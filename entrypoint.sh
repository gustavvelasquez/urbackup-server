#!/bin/bash
# Adapted from uroni/urbackup-server-docker:
# https://github.com/uroni/urbackup-server-docker
set -e

if [[ -n "$TMPDIR" ]]; then
    if [ -d "$TMPDIR" ]; then
        rm -f "$TMPDIR"/*
    fi
else
    for dir in /tmp /var/tmp; do
        if [ -d "$dir" ]; then
            rm -f "$dir"/*
        fi
    done
fi

cp -R /web-backup/* /usr/share/urbackup
echo "/backups" > /var/urbackup/backupfolder

if [[ -v ZFS_IMAGE ]]; then
    echo "$ZFS_IMAGE" > /etc/urbackup/dataset
fi
if [[ -v ZFS_FILES ]]; then
    echo "$ZFS_FILES" > /etc/urbackup/dataset_file
fi

if [[ $PUID != "" ]]; then
    usermod -u $PUID -o urbackup
else
    usermod -u 101 -o urbackup
fi
if [[ $PGID != "" ]]; then
    groupmod -g $PGID -o urbackup
else
    groupmod -g 101 -o urbackup
fi

su -s /bin/bash -c "test -w /backups" urbackup || chown urbackup:urbackup /backups
su -s /bin/bash -c "test -w /var/urbackup" urbackup || chown urbackup:urbackup /var/urbackup

exec urbackupsrv "$@"
