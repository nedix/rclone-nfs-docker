#!/usr/bin/env sh

mkdir -p \
    /etc/rclone \
    /mnt/rclone \
    /run/openrc

cat << EOF > /etc/rclone/.env
S3_NFS_BUCKET="$S3_NFS_BUCKET"
EOF

cat << EOF > /etc/rclone/rclone.conf
[default]
type = s3
provider = Other
access_key_id = $S3_NFS_ACCESS_KEY_ID
secret_access_key = $S3_NFS_SECRET_ACCESS_KEY
endpoint = $S3_NFS_ENDPOINT
EOF

rc-update add nfs
rc-update add rclone
rc-update add timestamp_updater

touch /run/openrc/softlevel

sed -i 's/^tty/#&/' /etc/inittab

exec /sbin/init
