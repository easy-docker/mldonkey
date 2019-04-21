#!/bin/sh
mkdir -p /incoming/files
mkdir -p /incoming/directories
if [ ! -f /var/lib/mldonkey/downloads.ini ]; then
    mldonkey &
    echo "Waiting for mldonkey to start..."
    sleep 5
    /usr/lib/mldonkey/mldonkey_command -p "" "set allowed_ips 0.0.0.0/0" "set temp_directory /temp"
    /usr/lib/mldonkey/mldonkey_command -p '' "share 0 /incoming/files incoming_files" "share 0 /incoming/directories incoming_directories"
    /usr/lib/mldonkey/mldonkey_command -p '' "unshare incoming/files" "unshare incoming/directories"
    /usr/lib/mldonkey/mldonkey_command -p '' "reshare"
    /usr/lib/mldonkey/mldonkey_command -p '' "save"
    if [ -z "$MLDONKEY_ADMIN_PASSWORD" ]; then
        /usr/lib/mldonkey/mldonkey_command -p "" "kill"
    else
        /usr/lib/mldonkey/mldonkey_command -p "" "useradd admin $MLDONKEY_ADMIN_PASSWORD"
        /usr/lib/mldonkey/mldonkey_command -u admin -p "$MLDONKEY_ADMIN_PASSWORD" "kill"
    fi
fi

mldonkey 
