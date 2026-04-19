# OpenClaude メモリ - インデックス

> 最新更新：2026-04-20 03:59 JST
> OpenClaude プロジェクトの長期記憶（セッション間での知識保持）

---

## 🎯 プロジェクト概要

**OpenClaude**: Claude API を使用したローカル LLM マルチエージェントシステム

- **GitHub:** https://github.com/0MK88880/OpenClaude
- **環境:** Node.js + gRPC + Anthropic SDK
- **インフラ:** SSH接続で5台マシン統制中

---

## 🔗 クイックリンク

- **SSH 接続情報:** `docs/ssh-info/SSH_CONNECTIONS.md`
- **セッション記録:** `/projects/openclaude_main.md`
- **システム設定:** `/systems/openclaude_config.md`

---

## 📌 重要な設定情報

### GitHub 連携
- **リポジトリ:** `0MK88880/OpenClaude`
- **接続方式:** SSH (`git@github.com:0MK88880/OpenClaude.git`)
- **認証:** `~/.ssh/id_ed25519` / `jp12_id_rsa`

### インフラ接続
- **制御マシン:** Mac mini M2 Pro (メイン開発環境)
- **ターゲットマシン:** Windows 5台、Mac 2台、VPS 1台
- **接続方式:** SSH (`.ssh/config` に alias設定済み)

---

## 📊 セッション記録

> 詳細は `/projects/openclaude_main.md` を参照

---
