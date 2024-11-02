#!/bin/bash

# File PID per impedire esecuzioni multiple
PIDFILE="/tmp/sync.pid"

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
    rm -f "$PIDFILE" "/tmp/push.pid" "/tmp/pull.pid"
}
trap cleanup EXIT

# Trap per gestire il segnale USR1
trap 'primo_avvio=1' USR1

while true; do
    if [ "$primo_avvio" -eq 1 ]; then
        primo_avvio=0
        scelta=$(zenity --list --title="Sync Settings" --column="Azione" "Start Synchronization" "Stop Synchronization")

        case "$scelta" in
            "Start Synchronization")
                if [ -e "/tmp/push.pid" ] || [ -e "/tmp/pull.pid" ]; then
                    zenity --warning --text="Sincronizzazione già attiva."
                else
                	cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit
                    ./.pull_daemon.sh & echo $! > "/tmp/pull.pid"
                    ./.push_daemon.sh & echo $! > "/tmp/push.pid"
                fi
                ;;
            "Stop Synchronization")
                [ -e "/tmp/push.pid" ] && kill -SIGKILL $(cat "/tmp/push.pid") && rm -f "/tmp/push.pid"
                [ -e "/tmp/pull.pid" ] && kill -SIGKILL $(cat "/tmp/pull.pid") && rm -f "/tmp/pull.pid"
                pkill -f pull_daemon.sh
                pkill -9 push_daemon.sh
                zenity --warning --text="Sincronizzazione interrotta!"
                exit 0
                ;;
        esac
    fi
    # Attende 1 secondo, sarà interrotto da un segnale USR1 se ricevuto? Mi pare di no...
    sleep 1
done
