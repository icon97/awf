---
id: multiplayer
title: /multiplayer - Multiplayer Development Workflow
version: 1.0.0
category: game-dev
triggers:
  - /multiplayer
  - /mp
  - /network
---

# /multiplayer - Multiplayer Development Workflow

## Overview

**Purpose**: Develop and debug UE5 multiplayer features - replication, RPCs, dedicated servers

**Modes**:
| Mode | Description |
|------|-------------|
| setup | Setup multiplayer architecture |
| debug | Debug network issues |
| test | Multi-PIE testing |
| server | Dedicated server management |

---

## /multiplayer setup

### Setup Multiplayer:
```
/multiplayer setup [type]
```

### Multiplayer Types:
| Type | Description | Use Case |
|------|-------------|----------|
| listen | Listen Server | Small games, host is player |
| dedicated | Dedicated Server | Large games, separate server |
| p2p | Peer-to-Peer | Direct connection |
| online | Online Subsystem | Platform services (Steam, EOS) |

### Replication Setup:
```cpp
// Actor Replication
UCLASS()
class AMyActor : public AActor
{
    GENERATED_BODY()
    
    // Replicated property
    UPROPERTY(Replicated)
    float Health;
    
    // Replicated with notification
    UPROPERTY(ReplicatedUsing=OnRep_Health)
    float Health;
    
    UFUNCTION()
    void OnRep_Health();
    
    // Server RPC
    UFUNCTION(Server, Reliable)
    void ServerTakeDamage(float Damage);
    
    // Client RPC
    UFUNCTION(Client, Reliable)
    void ClientShowDamage(float Damage);
    
    // Multicast RPC
    UFUNCTION(NetMulticast, Unreliable)
    void MulticastPlayEffect();
};
```

### GetLifetimeReplicatedProps:
```cpp
void AMyActor::GetLifetimeReplicatedProps(TArray<FLifetimeProperty>& OutLifetimeProps) const
{
    Super::GetLifetimeReplicatedProps(OutLifetimeProps);
    
    DOREPLIFETIME(AMyActor, Health);
    DOREPLIFETIME_CONDITION(AMyActor, Ammo, COND_OwnerOnly);
}
```

### Replication Conditions:
| Condition | Description |
|-----------|-------------|
| COND_None | Always replicate |
| COND_OwnerOnly | Only to owner |
| COND_SkipOwner | Everyone except owner |
| COND_SimulatedOnly | Simulated proxies only |
| COND_AutonomousOnly | Autonomous proxy only |
| COND_InitialOnly | Only on initial replication |

---

## /multiplayer debug

### Network Profiler:
```
/multiplayer debug --profiler
```

### Debug Tools:
| Tool | Purpose | Command |
|------|---------|---------|
| Network Profiler | Bandwidth analysis | stat net |
| Replication Graph | Visualize replication | ReplicationGraph |
| Net Emulation | Simulate lag/loss | NetEmulation |
| Log Categories | Network logs | LogNet, LogNetTraffic |

### Console Commands:
| Command | Purpose |
|---------|---------|
| `stat net` | Network statistics |
| `net.PktLag=100` | Simulate 100ms lag |
| `net.PktLoss=5` | Simulate 5% packet loss |
| `net.PktOrder=1` | Simulate out-of-order packets |
| `log LogNet Verbose` | Enable verbose network logging |

### Common Issues:
| Issue | Cause | Fix |
|-------|-------|-----|
| Property not syncing | Missing DOREPLIFETIME | Add to GetLifetimeReplicatedProps |
| RPC not executing | Wrong specifier | Check Server/Client/NetMulticast |
| Authority mismatch | Wrong HasAuthority check | Verify server/client logic |
| Bandwidth spike | Too much replication | Use conditions, reduce frequency |
| Client desync | Missing replication | Add UPROPERTY(Replicated) |

### Debug Output:
```
🌐 Network Debug

📊 Stats:
- Ping: [ms]
- Packet Loss: [%]
- Bandwidth In: [KB/s]
- Bandwidth Out: [KB/s]

📋 Replicated Actors: [count]
| Actor | Properties | RPCs/sec |
|-------|------------|----------|
| [Name] | [count] | [rate] |

⚠️ Warnings:
- [Actor]: High replication frequency
- [RPC]: Called too often
```

---

## /multiplayer test

### Multi-PIE Testing:
```
/multiplayer test --clients [count]
```

### Test Configurations:
| Config | Description |
|--------|-------------|
| 1 Server + 1 Client | Basic replication test |
| 1 Server + 3 Clients | Multi-client test |
| Listen Server + 2 Clients | Listen server test |
| Dedicated + 4 Clients | Full server test |

