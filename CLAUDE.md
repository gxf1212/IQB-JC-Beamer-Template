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

#### 字体大小控制

**全局字体模式**（推荐用于密集内容页）：
```latex
\begin{frame}{标题}
  \iqbfontsizemode{small}  % 整页字体缩小一级
  % ... 页面内容
\end{frame}
```
- 使用场景：方法详述、大量列表、复杂表格、MD模拟等信息密集页
- 效果：正文从\footnotesize降至\scriptsize，列表从\scriptsize降至\tiny
- **优先级**：比手动调整字号更好，保持一致性

**字体层级规范**：
- **标题**: 使用模板默认，不要手动设置
- **章节标题**: `\iqbsectiontitle{}`（自动格式化）
- **正文**: 模板默认（\footnotesize）或small模式（\scriptsize）
- **列表**: `\iqbitemize`/`\iqbenumerate`（自动适配）
- **表格**: 根据内容密度用`\footnotesize`、`\scriptsize`或`\tiny`
- **图注**: 使用`\iqbfigcap`自动处理

**禁止事项**：
- ❌ 尽量不要在正文中出现`\large`、`\normalsize`等手动调整
- ❌ 尽量不要用`\textbf{}`做标题，应用`\iqbsectiontitle{}`
- ❌ 不要使用Beamer的`shrink`选项强塞内容

#### 间距控制

**模板提供的间距命令**（从大到小）：
```latex
\iqbbigsep      % 0.5cm - 大段落间距
\iqbsep         % 0.3cm - 标准段落间距（常用）
\iqbsmallsep    % 0.2cm - 中小间距
\iqbtinysep     % 0.15cm - 小间距
\iqbmicrosep    % 0.1cm - 微小间距
```

**使用原则**：
- 间距命令前后必须换行
- 章节间用`\iqbsep`或`\iqbsmallsep`
- 列表项内用`\iqbtinysep`或`\iqbmicrosep`
- ❌ 禁止使用`\vspace{}`、`\medskip`等原生命令

#### Overfull处理策略

**诊断方法**：
```bash
# 编译时查看警告
xelatex file.tex 2>&1 | grep "Overfull"

# 查看vbox（垂直溢出，严重！）
grep "Overfull \\vbox" file.log

# 查看hbox（横向溢出，次要）
grep "Overfull \\hbox" file.log
```

**修复优先级**（从高到低）：

1. **使用全局small模式**（首选）：
   ```latex
   \iqbfontsizemode{small}
   ```

2. **压缩间距**：
   - `\iqbsep` → `\iqbsmallsep`
   - `\iqbsmallsep` → `\iqbtinysep`

3. **优化表格**：
   - 减小字体（`\footnotesize` → `\scriptsize` → `\tiny`）
   - 简化列内容
   - 合并相似行

4. **调整图片高度**：
   - 从`height=0.75\textheight`降至`0.68-0.70\textheight`

5. **重构布局**：
   - TikZ mindmap → 双栏列表
   - formula frame → 普通frame
   - 三栏改双栏

6. **拆分页面**（最后手段）：
   ```latex
   % 原：一页塞太多
   \begin{frame}{ABC}
     内容1 内容2 内容3
   \end{frame}

   % 改：拆成两页
   \begin{frame}{AB}
     内容1 内容2
   \end{frame}
   \begin{frame}{C}
     内容3
   \end{frame}
   ```

**重要原则**：
- **信息密度可以大，但不能删减内容**
- **拆分和重组优于删减**
- **overfull >5pt必须修复，<5pt可接受**

#### 其他排版要求

**排版规则**：
- **左对齐**: 所有文字（标题、正文）沿同一左边距对齐
- **避免自动换行**: 手动使用`\\`断行
- **行间距**: 模板默认1.2倍，可用`\setstretch{}`调整
- **图文平衡**: 每页尽量有图文结合
- **竖版图**: 必须用横向column布局（一列图片+其他列文字）

**模板使用规范**：
- 尽量用模板提供的布局命令（`\iqblayouttwo`、`\iqbfigcap`、`\iqborangebox`等）
- 尽量用`\iqbitemize`/`\iqbenumerate`，不用原生itemize
- 标题用`\iqbsectiontitle{}`，不用`\textbf{}`
- 标题框用`\iqbgreenbox`/`\iqborangebox`等，不用`\begin{block}{}`
- 需要标号的图用`\iqbfig`系列命令，简单图用`\iqbimgcenter`

**TikZ图示**：
- 有些纯文字不好表达的可以加简单的TikZ示意图（如LIME、流程图等）
- 用PDF截图检查TikZ图的页面效果，及时美化和修复错误

**编译与调试**：
- 边修改边编译，用`xelatex -interaction=nonstopmode`快速测试
- 根据报错和警告逐步修复
- 可暂时注释部分页面来定位overfull行

**工作流建议**：
- 每提取一部分就优化相应部分的slides，一步一步来
- 读software-copyright/document.pdf了解模板feature和预定义命令
- 参考E:\graduate_study\other-affairs\素质评价\三学年\奖学金\专项\slides\Xufan.tex

**结构与内容**：
- 每页都要图文结合：至少放一张与标题直接对应的图，并在同页详述数据/方法/结论
- 标题需有punchline，简洁概括主要结论，避免"结果：交叉验证"这类描述性标题
- 尽量按原文逻辑拆分，必要时增加页数，不要压缩信息
- 从原始Markdown或PDF大段取材以保证细节完整
- 重要结论或关键数据使用三线表或itemize，保持可读性
- 长公式用行间形式且另起行

**版式细节**：
- 标题比正文大一级并加粗
- 正文、图注和列表保持一致字号（默认约8pt）
- 图注左对齐
- 根据图片比例自动选择布局：
  * 超高图用"图1+文字2"横向布局
  * 超宽图2:1布局
  * 常规图默认两栏1/3+2/3
- 确保图面不太小且占满列高
- 标题宽度过长时自动换行，避免与页眉图案重叠

**图像要求**：
- 必须与原PDF页码对应，文件命名如fig1a.png
- 确保图注准确翻译，必要时拆子图
- 图注可放在文字栏，尤其是长图
- 所有图注需使用模板封装命令实现左对齐和统一字体
- 对所有图片运行tools/analyze_image_layout.py等工具，辅助确定布局和尺寸
- 未用图放入notusing文件夹

**模板特性**：
- 充分利用模板内的自定义字段（作者、导师、页脚设置等）
- `\iqbsectiontitle`后默认换行，`\iqbsep`两侧自动留白
- Punchline框（如`\iqbpunchlinegreen`、`\iqborangebox`）标题与正文分别使用模板定义的字号
- 所有页面含banner、footer；`\iqbsectionframe`项不显示footer
- 命令统一使用中文引号（Unicode 201C/201D）
- 必须用根目录的theme文件夹


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

尊重原文：fig9是Kollman和Jorgensen的合影（原文Figure 10），这样的话就全部按照原文的编号，要修改文件名 
tools\search_pdf_text.py查看lecuture_collection\free-energy\the-dawn-of-alchemical-free-energy-methods-in-biomolecular-simulations.pdf检查图注内容是否正确，你最起码把人是谁标一下。长的图注可以居左对齐，短的居中
还要检查图的内容，比如fig1.jpg和原文的fig1是不是对应。也避免overfull。自动完成所有的事
不要图 7：原文图 6 ，直接图6，其他类似

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
