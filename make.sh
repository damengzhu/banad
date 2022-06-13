#!/bin/bash
time=`echo "$(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间） " `
total=`cat jiekouAD.txt|grep -E "^(\|\|)[^\/\^]+\^$"|wc -l`
echo -e "[Adblock Plus 2.0]\n! Title: 瞎弄的广告过滤规则\n! Homepage: https://github.com/damengzhu/banad\n! by: 酷安@大萌主\n! Total Count:$total\n! Update Time:$time" >dnslist.txt
echo -e "#Title: 瞎弄的广告过滤规则\n#Homepage: https://github.com/damengzhu/banad\n#by: 酷安@大萌主\n#Total Count:$total\n#Update Time: $time\n127.0.0.1 localhost\n::1 localhost" > hosts.txt
cat jiekouAD.txt|grep -E "^(\|\|)[^\/\^]+\^$" |sort |uniq>> dnslist.txt
cat dnslist.txt |grep -Ev "!|\["|sed 's/||/0.0.0.0 /g' | sed "s/\^//g"|sort |uniq >> hosts.txt
sed -i "s/! Update Time:.*/! Update Time: $time/g" jiekouAD.txt
total=`cat jiekouAD.txt|grep -v "!"|wc -l`
sed -i "s/! Total Count:.*/! Total Count: $total/g" jiekouAD.txt
