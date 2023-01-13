#!/usr/bin/env bash

if ! type jq
then
  echo "jq tool not installed, use apt, dnf or brew to install it"
  exit 1
fi

if [ ! -s instance_ips ]
then
  echo "No output. Apply deployement first."
  exit 42
fi

if (( $# < 1 ))
then
  echo "Usage: $0 ip_id"
  exit 1
fi

ip=$1

if [ ! $(cat instance_ips | grep $ip) ]
then
   echo "$ip: ip inconnue. Pick one in :"
   echo $(cat instance_ips)
   exit 2
fi

echo "Instance public ip:" ${ip}

#ssh -i ../ssh-keys/id_rsa_tfkeypair1 \
ssh -i ~/.ssh/id_rsa \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    root@${ip}
