#!/usr/bin/bash
SERVER=example.org
USER=backupuser
DB_PWD=dbpassword

NOW=$(date +"%m%d%Y_%H%M%S")

ssh $USER@$SERVER "cat | bash /dev/stdin $DB_PWD /tmp/backup.$NOW /tmp/backup.$NOW.tgz" < local_script.sh
scp $USER@$SERVER:/tmp/backup.$NOW.tgz .
