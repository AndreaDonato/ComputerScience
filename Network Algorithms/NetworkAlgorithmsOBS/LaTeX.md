
Attenzione! Qua ci stanno le macro di LaTeX con relativa sintassi. Non toccare.

# Alfabeto Greco

Ogni lettera dell'alfabeto greco è la "corrispondente" lettera latina (e.g. \b = \beta)

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

# Insiemi Notevoli

- `\NPC` - Un modo civile per scrivere NP-Complete$$\newcommand{\NPC}{\mathbb{NP}\text{-}\mathbf{Complete}}\NPC$$
- `N`, `\R`, `\P`, `\NP` - E per scrivere gli altri insiemi notevoli$$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\P}{\mathbb{P}}\newcommand{\NP}{\mathbb{NP}}\N,\R,\P,\NP$$


# Utility

- Parentesi per le funzioni \floor e \ceiling:$$
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \floor*{\frac{x}{2}} \leq \frac{x}{2} \leq \ceil*{\frac{x}{2}}
$$
- `\bra`, `\ket` - Notazione <bra|ket>:$$\newcommand{\bra}{\langle}\newcommand{\ket}{\rangle}\bra x|y\ket = \sum_ix_iy_i$$

- `\so` - Non mi va di scrivere \Rightarrow:$$\newcommand{\so}{\Rightarrow}x\so y$$