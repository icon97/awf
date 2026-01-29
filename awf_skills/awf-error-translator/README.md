# AWF Error Translator - UE5/Game Development Extension

Extension cho awf-error-translator skill để hỗ trợ Unreal Engine 5, C++, và Blueprint errors.

> **Note**: File này bổ sung cho SKILL.md, chứa error translations cho game development.

---

## 🎮 UE5 Error Detection

### Error Source Detection:
```
Detect error type from context:

1. C++ Compile Errors
   - Pattern: "error C[0-9]+"
   - Source: Visual Studio / UnrealBuildTool

2. Linker Errors
   - Pattern: "error LNK[0-9]+"
   - Source: Linker

3. Blueprint Errors
   - Pattern: "Blueprint Runtime Error"
   - Source: PIE / Packaged game

4. UE5 Runtime Errors
   - Pattern: "Assertion failed", "Access violation"
   - Source: Game runtime

5. Shader Errors
   - Pattern: "Shader compilation failed"
   - Source: Material compiler
```

---

## C++ Error Translations

### Common Compile Errors:
| Error | Message | Giải thích | Fix |
|-------|---------|-----------|-----|
| C2065 | 'identifier': undeclared identifier | Biến/class chưa khai báo | Thêm #include hoặc forward declare |
| C2511 | 'function': overloaded member function not found | Virtual function signature không khớp | Check base class, match signature |
| C4430 | missing type specifier - int assumed | Thiếu kiểu dữ liệu | Forward declare hoặc #include header |
| C2039 | 'member': is not a member of 'class' | Class không có member này | Check spelling, include đúng header |
| C2664 | cannot convert argument | Kiểu dữ liệu không khớp | Cast hoặc dùng đúng type |
| C2248 | cannot access private member | Truy cập private member | Dùng getter/setter hoặc friend |
| C2143 | syntax error: missing ';' | Thiếu dấu chấm phẩy | Thêm ; ở cuối statement |
| C2061 | syntax error: identifier | Lỗi cú pháp | Check typo, missing include |

### Linker Errors:
| Error | Message | Giải thích | Fix |
|-------|---------|-----------|-----|
| LNK2019 | unresolved external symbol | Thiếu implementation | Implement function trong .cpp |
| LNK2001 | unresolved external symbol | Thiếu module dependency | Thêm module vào Build.cs |
| LNK1104 | cannot open file | Thiếu library | Check library path, install SDK |
| LNK2005 | already defined | Duplicate symbol | Check include guards, ODR |

---

## Blueprint Error Translations

### Runtime Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Accessed None" | Đang dùng object null | Thêm IsValid check trước khi dùng |
| "Array index out of bounds" | Index vượt quá array size | Check array length trước khi access |
| "Infinite loop detected" | Loop không có điều kiện thoát | Thêm break condition |
| "Cast to X failed" | Cast sai class type | Check class type trước khi cast |
| "Division by zero" | Chia cho 0 | Check divisor != 0 |
| "Pure virtual function called" | Gọi function chưa implement | Implement function trong subclass |

### Compile Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Unknown pin type" | Pin type không hợp lệ | Refresh node, check variable type |
| "Incompatible pin types" | Không thể connect 2 pins | Add conversion node |
| "Circular dependency" | 2 Blueprints reference nhau | Break cycle, use Interface |
| "Missing connection" | Pin bắt buộc chưa connect | Connect required pin |

---

## UE5 Runtime Error Translations

### Crash Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Assertion failed" | Điều kiện check thất bại | Xem callstack, fix logic bug |
| "Access violation" | Null pointer dereference | Check IsValid() trước khi dùng |
| "Stack overflow" | Recursion quá sâu | Add base case, limit depth |
| "Out of memory" | Hết RAM | Optimize memory, reduce assets |
| "GPU crash" | GPU overload | Reduce draw calls, simplify shaders |

### GC Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Object is pending kill" | Object đang bị destroy | Check IsValid(), don't cache |
| "Garbage collected" | Object bị GC thu hồi | Dùng UPROPERTY() để giữ reference |
| "Stale reference" | Reference đến object đã destroy | Use TWeakObjectPtr |

---

## Nakama/Multiplayer Error Translations

### Nakama Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Connection refused" | Không kết nối được server | Check server URL, port, firewall |
| "Authentication failed" | Đăng nhập thất bại | Check credentials, token expired |
| "Match not found" | Không tìm thấy match | Check match ID, create new match |
| "RPC failed" | Remote call thất bại | Check function name, parameters |

### Replication Errors:
| Error | Giải thích | Fix |
|-------|-----------|-----|
| "Property not replicated" | Property không sync | Add UPROPERTY(Replicated) |
| "RPC not executed" | RPC không chạy | Check Server/Client specifier |
| "NetGUID mismatch" | Object ID không khớp | Check spawn order, authority |

---

## Error Translation Format

### Output Template:
```
🔴 Error: [Original Error Message]

📖 Giải thích:
[Human-friendly explanation in Vietnamese]

🔧 Cách fix:
1. [Step 1]
2. [Step 2]
3. [Step 3]

📚 Tham khảo:
- [Link to UE5 docs if applicable]
- [Related workflow: /debug]
```

### Example:
```
🔴 Error: error C2065: 'UVehicleSubsystem': undeclared identifier

📖 Giải thích:
Compiler không biết UVehicleSubsystem là gì vì chưa include header file.

🔧 Cách fix:
1. Thêm #include "Subsystems/VehicleSubsystem.h" ở đầu file
2. Hoặc forward declare: class UVehicleSubsystem;
3. Check Build.cs có dependency đúng module không

📚 Tham khảo:
- UE5 Docs: Include What You Use
- Workflow: /debug để xem thêm
```

