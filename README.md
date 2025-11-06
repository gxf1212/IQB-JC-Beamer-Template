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
- 🛠️ **实用工具集** - PDF调试、PDF转PowerPoint、布局分析等辅助工具

---

## 📦 快速开始

### 安装要求
- **TeX Live 2020+** 或 **MiKTeX** (推荐 TeX Live 2023)
- **XeLaTeX** 编译器（支持中文）
- 中文字体（Windows 自带，Linux 需安装 `fonts-noto-cjk`）

### 基本使用
```latex
\documentclass[aspectratio=169,11pt]{beamer}
\usetheme{iqb}
\usepackage{theme/iqb-layouts}

\title{你的演示标题}
\author{你的名字}
\institute{IQB Lab}
\date{\today}

\begin{document}
\iqbcoverframe
\begin{frame}{目录}
  \tableofcontents
\end{frame}
\iqbsectionframe{Background}{研究背景}
\iqbthankyouframe
\end{document}
```

## 🎨 使用方式

### 方式 A：直接复制
将 `theme/` 文件夹复制到项目，在 LaTeX 中引入：
```latex
\usepackage{theme/beamerthemeiqb}
\usepackage{theme/iqb-layouts}
```

### 方式 B：Git 子模块
```bash
git submodule add https://github.com/IQB-Lab/IQB-JC-Beamer.git themes/iqb
\usepackage{themes/iqb/theme/beamerthemeiqb}
\usepackage{themes/iqb/theme/iqb-layouts}
```

## 📚 示例展示

查看 `examples/` 目录获取完整演示：
- `features-showcase.tex` - 26页完整功能演示
- `membrane-pore-jc.tex` - 14页真实JC案例

## 📖 详细文档

完整使用说明请参考：
- `software-copyright/3-basic-usage.tex` - LaTeX源码文档
- `software-copyright/3-basic-usage.pdf` - 格式化PDF文档

## 🛠️ 自定义配置

主题支持多种自定义选项，详细配置请参考 `software-copyright/3-basic-usage.tex`：
- 修改主题颜色和字体
- 替换Header图片
- 自定义Footer内容
- 高级布局配置

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源。

主题设计参考了 [Metropolis Beamer Theme](https://github.com/matze/mtheme)（CC-BY-SA 4.0）。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

**贡献指南**：
1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📋 版本历史

| 版本 | 日期 | 主要更新 |
|------|------|----------|
| v2.1 | 2025-11-05 | 新增PDF转换工具；完善文档结构 |
| v2.0 | 2025-10-23 | Footer引用系统、学术徽章、增强作者信息 |
| v1.0 | 2025-10-20 | 初始版本：30+布局模块、中文支持 |

**当前版本**: v2.1
**最后更新**: 2025-11-05
**维护者**: Xufan Gao
