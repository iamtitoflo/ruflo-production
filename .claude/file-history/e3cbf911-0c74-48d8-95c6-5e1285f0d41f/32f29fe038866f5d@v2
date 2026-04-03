# Performance Optimization

## Model Selection Strategy (3-Tier Auto-Routing)

The `UserPromptSubmit` hook classifies each prompt (score 0–100) and emits
`[TASK_MODEL_RECOMMENDATION: haiku|sonnet|opus]`. Always respect this tag.

| Score | Model | Use cases |
|-------|-------|-----------|
| ≤ 30  | **Haiku 4.5** ← DEFAULT | Preguntas simples, status, explicaciones, conversación |
| ≤ 70  | **Sonnet 4.6** | Implementación, código, planificación, debugging, scripts |
| > 70  | **Opus 4.6**  | Arquitectura, seguridad, análisis complejo, decisiones de diseño |

When spawning subagents via the Agent tool, set `model:` accordingly:
- `model: "haiku"` — workers simples, research rápido
- `model: "sonnet"` — coding, planificación, tareas medianas
- `model: "opus"` — arquitectura, auditoría de seguridad, análisis profundo

## Context Window Management

Avoid last 20% of context window for:
- Large-scale refactoring
- Feature implementation spanning multiple files
- Debugging complex interactions

Lower context sensitivity tasks:
- Single-file edits
- Independent utility creation
- Documentation updates
- Simple bug fixes

## Extended Thinking + Plan Mode

Extended thinking is enabled by default, reserving up to 31,999 tokens for internal reasoning.

Control extended thinking via:
- **Toggle**: Option+T (macOS) / Alt+T (Windows/Linux)
- **Config**: Set `alwaysThinkingEnabled` in `~/.claude/settings.json`
- **Budget cap**: `export MAX_THINKING_TOKENS=10000`
- **Verbose mode**: Ctrl+O to see thinking output

For complex tasks requiring deep reasoning:
1. Ensure extended thinking is enabled (on by default)
2. Enable **Plan Mode** for structured approach
3. Use multiple critique rounds for thorough analysis
4. Use split role sub-agents for diverse perspectives

## Build Troubleshooting

If build fails:
1. Use **build-error-resolver** agent
2. Analyze error messages
3. Fix incrementally
4. Verify after each fix
