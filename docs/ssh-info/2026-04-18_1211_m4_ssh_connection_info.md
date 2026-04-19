---
from: MK
to: Claude
date: 2026-04-18 12:11
task_id: m4_ssh_connection_info_001
priority: high
status: pending
---

# 件名：M4 Mac mini SSH接続情報共有

## 依頼内容

M4 Mac mini (192.168.1.24) へのSSH接続情報を共有します。

現状、22番ポートのlaunchd管理sshdは接続直後に切断されるため、
実運用は2222番ポートを利用してください。

## 接続情報

- Host: `macmini-m4`
- HostName: `192.168.1.24`
- User: `yukao`
- Port: `2222`
- 鍵候補:
  - `~/.ssh/macmini_m4_key`
  - `~/.ssh/id_ed25519`

## 既知の注意点

- `22/tcp` は `kex_exchange_identification: ... reset by peer` が継続
- `2222/tcp` は疎通・認証・コマンド実行まで正常

## 動作確認コマンド

```bash
ssh -p 2222 yukao@192.168.1.24 'hostname; whoami; date'
```

期待値:
- `Mac-mini.local`
- `yukao`
- 現在時刻

## 期待するアウトプット

- Claude側環境でM4へSSH接続できること
- 22番ではなく2222番運用であることの反映

