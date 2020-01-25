#!/bin/bash

mkdir -p Targets
cd Targets
mkdir $1


amass enum -active -d $1 | tee /root/Haxor/Targets/$1/$1_amass.txt

subfinder -d $1 | tee /root/Haxor/Targets/$1/$1_subfinder.txt

#/root/tools/massdns/scripts/subbrute.py /root/tools/Lists/all.txt $1 | massdns -r /root/OS-setup/lists/resolvers.txt -t A -o S -w /root/tools/Targets/$1/$1_massdns.txt

gobuster dns -d $1 -t 100 -w /root/tools/Lists/all.txt

#strip=$(echo $1|sed 's/https\?:\/\///')
#host $strip
#masscan -p1-65535 $(dig +short $strip|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -1) --max-rate 1000 |& tee $strip_scan
