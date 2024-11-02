#!/bin/bash

# Variabili principali
MAIN_DIR="/home/shaytaan/Desktop/int main/ComputerScience"
UPDATED_MARKS="$HOME/.config/LaTeXSync/updated_latex_files.txt"
MODIFICATION_TRACKER="$HOME/.config/LaTeXSync/last_modification_times.txt"

# Crea la cartella di configurazione, se non esiste
mkdir -p "$(dirname "$UPDATED_MARKS")"
touch "$UPDATED_MARKS" "$MODIFICATION_TRACKER"

# Funzione per sincronizzare i file LaTeX.md
sync_files() {
    local changed_file="$1"
    echo "Syncing changes from $changed_file"

    # Aggiorna i file e registra il timestamp
    local current_time=$(date +%s)

    # Crea un array per tracciare i file aggiornati
    local updated_files=()

    find "$MAIN_DIR" -type f -name "LaTeX.md" | while read -r target_file; do
        if [[ "$target_file" != "$changed_file" ]]; then
            # Copia solo se il target è più vecchio del file cambiato
            cp "$changed_file" "$target_file"
            echo "Updated $target_file"
            updated_files+=("$target_file")  # Aggiungi il file aggiornato all'array
        fi
    done

    # Aggiungi i file aggiornati a UPDATED_MARKS se non sono già presenti
    for updated_file in "${updated_files[@]}"; do
        if ! grep -Fxq "$updated_file" "$UPDATED_MARKS"; then
            echo "$updated_file" >> "$UPDATED_MARKS"
        fi
    done

    # Assicurati che il MODIFICATION_TRACKER abbia lo stesso numero di righe di UPDATED_MARKS
    > "$MODIFICATION_TRACKER"  # Pulisci il file MODIFICATION_TRACKER

    while read -r line; do
        # Per ogni file in UPDATED_MARKS, scrivi una riga in MODIFICATION_TRACKER
        echo "$current_time $line" >> "$MODIFICATION_TRACKER"
    done < "$UPDATED_MARKS"
}



# Funzione che controlla se il cambiamento è stato appena sincronizzato
is_recent_sync() {
    local file="$1"
    local last_modified=$(date +%s -r "$file")

    # Controlla il file tracker per l'ultimo timestamp di sincronizzazione
    if grep -q "$file" "$MODIFICATION_TRACKER"; then
        local last_sync_time=$(grep "$file" "$MODIFICATION_TRACKER" | tail -n1 | cut -d' ' -f1)
        # Se la modifica è avvenuta meno di 2 secondi fa, considerala già sincronizzata
        if (( last_modified <= last_sync_time + 2 )); then
            return 0  # Già sincronizzato
        fi
    fi
    return 1  # Non ancora sincronizzato
}


# Funzione principale che monitora i cambiamenti
monitor_changes() {
    # Avvia inotifywait in modalità ricorsiva
    inotifywait -m -r -e modify,delete --format "%e %w%f" "$MAIN_DIR" | while read -r event changed_file; do

        
        ### MODIFICA DEL FILE LaTeX.md ###
        
        if [[ "$event" == "MODIFY" && $(basename "$changed_file") == "LaTeX.md" ]]; then

            # Sincronizza solo se il file è aggiornato
            if grep -Fxq "$changed_file" "$UPDATED_MARKS"; then
                # Sincronizza solo se il file non è stato sincronizzato di recente
                if ! is_recent_sync "$changed_file"; then
                    sync_files "$changed_file"
                fi
            else
                zenity --warning --text="Stai modificando un file che verrà sovrascritto.\nModifica un qualsiasi file che compare in\n\n$UPDATED_MARKS"
            fi

        ### CANCELLAZIONE DEL FILE LaTeX.md ###

        elif [[ "$event" == "MODIFY" ]]; then
            file_check="$(dirname "$(dirname "$changed_file")")/LaTeX.md"
            #echo "$file_check"

            if grep -Fxq "$file_check" "$UPDATED_MARKS" && [ ! -e "$file_check" ]; then
                notify-send "LaTeXSync" "Deleted LaTeX.md"
                # Rimuove la stringa dal file UPDATED_MARKS
                sed -i "\|$file_check|d" "$UPDATED_MARKS"
                echo "$file_check rimosso da $UPDATED_MARKS perché non esiste più."
            fi
        fi

    done
}

# Avvia la funzione principale
monitor_changes
