#!/usr/bin/env bash
#
# Automated the script where all the domains that are beiing queried are prempetively being cached
#
export PATH=$PATH:/usr/bin:/bin:/usr/sbin
__touch_file=/etc/pihole/ongoing_caching
__db_file=/etc/pihole/domains_to_cache
__temp_file=$( mktemp )
__file_to_check=/var/log/pihole.log*

if [[ -f "${__touch_file}" ]]; then
    echo "${__touch_file}" exist. Currently caching going on. Skipping the caching now
    exit 1
fi

echo "$( date )" > "${__touch_file}"

grep query ${__file_to_check} | cut -d' ' -f7 >> "${__db_file}"
sort "${__db_file}" | uniq > "${__temp_file}"
cp "${__temp_file}" "${__db_file}"

while read domain_name; do
  echo "Checking ${domain_name}" & dig "${domain_name}" @127.0.0.1 ANY & sleep 1
done <"${__db_file}"

rm "${__touch_file}"
rm "${__temp_file}"
logger "PIHOLE_CACHE_REFRESH :: Refreshed Cache at :: $( date )"
exit 0
