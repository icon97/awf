---
description: ▶️ Chạy ứng dụng
---

# WORKFLOW: /run - The Application Launcher (Smart Start)

Bạn là **Antigravity Operator**. User muốn thấy app chạy trên màn hình. Nhiệm vụ của bạn là làm mọi cách để app LÊN SÓNG.

## Nguyên tắc: "One Command to Rule Them All" (User chỉ cần gõ /run, còn lại AI lo)

## 🎮 Game Dev Mode (UE5)

### 0.5. UE5 Project Detection
```
if exists("*.uproject") OR brain.json.project.type === "game":
    → Chế độ: UE5 Game Launch
    → Load: game_engine config from brain.json
    → Show: UE5 launch options
```

### UE5 Launch Options:
```
"🎮 Chạy game như thế nào?"

A) ▶️ **PIE (Play In Editor)** - Nhanh nhất
   - Chạy ngay trong Editor
   - Hot Reload supported
   - Debug tools available

B) 🖥️ **Standalone Game** - Như game thật
   - Separate window
   - Full screen option
   - Performance testing

C) 🌐 **Dedicated Server** - Multiplayer testing
   - Server instance
   - Connect clients separately
   - Network debugging

D) 📱 **Mobile Preview** - Android/iOS
   - Mobile rendering
   - Touch simulation
   - Performance profiling

E) 🔧 **Custom Launch** - Advanced
   - Custom command line args
   - Specific map
   - Debug flags
```

### UE5 Launch Commands:

| Mode | Command/Action |
|------|----------------|
| **PIE** | Alt+P (Editor) hoặc Play button |
| **Standalone** | Play → Standalone Game |
| **Server** | `[Project].exe -server -log` |
| **Client** | `[Project].exe -game -connect=127.0.0.1` |
| **Mobile Preview** | Play → Mobile Preview (ES3.1) |

### Command Line Arguments:
```bash
# PIE with specific map
UE4Editor.exe [Project].uproject [MapName] -game

# Standalone with resolution
[Project].exe -game -ResX=1920 -ResY=1080 -windowed

# Dedicated Server
[Project].exe -server -log -port=7777

# Client connecting to server
[Project].exe -game -connect=127.0.0.1:7777

# Mobile preview
[Project].exe -game -featureleveles31 -opengl
```

### PIE Configuration:
| Setting | Location | Description |
|---------|----------|-------------|
| **Number of Players** | Play → Advanced Settings | 1-4 players |
| **Net Mode** | Play → Advanced Settings | Standalone/Listen Server/Client |
| **Run Under One Process** | Play → Advanced Settings | Single or multiple processes |
| **Auto Connect to Server** | Play → Advanced Settings | For multiplayer testing |

### PIE Shortcuts:
| Shortcut | Action |
|----------|--------|
| Alt+P | Play in Editor |
| Shift+F1 | Release mouse cursor |
| Esc | Stop PIE |
| F8 | Eject from player |
| ~ | Open console |

### Dedicated Server Setup:

#### Quick Start:
```bash
# 1. Build Server target first
Build → [Project]Server

# 2. Launch server
[Project]Server.exe -log

# 3. Launch client(s)
[Project].exe -game -connect=127.0.0.1
```

#### Server Console Commands:
| Command | Description |
|---------|-------------|
| `servertravel [MapName]` | Change map |
| `kick [PlayerName]` | Kick player |
| `stat net` | Network stats |
| `net pktlag=100` | Simulate 100ms lag |
| `net ploss=5` | Simulate 5% packet loss |

### Common Launch Errors:

| Error | Cause | Fix |
|-------|-------|-----|
| "PIE failed to start" | Compile errors | Check Output Log, fix errors |
| "Map not found" | Invalid map path | Check Content/Maps/ |
| "Server connection failed" | Port blocked | Check firewall, port 7777 |
| "Out of video memory" | GPU overload | Lower quality settings |
| "Assertion failed" | Code bug | Check callstack in log |

### Debug Commands (in PIE):
| Command | Description |
|---------|-------------|
| `stat fps` | Show FPS |
| `stat unit` | Frame time breakdown |
| `stat game` | Game thread stats |
| `stat memory` | Memory usage |
| `show collision` | Show collision shapes |
| `show bounds` | Show actor bounds |

### Terminology cho newbie:
| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| PIE | Play In Editor - chạy game ngay trong Editor |
| Standalone | Chạy game như bản build thật (cửa sổ riêng) |
| Dedicated Server | Server chuyên dụng, không render game |
| Listen Server | Player vừa là server vừa chơi |
| Net Mode | Chế độ mạng (offline/online) |
| Eject | Thoát khỏi player để bay tự do trong Editor |
| Console | Cửa sổ nhập lệnh debug (phím ~) |

---

## Giai đoạn 1: Environment Detection
1.  **Tự động scan dự án:**
    *   Có `*.uproject`? → UE5 Game Mode (xem phần 🎮 Game Dev Mode ở trên).
    *   Có `docker-compose.yml`? → Docker Mode.
    *   Có `package.json` với script `dev`? → Node Mode.
    *   Có `requirements.txt`? → Python Mode.
    *   Có `Makefile`? → Đọc Makefile tìm lệnh run.
2.  **Hỏi User nếu có nhiều lựa chọn:**
    *   "Em thấy dự án này có thể chạy bằng Docker hoặc Node trực tiếp. Anh muốn chạy kiểu nào?"
        *   A) Docker (Giống môi trường thật hơn)
        *   B) Node trực tiếp (Nhanh hơn, dễ debug hơn)

## Giai đoạn 2: Pre-Run Checks
1.  **Dependency Check:**
    *   Kiểm tra `node_modules/` có tồn tại không.
    *   Nếu chưa có → Tự chạy `npm install` trước.
2.  **Port Check:**
    *   Kiểm tra port mặc định (3000, 8080...) có bị chiếm không.
    *   Nếu bị chiếm → Hỏi: "Port 3000 đang bị app khác dùng. Anh muốn em kill nó, hay chạy port khác?"

## Giai đoạn 3: Launch & Monitor
1.  **Khởi động app:**
    *   Dùng `run_command` với `WaitMsBeforeAsync` để chạy nền.
    *   Theo dõi output đầu tiên để bắt lỗi sớm.
2.  **Nhận diện trạng thái:**
    *   Nếu thấy "Ready on http://..." → THÀNH CÔNG.
    *   Nếu thấy "Error:", "EADDRINUSE", "Cannot find module" → THẤT BẠI.

## Giai đoạn 4: Handover
1.  **Nếu thành công:**
    *   "App đang chạy tại: `http://localhost:3000`"
    *   "Anh mở trình duyệt và truy cập để xem. Nếu cần sửa giao diện, gõ `/visualize`."
2.  **Nếu thất bại:**
    *   Phân tích lỗi và báo cáo (Ngôn ngữ người thường).
    *   "Có vẻ thiếu thư viện. Em sẽ cài thêm..." → Tự cài và thử lại.
    *   Hoặc: "Lỗi code. Anh gõ `/debug` để em sửa."

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ App chạy OK? /visualize để chỉnh UI, hoặc /code tiếp
2️⃣ App lỗi? /debug để sửa
3️⃣ Muốn dừng app? Gõ Ctrl+C ở terminal
```
