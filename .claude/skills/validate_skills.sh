#!/bin/bash
# IQB Beamer Skills 验证脚本
# 检查所有 Skills 是否正确安装和配置

set -e

SKILLS_DIR=".claude/skills"
REQUIRED_SKILLS=(
    "iqb-content-planner"
    "iqb-slide-writer"
    "iqb-compiler"
    "iqb-layout-optimizer"
    "iqb-quality-checker"
)

echo "========================================="
echo "IQB Beamer Skills 验证工具"
echo "========================================="
echo ""

# 检查 skills 目录是否存在
if [ ! -d "$SKILLS_DIR" ]; then
    echo "❌ 错误：.claude/skills 目录不存在"
    echo "   请运行：mkdir -p .claude/skills"
    exit 1
fi

echo "✅ Skills 目录存在: $SKILLS_DIR"
echo ""

# 检查每个必需的 Skill
echo "检查必需的 Skills..."
echo "-------------------------------------------"

all_present=true
for skill in "${REQUIRED_SKILLS[@]}"; do
    skill_dir="$SKILLS_DIR/$skill"
    skill_md="$skill_dir/SKILL.md"

    if [ ! -d "$skill_dir" ]; then
        echo "❌ 缺失 Skill 目录: $skill"
        all_present=false
    elif [ ! -f "$skill_md" ]; then
        echo "❌ 缺失 SKILL.md: $skill"
        all_present=false
    else
        echo "✅ $skill"

        # 检查 YAML frontmatter
        if ! grep -q "^---$" "$skill_md"; then
            echo "   ⚠️  警告：SKILL.md 缺少 YAML frontmatter"
        fi

        # 检查必需字段
        if ! grep -q "^name:" "$skill_md"; then
            echo "   ⚠️  警告：缺少 'name' 字段"
        fi

        if ! grep -q "^description:" "$skill_md"; then
            echo "   ⚠️  警告：缺少 'description' 字段"
        fi
    fi
done

echo ""

if [ "$all_present" = false ]; then
    echo "❌ 验证失败：部分 Skills 缺失或配置不正确"
    exit 1
fi

echo "✅ 所有必需的 Skills 已正确安装"
echo ""

# 检查辅助工具
echo "检查辅助工具..."
echo "-------------------------------------------"

if [ -f "tools/extract_pdf_page.py" ]; then
    echo "✅ PDF 提取工具：tools/extract_pdf_page.py"
else
    echo "⚠️  可选工具缺失：tools/extract_pdf_page.py"
fi

if [ -d "theme" ]; then
    echo "✅ 主题目录：theme/"

    if [ -f "theme/beamerthemeiqb.sty" ]; then
        echo "✅ 主题文件：theme/beamerthemeiqb.sty"
    else
        echo "❌ 缺失主题文件：theme/beamerthemeiqb.sty"
    fi

    if [ -f "theme/iqb-layouts.sty" ]; then
        echo "✅ 布局模块：theme/iqb-layouts.sty"
    else
        echo "❌ 缺失布局模块：theme/iqb-layouts.sty"
    fi

    if [ -f "theme/images/header.png" ]; then
        echo "✅ Header 图片：theme/images/header.png"
    else
        echo "⚠️  缺失 Header 图片：theme/images/header.png"
    fi
else
    echo "❌ 主题目录不存在：theme/"
fi

echo ""

# 检查 XeLaTeX
echo "检查编译环境..."
echo "-------------------------------------------"

if [ -f "/mnt/d/texlive/2022/bin/win32/xelatex.exe" ]; then
    echo "✅ XeLaTeX：/mnt/d/texlive/2022/bin/win32/xelatex.exe"
else
    echo "⚠️  XeLaTeX 路径可能不正确"
    echo "   预期路径：/mnt/d/texlive/2022/bin/win32/xelatex.exe"
    echo "   如果你的 TeXLive 安装在其他位置，请更新 iqb-compiler SKILL.md"
fi

# 检查 Python（用于 PDF 工具）
if command -v python3 &> /dev/null; then
    echo "✅ Python3：$(which python3)"
else
    echo "⚠️  Python3 未找到（PDF 提取工具需要）"
fi

echo ""

# 检查文档
echo "检查文档..."
echo "-------------------------------------------"

if [ -f "$SKILLS_DIR/README.md" ]; then
    echo "✅ 主文档：.claude/skills/README.md"
else
    echo "⚠️  缺失主文档：.claude/skills/README.md"
fi

if [ -f "$SKILLS_DIR/QUICKSTART.md" ]; then
    echo "✅ 快速入门：.claude/skills/QUICKSTART.md"
else
    echo "⚠️  缺失快速入门：.claude/skills/QUICKSTART.md"
fi

if [ -f "CLAUDE.md" ]; then
    echo "✅ 项目指南：CLAUDE.md"
else
    echo "⚠️  缺失项目指南：CLAUDE.md"
fi

echo ""

# 统计信息
echo "========================================="
echo "统计信息"
echo "========================================="

skill_count=$(find "$SKILLS_DIR" -maxdepth 1 -type d ! -path "$SKILLS_DIR" | wc -l)
echo "Skills 总数：$skill_count"

total_lines=0
for skill in "${REQUIRED_SKILLS[@]}"; do
    skill_md="$SKILLS_DIR/$skill/SKILL.md"
    if [ -f "$skill_md" ]; then
        lines=$(wc -l < "$skill_md")
        total_lines=$((total_lines + lines))
        echo "  - $skill: $lines 行"
    fi
done

echo "Skills 总行数：$total_lines"
echo ""

# 最终结果
echo "========================================="
echo "验证完成"
echo "========================================="
echo ""
echo "✅ IQB Beamer Skills 工作流系统已就绪！"
echo ""
echo "下一步："
echo "  1. 阅读快速入门：.claude/skills/QUICKSTART.md"
echo "  2. 查看完整文档：.claude/skills/README.md"
echo "  3. 开始创建演示：告诉 Claude '我要做一个 JC 演示'"
echo ""
