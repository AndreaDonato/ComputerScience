
# Wireless Networks Algorithms

Se le comunicazioni avvengono in aria bisogna anzitutto risolvere il problema dell'interferenza, tipicamente tramite una ***assegnazione di frequenze*** (i.e. ***minima colorazione del grafo***).

Dal momento che questo tipo di comunicazione è particolarmente energivora per sistemi a batteria (e.g. ***sensori***), si pone il problema dell'***efficienza***. Se poi più sensori devono eseguire una task cooperativa, è necessario un ***coordinamento***.

# Wireless Sensor Networks (WSN)

Ci sono due scenari principali in cui ho a che fare con una WSN.

- ***Static WSN*** - Sono tendenzialmente legate alla raccolta dati. La topologia della rete è nota, ma nascono problemi di ***efficienza energetica*** (in vista di un utilizzo a lungo termine);
- ***Dynamic WSN*** - Sono legate a compiti sul breve termine, motivo per cui l'interesse principale è ***ottimizzare il compito cooperativo*** loro richiesto.


# Static Wireless Sensor Network

Quando una WSN statica viene disposta sul territorio, non è più possibile modificarne la topologia, né è comodo cambiare delle batterie che si scaricano frequentemente. Devo quindi

- Assicurarmi che ogni nodo sia raggiungibile da ogni altro (i.e. che il grafo sia connesso), e che al contempo la comunicazione avvenga con il minimo dispendio possibile di energia $\so$ ***minimum spanning tree***;
	- La costruzione del MST avviene generalmente per il nodo "coordinatore", i.e. quello che deve ***mandare informazioni di controllo alla rete***.
- Trovare un modo efficiente di ***raccogliere grandi quantità di informazioni dalla rete***. Ho due vie principali:
	- Dal momento che non è ottimale farlo con il MST, assoldiamo un simpatico galoppino chiamato ***data mule*** che fa il giro della rete provando a seguire il percorso ottimale;
	- Se non dispongo di un DM, devo ridurre al minimo l'attività non necessaria per non sprecare batteria (***Duty Cycle***), mantenendo al contempo una backbone "un po' più attiva" in grado di raggiungere tutti i nodi $\so$ ***connected dominating set***;
	- Se il sistema è particolarmente complesso, si possono usare entrambe le strategie insieme.

# 5 - Minimum Spanning Tree

Quando invio un segnale in aria, la potenza si conserva sulla superficie della sfera, quindi cala come ${1\over r^\a}$, dove in generale $\a\geq2$ (è $=2$ solo in assenza di ostacoli).

Se $u$ vuole inviare un messaggio a $v$, la potenza con cui dovrà sparare il segnale è $\propto \dist(u,v)^\a$. Passare per un nodo intermedio $w$ equidistante da $u$ e da $v$ significa passare da un singolo messaggio mandato con potenza $\sim r^\a$ a due messaggi a potenza $({r\over2})^\a$, ovvero nel complesso ${r^\a\over2}$.

Schematizzo i dispositivi come nodi e assegno un peso proporzionale alla loro distanza agli archi tra essi. A differenza del routing, qui non posso fare `unicast`: ogni messaggio è un `broadcast` (i.e. inoltrare un messaggio significa fare `flooding` entro la mia gittata). La domanda è: ***qual è la minima potenza che mi garantisce che la catena di `broadcast` raggiunga tutti gli altri nodi della rete?***

Risolvere questo problema per $u$ è equivalente a trovare il suo ***minimum spanning tree***, i.e. il set di archi tale che l'albero di radice $u$ sia connesso ad ogni altro $v$ e che il costo complessivo sia minimo.

Essendo un problema $\NPH$, si usano ***algoritmi approssimanti***.

## Definire gli Archi

Nonostante il suo range di azione sia in linea di principio infinito, la potenza del segnale in aria decade come ${1\over r^\a}$. Questo significa che oltre una certa distanza sarà pressoché inintelligibile.

