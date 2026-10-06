#import "@preview/ilm:1.4.1": *
#import "def.typ": *
// #import "@preview/codly:1.3.0": *
// #import "@preview/codly-languages:0.1.1": *

#set text(lang: "en")

#set heading(numbering: "1")
#show heading: it => [
Q#counter(heading).display() #it.body
]


#show link: it => text(blue, it)
#show math.equation: set text(font: ("Concrete Math"))
#show raw: set text(font: ("JetBrains Mono"))

#let snip(cap, body) = figure(caption: cap)[
  #body
]

#let def(name, description) = [
  #blockquote[*#name* --- #description]
]

#import "barcala/lib.typ": apendice, informe, nomenclatura
#import "@preview/fancy-units:0.1.1": fancy-units-configure, unit // Paquete para unidades de medida, puede ser omitido
#import "@preview/lilaq:0.2.0" as lq // Paquete para gráficos, puede ser omitido
#import "@preview/physica:0.9.5": * // Paquete para matemática y física, puede ser omitido


#show: informe.with(
  unidad-academica: "hsse",
  asignatura: "Dev Tools",
  titulo: "Final exam",
  equipo: "HSSE MIPT 2026",
  autores: (
    (
      nombre: "Kalinin, Iwan",
      email: "kalinin.is@phystech.edu",
    ),
  ),

  titulo-descriptivo: "Программа зачета",
  // resumen: [*.*],

  fecha: datetime.today(),
)


#show raw.where(block: false): box.with(
  fill: rgb("#e0ffde"),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): set block(fill:rgb("#faffec"), inset: 1em, radius: 0.5em)

// #let questions = ()

#let questions = state("questions", ())

#let newq(topic, descr) = {
  questions.update(qs => qs + ((
    topic,
    descr,
  ),))
}

#let reg_topic(name, qs) = {
  let i = 0
  let topic = qs.map(el => (topic_num, q_num) => {
    [
      Вопрос #topic_num\-#q_num. Тема: #name.

      #el
    ]
  })

  questions.update(qs => qs + ((name, topic),))
}

#let br(text) = {

  questions.update(qs => qs + ((
    [],
    [#align(center)[ #line(length: 95%, stroke: (dash: "densely-dotted", paint: red, thickness: 4pt))]],
  ),))
}

/////////////////////////////////////////////////////////////////////////
#import "linux-fs.typ": linux_fs_qs
#reg_topic("Linux. FS", linux_fs_qs)

#import "git.typ": git_qs
#reg_topic("Git", git_qs)

#import "shell.typ": shell_qs
#reg_topic("Linux. Shell", shell_qs)

#import "utils.typ": utils_qs
#reg_topic("Linux. Utils", utils_qs)

/////////////////////////////////////////////////////////////////////////
#context { 
  let qs = questions.final()

  for (i, qqs) in qs.enumerate() {
    for (j, q) in qqs.at(1).enumerate() {
      q(i, j)

      if j != qqs.at(1).len() - 1 {
        align(center)[ #line(length: 95%, stroke: (dash: "dashed", paint: gray))]
      }
    }

    if i != qs.len() - 1 {
      align(center)[ #line(length: 95%, stroke: (dash: "loosely-dotted", paint: rgb("#1882af"), thickness: 2pt))]
    }
  }

  align(center)[ #line(length: 95%, stroke: (dash: "dashed", paint: rgb("#ecf80a"), thickness: 2pt))]
  
  let q_tot = 0

  [
    #for data in qs {
      [
        #data.at(0) $->$ #data.at(1).len()

      ]
      q_tot += data.at(1).len()
    }

    
    *Total $=>$ #q_tot*
  ]
}
