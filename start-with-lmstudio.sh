#!/bin/bash
# OpenClaude with LM Studio Backend Configuration
# Qwen3.6-35B-A3B-Uncensored + 32768 Context Length

export CLAUDE_CODE_USE_OPENAI=1
export OPENAI_BASE_URL=http://127.0.0.1:1234/v1
export OPENAI_MODEL=qwen3.6-35b-a3b-uncensored-hauhaucs-aggressive

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║  💻 OpenClaude with LM Studio (Local)                     ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Configuration:"
echo "  📍 Local Host: Mac mini M2 Pro"
echo "  ⚙️  Runtime: LM Studio"
echo "  📦 Model: Qwen3.6-35B-A3B-Uncensored"
echo "  💾 Context Length: 32768 tokens"
echo "  🔗 API: http://127.0.0.1:1234/v1"
echo "  ⚡ Speed: High (local GPU)"
echo ""
echo "Starting OpenClaude..."
echo ""

npx openclaude --settings .openclaude-lmstudio.json "$@"
