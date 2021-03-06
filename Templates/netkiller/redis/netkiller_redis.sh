#!/bin/bash
ipaddr=$1
db=$2
if [ -z $db ]; then
#(echo -en "info\r\nquit\r\n"; sleep 0.5) | nc ${ipaddr} 6379 | tail -n +2 | head -n -2 | tr "\r\n" " " | grep connected_clients
(echo -en "info\r\nquit\r\n"; sleep 0.5) | nc ${ipaddr} 6379 | egrep "(connected_clients|total_connections_received|total_commands_processed|keyspace_hits|keyspace_misses|used_memory:)" | tr -s '\r\n' ' ' | sed 's/[ ]*$/\n/g'
else
	(echo -en "info\r\nquit\r\n"; sleep 0.5) | nc ${ipaddr} 6379 | grep "$db:" | cut -d ':' -f2 | sed -e "s/,/ /g" -e "s/=/:/g"
fi
