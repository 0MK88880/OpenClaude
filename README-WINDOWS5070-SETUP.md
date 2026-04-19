# OpenClaude + Windows5070 Ollama セットアップガイド

## ✅ セットアップ完了

### 1. 環境構成

| 項目 | 詳細 |
|------|------|
| **リモートホスト** | windows5070 (192.168.1.25) |
| **ランタイム** | Ollama |
| **モデル** | Qwen3-Coder-30B-A3B-Instruct-GGUF |
| **量子化** | UD-Q4_K_XL (17GB) |
| **APIエンドポイント** | http://192.168.1.25:11434/v1 |
| **ステータス** | ✅ 動作確認済み |

### 2. 利用可能なモデル

Windows5070のOllamaで利用可能なモデル:

```
1. Qwen3.6-35B-A3B-GGUF (UD-Q4_K_M) - 23GB
   └─ 用途: 汎用・最高性能
   
2. Qwen3-Coder-30B-A3B-Instruct-GGUF (UD-Q4_K_XL) - 17GB ⭐ 推奨
   └─ 用途: コード生成・プログラミング専門
```

## 🚀 使用方法

### 方法1: セットアップスクリプト (推奨)

```bash
cd /Users/mk/OpenClaude
./start-with-windows5070.sh
```

このスクリプトは以下を自動実行:
- Windows5070のOllamaAPIに接続
- Qwen3-Coder-30B-A3B-Instruct-GGUFを選択
- OpenClaudeを起動

### 方法2: 環境変数を直接設定

```bash
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://192.168.1.25:11434/v1
export OPENAI_MODEL="hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL"

npx openclaude
```

### 方法3: 他のQwenモデルを使用する場合

**Qwen3.6-35B-A3B-GGUF (汎用版)**を使う場合:

```bash
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://192.168.1.25:11434/v1
export OPENAI_MODEL="hf.co/unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M"

npx openclaude
```

## 📝 使用例

### 対話的セッション
```bash
./start-with-windows5070.sh
```

### 非対話的 (出力のみ)
```bash
./start-with-windows5070.sh -p "Pythonで階乗を計算する関数を書いてください"
```

### ファイル入力を含む
```bash
./start-with-windows5070.sh -p "このコードをレビューしてください" < mycode.py
```

### エージェント機能を使用
```bash
./start-with-windows5070.sh -p "このプロジェクトの構造を分析してください" --add-dir ./src
```

## ✨ Qwen3-Coder-30B-A3B-Instruct の特徴

| 機能 | 説明 |
|------|------|
| **得意分野** | プログラミング・コード生成・デバッグ |
| **モデルサイズ** | 30.5B パラメータ |
| **量子化レベル** | Q4_K_XL (高品質) |
| **レスポンス速度** | 高速 (42 tok/s @ RTX 5070 Ti) |
| **言語サポート** | Python, JavaScript, Go, Rust など複数言語 |
| **推論性能** | 指示追従性が高い |

## 🔍 動作確認

### APIの疎通確認
```bash
curl -s http://192.168.1.25:11434/api/tags | jq '.models[].name'
```

### モデルのリスト表示
```bash
ssh windows5070 "ollama list"
```

### テストクエリ
```bash
curl -X POST http://192.168.1.25:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL",
    "messages": [{"role": "user", "content": "こんにちは"}],
    "max_tokens": 100
  }' | jq '.choices[0].message.content'
```

## 📋 トラブルシューティング

### エラー: "Connection refused"
**原因**: Windows5070のOllamaが起動していない  
**解決**: `ssh windows5070 "ollama serve"` でOllamaを起動

### エラー: "Model not found"
**原因**: 指定したモデル名が誤っている  
**解決**: `ssh windows5070 "ollama list"` で正確なモデル名を確認

### 応答が遅い
**原因**: ネットワーク遅延またはモデルが計算中  
**解決**: ローカルのMac miniのLM Studioを使用 (`./start-with-lmstudio.sh`)

### OpenClaudeが起動しない
**原因**: npm依存関係の問題  
**解決**:
```bash
cd /Users/mk/OpenClaude
npm install
```

## 🔗 参考情報

- **OpenClaude**: https://github.com/gitlawb/openclaude
- **Ollama**: https://ollama.ai/
- **Qwen Models**: https://github.com/QwenLM/Qwen
- **Windows5070 SSH**: `ssh windows5070` (設定済み)

## 📊 ネットワーク構成

```
Mac mini M2 Pro (OpenClaude CLI)
         ↓ SSH + OpenAI API
    Windows5070
    192.168.1.25:11434
    (Ollama Server)
         ↓
    Qwen3-Coder-30B-A3B-Instruct-GGUF
    RTX 5070 Ti GPU
```

## 🎯 推奨される使用シーン

✅ **最適な用途:**
- コード生成・補完
- プログラムのデバッグとレビュー
- 技術文書の作成
- システム設計の相談

⚠️ **非推奨:**
- リアルタイム会話 (遅延がある)
- 日本語自然会話 (コーダー向けモデル)

## 📌 よく使うコマンド

```bash
# コーダー版 (推奨)
./start-with-windows5070.sh -p "プロンプト"

# 汎用版 Qwen3.6
OPENAI_MODEL="hf.co/unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M" ./start-with-windows5070.sh

# 対話モード
./start-with-windows5070.sh

# ローカルLM Studio (Mac miniで高速)
./start-with-lmstudio.sh
```
