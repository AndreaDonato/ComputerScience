
L'idea di realizzare un sistema di ***cash digitale*** affonda le sue radici verso la seconda metà degli anni 80. Se le prime implementazioni si riducevano a tentativi di implementare modi sicuri per eseguire le transazioni, è con DigiCash (1989) che compaiono i primi coin.

Le moderne criptovalute si basano sulle ***blockchain***: ogni transazione viene inviata ad un server del sistema distribuito, il quale la inoltra agli altri. Dall'insieme delle transazioni in attesa (***mempool***) condiviso (idealmente) da tutti i server viene estratto mediante delle logiche variabili un sottoinsieme (che prende il nome di ***blocco***) da aggiungere alla blockchain. Un singolo server guadagna volta per volta il diritto di farsi portavoce di un blocco (e di ottenere di conseguenza un ***reward***) principalmente in due modi (ne esistono $N$, ovviamente):

- Risolvendo un ***computational puzzle***, se la Blockchain stabilisce un meccanismo di consenso di tipo ***Proof-of-Work*** (***PoW***). In questo caso, i server vengono chiamati ***miner***;
- "Bloccando" una certa quantità di criptovaluta, se si applica un meccanismo ***Proof-of-Stake*** (***PoS***). I server possono avere nomi (i.e. ruoli) variabili a seconda del protocollo.

Deve essere semplice per gli altri server verificare che colui che propone il blocco sia legittimato a farlo (i.e. raggiungere il ***consenso*** su quel server). 

La sequenza dei blocchi approvati costituisce il "libro mastro" (***ledger***) delle transazioni.

Esistono ledger la cui implementazione non è una Blockchain (e.g. IOTA).

# Creare Cash Digitale

Pochi accetterebbero come pagamento il carbone, ma molti accetterebbero i diamanti. Eppure hanno la stessa composizione chimica. Cosa cambia? I diamanti sono rari.

In generale, se si vuole creare una moneta digitale si deve tenere presente che il suo valore è legato alla sua quantità. Deve quindi esserci in qualche modo "difficile" creare nuovo cash.

Una soluzione a questo problema viene direttamente da una tecnica anti-spam per email che risale al 1992 (Dwok, Naor), basata su un principio molto semplice: per inviare una mail devo risolvere un ***computational puzzle*** legato in modo univoco a quella specifica mail, altrimenti questa non partirà. Se risolvere il problema per una mail `A` non dà alcun aiuto per la risoluzione del problema per la mail `B`, allora diventa computazionalmente difficile inviare grandi quantità di mail tutte insieme.

Questo stesso principio si applica in generale alle Blockchain ***PoW***: il cash viene creato ogni volta che un miner aggiunge un blocco alla blockchain, i.e. solo quando questo è stato in grado di risolvere il computational puzzle. In particolare, la prima transazione di ogni blocco assegna nuovi coin all'indirizzo del miner che sta costruendo quel blocco. 

"Ma così continuo ad erogare all'infinito!". Ni. In genere esiste un meccanismo di riduzione del reward. In ***Bitcoin***, ad esempio, il reward iniziale era di $50\,\BTC$ per blocco, ma il sistema stabilisce che ogni $210\cdot10^3$ blocchi aggiunti alla Blockchain (in che si traduce in un intervallo di tempo di qualche anno) questo valore si dimezza. Questo consente di dire che in una prima "era" sono stati prodotti $21\cdot10^3\times50=10.5$ milioni di bitcoin, poi $\times 25$ e via dicendo. Questa è ovviamente una serie convergente: se le regole restano queste, il massimo numero di Bitcoin in circolo sarà $21$ milioni. Ad oggi il reward è di $3.125\,\BTC$.

# Hashing e Computational Puzzles

Dopo aver effettuato un pagamento (che quindi è stato approvato dal sistema) e ricevuto un bene, un singolo miner prova a modificare la transazione in modo da recuperare i coin spesi. 

