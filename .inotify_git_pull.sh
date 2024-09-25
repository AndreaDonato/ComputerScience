#!/bin/bash

# Monitorare la cartella per l'accesso (read) e eseguire git pull
inotifywait -m -e access /home/shaytaan/Desktop/int\ main/ComputerScience | while read -r directory events filename; do
    /home/shaytaan/Desktop/int\ main/ComputerScience/.git_pull.sh
done
