# VPS 接続ガイド

**VPS:** ConoHa VPS (163.44.116.185)  
**ステータス:** ✅ 接続確認済み

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
IdentityFile ~/.ssh/conoha_vps
IdentitiesOnly yes
```

## 動作確認

```bash
ssh conoha-chatgpt "hostname && uname -a"
```

**期待値:**
```
vm-3cd6f172-d0
Linux vm-3cd6f172-d0 6.8.0-107-generic #107-Ubuntu PREEMPT_DYNAMIC ...
```

## 用途

- 外部 API リクエスト
- GitHub Webhook 受信
- X（Twitter）投稿システム
- チャットボット API

## トラブルシューティング

### 接続できない場合

```bash
# 複数の鍵で試す
ssh -i ~/.ssh/conoha_vps root@163.44.116.185
ssh -i ~/.ssh/conoha_vps_new root@163.44.116.185

# SSH verbose モード
ssh -vv conoha-chatgpt
```

---

**設定済み:** SSH config (`~/.ssh/config`) に alias 設定完了 ✅  
**テスト済み:** 2026-04-20 接続確認 ✅
