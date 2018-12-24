#!/bin/bash
source $root/config/config.sh

##
#@brief: 验证用户是否可以使用
#@retval: 成功返回true
##
function auth() {
    rst=`curl $curl_opts -X GET $cl_api_host/zones/$cl_zone_id \
        -H  "Content-Type:$content_type" \
        -H  "X-Auth-Key:$cl_auth_key" \
        -H "X-Auth-Email:$cl_auth_email" \
        `
    echo $rst | jq -r ".success"
} 
##
#@brief: 清除指定URL的HTTP缓存
#@retval: 成功返回trues
##
function purgecache() {
    url=${1:-""}
    rst=`curl $curl_opts -X POST $cl_api_host/zones/$cl_zone_id/purge_cache \
        -H "X-Auth-Email: $cl_auth_email" \
        -H "X-Auth-Key: $cl_auth_key" \
        -H "Content-Type: $content_type" \
        --data '
            {
                "files": [
                    "'"$url"'"
                ]
            }'
        `
    echo $rst | jq -r ".success"
}
