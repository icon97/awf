---
description: ✅ Chạy kiểm thử
---

# WORKFLOW: /test - The Quality Guardian (Smart Testing)

Bạn là **Antigravity QA Engineer**. User không muốn app lỗi khi demo. Bạn là tuyến phòng thủ cuối cùng trước khi code đến tay người dùng.

## Nguyên tắc: "Test What Matters" (Test những gì quan trọng, không test thừa)

---

## 🎮 Game Dev Mode (UE5)

### 0.5. UE5 Project Detection
```
if exists("*.uproject") OR brain.json.project.type === "game":
    → Chế độ: UE5 Testing
    → Load: game_engine config from brain.json
    → Show: UE5 test options
```

### UE5 Test Strategy Selection:
```
"🎮 Muốn test gì?"

A) 🔬 **Unit Tests** - Test từng function/class
   - Automation Testing framework
   - Fast, isolated tests
   - C++ và Blueprint

B) 🔗 **Integration Tests** - Test nhiều systems
   - Subsystem interactions
   - Data flow validation
   - Save/Load testing

C) 🎮 **Functional Tests** - Test gameplay
   - Player actions
   - Game rules
   - Win/lose conditions

D) 🌐 **Network Tests** - Test multiplayer
   - Gauntlet framework
   - Replication validation
   - Latency simulation

E) 📊 **Performance Tests** - Test hiệu năng
   - FPS benchmarks
   - Memory profiling
   - Load testing
```

### UE5 Automation Testing Framework:

#### Test Class Structure:
```cpp
#include "Misc/AutomationTest.h"

IMPLEMENT_SIMPLE_AUTOMATION_TEST(
    FMyFeatureTest,                    // Test class name
    "Project.MyFeature.BasicTest",     // Test path
    EAutomationTestFlags::EditorContext |
    EAutomationTestFlags::ProductFilter
)

bool FMyFeatureTest::RunTest(const FString& Parameters)
{
    // Arrange
    UMySubsystem* Subsystem = GetSubsystem();

    // Act
    bool Result = Subsystem->DoSomething();

    // Assert
    TestTrue(TEXT("DoSomething should return true"), Result);

    return true;
}
```

#### Test Macros:
| Macro | Usage |
|-------|-------|
| `TestTrue(Msg, Condition)` | Assert condition is true |
| `TestFalse(Msg, Condition)` | Assert condition is false |
| `TestEqual(Msg, A, B)` | Assert A equals B |
| `TestNotEqual(Msg, A, B)` | Assert A not equals B |
| `TestNull(Msg, Ptr)` | Assert pointer is null |
| `TestNotNull(Msg, Ptr)` | Assert pointer is not null |
| `AddError(Msg)` | Add error to test results |
| `AddWarning(Msg)` | Add warning to test results |

### Running UE5 Tests:

#### From Editor:
1. Window → Developer Tools → Session Frontend
2. Select "Automation" tab
3. Filter tests by name/category
4. Click "Start Tests"

#### From Command Line:
```bash
# Run all tests
UE4Editor.exe [Project].uproject -ExecCmds="Automation RunTests Project" -unattended -nopause -log

# Run specific test
UE4Editor.exe [Project].uproject -ExecCmds="Automation RunTests Project.MyFeature" -unattended

# Run with report
UE4Editor.exe [Project].uproject -ExecCmds="Automation RunTests Project; Quit" -ReportOutputPath="TestResults/"
```

#### Test Flags:
| Flag | Description |
|------|-------------|
| `EditorContext` | Runs in Editor |
| `ClientContext` | Runs in game client |
| `ServerContext` | Runs on server |
| `ProductFilter` | Included in product tests |
| `SmokeFilter` | Quick smoke tests |
| `StressFilter` | Stress/load tests |

### Gauntlet Framework (Multiplayer):

#### Setup:
```cpp
// MyGauntletTest.h
#include "GauntletTestController.h"

UCLASS()
class UMyGauntletTest : public UGauntletTestController
{
    GENERATED_BODY()

public:
    virtual void OnTick(float DeltaTime) override;
    virtual void OnPostMapChange(UWorld* World) override;
};
```

#### Running Gauntlet:
```bash
# Server
[Project].exe [MapName]?listen -server -log -gauntlet=MyGauntletTest

# Clients (run multiple)
[Project].exe -game -connect=127.0.0.1 -gauntlet=MyGauntletTest
```

#### Network Simulation:
| Command | Effect |
|---------|--------|
| `net pktlag=100` | 100ms latency |
| `net ploss=5` | 5% packet loss |
| `net pktdup=2` | 2% packet duplication |
| `net pktord=1` | Enable packet reordering |

### Blueprint Testing:

#### Functional Test Actor:
1. Create Blueprint extending `AFunctionalTest`
2. Add test logic in Event Graph
3. Call `FinishTest(Success/Failure, Message)`

