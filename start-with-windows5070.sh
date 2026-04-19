#!/bin/bash
# OpenClaude with Windows5070 Ollama Backend Configuration
# Qwen3-Coder-30B-A3B-Instruct-GGUF (UD-Q4_K_XL)

# Set environment variables for Windows5070 backend
export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://192.168.1.25:11434/v1
export OPENAI_MODEL="hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL"

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║  🖥️  OpenClaude with Windows5070 Ollama                   ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Configuration:"
echo "  🌐 Remote Host: windows5070 (192.168.1.25)"
echo "  ⚙️  Runtime: Ollama"
echo "  📦 Model: Qwen3-Coder-30B-A3B-Instruct-GGUF"
echo "  💾 Quantization: UD-Q4_K_XL (17GB)"
echo "  🔗 API: http://192.168.1.25:11434/v1"
echo ""
echo "Starting OpenClaude..."
echo ""

# Run OpenClaude with profile configuration
npx openclaude --settings .openclaude-windows5070.json "$@"
