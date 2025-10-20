// ============================================================
// 致谢/结束页组件
// ============================================================

#import "@preview/touying:0.6.1": *

/// 标准致谢页
///
/// 参数：
/// - message: 致谢文字（默认 "Thanks for listening!"）
/// - decoration: 装饰图片（可选）
/// - question-text: "Questions?" 文字（默认显示）
///
/// 返回：致谢页幻灯片
#let jc-closing(
  message: [Thanks for listening!],
  decoration: none,
  question-text: [Questions?],
  show-questions: true,
) = {
  slide[
    #set align(center + horizon)

    // 主要致谢文字
    #text(size: 36pt, weight: "bold", fill: rgb("#003366"))[
      #message
    ]

    #v(2em)

    // 装饰图片
    #if decoration != none [
      #image(decoration, width: 6cm)
      #v(1em)
    ] else [
      // 默认装饰元素
      #text(size: 48pt, fill: gradient.linear(
        rgb("#003366"),
        rgb("#0066CC"),
      ))[
        ✨
      ]
      #v(1em)
    ]

    // Questions 文字
    #if show-questions [
      #text(size: 20pt, fill: gray.darken(20%))[
        #question-text
      ]
    ]
  ]
}

/// 简化致谢页（仅文字）
#let jc-closing-simple(
  message: [Thanks for listening!],
) = {
  slide[
    #set align(center + horizon)

    #text(size: 66pt, weight: "bold", fill: rgb("#003366"))[
      #message
    ]
  ]
}

/// 带联系信息的致谢页
///
/// 参数：
/// - message: 致谢文字
/// - email: 邮箱地址（可选）
/// - github: GitHub 用户名（可选）
/// - website: 个人网站（可选）
///
/// 返回：带联系信息的致谢页幻灯片
#let jc-closing-with-contact(
  message: [Thanks for listening!],
  email: none,
  github: none,
  website: none,
) = {
  slide[
    #set align(center + horizon)

    // 主要致谢文字
    #text(size: 56pt, weight: "bold", fill: rgb("#003366"))[
      #message
    ]

    #v(3em)

    // 联系信息
    #grid(
      columns: 1,
      row-gutter: 0.5em,

      if email != none [
        #text(size: 18pt, fill: blue)[
          📧 #link("mailto:" + email)[#email]
        ]
      ],

      if github != none [
        #text(size: 18pt, fill: blue)[
          💻 #link("https://github.com/" + github)[@#github]
        ]
      ],

      if website != none [
        #text(size: 18pt, fill: blue)[
          🌐 #link(website)[#website]
        ]
      ],
    )
  ]
}

/// 总结页（带要点列表）
///
/// 参数：
/// - title: 总结标题（默认 "Summary"）
/// - points: 要点列表
///
/// 返回：总结页幻灯片
#let jc-summary(
  title: [Summary],
  points,
) = {
  slide[
    = #title

    #v(1em)

    #set text(size: 18pt)
    #set list(marker: [▸], spacing: 1.2em)

    #points
  ]
}
