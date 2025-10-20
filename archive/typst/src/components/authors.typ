// ============================================================
// 作者介绍页组件（三栏布局，不含 Journal 信息）
// ============================================================

#import "@preview/touying:0.6.1": *

/// 作者介绍页（双作者）
///
/// 参数：
/// - author1: 字典，包含 name, affiliation, photo, email
/// - author2: 字典，包含 name, affiliation, photo, email
/// - title: 页面标题（默认 "Authors"）
///
/// 返回：作者介绍页幻灯片
#let jc-authors-page(
  author1: (
    name: "Dr. Author One",
    affiliation: "Institution A",
    photo: none,
    email: none,
  ),
  author2: (
    name: "Dr. Author Two",
    affiliation: "Institution B",
    photo: none,
    email: none,
  ),
  title: [Authors],
) = {
  slide[
    = Introduction
    == #title

    #grid(
      columns: (1fr, 1fr),
      gutter: 1.5em,

      // 作者 1
      align(center)[
        // 照片或占位符
        #if author1.photo != none [
          #image(author1.photo, width: 4cm, height: 4cm, fit: "cover")
        ] else [
          #box(
            width: 4cm,
            height: 4cm,
            fill: gradient.radial(
              rgb("#E8F4F8"),
              rgb("#B8D4E0"),
              center: (30%, 30%),
            ),
            stroke: 1pt + gray,
            radius: 0.3cm,
            align(center + horizon)[
              #text(size: 48pt, fill: gray)[👤]
            ]
          )
        ]

        #v(0.5em)

        // 姓名
        #text(size: 15pt, weight: "bold")[
          #author1.name
        ]

        #v(0.3em)

        // 机构
        #text(size: 12pt, fill: gray.darken(20%))[
          #author1.affiliation
        ]

        // 邮箱
        #if author1.email != none [
          #v(0.2em)
          #text(size: 10pt, fill: blue)[
            #link("mailto:" + author1.email)[#author1.email]
          ]
        ]
      ],

      // 作者 2
      align(center)[
        // 照片或占位符
        #if author2.photo != none [
          #image(author2.photo, width: 4cm, height: 4cm, fit: "cover")
        ] else [
          #box(
            width: 4cm,
            height: 4cm,
            fill: gradient.radial(
              rgb("#F8E8F4"),
              rgb("#E0B8D4"),
              center: (30%, 30%),
            ),
            stroke: 1pt + gray,
            radius: 0.3cm,
            align(center + horizon)[
              #text(size: 48pt, fill: gray)[👤]
            ]
          )
        ]

        #v(0.5em)

        // 姓名
        #text(size: 15pt, weight: "bold")[
          #author2.name
        ]

        #v(0.3em)

        // 机构
        #text(size: 12pt, fill: gray.darken(20%))[
          #author2.affiliation
        ]

        // 邮箱
        #if author2.email != none [
          #v(0.2em)
          #text(size: 10pt, fill: blue)[
            #link("mailto:" + author2.email)[#author2.email]
          ]
        ]
      ],
    )
  ]
}

/// 作者介绍页（三作者版本）
#let jc-authors-page-three(
  author1: (:),
  author2: (:),
  author3: (:),
  title: [Authors],
) = {
  slide[
    = Introduction
    == #title

    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,

      // 作者 1
      align(center)[
        #if author1.photo != none [
          #image(author1.photo, width: 3.5cm, height: 3.5cm, fit: "cover")
        ] else [
          #box(
            width: 3.5cm,
            height: 3.5cm,
            fill: blue.lighten(90%),
            stroke: 1pt + gray,
            radius: 0.3cm,
            align(center + horizon)[
              #text(size: 36pt, fill: gray)[👤]
            ]
          )
        ]

        #v(0.3em)
        #text(size: 16pt, weight: "bold")[#author1.name]
        #v(0.2em)
        #text(size: 12pt, fill: gray.darken(20%))[#author1.affiliation]
      ],

      // 作者 2
      align(center)[
        #if author2.photo != none [
          #image(author2.photo, width: 3.5cm, height: 3.5cm, fit: "cover")
        ] else [
          #box(
            width: 3.5cm,
            height: 3.5cm,
            fill: green.lighten(90%),
            stroke: 1pt + gray,
            radius: 0.3cm,
            align(center + horizon)[
              #text(size: 36pt, fill: gray)[👤]
            ]
          )
        ]

        #v(0.3em)
        #text(size: 16pt, weight: "bold")[#author2.name]
        #v(0.2em)
        #text(size: 12pt, fill: gray.darken(20%))[#author2.affiliation]
      ],

      // 作者 3
      align(center)[
        #if author3.photo != none [
          #image(author3.photo, width: 3.5cm, height: 3.5cm, fit: "cover")
        ] else [
          #box(
            width: 3.5cm,
            height: 3.5cm,
            fill: purple.lighten(90%),
            stroke: 1pt + gray,
            radius: 0.3cm,
            align(center + horizon)[
              #text(size: 36pt, fill: gray)[👤]
            ]
          )
        ]

        #v(0.3em)
        #text(size: 16pt, weight: "bold")[#author3.name]
        #v(0.2em)
        #text(size: 12pt, fill: gray.darken(20%))[#author3.affiliation]
      ],
    )
  ]
}
