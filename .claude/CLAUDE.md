# IQB Journal Club Beamer 模板项目指南

## 项目概述

- **项目类型**: LaTeX Beamer 学术幻灯片模板
- **技术栈**: XeLaTeX + Beamer + CJK中文支持
- **编译命令**: `/mnt/d/texlive/2022/bin/win32/xelatex.exe` (WSL中调用Windows TeXLive)

## 核心格式要求

### Header（页眉横幅）
- **资源文件**: `/theme/images/header.png` (1999×204px)
- **占满slides的full width，保持原始宽高比**
- **除首页（封面）和末页（致谢）外，所有页面都必须显示**
- 位于页面顶部，不能被其他元素遮挡

### Frametitle（标题）
- **位置**: 左上角，叠在header空白区域上（使用TikZ绝对定位）
- **背景**: 完全透明，无白色背景
- **颜色**: IQB深蓝色 (#003366)
- 不占用正文内容空间

### Footer（页脚）
- **位置**: 固定在页面最底部，不能超出页面
- **内容三段式**: 左侧"IQB Lab" | 中间Section进度标识 | 右侧"页码/总数"
- **颜色**: 顶部带IQB蓝色分割线（1.5pt），文字使用主题色
- 使用`\setsection{Methods}`等命令设置中间Section名称

### 布局与排版

**Beamer最佳实践**：
- **字体大小**: 正文使用\scriptsize，标题\normalsize，确保10-12行/页
- **行间距**: 150% point size，增加可读性
- **不要使用shrink选项**来强行塞入更多内容
- **左对齐**: 所有文字（标题、正文）沿同一左边距对齐
- **避免自动换行**: 手动使用`\\`断行，不要依赖LaTeX自动换行

**本模板特定要求**：
- 文字图片不溢出到下一页
- 每页尽量有图文结合
- 图片不要太小，竖版图采用横向column布局（一列图片+其他列文字）
- **字体大小参考PPTX中字体与页面大小的比例**

你能否调用d/texlive/2022/bin/win32/xelatex.exe来测试编译？还是不行，能否边修复边测试编译？根据报错来修复
尽量不要手动调字号\large，一般就用模板的
overfull的话可以重新布局，可以拆分多页
尽量不要出现overfull
尽量不用vspace而是\iqbseq之类的，尽量用可复用的title而不是textbf，不是不能用，正常临时加粗当然可以，但标题类的应该用模板，如果有必要可在iqbsectiontitle下面加一级小标题？你写的时候尽量不要手动，我微调才会加
\iqbsep前或后要换行
能用iqbitemize的，类似并列结构的就用
需要标号的采用\iqbfig系统？没事就用\iqbimgcenter
参考E:\graduate_study\other-affairs\素质评价\三学年\奖学金\专项\slides\Xufan.tex
还有什么放图的命令吗？有些你觉得纯文字不好表达的可以加个简单的tikz示意图，自己试试这方面功能，如LIME。用PDF截图检查tikz图的页面，来美化和修复错误
Internal Validation in Practice: Experimental vs. Predicted，这一页下面一页是空的. \item[Benefit]如果overfull了就用普通\item 
左边栏的\item[CoMFA]这种长的标签，应该往右推，如\begin{iqbitemize}[1.5cm]

### 可复用模块

模板提供丰富的预设模块（详见`theme/iqb-layouts.sty`）：

**作者信息**：
- `\iqbauthorstwophoto{}{}...` - 通讯+一作，支持照片
- `\iqbauthorstwo{}{}...` - 通讯+一作，无照片
- `\setauthorfirstfield{}` - 设置一作研究领域

**图表模块**（带自动编号"图1："，左对齐caption）：
- `\iqbfig[options]{image}{caption}` - 单图
- `\iqbtwofig[]{img1}{cap1}{img2}{cap2}` - 双图
- `\iqbthreefig[]{}...` - 三图
- `\iqbfourfig[]{}...` - 2×2四图

**布局工具**：
- `\iqblayouttwo{left}{right}` - 50-50双列
- `\iqblayoutonethird{left}{right}` - 1/3 + 2/3
- `\iqblayoutthree{}{}{}}` - 三列均分
- `\iqbtextimage[]{text}{image}` - 文字+图片

**其他模块**：
- `\iqbkeypoints{}` - 关键要点
- `\iqbquestion{}` - 核心问题
- `\iqbconclusion{}` - 结论总结
- `\iqbtimeline{}{}...` - 时间线/流程图

## 参考资料

- **PPTX样式参考**: `E:\GitHub-repo\literature-reading\JC`
- **内容来源**: `E:\GitHub-repo\mendelevium\_pages\Specific Sytems\Membrane`

## 开发工作流

### 编译
```bash
cd examples
/mnt/d/texlive/2022/bin/win32/xelatex.exe -interaction=nonstopmode membrane-pore-jc.tex
```

### PDF审查
编译后使用 **pdf-layout-reviewer agent** 自动检查所有格式要求，但不一定所有页面，要不然太慢：
- Header是否全宽且保持比例
- Footer是否包含三段式内容且不超出页面
- Frametitle是否透明背景且叠在banner上
- 布局是否溢出、图文是否平衡
- 字体大小是否合适

### 调试工具
使用 `tools/extract_pdf_page.py` 提取特定页面为PNG供视觉分析：
```bash
python3 tools/extract_pdf_page.py examples/output/xxx.pdf 3
```

或者使用pdf-layout-reviewer这个agent

## 目录结构

```
IQB-JC-master/
├── theme/                    # 主题核心（复用）
│   ├── beamerthemeiqb.sty    # 主题（颜色、字体、header/footer）
│   ├── iqb-layouts.sty       # 布局工具包
│   └── images/header.png     # IQB横幅
├── examples/                 # 示例
│   ├── membrane-pore-jc.tex  # 完整JC示例
│   ├── images/membrane-pore-jc/  # 图片资源
├── template/                 # 空白模板
│   └── jc-template.tex
├── tools/                    # 辅助工具
│   └── extract_pdf_page.py
└── archive/                  # 历史参考
```

## 内容设计原则（General Requirements）

### 1. 页面标题（Frametitle）设计
- **禁止简单罗列式标题**：不要使用"结果：交叉验证"、"方法：Full-Path CV"等平淡描述
- **必须包含punchline或结论概括**：标题应传达该页面的核心发现或关键洞察
- **参考原则**：
  - 问题页 → 突出挑战的本质（如"统一描述成核与扩展两个截然不同的阶段"）
  - 方法页 → 强调创新点（如"切换函数巧妙结合成核与扩展"）
  - 结果页 → 突出结论（如"正反向拉伸完全重合，CV设计可逆无滞后"）
  - 验证页 → 强调验证结果（如"脂质尾部密度与孔寿命正相关(R²=0.82)"）

**示例对比**：
- ❌ 差：`\begin{frame}{结果：交叉验证}`
- ✅ 好：`\begin{frame}{双重验证：Full-Path与Rapid高度一致，与实验定性吻合}`

### 2. 图片布局原则
- **竖版图片（高>宽）必须使用横向column布局**：
  - 一个column专门放图片（占0.31-0.48宽度）
  - 其他column放文字说明
  - **禁止**将竖版图堆在文字下方，会导致图片过小
  - 每个图都必然有图注，要么详细图注，要么这一页剩下的文字就都是解读图片，反正就是围绕图片来讲解结果。图注也可以写文字栏，如果图片非常高
- **图片尺寸要求**：
  - 单图：`height=0.5-0.6\textheight`
  - 双图并排：`height=0.45-0.55\textheight`
  - 三图并排：`height=0.35-0.4\textheight`
  - 竖版图在column中：`height=0.5-0.65\textheight`
- **图文平衡**：每页尽量都有图文结合，避免纯文字或纯图片页面

#### 图片布局与文字策略（核心要求）

**基本原则**：
- **默认布局**：1/3 文字 + 2/3 图片
- **竖版特高图**（高>宽×1.2）：2:1 双栏，即 1 份图片 + 2 份文字，文字可写详细解读和图注
- **宽图**（宽≥高×1.5）：2:1 布局变体，图占 2、文字占 1，或用表格/多行长句作图注
- **其他情况**：保持 1/3 + 2/3

**图注与文字要求**：
- **每个图都必然有图注**（强制要求）
  - 要么写详细的 figure caption（可用表格格式容纳多行长文字）
  - 要么这一页的所有文字都围绕图片进行解读，既是文字说明也是图注
- **文字行策略**：少行长句优于多行短句
  - 竖版高图：3-5行长句，每行可达 40+ 字
  - 宽图配表格：用表格或"|"分隔符分列说明多个子图
- **图注也可独立成文字栏**：如果图片特别高，可在旁边文字栏中写详细的 caption 和解释文字

### 3. 字体层级（已统一）
一般**禁止**在正文中出现11pt的文字（如`\normalsize`的加粗标题）

### 4. 溢出检查
- **编译时检查**：XeLaTeX编译会警告 `Overfull \hbox` 或 `Overfull \vbox`
- **修复方法**：
  - 减少文字行数，提炼关键点
  - 调整图片高度参数
  - 拆分为两页
  - 使用更紧凑的布局（如`\iqblayoutthree`代替`\iqblayouttwo`）

## 与 Claude Code 协作提示

- 用户说"编译"或"检查PDF" → 使用TeXLive编译 + 调用pdf-layout-reviewer
- 修改主题后 → 立即重新编译验证效果
- 布局问题 → 提取页面截图用视觉模型诊断
- 完成后 → 清理临时文件 `rm /tmp/pdf_page_*.png`
- **修改内容后必须编译验证**：检查溢出、字体大小、图片尺寸

给用户的使用说明写在 `software-copyright` 文件夹下。先写一个初版，先只写 `software-copyright/3-usage.tex`（有需要可以拆几章）已经实现的部分，既要满足软著使用手册的 `prompt.md`，又要符合LaTeX包说明文档的要求。使用说明更新到software-copyright中，所有新的更新。 
