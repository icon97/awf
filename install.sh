#!/bin/bash
# AWF Installer for Mac/Linux
# Tự động detect Antigravity Global Workflows

REPO_URL="https://raw.githubusercontent.com/TUAN130294/awf/main/workflows"
WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md" 
    "debug.md" "refactor.md" "test.md" "run.md" 
    "init.md" "recap.md" "rollback.md" "save_brain.md" 
    "audit.md" "cloudflare-tunnel.md" "README.md"
)

# Detect paths
ANTIGRAVITY_GLOBAL="$HOME/.gemini/antigravity/global_workflows"
GEMINI_MD="$HOME/.gemini/GEMINI.md"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🚀 AWF - Antigravity Workflow Framework v3.0         ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# 1. Cài Global Workflows
mkdir -p "$ANTIGRAVITY_GLOBAL"
echo "✅ Antigravity Global Path: $ANTIGRAVITY_GLOBAL"

echo "⏳ Đang tải workflows..."
success=0
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$ANTIGRAVITY_GLOBAL/$wf" "$REPO_URL/$wf"; then
        echo "   ✅ $wf"
        ((success++))
    else
        echo "   ❌ $wf"
    fi
done

# 2. Update Global Rules
AWF_INSTRUCTIONS='
# AWF - Antigravity Workflow Framework
Bạn đã được cài đặt AWF. Khi user dùng lệnh /, hãy đọc file workflow tương ứng trong ~/.gemini/antigravity/global_workflows/:
- /plan, /code, /visualize, /deploy, /debug, /test, /run
- /init, /recap, /save-brain, /audit, /refactor, /rollback
'

mkdir -p "$HOME/.gemini"
if [ ! -f "$GEMINI_MD" ]; then
    echo "$AWF_INSTRUCTIONS" > "$GEMINI_MD"
    echo "✅ Đã tạo Global Rules (GEMINI.md)"
else
    if ! grep -q "AWF - Antigravity Workflow Framework" "$GEMINI_MD"; then
        echo "$AWF_INSTRUCTIONS" >> "$GEMINI_MD"
        echo "✅ Đã cập nhật Global Rules (GEMINI.md)"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 HOÀN TẤT! Đã cài $success workflows vào hệ thống."
echo ""
echo "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!"
echo "👉 Thử gõ '/plan' để kiểm tra."
echo ""
