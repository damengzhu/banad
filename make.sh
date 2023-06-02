#!/bin/bash
time=$(echo "$(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间）")
dnstotal=$(cat jiekouAD.txt | grep -E "^(\|\|)[^\/\^]+\^$" | wc -l)
echo -e "[Adblock Plus 2.0]\n! Title: 几十KB的轻量规则\n! Homepage: https://github.com/damengzhu/banad\n! by: 酷安@大萌主\n! Total Count: $dnstotal\n! Update Time:$time" >dnslist.txt
cat jiekouAD.txt | grep -E "^(\|\|)[^\/\^]+\^$" | sort -u >>dnslist.txt
sed -n '/^#Reserved area start/,/^#Reserved area end/p' hosts.txt >reservedHost.txt
echo -e "#Title: 几十KB的轻量规则\n#Homepage: https://github.com/damengzhu/banad\n#by: 酷安@大萌主\n#Total Count: HOSTCOUNT\n#Update Time: $time\n127.0.0.1 localhost\n::1 localhost" >hosts.txt
cat dnslist.txt | grep -Ev "\!|\[|\*" | sed -e 's/||/0.0.0.0 /g' -e "s/\^//g" | sort -u >>hosts.txt
cat reservedHost.txt >>hosts.txt && rm -f reservedHost.txt
hosttotal=$(cat hosts.txt | grep -E "^0\.0\.0\.0" | wc -l)
sed -i "s/HOSTCOUNT/$hosttotal/" hosts.txt
sed -i "s/! Update Time:.*/! Update Time: $time/g" jiekouAD.txt
total=$(cat jiekouAD.txt | grep -v "^!" | wc -l)
sed -i "s/! Total Count:.*/! Total Count: $total/g" jiekouAD.txt
exit 0
