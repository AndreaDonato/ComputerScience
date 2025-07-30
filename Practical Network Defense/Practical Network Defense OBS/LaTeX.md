
Macro LaTeX con relativa sintassi.

# Alfabeto Greco

Quasi ogni lettera dell'alfabeto greco è la "corrispondente" lettera latina (e.g. `\b` = `\beta`). Ne restano escluse quelle già molto corte (e.g. `\pi` e `\Pi` restano così) e quelle uguali ai caratteri latini (che tanto non ci sono neanche in LaTeX, per ovvi motivi).

$$
\newcommand{\a}{\alpha}\a
\newcommand{\b}{\beta}\b
\newcommand{\g}{\gamma}\g
\newcommand{\G}{\Gamma}\G
\newcommand{\d}{\delta}\d
\newcommand{\D}{\Delta}\D
\newcommand{\e}{\varepsilon}\e
\newcommand{\z}{\zeta}\z
\newcommand{\th}{\vartheta}\th
\newcommand{\T}{\Theta}\T
\newcommand{\l}{\lambda}\l
\newcommand{\L}{\Lambda}\L
\newcommand{\r}{\rho}\r
\newcommand{\s}{\sigma}\s
\newcommand{\S}{\Sigma}\S
\newcommand{\t}{\tau}\t
\newcommand{\f}{\phi}\f
\newcommand{\F}{\Phi}\F
\newcommand{\c}{\chi}\c
\newcommand{\o}{\omega}\o
\newcommand{\O}{\Omega}\O
$$

# Varianti \mathcal

Ogni lettera maiuscola ha una variante `\mathcal{X}` scrivibile come `\calX`
$$
\newcommand{\calA}{\mathcal{A}}\calA
\newcommand{\calB}{\mathcal{B}}\calB
\newcommand{\calC}{\mathcal{C}}\calC
\newcommand{\calD}{\mathcal{D}}\calD
\newcommand{\calE}{\mathcal{E}}\calE
\newcommand{\calF}{\mathcal{F}}\calF
\newcommand{\calG}{\mathcal{G}}\calG
\newcommand{\calH}{\mathcal{H}}\calH
\newcommand{\calI}{\mathcal{I}}\calI
\newcommand{\calJ}{\mathcal{J}}\calJ
\newcommand{\calK}{\mathcal{K}}\calK
\newcommand{\calL}{\mathcal{L}}\calL
\newcommand{\calM}{\mathcal{M}}\calM
\newcommand{\calN}{\mathcal{N}}\calN
\newcommand{\calO}{\mathcal{O}}\calO
\newcommand{\calP}{\mathcal{P}}\calP
\newcommand{\calQ}{\mathcal{Q}}\calQ
\newcommand{\calR}{\mathcal{R}}\calR
\newcommand{\calS}{\mathcal{S}}\calS
\newcommand{\calT}{\mathcal{T}}\calT
\newcommand{\calU}{\mathcal{U}}\calU
\newcommand{\calV}{\mathcal{V}}\calV
\newcommand{\calW}{\mathcal{W}}\calW
\newcommand{\calX}{\mathcal{X}}\calX
\newcommand{\calY}{\mathcal{Y}}\calY
\newcommand{\calZ}{\mathcal{Z}}\calZ
$$



# Insiemi

- `\NPC` - Un modo civile per scrivere NP-Complete$$\newcommand{\NPC}{\mathbb{NP}\text{-}\mathbf{Complete}}\NPC$$
- `\NPH` - E uno per scrivere NP-Hard$$\newcommand{\NPH}{\mathbb{NP}\text{-}\mathbf{Hard}}\NPH$$
- `\N`, `\R`, `\P`, `\NP`, `\Z`, `\I` - E per scrivere gli altri insiemi notevoli$$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\P}{\mathbb{P}}\newcommand{\NP}{\mathbb{NP}}\newcommand{\Z}{\mathbb{Z}}\newcommand{\I}{\mathbb{I}}\newcommand{\C}{\mathbb{C}}\N,\R,\P,\NP,\Z,\I, \C$$
- `\ss`, `\sse` - Non mi va di scrivere `\subset` e `\subseteq`$$\newcommand{\ss}{\subset}\newcommand{\sse}{\subseteq}A\ss B\quad C\sse D$$

