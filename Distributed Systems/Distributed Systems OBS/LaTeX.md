
Attenzione! Qua ci stanno le macro di LaTeX con relativa sintassi. Non toccare.

- Parentesi per le funzioni \floor e \ceiling:$$
\DeclarePairedDelimiter\ceil{\lceil}{\rceil}
\DeclarePairedDelimiter\floor{\lfloor}{\rfloor}
    \floor*{\frac{x}{2}} \leq \frac{x}{2} \leq \ceil*{\frac{x}{2}}
$$
- Notazione <bra|ket>:$$\newcommand{\bra}{\langle}\newcommand{\ket}{\rangle}\bra x|y\ket = \sum_ix_iy_i$$ $$\newcommand{\s}{\sigma}\s$$
- `\NPC` - Un modo civile per scrivere NP-Complete$$\newcommand{\NPC}{\mathbb{NP}\text{-}\mathbf{Complete}}\NPC$$