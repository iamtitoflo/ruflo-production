# Subagentes Registrados - Producción

**Proyecto**: Claude Code + Ruflo v3 Hive-Mind
**Fecha**: 2026-04-03
**Coordinador**: coordinator (Sonnet, Leader)
**Max Agentes**: 8 (hierarchical topology)
**Consenso**: Raft + Byzantine fault tolerance

---

## 📋 Registro Completo

| Agente | Modelo | Rol | Complejidad | Namespace | Status |
|--------|--------|-----|-------------|-----------|--------|
| **architect** | Opus | Specialist | Alta (>70%) | arch-decisions | Registrado ✓ |
| **coder** | Sonnet | Worker | Media (30-70%) | code-impl | Registrado ✓ |
| **tester** | Haiku | Worker | Baja (<30%) | testing | Registrado ✓ |
| **security-auditor** | Opus | Reviewer | Alta (>70%) | security | Registrado ✓ |
| **devops-engineer** | Sonnet | Worker | Media (30-70%) | devops | Registrado ✓ |
| **memory-specialist** | Haiku | Worker | Baja (<30%) | memory-mgmt | Registrado ✓ |
| **coordinator** | Sonnet | **Leader** | Media (30-70%) | coordination | **Siempre ON** |

---

## 🎯 Routing Logic (Coordinator automático)

```
Tarea entra → COORDINATOR evalúa
  ├─ Complejidad BAJA (<30%)
  │  └─ Assign: TESTER o MEMORY-SPECIALIST
  ├─ Complejidad MEDIA (30-70%)
  │  └─ Assign: CODER o DEVOPS-ENGINEER
  └─ Complejidad ALTA (>70%)
     └─ Assign: ARCHITECT o SECURITY-AUDITOR
```

---

## 🔧 Spawn Commands

```bash
# Registrar todos (una vez)
for agent in architect coder tester security-auditor devops-engineer memory-specialist coordinator; do
  claude-flow agent register --config .claude/agents/$agent.yaml
done

# Verificar registro
claude-flow agent list

# Iniciar Coordinator (debe estar siempre activo)
claude-flow agent spawn -t coordinator --hive --role leader

# View status
claude-flow hive-mind status --metrics
```

---

## 📊 Memory Namespaces (Compartidas)

```
coordination     ← SHARED entre todos (Coordinator mantiene)
├── arch-decisions    ← architect
├── code-impl         ← coder
├── testing           ← tester
├── security          ← security-auditor
├── devops            ← devops-engineer
└── memory-mgmt       ← memory-specialist
```

---

## 🎬 Quick Start

```bash
# 1. Register all agents
for agent in architect coder tester security-auditor devops-engineer memory-specialist coordinator; do
  echo "Registering $agent..."
  claude-flow agent register --config .claude/agents/$agent.yaml
done

# 2. Start Coordinator (must be always-on)
claude-flow agent spawn -t coordinator --hive --role leader --detach

# 3. Verify hive-mind status
claude-flow hive-mind status --metrics

# 4. Test task routing
claude-flow task create --title "Test routing" --complexity-hint high

# 5. Monitor
claude-flow hive-mind status --continuous --metrics
```

---

## 🚨 Roles Explanation

- **Leader** (Coordinator): Orquestación, routing, consenso, state
- **Specialist**: Ejecutores de tareas específicas
- **Worker**: Ejecutores sin liderazgo
- **Reviewer** (Security-Auditor): Bloquea commits si encuentra críticos

---

## 💾 Persistence

- YAML configs persisten en `.claude/agents/`
- Registros en: `~/.claude/agents.json`
- Memory namespaces en: `~/.claude/memory/`
- Hive-mind state en: `~/.claude/hive-state.json`