# Quantum Information

- `\kz`, `\ku`, `\kp`, `\km` - Modi rapidi per scrivere i ket più importanti$$\newcommand{\kz}{|0\ket}\kz \newcommand{\ku}{|1\ket}\ku \newcommand{\kp}{|+\ket}\kp \newcommand{\km}{|-\ket}\km $$
###### Scrivere rapidamente gli operatori principali

`\identity`, `\paulix`, `\pauliy`, `\pauliz`

$$
\newcommand{\identity}{\begin{pmatrix}1&0\\0&1\end{pmatrix}}\identity
\newcommand{\paulix}{\begin{pmatrix}0&1\\1&0\end{pmatrix}}\paulix
\newcommand{\pauliy}{\begin{pmatrix}0&-i\\i&0\end{pmatrix}}\pauliy
\newcommand{\pauliz}{\begin{pmatrix}1&0\\0&-1\end{pmatrix}}\pauliz
$$

`\hadamard`
$$
\newcommand{\hadamard}{{1\over\sqrt2}\begin{pmatrix}1&1\\1&1\end{pmatrix}}\hadamard
$$
`\gateS`, `\gateT`
$$
\newcommand{\gateS}{\begin{pmatrix}1&0\\0&i\end{pmatrix}}\calS=\gateS
\newcommand{\gateT}{\begin{pmatrix}1&0\\0&{1+i\over\sqrt2}\end{pmatrix}}\qquad\calT=\gateT

$$

# Utility

- Parentesi per le funzioni `\floor` e `\ceiling`:$$
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \floor*{\frac{x}{2}} \leq \frac{x}{2} \leq \ceil*{\frac{x}{2}}
$$
- `\bra`, `\ket` - Notazione `<bra|ket>`:$$\newcommand{\bra}{\langle}\newcommand{\ket}{\rangle}\bra x|y\ket = \sum_ix_iy_i$$

- `\so` - Non mi va di scrivere `\Rightarrow`:$$\newcommand{\so}{\Rightarrow}x\so y$$
-  `\impose` - Voglio un modo rapido per scrivere `\stackrel{!}{=}`$$\newcommand{\impose}{\stackrel{!}{=}}\impose$$
- `\meanx` - Vorrei evitare di scrivere ogni volta `\overline{x}` (ed altri, tipo `y`, se serve)$$\newcommand{\meanx}{\overline{x}}\meanx\newcommand{\meany}{\overline{y}}\meany$$
- `\E` - Per scrivere rapidamente l'operatore valore atteso$$\newcommand{\E}{\mathbb{E}}\E$$
# Varie

- `\dist` - Non mi va di scrivere `\text{dist}` per la distanza:$$\newcommand{\dist}{\text{dist}}\dist(u,v)$$
- `\uD`, `\dD`, `\tD` - Preferisco scrivere il numero di dimensioni come `\text{1D}`, probabilmente perché sono autistico:$$\newcommand{\uD}{\text{1D}}\newcommand{\dD}{\text{2D}}\newcommand{\tD}{\text{3D}}\uD,\,\dD,\,\tD$$
- `\PCH`, `\SCH` - Primo e Secondo Canale$$\newcommand{\PCH}{\text{CH}_1}\PCH\newcommand{\SCH}{\text{CH}_2}\SCH$$
- `\BTC`, `\ETH` - Un modo più carino di scrivere Bitcoin ed Ethereum$$\newcommand{\BTC}{\mathsf{BTC}}\BTC\quad\newcommand{\ETH}{\mathsf{ETH}}\ETH$$
- `\bit` - Devo distinguere tra $\mathsf{bit}$ informativo e `bit` fisico$$\newcommand{\bit}{\mathsf{bit}}\bit$$
- `\SNR` - Signal to Noise Ratio$$\newcommand{\SNR}{\mathsf{SNR}}\SNR$$