// ============================================================
// 封面页组件
// ============================================================

#import "@preview/touying:0.6.1": *

/// 标准 JC 封面页
///
/// 参数：
/// - title: 文献标题
/// - subtitle: 副标题（可选）
/// - author: 汇报人
/// - date: 日期
/// - institution: 机构名称
///
/// 返回：封面页幻灯片
#let jc-cover(
  title: [Presentation Title],
  subtitle: none,
  author: [Author Name],
  date: datetime.today(),
  institution: [IQB Lab],
) = {
  slide[
    #set align(center + horizon)
    #block(
      width: 90%,
      inset: 2em,
      [
        // 标题
        #text(size: 24pt, weight: "bold", fill: rgb("#003366"))[
          #title
        ]

        // 副标题
        #if subtitle != none [
          #v(0.5em)
          #text(size: 18pt, fill: gray.darken(20%))[
            #subtitle
          ]
        ]

        #v(2em)

        // 分隔线
        #line(length: 80%, stroke: 2pt + gray)

        #v(1.5em)

        // 汇报人信息
        #text(size: 15pt)[
          *Reporter:* #author \
          *Date:* #date.display("[year].[month].[day]") \
          *Institution:* #institution
        ]
      ]
    )
  ]
}

/// 简化封面页（仅标题和汇报人）
#let jc-cover-simple(
  title: [Presentation Title],
  author: [Author Name],
  date: datetime.today(),
) = {
  slide[
    #set align(center + horizon)

    #text(size: 36pt, weight: "bold", fill: rgb("#003366"))[
      #title
    ]

    #v(3em)

    #text(size: 22pt)[
      #author \
      #date.display("[year].[month].[day]")
    ]
  ]
}
