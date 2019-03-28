#!/bin/bash
Usage=$(uptime | cut -d "," -f4 | sed -e "s/\.//g")
Threshold=1
while [ 1 ]
do
if [ $Usage -gt $Threshold ]
then
 echo "Usage is : $Usage"
 echo "Threshold is : $Threshold"
 echo "Top Process"
 echo "PID     %CPU     COMMAND"
 echo "$(ps -eo pid -eo pcpu -eo cmd | sort -k 2 -rn | head -n 1)"
 echo
 echo "usage greater than threshold"
 echo "kill the above process Y or N"
 read opt
 if [ $opt = Y ]
 then
  sudo kill -9 $(ps -eo pid -eo pcpu | grep -v %CPU | sort -k 2 -rn | head -n 1 | cut -d " " -f2)
 fi
fi
sleep 60
done
