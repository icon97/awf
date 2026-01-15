# AWF Installer for Windows (PowerShell)
# ⚠️ QUAN TRỌNG: Chạy lệnh này trong Terminal của Antigravity/Cursor, KHÔNG PHẢI CMD/PowerShell bên ngoài!

param(
    [switch]$Global,
    [switch]$Link
)

$RepoUrl = "https://raw.githubusercontent.com/TUAN130294/awf/main/workflows"
$Workflows = @(
    "plan.md", "code.md", "visualize.md", "deploy.md", 
    "debug.md", "refactor.md", "test.md", "run.md", 
    "init.md", "recap.md", "rollback.md", "save_brain.md", 
    "audit.md", "cloudflare-tunnel.md", "README.md"
)

$GlobalDir = "$env:USERPROFILE\AWF-Workflows"

# Mode selection
if ($Global) {
    Write-Host ""
    Write-Host "🌍 CHẾ ĐỘ GLOBAL: Cài vào thư mục trung tâm" -ForegroundColor Cyan
    Write-Host "   Đường dẫn: $GlobalDir" -ForegroundColor DarkGray
    Write-Host ""
    $TargetDir = $GlobalDir
} elseif ($Link) {
    Write-Host ""
    Write-Host "🔗 CHẾ ĐỘ LINK: Copy từ thư mục trung tâm vào project hiện tại" -ForegroundColor Cyan
    Write-Host ""
    
    if (-not (Test-Path $GlobalDir)) {
        Write-Host "❌ Chưa cài Global! Chạy lệnh sau trước:" -ForegroundColor Red
        Write-Host '   iex "& { $(irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1) } -Global"' -ForegroundColor Yellow
        exit
    }
    
    $TargetDir = ".agent\workflows"
    if (-not (Test-Path $TargetDir)) {
        New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
    }
    
    Copy-Item -Path "$GlobalDir\*" -Destination $TargetDir -Recurse -Force
    Write-Host "✅ Đã copy AWF workflows vào project!" -ForegroundColor Green
    Write-Host "   Từ: $GlobalDir" -ForegroundColor DarkGray
    Write-Host "   Đến: $TargetDir" -ForegroundColor DarkGray
    exit
} else {
    Write-Host ""
    Write-Host "📁 CHẾ ĐỘ PROJECT: Cài vào thư mục hiện tại" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "⚠️  LƯU Ý: Hãy chắc chắn bạn đang chạy lệnh này trong:" -ForegroundColor Yellow
    Write-Host "   Terminal của Antigravity/Cursor (bên trong IDE)" -ForegroundColor Yellow
    Write-Host "   KHÔNG PHẢI CMD/PowerShell bên ngoài!" -ForegroundColor Yellow
    Write-Host ""
    $TargetDir = ".agent\workflows"
}

Write-Host "🚀 Đang cài đặt Antigravity Workflow Framework (AWF)..." -ForegroundColor Yellow
Write-Host ""

# Create directory
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
    Write-Host "📂 Đã tạo thư mục: $TargetDir" -ForegroundColor Green
}

# Download files
$success = 0
$failed = 0
foreach ($wf in $Workflows) {
    try {
        $url = "$RepoUrl/$wf"
        $output = "$TargetDir\$wf"
        Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
        Write-Host "   ✅ $wf" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   ❌ $wf (Lỗi tải)" -ForegroundColor Red
        $failed++
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 Hoàn tất! Đã cài $success/$($Workflows.Count) workflows." -ForegroundColor Yellow

if ($Global) {
    Write-Host ""
    Write-Host "📌 ĐÃ CÀI GLOBAL!" -ForegroundColor Cyan
    Write-Host "   AWF đã được lưu tại: $GlobalDir" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "👉 Với mỗi project MỚI, chỉ cần chạy (trong Terminal của Antigravity):" -ForegroundColor White
    Write-Host '   iex "& { $(irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1) } -Link"' -ForegroundColor Green
    Write-Host ""
    Write-Host "   Lệnh trên sẽ copy nhanh AWF vào project chỉ trong 1 giây!" -ForegroundColor DarkGray
} else {
    Write-Host ""
    Write-Host "👉 Restart Antigravity/IDE để nhận diện lệnh mới." -ForegroundColor Cyan
    Write-Host "👉 Gõ '/' trong chat để thấy các siêu lệnh!" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "📖 Hướng dẫn chi tiết: https://tuan130294.github.io/awsweb" -ForegroundColor DarkGray
Write-Host ""
