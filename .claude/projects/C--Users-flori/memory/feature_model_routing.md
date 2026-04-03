---
name: Model routing automático 3-tier
description: Haiku (default) → Sonnet (planificación) → Opus (complejo) vía hook UserPromptSubmit
type: project
---

## Implementación completada (2026-03-29)

### Configuración activa
- **Default model**: `claude-haiku-4-5-20251001` (conversación, preguntas simples)
- **Routing automático**: vía hook `UserPromptSubmit` — analiza cada prompt, emite `[TASK_MODEL_RECOMMENDATION: haiku|sonnet|opus]`
- **Score de complejidad**: 0–100
  - ≤30: Haiku (QA simple, status, explicaciones)
  - ≤70: Sonnet (código, planificación, debugging, scripts)
  - >70: Opus (arquitectura, seguridad, análisis profundo)

### Archivos modificados
1. **`~/.claude/helpers/router.js`**: nueva función `recommendModel()` con `COMPLEXITY_SIGNALS` (haiku/medium/high)
2. **`~/.claude/helpers/hook-handler.cjs`**: emite `[TASK_MODEL_RECOMMENDATION]` en handler 'route'
3. **`~/.claude/settings.json`**:
   - Top level: `"model": "claude-haiku-4-5-20251001"` (usado por statusline)
   - `claudeFlow.modelPreferences`: `default`, `planning`, `complex`
4. **`~/.claude/rules/common/performance.md`**: tabla actualizada con 3-tier routing

### Cómo funciona
- Hook se ejecuta en cada `UserPromptSubmit` (cada prompt nuevo)
- Analiza señales: palabras clave, longitud, contexto
- Emite tag que Claude Code inyecta como contexto
- Statusline refleja el modelo actual (próxima sesión mostrará Haiku si no hay override)

### Nota sobre Remote Triggers
- Se intentó crear pero API rechazó (no aplica para este caso)
- Descartado — no se guardó nada

**Why:** Optimización de costes sin sacrificar calidad. Haiku es suficiente para 80% de conversaciones, Sonnet para desarrollo, Opus solo cuando realmente se necesita reasoning profundo.

**How to apply:** El routing es automático. Solo override manual si algo falla: `/model claude-sonnet-4-6`
