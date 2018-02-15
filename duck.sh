#!/bin/bash

# duckdns.key must contain the token of duckdns and your domain (ex: acme if you have acme.duckdns)
duckdns_key=/etc/duckdns.key

# Just a couple of check if the file with the keys exist and it's not zero length 
if [[ -e $duckdns_key ]] && [[ -s $duckdns_key  ]] 
then 
    . $duckdns_key
else
    echo "The file $duckdns_key doesn't exits or it's empty, You have to write in there your domain and token"
    exit 1
fi

# Okey, the file exits and we've loaded, but you have write you keys? 

if [[ -z $token_duckdns ]] || [[ -z $duckdns_domain ]] 
then
    echo "You have to edit the file $duckdns_key and write your domain and token"
    exit 1
fi

# Apparently yes

check_my_ip=ip.hako.us
duckdns_url_update="https://www.duckdns.org/update?domains=$duckdns_domain&token=$token_duckdns&ip="

log_dir=/var/log
old_ip=$log_dir/ip_home
new_ip=$log_dir/ip_home.tmp
log_err=$log_dir/duck.err
log=$log_dir/duck.log

wget http://$check_my_ip -O $new_ip --timeout=60 --quiet > /dev/null 2>&1
ERR_WGET=$?

if [ $ERR_WGET -ne 0 ]
then
    ping -c 1 $check_my_ip > /dev/null 2>&1
    ERR_PING=$?
    echo "$(date) - Error code: $ERR_WGET - Ping Error Code: $ERR_PING" >> $log_err
    exit 1
fi

if [ -e $old_ip ]
then
   diff -q $old_ip $new_ip
   if [ $? -ne 0 ]
   then 
       echo url="$duckdns_url_update" | curl -s -k -o $log -K -
       (echo $(date): $(cat $new_ip); echo ""; geoiplookup $(cat /var/log/ip_home.tmp) ) | mailx -s "Home's IP Changed $(cat $new_ip) [duck]" matteo.marchelli@gmail.com
#       /usr/local/bin/newzen.sh -c warning -d "IP Cambiato: $(cat $new_ip)" > /dev/null 2>&1
   else
       exit 0
   fi
fi

mv $new_ip $old_ip
