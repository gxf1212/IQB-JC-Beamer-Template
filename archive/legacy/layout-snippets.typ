// ============================================================
// IQB JC 常用布局代码片段库
// ============================================================

// ============================================================
// 1. 双列布局（35% 的页面使用）
// ============================================================

// 方式 1: 使用 composer（推荐，最简洁）
#slide(composer: (1fr, 1fr))[
  // 左列
  #image("figure1.png", width: 100%)

  *Key Points:*
  - Point 1
  - Point 2
][
  // 右列
  #image("figure2.png", width: 100%)

  Additional description text.
]

// 方式 2: 使用 grid
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,

    // 左列
    [
      #image("figure1.png", width: 100%)
      Description for left figure.
    ],

    // 右列
    [
      #image("figure2.png", width: 100%)
      Description for right figure.
    ]
  )
]

// 方式 3: 不等宽双列（1:2 比例）
#slide(composer: (1fr, 2fr))[
  // 窄列
  *Features:*
  - Feature A
  - Feature B
][
  // 宽列
  #image("large_figure.png", width: 100%)
]

// ============================================================
// 2. 三列布局（25% 的页面使用）
// ============================================================

// 等宽三列
#slide[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.5em,

    align(center)[
      #image("author1.png", width: 100%)
      *Author 1*
    ],

    align(center)[
      #image("author2.png", width: 100%)
      *Author 2*
    ],

    align(center)[
      #image("journal.png", width: 100%)
      *Journal*
    ],
  )
]

// 不等宽三列（2:3:2）
#slide(composer: (2fr, 3fr, 2fr))[
  // 左侧栏
  Sidebar content
][
  // 中间主要内容
  Main content with large figure
][
  // 右侧栏
  Additional notes
]

// ============================================================
// 3. 左侧两图垂直排列 + 右侧单图（常见模式）
// ============================================================

#slide[
  // 右侧大图（绝对定位）
  #place(
    dx: 6cm, dy: 0cm,
    image("right_full.png", width: 6cm, height: 7cm)
  )

  // 左上图
  #place(
    dx: 0cm, dy: 1cm,
    image("left_top.png", width: 5cm, height: 2cm)
  )

  // 左下图
  #place(
    dx: 0cm, dy: 4cm,
    image("left_bottom.png", width: 6cm, height: 2cm)
  )

  // 说明文字
  #place(
    dx: 0cm, dy: 6.2cm,
    text(16pt)[Description text at bottom left.]
  )
]

// ============================================================
// 4. 四图不规则布局（10% 的页面使用）
// ============================================================

// 模式 A: 小-大-大布局
#slide[
  // 左上小图
  #place(dx: 0cm, dy: 1cm,
    image("small.png", width: 3cm, height: 3cm)
  )

  // 左下图例
  #place(dx: 0cm, dy: 5cm,
    box(width: 3cm, height: 1cm,
      text(12pt)[Legend or caption]
    )
  )

  // 中间大图
  #place(dx: 3cm, dy: 1cm,
    image("main.png", width: 5cm, height: 6cm)
  )

  // 右侧图
  #place(dx: 8cm, dy: 1cm,
    image("right.png", width: 4cm, height: 6cm)
  )
]

// 模式 B: 2x2 网格
#slide[
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr, 1fr),
    gutter: 0.5em,

    image("fig1.png", width: 100%),
    image("fig2.png", width: 100%),
    image("fig3.png", width: 100%),
    image("fig4.png", width: 100%),
  )
]

// ============================================================
// 5. 单张全宽图 + 文字
// ============================================================

#slide[
  #align(center)[
    #image("wide_figure.png", width: 13cm, height: 3cm)
  ]

  #v(1em)

  *Key Findings:*
  - Finding 1: Detailed explanation
  - Finding 2: Additional insights
  - Finding 3: Statistical significance
]

// ============================================================
// 6. 纯文本页（总结、方法描述等）
// ============================================================

