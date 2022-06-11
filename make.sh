#!/bin/bash
total=`cat jiekouAD.txt|grep -E "^(\|\|)[^\/\^]+\^$"|wc -l`
echo -e "[Adblock Plus 2.0]\n! Title: 瞎弄的广告过滤规则\n! Homepage: https://github.com/damengzhu/banad\n! by: 酷安@大萌主\n! Total Count:$total" >dnslist.txt
echo -e "#Title: 瞎弄的广告过滤规则\n#Homepage: https://github.com/damengzhu/banad\n#by: 酷安@大萌主\n#Total Count:$total\n127.0.0.1 localhost\n::1 localhost" > hosts.txt
cat jiekouAD.txt|grep -E "^(\|\|)[^\/\^]+\^$" |sort |uniq>> dnslist.txt
cat dnslist.txt |grep -Ev "!|\["|sed 's/||/0.0.0.0 /g' | sed "s/\^//g"|sort |uniq >> hosts.txt
