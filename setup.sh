#!/usr/bin/env bash


__backup_config=./pihole/conf
__target_config=./pihole/vol/etc/pihole

echo
echo Removing previous stack && docker-compose down

echo Resetting addlist and custom dns mapping.
rm -rf ${__target_config}
mkdir ${__target_config}
cp ${__backup_config}/adlists.list.bak ${__target_config}/adlists.list
cp ${__backup_config}/custom.list.bak ${__target_config}/custom.list
cp ${__backup_config}/custom-blocklist.list.bak ${__target_config}/custom-blocklist.list
echo
echo Setting up new stack && docker-compose up -d --build
echo Running post setup code && docker-compose exec pihole /usr/bin/postsetup.sh

