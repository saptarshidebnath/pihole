ARG PIHOLE_VERSION

FROM "pihole/pihole:${PIHOLE_VERSION}"
COPY postsetup.sh /usr/bin/postsetup.sh
RUN chmod +x /usr/bin/postsetup.sh
COPY cachescript.sh /etc/cron.hourly/cachescript
RUN chmod +x /etc/cron.hourly/cachescript
