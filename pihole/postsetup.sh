#!/usr/bin/env bash

__touch_file=/etc/pihole/post_setup_complete
echo
echo Attempting to update blocklist
echo
if [[ ! -f ${__touch_file} ]]
then
    __domains=$( cat /etc/pihole/custom-blocklist.list | xargs )
    while ! pihole --wild ${__domains} ;
        do 
        echo Waiting for pihole to come up
    done
    touch ${__touch_file}
else
    echo Post setup step already completed. Skipping . . . 
fi

