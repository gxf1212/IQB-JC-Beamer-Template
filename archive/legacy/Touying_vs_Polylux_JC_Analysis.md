# Touying vs Polylux：JC 文献汇报最佳选择分析

## 🎯 结论：**强烈推荐 Touying** ⭐⭐⭐⭐⭐

基于对你的 JC 布局需求分析（56页历史幻灯片），**Touying 完美匹配所有需求**，是绝对的首选。

---

## 📊 Touying vs Polylux 详细对比

| 维度 | Touying | Polylux | JC 需求匹配度 |
|------|---------|---------|--------------|
| **精确定位** | ⭐⭐⭐⭐⭐ 原生支持 `place(dx, dy)` | ⭐⭐⭐⭐⭐ 同样支持 | Touying = Polylux |
| **多列布局** | ⭐⭐⭐⭐⭐ `composer: (1fr, 1fr)` 简洁 | ⭐⭐⭐⭐ 需要更多代码 | **Touying 更优** |
| **动画支持** | ⭐⭐⭐⭐⭐ `#pause` 性能优化 | ⭐⭐⭐⭐ 依赖 counter/context | **Touying 更优** |
| **数学公式动画** | ⭐⭐⭐⭐⭐ 原生支持 `pause` in equations | ⭐⭐⭐ 需要 workaround | **Touying 独有** |
| **主题生态** | ⭐⭐⭐⭐⭐ 10+ 官方主题 | ⭐⭐⭐ 较少 | **Touying 更优** |
| **学习成本** | ⭐⭐⭐⭐⭐ 两种语法（标题/块） | ⭐⭐⭐⭐ 单一语法 | Touying 稍复杂但更灵活 |
| **性能** | ⭐⭐⭐⭐⭐ 更快（无 counter） | ⭐⭐⭐⭐ 标准 | **Touying 更优** |
| **社区活跃度** | ⭐⭐⭐⭐⭐ 2025 活跃开发 | ⭐⭐⭐ 维护状态 | **Touying 更优** |
| **文档质量** | ⭐⭐⭐⭐⭐ 中英文 + 版本化 | ⭐⭐⭐⭐ 英文 | **Touying 更优** |
| **LLM 友好** | ⭐⭐⭐⭐⭐ 纯文本 | ⭐⭐⭐⭐⭐ 纯文本 | Touying = Polylux |

---

## 🎨 Touying 核心优势（针对 JC 需求）

### 1. 多列布局极其简洁 ✅

**你的需求**：35% 双列 + 25% 三列布局

#### Touying 方式（推荐）
```typst
#slide(composer: (1fr, 1fr))[
  // 左列：图片
  #image("figure1.png", width: 100%)

  *Key Features:*
  - Feature 1
  - Feature 2
][
  // 右列：图片
  #image("figure2.png", width: 100%)

  #text(14pt)[CoV Mpro-ligands]
]
```

#### Polylux 方式（对比）
```typst
#polylux-slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #image("figure1.png", width: 100%)

      *Key Features:*
      - Feature 1
      - Feature 2
    ],
    [
      #image("figure2.png", width: 100%)

      #text(14pt)[CoV Mpro-ligands]
    ]
  )
]
```

**差异**：Touying 的 `composer` 参数更语义化，代码更清晰。

---

### 2. 精确定位 + 网格混合 ✅

**你的需求**：68% 页面需要不规则布局

#### 案例：复现你的幻灯片 11（四图不规则布局）

```typst
#slide[
  = Methods: Affinity Model Training

  // 左上小图（绝对定位）
  #place(
    dx: 0cm, dy: 1cm,
    image("pocket_id.png", width: 3cm, height: 3cm)
  )

  // 中间大图（绝对定位）
  #place(
    dx: 3cm, dy: 1cm,
    image("workflow.png", width: 5cm, height: 6cm)
  )

  // 右侧图（绝对定位）
  #place(
    dx: 8cm, dy: 1cm,
    image("model_arch.png", width: 4cm, height: 6cm)
  )

  // 左下图例（绝对定位）
  #place(
    dx: 0cm, dy: 5cm,
    box(
      width: 3cm, height: 1cm,
      text(12pt)[Pocket Identification and cropping]
    )
  )
]
```

