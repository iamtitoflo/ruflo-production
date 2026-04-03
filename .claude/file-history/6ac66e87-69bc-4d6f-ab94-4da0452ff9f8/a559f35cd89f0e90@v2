---
name: Setup Ruflo v3 Production (2026-04-03)
description: Autoconfiguracion completa Ruflo + Hive-Mind + 7 subagentes + model routing 3-tier
type: project
---

**Estado**: Completado en 2026-04-03
**Versión**: Ruflo v3.5.51
**Setup**: Production-Ready

## Archivos Creados / Actualizados

### Configuración
1. **CLAUDE.md** — 141 líneas, optimizado (model routing, hive-mind, CLI commands)
2. **.claude/settings.json** — Extended con ruflo hive-mind + 3-tier routing
3. **.claude/hooks.json** — 15+ hooks automáticos

### Subagentes (7 en .claude/agents/)
- architect.yaml (Opus) — Decisiones de diseño
- coder.yaml (Sonnet) — Implementación TDD
- tester.yaml (Haiku) — Tests + coverage
- security-auditor.yaml (Opus) — OWASP scan
- devops-engineer.yaml (Sonnet) — IaC, CI/CD, Proxmox
- memory-specialist.yaml (Haiku) — HNSW, memory sync
- coordinator.yaml (Sonnet, Leader) — Orquestación, siempre ON

### Scripts
- .claude/INIT_RUFLO.sh (Bash)
- .claude/INIT_RUFLO.ps1 (PowerShell)
- .claude/SETUP_COMPLETE.md (Documentación completa)

## Configuración Activa

**Hive-Mind**:
- Consenso: Raft + Byzantine FT
- Topology: Hierarchical
- Max agents: 8
- Heartbeat: 300ms
- Leader: coordinator

**Model Routing**:
- <30%: Haiku ($0.0002)
- 30-70%: Sonnet ($0.003)
- >70%: Opus ($0.015)

**Memory**: HNSW backend, dim=1536, shared namespace: coordination

**Hooks**: Auto-lint, security-scan, test-coverage, memory-sync, checkpoints

## Quick Start

PowerShell: `.\.claude\INIT_RUFLO.ps1`
Bash: `./.claude/INIT_RUFLO.sh`

Manualmente: `claude-flow daemon start`, registrar agents, init hive-mind, memory, spawn coordinator

## Próximas Veces

- Rodar init script al empezar proyecto complejo
- Usar `claude-flow hive-mind status` para monitorear
- Recordar que Coordinator debe estar siempre activo
- Memory search: `claude-flow memory search --query "pattern"`
