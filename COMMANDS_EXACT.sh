#!/bin/bash
# EXACT COMMANDS FOR PRODUCTION SETUP
# Copy-paste these in order

echo "════════════════════════════════════════════════════════════════════"
echo "🚀 EXACT COMMANDS (Copy-Paste Order)"
echo "════════════════════════════════════════════════════════════════════"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 1: Initialize Hive-Mind + Token Optimizer
# ────────────────────────────────────────────────────────────────────────
echo "STEP 1️⃣: Initialize Hive-Mind + Token Optimizer"
echo "──────────────────────────────────────────────"
echo ""
echo "# Start daemon"
echo "claude-flow daemon start --log-level=info --detach"
echo ""
echo "# Wait 2 seconds"
echo "sleep 2"
echo ""
echo "# Initialize Hive-Mind (Raft Consensus)"
echo "claude-flow hive-mind init \\"
echo "  --consensus raft \\"
echo "  --topology hierarchical \\"
echo "  --heartbeat 300ms \\"
echo "  --election-timeout 3000ms"
echo ""
echo "# Activate Token Optimizer (PRIMARY: aggressive caching + compression)"
echo "claude-flow token-optimizer activate \\"
echo "  --compression enabled \\"
echo "  --caching aggressive \\"
echo "  --budget-alert 10"
echo ""
echo "# Verify"
echo "claude-flow daemon status"
echo "claude-flow hive-mind status --metrics"
echo "claude-flow token-optimizer status"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 2: Register Subagents
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 2️⃣: Register 7 Subagents"
echo "─────────────────────────────"
echo ""
echo "# Register all (loop)"
echo "for agent in architect coder tester security-auditor devops-engineer memory-specialist coordinator; do"
echo "  echo \"Registering \$agent...\""
echo "  claude-flow agent register --config .claude/agents/\${agent}.yaml"
echo "done"
echo ""
echo "# Verify"
echo "claude-flow agent list"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 3: Initialize Memory (HNSW)
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 3️⃣: Initialize Memory System (HNSW)"
echo "──────────────────────────────────────────"
echo ""
echo "claude-flow memory init \\"
echo "  --backend hnsw \\"
echo "  --dimension 1536 \\"
echo "  --ef-construction 200"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 4: Spawn Coordinator (Always-On Leader)
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 4️⃣: Spawn Coordinator (Always-On Leader)"
echo "──────────────────────────────────────────────"
echo ""
echo "claude-flow agent spawn \\"
echo "  -t coordinator \\"
echo "  --hive \\"
echo "  --role leader \\"
echo "  --detach"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 5: Export Memory (Before Git Commit)
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 5️⃣: Export Memory (Persistent Knowledge)"
echo "──────────────────────────────────────────────"
echo ""
echo "# Export all indexed patterns + learnings"
echo "claude-flow memory export > memory-backup.json"
echo ""
echo "# Verify"
echo "ls -lh memory-backup.json"
echo "head -20 memory-backup.json"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 6: Git Commit + Push (Initial)
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 6️⃣: Git Commit + Push (Initial Setup)"
echo "──────────────────────────────────────────"
echo ""
echo "# Configure git (one-time)"
echo "git config user.name 'Flori'"
echo "git config user.email 'flori@local'"
echo ""
echo "# Add all (except .env, secrets)"
echo "git add ."
echo ""
echo "# Commit with message"
echo "git commit -m \"init: Ruflo v3 setup with token optimizer + portable init"
echo ""
echo "- Ultra-lean CLAUDE.md (107 lines)"
echo "- setup.sh for automated PC cloning"
echo "- 7 subagents with cost-optimized models (70-80% Haiku)"
echo "- Hive-mind (Raft) + token optimizer (compression + caching)"
echo "- Persistent memory (HNSW indexed, portable)"
echo "- .gitignore: exclude secrets, include .claude/"
echo "\""
echo ""
echo "# Push to GitHub"
echo "git push -u origin main"
echo ""

# ────────────────────────────────────────────────────────────────────────
# STEP 7: Verify Final State
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "STEP 7️⃣: Verify Final State"
echo "───────────────────────────"
echo ""
echo "# Hive-mind status (continuous)"
echo "claude-flow hive-mind status --continuous"
echo ""
echo "# Token optimizer report"
echo "claude-flow token-optimizer report"
echo ""
echo "# Memory status"
echo "claude-flow memory list --limit 5"
echo ""
echo "# Agents"
echo "claude-flow agent list"
echo ""

# ────────────────────────────────────────────────────────────────────────
# BONUS: Recovery on New PC
# ────────────────────────────────────────────────────────────────────────
echo ""
echo "🌍 BONUS: Recovery on New PC"
echo "────────────────────────────"
echo ""
echo "# 1. Clone repo"
echo "git clone https://github.com/YOUR_USERNAME/your-repo.git"
echo "cd your-repo"
echo ""
echo "# 2. Set OpenRouter API key (env var, NEVER .env)"
echo "export OPENROUTER_API_KEY='sk-or-v1-YOUR_KEY_HERE'"
echo ""
echo "# 3. Run automated setup (does everything above)"
echo "./setup.sh"
echo ""
echo "# Result: Identical swarm + memory recovered ✓"
echo ""

echo "════════════════════════════════════════════════════════════════════"
echo "✅ ALL COMMANDS ABOVE"
echo "════════════════════════════════════════════════════════════════════"
echo ""
