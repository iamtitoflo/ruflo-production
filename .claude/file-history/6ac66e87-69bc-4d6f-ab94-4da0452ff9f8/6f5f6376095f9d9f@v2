# GitHub Portability + Memory Persistence Guide

**Objetivo**: Clonar este repo en cualquier PC y recuperar el setup exacto (agentes, memoria, configuración).

---

## 📋 Archivos Críticos (Committed to Git)

```
✓ CLAUDE.md                           # Ultra-lean config (107 líneas)
✓ setup.sh                            # Portable init script
✓ .gitignore                          # Excludes secrets, includes .claude/
✓ .claude/agents/*.yaml               # 7 subagent definitions
✓ .claude/hooks.json                  # Automation rules
✓ .claude/settings.json               # Model routing, OpenRouter config
✓ .claude/REGISTRY.md                 # Agent documentation
✓ .claude/SETUP_COMPLETE.md           # Full setup details
✓ memory-backup.json                  # Exported memory (commit BEFORE push)
```

---

## 🔑 OpenRouter API Key (Environment Variable)

**NUNCA commits `.env`** — usa variables de entorno:

### Linux/macOS/WSL:
```bash
export OPENROUTER_API_KEY="sk-or-v1-YOUR_KEY_HERE"
```

### Windows (PowerShell):
```powershell
$env:OPENROUTER_API_KEY="sk-or-v1-YOUR_KEY_HERE"
```

### Windows (CMD):
```cmd
set OPENROUTER_API_KEY=sk-or-v1-YOUR_KEY_HERE
```

### Persistent (Linux/macOS):
```bash
echo 'export OPENROUTER_API_KEY="sk-or-v1-YOUR_KEY_HERE"' >> ~/.bashrc
source ~/.bashrc
```

### Persistent (Windows PowerShell):
```powershell
# Edit $PROFILE or use environment variables GUI
# Settings > System > Advanced > Environment Variables
# New User Variable: OPENROUTER_API_KEY = sk-or-v1-YOUR_KEY_HERE
```

---

## 💾 Memory Export/Import (Persistent Knowledge)

### Export Current Memory (Before Commit/Push)
```bash
# Full memory export (semantic knowledge, patterns, decisions)
claude-flow memory export > memory-backup.json

# Verify export
wc -l memory-backup.json
head -20 memory-backup.json
```

### Import Memory (After git clone on New PC)
```bash
# Will run automatically in setup.sh, but manual import:
claude-flow memory import < memory-backup.json

# Verify import
claude-flow memory list --limit 10
claude-flow memory search --query "test" --limit 3
```

### Memory Namespaces (What Gets Persisted)
```json
{
  "coordination": "Central shared state (HNSW indexed)",
  "arch-decisions": "Architecture patterns + ADRs",
  "code-impl": "Code patterns, snippets, learnings",
  "testing": "Test patterns, coverage strategies",
  "security": "CVE tracking, vulnerability patterns",
  "devops": "IaC patterns, deployment learnings",
  "memory-mgmt": "Meta patterns about memory itself",
  "commits": "Commit history for reference"
}
```

---

## 🚀 Initial Setup (First Time)

```bash
# 1. Clone your repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# 2. Set OpenRouter API key (environment variable, NEVER in .env)
export OPENROUTER_API_KEY="sk-or-v1-YOUR_KEY_HERE"

# 3. Run portable setup (everything automated)
./setup.sh

# 4. Verify
claude-flow hive-mind status --metrics
claude-flow token-optimizer status
```

---

## 🔄 Recovery on New PC (Full Clone + Memory)

```bash
# 1. Clone repository
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# 2. Set OpenRouter key (env var, not .env)
export OPENROUTER_API_KEY="sk-or-v1-YOUR_KEY_HERE"

# 3. Run setup.sh
# Automatically:
#   - Initializes git
#   - Installs Ruflo
#   - Registers agents from .yaml
#   - Starts daemon + hive-mind
#   - Activates token optimizer
#   - Imports memory from memory-backup.json ← PERSISTENCE
#   - Spawns coordinator
./setup.sh

# 4. Verify same state as original PC
claude-flow memory search --query "pattern" --limit 5
claude-flow agent list
```

