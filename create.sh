#!/bin/sh

echo "Register mycert.cer file to Azure first."

azure account list

echo "Subscription ID: \c"
read subscription
echo "Password: \c"
read -s password

openssl aes-256-cbc -d -in mycert.cer.encrypted -out mycert.cer -pass pass:$password
openssl aes-256-cbc -d -in mycert.pem.encrypted -out mycert.pem -pass pass:$password
openssl aes-256-cbc -d -in mycert.pfx.encrypted -out mycert.pfx -pass pass:$password

docker-machine create -d azure \
--azure-subscription-id="$subscription" \
--azure-subscription-cert="mycert.pem" \
--azure-location="Japan West" \
xarsh-docker-machine-base

docker-machine env xarsh-docker-machine-base
