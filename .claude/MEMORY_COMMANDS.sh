#!/bin/bash
# Memory Export/Import Commands for GitHub Portability
# Run these to persist knowledge across PC clones

echo "════════════════════════════════════════════════════════════════"
echo "💾 MEMORY PERSISTENCE COMMANDS (GitHub Portable)"
echo "════════════════════════════════════════════════════════════════"
echo ""

# ────────────────────────────────────────────────────────────────────
# EXPORT MEMORY (Before git commit + push)
# ────────────────────────────────────────────────────────────────────
echo "📤 EXPORT MEMORY (captures all learnings, patterns, decisions)"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Command:"
echo "  claude-flow memory export > memory-backup.json"
echo ""
echo "What gets exported:"
echo "  ✓ All indexed patterns (HNSW semantic search)"
echo "  ✓ Architecture decisions (ADRs)"
echo "  ✓ Code patterns + snippets"
echo "  ✓ Test learnings"
echo "  ✓ Security CVE tracking"
echo "  ✓ DevOps patterns (IaC, deployment)"
echo "  ✓ Commit history + metadata"
echo ""
echo "Run BEFORE every git push:"
echo "  1. claude-flow memory export > memory-backup.json"
echo "  2. git add memory-backup.json"
echo "  3. git commit -m 'refactor: update memory export'"
echo "  4. git push origin main"
echo ""

# ────────────────────────────────────────────────────────────────────
# IMPORT MEMORY (After git clone on new PC)
# ────────────────────────────────────────────────────────────────────
echo "📥 IMPORT MEMORY (recover from memory-backup.json)"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Command:"
echo "  claude-flow memory import < memory-backup.json"
echo ""
echo "When to run:"
echo "  ✓ After 'git clone' on new PC"
echo "  ✓ Automatically in setup.sh (if memory-backup.json exists)"
echo "  ✓ Manual recovery: copy memory-backup.json to project dir"
echo ""
echo "Verify import:"
echo "  claude-flow memory list --limit 10"
echo "  claude-flow memory search --query 'authentication' --limit 5"
echo ""

# ────────────────────────────────────────────────────────────────────
# MEMORY SEARCH (Use persistent knowledge)
# ────────────────────────────────────────────────────────────────────
echo "🔍 MEMORY SEARCH (semantic, HNSW indexed)"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Examples:"
echo ""
echo "  # Search for patterns"
echo "  claude-flow memory search --query 'authentication patterns' --limit 5"
echo ""
echo "  # Search in specific namespace"
echo "  claude-flow memory search --query 'scaling' --namespace devops --limit 3"
echo ""
echo "  # Full-text with threshold"
echo "  claude-flow memory search --query 'error handling' --threshold 0.8"
echo ""

# ────────────────────────────────────────────────────────────────────
# MEMORY STORE (Save new patterns)
# ────────────────────────────────────────────────────────────────────
echo "💾 MEMORY STORE (save learned patterns)"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Example:"
echo "  claude-flow memory store \\"
echo "    --key 'pattern-auth-jwt-refresh' \\"
echo "    --value 'JWT with 15min access + 7day refresh tokens' \\"
echo "    --namespace security \\"
echo "    --ttl 7776000 \\"
echo "    --tags 'authentication,jwt,tokens'"
echo ""

# ────────────────────────────────────────────────────────────────────
# MEMORY STATUS
# ────────────────────────────────────────────────────────────────────
echo "📊 MEMORY STATUS"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Commands:"
echo "  claude-flow memory status                    # Overall status"
echo "  claude-flow memory list --namespace security # List by namespace"
echo "  claude-flow memory gc --compress              # Cleanup + optimize"
echo ""

# ────────────────────────────────────────────────────────────────────
# TOKEN OPTIMIZER + COST TRACKING
# ────────────────────────────────────────────────────────────────────
echo "💰 TOKEN OPTIMIZER + COST TRACKING"
echo "────────────────────────────────────────────────────────────────"
echo ""
echo "Monitor spending:"
echo "  claude-flow token-optimizer report          # Show usage + cost"
echo "  export OPENROUTER_BUDGET_ALERT=10           # Alert at $10/day"
echo ""
echo "Optimization settings:"
echo "  claude-flow token-optimizer activate \\"
echo "    --compression enabled \\"
echo "    --caching aggressive \\"
echo "    --budget-alert 10"
echo ""

echo "════════════════════════════════════════════════════════════════"
echo "✅ USE THIS BEFORE GIT PUSH:"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "  # 1. Export memory"
echo "  claude-flow memory export > memory-backup.json"
echo ""
echo "  # 2. Check what changed"
echo "  git status"
echo ""
echo "  # 3. Commit all"
echo "  git add ."
echo "  git commit -m 'refactor: memory export + knowledge update'"
echo ""
echo "  # 4. Push to GitHub"
echo "  git push origin main"
echo ""
echo "  # 5. Verify on GitHub"
echo "  # memory-backup.json should be in root"
echo ""
