#!/bin/bash

cd /home/shaytaan/Desktop/Workspace/

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

./.pull_daemon.sh & echo $! > "/tmp/pull.pid"
./.push_daemon.sh & echo $! > "/tmp/push.pid"

echo "cronjob executed"