#slide[
  = Summary
  == Take-home Messages

  *Main Contributions:*

  - Contribution 1: Novel architecture
  - Contribution 2: Improved performance
  - Contribution 3: Broader applicability

  #pause

  *Limitations:*

  - Limitation 1: Computational cost
  - Limitation 2: Data requirements

  #pause

  *Future Work:*

  - Direction 1: Extension to other domains
  - Direction 2: Optimization for speed
]

// ============================================================
// 7. 精确定位技巧
// ============================================================

// 技巧 1: 绝对定位（像素级控制）
#slide[
  #place(
    dx: 2.5cm,      // 距离左边 2.5cm
    dy: 1.8cm,      // 距离顶部 1.8cm
    image("logo.png", width: 3cm)
  )
]

// 技巧 2: 相对对齐
#slide[
  #place(
    top + left,     // 左上角
    dx: 1cm,
    dy: 1cm,
    [Content]
  )

  #place(
    bottom + right, // 右下角
    dx: -1cm,
    dy: -1cm,
    [Footer]
  )
]

// 技巧 3: 居中对齐
#slide[
  #align(center + horizon)[
    #text(48pt, weight: "bold")[
      Centered Title
    ]
  ]
]

// ============================================================
// 8. 图片 + 文字环绕
// ============================================================

#slide(composer: (1fr, 1fr))[
  // 左侧图片
  #image("structure.png", width: 100%)

  #text(14pt)[Figure 1: Crystal structure]
][
  // 右侧文字
  *Analysis:*

  The structure shows:
  1. Active site configuration
  2. Ligand binding mode
  3. Key interactions

  #v(1em)

  #text(16pt)[
    RMSD = 1.2 Å \
    Pearson R = 0.92
  ]
]

// ============================================================
// 9. 背景色块 + 内容
// ============================================================

#slide[
  #box(
    width: 100%,
    height: 6cm,
    fill: blue.lighten(95%),
    inset: 1em,
    [
      #text(24pt, weight: "bold")[Important Note]

      #v(1em)

      This is highlighted content with:
      - Background color
      - Padding (inset)
      - Full width
    ]
  )
]

// ============================================================
// 10. 数学公式 + 动画
// ============================================================

#slide[
  = Methods
  == Mathematical Formulation

  The objective function is:

  $
    L(theta) &= pause sum_(i=1)^n ℓ(y_i, hat(y)_i) \
    &= pause sum_(i=1)^n (y_i - f(x_i; theta))^2 \
    &= pause "MSE Loss" \
  $

  #meanwhile

  Where #pause $theta$ represents model parameters.

  #pause

  We minimize this using gradient descent.
]

// ============================================================
// 11. 表格布局
// ============================================================

#slide[
  = Results
  == Performance Comparison

  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      align: center,
      [*Method*], [*RMSD (Å)*], [*Pearson R*], [*Time (s)*],
      [Method A], [2.1], [0.78], [120],
      [Method B], [1.5], [0.85], [180],
      [Ours], [*1.2*], [*0.92*], [*90*],
    )
  ]
]

// ============================================================
// 12. 分步展示（逐个显示元素）
// ============================================================

#slide[
  = Key Results

  #uncover("1-")[First point appears immediately]

  #uncover("2-")[Second point appears on click]

  #uncover("3-")[Third point appears on another click]

  #only("4-")[This only shows from slide 4 onwards]

  #alternatives[
    Old incorrect approach ✗
  ][
    New correct approach ✓
  ]
]

// ============================================================
// 使用说明
// ============================================================

/*
1. 复制需要的布局代码到你的 JC 文件中
2. 替换占位图片路径（如 "figure1.png"）为实际图片
3. 修改文字内容
4. 调整尺寸参数（width, height, dx, dy）

常用尺寸参考（基于 13cm × 7cm）:
- 全宽图: width: 13cm
- 半宽图: width: 6cm
- 三分之一宽: width: 4cm
- 全高图: height: 7cm
- 半高图: height: 3.5cm

精确定位参考（13cm × 7cm）:
- 左侧: dx: 0cm
- 中间: dx: 6.5cm
- 右侧: dx: 8cm
- 顶部: dy: 0cm
- 中间: dy: 3.5cm
- 底部: dy: 6cm
*/
