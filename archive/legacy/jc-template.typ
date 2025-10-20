// ============================================================
// IQB 课题组 Journal Club 模板
// 基于 Touying 0.6.1
// ============================================================

#import "@preview/touying:0.6.1": *
#import themes.university: *

// ============================================================
// 主题配置
// ============================================================
#show: university-theme.with(
  aspect-ratio: "16-9",  // 使用标准 16:9，稍后自定义页面尺寸
  config-info(
    title: [Regina: Rigorously Predicting Protein-Ligand Dynamics],
    subtitle: [Journal Club Presentation],
    author: [高旭帆],
    date: datetime(year: 2025, month: 10, day: 19),
    institution: [IQB Lab],
    logo: image("header.png", width: 3cm),
  ),
)

// 自定义页面尺寸为 13cm × 7cm（匹配历史 JC）
#set page(width: 13cm, height: 7cm)

// ============================================================
// 全局样式设置
// ============================================================
#set text(
  size: 20pt,
  lang: "zh",
)

#set par(justify: true)

// ============================================================
// 封面页
// ============================================================
#title-slide()

// ============================================================
// 目录页（可选）
// ============================================================
#slide[
  = Outline
  #components.adaptive-columns(outline(title: none, indent: 1em))
]

// ============================================================
// 第 1 部分：Introduction
// ============================================================

= Introduction

== Authors

#slide[
  = Introduction
  == Authors

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.5em,

    // 作者 1
    align(center)[
      #box(
        width: 3.5cm,
        height: 3.5cm,
        fill: gray.lighten(80%),
        [Author 1 Photo]
      )

      *Dr. Alice Smith* \
      MIT CSAIL \
      #link("mailto:alice@mit.edu")
    ],

    // 作者 2
    align(center)[
      #box(
        width: 3.5cm,
        height: 3.5cm,
        fill: gray.lighten(80%),
        [Author 2 Photo]
      )

      *Dr. Bob Johnson* \
      Stanford AI Lab \
      #link("mailto:bob@stanford.edu")
    ],

    // 期刊信息
    align(center)[
      #box(
        width: 3.5cm,
        height: 3.5cm,
        fill: blue.lighten(90%),
        align(center + horizon)[
          *Nature* \
          2025
        ]
      )

      #link("https://doi.org/xxx")
    ],
  )
]

== Overview

#slide[
  = Introduction
  == Overview

  #place(
    dx: 6cm, dy: 0cm,
    box(
      width: 6cm, height: 7cm,
      fill: blue.lighten(90%),
      align(center + horizon)[
        *Right Side* \
        Full Height Image
      ]
    )
  )

  #place(
    dx: 0cm, dy: 1cm,
    box(
      width: 5cm, height: 2cm,
      fill: green.lighten(90%),
      align(center + horizon)[Feature 1]
    )
  )

  #place(
    dx: 0cm, dy: 4cm,
    box(
      width: 6cm, height: 2cm,
      fill: orange.lighten(90%),
      align(center + horizon)[Feature 2]
    )
  )

  #place(
    dx: 0cm, dy: 6.2cm,
    text(16pt)[
      Comparable accuracy with state-of-the-art methods.
    ]
  )
]

// ============================================================
// 第 2 部分：Methods
// ============================================================

= Methods

== Dataset

#slide(composer: (1fr, 1fr))[
  = Methods
  == Dataset

  #box(
    width: 100%, height: 5cm,
    fill: purple.lighten(90%),
    align(center + horizon)[
      *Training Data* \
      10,000 samples
    ]
  )

  *Key Features:*
  - High quality annotations
  - Diverse protein families
  - Experimental validation
][
  #box(
    width: 100%, height: 5cm,
    fill: yellow.lighten(90%),
    align(center + horizon)[
      *Test Data* \
      2,000 samples
    ]
  )

  *Evaluation:*
  - RMSD < 2.0 Å
  - Pearson R > 0.85
]

== Architecture

#slide[
  = Methods
  == Architecture

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.5em,

    box(
      width: 100%, height: 5cm,
      fill: red.lighten(90%),
      align(center + horizon)[
        *Encoder* \
        Transformer
      ]
    ),

    box(
      width: 100%, height: 5cm,
      fill: green.lighten(90%),
      align(center + horizon)[
        *Processor* \
        PairFormer
      ]
    ),

    box(
      width: 100%, height: 5cm,
      fill: blue.lighten(90%),
      align(center + horizon)[
        *Decoder* \
        Diffusion
      ]
    ),
  )
]

// ============================================================
// 第 3 部分：Results
// ============================================================

= Results

== Benchmark

#slide[
  = Results
  == Benchmark Comparison

  // 左上小图
  #place(dx: 0cm, dy: 1cm,
    box(width: 3cm, height: 3cm, fill: teal.lighten(90%),
      align(center + horizon)[Method A]
    )
  )

  // 左下图例
  #place(dx: 0cm, dy: 5cm,
    box(width: 3cm, height: 1cm, fill: gray.lighten(90%),
      align(center + horizon)[Legend]
    )
  )

  // 中间大图
  #place(dx: 3cm, dy: 1cm,
    box(width: 5cm, height: 6cm, fill: orange.lighten(90%),
      align(center + horizon)[
        *Main Results* \
        Comparison Chart
      ]
    )
  )

  // 右侧图
  #place(dx: 8cm, dy: 1cm,
    box(width: 4cm, height: 6cm, fill: purple.lighten(90%),
      align(center + horizon)[
        *Ours* \
        SOTA Performance
      ]
    )
  )
]

== Ablation Study

#slide[
  = Results
  == Ablation Study

  #align(center)[
    #box(
      width: 12cm, height: 3cm,
      fill: blue.lighten(90%),
      align(center + horizon)[
        *Full Model Performance* \
        Wide Table or Chart
      ]
    )
  ]

  #v(1em)

  *Key Findings:*
  - Component A contributes 15% improvement
  - Component B is essential for stability
  - Combined effect is synergistic
]

// ============================================================
// 第 4 部分：Summary
// ============================================================

= Summary

== Take-home Messages

#slide[
  = Summary
  == Take-home Messages & Thoughts

  *Main Contributions:*

  - Novel architecture achieving SOTA performance
  - Efficient training with limited data
  - Generalizable to unseen protein families

  #pause

  *Limitations:*

  - Computational cost remains high
  - Limited to certain protein sizes
  - Requires further experimental validation

  #pause

  *Future Directions:*

  - Extension to other biomolecules
  - Integration with experimental workflows
]

// ============================================================
// 结束页
// ============================================================

#slide[
  #align(center + horizon)[
    #text(66pt, weight: "bold")[
      Thanks for listening!
    ]

    #v(2em)

    #text(24pt)[
      Questions?
    ]
  ]
]
