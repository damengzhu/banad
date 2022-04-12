#curl -X POST https://api.github.com/repos/cats-team/AdRules/dispatches \ 临时移除
curl -X POST https://api.github.com/repos/hacamer/AdRules/dispatches \
-H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GITHUBTOKEN" \
    --data '{"event_type": "Manual-Update-For-大萌主"}'
echo Pass
