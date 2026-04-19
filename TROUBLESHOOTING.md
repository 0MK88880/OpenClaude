# OpenClaude モデル選択 トラブルシューティング

## 問題: "There's an issue with the selected model"

OpenClaudeが起動時にモデル選択エラーを表示する場合があります。

```
There's an issue with the selected model (50-Qwen3-Coder-30B-A3B-Instruct-GGUF).
It may not exist or you may not have access to it. Run /model to pick a different model.
```

### 解決方法

#### 方法1: `/model` コマンドで正しいモデルを選択（推奨）

1. OpenClaudeが起動したら、以下を入力:
   ```
   /model
   ```

2. 利用可能なモデルが表示されます:
   ```
   Available models:
   1. hf.co/unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_M (23 GB)
   2. hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL (17 GB) ⭐
   ```

3. `2` を選択してQwen3-Coder-30Bを確定

4. 設定を保存するか選択
   ```
   Save this provider configuration? (y/n)
   ```
   `y` で保存すると、次回から自動的に使用されます

#### 方法2: 環境変数で直接指定

```bash
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://192.168.1.25:11434/v1
export OPENAI_MODEL="hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL"

npx openclaude
```

#### 方法3: プロバイダー設定ファイルを使用

既に `.openclaude-profile.json` が作成されています:

```bash
cd /Users/mk/OpenClaude
npx openclaude
```

OpenClaudeが自動的にこの設定を読み込みます。

## モデル選択後の確認

OpenClaudeが正常に起動した場合の表示:

```
Provider: Ollama
Model: hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL
Endpoint: http://192.168.1.25:11434/v1
Status: Ready ✓ Type /help to begin
```

## API接続確認

コマンドラインでOllamaのAPIが応答しているか確認:

```bash
# モデル一覧確認
curl -s http://192.168.1.25:11434/v1/models | jq

# テストクエリ
curl -X POST http://192.168.1.25:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL",
    "messages": [{"role": "user", "content": "hello"}],
    "max_tokens": 20
  }'
```

## トラブルシューティングチェックリスト

- [ ] Windows5070が起動している
- [ ] OllamaサーバーがWindows5070で実行中 (`ollama serve`)
- [ ] ネットワーク接続確認: `ping 192.168.1.25`
- [ ] APIエンドポイント確認: `curl -s http://192.168.1.25:11434/v1/models`
- [ ] モデル名が一致している
- [ ] OpenClaudeを再起動

## よくある原因と対策

| 現象 | 原因 | 対策 |
|------|------|------|
| Connection refused | Ollamaが起動していない | Windows5070でOllamaを起動 |
| Model not found | モデル名が誤っている | `/model` で正しいモデルを選択 |
| Timeout | ネットワーク遅延 | ローカルの LM Studio を使用 |
| 応答なし | GPUが処理中 | 数秒待つか、別のセッションで試す |

## おすすめの使い分け

| シーン | 推奨モデル | スクリプト |
|--------|----------|----------|
| 高速レスポンス（ローカル） | Qwen3-Coder-30B (LM Studio) | `./start-with-lmstudio.sh` |
| リモート・高性能（コード生成） | Qwen3-Coder-30B-A3B (Windows5070) | `./start-with-windows5070.sh` |
| 汎用・日本語対応 | Qwen3.6-35B (Windows5070) | 環境変数で切り替え |

## デバッグモード

詳細ログを表示しながら起動:

```bash
export DEBUG=openclaude:*
./start-with-windows5070.sh -p "テスト"
```
