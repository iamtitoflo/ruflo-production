#!/usr/bin/env node
/**
 * Claude Flow Agent Router
 * Routes tasks to optimal agents and models based on complexity
 */

// Model routing thresholds
const MODEL_THRESHOLDS = {
  haiku:  { max: 30, id: 'claude-haiku-4-5-20251001',  label: 'Haiku'  },
  sonnet: { max: 70, id: 'claude-sonnet-4-6',           label: 'Sonnet' },
  opus:   { max: 100, id: 'claude-opus-4-6',            label: 'Opus'   },
};

// Complexity signals per tier
const COMPLEXITY_SIGNALS = {
  // High complexity → Opus (architectural, deep analysis, security)
  high: [
    'arquitectura', 'architecture', 'sistema distribuido', 'distributed system',
    'diseño de sistema', 'system design', 'seguridad', 'security audit',
    'análisis profundo', 'deep analysis', 'refactorizar todo', 'full refactor',
    'migración', 'migration', 'consenso', 'consensus', 'escalabilidad', 'scalability',
    'threat model', 'vulnerability', 'cve', 'zero-trust', 'compliance',
    'multiple files', 'cross-cutting', 'bounded context', 'domain model',
    'performance optimization', 'benchmarking', 'concurrency', 'race condition',
  ],
  // Medium complexity → Sonnet (planning, implementation, coding)
  medium: [
    'plan', 'planifica', 'implementa', 'implement', 'crea', 'create', 'build',
    'desarrolla', 'develop', 'diseña', 'design', 'refactoriza', 'refactor',
    'optimiza', 'optimize', 'mejora', 'improve', 'añade', 'add feature',
    'configura', 'configure', 'instala', 'install', 'despliega', 'deploy',
    'prueba', 'test', 'debug', 'fix bug', 'arregla', 'script', 'automatiza',
    'workflow', 'pipeline', 'api', 'endpoint', 'database', 'auth',
    'code review', 'revisar código', 'analiza', 'analyze',
  ],
  // Low complexity → Haiku (simple Q&A, explanations, status)
  low: [
    'qué es', 'what is', 'qué significa', 'explain', 'explica', 'cómo funciona',
    'how does', 'muestra', 'show me', 'lista', 'list', 'resume', 'summarize',
    'status', 'estado', 'check', 'verifica', 'simple', 'básico', 'quick',
    'hola', 'hello', 'gracias', 'thanks', 'ayuda', 'help',
  ],
};

/**
 * Compute complexity score (0-100) and return model recommendation.
 */
function recommendModel(task) {
  const t = task.toLowerCase();
  let score = 25; // base → haiku territory

  // Boost for high-complexity signals
  for (const signal of COMPLEXITY_SIGNALS.high) {
    if (t.includes(signal)) score += 25;
  }
  // Moderate boost for medium signals
  for (const signal of COMPLEXITY_SIGNALS.medium) {
    if (t.includes(signal)) score += 12;
  }
  // Reduce for explicit low-complexity signals
  for (const signal of COMPLEXITY_SIGNALS.low) {
    if (t.includes(signal)) score = Math.max(5, score - 10);
  }

  // Length heuristic: longer prompts tend to be more complex
  if (task.length > 300) score += 15;
  else if (task.length > 150) score += 8;

  score = Math.min(100, score);

  if (score <= MODEL_THRESHOLDS.haiku.max)  return { model: 'haiku',  id: MODEL_THRESHOLDS.haiku.id,  score };
  if (score <= MODEL_THRESHOLDS.sonnet.max) return { model: 'sonnet', id: MODEL_THRESHOLDS.sonnet.id, score };
  return { model: 'opus', id: MODEL_THRESHOLDS.opus.id, score };
}

const AGENT_CAPABILITIES = {
  coder: ['code-generation', 'refactoring', 'debugging', 'implementation'],
  tester: ['unit-testing', 'integration-testing', 'coverage', 'test-generation'],
  reviewer: ['code-review', 'security-audit', 'quality-check', 'best-practices'],
  researcher: ['web-search', 'documentation', 'analysis', 'summarization'],
  architect: ['system-design', 'architecture', 'patterns', 'scalability'],
  'backend-dev': ['api', 'database', 'server', 'authentication'],
  'frontend-dev': ['ui', 'react', 'css', 'components'],
  devops: ['ci-cd', 'docker', 'deployment', 'infrastructure'],
};

const TASK_PATTERNS = {
  // Code patterns
  'implement|create|build|add|write code': 'coder',
  'test|spec|coverage|unit test|integration': 'tester',
  'review|audit|check|validate|security': 'reviewer',
  'research|find|search|documentation|explore': 'researcher',
  'design|architect|structure|plan': 'architect',

  // Domain patterns
  'api|endpoint|server|backend|database': 'backend-dev',
  'ui|frontend|component|react|css|style': 'frontend-dev',
  'deploy|docker|ci|cd|pipeline|infrastructure': 'devops',
};

function routeTask(task) {
  const taskLower = task.toLowerCase();

  // Check patterns
  for (const [pattern, agent] of Object.entries(TASK_PATTERNS)) {
    const regex = new RegExp(pattern, 'i');
    if (regex.test(taskLower)) {
      return {
        agent,
        confidence: 0.8,
        reason: `Matched pattern: ${pattern}`,
      };
    }
  }

  // Default to coder for unknown tasks
  return {
    agent: 'coder',
    confidence: 0.5,
    reason: 'Default routing - no specific pattern matched',
  };
}

// CLI
const task = process.argv.slice(2).join(' ');

if (task) {
  const result = routeTask(task);
  const model = recommendModel(task);
  console.log(JSON.stringify({ ...result, model }, null, 2));
} else {
  console.log('Usage: router.js <task description>');
  console.log('\nAvailable agents:', Object.keys(AGENT_CAPABILITIES).join(', '));
}

module.exports = { routeTask, recommendModel, AGENT_CAPABILITIES, TASK_PATTERNS, MODEL_THRESHOLDS, COMPLEXITY_SIGNALS };
