# IQB Journal Club Beamer Template

**专业的学术文献汇报 LaTeX Beamer 模板，为 IQB Lab 定制**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## ✨ 特性

- 🎨 **IQB 品牌化设计** - 全宽 header 横幅 + 三段式 footer（IQB Lab | Section | 页码）
- 📐 **丰富布局组件** - 双列、三列、2×2 网格、不规则布局等
- 🌏 **中文完美支持** - 基于 XeLaTeX + CJK 字体
- 📦 **开箱即用** - 完整示例 + 空白模板，5 分钟快速启动
- 🔧 **高度可定制** - 主题颜色、footer section、布局参数均可调整

---

## 📦 快速开始

### 1. 安装要求

- **TeX Live 2020+** 或 **MiKTeX** (推荐 TeX Live 2023)
- **XeLaTeX** 编译器（支持中文）
- 中文字体（Windows 自带，Linux 需安装 `fonts-noto-cjk`）

### 2. 最小示例

```latex
\documentclass[aspectratio=169,11pt]{beamer}

% 加载 IQB 主题
\usepackage{theme/beamerthemeiqb}
\usepackage{theme/iqb-layouts}

\title{你的演示标题}
\author{你的名字}
\institute{IQB Lab}
\date{\today}

\begin{document}

% 封面页
\begin{frame}[plain]
  \titlepage
\end{frame}

% 内容页
\setsection{Background}  % 设置 footer 的 section 标识
\begin{frame}{第一页}
  \begin{itemize}
    \item 要点 1
    \item 要点 2
  \end{itemize}
\end{frame}

% 致谢页
\begin{frame}[plain]
  \centering
  {\Huge Thank You!}
\end{frame}

\end{document}
```

### 3. 编译命令

```bash
# 使用 XeLaTeX（推荐，支持中文）
xelatex your-presentation.tex

# 或使用 PDFLaTeX（仅英文）
pdflatex your-presentation.tex
```

---

## 📂 目录结构

```
IQB-JC-Beamer/
├── README.md                  # 项目主文档（当前文件）
├── LICENSE                    # MIT 许可证
│
├── theme/                     # IQB 主题（核心，可复用）
│   ├── beamerthemeiqb.sty     # 主题文件（颜色、字体、header/footer）
│   ├── iqb-layouts.sty        # 布局工具包（双列、三列、网格等）
│   └── images/
│       └── header.png         # IQB logo 横幅图片
│
├── examples/                  # 示例演示稿
│   ├── membrane-pore-jc.tex   # 真实 JC 示例（膜孔自由能，15+ 页）
│   ├── test-minimal.tex       # 最小测试示例
│   ├── images/                # 示例用图片
│   │   └── membrane-pore-jc/  # 膜孔 JC 图片（19 张，含作者照片）
│   └── output/                # 编译输出 PDF
│
├── template/                  # 空白模板（快速启动）
│   └── jc-template.tex        # 预设好的模板骨架
│
├── docs/                      # 使用文档
│   ├── QUICK_START.md         # 5 分钟快速开始指南
│   └── LAYOUT_GUIDE.md        # 布局完全指南
│
├── archive/                   # 历史参考文件（保留）
│   ├── analysis/              # JC 布局分析报告
│   ├── legacy/                # 旧版本模板
│   └── mtheme-master.zip      # Metropolis 主题源码（参考）
│
└── tools/
    └── extract_pdf_page.py    # PDF 调试工具（提取单页为图片）
```

---

## 🎨 使用方式

### 方式 A：直接复制到你的项目

1. 将 `theme/` 文件夹复制到你的项目根目录
2. 在 LaTeX 文档中引入：
   ```latex
   \usepackage{theme/beamerthemeiqb}
   \usepackage{theme/iqb-layouts}
   ```

### 方式 B：作为 Git 子模块引用

```bash
# 在你的项目中添加为子模块
git submodule add https://github.com/your-org/IQB-JC-Beamer.git themes/iqb

# 在 LaTeX 文档中引入
\usepackage{themes/iqb/theme/beamerthemeiqb}
\usepackage{themes/iqb/theme/iqb-layouts}
```

---

## 📚 示例展示

### 1. `examples/demo-basic.tex`

展示所有可用的布局组件：
- 双列布局（50-50、1/3-2/3、2/3-1/3）
- 三列布局（均分、不规则）
- 2×2 和 3×2 网格
- 图文混排
- Block 环境

### 2. `examples/membrane-pore-jc.tex`

真实 Journal Club 演示（14 页）：
- **主题**：膜孔自由能与稳定性的分子动力学模拟研究
- **内容**：完整的 JC 汇报结构（封面、背景、方法、结果、讨论、致谢）
- **布局**：展示复杂图文混排、多子图拼接、公式排版
- **特点**：每页布局精心调整，无溢出，适合直接参考

---

## 📖 详细文档

| 文档 | 内容 |
|------|------|
| [快速开始指南](docs/QUICK_START.md) | 安装要求、基础用法、编译命令、常见错误 |
| [布局完全指南](docs/LAYOUT_GUIDE.md) | 所有布局命令详解、footer 设置、图片处理技巧 |

---

## 🔧 核心功能速查

### 1. 设置 Footer Section

```latex
\setsection{Methods}  % footer 中间显示 "Methods"
\begin{frame}{方法部分}
  % 内容
\end{frame}
```

### 2. 常用布局命令

```latex
% 双列布局（50-50）
\iqblayouttwo{左列内容}{右列内容}

% 三列布局
\iqblayoutthree{左列}{中列}{右列}

% 2×2 网格
\iqbgridtwobytwo{图1}{图2}{图3}{图4}

% 图片 + 文字
\iqbimagetext[width=0.4\textwidth]{image.png}{右侧文字内容}
```

### 3. 特殊页面（无 header/footer）

```latex
% 封面页或致谢页
\begin{frame}[plain,noframenumbering]
  \titlepage  % 或其他内容
\end{frame}
```

---

## 🛠️ 自定义配置

### 修改主题颜色

编辑 `theme/beamerthemeiqb.sty`：

```latex
% 将 IQB 蓝色改为其他颜色
\definecolor{iqbblue}{RGB}{0, 51, 102}  % 改为你的颜色
```

### 替换 Header 图片

将你的 logo 图片（建议 16:9 比例）保存为 `theme/images/header.png`

### 调整 Footer 内容

编辑 `theme/beamerthemeiqb.sty` 中的 `footline` 模板：

```latex
\defbeamertemplate*{footline}{iqb}
{
  % 修改左侧文字（默认 "IQB Lab"）
  \hspace{1em}\usebeamerfont{footline}Your Lab Name
  ...
}
```

---

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源。

主题设计参考了 [Metropolis Beamer Theme](https://github.com/matze/mtheme)（CC-BY-SA 4.0）。

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

**贡献指南**：
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

---

## 📧 联系

如有问题或建议，欢迎联系 **IQB Lab**

---

**生成时间**: 2025-10-20
**模板版本**: 1.0
**基于**: Metropolis Beamer Theme
