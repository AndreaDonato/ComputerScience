#!/bin/bash

cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit


########################
### per usare zenity ###
########################

export DISPLAY=:1
# Consenti a root di accedere al display
sudo -u shaytaan xhost +local:root
# Consenti a shaytaan di vedere le notifiche di zenity
xhost +local:shaytaan

#export DBUS_SESSION_BUS_ADDRESS=$(sudo -u shaytaan bash -c 'echo $DBUS_SESSION_BUS_ADDRESS')
#export XDG_RUNTIME_DIR=$(sudo -u shaytaan bash -c 'echo $XDG_RUNTIME_DIR')

export $(sudo -u shaytaan dbus-launch --sh-syntax)

git pull


##############################
### per gestire gli errori ###
##############################

if [ $? -ne 0 ]; then
    # Se c'è stato un errore, mostra una finestra con zenity con tre opzioni
    echo "Qua dovrebbe aprirsi una finestra zenity"
    scelta=$(zenity --list --title="Errore" \
        --text="Si è verificato un errore con il pull automatico, che succede?" \
        --column="Opzioni" "Riprova un pull automatico" "Apri un terminale per visualizzare l'errore" "Ignora l'errore" "Ferma il pull automatico fino al prossimo riavvio" --height=250 --width=300)

    case $scelta in
        "Riprova un pull automatico")
            echo "Riprovo il pull..."
            ./.git_pull.sh
            ;;
        "Apri un terminale per visualizzare l'errore")

			# Visto che bash è un po' limitato, per aspettare un terminale aperto tramite gnome-terminal bisogna fare così:
			pid_file="/tmp/git_pull_terminal.pid"				# Creo un file temporaneo in cui salvare il pid del nuovo terminale

			# Eseguo un terminale che stampa il suo stesso PID sul file di cui sopra, poi fa quello che deve fare
			gnome-terminal -- bash -c "echo \$\$ > '$pid_file'; cd /home/shaytaan/Desktop/int\ main/ComputerScience/ || exit; git pull; exec bash" &
			sleep 1 											# Gli serve un momento per fare tutta sta roba, il processore c'ha da fa
			if [ -f "$pid_file" ]; then							# Se il file temporaneo esiste
    			terminal_pid=$(<"$pid_file")       				# Leggi il PID dal file

    			# La syscall wait non funziona se il processo da aspettare non è direttamente tuo figlio, quindi...
				while true; do
    				if ! ps -p $terminal_pid > /dev/null; then
        				break  # Esci dal ciclo se il terminale è chiuso
    				fi
    				sleep 1  # Aspetta 1 secondo prima di controllare di nuovo
			done

			rm -f "$pid_file"									# Rimuovi il file temporaneo
			else
    			echo "Impossibile trovare il file $pid_file."	# Non si sa mai
			fi
			;;
        "Ignora l'errore")
            echo "Ignoro l'errore e proseguo..."
            ;;
        "Ferma il pull automatico fino al prossimo riavvio")
      	  	pkexec bash -c 'systemctl stop CS-git-pull.timer && systemctl stop CS-git-pull-inotify.service'
      	  	if [[ $? -ne 0 ]]; then
            	notify-send "git pull daemon" "Non è stato possibile interrompere il pull automatico."
            else
                notify-send "git pull daemon" "Servizi di pull automatico disabilitati fino al riavvio\nPer riavviarli adesso, systemctl start ..."
      	  	fi
            exit 1
            ;;
        *)
            notify-send "git pull daemon" "Questa scelta equivale a selezionare 'Ignora l'errore'\nNon ignorare i menù a tendina per favore"
            exit 1
            ;;
    esac

else
    echo "Segue notifica zenity"
    notify-send "git pull daemon" "no errors during git pull daemon execution"
fi