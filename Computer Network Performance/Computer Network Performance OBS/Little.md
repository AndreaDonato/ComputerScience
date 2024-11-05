
# Sistema Aperto

Dato un sistema aperto ed un intervallo di osservazione da $0$ a $t$, abbiamo

- i job $C(t)$ completati entro $t$, che occupano la CPU per un tempo$$\sum_{i\in C(t)}T_i$$
- i job $A(t)$ arrivati entro $t$, che includono sia i job completati che quelli non ancora completati. Nel complesso, hanno occupato e/o occuperanno in futuro (per "futuro" si intende oltre $t$) la CPU per un tempo$$\sum_{i\in A(t)}T_i$$
- sempre i job $\in A(t)$, ma stavolta consideriamo solo il tempo fino a $t$$$a = \int_0^tN(t')dt'$$

Per come sono stati definiti, abbiamo che$$\sum_{i\in C(t)}T_i\leq a \leq \sum_{i\in A(t)}T_i$$
Moltiplico e divido per $C(t)\over C(t)$ a sinistra e per $A(t)\over A(t)$ a destra, poi applico a tutti i membri $$\lim_{t\to\infty} (*) {1\over t}$$$$\so \lim_{t\to\infty} {C(t)\over t}{\sum_{i\in C(t)}T_i\over C(t)}\leq \lim_{t\to\infty}{a\over t} \leq \lim_{t\to\infty} {A(t)\over t}{\sum_{i\in A(t)}T_i\over A(t)}$$
A questo punto

- $\lim_{t\to\infty} {C(t)\over t}$ è il throughput $X$;
- $\lim_{t\to\infty} {\sum_{i\in C(t)}T_i\over C(t)}$ è il response time dei processi completati $\bra T \ket_C$;
- $\lim_{t\to\infty}{a\over t}$ è il valore atteso del numero di job nel sistema $\bra N\ket$;
- $\lim_{t\to\infty} {A(t)\over t}$ è l'arrival rate $\l$;
- $\lim_{t\to\infty} {\sum_{i\in A(t)}T_i\over A(t)}$ è il response time dei processi arrivati $\bra T \ket_A$.

Sotto l'ipotesi di sistema ergodico (in questo caso $\l < \mu$) abbiamo che$$\bra T \ket_C=\bra T \ket_A=\bra R \ket$$$$\bra\l\ket = \bra X\ket$$
Quindi per il sempreverde teorema dei carabinieri$$X\bra R\ket\leq\bra N\ket \leq X\bra R\ket \quad\so\quad\bra N\ket = X\bra R\ket$$

# Sistema Chiuso

Per un sistema chiuso facciamo lo stesso ragionamento del sistema aperto, l'unica differenza è che la popolazione è nota: $a=Nt$.

Definisco una box in cui includo sia server che client, ma "taglio fuori" un pezzetto di collegamento, in modo da ricondurmi ad un sistema aperto. Posso applicare la Little's Law per il sistema aperto (in cui però conosco $N$)$$N=X\bra T\ket$$dove però stavolta $T$ è la somma dei response time del server ($R$) e del client ($Z$, anche detto ***think time***). Sostituendo abbiamo$$N=X\bigg(\bra R\ket + \bra Z\ket\bigg)$$