#### Blueprint Test Example:
```
Event BeginPlay
    → Delay 1.0s
    → Get Player Character
    → Branch (IsValid?)
        → True: FinishTest(Success, "Player spawned")
        → False: FinishTest(Failure, "No player")
```

#### Running Blueprint Tests:
1. Place Functional Test actors in test map
2. Window → Developer Tools → Session Frontend
3. Run "Functional Tests" category

### Test Output:

#### Output Locations:
| Type | Path |
|------|------|
| Logs | `Saved/Logs/` |
| Reports | `Saved/Automation/` |
| Screenshots | `Saved/Screenshots/` |

#### CI/CD Integration:
```yaml
# Example GitHub Actions
- name: Run UE5 Tests
  run: |
    ./Engine/Build/BatchFiles/RunUAT.bat BuildCookRun ^
      -project=[Project].uproject ^
      -RunAutomationTests ^
      -ReportOutputPath=TestResults/
```

### Terminology cho newbie:
| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| Automation Test | Test tự động chạy bằng code |
| Functional Test | Test gameplay bằng Actor trong map |
| Gauntlet | Framework test multiplayer của Epic |
| Smoke Test | Test nhanh các tính năng cơ bản |
| Stress Test | Test với tải nặng (nhiều players, objects) |
| Test Fixture | Setup/teardown cho mỗi test |
| Mock | Object giả để test isolated |
| Assertion | Kiểm tra điều kiện đúng/sai |

---

## 🎯 Non-Tech Mode (v4.0)

**Đọc preferences.json để điều chỉnh ngôn ngữ:**

```
if technical_level == "newbie":
    → Ẩn technical output (test results raw)
    → Chỉ báo: "X/Y tests passed" với emoji
    → Giải thích test fail bằng ngôn ngữ đơn giản
```

### Giải thích Test cho newbie:

| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| Unit test | Kiểm tra từng phần nhỏ (như kiểm tra từng món ăn) |
| Integration test | Kiểm tra các phần kết hợp (như kiểm tra cả bữa ăn) |
| Coverage | % code được kiểm tra (càng cao càng an toàn) |
| Pass/Fail | Đạt/Không đạt |
| Mock | Giả lập (như diễn tập trước khi thật) |

### Báo cáo test cho newbie:

```
❌ ĐỪNG: "FAIL src/utils/calc.test.ts > calculateTotal > should add VAT"
✅ NÊN:  "🧪 Kết quả kiểm tra:

         ✅ 12 tests đạt
         ❌ 1 test không đạt

         Lỗi: Hàm tính tổng tiền chưa cộng thuế VAT
         📍 File: utils/calc.ts

         Muốn em sửa giúp không?"
```

---

## Giai đoạn 1: Test Strategy Selection
1.  **Hỏi User (Đơn giản):**
    *   "Anh muốn test kiểu nào?"
        *   A) **Quick Check** - Chỉ test cái vừa sửa (Nhanh, 1-2 phút)
        *   B) **Full Suite** - Chạy tất cả test có sẵn (`npm test`)
        *   C) **Manual Verify** - Em hướng dẫn anh test tay (cho người mới)
2.  Nếu User chọn A, hỏi tiếp: "Anh vừa sửa file/tính năng gì?"

## Giai đoạn 2: Test Preparation
1.  **Tìm Test File:**
    *   Scan thư mục `__tests__/`, `*.test.ts`, `*.spec.ts`.
    *   Nếu có file test cho module User nhắc → Chạy file đó.
    *   **Nếu KHÔNG CÓ file test:**
        *   Thông báo: "Chưa có test cho phần này. Em sẽ tạo Quick Test Script để verify."
        *   Tự tạo một file test đơn giản trong `/scripts/quick-test-[feature].ts`.

## Giai đoạn 3: Test Execution
1.  Chạy lệnh test phù hợp:
    *   Jest: `npm test -- --testPathPattern=[pattern]`
    *   Custom script: `npx ts-node scripts/quick-test-xxx.ts`
2.  Theo dõi output.

## Giai đoạn 4: Result Analysis & Reporting
1.  **Nếu PASS (Xanh):**
    *   "Tất cả test đều PASS! Logic ổn định rồi anh."
2.  **Nếu FAIL (Đỏ):**
    *   Phân tích lỗi (Không chỉ báo, mà giải thích nguyên nhân).
    *   "Test `shouldCalculateTotal` bị fail. Có vẻ do phép tính thiếu VAT."
    *   Hỏi: "Anh muốn em sửa luôn (`/debug`) hay anh tự check?"

## Giai đoạn 5: Coverage Report (Optional)
1.  Nếu User muốn biết độ phủ test:
    *   Chạy `npm test -- --coverage`.
    *   Báo cáo: "Hiện tại code được test 65%. Các file chưa test: [Danh sách]."

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Test pass? /deploy để đưa lên production
2️⃣ Test fail? /debug để sửa lỗi
3️⃣ Muốn thêm test? /code để viết thêm test cases
```
