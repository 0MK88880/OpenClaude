# VPS 接続ガイド

**VPS:** ConoHa VPS (163.44.116.185)

## クイック接続

```bash
ssh conoha-chatgpt
```

## 接続情報

```
Host conoha-chatgpt
HostName 163.44.116.185
User root
Port 22
IdentityFile ~/.ssh/conoha_vps_chatgpt
IdentitiesOnly yes
```

## 動作確認

```bash
ssh conoha-chatgpt "hostname && uname -a"
```

期待値:
- ホスト名
- Ubuntu バージョン

## 用途

- 外部 API リクエスト
- GitHub Webhook 受信
- X（Twitter）投稿システム
- チャットボット API

---

**設定済み:** SSH config (`~/.ssh/config`) に alias 設定完了 ✅
