#import "@preview/cetz:0.4.0"
#import "@preview/algorithmic:1.0.0"
#import "@preview/finite:0.5.0": *

#let circumflex = "^"
#let LR(k) = $bold("LR")"("#k")"$
#let cz(sym) = $accent(#sym, caron)$
#let hat(sym) = $accent(#sym, macron)$
#let circ = super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))))

#let eps = $epsilon$
#let gear = "⛭"

#let iff = $bold("iff")$
#let to = $attach(tack, tr: *)$
#let tor = $attach(to, br: r m)$
#let tol = $attach(to, br: l m)$
#let rto = $attach(tack, br: r m)$
#let lto = $attach(tack, br: l m)$
#let al = $chevron.l$
#let ar = $chevron.r$

#let Aa = $cal(A)$
#let Bb = $cal(B)$
#let Dd = $cal(D)$
#let Ff = $cal(F)$
#let Gg = $cal(G)$
#let Ll = $cal(L)$
#let Mm = $cal(M)$
#let Nn = $cal(N)$
#let Oo = $cal(O)$
#let Tt = $cal(T)$
#let Pp = $cal(P)$
#let Rr = $cal(R)$

#let LS = $Ll\$$
#let SD = $Sigma\$$

#let srd = $bold("Shift-Reduce")$
#let rr = $bold("Reduce-Reduce")$

#let acc = $bold("acc")$
#let rej = $bold("rej")$

#let sa = $frak(s_(a c c))$
#let sr = $frak(s_(r e j))$

#let vp = $op(bold("VI"))$
#let follow = $op(bold("FOLLOW"))$
#let first(k : "0") = if (k == "0") [
                  $op(bold("FIRST"))$
                ] else [
                  $op(bold(#k"-FIRST"))$
                ]

#let lrDot = $circle.filled.small$
#let ecl = $op(bold(eps"-CLOSURE"))$
#let cl = $op(bold("CLOSURE"))$
#let goto = $op(bold("GOTO"))$

#let пда = [PDA]
#let aut = $op(bold("AUT"))$
#let pda = $op(bold("PDA"))$
#let dcfl = $op(bold("DCFL"))$
#let dcfl-es = $dcfl_bold("es")$
#let dpda = $op(bold("DPDA"))$
#let reg = $op(bold("REG"))$
#let regexp = $op(bold("REGEXP"))$
#let RE = $op(bold("RE"))$
#let cfl = $op(bold("CFL"))$
#let csl = $op(bold("CSL"))$

#let dom = $op(bold("dom"))$
#let pref = $op(bold("pref"))$

#let gb(data) = block(
  fill: green.lighten(80%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[
  #data
]

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let taskCnt(section) = counter("task" + section)
#let taskHeader(n, m) = [
  *Задача #counter(heading).display()#n* #label("task" + counter(heading).display() + str(m.at(0)))
]

#let yb(data) = block(
  fill: yellow.lighten(80%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[
  #context taskCnt(counter(heading).display()).step()
  #(context taskHeader(taskCnt(counter(heading).display()).display(), taskCnt(counter(heading).display()).get()))

  #data
]

#let ob(data) = block(
  fill: orange.lighten(80%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[ #data ]

#let thCnt() = counter("theorem")
#let thHeader(n, name, m) = [
  *Теорема #n. (#name)* #label("theorem" + counter(heading).display() + str(m.at(0)))
  // #counter(heading).display()
]

#let th(name, descr) = block(
  fill: blue.lighten(80%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[
  #context thCnt().step()
  #context thHeader(thCnt().display(), name, thCnt().get())

  #descr
]

#let lemmaCnt = counter("lemma")
#let lemma(n, name, descr) = block(
  fill: blue.lighten(80%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[
  #if name == "" {
    [*Лемма #n* #label("lemma" + str(n))]
  } else if n == "" {
    lemmaCnt.step()
    context [*Лемма #name* #label("lemman" + lemmaCnt.display())]
  } else {
    [*Лемма #n. (#name)* #label("lemma" + str(n))]
  }

  #descr
]

#let proof(data) = block(
  fill: gray.lighten(90%),
  width: 100%,
  radius: 4pt,
  inset: 8pt,
)[
  *Доказательство*

  #data

  #align(right)[*Ч.Т.Д.*]
]

#let hr = line(length: 100%, stroke: (dash: "dashed", paint: gray))
#let brown = rgb("#7f3e09")