Definiamo quindi un ***transmission range*** $R$ tale che due nodi $u$ e $v$ sono collegati da un arco se e solo se la loro distanza è $<R$:$$R\,:\,\{(u,v)\in E \iff \dist(u,v)<R\}$$
Questo per evitare che il nodo sia tentato di urlare troppo forte se il collegamento è molto debole.

Sicuramente è il dispositivo stesso ad avere un ***limite di potenza*** oltre il quale non può trasmettere, ma anche restando al di sotto di esso alzare $R$ significa consentire al nodo di sparare più forte, il che potrebbe portarlo a consumare più batteria (dipendentemente dalla soluzione del MST: magari a quel nodo è sufficiente sussurrare ad un nodo vicino per raggiungere il resto della rete, o può essere costretto ad usare tutta la potenza a sua disposizione). Di contro, un $R$ troppo basso potrebbe produrre un grafo non connesso.


## Premesse agli Algoritmi Approssimanti

Siamo interessati a fare un ***Broadcast Range Assignment*** minimale, ovvero assegnare ad ogni nodo la minima potenza di trasmissione necessaria a raggiungere ogni altro nodo, i.e. risolvere il ***Minimum-Energy Broadcast*** (`MinBroadcast`) problem. C'è un problema.

`THM` - Non esiste, in generale, un algoritmo polinomiale che approssima `MinBroadcast` entro un fattore costante, i.e. l'approssimazione peggiora al crescere della dimensione del problema.

`Proof` - Dimostro che `MinBroadcast` è polinomialmente riconducibile a `MinSetCover` e dimostro che quest'ultimo non è approssimabile entro un fattore costante.

- `MinSetCover` - Il problema è così definito: abbiamo un ***Universal Set*** $U$ che possiamo pensare come un alfabeto ed $N$ subset $S_i\ss U$. Posto che $\bigcup_{i=1}^N S_i = U$ (i.e. se prendo tutti gli $S$, questi ricoprono $U$), qual è il set minimale $\calS=\{S_k\}_{k=1}^{n<N}$ che ricopre $U$ (i.e. $\bigcup_{k=1}^{n<N} S_k = U$)?
	- Ci fidiamo che non è approssimabile per nessuna costante $c\log|U|$.
- `Riduzione` - L'idea è costruire un albero a tre layer:
	- Il primo layer consta della sola radice, il nodo sorgente $s$ (i.e. $\calS$), che punta ad $n$ nodi $\{S_k\}$;
	- Tali nodi formano il secondo layer, che rappresenta gli $n$ subset $\{S_k\}$. Ognuno di essi ha al suo interno un certo numero $j_k$ di simboli $\{U_i\}^{j_k}_{i=1}$, quindi ogni $S_k$ punta ai rispettivi simboli con $j_k$ archi orientati;
	- Gli $N$ simboli $\{U_i\}^N_{i=1}$ di $U$ costituiscono l'ultimo layer.
	- Assegnando a tutti gli archi lo stesso costo (e.g. $1$), abbiamo mappato la minimizzazione dei subset $\calS$ alla minimizzazione del costo dello spanning tree.

Pur vero questo, nel caso speciale di ***distanza Euclidea $\dD$*** possiamo fare un po' meglio, e trovare fino ad una $6$-approssimazione. Procediamo allora osservando che

- Possono esistere diversi MST con lo stesso costo complessivo;
	- Se tutti i pesi sono uguali ogni ST sul grafo è minimo (pure massimo, se è per questo...);
	- Viceversa, se tutti i costi sono diversi il MST è unico. Si dimostra per contraddizione assumendo che non lo sia e vedendo che il costo dell'altro è diverso (non essendo uguale, il MST è unico, come atteso).
- Se nel grafo è presente un ciclo ed uno degli archi che lo forma ha costo maggiore della somma di tutti gli altri, allora questo arco non potrà essere nel MST (fa una `proof`, ma è ovvio);
- Se nel grafo è presente un unico arco dal costo minimo, allora questo sarà nel MST;
- Nelle slides ci sono altre osservazioni, ma non mi pare siano utili.


## Algoritmi Approssimanti per `MinimumSpanningTree`