Si può fare? In teoria sì, ma viene reso estremamente difficile dall'***hashing*** dei blocchi. Ogni blocco ha un valore di hash che dipende dalle transazioni al suo interno, ma anche dall'hash del blocco precedente. Modificare un blocco significa non solo modificare il suo hash, ma rendere inconsistenti tutti gli hash di tutti i blocchi successivi. Un attaccante dovrebbe quindi modificare una sequenza di hash, che è notoriamente un problema difficile da risolvere ma di cui è facile da verificare la soluzione (tuttavia non è formalmente un problema $\NPH$).

In virtù della difficoltà del problema, le Blockchain ***PoW*** sfruttano l'hashing per implementare il ***computational puzzle***: solo chi riesce a trovare il giusto hash per il blocco che vuole proporre può aggiungerlo alla Blockchain.

Un'idea di come funziona è il meccanismo usato da ***Bitcoin***: per essere un blocco valido, l'hash in uscita deve avere i $k$ bit meno significativi uguali a $0$.

Ora, la funzione di hash (e.g. ***SHA-256*** per Bitcoin) prende in input le transazioni del blocco che voglio far approvare, l'hash del blocco precedente e (oltre ad altra roba che non stiamo a specificare in quanto non utile alla trattazione) un ***nonce***. In generale non ho idea di cosa esca fuori come hash di output, posso solo cambiare il nonce e guardare il risultato.

La probabilità di trovare proprio quello che voglio (i.e. i $k$ zeri finali) richiede un numero di lanci quantomeno esponenziale per diventare di ordine $1$, da cui la difficoltà probabilistica del problema (si capisce meglio perché non è classificabile come $\NPH$). Una volta risolto il problema (i.e. trovato il nonce), è facile per gli altri miner verificare la soluzione (basta far girare SHA-256 con i parametri indicati dal miner risolutore).

# What Cash Digitale?

L'entità "analogica" più vicina ad una moneta digitale è un assegno: erogo un biglietto con la mia firma che indica che il possessore può restituirmelo per ottenere l'equivalente in dollari. Questo assume fondamentalmente due cose:

- È difficile replicare la mia firma (i.e. è difficile falsificare l'assegno);
	- È invece molto facile copiare un file. Se a tale file è associato un "assegno digitale" (i.e. un coin) potrei duplicarlo e usarlo più volte. Questo problema prende il nome di ***double spending***, e la sua risoluzione ha stuzzicato la curiosità di diversi esponenti del mondo della crittografia;
- Chi accetta l'assegno si fida del fatto che a fronte di esso qualcuno mi pagherà.
	- Questo è equivalente a dire che qualcuno deve garantire che la transazione avvenga. Di norma questo compito spetta alle banche, che fungono da entità garante centrale. L'obiettivo di un DS, tuttavia, è quello di evitare centralizzazioni. Deve quindi essere il DS stesso a fare da garante, obiettivo raggiungibile tramite il ***consenso*** da parte di tutti i server (***miner***) sull'approvazione delle transazioni presenti nei singoli ***blocchi*** della ***blockchain***, i.e. il "libro mastro" (***ledger***) di tutte le transazioni.


# Bitcoin

Il sistema Bitcoin consta di $O(10^3)$ miner sparsi per il mondo, e il gossiping avviene tra $O(10)$ primi vicini. Dal momento che non sono previsti Smart Contracts, esiste un unico coin: $\BTC$.

Nasce con un primo blocco hard-coded contenente una sola transazione che ha fornito $50\,\BTC$ al suo fondatore, dopodiché diversi server si sono proposti come miner ed è iniziato il gioco. Il numero di transazioni per blocco è aumentato con il tempo, e al prima transazione di ogni blocco costituisce il reward per il miner che risolve il problema computazionale, motivo per cui la storia di ogni $\BTC$ è tracciabile fino alla sua origine.

Quando si esegue una transazione, è consigliato (ma non obbligatorio) pagare una ***fee*** al miner che fa approvare il blocco. Questo perché di fatto è un guadagno per il miner, il quale tenderà a dare priorità di approvazione alle transazioni con le fee più alte.

Il computational puzzle è abbastanza standard