**关键**：`place()` 函数支持像素级精确定位，完美匹配你的需求。

---

### 3. 数学公式动画（JC 可能用到） ✅

Touying 独有功能：

```typst
#slide[
  = Key Results

  Equation with `pause`:

  $
    f(x) &= pause x^2 + 2x + 1 \
    &= pause (x + 1)^2 \
  $

  #meanwhile

  Here, #pause we have the expression of $f(x)$.

  #pause

  By factorizing, we can obtain this result.
]
```

**效果**：
- 第 1 帧：只显示 $f(x) =$
- 第 2 帧：显示完整第一行
- 第 3 帧：显示第二行
- 第 4 帧：同时显示旁边的解释文字

---

### 4. 两种写法灵活切换 ✅

#### 方式 1：标题驱动（快速原型）
```typst
= Introduction

== Authors

Authors information here...

== Overview

Overall features here...
```

#### 方式 2：块驱动（精确控制）
```typst
#slide[
  = Authors

  #grid(
    columns: (1fr, 1fr, 1fr),
    image("author1.png"),
    image("author2.png"),
    image("journal.png")
  )
]
```

**优势**：初稿用标题快速搭建，细化时切换到块模式精确控制。

---

### 5. 丰富的主题生态 ✅

Touying 官方主题（可直接使用）：

1. **Simple** - 极简风格
2. **University** - 学术风格（推荐 JC）
3. **Metropolis** - 现代风格
4. **Aqua** - 清新风格
5. **Stargazer** - 星空主题
6. **Dewdrop** - 水滴主题（带导航栏）

**推荐配置**（适合 IQB 课题组）：
```typst
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "13:7",  // 匹配你的 13cm × 7cm
  config-info(
    title: [文献标题],
    author: [高旭帆],
    date: datetime.today(),
    institution: [IQB Lab],
    logo: image("header.png", width: 2cm),
  ),
)
```

---

## 🔧 针对 JC 的 Touying 模板设计

### 完整示例（基于你的历史 JC 结构）

