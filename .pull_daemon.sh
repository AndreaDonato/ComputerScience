#!/bin/bash

export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit
notify-send "git pull daemon" "GIT PULL DEAMON"
echo "ciao"
# Inizializza la variabile per tenere traccia dell'ultimo esecuzione
last_run=0

while true; do
    current_time=$(date +%s)  # Ottieni il tempo attuale in secondi dall'epoca
    # Controlla se sono trascorsi 600 secondi (10 minuti) dall'ultima esecuzione
    if (( current_time - last_run >= 300 )); then
        ./.git_pull.sh
        last_run=$current_time  # Aggiorna il tempo dell'ultima esecuzione
    fi
done
