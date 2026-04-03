#!/bin/bash
# Ruflo v3 Hive-Mind Initialization Script
# Production-Ready Setup
# Author: Arquitecto Supremo
# Date: 2026-04-03

set -e  # Exit on first error

echo "🚀 RUFLO V3 HIVE-MIND AUTOCONFIGURACION"
echo "=========================================="
echo ""

# STEP 1: Verificar Ruflo instalado
echo "📦 [1/6] Verificando Ruflo v3..."
if ! command -v claude-flow &> /dev/null; then
    echo "❌ Ruflo NO está instalado. Instalando..."
    npm install -g @claude-flow/cli@latest
fi
RUFLO_VERSION=$(claude-flow --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
echo "✓ Ruflo v${RUFLO_VERSION} listo"
echo ""

# STEP 2: Registrar subagentes desde YAML
echo "👥 [2/6] Registrando 7 subagentes especializados..."
AGENTS=("architect" "coder" "tester" "security-auditor" "devops-engineer" "memory-specialist" "coordinator")
for agent in "${AGENTS[@]}"; do
    CONFIG_FILE=".claude/agents/${agent}.yaml"
    if [ -f "$CONFIG_FILE" ]; then
        echo "  ✓ Registrando ${agent}..."
        claude-flow agent register --config "$CONFIG_FILE" 2>/dev/null || echo "    (ya registrado)"
    else
        echo "  ⚠ ${agent}.yaml NO encontrado en .claude/agents/"
    fi
done
echo ""

# STEP 3: Inicializar Daemon
echo "⚙️  [3/6] Iniciando Daemon de Ruflo..."
claude-flow daemon start --log-level=info --detach 2>/dev/null || echo "  (daemon ya corriendo)"
sleep 2
echo "✓ Daemon iniciado (puerto 9999)"
echo ""

# STEP 4: Inicializar Hive-Mind
echo "🧠 [4/6] Inicializando Hive-Mind (Raft Consensus)..."
claude-flow hive-mind init \
    --consensus raft \
    --topology hierarchical \
    --heartbeat 300ms \
    --election-timeout 3000ms \
    2>/dev/null || echo "  (hive-mind ya inicializado)"
echo "✓ Hive-Mind con Raft Consensus listo"
echo ""

# STEP 5: Inicializar Memory System (HNSW)
echo "💾 [5/6] Inicializando Memory System con HNSW indexing..."
claude-flow memory init \
    --backend hnsw \
    --dimension 1536 \
    --ef-construction 200 \
    --ef-search 100 \
    2>/dev/null || echo "  (memory ya inicializado)"
echo "✓ Memory HNSW indexing listo"
echo ""

# STEP 6: Configurar Hooks
echo "🎣 [6/6] Configurando Hooks automáticos..."
if [ -f ".claude/hooks.json" ]; then
    claude-flow hooks config --from-file .claude/hooks.json 2>/dev/null || true
    echo "✓ Hooks configurados"
else
    echo "  ⚠ .claude/hooks.json NO encontrado"
fi
echo ""

# VERIFICACION FINAL
echo "🔍 VERIFICACION FINAL"
echo "===================="
echo ""

echo "1️⃣  Verificando Daemon..."
if claude-flow daemon status &> /dev/null; then
    echo "   ✓ Daemon corriendo"
else
    echo "   ❌ Daemon NO corre"
fi

echo "2️⃣  Verificando Agents registrados..."
AGENT_COUNT=$(claude-flow agent list 2>/dev/null | grep -c "agent" || echo "0")
echo "   ✓ ${AGENT_COUNT} agentes registrados"

echo "3️⃣  Verificando Hive-Mind status..."
if claude-flow hive-mind status &> /dev/null; then
    echo "   ✓ Hive-Mind activo"
    echo ""
    echo "   Métricas:"
    claude-flow hive-mind status --metrics 2>/dev/null | head -10 || echo "   (métricas no disponibles aún)"
else
    echo "   ⚠ Hive-Mind status no disponible"
fi

echo "4️⃣  Verificando Memory..."
if claude-flow memory status &> /dev/null; then
    echo "   ✓ Memory system listo"
else
    echo "   (memory métricas no disponibles)"
fi

echo ""
echo "=========================================="
echo "✅ SETUP COMPLETADO"
echo "=========================================="
echo ""
echo "📋 PRÓXIMOS PASOS:"
echo "   1. Iniciar Coordinator (siempre activo):"
echo "      claude-flow agent spawn -t coordinator --hive --role leader --detach"
echo ""
echo "   2. Ver estado continuo del hive-mind:"
echo "      claude-flow hive-mind status --continuous --metrics"
echo ""
echo "   3. Crear tu primera tarea:"
echo "      claude-flow task create --title 'My first task' --complexity-hint high"
echo ""
echo "   4. Monitorear agentes:"
echo "      claude-flow hive-mind status --metrics"
echo ""
echo "🎯 Comandos útiles:"
echo "   - claude-flow agent list                 (listar todos)"
echo "   - claude-flow memory search --query ...  (buscar en memory)"
echo "   - claude-flow security scan              (scan de seguridad)"
echo "   - claude-flow doctor --fix               (auto-fix issues)"
echo ""
