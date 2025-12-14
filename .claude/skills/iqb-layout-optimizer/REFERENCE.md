# IQB Layout Optimizer - Reference Guide

详细的布局问题诊断和修复方案。

## 辅助工具

### diagnose_overfull.py
自动解析 LaTeX 日志，提取和诊断所有 Overfull 警告。

**用法：**
```bash
python3 .claude/skills/iqb-layout-optimizer/helpers/diagnose_overfull.py examples/membrane-pore-jc.log
```

**输出：**
- Overfull hbox/vbox 统计
- 按严重程度分类（严重/中等/轻微）
- 每个问题的位置和修复建议

## Overfull 修复决策树

```
Overfull Warning?
├─ Overfull hbox (文字太宽)
│  ├─ < 5pt: 手动添加 \\ 断行
│  ├─ 5-15pt: 缩短文字或调整列宽
│  └─ > 15pt: 重写内容或改变布局
│
└─ Overfull vbox (内容太高)
   ├─ < 3pt: 减小图片 0.05\textheight
   ├─ 3-10pt: 删除 1-2 行或减小图片
   └─ > 10pt: 拆分为两页
```

## 布局模块选择指南

### 图片类型决策

```
图片方向？
├─ 竖版 (height > width × 1.2)
│  ├─ 普通竖版
│  │  └─ \iqblayouttwo{text}{\iqbfig[height=0.5\textheight]{...}{...}}
│  │     (1/3 text + 2/3 image)
│  │
│  └─ 特高竖版
│     └─ 2:1 layout (1 image + 2 text)
│        \begin{columns}
│          \begin{column}{0.31\textwidth} % 图
│          \begin{column}{0.64\textwidth} % 详细文字和 caption
│
├─ 横版 (宽 ≥ 高)
│  └─ \iqblayouttwo{text}{image}
│     或 \iqbtextimage[0.48]{text}{image}
│
├─ 超宽 (width ≥ height × 1.5)
│  └─ 2:1 variant (image 占 2, text 占 1)
│     或全宽图 + 下方文字
│
└─ 多图
   ├─ 2 图: \iqbtwofig[height=0.45\textheight]{...}{...}{...}{...}
   ├─ 3 图: \iqbthreefig[height=0.35\textheight]{...}
   └─ 4 图: \iqbfourfig[height=0.3\textheight]{...}
```

### 文字内容决策

```
内容类型？
├─ 纯文字 (无图)
│  ├─ 对比性内容
│  │  └─ \iqbtwocolumn{left}{right}
│  │
│  ├─ 关键要点
│  │  └─ \iqbkeypoints{\item ...}
│  │
│  └─ 核心问题
│     └─ \iqbquestion{...}
│
├─ 文字 + 图片
│  └─ 见上方"图片类型决策"
│
├─ 时间线/流程
│  └─ \iqbtimeline{\item[Step 1] ...}
│
└─ 结论总结
   └─ \iqbconclusion{\item ...}
```

## 图片尺寸速查表

| 场景 | 推荐高度 | 备注 |
|------|---------|------|
| 单图（重要） | 0.5-0.6\textheight | 主要结果图 |
| 单图（辅助） | 0.4-0.5\textheight | 示意图、流程图 |
| 双图并排 | 0.45-0.55\textheight | 对比、前后 |
| 三图并排 | 0.35-0.4\textheight | 参数扫描 |
| 四图 2×2 | 0.28-0.32\textheight | 多条件对比 |
| 竖版在 column | 0.5-0.65\textheight | 利用竖向空间 |
| 宽图 | 0.45-0.5\textheight | 保持可读性 |

**最小可接受尺寸：** 0.35\textheight（更小会难以辨识）

## 内容密度控制

### 文字行数建议

| 字号 | 行间距 | 推荐最大行数 |
|------|--------|-------------|
| \scriptsize | 1.2 | 12 行 |
| \footnotesize | 1.2 | 10 行 |
| \small | 1.2 | 8 行 |

**超过最大行数？**
1. 浓缩文字（删除冗余）
2. 使用层级结构（主要点 + 子点）
3. 拆分为两页

### Bullet Points 建议

- **理想：** 4-5 个主要点
- **最多：** 6-7 个点
- **每点：** 1 行（最多 2 行）

**超过 7 个点？**
- 合并相关点
- 使用二级 bullet points
- 拆分为两页

## 常见布局模式

### 模式 1: 方法说明 + 示意图（竖版）

```latex
\begin{frame}{创新点的 Punchline 标题}
  \iqblayouttwo{
    \textbf{核心创新：}

    简短描述（3-5 行，每行长句）

    \medskip

    \iqbitemize{
      \item 关键点 1
      \item 关键点 2
      \item 关键点 3
    }
  }{
    \iqbfig[height=0.55\textheight]{vertical_diagram.png}{%
      简短 caption
    }
  }
\end{frame}
```

### 模式 2: 结果展示 + 横版图

```latex
\begin{frame}{发现的 Punchline 标题}
  \iqblayouttwo{
    \textbf{主要发现：}

    \iqbitemize{
      \item 观察 1（定量数据）
      \item 观察 2（定量数据）
      \item 观察 3（定量数据）
    }

    \medskip

    \textbf{物理意义：}

    简短解释（2-3 行）
  }{
    \iqbfig[height=0.5\textheight]{result_plot.png}{%
      图 N：详细 caption
    }
  }
\end{frame}
```