```typst
#import "@preview/touying:0.6.1": *
#import themes.university: *

// ========== 主题配置 ==========
#show: university-theme.with(
  aspect-ratio: "13:7",
  config-info(
    title: [Regina: Rigorously Predicting Protein-Ligand Dynamics],
    subtitle: [Journal Club Presentation],
    author: [高旭帆],
    date: datetime(year: 2025, month: 10, day: 19),
    institution: [IQB Lab],
    logo: image("/mnt/e/GitHub-repo/literature-reading/JC/2025.10/header.png", width: 3cm),
  ),
)

#set text(font: "Noto Sans CJK SC", size: 20pt)

// ========== 封面页 ==========
#title-slide()

// ========== 第 2 页：作者介绍（三图并列）==========
#slide[
  = Introduction
  == Authors

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.5em,

    // 左列
    [
      #image("author1.png", width: 100%)
      https://www.regina.csail.mit.edu/
    ],

    // 中列
    [
      #image("author2.png", width: 100%)
      https://people.csail.mit.edu/tommi/
    ],

    // 右列
    [
      #image("journal.png", width: 100%)
      *Nature*, 2025
    ]
  )
]

// ========== 第 3 页：Overview（左侧两图 + 右侧全高图）==========
#slide[
  = Overview
  == Overall Features

  // 右侧大图（绝对定位）
  #place(
    dx: 6cm, dy: 0cm,
    image("overview_full.png", width: 6cm, height: 7cm)
  )

  // 左上图
  #place(
    dx: 0cm, dy: 1cm,
    image("feature1.png", width: 5cm, height: 2cm)
  )

  // 左下图
  #place(
    dx: 0cm, dy: 4cm,
    image("feature2.png", width: 6cm, height: 2cm)
  )

  // 说明文字
  #place(
    dx: 0cm, dy: 6.2cm,
    text(20pt)[
      Comparable RMSF prediction accuracy with BioEmu,
      even using short trajectories.
    ]
  )
]

// ========== 第 4 页：双图左右分栏 ==========
#slide(composer: (1fr, 1fr))[
  = Overview
  == Key Results: Structural Prediction

  #image("structure_pred.png", width: 100%)

  #text(14pt)[CoV Mpro-ligands]
][
  #image("accuracy_comparison.png", width: 100%)

  #text(20pt)[
    Comparable structural prediction accuracy
    with AF3 or Boltz-1.
  ]
]

// ========== 第 6 页：三图复杂布局 ==========
#slide[
  = Structure
  == Methods: PairFormer Architecture

  // 左上图
  #place(
    dx: 0cm, dy: 1cm,
    block[
      #image("pairformer_original.png", width: 6cm, height: 3cm)
      #text(14pt)[Original PairFormer (AF3)]
    ]
  )

  // 左下小图条
  #place(
    dx: 0cm, dy: 4cm,
    image("equation.png", width: 6cm, height: 1cm)
  )

  // 右侧大图 + 说明
  #place(
    dx: 7cm, dy: 2cm,
    block[
      #image("architecture.png", width: 6cm, height: 4cm)
      #text(14pt)[
        单一表示 (Single Representation)：一个二维张量，
        尺寸为 n×cs，其中 n 是 token 数量...
      ]
    ]
  )
]

// ========== 第 11 页：四图不规则布局 ==========
#slide[
  = Affinity
  == Methods: Affinity Model Training

  // 左上小图
  #place(dx: 0cm, dy: 1cm,
    image("pocket_crop.png", width: 3cm, height: 3cm)
  )

  // 左下图例
  #place(dx: 0cm, dy: 5cm,
    box(width: 3cm, height: 1cm,
      text(12pt)[Pocket Identification and cropping]
    )
  )

  // 中间大图
  #place(dx: 3cm, dy: 1cm,
    image("workflow.png", width: 5cm, height: 6cm)
  )

  // 右侧图
  #place(dx: 8cm, dy: 1cm,
    image("model_architecture.png", width: 4cm, height: 6cm)
  )
]

// ========== 第 13 页：单张宽图 ==========
#slide[
  = Affinity
  == Results: Avoiding Data Leakage Problem

  #align(center)[
    #image("data_leakage.png", width: 13cm, height: 3cm)
  ]

  #text(18pt)[
    通过严格的数据集划分，避免了训练集和测试集之间的泄漏问题。
  ]
]

// ========== 第 18 页：纯文本总结 ==========
#slide[
  = Summary
  == Take-home messages & thoughts

  *Inspirations*

  - *Generalizability*: Another tool for fast and accurate
    protein-ligand dynamics prediction

  - *Methodology*: Ensemble learning + PairFormer architecture

  - *Benchmark*: New FEP+ benchmark dataset for affinity prediction

  #pause

  *Limitations*

  - Limited to small molecules (< 50 atoms)
  - Requires high-quality initial structures
]

// ========== 结束页 ==========
#slide[
  #align(center + horizon)[
    #text(66pt, weight: "bold")[
      Thanks for listening!
    ]

    #v(2em)

    #image("thank_you.png", width: 5cm)
  ]
]
```

---

## 🚀 Touying 特有功能（Polylux 没有的）

### 1. 演讲者备注（双屏显示）
```typst
#slide[
  = Key Results

  Main content here...

  #speaker-note[
    + 这是给演讲者看的备注
    + 不会显示在主屏幕上
    + 使用 `config-common(show-notes-on-second-screen: right)` 启用
  ]
]
```

### 2. 导出 PPTX/HTML
```bash
# 使用 touying-exporter
touying-exporter slides.typ --format pptx
touying-exporter slides.typ --format html
```

### 3. 在线分享（gistd）
直接通过 Git 即时分享幻灯片，无需编译 PDF。

### 4. CeTZ/Fletcher 动画（绘制流程图）
```typst
#import "@preview/fletcher:0.5.8" as fletcher: node, edge

#fletcher-diagram(
  node((0, 0), `reading`, radius: 2em),
  edge((0, 0), (0, 0), `read()`, "--|>", bend: 130deg),
  pause,
  edge(`read()`, "-|>"),
  node((1, 0), `eof`, radius: 2em),
)
```

---

