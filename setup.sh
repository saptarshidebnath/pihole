#!/usr/bin/env bash


__backup_config=./pihole/conf
__pihole_vol=./pihole/vol
__target_config=${__pihole_vol}/etc/pihole


VAR="$1"

case $VAR in

  "-r")
    echo
    echo Removing previous stack && docker-compose down -v --rmi all --remove-orphans 
    echo Resetting addlist and custom dns mapping.
    sudo rm -rf ${__pihole_vol}
    mkdir -p ${__target_config}
    cp ${__backup_config}/adlists.list.bak ${__target_config}/adlists.list
    cp ${__backup_config}/custom.list.bak ${__target_config}/custom.list
    cp ${__backup_config}/custom-blocklist.list.bak ${__target_config}/custom-blocklist.list
    ;;

  *)
    echo '(Re)Starting containers'
    ;;
esac

echo
echo Setting up stack && docker-compose up -d --build
echo "Waiting for 30s to update blacklist" && sleep 30
echo Running post setup code && docker-compose exec pihole /usr/bin/postsetup.sh

#docker-compose logs --follow