### 模式 3: 对比结果（双图）

```latex
\begin{frame}{对比结论的 Punchline 标题}
  \iqbtwofig[height=0.48\textheight]{
    method1_result.png
  }{
    方法 1 结果：简短描述
  }{
    method2_result.png
  }{
    方法 2 结果：简短描述
  }

  \medskip

  \textbf{关键对比：}
  两种方法的差异和物理解释（1-2 行）
\end{frame}
```

### 模式 4: 特高竖版图（详细解释）

```latex
\begin{frame}{Punchline 标题}
  \begin{columns}[T]
    \begin{column}{0.31\textwidth}
      \includegraphics[height=0.65\textheight]{very_tall.png}
    \end{column}
    \begin{column}{0.64\textwidth}
      \textbf{图 N 详细解读：}

      这是一个特别高的示意图，包含多个子面板...
      （可以写 5-7 行详细说明）

      \medskip

      \textbf{Panel A:} 说明\\
      \textbf{Panel B:} 说明\\
      \textbf{Panel C:} 说明\\

      \medskip

      \textbf{物理意义：} 总结（2-3 行）
    \end{column}
  \end{columns}
\end{frame}
```

## 拆分页面策略

### 何时拆分？

满足以下任一条件应考虑拆分：

1. **Overfull vbox > 10pt**
2. **文字行数 > 12**
3. **Bullet points > 7**
4. **多个复杂概念混在一页**
5. **图片被迫小于 0.4\textheight**

### 如何拆分？

**原则：** 每页一个核心信息

```
原始页面：方法 A 的原理 + 实现 + 验证

拆分为：
├─ 页面 1: 方法 A 的核心原理 + 示意图
│  标题：方法 A 的创新点 [punchline]
│
└─ 页面 2: 方法 A 的验证结果 + 数据图
   标题：方法 A 的验证效果 [punchline]
```

**每页都有新的 punchline 标题！**

## 列宽调整速查

### 标准列宽组合

```latex
% 50-50 均分
\begin{column}{0.48\textwidth}...\begin{column}{0.48\textwidth}

% 1/3 + 2/3（文字少图大）
\begin{column}{0.31\textwidth}...\begin{column}{0.64\textwidth}

% 2/3 + 1/3（文字多图小）
\begin{column}{0.64\textwidth}...\begin{column}{0.31\textwidth}

% 40-60（文字适中）
\begin{column}{0.38\textwidth}...\begin{column}{0.58\textwidth}

% 三列均分
\begin{column}{0.31\textwidth}...(×3)
```

### 微调建议

- 文字稍多 → 左栏 +0.05, 右栏 -0.05
- 图片稍大 → 右栏 +0.05, 左栏 -0.05
- Overfull hbox → 对应栏 +0.03

## Caption 优化策略

### Caption 过长？

**策略 1：简化 Caption**
```latex
% 改前（5 行）
\iqbfig[...]{image.png}{%
  图 3：孔闭合的完整四个阶段的详细动态过程。（A）初始平衡孔状态，水分子...（B）半径开始缩小...（C）...（D）...
}

% 改后（1 行）
\iqbfig[...]{image.png}{图 3：孔闭合四阶段（A→B→C→D）}
```

**策略 2：Caption 移到文字栏**
```latex
\iqblayouttwo{
  \textbf{图 3 解读：}

  详细说明每个 panel...（这里可以写 5-7 行）
}{
  \includegraphics[height=0.55\textheight]{image.png}
}
```

**策略 3：表格式 Caption**
```latex
\begin{tabular}{@{}ll@{}}
  \textbf{A:} & Brief description \\
  \textbf{B:} & Brief description \\
  \textbf{C:} & Brief description \\
\end{tabular}
```

## 优化工作流

```
1. 诊断 (diagnose_overfull.py)
   ↓
2. 分类问题（严重/中等/轻微）
   ↓
3. 优先修复严重问题
   ├─ Overfull vbox > 10pt → 拆分页面
   ├─ Overfull hbox > 15pt → 重写文字
   └─ 竖版图堆叠 → 改用 column
   ↓
4. 修复中等问题
   ├─ 调整图片高度
   ├─ 浓缩文字
   └─ 调整列宽
   ↓
5. 修复轻微问题
   ├─ 手动断行
   └─ 微调尺寸
   ↓
6. 重新编译验证
   ↓
7. 重复直至无警告
```

## 禁忌操作

### ❌ 绝对不要做

1. **使用 `[shrink=10]`**
   - 强制压缩破坏排版
   - 掩盖根本问题

2. **手动 `\vspace{-2cm}`**
   - 破坏语义结构
   - 难以维护

3. **过度减小字号**
   - `\tiny` 在正文中不可读
   - 违反模板规范

4. **堆叠竖版图**
   - 图片太小
   - 浪费横向空间

5. **忽略 Overfull 警告**
   - "看起来还行" 不等于正确
   - 可能在不同设备显示异常

### ✅ 应该做

1. **使用语义间距** (`\medskip`, `\iqbsep`)
2. **调整内容而非强制压缩**
3. **拆分过载页面**
4. **使用预定义布局模块**
5. **保持一致的图片尺寸**
