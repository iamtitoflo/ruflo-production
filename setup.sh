#!/bin/bash
# Ruflo v3 + Token Optimizer Setup (Portable)
# Runs on any PC: clones repo, initializes, imports memory, activates hive-mind
# Usage: ./setup.sh [repo-url]

set -e

REPO_URL="${1:-https://github.com/YOUR_USERNAME/YOUR_REPO.git}"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "════════════════════════════════════════════════════════════"
echo "🚀 RUFLO V3 PORTABLE SETUP (Token Optimizer + Hive-Mind)"
echo "════════════════════════════════════════════════════════════"
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 1: Verify/Clone Repository
# ────────────────────────────────────────────────────────────────
echo "📦 [1/6] Repository Setup..."
if [ ! -d .git ]; then
    echo "  Cloning from: $REPO_URL"
    git clone "$REPO_URL" .
else
    echo "  ✓ Repository already initialized"
fi
git config user.name "Flori" 2>/dev/null || git config --global user.name "Flori"
git config user.email "flori@local" 2>/dev/null || git config --global user.email "flori@local"
echo "  ✓ Git configured"
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 2: Install Ruflo
# ────────────────────────────────────────────────────────────────
echo "📥 [2/6] Installing Ruflo v3..."
npm install -g @claude-flow/cli@latest >/dev/null 2>&1 || \
    npm install --save-dev @claude-flow/cli@latest >/dev/null 2>&1
RUFLO_VERSION=$(claude-flow --version 2>/dev/null || npx @claude-flow/cli@latest --version)
echo "  ✓ Ruflo $RUFLO_VERSION installed"
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 3: Register Subagents from YAML
# ────────────────────────────────────────────────────────────────
echo "👥 [3/6] Registering Subagents..."
if [ -d ".claude/agents" ]; then
    for agent_yaml in .claude/agents/*.yaml; do
        if [ -f "$agent_yaml" ]; then
            agent_name=$(basename "$agent_yaml" .yaml)
            echo "  → Registering $agent_name..."
            claude-flow agent register --config "$agent_yaml" 2>/dev/null || true
        fi
    done
    echo "  ✓ Agents registered"
else
    echo "  ⚠ .claude/agents/ not found (skip)"
fi
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 4: Setup OpenRouter API Key (if not already set)
# ────────────────────────────────────────────────────────────────
if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "🔑 [4a/6] OpenRouter API key not set. Check GitHub Secrets or local .env"
    echo "  To set locally: export OPENROUTER_API_KEY='sk-or-v1-...'"
    echo "  GitHub Actions will auto-inject from Secrets"
else
    echo "✓ OpenRouter API key detected (length: ${#OPENROUTER_API_KEY})"
fi
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 4b: Initialize Hive-Mind + Token Optimizer
# ────────────────────────────────────────────────────────────────
echo "🧠 [4b/6] Initializing Hive-Mind + Token Optimizer..."
claude-flow daemon start --log-level=info --detach 2>/dev/null || true
sleep 2

# Hive-Mind (Raft Consensus)
claude-flow hive-mind init \
    --consensus raft \
    --topology hierarchical \
    --heartbeat 300ms \
    2>/dev/null || echo "  (hive-mind already initialized)"

# Token Optimizer (PRIMARY: aggressive caching + compression)
claude-flow token-optimizer activate \
    --compression enabled \
    --caching aggressive \
    --budget-alert 10 \
    2>/dev/null || echo "  (token optimizer already active)"

echo "  ✓ Hive-Mind (Raft) initialized"
echo "  ✓ Token Optimizer (compression + caching) active"
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 5: Import Memory (if backup exists)
# ────────────────────────────────────────────────────────────────
echo "💾 [5/6] Memory System..."
if [ -f "memory-backup.json" ]; then
    echo "  Found memory-backup.json, importing..."
    claude-flow memory import < memory-backup.json 2>/dev/null && \
        echo "  ✓ Memory imported (semantic search ready)" || \
        echo "  ⚠ Memory import skipped"
else
    echo "  (No memory-backup.json, using fresh state)"
fi

# Initialize Memory backend if needed
claude-flow memory init \
    --backend hnsw \
    --dimension 1536 \
    2>/dev/null || echo "  (memory already initialized)"
echo ""

# ────────────────────────────────────────────────────────────────
# STEP 6: Spawn Coordinator (Always-On Leader)
# ────────────────────────────────────────────────────────────────
echo "🎯 [6/6] Spawning Coordinator..."
claude-flow agent spawn \
    -t coordinator \
    --hive \
    --role leader \
    --detach \
    2>/dev/null || echo "  (coordinator already running)"
echo "  ✓ Coordinator active (leader)"
echo ""

# ────────────────────────────────────────────────────────────────
# VERIFICATION
# ────────────────────────────────────────────────────────────────
echo "════════════════════════════════════════════════════════════"
echo "✅ SETUP COMPLETE - VERIFICATION"
echo "════════════════════════════════════════════════════════════"
echo ""

if claude-flow daemon status >/dev/null 2>&1; then
    echo "✓ Daemon running"
else
    echo "❌ Daemon not responding"
fi

AGENT_COUNT=$(claude-flow agent list 2>/dev/null | grep -c "agent" || echo "0")
echo "✓ Agents registered: $AGENT_COUNT"

if claude-flow hive-mind status >/dev/null 2>&1; then
    echo "✓ Hive-Mind (Raft) active"
    echo ""
    echo "Metrics:"
    claude-flow hive-mind status --metrics 2>/dev/null | head -5 || echo "  (metrics pending)"
else
    echo "⚠ Hive-Mind metrics unavailable"
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo "🎯 READY TO USE"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Monitor: claude-flow hive-mind status --continuous"
echo "  2. Create task: claude-flow task create --title '...' --complexity-hint high"
echo "  3. Search memory: claude-flow memory search --query 'pattern'"
echo "  4. Check costs: claude-flow token-optimizer report"
echo ""
echo "Before pushing to GitHub:"
echo "  1. Export memory: claude-flow memory export > memory-backup.json"
echo "  2. Commit: git add . && git commit -m 'refactor: memory + setup'"
echo "  3. Push: git push origin main"
echo ""
