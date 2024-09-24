#!/bin/bash

git add .
git commit -m "Automatic Commit"
git push

if [ $? -ne 0 ]; then
    # Se il codice di uscita non è zero, c'è stato un errore
    echo "Errore durante il push al repository remoto. Si prega di controllare manualmente."
    # Qui puoi aprire una finestra con il messaggio di errore, ad esempio utilizzando Zenity
    zenity --error --text="Errore durante il push al repository remoto. Si prega di controllare manualmente."
fi
