#!/bin/bash

cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit



# inotifywait ha la brutta abitudine di creare copie dello script che lo lancia, quindi implemento un controllo per evitare processi duplicati
PIDFILE="/tmp/push.pid"

# Se esiste già un PID termina
if [ -e "$PIDFILE" ]; then
    exit 1
else
    # Salva il proprio PID
    echo $$ > "$PIDFILE"
fi



# Inizializza la variabile per tenere traccia dell'ultimo esecuzione
last_run=0

inotifywait -m -r -e modify,close_write,create,delete /home/shaytaan/Desktop/int\ main/ComputerScience | while read -r directory events filename; do

    current_time=$(date +%s)  # Ottieni il tempo attuale in secondi dall'epoca
    # Controlla se sono trascorsi 600 secondi (10 minuti) dall'ultima esecuzione
    if (( current_time - last_run >= 600 )); then
        sleep 30
        ./.fast_push.sh
        last_run=$current_time  # Aggiorna il tempo dell'ultima esecuzione
    fi
done