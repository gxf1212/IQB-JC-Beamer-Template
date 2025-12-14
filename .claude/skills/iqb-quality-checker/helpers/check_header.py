#!/usr/bin/env python3
"""
IQB Quality Checker - Header Verification Helper
检查 PDF 中 Header 是否符合 IQB 模板规范
"""

import sys
import subprocess
import json
from pathlib import Path


def check_pdf_page_count(pdf_path):
    """获取 PDF 总页数"""
    try:
        result = subprocess.run(
            ['pdfinfo', pdf_path],
            capture_output=True,
            text=True,
            check=True
        )
        for line in result.stdout.split('\n'):
            if line.startswith('Pages:'):
                return int(line.split(':')[1].strip())
    except Exception as e:
        print(f"Error getting page count: {e}", file=sys.stderr)
        return None


def extract_page(pdf_path, page_num, output_path="/tmp/header_check.png"):
    """提取指定页面为图片"""
    try:
        subprocess.run(
            ['python3', 'tools/extract_pdf_page.py', pdf_path, str(page_num), output_path],
            check=True,
            capture_output=True
        )
        return output_path
    except Exception as e:
        print(f"Error extracting page {page_num}: {e}", file=sys.stderr)
        return None


def check_header_compliance(pdf_path, sample_pages=None):
    """
    检查 Header 是否符合规范

    Args:
        pdf_path: PDF 文件路径
        sample_pages: 要检查的页码列表（None 则检查 3, 5, 7）

    Returns:
        dict: 检查结果
    """
    if sample_pages is None:
        sample_pages = [3, 5, 7]  # 默认检查几个关键页

    total_pages = check_pdf_page_count(pdf_path)
    if total_pages is None:
        return {"error": "Cannot get PDF page count"}

    results = {
        "pdf": pdf_path,
        "total_pages": total_pages,
        "checked_pages": [],
        "issues": []
    }

    for page in sample_pages:
        if page > total_pages:
            continue

        # 提取页面
        img_path = extract_page(pdf_path, page, f"/tmp/header_check_p{page}.png")
        if img_path:
            results["checked_pages"].append({
                "page": page,
                "image": img_path,
                "note": "需要视觉检查 Header 是否全宽且保持比例"
            })

    # 检查首页和末页（不应有 Header）
    if total_pages > 0:
        first_page = extract_page(pdf_path, 1, "/tmp/header_check_p1.png")
        if first_page:
            results["special_pages"] = {
                "cover": {
                    "page": 1,
                    "image": first_page,
                    "note": "封面页不应有 Header"
                }
            }

    if total_pages > 1:
        last_page = extract_page(pdf_path, total_pages, f"/tmp/header_check_p{total_pages}.png")
        if last_page:
            results["special_pages"]["thank_you"] = {
                "page": total_pages,
                "image": last_page,
                "note": "致谢页不应有 Header"
            }

    return results


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 check_header.py <pdf_path> [page1 page2 ...]")
        print("Example: python3 check_header.py examples/membrane-pore-jc.pdf 3 5 7")
        sys.exit(1)

    pdf_path = sys.argv[1]
    sample_pages = [int(p) for p in sys.argv[2:]] if len(sys.argv) > 2 else None

    results = check_header_compliance(pdf_path, sample_pages)

    print("\n=== IQB Header Compliance Check ===\n")
    print(f"PDF: {results['pdf']}")
    print(f"Total Pages: {results.get('total_pages', 'Unknown')}")
    print(f"\nChecked Pages: {len(results['checked_pages'])}")

    for item in results["checked_pages"]:
        print(f"  - Page {item['page']}: {item['image']}")
        print(f"    {item['note']}")

    if "special_pages" in results:
        print("\nSpecial Pages:")
        for name, info in results["special_pages"].items():
            print(f"  - {name.title()} (Page {info['page']}): {info['image']}")
            print(f"    {info['note']}")

    print("\n请使用 Read tool 检查生成的图片，验证：")
    print("  1. Content pages 的 Header 是否全宽")
    print("  2. Header 宽高比是否正确（1999×204）")
    print("  3. Cover 和 Thank You 页是否无 Header")


if __name__ == "__main__":
    main()