Sono tutti algoritmi greedy basati sulla stessa logica:

- Parti da un set vuoto $A$;
- Fintantoché $A$ non è un MST aggiungi un ***safe arc***, i.e. tale da non violare le proprietà dell'MST.

Il grafo $G_A$ che va costruendosi consta di diverse componenti connesse, le quali possono essere singoli nodi o alberi. Ogni nuovo arco che viene aggiunto ad $A$ connette due componenti di $G_A$.

In cosa differiscono i diversi algoritmi?

- ***Kruskal*** - Si basa sulla seguente logica: dato $G_A$, tra gli archi che connettono due componenti connesse disgiunte scegli quello con costo minore;
	- Usa la struttura dati ***Union-Find***, che opera su insiemi disgiunti e si basa su due azioni:
		- **Find** - Dato un elemento, individua l'insieme di cui fa parte;
		- **Union** - Unione degli insiemi disgiunti;
	- Questo significa che si creeranno diverse "bolle" che verranno infine collegate tra loro;
	- Complessità $O(m\log n)$ (al solito, $n$ nodi ed $m$ edges);
	- ***Ottimale per grafi sparsi*** ($m\sim n$).
- ***Prim*** - La logica è collegare la componente connessa già presente con il nodo isolato avente il collegamento meno costoso;
	- L'albero si sviluppa come un singolo "embrione" che cresce;
	- La complessità dipende dalla struttura dati di supporto:
		- Heap - $O(m\log n)$;
		- Fibonacci Heap - $O(m+n\log n)$
	- ***Ottimale per grafi densi*** ($m\sim n^2$).
