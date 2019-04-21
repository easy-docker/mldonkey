#!/bin/sh
mkdir -p /incoming/files
mkdir -p /incoming/directories
if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "set temp_directory /temp"
    #启用网络
    /usr/lib/mldonkey/mldonkey_command -p '' "set enable_kademlia true" "set enable_overnet true"
    #上传下载速度不限制
    /usr/lib/mldonkey/mldonkey_command -p '' "set max_hard_download_rate 0" "set max_hard_upload_rate 0"
    #修改服务器来源
    /usr/lib/mldonkey/mldonkey_command -p '' "set ED2K-update_server_list_client true" "set ED2K-update_server_list_server true" "set ED2K-update_server_list_server_met true"
    #增加下载共享目录
    /usr/lib/mldonkey/mldonkey_command -p '' "share 0 /incoming/files incoming_files" "share 0 /incoming/directories incoming_directories"
    #删除自带下载共享目录
    /usr/lib/mldonkey/mldonkey_command -p '' "unshare incoming/files" "unshare incoming/directories"
    #使共享生效
    /usr/lib/mldonkey/mldonkey_command -p '' "reshare"
    #保存配置到配置文件
    /usr/lib/mldonkey/mldonkey_command -p '' "save"
    if [ -z "$MLDONKEY_ADMIN_PASSWORD" ]; then
        /usr/lib/mldonkey/mldonkey_command -p "" "kill"
    else
        /usr/lib/mldonkey/mldonkey_command -p "" "useradd admin $MLDONKEY_ADMIN_PASSWORD"
        /usr/lib/mldonkey/mldonkey_command -u admin -p "$MLDONKEY_ADMIN_PASSWORD" "kill"
    fi
fi

mldonkey 
