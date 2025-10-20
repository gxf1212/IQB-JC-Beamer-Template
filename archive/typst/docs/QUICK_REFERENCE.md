# Touying JC 快速参考

## 🚀 一分钟开始

```typst
#import "@preview/touying:0.6.1": *
#import themes.university: *

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [文献标题],
    author: [你的名字],
    institution: [IQB Lab],
  ),
)

#set page(width: 13cm, height: 7cm)

= Introduction
== First Slide
内容...
```

## 📐 常用布局速查

### 双列（左右分栏）
```typst
#slide(composer: (1fr, 1fr))[
  左列内容
][
  右列内容
]
```

### 三列
```typst
#grid(
  columns: (1fr, 1fr, 1fr),
  [列1], [列2], [列3]
)
```

### 精确定位
```typst
#place(
  dx: 6cm,   // 距左边 6cm
  dy: 1cm,   // 距顶部 1cm
  image("fig.png", width: 5cm)
)
```

### 四图布局
```typst
// 小-大-大模式
#place(dx: 0cm, dy: 1cm, image("s.png", width: 3cm))
#place(dx: 3cm, dy: 1cm, image("m.png", width: 5cm))
#place(dx: 8cm, dy: 1cm, image("r.png", width: 4cm))
```

## 🎬 动画

### 基础暂停
```typst
第一帧
#pause
第二帧
```

### 同时显示
```typst
#meanwhile
与上一帧同时显示
```

### 数学动画
```typst
$
  f(x) &= pause x^2 + 1 \
  &= pause (x+1)(x-1) \
$
```

## 📏 尺寸速查（13cm×7cm）

| 位置 | dx | dy |
|------|----|----|
| 左上 | 0cm | 0cm |
| 中央 | 6.5cm | 3.5cm |
| 右下 | ~10cm | ~6cm |

| 大小 | 值 |
|------|-----|
| 全宽 | 13cm |
| 半宽 | 6cm |
| 全高 | 7cm |
| 半高 | 3.5cm |

## ⚡ 常用命令

```bash
# 编译
typst compile slides.typ output.pdf

# 自动编译
typst watch slides.typ output.pdf

# 查看版本
typst --version
```

## 🎨 样式

### 字体大小
```typst
#text(24pt)[大标题]
#text(20pt)[正文]
#text(14pt)[小字]
```

### 颜色
```typst
#text(fill: red)[红色文字]
#box(fill: blue.lighten(90%))[蓝色背景]
```

### 对齐
```typst
#align(center)[居中]
#align(left)[左对齐]
#align(right)[右对齐]
```

## 📦 完整示例

```typst
#slide(composer: (1fr, 1fr))[
  = Methods
  == Dataset

  #image("data.png", width: 100%)

  *Features:*
  - High quality
  - Large scale
][
  #image("result.png", width: 100%)

  *Results:*
  - RMSD < 2.0 Å
  - R > 0.85
]
```

## 🔗 链接

- [完整文档](README.md)
- [布局片段库](templates/layout-snippets.typ)
- [Touying 官方](https://touying-typ.github.io/)
