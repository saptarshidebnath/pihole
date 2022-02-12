# pihole

#How to setup static IP
## Step 1 : Enable static IP for raspberypi using dhcpcd.conf
Add the following content to /etc/dhcpcd.conf to set the static ip 192.168.1.11. The router's and domain name server (dns) is very important and should be collected from the system before proceeding.
```
interface wlan0
static ip_address=192.168.1.11/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1 8.8.8.8 fd51:42f8:caae:d92e::1
```

## Step 2 : Add static IP alias for raspberypi using dhcpcd
Add the below content to /etc/dhcpcd.enter-hook. It sets the static IP to 192.168.1.10. The current one overrides wlan0 which is the WIFI. it can also eth0 which is the lan port. The interface need to something that the system reocgnizes as a valid network interface
Inspired by https://www.rigacci.org/wiki/doku.php/doc/appunti/linux/sa/dhcpcd_ip_alias
```
# File /etc/dhcpcd.enter-hook
# Assign an IP alias to the eth0 interface.
if [ "$interface" = "wlan0" ]; then
    case $reason in
        PREINIT)
            /usr/sbin/ip addr add 192.168.1.10 dev "${interface}" label "${interface}":0 || true
            ;;
    esac
fi
```