### PIE Settings:
| Setting | Location | Purpose |
|---------|----------|---------|
| Number of Players | Play Settings | Client count |
| Net Mode | Play Settings | Listen/Dedicated |
| Run Dedicated Server | Play Settings | Separate server process |
| Use Single Process | Play Settings | All in one process |

### Test Scenarios:
| Scenario | What to Test |
|----------|--------------|
| Join/Leave | Player connection handling |
| Replication | Property sync correctness |
| RPCs | Server/Client function calls |
| Ownership | Actor ownership transfer |
| Relevancy | Actor visibility per client |

### Test Output:
```
🧪 Multiplayer Test

📊 Configuration:
- Mode: Dedicated Server
- Clients: 3
- Map: [MapName]

✅ Passed: [count]
- Player join: All clients connected
- Replication: Properties synced correctly
- RPCs: Server/Client calls working

❌ Failed: [count]
- Ownership: Actor ownership not transferred correctly

📋 Recommendations:
1. Check SetOwner() call on server
2. Verify HasAuthority() checks
```

---

## /multiplayer server

### Dedicated Server:
```
/multiplayer server [action]
```

### Server Actions:
| Action | Command | Description |
|--------|---------|-------------|
| start | /multiplayer server start | Start local dedicated server |
| stop | /multiplayer server stop | Stop server |
| status | /multiplayer server status | Show server status |
| config | /multiplayer server config | Edit server settings |

### Server Configuration:
```ini
[/Script/Engine.GameSession]
MaxPlayers=16

[/Script/OnlineSubsystemUtils.IpNetDriver]
MaxClientRate=15000
MaxInternetClientRate=15000

[URL]
Port=7777
```

### Server Commands:
| Command | Purpose |
|---------|---------|
| ServerTravel | Change map |
| Kick | Kick player |
| Ban | Ban player |
| AdminLogin | Admin access |

### Server Launch:
```bash
# Windows
[ProjectName]Server.exe [MapName] -server -log -port=7777

# Linux
./[ProjectName]Server [MapName] -server -log -port=7777
```

### Server Status Output:
```
🖥️ Server Status

📊 Info:
- Status: Running
- Map: [MapName]
- Port: 7777
- Uptime: [time]

👥 Players: [count]/[max]
| Player | Ping | Status |
|--------|------|--------|
| [Name] | [ms] | Connected |

📈 Performance:
- CPU: [%]
- Memory: [MB]
- Bandwidth: [KB/s]
```

---

## Backend Integration

### Nakama Setup:
```
/multiplayer setup --backend nakama
```

### Nakama Features:
| Feature | Description |
|---------|-------------|
| Authentication | User login/register |
| Matchmaking | Find/create matches |
| Realtime | WebSocket communication |
| Leaderboards | Score tracking |
| Storage | Cloud save |

### Nakama Code Example:
```cpp
// Authentication
void UMyGameInstance::AuthenticateWithNakama()
{
    NakamaClient->AuthenticateDevice(
        DeviceId,
        FOnAuthUpdate::CreateUObject(this, &UMyGameInstance::OnAuthSuccess),
        FOnError::CreateUObject(this, &UMyGameInstance::OnAuthError)
    );
}

// Matchmaking
void UMyGameInstance::FindMatch()
{
    NakamaClient->AddMatchmaker(
        MinPlayers, MaxPlayers,
        Query, StringProperties, NumericProperties,
        FOnMatchmakerMatched::CreateUObject(this, &UMyGameInstance::OnMatchFound)
    );
}
```

### Edgegap Integration:
| Feature | Description |
|---------|-------------|
| Server Hosting | Deploy dedicated servers |
| Auto-scaling | Scale based on demand |
| Matchmaking | Regional server selection |

### Backend Setup Checklist:
```
□ Nakama server running (local or cloud)
□ Client SDK integrated
□ Authentication flow implemented
□ Matchmaking configured
□ Server deployment pipeline ready
```

---

## Terminology cho newbie

| Term | Giải thích |
|------|-----------|
| Replication | Đồng bộ dữ liệu giữa server và clients |
| RPC | Remote Procedure Call - gọi hàm từ xa |
| Authority | Quyền kiểm soát Actor (server hoặc client) |
| Listen Server | Server + Player trong cùng 1 instance |
| Dedicated Server | Server riêng, không có player |
| NetMulticast | RPC gửi đến tất cả clients |
| Relevancy | Actor có hiển thị với client không |
| Ownership | Client nào sở hữu Actor |
| Nakama | Backend server cho multiplayer |
| Matchmaking | Ghép người chơi vào cùng match |
| PIE | Play In Editor - test trong Editor |
| Proxy | Bản sao Actor trên client |

---

## Related Workflows
- `/build-ue` - Build server/client
- `/debug` - Debug network issues
- `/test` - Run network tests
- `/deploy` - Deploy dedicated servers

