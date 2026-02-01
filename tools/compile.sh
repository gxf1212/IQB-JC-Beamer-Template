#!/bin/bash

# LaTeX编译脚本 - IQB Journal Club Beamer
# 适用于WSL环境，使用Windows TeXLive XeLaTeX编译器
#
# 使用方法：
#   chmod +x compile.sh
#   ./compile.sh [file.tex]

set -e  # 遇到错误立即退出

# 颜色输出定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Windows XeLaTeX路径
XELATEX="/mnt/d/texlive/2022/bin/win32/xelatex.exe"

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 清理临时文件
cleanup() {
    print_info "清理临时文件..."

    # 先尝试杀死可能残留的XeLaTeX进程
    killall -9 xelatex 2>/dev/null || true
    sleep 1

    # 删除LaTeX临时文件
    rm -f *.aux *.log *.toc *.out *.fdb_latexmk *.fls *.synctex.gz \
          *.bbl *.blg *.idx *.ind *.ilg *.lof *.lot *.nav *.snm \
          *.vrb *.xdv *.figlist *.makefile *.fls_latexmk *.run.xml \
          *-blx.bib 2>/dev/null || true

    print_success "临时文件清理完成"
}

# 编译单个LaTeX文件
compile() {
    local tex_file="${1:-qm_chap2.tex}"

    # 获取绝对路径
    local tex_path="$(realpath "$tex_file" 2>/dev/null || echo "$tex_file")"
    local tex_dir="$(dirname "$tex_path")"
    local tex_name="$(basename "$tex_path")"
    local base_name="${tex_name%.tex}"

    # 检查文件是否存在
    if [ ! -f "$tex_path" ]; then
        print_error "未找到 ${tex_file} 文件！"
        exit 1
    fi

    print_info "开始编译 ${tex_name}..."
    print_info "工作目录: ${tex_dir}"

    # 切换到 .tex 文件所在目录
    cd "$tex_dir" || exit 1

    # 编译前先清理
    cleanup

    # 执行XeLaTeX编译
    print_info "执行XeLaTeX编译..."
    if "$XELATEX" -interaction=nonstopmode "$tex_name" > /tmp/xelatex_compile.log 2>&1; then
        print_success "XeLaTeX编译成功"
    else
        print_error "XeLaTeX编译失败，查看日志: /tmp/xelatex_compile.log"
        tail -50 /tmp/xelatex_compile.log
        exit 1
    fi

    # 检查PDF是否生成
    if [ -f "${base_name}.pdf" ]; then
        local pdf_size=$(ls -lh "${base_name}.pdf" | awk '{print $5}')
        local pdf_pages=$(pdfinfo "${base_name}.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}' || echo "未知")

        print_success "成功生成 ${base_name}.pdf (${pdf_pages} 页, ${pdf_size})"

        # 检查overfull警告
        local overfull_count=$(grep -c "Overfull" /tmp/xelatex_compile.log 2>/dev/null || echo "0")
        if [ "$overfull_count" -gt 0 ]; then
            print_warning "发现 ${overfull_count} 个overfull警告"
            print_info "详细信息:"
            grep "Overfull" /tmp/xelatex_compile.log | tail -10
        else
            print_success "无overfull警告，布局完美！"
        fi

        # 编译后清理
        print_info "等待文件释放并清理临时文件..."
        killall -9 xelatex 2>/dev/null || true
        sleep 3  # 等待更长时间确保文件释放
        cleanup

        # 最终验证清理结果
        local remaining_files=$(ls *.aux *.log *.nav *.out *.snm *.toc 2>/dev/null | wc -l)
        if [ "$remaining_files" -eq 0 ]; then
            print_success "所有临时文件已清理完毕"
        else
            print_warning "仍有 ${remaining_files} 个临时文件无法删除（可能被Windows进程锁定）"
        fi

        return 0
    else
        print_error "编译失败，未生成PDF文件"
        exit 1
    fi
}

# 显示帮助信息
show_help() {
    echo "LaTeX编译脚本 - IQB Journal Club Beamer"
    echo ""
    echo "用法："
    echo "  ./compile.sh                    - 编译qm_chap2.tex（默认）"
    echo "  ./compile.sh <file.tex>         - 编译指定的.tex文件"
    echo "  ./compile.sh clean              - 仅清理临时文件"
    echo "  ./compile.sh help               - 显示此帮助信息"
    echo ""
    echo "功能："
    echo "  - 自动调用Windows TeXLive的XeLaTeX编译器"
    echo "  - 编译前后自动清理临时文件"
    echo "  - 检测并显示overfull警告"
    echo "  - 显示PDF文件大小和页数"
    echo ""
    echo "环境要求："
    echo "  - WSL环境"
    echo "  - Windows安装了TeXLive 2022"
    echo "  - XeLaTeX路径: /mnt/d/texlive/2022/bin/win32/xelatex.exe"
}

# 解析命令行参数
case "${1:-}" in
    clean)
        cleanup
        exit 0
        ;;
    help|--help|-h)
        show_help
        exit 0
        ;;
    "")
        compile
        ;;
    *.tex)
        compile "$1"
        ;;
    *)
        print_error "未知参数: $1"
        echo "使用 './compile.sh help' 查看帮助信息"
        exit 1
        ;;
esac