---

## 📤 Commit + Push Workflow

### Before Every Push:

```bash
# 1. Export latest memory (captures all learnings)
claude-flow memory export > memory-backup.json

# 2. Add all (hooks will auto-check security)
git add .

# 3. Commit with clear message
git commit -m "refactor: update memory + config

- Memory export with latest patterns
- Token optimizer settings optimized
- Subagent learnings indexed
"

# 4. Push to GitHub
git push origin main

# 5. Verify (optional)
git log --oneline | head -5
```

---

## 🔐 What Gets Committed vs Ignored

### ✓ COMMITTED (Portable):
```
.claude/agents/*.yaml         # Agent definitions
.claude/hooks.json           # Automation
.claude/settings.json        # Config (with model routing)
.claude/REGISTRY.md          # Documentation
CLAUDE.md                    # Ultra-lean config
setup.sh                     # Init script
memory-backup.json           # Exported knowledge
.gitignore                   # File exclusion rules
```

### ✗ IGNORED (Secrets, Temp):
```
.env / .env.local            # ❌ API keys
.claude/node_modules/        # ❌ Large
.claude-flow/logs/           # ❌ Temp
.token-cache/                # ❌ Runtime state
```

---

## 🎯 Complete Setup Checklist

- [ ] Repository cloned or initialized (`git init`)
- [ ] .gitignore configured (exclude secrets, include .claude/)
- [ ] Ruflo installed (`claude-flow --version`)
- [ ] OpenRouter API key set as ENV VAR (not in .env)
- [ ] setup.sh created + executable (`chmod +x setup.sh`)
- [ ] Initial commit: `git add . && git commit -m "init: Ruflo setup"`
- [ ] Memory exported: `claude-flow memory export > memory-backup.json`
- [ ] Final commit with memory: `git add . && git commit -m "refactor: add memory"`
- [ ] Pushed to GitHub: `git push origin main`
- [ ] Tested clone on new PC: `git clone ... && ./setup.sh`

---

## 🔍 Troubleshooting Portability

### Memory not imported on new PC?
```bash
# Check if backup exists
ls -la memory-backup.json

# Check if memory system is initialized
claude-flow memory status

# Manual import
claude-flow memory import < memory-backup.json

# Verify
claude-flow memory list --limit 5
```

### Agents not registering on clone?
```bash
# Check YAML files exist
ls -la .claude/agents/*.yaml

# Manual registration
for yaml in .claude/agents/*.yaml; do
  claude-flow agent register --config "$yaml"
done

# Verify
claude-flow agent list
```

### OpenRouter key not found?
```bash
# Verify env var set
echo $OPENROUTER_API_KEY

# If empty, set it:
export OPENROUTER_API_KEY="sk-or-v1-..."

# Check settings.json has fallback config
grep -A5 "openrouter" .claude/settings.json
```

### Token optimizer not active?
```bash
# Re-activate
claude-flow token-optimizer activate \
  --compression enabled \
  --caching aggressive

# Verify
claude-flow token-optimizer status
```

---

## 📊 GitHub Repository Template

When creating your repo on GitHub:

```bash
# After initial setup locally:

# 1. Create repo on GitHub (empty, no README)

# 2. Add remote
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main

# 3. First push
git add .
git commit -m "init: Ruflo v3 setup with token optimizer + hive-mind"
git push -u origin main

# 4. Add memory before next push
claude-flow memory export > memory-backup.json
git add memory-backup.json
git commit -m "refactor: add persistent memory export"
git push
```

---

## 🎉 Result

After all steps:
- ✅ Repo is fully portable
- ✅ Memory persists across clones
- ✅ Setup is 100% automated (./setup.sh)
- ✅ Secrets are never committed (env vars only)
- ✅ Cost-optimized (70-80% Haiku, token caching)
- ✅ Any PC → `git clone` + `./setup.sh` = identical swarm

---

**Next**: See SETUP_COMPLETE.md for full details. See CLAUDE.md for configuration.