- ***Boruvka*** (o ***Sollin***) - Nell'ipotesi che tutti gli archi abbiano costi diversi (?), fa un ciclo su tutti i cluster $C_i$ e per ognuno di essi sceglie l'arco di costo minore con la stessa logica di Prim.
	- L'albero si sviluppa "a bolle" come in Kruskal, ma la logica per far espandere queste bolle è simile a Prim (i.e. è una sorta di Prim a più cluster);
	- Complessità $O(m\log n)$;
	- Non ho capito bene per cosa è ottimale, [dicono](https://en.wikipedia.org/wiki/Bor%C5%AFvka%27s_algorithm) in contesti distribuiti e/o paralleli (specie se usato insieme a Prim, e.g. in computazione parallela).

Dato un grafo e un suo MST, è più facile ($O(\log n$)) ricalcolarlo se il grafo cambia leggermente. Ancora più facile ($O(n+m)$) è verificare se uno ST è effettivamente minimo.

## Non un MST, ma...

Potrei provare a risolvere il problema del minimo costo del broadcast senza costruire un MST.

- ***SPT*** (***Spanning Path Tree***) - Uso ***Dijkstra*** per costruire il percorso di costo minimo verso ogni singola foglia. Dista dalla soluzione ottimale $\e^2 + {n\over2}(1-\e)^2$, dove non ho capito bene chi è $\e$, ma per qualche motivo alla fine fa un commento su $\e\to0$;
- ***BAIP*** (***Broadcast Average Incremental Power***) - Variante di Dijkstra in cui scelgo se aggiungere un nodo allo ST con la seguente logica:
	- Definisco un `Minimum Average Cost` = `Energy Increase`/`# of Nodes in the Tree`;
	- Se per il nodo che Dijkstra vorrebbe aggiungere questo valore è $<1$, accetto.
	- L'efficienza media, definita come `Potenza Complessiva`/`# Nodi Raggiunti`, è in questo caso $=1$ (per qualche motivo che non mi è chiarissimo);
	- Calcolando la minima potenza usata, si trova che questo metodo è una$$\bigg({4n\over\log n}+O(1)\bigg)-\text{approssimazione}$$

# 6 - Data Mule Scheduling

Il Data Mule è un nodo mobile che va in giro a raccogliere dati, consentendo ai nodi fissi di comunicare grandi moli di dati usando bassa potenza (i.e. consumando poca batteria) e sgravandoli dal compito di fare routing.

Il problema di trovare il ***percorso ottimale*** tra i nodi si formalizza nel seguente modo:

- Un ***percorso hamiltoniano*** è una cammino che tocca tutti i nodi una ed una sola volta;
- Un ***ciclo hamiltoniano*** (***HC***) è un percorso hamiltoniano il cui ultimo nodo coincide col primo;
- Trovare il ciclo hamiltoniano ottimale si traduce nel ***travelling salesman problem*** (***TSP***).

Posto di aver trovato il path, ci sono altre due variabili da tenere in considerazione:

- ***Controllo della velocità*** - Una volta entrato in range di trasmissione, il Mule deve restarci per il tempo necessario a scaricare tutti i dati;
- ***Job Scheduling*** - Se il percorso del Mule passa per il range di più dispositivi contemporaneamente, deve scegliere a quale dei due dare la precedenza per il trasferimento dei dati.

Ci focalizziamo solo sul TSP, e la soluzione è sempre un ***grafo orientato***.


## Travelling Salesman Problem (TSP)

Sia $G=(V,E)$ un grafo non orientato. Sappiamo che determinare se $G$ contiene un HC è $\NPC$.

Questo però non è TSP, perché il Data Mule può muoversi tra qualsiasi coppia di nodi. Sia $K_n(V,E')$ un grafo completo tale che $E\ss E'$ e $t\in\R^+$. È chiaro che $K_n$ contiene almeno un HC, ma ne contiene uno il cui costo è minore di $t$? O in modo analogo, qual è il minimo $t$ take che $K_n$ ha un costo $\leq t$?

***`Theorem`*** - Quest'ultimo problema, anche detto TSP, è $\NPC$. Segue `proof`.

- Sicuramente TSP $\in\P$. Verificare che un ciclo sia un HC ha costo $O(|V|)=O(n)$, e fare la somma dei costi per verificare che essa sia $\leq t$ è $O(|E'|)=O(m)$;
- Sappiamo che HC $\in\NPC$, basta trovare una riduzione da HC a TSP.
	- Definiamo una ***weight function*** $w$ tale che
		- $w(i,j)=1$ se $(i,j)\in E$ (i.e. hanno costo $1$ gli archi $\in G\ss K_n$);
		- $w(i,j)=2$ se $(i,j)\in E'-E$. (i.e. hanno costo $2$ gli archi di $K_n$ che non compaiono in $G$)
	- Assumiamo che $G$ abbia un HC. Visto che $G\ss K_n$, allora esiste un HC su $K_n$ di costo $t$, dove $t$ è il numero di archi dell'HC $\in G$, che coincide con il costo complessivo, essendo $=1\forall (i,j)\in E$, e che coincide con il numero di nodi di $G$, essendo la soluzione un HC, e che quindi coincide con il numero di nodi $n$ di $K_n$ (in breve: in questa costruzione $t=n$);
	- Viceversa, se $K_n$ ha un HC di costo $t=n$ significa che gli archi che ha utilizzato hanno tutti costo $1$, quindi sono tutti $\in E$ e quindi $G$ contiene un HC.

Il grosso problema è che non solo TSP è $\NPC$, lo è anche un qualsiasi algoritmo $r$-approssimante. Questo significa che ***TSP non è in generale approssimabile entro una costante***.

Anche qui, ci sono situazioni particolari in cui questo limite si aggira. Se $w$ rispetta la disuguaglianza triangolare $w(a,c) ≤ w(a,b)+w(b,c)$ (e.g. $w$ è una ***distanza euclidea***, guarda caso proprio quella che ci serve) possiamo trovare fino ad una $1.5$-approssimazione.


### Non-Approssimabilità di TSP

`Theorem` - Se esiste un algoritmo $\in\P$ che produce una $r$-approssimazione per TSP, allora $\P=\NP$.

`Proof` - L'idea è dimostrare che se TSP è $r$-approssimabile, allora esiste un algoritmo $\in\P$ che fornisce una soluzione esatta per l'HC. Siano $G$ e $K_n$ definiti come prima. Generalizziamo la weight function $w$ definita in precedenza:

- $w(i,j)=1$ se $(i,j)\in E$
- $w(i,j)=2 +(r-1)n$ se $(i,j)\in E'-E$.

Se $r=1$ (soluzione esatta) torniamo correttamente alla $w$ precedente, quindi sappiamo che$$K_n\text{ ha un HC di costo }n\iff G\text{ contiene un HC}$$
Un algoritmo $r$-approssimante trova quindi una soluzione di costo al più $r\cdot n$. I casi sono due:

- La soluzione contiene solo gli archi ottimali. In questo caso, è la soluzione esatta. Ma l'ho trovata in tempo polinomiale, quindi ho risolto HC su $G$ in tempo polinomiale, quindi sto dicendo che ho trovato un algoritmo $\P$ per un problema $\NPC$, da cui segue $\P=\NP$;
- La soluzione contiene un edge $\notin E$, quindi quantomeno tolgo un arco ottimale e lo sostituisco con un arco sub-ottimale (o peggio), il che si traduce nel dire che $$\text{Cost}(H)\geq n - 1 + 2+ (r-1)n=r\cdot n+1$$Questo contraddice l'ipotesi di algoritmo $r$-approssimante.

### TSP come ILP

Si può formulare TSP come ILP. Definiamo le variabili booleane come $x_{ij}=1 \iff (i,j)\in HC$ e $x_{ij}=0$ altrimenti e usiamo la funzione di peso $w_{ij}$. L'obiettivo è minimizzare$$\min\bigg[\sum_{i,j}^Nw_{ij}x_{ij}\bigg]\quad s.t.\quad\sum_{i}^Nx_{ij}=\sum_{j}^Nx_{ij}=1\quad\text{and}\quad\sum_{i,j\in S}x_{ij}<|S|$$dove i constraints mirano a garantire che

- da $i$ parte uno ed un solo arco, e a $j$ punta uno ed un solo arco;
- una ***cycle cover*** (i.e. quando grafo viene ricoperto da cicli disgiunti) non sia una soluzione. $S$ indica un generico subset proprio di nodi di $V$, e se i suoi nodi sono collegati da un ciclo allora il numero di archi sarà uguale al numero di nodi. Per evitare questa possibilità impongo una disuguaglianza di minore stretto, detta ***subtour elimination constraint***.
	- Questa cosa va fatta $\forall S\ss V$, quindi abbiamo un numero esponenziale di constraints!

## Algoritmi Approssimanti per `TSP`

Se $w$ è una metrica (i.e. $w$ rispetta la disuguaglianza triangolare) arrivo fino ad una $2$-approssimazione. Se poi uso quella simpatica metrica chiamata distanza euclidea arrivo fino a $1.5$.

Nel farlo teniamo in considerazione che se $T$ è un MST sul grafo, $P$ è un path e $H^*$ la soluzione ottimale per HC,$$w(T)\leq w(P)\leq w(H^*)$$cioè il peso di un qualsiasi MST è un lower bound per la soluzione $H^*$ di HC.

### Metric TSP ($2$-approssimazione)

Chiamiamo l'algoritmo "`2-Approx-mTSP`" e vediamo come agisce.

- Scegli un nodo radice $r\in K_n$ e calcolane un MST;
- L'HC approssimato è una sua visita in ***preordine*** $L$ senza ripetizioni.

`Theorem` - Se $w$ è una metrica `2-Approx-mTSP` è una $2$-approssimazione.

`Proof` - Sappiamo che $w(T)\leq w(H^*)$. In una visita in preordine ogni edge compare esattamente due volte, quindi la soluzione approssimata $C$ così costruita è tale che $w(C)=2w(T)$. Questo prova l'uguaglianza, ma possiamo eliminare qualche arco ridondante ed abbassare il costo, grazie alla disuguaglianza triangolare (e.g. se devo visitare i nodi $A$, $B$ e $C$ tutti connessi tra loro, posso fare $A\to B$ e poi direttamente $B\to C$ dove invece il preordine su un albero prevede $B\to A\to C$).

In definitiva, $$w(H) ≤ w(C) =2 w(T) ≤ 2 w(H^*)$$

### Euclidean TSP ($1.5$-approssimazione)

Il ***Christofides Algorithm*** abbassa l'approximation ratio sempre sfruttando MST.

- Scegli un nodo radice $r\in K_n$ e calcolane un MST $T$;
- Sia $O$ il set di nodi di $T$ aventi grado dispari, e sia $G_O$ il sub-grafo indotto da $O$;
	- Ogni MST ha un numero pari di nodi aventi grado dispari (cfr. ***Handshaking Theorem***).
- Esegue un ***perfect matching*** su $G_O$, cioè organizza a coppie i nodi di $G_O$ scegliendo gli archi che minimizzano il costo complessivo e creando il grafo (non connesso) $M$;
	- È sempre possibile perché sono partito da un grafo completo (cfr. ***Lemma di Berge***)
- Unisce $M$ e $T$, creando una duplicazione degli archi sui nodi di grado dispari (i.e. crea un ***multigrafo***). Il risultato è un grafo in cui ogni nodo ha grado pari;
- Crea un ***ciclo euleriano***, cioè un ciclo che passa da ogni arco esattamente una volta (sempre possibile in quanto ogni nodo ha grado pari, cfr. ***Teorema di Eulero***);
- Converti il ciclo euleriano in un ciclo hamiltoniano. Chiaramente non potrà essere esattamente un $H^*$, ma come detto l'approximation rate è al più $1.5$.

`Theorem` - Se $w$ è una metrica, questo algoritmo è una $1.5$-approssimazione.

`Proof` - Dividiamo gli archi $M$ della soluzione ottimale $H^*$ (***grafo orientato***) in due subset:

- $M_o$, il cui nodo di partenza aveva originariamente grado dispari su $K_n$;
- $M_e$ stessa cosa con i nodi di grado pari.

Questi subset sono tali che $w(M_o)+w(M_e)=w(H^*)$, e per almeno uno dei due subset (e.g. w.l.o.g. $M_o$) deve essere vero che$$w(M_o)\leq {1\over2}w(H^*)$$
A questo punto l'algoritmo fa un perfect matching $M$ di $G_O$, ottenendo un peso complessivo migliore rispetto a quello di $M_o$, per cui$$w(M)\leq w(M_o)\leq {1\over2}w(H^*)$$
Quando infine sommo questo grafo con l'MST creato all'inizio, il peso complessivo della soluzione sarà minore della somma dei pesi dei due contributi (magari ci stanno archi in comune che non si sommano). Sapendo che $w(T)\leq w(H^*)$ e applicando entrambi gli upper bound abbiamo che$$w(H)\le w(M)+w(T)\le {1\over2}w(H^*)+w(H^*)={3\over2}w(H^*)$$

## MST + Data Mule

MST e Data Mule vengono generalmente usati insieme, perché ottimizzano due aspetti differenti.

MST non è ottimale per raccogliere le informazioni dai sensori. Questo perché una comunicazione multi-hop all-to-all così costruita è squilibrata in termini di energia e di complessità:

- Se tutti mandano i dati raccolti al ***sink***, i nodi sono sempre costretti ad usare tutta la potenza necessaria a raggiungere il primo vicino sul MST, quindi si scaricano più rapidamente (specie quelli vicini al sink, perché sono quelli più spesso chiamati in causa);
- Per evitare le `broadcast storm`, ogni nodo dovrebbe implementare protocolli di routing.

Ovviamente, il Data Mule non è ottimale per trasmettere informazioni di controllo ai nodi perché non sai mai quando li raggiungerà.

Inoltre, per via della sua struttura ottimizzata MST ha davvero poca ***fault tolerance***: se si guasta un nodo, il suo sotto-albero viene di fatto disconnesso. Il Data Mule può mitigare il problema, ma in genere si tende a creare una struttura di partenza con più ridondanza rispetto al MST.



