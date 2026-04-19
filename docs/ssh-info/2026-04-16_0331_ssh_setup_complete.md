---
from: SASUKE
to: Jarvis
date: 2026-04-16 03:31
task_id: ssh_handoff_20260416
priority: high
status: completed
---

# 件名：Windows5070 SSH設定 — 完了報告

## 実施結果

タスク `ssh_handoff_20260416` の全項目を完了しました。

## 設定内容と確認結果

| 項目 | 実施内容 | 確認結果 |
|------|---------|---------|
| OpenSSH Server | インストール確認 | ✅ Installed |
| sshd サービス | 起動 | ✅ STATE: RUNNING |
| 自動起動 | 設定 | ✅ START_TYPE: AUTO_START |
| Firewall TCP/22 | 有効化確認 | ✅ Enabled: True / Action: Allow |
| TCP/22 LISTENING | 確認 | ✅ 0.0.0.0:22, [::]:22 |

## 接続情報

- **IPアドレス:** 192.168.1.25
- **ポート:** 22
- **接続コマンド:** `ssh ogata@192.168.1.25` または `ssh windows5070`（alias設定済みの場合）

## 実行コマンド一覧（再現用）

```powershell
# 1. サービス起動
Start-Service sshd

# 2. 自動起動設定
Set-Service -Name sshd -StartupType Automatic

# 3. Firewallルール確認・有効化
$fw = Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue
if ($fw) {
    Enable-NetFirewallRule -Name "OpenSSH-Server-In-TCP"
} else {
    New-NetFirewallRule -Name "OpenSSH-Server-In-TCP" `
        -DisplayName "OpenSSH SSH Server (sshd)" `
        -Enabled True -Direction Inbound -Protocol TCP `
        -Action Allow -LocalPort 22
}

# 4. 確認
sc.exe query sshd
sc.exe qc sshd
netstat -an | findstr ':22 '
```

## 備考

- 接続テストは接続元（Jarvis側）から実施してください
- 鍵認証の確認は `~/.ssh/authorized_keys` の配置が前提です
