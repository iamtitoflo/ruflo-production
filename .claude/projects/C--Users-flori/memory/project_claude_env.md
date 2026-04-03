---
name: Entorno Claude configurado
description: Estado del entorno local de Claude — optimizaciones, agentes y configuración aplicada
type: project
---

## Optimizaciones aplicadas

### Costes (2026-03-28 → 2026-03-29)
- **v1 (2026-03-28)**: Model default `claude-sonnet-4-6` (de opus)
- **v2 (2026-03-29)**: Model default `claude-haiku-4-5-20251001` + 3-tier auto-routing

### 3-Tier Model Routing (ACTIVO)
Auto-enruta cada prompt según complejidad:
- **Haiku (≤30)**: preguntas simples, status, explicaciones, conversación
- **Sonnet (≤70)**: código, planificación, scripts, debugging, review
- **Opus (>70)**: arquitectura, seguridad, análisis complejo, decisiones

**Implementación**: Hook `UserPromptSubmit` ejecuta `router.recommendModel()` → emite `[TASK_MODEL_RECOMMENDATION: haiku|sonnet|opus]`

**Archivos modificados**:
- `~/.claude/helpers/router.js` — función `recommendModel(task)` con señales de complejidad
- `~/.claude/helpers/hook-handler.cjs` — handler 'route' emite recommendation tag
- `~/.claude/settings.json` — top-level `"model": "claude-haiku-4-5-20251001"` + `modelPreferences` con planning/complex
- `~/.claude/rules/common/performance.md` — tabla actualizada con 3-tier guide

### Limpieza de espacio
- Eliminados `~/.claude/plugins/cache/` (~289MB) — regenerable
- Eliminados `~/.claude/plugins/marketplaces/thedotmack/` (~279MB) — no usado
- Espacio liberado: ~400MB (de 484MB → 85MB)

### Agentes personalizados creados
- `~/.claude/agents/sysadmin.md` — especializado en Proxmox, AD, Intune, PS, Python, redes

### Comandos personalizados creados
- `~/.claude/commands/ps-review.md` — revisar scripts PowerShell antes de ejecutar en prod
- `~/.claude/commands/infra-plan.md` — generar runbook para tareas de infraestructura

### GitHub CLI
- Instalado: GitHub CLI v2.89.0
- Autenticado como: `iamtitoflo`
- Scopes: gist, read:org, repo, workflow

**Why:** Optimización de costes y productividad para uso diario de Claude como sysadmin.
**How to apply:** Al sugerir modelos o flujos de trabajo, usar Sonnet por defecto y Haiku para tareas simples.
