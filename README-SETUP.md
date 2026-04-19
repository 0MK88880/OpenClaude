# OpenClaude + LM Studio セットアップ完了

## ✅ 完了した設定

### 1. LM Studioの設定
- **モデル**: Qwen3.6-35B-A3B-Uncensored (22.87 GB, Q4_K_M)
- **コンテキスト長**: 32768トークン ✅ (以前の8192から増加)
- **APIエンドポイント**: http://127.0.0.1:1234/v1
- **ステータス**: READY (実行中)

### 2. 設定の詳細

Context Lengthが32768に設定されたため、OpenClaudeの自動システムプロンプト(約32000トークン)が収まるようになりました。

## 🚀 使用方法

### 方法1: シェルスクリプト (推奨)
```bash
cd /Users/mk/OpenClaude
./start-with-lmstudio.sh
```

このスクリプトは以下の環境変数を自動的に設定します:
- `CLAUDE_CODE_USE_OPENAI=1` - OpenAI互換APIモード
- `OPENAI_BASE_URL=http://127.0.0.1:1234/v1` - LM StudioのAPIエンドポイント
- `OPENAI_MODEL=qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive` - モデル名

### 方法2: 環境変数を直接設定
```bash
cd /Users/mk/OpenClaude

# 環境変数を設定
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://127.0.0.1:1234/v1
export OPENAI_MODEL=qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive

# OpenClaudeを起動
npx openclaude
```

### 方法3: 単一コマンド
```bash
CLAUDE_CODE_USE_OPENAI=1 OPENAI_BASE_URL=http://127.0.0.1:1234/v1 OPENAI_MODEL=qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive npx openclaude
```

## 📝 使用例

### 対話的セッション
```bash
./start-with-lmstudio.sh
```
OpenClaudeの対話的プロンプトが起動します。

### 非対話的(出力のみ)
```bash
./start-with-lmstudio.sh -p "プロンプトテキスト"
```

### コードの説明
```bash
./start-with-lmstudio.sh -p "このコードは何をしていますか？" < myfile.js
```

## 🔍 動作確認

### LM Studio API確認
```bash
curl -s http://127.0.0.1:1234/v1/models | jq
```

### コンテキスト長テスト
LM Studioでモデルの詳細情報を確認:
1. LM Studio Developerタブを開く
2. "Local Server"をクリック
3. ロードされたモデルの情報でコンテキスト長が32768と表示されることを確認

## ⚠️ トラブルシューティング

### エラー: "API Error: The number of tokens to keep..."
**原因**: コンテキスト長がOpenClaudeの要求に不足
**解決**: LM Studioでコンテキスト長が32768に設定されているか確認

### エラー: "Connection refused"
**原因**: LM Studioが起動していない
**解決**: LM Studioを起動してモデルをロード

### OpenClaudeの起動が遅い
**原因**: 初回のnpm依存関係読み込み
**解決**: 2回目以降は高速化されます

## 📦 重要なファイル

- `start-with-lmstudio.sh` - LM Studio設定でOpenClaudeを起動するスクリプト
- `package.json` - OpenClaude依存関係
- `node_modules/@gitlawb/openclaude/` - OpenClaudeパッケージ本体

## 🔗 参考リンク

- [OpenClaude GitHub](https://github.com/gitlawb/openclaude)
- [LM Studio](https://lmstudio.ai/)
- [Qwen Models](https://github.com/QwenLM/Qwen)

## 次のステップ

OpenClaudeはこれらの機能をサポートしています:
- `/provider` - プロバイダー設定管理
- `/agent` - エージェント機能
- `/task` - タスク実行
- `/mcp` - Model Context Protocol対応
- Bash、ファイル操作、Grep、Globなどのツール統合

詳細は `npx openclaude --help` または OpenClaudeドキュメントを参照してください。
