#!/bin/bash

# --- 变量定义 ---
# 使用北京时间 (UTC+8)
# 定义详细的更新时间变量，用于显示
time=$(echo "$(TZ=UTC-8 date +'%Y-%m-%d %H:%M:%S')（北京时间）")
# 定义版本号变量，格式为 YYYYMMDDHHMMSS
version=$(TZ=UTC-8 date +'%Y%m%d%H%M%S') # <--- 新增行：定义版本号变量

# --- 生成 dnslist.txt ---
# 1. 计算dns规则总数
dnstotal=$(cat jiekouAD.txt | grep -E "^(\|\|)[^\/\^]+\^$" | wc -l)
# 2. 写入文件头，包含版本号和更新时间
echo -e "[Adblock Plus 2.0]\n! Title: 几十KB的轻量规则\n! Homepage: https://github.com/damengzhu/banad\n! by: 酷安@大萌主\n! Version: $version\n! Total Count: $dnstotal\n! Update Time: $time" >dnslist.txt # <--- 修改行：在dnslist.txt的头部增加版本号
# 3. 写入dns规则内容
cat jiekouAD.txt | grep -E "^(\|\|)[^\/\^]+\^$" | sort -u >>dnslist.txt

# --- 生成 hosts.txt ---
# 1. 备份并提取hosts.txt中的保留区域
sed -n '/^#Reserved area start/,/^#Reserved area end/p' hosts.txt >reservedHost.txt
# 2. 写入文件头，包含版本号和更新时间
echo -e "# Title: 几十KB的轻量规则\n# Homepage: https://github.com/damengzhu/banad\n# by: 酷安@大萌主\n# Version: $version\n# Total Count: HOSTCOUNT\n# Update Time: $time\n127.0.0.1 localhost\n::1 localhost" >hosts.txt # <--- 修改行：在hosts.txt的头部增加版本号
# 3. 从dnslist转换并写入hosts规则
cat dnslist.txt | grep -Ev "\!|\[|\*" | sed -e 's/||/0.0.0.0 /g' -e "s/\^//g" | sort -u >>hosts.txt
# 4. 追加回保留区域并删除临时文件
cat reservedHost.txt >>hosts.txt && rm -f reservedHost.txt
# 5. 回填hosts规则总数
hosttotal=$(cat hosts.txt | grep -E "^0\.0\.0\.0" | wc -l)
sed -i "s/HOSTCOUNT/$hosttotal/" hosts.txt

# --- 更新源文件 jiekouAD.txt ---
# 1. 更新源文件中的版本号
sed -i "s/! Version:.*/! Version: $version/g" jiekouAD.txt 
# 2. 更新源文件中的更新时间
sed -i "s/! Update Time:.*/! Update Time: $time/g" jiekouAD.txt
# 3. 更新源文件中的总行数
total=$(cat jiekouAD.txt | grep -v "^!" | wc -l)
sed -i "s/! Total Count:.*/! Total Count: $total/g" jiekouAD.txt

exit 0
