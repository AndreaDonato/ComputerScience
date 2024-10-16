#!/bin/bash

# Inizializza la variabile per tenere traccia dell'ultimo esecuzione
last_run=0

inotifywait -m -r -e modify,close_write,create,delete /home/shaytaan/Desktop/int\ main/ComputerScience | while read -r directory events filename; do
    current_time=$(date +%s)  # Ottieni il tempo attuale in secondi dall'epoca
    # Controlla se sono trascorsi 600 secondi (10 minuti) dall'ultima esecuzione
    if (( current_time - last_run >= 600 )); then
        /home/shaytaan/Desktop/int\ main/ComputerScience/.fast_push.sh
        last_run=$current_time  # Aggiorna il tempo dell'ultima esecuzione
    fi
done
