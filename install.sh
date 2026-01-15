#!/bin/bash
# AWF Installer for Mac/Linux
# ⚠️ QUAN TRỌNG: Chạy lệnh này trong Terminal của Antigravity/Cursor, KHÔNG PHẢI Terminal bên ngoài!

REPO_URL="https://raw.githubusercontent.com/TUAN130294/awf/main/workflows"
WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md" 
    "debug.md" "refactor.md" "test.md" "run.md" 
    "init.md" "recap.md" "rollback.md" "save_brain.md" 
    "audit.md" "cloudflare-tunnel.md" "README.md"
)

GLOBAL_DIR="$HOME/AWF-Workflows"

# Parse arguments
MODE="project"
for arg in "$@"; do
    case $arg in
        --global|-g) MODE="global" ;;
        --link|-l) MODE="link" ;;
    esac
done

echo ""

if [[ "$MODE" == "global" ]]; then
    echo "🌍 CHẾ ĐỘ GLOBAL: Cài vào thư mục trung tâm"
    echo "   Đường dẫn: $GLOBAL_DIR"
    echo ""
    TARGET_DIR="$GLOBAL_DIR"
    
elif [[ "$MODE" == "link" ]]; then
    echo "🔗 CHẾ ĐỘ LINK: Copy từ thư mục trung tâm vào project hiện tại"
    echo ""
    
    if [[ ! -d "$GLOBAL_DIR" ]]; then
        echo "❌ Chưa cài Global! Chạy lệnh sau trước:"
        echo '   curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | sh -s -- --global'
        exit 1
    fi
    
    TARGET_DIR=".agent/workflows"
    mkdir -p "$TARGET_DIR"
    cp -r "$GLOBAL_DIR"/* "$TARGET_DIR/"
    
    echo "✅ Đã copy AWF workflows vào project!"
    echo "   Từ: $GLOBAL_DIR"
    echo "   Đến: $TARGET_DIR"
    exit 0
    
else
    echo "📁 CHẾ ĐỘ PROJECT: Cài vào thư mục hiện tại"
    echo ""
    echo "⚠️  LƯU Ý: Hãy chắc chắn bạn đang chạy lệnh này trong:"
    echo "   Terminal của Antigravity/Cursor (bên trong IDE)"
    echo "   KHÔNG PHẢI Terminal bên ngoài!"
    echo ""
    TARGET_DIR=".agent/workflows"
fi

echo "🚀 Đang cài đặt Antigravity Workflow Framework (AWF)..."
echo ""

# Create directory
mkdir -p "$TARGET_DIR"

# Download files
success=0
failed=0
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$TARGET_DIR/$wf" "$REPO_URL/$wf"; then
        echo "   ✅ $wf"
        ((success++))
    else
        echo "   ❌ $wf (Lỗi tải)"
        ((failed++))
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Hoàn tất! Đã cài $success/${#WORKFLOWS[@]} workflows."

if [[ "$MODE" == "global" ]]; then
    echo ""
    echo "📌 ĐÃ CÀI GLOBAL!"
    echo "   AWF đã được lưu tại: $GLOBAL_DIR"
    echo ""
    echo "👉 Với mỗi project MỚI, chỉ cần chạy (trong Terminal của Antigravity):"
    echo '   curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | sh -s -- --link'
    echo ""
    echo "   Lệnh trên sẽ copy nhanh AWF vào project chỉ trong 1 giây!"
else
    echo ""
    echo "👉 Restart Antigravity/IDE để nhận diện lệnh mới."
    echo "👉 Gõ '/' trong chat để thấy các siêu lệnh!"
fi

echo ""
echo "📖 Hướng dẫn: https://tuan130294.github.io/awsweb"
echo ""