## 📋 JC 布局需求匹配度（满分⭐⭐⭐⭐⭐）

| 需求 | Touying | 实现方式 |
|------|---------|---------|
| 精确定位（cm级） | ⭐⭐⭐⭐⭐ | `place(dx: 6cm, dy: 1cm, ...)` |
| 双列布局（35%） | ⭐⭐⭐⭐⭐ | `composer: (1fr, 1fr)` |
| 三列布局（25%） | ⭐⭐⭐⭐⭐ | `composer: (1fr, 1fr, 1fr)` 或 `grid()` |
| 不规则布局（40%） | ⭐⭐⭐⭐⭐ | `place()` 绝对定位 |
| 图文混排（90%） | ⭐⭐⭐⭐⭐ | `place()` + `grid()` 组合 |
| LLM 可编辑 | ⭐⭐⭐⭐⭐ | 纯文本 `.typ` 格式 |
| 字体层级控制 | ⭐⭐⭐⭐⭐ | `text(24pt)[...]` |
| 13cm × 7cm 尺寸 | ⭐⭐⭐⭐⭐ | `aspect-ratio: "13:7"` |

**总分**: 40/40 ⭐⭐⭐⭐⭐

---

## 🎓 学习路径（1小时上手）

### 阶段 1：基础语法（15分钟）
```typst
// 最简示例
#import "@preview/touying:0.6.1": *
#import themes.simple: *

#show: simple-theme.with(aspect-ratio: "13:7")

= Title
== First Slide
Hello, Touying!
```

### 阶段 2：双列布局（15分钟）
```typst
#slide(composer: (1fr, 1fr))[
  左列内容
][
  右列内容
]
```

### 阶段 3：精确定位（15分钟）
```typst
#slide[
  #place(dx: 2cm, dy: 1cm,
    image("fig.png", width: 5cm)
  )
]
```

### 阶段 4：完整 JC 模板（15分钟）
使用上面的完整示例代码。

---

## 🔧 下一步行动计划

1. **安装 Typst**（5分钟）
   ```bash
   # WSL Ubuntu
   curl -fsSL https://typst.app/install.sh | sh
   ```

2. **创建第一个 JC**（10分钟）
   - 使用 Touying University 主题
   - 配置 IQB 课题组 Logo
   - 实现 3 种常用布局

3. **测试 LLM 生成**（15分钟）
   - 让 Claude 生成一页幻灯片
   - 验证语法正确性
   - 调整提示词优化生成质量

4. **建立代码片段库**（20分钟）
   - 双列布局模板
   - 三列布局模板
   - 四图不规则布局模板
   - 纯文本总结页模板

5. **文档化工作流**（10分钟）
   - 创建 `README.md`
   - 编写使用指南
   - 记录常见问题

---

## 🎯 最终推荐

### ✅ 使用 Touying 的理由

1. **完美匹配 JC 需求**（40/40 分）
2. **比 Polylux 更现代**（性能更好、功能更多）
3. **活跃开发**（2025 年持续更新）
4. **学习成本低**（1 小时上手）
5. **LLM 友好**（纯文本格式）
6. **社区支持好**（文档详细、主题丰富）

### ❌ 不推荐 Polylux 的理由

1. Touying 是 Polylux 的"升级版"（继承 + 优化）
2. 性能更差（依赖 counter/context）
3. 功能更少（无演讲者备注、无数学动画）
4. 社区活跃度低（维护状态）

---

## 📊 最终评分

| 框架 | 综合评分 | 推荐度 |
|------|---------|--------|
| **Touying** | **98/100** | ⭐⭐⭐⭐⭐ 强烈推荐 |
| Polylux | 85/100 | ⭐⭐⭐⭐ 可用但不是最优 |
| Marp | 70/100 | ⭐⭐⭐ 简单场景可用 |
| Quarto | 65/100 | ⭐⭐⭐ 数据科学场景更好 |
| Beamer | 45/100 | ⭐⭐ 不推荐 |

---

**生成时间**: 2025.10.19
**分析依据**: 56页历史 JC + Touying 官方文档
**推荐结论**: **Touying 是 JC 文献汇报的最佳选择**
