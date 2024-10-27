
Attenzione! Qua ci stanno le macro di LaTeX con relativa sintassi. Non toccare.

- Parentesi per le funzioni \floor e \ceiling:$$
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \floor*{\frac{x}{2}} \leq \frac{x}{2} \leq \ceil*{\frac{x}{2}}
$$
- `\bra`, `\ket` - Notazione <bra|ket>:$$\newcommand{\bra}{\langle}\newcommand{\ket}{\rangle}\bra x|y\ket = \sum_ix_iy_i$$
- `\dist` - Non mi va di scrivere \text{dist} per la distanza:$$\newcommand{\dist}{\text{dist}}\dist(u,v)$$
- `\so` - Non mi va di scrivere \Rightarrow:$$\newcommand{\so}{\Rightarrow}x\so y$$
- `\uD`, `\dD`, `\tD` - Preferisco scrivere il numero di dimensioni come \text{1D}, probabilmente perché sono autistico:$$\newcommand{\uD}{\text{1D}}\newcommand{\dD}{\text{2D}}\newcommand{\tD}{\text{3D}}\uD,\,\dD,\,\tD$$
- `\NPC` - Un modo civile per scrivere NP-Complete$$\newcommand{\NPC}{\mathbb{NP}\text{-}\mathbf{Complete}}\NPC$$
	- `N`, `\R`, `\P`, `\NP` - E per scrivere gli altri insiemi notevoli$$\newcommand{\N}{\mathbb{N}}\newcommand{\R}{\mathbb{R}}\newcommand{\P}{\mathbb{P}}\newcommand{\NP}{\mathbb{NP}}\N,\R,\P,\NP$$
- `\a` per \alpha $$\newcommand{\a}{\alpha}\a$$