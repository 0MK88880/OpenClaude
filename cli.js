#!/usr/bin/env node

/**
 * OpenClaude CLI
 * SSH コマンド実行インターフェース
 */

const { exec } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// VPS 接続設定
const VPS_CONFIG = {
  alias: 'conoha-chatgpt',
  host: '163.44.116.185',
  user: 'root',
  port: 22,
  key: '~/.ssh/conoha_vps'
};

// コマンド処理
function handleCommand(input) {
  const command = input.trim().toLowerCase();

  // VPS 接続コマンド
  if (command.includes('vps') && command.includes('接続')) {
    connectToVPS();
    return;
  }

  // ヘルプコマンド
  if (command === 'help' || command === 'ヘルプ') {
    showHelp();
    return;
  }

  // 終了
  if (command === 'exit' || command === 'quit') {
    rl.close();
    return;
  }

  console.log('❌ コマンドが認識されませんでした。\n「VPS に接続して」または「help」で確認してください。');
}

// VPS 接続
function connectToVPS() {
  console.log('🔗 VPS に接続します...\n');

  const sshCommand = `ssh ${VPS_CONFIG.alias}`;
  console.log(`実行: ${sshCommand}\n`);

  const child = exec(sshCommand, { stdio: 'inherit' });

  child.on('close', (code) => {
    console.log(`\n✅ VPS 接続を切断しました (終了コード: ${code})`);
    promptCommand();
  });
}

// ヘルプ表示
function showHelp() {
  console.log(`
📚 OpenClaude CLI ヘルプ

【使用可能なコマンド】
  • VPS に接続して
    └ ConoHa VPS (163.44.116.185) に SSH で接続します

  • help, ヘルプ
    └ このヘルプを表示します

  • exit, quit
    └ CLI を終了します

【VPS 接続情報】
  ホスト名: ${VPS_CONFIG.alias}
  IP: ${VPS_CONFIG.host}
  ユーザー: ${VPS_CONFIG.user}
  SSH キー: ${VPS_CONFIG.key}
`);
  promptCommand();
}

// コマンドプロンプト
function promptCommand() {
  rl.question('OpenClaude> ', (input) => {
    if (input.trim() === '') {
      promptCommand();
      return;
    }
    handleCommand(input);
  });
}

// 起動
console.log('🚀 OpenClaude CLI を起動しました');
console.log('「VPS に接続して」または「help」を入力してください\n');
promptCommand();

rl.on('close', () => {
  console.log('\n👋 OpenClaude CLI を終了しました');
  process.exit(0);
});
