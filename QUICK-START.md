# OpenClaude クイックスタートガイド

## 🚀 最速で始める

### 方法1: バックエンド選択メニュー（推奨）

```bash
cd /Users/mk/OpenClaude
./openclaude-select.sh
```

対話的にバックエンドを選択できます：

```
Available backends:

  1️⃣  💻 Mac mini M2 Pro (LM Studio)
     └─ Model: Qwen3.6-35B-A3B-Uncensored
     └─ Speed: ⚡⚡⚡ (fastest)

  2️⃣  🖥️  Windows5070 (Ollama)
     └─ Model: Qwen3-Coder-30B-A3B-Instruct
     └─ Speed: ⚡⚡ (fast, remote)

Select backend (1 or 2):
```

### 方法2: 直接起動

**ローカル（Mac mini M2 Pro）- 高速推奨:**
```bash
./start-with-lmstudio.sh
```

**リモート（Windows5070） - コード生成専門:**
```bash
./start-with-windows5070.sh
```

## 📋 バックエンド比較

| 項目 | LM Studio | Windows5070 |
|------|-----------|------------|
| **モデル** | Qwen3.6-35B-A3B-Uncensored | Qwen3-Coder-30B-A3B-Instruct |
| **場所** | ローカル (Mac mini) | リモート (Windows5070) |
| **速度** | ⚡⚡⚡ 最速 | ⚡⚡ 高速 |
| **レスポンス時間** | 数秒 | 5-10秒 |
| **得意分野** | 日本語・汎用 | プログラミング・コード |
| **ネットワーク** | 不要 | LAN内接続 |
| **コンテキスト長** | 32768トークン | 自動調整 |

## 💡 使い分けガイド

### LM Studioを使うべき場合
- ✅ 高速レスポンスが必要
- ✅ 日本語対話
- ✅ ネットワーク遅延を避けたい
- ✅ 汎用的なタスク

```bash
./start-with-lmstudio.sh -p "日本語でこの関数を説明してください"
```

### Windows5070を使うべき場合
- ✅ コード生成が必要
- ✅ 複雑なプログラミングタスク
- ✅ 複数言語のコード処理
- ✅ 高性能GPUを活用したい

```bash
./start-with-windows5070.sh -p "Rustで並列処理のサンプルを書いてください"
```

## 🔄 よく使うコマンド

### 対話的セッション（デフォルト）
```bash
./openclaude-select.sh        # メニューから選択
# または
./start-with-lmstudio.sh      # LM Studioで起動
./start-with-windows5070.sh   # Windows5070で起動
```

### 非対話的（プロンプト実行のみ）
```bash
./start-with-lmstudio.sh -p "プロンプトテキスト"
./start-with-windows5070.sh -p "プロンプトテキスト"
```

### ファイル入力を含む
```bash
./start-with-lmstudio.sh -p "このコードをレビューしてください" < mycode.py
```

### エージェント機能を使用
```bash
./start-with-windows5070.sh -p "プロジェクトを分析してください" --add-dir ./src
```

## 🔌 接続確認

### LM Studioが起動しているか確認
```bash
curl -s http://127.0.0.1:1234/v1/models | jq '.data[].id'
```

### Windows5070が接続可能か確認
```bash
curl -s http://192.168.1.25:11434/v1/models | jq '.data[].id'
```

## 📊 モデル表示の見分け方

OpenClaudeのモデル選択画面では、以下のように表示されます：

```
✅ 💻 Mac mini M2 → Qwen3.6-35B-A3B-Uncensored (LM Studio)
✅ 🖥️ Windows5070 → Qwen3-Coder-30B-A3B-Instruct (Ollama)
```

**絵文字で一目瞭然！**
- 💻 = ローカル
- 🖥️ = リモート

## ⚠️ 問題が発生した場合

### エラー: "Connection refused"
```bash
# LM Studioが起動していない
# → Mac miniでLM Studioを起動
```

### エラー: "Model not found"
```bash
# モデル名が誤っている
# → `/model` コマンドで正しいモデルを選択
```

### 遅い・応答がない
```bash
# Windows5070が処理中の可能性
# → LM Studioバージョンを試す
./start-with-lmstudio.sh
```

詳細は `TROUBLESHOOTING.md` を参照してください。

## 🎯 次のステップ

1. **バックエンドを選択**
   ```bash
   ./openclaude-select.sh
   ```

2. **OpenClaudeで作業**
   - `/help` - ヘルプ表示
   - `/model` - モデル変更
   - `/provider` - プロバイダー設定

3. **設定を保存**
   - プロンプト内で聞かれたら `y` で保存
   - 次回起動時に自動適用

## 📚 詳細ドキュメント

- `README-SETUP.md` - LM Studio詳細設定
- `README-WINDOWS5070-SETUP.md` - Windows5070詳細設定
- `TROUBLESHOOTING.md` - トラブルシューティング
