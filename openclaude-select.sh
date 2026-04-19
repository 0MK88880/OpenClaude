#!/bin/bash
# OpenClaude Backend Selector
# Choose which backend to use: LM Studio (local) or Windows5070 (remote)

set -e

cd "$(dirname "$0")" || exit 1

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║   OpenClaude - Backend Selection Menu                  ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "Available backends:"
echo ""
echo "  1️⃣  💻 Mac mini M2 Pro (LM Studio)"
echo "     └─ Model: Qwen3.6-35B-A3B-Uncensored"
echo "     └─ Context: 32768 tokens"
echo "     └─ Speed: ⚡⚡⚡ (fastest, local GPU)"
echo ""
echo "  2️⃣  🖥️  Windows5070 (Ollama)"
echo "     └─ Model: Qwen3-Coder-30B-A3B-Instruct"
echo "     └─ Quantization: UD-Q4_K_XL"
echo "     └─ Speed: ⚡⚡ (fast, remote GPU)"
echo ""
echo "════════════════════════════════════════════════════════"
echo ""

read -p "Select backend (1 or 2): " choice

case $choice in
  1)
    echo ""
    echo "🚀 Starting with LM Studio backend..."
    echo ""
    ./start-with-lmstudio.sh "$@"
    ;;
  2)
    echo ""
    echo "🚀 Starting with Windows5070 backend..."
    echo ""
    ./start-with-windows5070.sh "$@"
    ;;
  *)
    echo ""
    echo "❌ Invalid choice. Please select 1 or 2."
    exit 1
    ;;
esac
