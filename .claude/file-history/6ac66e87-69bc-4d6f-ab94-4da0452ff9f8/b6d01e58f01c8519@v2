# Ruflo v3 Hive-Mind Initialization (PowerShell)
# Production-Ready Setup
# Author: Arquitecto Supremo
# Date: 2026-04-03

function Write-Status {
    param([string]$Message, [string]$Status)
    $symbols = @{
        'success' = '✓'
        'error' = '❌'
        'warning' = '⚠'
        'info' = 'ℹ'
        'step' = '→'
    }
    $symbol = $symbols[$Status] -or $symbols['info']
    Write-Host "$symbol $Message" -ForegroundColor Green
}

function Write-Error-Status {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Step {
    param([string]$Message)
    Write-Host "🚀 $Message" -ForegroundColor Cyan
}

# Main
Write-Host "`n"
Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║   RUFLO V3 HIVE-MIND AUTOCONFIGURACION (PowerShell)   ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host "`n"

# STEP 1
Write-Step "[1/6] Verificando Ruflo v3..."
$rufloVersion = & claude-flow --version 2>$null
if ($null -eq $rufloVersion) {
    Write-Error-Status "Ruflo NO está instalado. Instalando..."
    npm install -g @claude-flow/cli@latest
    $rufloVersion = & claude-flow --version
}
Write-Status "Ruflo instalado: $rufloVersion" -Status success
Write-Host "`n"

# STEP 2
Write-Step "[2/6] Registrando 7 subagentes especializados..."
$agents = @("architect", "coder", "tester", "security-auditor", "devops-engineer", "memory-specialist", "coordinator")
foreach ($agent in $agents) {
    $configFile = ".\.claude\agents\$agent.yaml"
    if (Test-Path $configFile) {
        Write-Host "  → Registrando $agent..." -ForegroundColor Yellow
        & claude-flow agent register --config $configFile 2>$null | Out-Null
    } else {
        Write-Host "  ⚠ $agent.yaml NO encontrado" -ForegroundColor Yellow
    }
}
Write-Host "`n"

# STEP 3
Write-Step "[3/6] Iniciando Daemon de Ruflo..."
& claude-flow daemon start --log-level=info --detach 2>$null | Out-Null
Start-Sleep -Seconds 2
Write-Status "Daemon iniciado (puerto 9999)" -Status success
Write-Host "`n"

# STEP 4
Write-Step "[4/6] Inicializando Hive-Mind (Raft Consensus)..."
$hiveMindInit = & claude-flow hive-mind init `
    --consensus raft `
    --topology hierarchical `
    --heartbeat 300ms `
    --election-timeout 3000ms `
    2>$null
Write-Status "Hive-Mind con Raft Consensus listo" -Status success
Write-Host "`n"

# STEP 5
Write-Step "[5/6] Inicializando Memory System (HNSW)..."
& claude-flow memory init `
    --backend hnsw `
    --dimension 1536 `
    --ef-construction 200 `
    --ef-search 100 `
    2>$null | Out-Null
Write-Status "Memory HNSW indexing listo" -Status success
Write-Host "`n"

# STEP 6
Write-Step "[6/6] Configurando Hooks automáticos..."
if (Test-Path ".\.claude\hooks.json") {
    & claude-flow hooks config --from-file .\.claude\hooks.json 2>$null | Out-Null
    Write-Status "Hooks configurados" -Status success
} else {
    Write-Host "  ⚠ .claude\hooks.json NO encontrado" -ForegroundColor Yellow
}
Write-Host "`n"

# FINAL VERIFICATION
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "🔍 VERIFICACION FINAL" -ForegroundColor Cyan
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Magenta
Write-Host "`n"

$daemonStatus = & claude-flow daemon status 2>$null
if ($daemonStatus) {
    Write-Status "Daemon corriendo" -Status success
} else {
    Write-Error-Status "Daemon NO corre"
}

$agentList = & claude-flow agent list 2>$null
$agentCount = if ($agentList) { ($agentList | Measure-Object -Line).Lines } else { 0 }
Write-Status "$agentCount agentes registrados" -Status success

$hiveMindStatus = & claude-flow hive-mind status 2>$null
if ($hiveMindStatus) {
    Write-Status "Hive-Mind activo" -Status success
} else {
    Write-Status "Hive-Mind métricas no disponibles" -Status warning
}

Write-Host "`n"
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "✅ SETUP COMPLETADO" -ForegroundColor Green
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "`n"

Write-Host "📋 PRÓXIMOS PASOS:" -ForegroundColor Yellow
Write-Host "   1. Iniciar Coordinator (siempre activo):" -ForegroundColor White
Write-Host "      claude-flow agent spawn -t coordinator --hive --role leader --detach" -ForegroundColor Cyan
Write-Host "`n   2. Ver estado continuo del hive-mind:" -ForegroundColor White
Write-Host "      claude-flow hive-mind status --continuous --metrics" -ForegroundColor Cyan
Write-Host "`n   3. Crear tu primera tarea:" -ForegroundColor White
Write-Host "      claude-flow task create --title 'My task' --complexity-hint high" -ForegroundColor Cyan
Write-Host "`n   4. Monitorear agentes:" -ForegroundColor White
Write-Host "      claude-flow hive-mind status --metrics" -ForegroundColor Cyan
Write-Host "`n"

Write-Host "🎯 Comandos útiles:" -ForegroundColor Yellow
Write-Host "   - claude-flow agent list" -ForegroundColor Cyan
Write-Host "   - claude-flow memory search --query '...'" -ForegroundColor Cyan
Write-Host "   - claude-flow security scan" -ForegroundColor Cyan
Write-Host "   - claude-flow doctor --fix" -ForegroundColor Cyan
Write-Host "`n"
