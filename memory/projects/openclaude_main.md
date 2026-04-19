---
name: OpenClaude メインプロジェクト
description: OpenClaude の開発・セットアップ・インフラ構成
type: project
---

# OpenClaude メインプロジェクト

**最終更新:** 2026-04-20 03:59 JST

---

## 📋 プロジェクト概要

### 目的
Claude API + ローカル LLM を組み合わせたマルチエージェントシステムの構築。
マシン間で情報を共有し、効率的な分散処理を実現する。

### 現状
- ✅ GitHub リポジトリ作成完了（`0MK88880/OpenClaude`）
- ✅ SSH 接続情報ファイル統合完了
- ✅ 長期記憶システムセットアップ完了

---

## 🔧 現在のセットアップ

### インフラ構成

| マシン | 用途 | SSH ホスト名 | 状態 |
|:---|:---|:---|:---|
| Mac mini M2 Pro | メイン開発・統括 | - | ✅ |
| Mac mini M4 | LLM実行（SuperGemma4-26B） | `m4-mini` | ✅ |
| iMac M1 | LLM実行（DeepSeek-6.7B） | `imac` | ✅ |
| Windows RTX 5070 | LLM実行（Qwen3-30B） | `windows5070` | ✅ |
| Windows Gemma4 | LLM実行（Gemma4-E2B） | `gemma4-windows` | ✅ |
| ConoHa VPS | 外部API・Webhook | `conoha-chatgpt` | ✅ |

### GitHub 連携
- **リポジトリ:** https://github.com/0MK88880/OpenClaude
- **SSH 設定:** `git@github.com:0MK88880/OpenClaude.git`
- **ブランチ:** `main`
- **最新コミット:** SSH 接続情報統合（2026-04-20）

---

## 📚 ドキュメント体系

```
OpenClaude/
├── docs/ssh-info/           ← SSH 接続設定
│   ├── SSH_CONNECTIONS.md   ← クイック接続ガイド
│   └── *.md                 ← マシン別設定
├── README.md                ← プロジェクト説明
└── .env.example             ← 環境設定テンプレート
```

---

## 🎯 次のタスク

### Phase 1: 環境確認（2026-04-20）
- [ ] OpenClaude で SSH 接続動作確認
- [ ] 各マシンへのリモートコマンド実行テスト
- [ ] GitHub ウェブフック設定

### Phase 2: API 統合
- [ ] Claude API 統合テスト
- [ ] ローカル LLM との連携テスト
- [ ] マシン間通信テスト（gRPC）

### Phase 3: エージェント実装
- [ ] メインエージェント実装
- [ ] 分散処理パイプライン構築
- [ ] 本番運用開始

---

## 🔑 重要な設定

### SSH 秘密鍵（`~/.ssh/`配下）
```
id_ed25519              ← M4, Windows Gemma4 用
jp12_id_rsa             ← バックアップ
windows_key             ← Windows RTX 5070 用
macmini_m4_key          ← M4 Mac mini 用
imac_key                ← iMac M1 用
conoha_vps_chatgpt      ← VPS 用
```

### SSH Config エイリアス（`.ssh/config`設定済み）
```bash
ssh m4-mini         # M4 Mac mini に接続
ssh imac            # iMac M1 に接続
ssh windows5070     # Windows RTX 5070 に接続
ssh gemma4-windows  # Windows Gemma4 に接続
ssh conoha-chatgpt  # VPS に接続
```

---

## 📝 開発ルール

**開発ワークフロー:**
1. フィーチャーブランチで開発
2. 動作確認後にメインブランチへマージ
3. GitHub リポジトリに自動プッシュ

**コミットメッセージ形式:**
```
<type>: <description>

<optional body>
```

Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`

---
