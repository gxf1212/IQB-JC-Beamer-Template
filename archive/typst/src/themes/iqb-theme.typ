// ============================================================
// IQB 课题组自定义 Touying 主题
// 基于 University 主题，优化 header 横幅和中文支持
// ============================================================

#import "@preview/touying:0.6.1": *
#import themes.university: *

// ============================================================
// IQB 主题函数
// ============================================================
#let iqb-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  // 使用 University 主题作为基础
  show: university-theme.with(aspect-ratio: aspect-ratio, ..args)

  // 页面尺寸配置
  set page(
    width: 13cm,
    height: 7cm,
    margin: (
      top: 1.2cm,
      bottom: 1cm,
      left: 0.5cm,
      right: 0.5cm,
    ),
  )

  // 中文字体配置（降级列表）
  set text(
    font: (
      "Source Han Sans SC",
      "Noto Sans CJK SC",
      "WenQuanYi Micro Hei",
      "SimHei",
      "PingFang SC",
      "Microsoft YaHei",
    ),
    size: 11pt,
    lang: "zh",
  )

  // 段落设置
  set par(justify: true, leading: 0.8em)

  // 列表设置
  set list(marker: ([•], [‣], [⁃]))
  set enum(numbering: "1.a.i.")

  body
}

// ============================================================
// Header 组件（在每个 slide 开始处手动调用）
// ============================================================
#let iqb-header() = {
  place(
    top + left,
    float: true,   // 相对于整个页面定位，而非当前列
    dx: -0.5cm,    // 抵消左 margin，从页面边缘开始
    dy: -1.0cm,    // 向上移动到 top margin 区域
    image("/assets/images/header.png", width: 13cm, height: 0.8cm, fit: "stretch")
  )
}

//================================================
// Footer 组件（在每个 slide 开始处手动调用）
// ============================================================
#let iqb-footer(section: none) = {
  place(
    bottom + left,
    float: true,   // 相对于整个页面定位，而非当前列
    dx: -0.5cm,    // 抵消左 margin，从页面边缘开始
    dy: 0.7cm,     // 向下移动到 bottom margin 区域
    box(
      width: 13cm,
      inset: (left: 0.5cm, right: 0.5cm, top: 0.1cm, bottom: 0.1cm),
      [
        #set text(size: 10pt, fill: gray.darken(30%))
        #set align(horizon)
        #grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          gutter: 0.5cm,
          [IQB Lab],
          if section != none [
            #text(weight: "bold", fill: rgb("#003366"))[#section]
          ],
          context [#counter(page).display("1 / 1", both: true)],
        )
      ]
    )
  )
}

// ============================================================
// 主题配置辅助函数
// ============================================================

// 配置 IQB 主题色
#let iqb-colors = (
  primary: rgb("#003366"),      // IQB 深蓝色
  secondary: rgb("#336699"),    // IQB 浅蓝色
  accent: rgb("#0066CC"),       // 强调色
)

// 导出主题
#let iqb-theme-config(
  title: [Presentation Title],
  subtitle: none,
  author: [Author Name],
  date: datetime.today(),
  institution: [IQB Lab],
) = {
  iqb-theme.with(
    aspect-ratio: "16-9",
    config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      date: date,
      institution: institution,
    ),
    config-colors(
      primary: iqb-colors.primary,
      secondary: iqb-colors.secondary,
    ),
  )
}
