#!/bin/bash

cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit

# inotifywait ha la brutta abitudine di creare copie dello script che lo lancia, quindi implemento un controllo per evitare processi duplicati
PIDFILE="/tmp/push.pid"


if [ -f $PIDFILE ]; then
    read -r stored_pid < "$PIDFILE"
else
    echo "Il file $PIDFILE non esiste."
    exit 1
fi

# Ottieni il PID del processo corrente
current_pid=$$

# Controlla se il PID memorizzato è diverso dal PID corrente
if [ "$stored_pid" -ne "$current_pid" ]; then
    echo "Il PID nel file è diverso dal PID corrente. Uscita..."
    exit 1
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