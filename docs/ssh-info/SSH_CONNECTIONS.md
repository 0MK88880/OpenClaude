# SSH接続設定ガイド

**最終更新:** 2026-04-17 14:36 JST

全マシンへのSSH接続設定が完了しました。以下の情報を使用して接続できます。

---

## 📋 接続情報サマリー

| マシン | ホスト名 | IP | ユーザー | スペック | 状態 |
|:---|:---|:---|:---|:---|:---|
| **Windows Gemma4** | `gemma4-windows` | 192.168.1.29 | windows | i7-9700K + RTX 2060, 16GB RAM | ✅ |
| **Windows RTX 5070** | `windows5070` | 192.168.1.25 | ogata | RTX 5070 Ti, 32GB + 16GB VRAM | ✅ |
| **M4 Mac mini** | `m4-mini` | 192.168.1.24 | yukao | Apple M4, 16GB RAM | ✅ |
| **iMac M1** | `imac` | 192.168.1.17 | omg | Apple M1, 8GB RAM | ✅ |
| **ConoHa VPS** | `conoha-chatgpt` | 163.44.116.185 | root | Ubuntu 6.8.0 x86_64 | ✅ |

---

## 🚀 クイック接続

`.ssh/config` が設定済みなので、以下のコマンドで接続可能：

```bash
# Windows Gemma-4-E2B サーバー
ssh gemma4-windows

# Windows RTX 5070 Ti
ssh windows5070
# または
ssh windows

# M4 Mac mini
ssh m4-mini

# iMac M1
ssh imac

# ConoHa VPS
ssh conoha-chatgpt
```

---

## 🔧 ~/.ssh/config 詳細設定

### Windows Gemma4 (192.168.1.29)

```
Host gemma4-windows
    HostName 192.168.1.29
    User windows
    IdentityFile ~/.ssh/id_ed25519
    Port 22
```

**特徴:**
- OpenSSH Server (sshd) 自動起動 ✅
- 秘密鍵認証 (administrators_authorized_keys)
- Ollama API: `http://192.168.1.29:11434`

### Windows RTX 5070 (192.168.1.25)

```
Host windows windows5070
    HostName 192.168.1.25
    User ogata
    IdentityFile ~/.ssh/windows_key
    IdentitiesOnly yes
    Port 22
    StrictHostKeyChecking accept-new
```

### M4 Mac mini (192.168.1.24)

```
Host m4-mini
    HostName 192.168.1.24
    User yukao
    IdentityFile ~/.ssh/id_ed25519
    IdentityFile ~/.ssh/macmini_m4_key
    StrictHostKeyChecking accept-new
```

### iMac M1 (192.168.1.17)

```
Host imac
    HostName 192.168.1.17
    User omg
    IdentityFile ~/.ssh/imac_key
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
```

### ConoHa VPS (163.44.116.185)

```
Host conoha-chatgpt
HostName 163.44.116.185
User root
Port 22
IdentityFile ~/.ssh/conoha_vps_chatgpt
IdentitiesOnly yes
```

---

## 🧪 接続テスト

各マシンへの接続確認：

```bash
# 全マシンへの接続確認
ssh gemma4-windows "hostname && uname -m"
ssh windows5070 "whoami && hostname"
ssh m4-mini "hostname && system_profiler SPHardwareDataType | grep 'Chip\|Memory'"
ssh imac "hostname && uname -a"
ssh conoha-chatgpt "hostname && uname -a"
```

---

## 🔑 セキュリティ設定

### 秘密鍵の権限

```bash
# 秘密鍵のパーミッション設定
chmod 600 ~/.ssh/id_ed25519
chmod 600 ~/.ssh/windows_key
chmod 600 ~/.ssh/macmini_m4_key
chmod 600 ~/.ssh/imac_key
chmod 600 ~/.ssh/conoha_vps_chatgpt

# .ssh ディレクトリ
chmod 700 ~/.ssh
```

### Windows SSH キー認証

Windows マシンは秘密鍵認証を使用：
- `~/.ssh/administrators_authorized_keys` にMacの公開鍵を登録
- パスワード認証は無効化推奨

---

## 🔄 Ollama API アクセス

Windows Gemma4 の Ollama API にリモートからアクセス：

```bash
# Mac mini M2 Pro からアクセス
curl http://192.168.1.29:11434/api/generate \
  -d '{
    "model": "gemma4-e2b",
    "prompt": "Hello, say hi in one sentence",
    "stream": false
  }'

# レスポンス例
{
  "model": "gemma4-e2b",
  "response": "Hi! How can I help you today?",
  "done": true,
  ...
}
```

**推論速度:** 97.3 tok/s (RTX 2060 GPU)

---

## 📊 LLM モデル配置

| マシン | モデル | 配置 | 推論速度 |
|:---|:---|:---|:---|
| Windows Gemma4 | Gemma-4-E2B-it-heretic-ara (Q4_K_M) | Ollama | 97.3 tok/s |
| Windows RTX 5070 | Qwen3-Coder-30B | llama.cpp | 42 tok/s |
| Mac mini M2 Pro | Qwen3-Coder-30B | llama.cpp | バックアップ用 |
| Mac mini M4 | SuperGemma4-26B | Ollama | 46.2 tok/s |
| iMac M1 | DeepSeek-Coder-6.7B | llama.cpp | 軽量版 |

---

## 🛠️ トラブルシューティング

### 接続タイムアウト

```bash
# ファイアウォール確認
ssh -vv gemma4-windows  # -vv で詳細ログを表示

# Windows側: sshd サービス確認
ssh gemma4-windows "Get-Service sshd"

# ポート確認
ssh gemma4-windows "netstat -an | findstr 22"
```

### キーの権限エラー

```bash
# パーミッション確認
ls -la ~/.ssh/id_ed25519  # 600 であることを確認
ls -la ~/.ssh/            # 700 であることを確認
```

### Windows OpenSSH 再起動

```bash
ssh gemma4-windows "Restart-Service sshd"
```

---

## 📌 自動起動設定確認

### Windows (sshd)

```bash
ssh gemma4-windows "Get-Service sshd | Select-Object Status, StartType"
# Output: Status: Running, StartType: Automatic
```

### Windows (Ollama)

```bash
ssh gemma4-windows "Get-ScheduledTask -TaskName OllamaAutoStart"
```

---

## 🔗 関連リンク

- [SSH設定ファイル](~/.ssh/config)
- [Ollama API ドキュメント](http://192.168.1.29:11434)
- [Windows SSH セットアップガイド](03_Automation_Scripts/windows-ssh-setup.md)
- [Gemma-4-E2B サーバーセットアップガイド](03_Automation_Scripts/gemma4-e2b-server-setup.md)

---

**作成日:** 2026-04-17  
**最終更新:** 2026-04-17 14:36 JST  
**ステータス:** ✅ 全マシン接続確認済み
