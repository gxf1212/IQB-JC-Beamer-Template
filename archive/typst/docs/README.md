# IQB JC Touying 模板

基于 Touying 的 Journal Club 文献汇报幻灯片模板，专为 IQB 课题组设计。

## 🎯 项目简介

本项目提供了一套完整的 Typst/Touying 幻灯片模板，用于课题组的文献汇报（Journal Club）。基于对历史 56 页 JC 幻灯片的深度分析，实现了所有常用布局模式。

### 核心优势

- ✅ **纯文本编辑**：`.typ` 格式，完美支持版本控制和 LLM 辅助生成
- ✅ **精确布局控制**：像素级定位，支持复杂的不规则布局
- ✅ **快速编译**：秒级生成 PDF，增量编译
- ✅ **现代语法**：比 LaTeX Beamer 简洁 10 倍
- ✅ **丰富功能**：动画、演讲者备注、数学公式动画

## 📁 项目结构

```
IQB-JC-master/
├── jc-template.typ              # 主模板文件（完整示例）
├── templates/
│   └── layout-snippets.typ      # 常用布局代码片段库
├── images/                      # 图片资源目录
│   └── header.png              # IQB Logo
├── examples/                    # 示例文件
├── output/                      # 生成的 PDF 输出
│   └── jc-template.pdf         # 编译后的示例 PDF
├── JC_layout_requirements.md    # 布局需求分析报告
├── Touying_vs_Polylux_JC_Analysis.md  # 框架对比分析
└── README.md                    # 本文件
```

## 🚀 快速开始

### 1. 安装 Typst

```bash
# Ubuntu/Debian (推荐 snap)
sudo snap install typst

# 或使用 cargo
cargo install typst-cli

# macOS
brew install typst

# Windows
winget install --id Typst.Typst
```

### 2. 验证安装

```bash
typst --version
# 输出：typst 0.13.1 (或更高版本)
```

### 3. 编译模板

```bash
# 编译主模板
typst compile jc-template.typ output/jc-template.pdf

# 或使用 watch 模式（自动重新编译）
typst watch jc-template.typ output/jc-template.pdf
```

### 4. 查看 PDF

```bash
# Linux
xdg-open output/jc-template.pdf

# macOS
open output/jc-template.pdf

# Windows
start output/jc-template.pdf
```

## 📖 使用指南

### 基础模板结构

```typst
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [你的文献标题],
    author: [你的名字],
    date: datetime.today(),
    institution: [IQB Lab],
    logo: image("header.png", width: 3cm),
  ),
)

#set page(width: 13cm, height: 7cm)  // 自定义尺寸

= Introduction

== First Slide

内容...
```

### 常用布局示例

#### 1. 双列布局（最常用：35%）

```typst
#slide(composer: (1fr, 1fr))[
  // 左列
  #image("figure1.png", width: 100%)
  *Key Points:*
  - Point 1
  - Point 2
][
  // 右列
  #image("figure2.png", width: 100%)
  Additional text.
]
```

#### 2. 三列布局（25%）

```typst
#slide[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.5em,
    align(center)[Author 1],
    align(center)[Author 2],
    align(center)[Journal],
  )
]
```

#### 3. 精确定位（不规则布局：40%）

```typst
#slide[
  // 右侧全高图
  #place(dx: 6cm, dy: 0cm,
    image("right.png", width: 6cm, height: 7cm)
  )

  // 左上图
  #place(dx: 0cm, dy: 1cm,
    image("left_top.png", width: 5cm, height: 2cm)
  )

  // 左下图
  #place(dx: 0cm, dy: 4cm,
    image("left_bottom.png", width: 5cm, height: 2cm)
  )
]
```

#### 4. 四图不规则布局

```typst
#slide[
  #place(dx: 0cm, dy: 1cm,
    image("small.png", width: 3cm, height: 3cm)
  )

  #place(dx: 3cm, dy: 1cm,
    image("main.png", width: 5cm, height: 6cm)
  )

  #place(dx: 8cm, dy: 1cm,
    image("right.png", width: 4cm, height: 6cm)
  )
]
```

### 更多布局

完整的布局代码片段库请参考 `templates/layout-snippets.typ`，包含：

- ✅ 双列布局（3种变体）
- ✅ 三列布局（等宽/不等宽）
- ✅ 四图不规则布局（2种模式）
- ✅ 单张全宽图 + 文字
- ✅ 纯文本页
- ✅ 表格布局
- ✅ 数学公式动画
- ✅ 分步展示
- ✅ 背景色块
- ✅ 图文环绕

## 🎨 自定义配置

### 修改主题

Touying 提供多个官方主题：

```typst
// University 主题（学术风格，推荐）
#import themes.university: *
#show: university-theme.with(...)

// Simple 主题（极简风格）
#import themes.simple: *
#show: simple-theme.with(...)

// Metropolis 主题（现代风格）
#import themes.metropolis: *
#show: metropolis-theme.with(...)
```

### 修改颜色

```typst
#let primary-color = rgb("#003366")  // IQB 主题色

#show: university-theme.with(
  config-colors(
    primary: primary-color,
    secondary: rgb("#336699"),
  ),
  ...
)
```

