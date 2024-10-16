#!/bin/bash

cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit
git add .
git commit -m "Automatic Commit"
git push


########################
### per usare zenity ###
########################

export DISPLAY=:1
# Consenti a root di accedere al display
sudo -u shaytaan xhost +local:root
# Consenti a shaytaan di vedere le notifiche di zenity
xhost +local:shaytaan



##############################
### per gestire gli errori ###
##############################

if [ $? -ne 0 ]; then
    # Se il codice di uscita non è zero, c'è stato un errore
    echo "Errore durante il push al repository remoto. Si prega di controllare manualmente."
    # Qui puoi aprire una finestra con il messaggio di errore, ad esempio utilizzando Zenity
    zenity --error --text="Errore durante il push al repository remoto. Si prega di controllare manualmente."

    # Visto che bash è un po' limitato, per aspettare un terminale aperto tramite gnome-terminal bisogna fare così:
    pid_file="/tmp/git_push_terminal.pid"               # Creo un file temporaneo in cui salvare il pid del nuovo terminale

    # Eseguo un terminale che stampa il suo stesso PID sul file di cui sopra, poi fa quello che deve fare
    gnome-terminal -- bash -c "echo \$\$ > '$pid_file'; cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit; git push; exec bash" &
    sleep 1                                             # Gli serve un momento per fare tutta sta roba, il processore c'ha da fa
    if [ -f "$pid_file" ]; then                         # Se il file temporaneo esiste
        terminal_pid=$(<"$pid_file")                    # Leggi il PID dal file

        # La syscall wait non funziona se il processo da aspettare non è direttamente tuo figlio, quindi...
        while true; do
            if ! ps -p $terminal_pid > /dev/null; then
                break  # Esci dal ciclo se il terminale è chiuso
            fi
            sleep 1  # Aspetta 1 secondo prima di controllare di nuovo
    done
    rm -f "$pid_file"                                   # Rimuovi il file temporaneo
    else
        echo "Impossibile trovare il file $pid_file."   # Non si sa mai
    fi

    scelta=$(zenity --question --text="Se il problema non è stato risolto, puoi fermare i push automatici fino al prossimo riavvio" --ok-label="Ferma i push automatici" --cancel-label="Problema risolto!")

    if [ $? -eq 0 ]; then
        pkexec bash -c 'systemctl stop CS-git-push-inotify.service'
        if [[ $? -ne 0 ]]; then
            zenity --notification --text="Non è stato possibile interrompere il pull automatico."
        else
            zenity --notification --text="Servizi di pull automatico disabilitati fino al riavvio\nPer riavviarli adesso, systemctl start ..."
        fi
        exit 1
    fi

else
    zenity --notification --text="git push daemon correctly executed"

fi