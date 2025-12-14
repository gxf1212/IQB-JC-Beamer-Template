#!/usr/bin/env python3
"""
IQB Layout Optimizer - Overfull Diagnostic Helper
从编译日志中提取和诊断 Overfull 警告
"""

import sys
import re
from collections import defaultdict
from pathlib import Path


def parse_log_file(log_path):
    """
    解析 LaTeX 日志文件，提取 Overfull 警告

    Returns:
        dict: {
            'overfull_hbox': [(line_num, width, context), ...],
            'overfull_vbox': [(line_num, height, context), ...]
        }
    """
    with open(log_path, 'r', encoding='utf-8', errors='ignore') as f:
        log_content = f.read()

    results = {
        'overfull_hbox': [],
        'overfull_vbox': []
    }

    # 匹配 Overfull \hbox
    hbox_pattern = r'Overfull \\hbox \(([0-9.]+)pt too wide\).*?lines? (\d+)--(\d+)'
    for match in re.finditer(hbox_pattern, log_content):
        width = float(match.group(1))
        line_start = int(match.group(2))
        line_end = int(match.group(3))

        # 提取上下文
        context_start = log_content.find(match.group(0))
        context_end = min(context_start + 200, len(log_content))
        context = log_content[context_start:context_end]

        results['overfull_hbox'].append({
            'width': width,
            'line_start': line_start,
            'line_end': line_end,
            'context': context[:100]  # 前 100 字符
        })

    # 匹配 Overfull \vbox
    vbox_pattern = r'Overfull \\vbox \(([0-9.]+)pt too high\).*?line (\d+)'
    for match in re.finditer(vbox_pattern, log_content):
        height = float(match.group(1))
        line_num = int(match.group(2))

        context_start = log_content.find(match.group(0))
        context_end = min(context_start + 200, len(log_content))
        context = log_content[context_start:context_end]

        results['overfull_vbox'].append({
            'height': height,
            'line': line_num,
            'context': context[:100]
        })

    return results


def diagnose_overfull(overfull_data):
    """
    诊断 Overfull 问题并提供修复建议
    """
    suggestions = []

    # 诊断 Overfull hbox
    for hbox in overfull_data['overfull_hbox']:
        width = hbox['width']
        lines = f"{hbox['line_start']}-{hbox['line_end']}"

        if width < 5:
            severity = "轻微"
            fix = "可能是单词换行问题，尝试手动添加 \\\\ 断行"
        elif width < 15:
            severity = "中等"
            fix = "文字过长，建议缩短内容或使用更窄的列宽"
        else:
            severity = "严重"
            fix = "严重溢出，需要重写内容或调整布局"

        suggestions.append({
            'type': 'Overfull hbox',
            'severity': severity,
            'location': f"Lines {lines}",
            'amount': f"{width}pt",
            'fix': fix,
            'context': hbox['context']
        })

    # 诊断 Overfull vbox
    for vbox in overfull_data['overfull_vbox']:
        height = vbox['height']
        line = vbox['line']

        if height < 3:
            severity = "轻微"
            fix = "内容略多，尝试减小图片高度 0.05\\textheight"
        elif height < 10:
            severity = "中等"
            fix = "内容过多，建议删除 1-2 行文字或减小图片"
        else:
            severity = "严重"
            fix = "严重溢出，需要拆分为两页或大幅度减少内容"

        suggestions.append({
            'type': 'Overfull vbox',
            'severity': severity,
            'location': f"Line {line}",
            'amount': f"{height}pt",
            'fix': fix,
            'context': vbox['context']
        })

    return suggestions


def generate_report(log_path):
    """生成完整的诊断报告"""
    print("\n=== IQB Layout Overfull Diagnostic ===\n")
    print(f"Log File: {log_path}\n")

    overfull_data = parse_log_file(log_path)

    total_hbox = len(overfull_data['overfull_hbox'])
    total_vbox = len(overfull_data['overfull_vbox'])

    print(f"Total Overfull Warnings: {total_hbox + total_vbox}")
    print(f"  - Overfull hbox: {total_hbox}")
    print(f"  - Overfull vbox: {total_vbox}\n")

    if total_hbox + total_vbox == 0:
        print("✅ No overfull warnings found!")
        return

    suggestions = diagnose_overfull(overfull_data)

    print("=== Detailed Diagnostics ===\n")

    # 按严重程度分组
    by_severity = defaultdict(list)
    for sug in suggestions:
        by_severity[sug['severity']].append(sug)

    for severity in ['严重', '中等', '轻微']:
        if severity in by_severity:
            print(f"\n{severity}问题 ({len(by_severity[severity])}):")
            for i, sug in enumerate(by_severity[severity], 1):
                print(f"\n{i}. [{sug['type']}] {sug['location']}")
                print(f"   溢出量: {sug['amount']}")
                print(f"   修复建议: {sug['fix']}")
                if sug.get('context'):
                    print(f"   上下文: {sug['context'][:80]}...")

    print("\n=== Summary Recommendations ===\n")
    print("1. 优先修复'严重'级别的问题")
    print("2. 使用 iqb-layout-optimizer Skill 自动应用修复")
    print("3. 修复后重新编译验证")


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 diagnose_overfull.py <log_file>")
        print("Example: python3 diagnose_overfull.py examples/membrane-pore-jc.log")
        sys.exit(1)

    log_path = sys.argv[1]

    if not Path(log_path).exists():
        print(f"Error: Log file not found: {log_path}")
        sys.exit(1)

    generate_report(log_path)


if __name__ == "__main__":
    main()
