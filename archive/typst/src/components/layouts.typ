// ============================================================
// 布局组件（基于历史 JC 的常用布局分析）
// ============================================================

#import "@preview/touying:0.6.1": *
#import "../themes/iqb-theme.typ": iqb-header, iqb-footer

/// 双列布局（35% 的 JC 页面使用）
///
/// 参数：
/// - left: 左列内容
/// - right: 右列内容
/// - ratio: 列宽比例（默认 1:1）
/// - gutter: 列间距
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
///
/// 返回：双列布局幻灯片
#let jc-two-column(
  left,
  right,
  ratio: (1fr, 1fr),
  gutter: 1em,
  section: none,
  subsection: none,
) = {
  slide(composer: ratio)[
    #iqb-header()
    #iqb-footer(section: section)

    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    #left
  ][
    #right
  ]
}

/// 三列布局（25% 的 JC 页面使用）
///
/// 参数：
/// - col1, col2, col3: 三列内容
/// - ratio: 列宽比例（默认 1:1:1）
/// - gutter: 列间距
///
/// 返回：三列布局幻灯片
#let jc-three-column(
  col1,
  col2,
  col3,
  ratio: (1fr, 1fr, 1fr),
  gutter: 0.5em,
  section: none,
  subsection: none,
) = {
  slide[
    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    #grid(
      columns: ratio,
      gutter: gutter,
      col1,
      col2,
      col3,
    )
  ]
}

/// 四图不规则布局（10% 的 JC 页面使用）
///
/// 模式：左上小图 + 中间大图 + 右侧图 + 左下图例
///
/// 参数：
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
/// - small: 左上小图
/// - main: 中间大图
/// - right: 右侧图
/// - legend: 左下图例（可选）
///
/// 返回：四图布局幻灯片
#let jc-four-images-layout(
  section: none,
  subsection: none,
  small,
  main,
  right,
  legend: none,
) = {
  slide[
    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    // 左上小图
    #place(dx: 0cm, dy: 1cm, small)

    // 左下图例
    #if legend != none [
      #place(dx: 0cm, dy: 5cm, legend)
    ]

    // 中间大图
    #place(dx: 3cm, dy: 1cm, main)

    // 右侧图
    #place(dx: 8cm, dy: 1cm, right)
  ]
}

/// 左侧两图 + 右侧全高图（常见模式）
///
/// 参数：
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
/// - left-top: 左上图
/// - left-bottom: 左下图
/// - right-full: 右侧全高图
/// - caption: 底部说明文字（可选）
///
/// 返回：特殊布局幻灯片
#let jc-left-two-right-full(
  section: none,
  subsection: none,
  left-top,
  left-bottom,
  right-full,
  caption: none,
) = {
  slide[
    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    // 右侧全高图
    #place(dx: 6cm, dy: 0cm, right-full)

    // 左上图
    #place(dx: 0cm, dy: 1cm, left-top)

    // 左下图
    #place(dx: 0cm, dy: 4cm, left-bottom)

    // 底部说明
    #if caption != none [
      #place(dx: 0cm, dy: 6.2cm, text(16pt)[#caption])
    ]
  ]
}

/// 单图全宽布局
///
/// 参数：
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
/// - image-content: 图片内容
/// - caption: 图片说明
/// - width: 图片宽度（默认 12cm）
/// - height: 图片高度（默认 3cm）
///
/// 返回：单图布局幻灯片
#let jc-single-wide-image(
  section: none,
  subsection: none,
  image-content,
  caption: none,
  width: 12cm,
  height: 3cm,
) = {
  slide[
    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    #align(center)[
      #box(width: width, height: height, image-content)
    ]

    #if caption != none [
      #v(0.5em)
      #text(16pt)[#caption]
    ]
  ]
}

/// 2x2 网格布局（四图均等）
///
/// 参数：
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
/// - img1, img2, img3, img4: 四张图片
/// - gutter: 间距
///
/// 返回：2x2 网格布局幻灯片
#let jc-grid-2x2(
  section: none,
  subsection: none,
  img1,
  img2,
  img3,
  img4,
  gutter: 0.5em,
) = {
  slide[
    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    #grid(
      columns: (1fr, 1fr),
      rows: (1fr, 1fr),
      gutter: gutter,
      img1,
      img2,
      img3,
      img4,
    )
  ]
}

/// 纯文本页（总结/方法描述等）
///
/// 参数：
/// - section: 章节标题（可选）
/// - subsection: 小节标题（可选）
/// - content: 文本内容
///
/// 返回：纯文本布局幻灯片
#let jc-text-only(
  section: none,
  subsection: none,
  content,
) = {
  slide[
    #iqb-header()
    #iqb-footer(section: section)

    #if section != none [ = #section ]
    #if subsection != none [ == #subsection ]

    #content
  ]
}
