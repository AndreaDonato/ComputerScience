#!/bin/bash

# File PID per impedire esecuzioni multiple
PIDFILE="/tmp/latexsync.pid"

# Se esiste già un PID, manda un segnale e termina
if [ -e "$PIDFILE" ]; then
    old_pid=$(cat "$PIDFILE")
    kill -USR1 "$old_pid" 2>/dev/null
    echo "Sync già in esecuzione, notificato il processo $old_pid."
    exit 1
else
    # Salva il proprio PID e imposta primo_avvio
    echo $$ > "$PIDFILE"
    primo_avvio=1
fi

# Funzione di pulizia all'uscita
cleanup() {
    rm -f "$PIDFILE" "/tmp/LaTeXSync.pid"
}
trap cleanup EXIT

# Trap per gestire il segnale USR1
trap 'primo_avvio=1' USR1

while true; do
    if [ "$primo_avvio" -eq 1 ]; then
        primo_avvio=0
        scelta=$(zenity --list --title="LaTeXSync Settings" --column="Azione" "Start Synchronization" "Stop Synchronization")

        case "$scelta" in
            "Start Synchronization")
                if [ -e "/tmp/LaTeXSync.pid" ] ; then
                    zenity --warning --text="Sincronizzazione LaTeX già attiva."
                else
                	cd /home/shaytaan/Desktop/LaTeXSync || exit
                    ./LaTeXSync.sh & echo $! > "/tmp/LaTeXSync.pid"
                fi
                ;;
            "Stop Synchronization")
                pkill -9 LaTeXSync.sh
                zenity --warning --text="Sincronizzazione LaTeX interrotta!"
                exit 0
                ;;
        esac
    fi
    # Attende 1 secondo, sarà interrotto da un segnale USR1 se ricevuto? Mi pare di no...
    sleep 1
done
