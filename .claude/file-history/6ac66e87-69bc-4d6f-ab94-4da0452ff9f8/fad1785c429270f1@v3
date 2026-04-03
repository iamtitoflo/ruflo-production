# Ruflo v3 Production Config (Ultra-Lean)

**Version**: 3.5.51 | **Updated**: 2026-04-03 | **Model Routing**: 3-Tier Auto

## Model Routing (Cost-First: 70-80% Haiku/Free, 15-25% Sonnet, 5-10% Opus)

| % | Model | Cost | Use |
|---|---|---|---|
| 70-80% | Haiku 4.5 / Free | ~$0.0001 | Triage, tests, memory |
| 15-25% | Sonnet 4.6 | ~$0.003 | Coding, planning, debugging |
| 5-10% | Opus 4.6 | ~$0.015 | Architecture, security, complex decisions |

**OpenRouter fallback**: Export `OPENROUTER_API_KEY`

## Hive-Mind + Token Optimizer

```bash
# Initialize (run setup.sh, or manually):
claude-flow hive-mind init --consensus raft --topology hierarchical
claude-flow token-optimizer activate --compression enabled --caching aggressive

# Commands:
claude-flow hive-mind status --metrics
claude-flow token-optimizer status
claude-flow memory export > memory-backup.json
```

## 7 Subagentes (Single-Responsibility, Model-Optimized)

**Defined in** `.claude/agents/*.yaml`:
- `architect.yaml` (Opus, <5%) — Design decisions
- `coder.yaml` (Sonnet, 20%) — Implementation TDD
- `tester.yaml` (Haiku, 30%) — Tests + coverage 80%+
- `security-auditor.yaml` (Opus, 5%) — OWASP scan
- `devops-engineer.yaml` (Sonnet, 15%) — IaC, CI/CD, Proxmox
- `memory-specialist.yaml` (Haiku, 20%) — HNSW indexing
- `coordinator.yaml` (Sonnet) — Orchestration (always-on leader)

See `.claude/agents/REGISTRY.md` for registration commands.

## Hooks (Low-Cost Automations)

**Config**: `.claude/hooks.json`
- Pre-commit security scan (blocks secrets)
- Auto-lint (JS/TS/Python)
- Test coverage verify (80%+ minimum)
- Memory sync post-task
- Checkpoints (5+ files changed)

## Behavioral Rules (Always)

- ✅ **All ops parallel**: 1 message = all concurrent actions
- ✅ **Planning first**: TDD + architecture before coding
- ✅ **Context <60%**: Token hygiene, /clear aggressive
- ✅ **No secrets**: .env files never committed
- ✅ **Git commits**: Before major changes
- ✅ **Memory index**: Patterns, decisions, learning

## Portability + Persistence

**Export memory**: `claude-flow memory export > backup.json`
**Import memory**: `claude-flow memory import < backup.json`
**Full setup**: Run `./setup.sh` on new PC (clones everything)

See `setup.sh` + `SETUP_COMPLETE.md` for details.

## Quick Commands

```bash
# Verify setup
./setup.sh                          # Full init on new PC
claude-flow doctor --fix            # Auto-fix issues

# Monitor
claude-flow hive-mind status --continuous

# Optimize
claude-flow token-optimizer reset   # Clear cache
/clear                              # Clear context aggressively

# Memory
claude-flow memory search --query "pattern"
claude-flow memory export > backup.json

# Commit (before major work)
git add . && git commit -m "feature: ..."
```

## Token Cost Monitoring

```bash
# Check spending
claude-flow token-optimizer report
export OPENROUTER_BUDGET_ALERT=10  # Alert at $10/day

# Cost per model (approx):
# Haiku: $0.0002/1K tokens
# Sonnet: $0.003/1K tokens
# Opus: $0.015/1K tokens
```

## Support

- Docs: https://github.com/ruvnet/ruflo
- Init: `./setup.sh`
- Export: `claude-flow memory export`
- Git: This repo is portable—clone and run `./setup.sh`