### 修改字体

```typst
#set text(
  font: ("Source Han Sans SC", "Noto Serif CJK SC"),
  size: 20pt,
)
```

## 🔧 进阶功能

### 1. 动画效果

```typst
#slide[
  First point

  #pause

  Second point (appears on click)

  #meanwhile

  Third point (appears with second)
]
```

### 2. 数学公式动画

```typst
$
  f(x) &= pause x^2 + 2x + 1 \
  &= pause (x + 1)^2 \
$
```

### 3. 演讲者备注

```typst
#slide[
  Main content...

  #speaker-note[
    This is a note only for the speaker.
  ]
]
```

### 4. 导出其他格式

```bash
# 导出 PPTX（需要 touying-exporter）
touying-exporter jc-template.typ --format pptx

# 导出 HTML
touying-exporter jc-template.typ --format html
```

## 📐 尺寸参考

基于 13cm × 7cm 页面：

| 位置 | dx 值 | dy 值 |
|------|-------|-------|
| 左上角 | 0cm | 0cm |
| 中上 | 6.5cm | 0cm |
| 右上角 | ~10cm | 0cm |
| 左中 | 0cm | 3.5cm |
| 中心 | 6.5cm | 3.5cm |
| 左下角 | 0cm | ~6cm |

| 尺寸 | width | height |
|------|-------|--------|
| 全宽 | 13cm | - |
| 半宽 | 6cm | - |
| 1/3宽 | 4cm | - |
| 全高 | - | 7cm |
| 半高 | - | 3.5cm |

## 💡 使用技巧

### 1. 快速开发工作流

```bash
# 终端 1：自动编译
typst watch jc-template.typ output/jc-template.pdf

# 终端 2：实时预览 PDF（自动刷新）
evince output/jc-template.pdf  # Linux
# 或使用其他支持自动刷新的 PDF 阅读器
```

### 2. 多文件组织

```typst
// jc-template.typ
#import "config.typ": *
#include "content/introduction.typ"
#include "content/methods.typ"
#include "content/results.typ"
```

### 3. 使用 LLM 辅助生成

**提示词示例**：

```
请用 Touying 生成一个双列布局的幻灯片：
- 左侧：显示蛋白质结构图 protein.png
- 右侧：列出 3 个关键特征
- 页面尺寸：13cm × 7cm
```

LLM 会生成：

```typst
#slide(composer: (1fr, 1fr))[
  #image("protein.png", width: 100%)
][
  *Key Features:*
  - Active site configuration
  - Ligand binding mode
  - Key interactions
]
```

## 📚 参考资源

### 官方文档

- [Touying 官方文档](https://touying-typ.github.io/)
- [Typst 官方文档](https://typst.app/docs/)
- [Touying GitHub](https://github.com/touying-typ/touying)

### 本项目文档

- `JC_layout_requirements.md` - 基于 56 页历史 JC 的布局需求分析
- `Touying_vs_Polylux_JC_Analysis.md` - Touying vs Polylux 详细对比
- `templates/layout-snippets.typ` - 12 种常用布局代码片段

### 社区资源

- [Touying Gallery](https://github.com/touying-typ/touying/wiki/Gallery) - 用户作品展示
- [Typst Universe](https://typst.app/universe/) - 更多主题和包

## ❓ 常见问题

### Q1: 编译时出现字体警告？

A: 这是正常现象，Touying 会使用系统默认字体。如需指定字体：

```typst
#set text(font: "你的字体名称")
```

### Q2: 如何调整页面尺寸？

A: 使用 `#set page(width: ..., height: ...)`：

```typst
#set page(width: 13cm, height: 7cm)
```

### Q3: 图片路径怎么写？

A: 相对于 `.typ` 文件的路径：

```typst
#image("images/figure1.png")      // 正确
#image("/absolute/path/fig.png")  // 也可以用绝对路径
```

### Q4: 如何生成演讲者备注的双屏模式？

A: 在主题配置中添加：

```typst
#show: university-theme.with(
  config-common(show-notes-on-second-screen: right),
  ...
)
```

### Q5: 警告 "layout did not converge" 怎么办？

A: 这通常可以忽略，不影响最终 PDF。如果确实需要解决，检查是否有循环依赖的 `place()` 或 `query()`。

## 🔄 版本历史

- **v1.0.0** (2025-10-19)
  - ✅ 初始版本
  - ✅ 基于 Touying 0.6.1
  - ✅ 支持所有常用 JC 布局（基于 56 页历史分析）
  - ✅ 完整的代码片段库
  - ✅ 详细的使用文档

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

如果你创建了新的布局或主题，请考虑分享到 `examples/` 目录。

## 📄 许可证

本项目基于 MIT 许可证开源。

Touying 包版权归其原作者所有。

## 👥 致谢

- Touying 开发团队
- IQB 课题组成员
- Claude Code 辅助开发

---

**生成时间**: 2025.10.19
**维护者**: IQB Lab
**Typst 版本**: 0.13.1+
**Touying 版本**: 0.6.1
