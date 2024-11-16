
Macro LaTeX con relativa sintassi.

# Alfabeto Greco

Ogni lettera dell'alfabeto greco è la "corrispondente" lettera latina (e.g. `\b` = `\beta`)

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

# Insiemi

- `\NPC` - Un modo civile per scrivere NP-Complete$$\newcommand{\NPC}{\mathbb{NP}\text{-}\mathbf{Complete}}\NPC$$
- `\NPH` - E uno per scrivere NP-Hard$$\newcommand{\NPH}{\mathbb{NP}\text{-}\mathbf{Hard}}\NPH$$
- `N`, `\R`, `\P`, `\NP` - E per scrivere gli altri insiemi notevoli$$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\P}{\mathbb{P}}\newcommand{\NP}{\mathbb{NP}}\N,\R,\P,\NP$$
- `\ss`, `\sse` - Non mi va di scrivere `\subset` e `\subseteq`$$\newcommand{\ss}{\subset}\newcommand{\sse}{\subseteq}A\ss B\quad C\sse D$$
- `\calN`, `\calX` - Varianti `\mathcal` per alcune lettere usate a volte per gli insiemi$$\newcommand{\calN}{\mathcal{N}}\newcommand{\calX}{\mathcal{X}}\calN\calX$$

# Utility

- Parentesi per le funzioni `\floor` e `\ceiling`:$$
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \floor*{\frac{x}{2}} \leq \frac{x}{2} \leq \ceil*{\frac{x}{2}}
$$
- `\bra`, `\ket` - Notazione `<bra|ket>`:$$\newcommand{\bra}{\langle}\newcommand{\ket}{\rangle}\bra x|y\ket = \sum_ix_iy_i$$

- `\so` - Non mi va di scrivere `\Rightarrow`:$$\newcommand{\so}{\Rightarrow}x\so y$$

# Varie

- `\dist` - Non mi va di scrivere `\text{dist}` per la distanza:$$\newcommand{\dist}{\text{dist}}\dist(u,v)$$
- `\uD`, `\dD`, `\tD` - Preferisco scrivere il numero di dimensioni come `\text{1D}`, probabilmente perché sono autistico:$$\newcommand{\uD}{\text{1D}}\newcommand{\dD}{\text{2D}}\newcommand{\tD}{\text{3D}}\uD,\,\dD,\,\tD$$
- `\PCH`, `\SCH` - Primo e Secondo Canale$$\newcommand{\PCH}{\text{CH}_1}\PCH\newcommand{\SCH}{\text{CH}_2}\SCH$$