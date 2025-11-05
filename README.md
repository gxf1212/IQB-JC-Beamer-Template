# IQB Journal Club Beamer Template

**专业学术演示 Beamer 模板 - 灵活布局 + 学术功能 + 完美中文支持**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/Version-2.0-blue)](https://github.com/IQB-Lab/IQB-JC-master)

---

## ✨ 核心特性

### 设计与布局
- 🎨 **品牌化设计** - 全宽header横幅 + 三段式footer（机构名 | Section | 页码）
- 📐 **30+ 布局模块** - 双列/三列/网格/图文混排/时间线/对比表格等
- 📏 **学术最佳实践** - 1.5x行间距，4级字号体系，无障碍配色

### 学术功能 (v2.0 新增)
- 📚 **Footer引用系统** - 支持biblatex完整引用、URL、DOI链接
- 🎓 **学术徽章** - ORCID、Google Scholar、GitHub等图标命令
- 👤 **增强作者信息** - 可选email字段，三作者紧凑布局

### 技术支持
- 🌏 **中文完美支持** - 基于XeLaTeX + xeCJK，跨平台字体自动适配
- 📦 **开箱即用** - 完整示例 + 空白模板 + 26页功能展示PDF
- 🔧 **高度可定制** - 主题选项（header显示、目录编号）、颜色、布局参数

---

## 📦 快速开始

### 1. 安装要求

- **TeX Live 2020+** 或 **MiKTeX** (推荐 TeX Live 2023)
- **XeLaTeX** 编译器（支持中文）
- 中文字体（Windows 自带，Linux 需安装 `fonts-noto-cjk`）

### 2. 最小示例

```latex
\documentclass[aspectratio=169,11pt]{beamer}

% 加载IQB主题 (可选参数: noheader, tocnumbered)
\usetheme{iqb}  % 或 \usetheme[tocnumbered]{iqb} 启用目录编号
\usepackage{theme/iqb-layouts}

% 如需使用footer引用系统，加载biblatex
\usepackage[style=authoryear]{biblatex}
\addbibresource{references.bib}

\title{你的演示标题}
\author{你的名字}
\institute{IQB Lab}
\date{\today}

\begin{document}

% 封面页 (使用快捷命令)
\iqbcoverframe

% 目录页
\begin{frame}{目录}
  \tableofcontents  % 默认不编号，除非使用 tocnumbered 选项
\end{frame}

% 内容页
\iqbsectionframe{Background}{研究背景}  % 自动设置section并显示分隔页

\begin{frame}{研究现状}
  \begin{itemize}
    \item 要点 1
    \item 要点 2
  \end{itemize}

  % Footer引用示例
  \iqbfootcite{smith2023}  % 显示完整文献引用
\end{frame}

% 致谢页 (使用快捷命令)
\iqbthankyouframe

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
IQB-JC-master/
├── README.md                     # 项目主文档（当前文件）
├── LICENSE                       # MIT 许可证
├── CHANGELOG.md                  # 版本更新日志
│
├── theme/                        # IQB 主题核心（可复用）
│   ├── beamerthemeiqb.sty        # 主题文件 (v2.0)
│   │                             #   - 颜色/字体/header/footer
│   │                             #   - 选项: noheader, tocnumbered
│   ├── iqb-layouts.sty           # 布局工具包 (30+ 模块)
│   │                             #   - 双列/三列/网格/图文混排
│   │                             #   - Footer引用系统
│   │                             #   - 学术徽章/作者信息
│   └── images/
│       └── header.png            # IQB logo 横幅 (1999×204px)
│
├── examples/                     # 示例演示稿
│   ├── membrane-pore-jc.tex      # 真实JC案例 (膜孔自由能MD研究)
│   ├── features-showcase.tex     # 功能全展示 (26页，含v2.0新功能)
│   ├── references.bib            # 示例文献库 (9条记录)
│   └── images/                   # 示例图片资源
│
├── template/                     # 空白模板（快速启动）
│   └── jc-template.tex           # 预设模板骨架
│
├── software-copyright/           # 软件著作权申请材料
│   └── 3-usage.tex               # 完整使用手册 (LaTeX源码)
│
├── archive/                      # 历史参考文件
│   └── ...                       # 旧版本/分析报告/参考主题
│
└── tools/
    └── extract_pdf_page.py       # PDF调试工具 (提取页面为PNG)
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

### 1. 主题选项

```latex
% 基础用法
\usetheme{iqb}

% 禁用header横幅
\usetheme[noheader]{iqb}

% 启用目录编号
\usetheme[tocnumbered]{iqb}

% 组合选项
\usetheme[noheader,tocnumbered]{iqb}
```

### 2. 快捷页面命令

```latex
% 封面页（自动使用\title, \author等信息）
\iqbcoverframe

% Section分隔页（自动设置footer section）
\iqbsectionframe{Methods}{研究方法}

% 致谢页
\iqbthankyouframe
```

### 3. Footer引用系统 (v2.0 新增)

```latex
% 需先加载biblatex
\usepackage[style=authoryear]{biblatex}
\addbibresource{references.bib}

\begin{frame}{研究背景}
  % 内容...

  % 在页面底部显示完整引用
  \iqbfootcite{smith2023}

  % 显示URL链接
  \iqbfooterurl[来源]{https://example.com}

  % 显示DOI（自动添加超链接）
  \iqbfooterdoi{10.1038/nature12345}
\end{frame}
```

### 4. 学术徽章/图标 (v2.0 新增)

```latex
% ORCID
\iqborcid{0000-0001-2345-6789}

% GitHub
\iqbgithub{username}

% Google Scholar
\iqbgscholar{https://scholar.google.com/citations?user=XXXX}

% Email
\iqbemail{someone@example.com}

% 通用网站
\iqbwebsite{https://example.com}

% 组合使用（如在作者信息中）
\iqbauthoronephoto{photo.jpg}{张三}{清华大学}{\iqbwebsite{url}}{计算生物学}{\iqbemail{email}}
```

### 5. 常用布局命令

```latex
% 双列布局（50-50）
\iqblayouttwo{左列内容}{右列内容}

% 三列布局
\iqblayoutthree{左列}{中列}{右列}

% 1/3 + 2/3 布局
\iqblayoutonethird{窄列}{宽列}

% 2×2 网格（插入4张图片）
\iqbgridtwobytwo{img1.png}{img2.png}{img3.png}{img4.png}

% 图片 + 文字（文字在右）
\iqbtextimage[width=0.4\textwidth]{文字内容}{image.png}
```

### 6. 作者信息展示

```latex
% 单作者（带照片，可选email）
\iqbauthoronephoto{photo.jpg}{姓名}{单位}{网站}{研究方向}{email}
%                                                      ^^^^^ 可传空{}

% 三作者紧凑布局
\iqbauthorsthreephoto{p1}{n1}{a1}{p2}{n2}{a2}{p3}{n3}{a3}
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

## 📋 版本历史

| 版本 | 日期 | 主要更新 |
|------|------|----------|
| v2.0 | 2025-10-23 | Footer引用系统、学术徽章、增强作者信息、目录编号选项、学术最佳实践（1.5x行间距） |
| v1.0 | 2025-10-20 | 初始版本：30+布局模块、中文支持、品牌化设计 |

---

**当前版本**: v2.0
**最后更新**: 2025-10-23
**基于**: Metropolis Beamer Theme (参考设计)
**维护者**: IQB Lab
