#!bin/bash

freemem=$(free -m | grep Mem | awk '{print $2}')
usedmem=$(free -m | grep Mem | awk '{print $3}')
mem=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
freedisk=$(df -h --block-size=G --total | tail -n 1 | awk '{print $2}' | cut -d G -f1)
useddisk=$(df -h --block-size=G --total | tail -n 1 | awk '{print $3}' | cut -d G -f1)
disk=$(df -h --block-size=G --total | tail -n 1 | awk '{print $5}' | cut -d % -f1)
cpu1=$(mpstat | tail -n 1 | awk '{print $4}')
cpu2=$(mpstat | tail -n 1 | awk '{print $6}')
cpu3=$(echo "$cpu1 + $cpu2" | bc)

wall "
#Architecture    :$(uname -a)
#CPU physical    :$(grep "physical id" /proc/cpuinfo | wc -l)
#vCPU            :$(grep "^processor" /proc/cpuinfo | wc -l)
#Memory Usage    :$usedmem/${freemem}MB ($mem%)
#Disk Usage      :$useddisk/${freedisk}GB (${disk}%)
#CPU LOAD        :$cpu3%
#Last Boot       :$(who -b | awk '$1 == "system" {print $3 " " $4}')
#LVM Usage       :$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
#Connections TCP :$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
#User Log        :$(users | wc -w)
#Network         :$(hostname -I) ($(ip link show | awk '$1 == "link/ether" {print $2}'))
#SUDO            :$(journalctl _COMM=sudo | grep COMMAND | wc -l)
"
