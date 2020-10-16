#!/bin/bash

function install {
  sudo apt-get update
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable"
  apt-get install -y docker-ce docker-compose
  sudo usermod -aG docker vagrant
}

function main {
  local manager_token="/vagrant/mgr.token"
  local worker_token="/vagrant/wrk.token"

  install

  if [[ $HOSTNAME == "manager" ]]
  then
    docker swarm init --advertise-addr=172.28.128.10
    docker swarm join-token manager -q > ${manager_token}
    docker swarm join-token worker -q > ${worker_token}
  fi

  for id in {1..2}
  do
    if [[ $HOSTNAME == node${id} ]]
    then
      docker swarm join --token $(cat ${worker_token}) --advertise-addr=172.28.128.1${id} 172.28.128.10
    fi
  done

}

main