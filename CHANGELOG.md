# Changelog

All notable changes to the IQB Journal Club Beamer Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-10-23

### Added

#### Footer引用系统
- **`\iqbfootcite{key}`** - 在页面底部显示完整文献引用（需要biblatex支持）
- **`\iqbfooterurl[title]{url}`** - 在页面底部显示URL链接（可选标题）
- **`\iqbfooterdoi{doi}`** - 在页面底部显示DOI链接（自动添加https://doi.org/前缀和超链接）
- **`\iqbfootcitewithurl{key}{url}`** - 组合显示完整引用和在线链接

#### 学术徽章与图标系统
- **`\iqborcid{id}`** - ORCID图标 + ID（带超链接）
- **`\iqbgithub{username}`** - GitHub图标 + username（带链接）
- **`\iqbgscholar{url}`** - Google Scholar图标 + 链接
- **`\iqbemail{email}`** - Email图标 + 邮件地址（可点击发送邮件）
- **`\iqbtwitter{username}`** - Twitter/X图标 + @username
- **`\iqbresearchgate{name}`** - ResearchGate图标 + 链接
- **`\iqbwebsite{url}`** - 通用网站图标 + 链接
- 新增依赖：`fontawesome5`包（已自动在主题中加载）

#### 增强作者信息模块
- **`\iqbauthoronephoto{photo}{name}{aff}{url}{research}{email}`** - 单作者展示（带照片），支持可选email字段
- **`\iqbauthorsthreephoto{p1}{n1}{a1}{p2}{n2}{a2}{p3}{n3}{a3}`** - 三作者紧凑布局（带照片）

#### 主题选项系统
- **`tocnumbered`选项** - 启用目录编号（默认不编号）
  - 用法：`\usetheme[tocnumbered]{iqb}`
  - 同时支持section和subsection编号
- 保留原有`noheader`选项（隐藏header横幅）

#### 示例与文档
- 新增 `examples/references.bib` - 示例文献库（9条记录，含中英文文献）
- 更新 `examples/features-showcase.tex` - 新增4页功能演示（第23-26页）
  - Footer引用系统演示
  - URL与DOI使用示例
  - 学术徽章图标展示
  - 增强作者信息演示
- 更新 `examples/features-showcase.pdf` - 从22页扩展到26页

### Changed

#### 学术最佳实践优化
- **行间距**：从0.92x调整为1.5x（基于Michaillat 2025等学术研究）
- **版本信息**：从v1.0更新到v2.0（日期：2025-10-23）
- **文档改进**：
  - README.md全面重写，新增v2.0功能说明
  - 目录结构更新，反映新文件
  - 添加版本徽章和功能分类

### Fixed
- 修复`\iqbitemize`命令在某些上下文中的paragraph break问题（在appendix frames中改用标准itemize环境）
- 改进`\iqbauthoronephoto`的email字段可选逻辑（使用`\ifx&#6&`判断空参数）

---

## [1.0.0] - 2025-10-20

### Added

#### 核心主题系统
- **beamerthemeiqb.sty** - IQB主题文件
  - 全宽header横幅设计（1999×204px，保持比例）
  - 三段式footer（IQB Lab | Section | 页码/总数）
  - IQB蓝色配色方案（主色#003366）
  - 4级字号体系（12pt/11pt/9pt/8pt）
  - 支持`noheader`选项

#### 布局工具包（30+模块）
- **iqb-layouts.sty** - 布局命令库
  - 快捷页面命令：`\iqbcoverframe`, `\iqbthankyouframe`, `\iqbsectionframe`
  - 双列布局：`\iqblayouttwo`, `\iqblayoutonethird`, `\iqblayouttwothirds`
  - 三列布局：`\iqblayoutthree`
  - 网格布局：`\iqbgridtwobytwo`, `\iqbgridthreebytwo`
  - 图文混排：`\iqbtextimage`, `\iqbimagetwotext`
  - 图片模块：`\iqbfig`, `\iqbtwofig`, `\iqbthreefig`, `\iqbfourfig`（带自动编号）
  - 对比模块：`\iqbtwocolcompare`, `\iqbthreecolcompare`
  - 表格模块：`\iqbthreelinetable`, `\iqbfourcolumntable`
  - 作者信息：`\iqbauthorstwo`, `\iqbauthorstwophoto`, `\iqbauthorsthree`
  - 时间线/流程：`\iqbtimeline`
  - 关键点模块：`\iqbkeypoints`, `\iqbquestion`, `\iqbconclusion`
  - 视觉增强：`\emphdata`, `\keyfinding`, `\iqbbluebox`, `\iqborangebox`, `\iqbgreenbox`, `\iqbredbox`
  - 代码显示：`\iqbinlinecode`, `iqbcode`环境
  - 附录模式：`\iqbappendix`

#### 示例与模板
- **examples/membrane-pore-jc.tex** - 真实JC案例（膜孔自由能MD研究，14页）
- **examples/features-showcase.tex** - 功能展示（22页）
- **template/jc-template.tex** - 空白起始模板
- **examples/images/** - 示例图片资源（19张，含作者照片）

#### 中文支持
- 基于XeLaTeX + xeCJK
- 跨平台字体自动适配（Windows/macOS/Linux）
- SimSun/Songti SC/Noto Serif CJK SC自动选择

#### 文档
- README.md - 完整项目文档
- LICENSE - MIT许可证

#### 工具
- **tools/extract_pdf_page.py** - PDF调试工具（提取单页为PNG）

### Project Structure
```
IQB-JC-master/
├── theme/ (核心主题)
├── examples/ (示例)
├── template/ (空白模板)
├── archive/ (历史参考)
└── tools/ (辅助工具)
```

---

## 版本说明

### v2.0重点改进
1. **学术功能增强**：Footer引用系统、学术徽章/图标、增强作者信息
2. **学术最佳实践**：1.5x行间距（遵循Michaillat 2025建议）
3. **用户体验优化**：目录编号选项、更完整的示例文档

### v1.0初始功能
1. **品牌化设计**：IQB header/footer、配色方案
2. **丰富布局**：30+预设布局模块
3. **中文支持**：完美的CJK字体处理
4. **开箱即用**：完整示例和空白模板

---

**维护者**: IQB Lab
**许可证**: MIT License
**基于**: Metropolis Beamer Theme (参考设计)
