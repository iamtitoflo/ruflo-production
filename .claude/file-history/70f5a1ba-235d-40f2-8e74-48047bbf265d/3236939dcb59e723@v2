---
name: Proyecto techbyflo
description: Estado actual del proyecto web techbyflo — stack, oferta, arquitectura y configuración
type: project
---

Repositorio: `iamtitoflo/techbyflo` (privado en GitHub)
Clonado en: `C:/Users/flori/src/techbyflo`
Desplegado en: Vercel (dominio techbyflo.com)

## Stack técnico
- Frontend: React 19 + TypeScript + Vite + Tailwind CSS v4 + shadcn/ui + Wouter
- Backend: Express (stub) + Vercel serverless functions en `api/`
- Base de datos: Neon PostgreSQL (Drizzle ORM configurado)
- Email: Resend API (quiz email gate + leads)
- Deploy: Vercel con auto-deploy desde main

## Oferta de negocio (actualizada)
- Auditoría Digital Gratis 20-30min (Zoom/Loom) → lead magnet
- Blindaje Básico: 97€ one-time (setup completo)
- Guardia Digital: 19€/mes (protección continua)
- Target: autónomos españoles

## Estructura de páginas
- `/` → home.tsx (landing de conversión con copy INCIBE 2025)
- `/quiz` → quiz.tsx (15 preguntas, email gate, score, upsell)
- `/trabaja-conmigo` → work-with-me.tsx
- `/sobre-mi` → about.tsx
- `/contacto` → contact.tsx
- `/recursos` → resources.tsx
- `/estafas` → scams.tsx (feed RSS INCIBE)
- `/guardia-digital` → guard.tsx
- `/gracias` → gracias.tsx
- `/admin` → admin.tsx (panel de administración protegido)
- `*` → not-found.tsx

## API endpoints (Vercel serverless)
- `POST /api/admin/login` — auth con contraseña, emite cookie HttpOnly firmada HMAC
- `POST /api/admin/logout` — limpia cookie
- `GET/POST /api/admin/maintenance` — toggle modo mantenimiento (requiere auth)
- `GET /api/admin/leads` — lista de quiz leads + stats (requiere auth)
- `GET /api/admin/health` — health check de todos los servicios (requiere auth)
- `GET/POST /api/admin/config` — configuración de banner del sitio (requiere auth)
- `GET /api/status` — estado mantenimiento (público)
- `GET /api/banner` — estado del banner (público)
- `POST /api/subscribe` — captura email del quiz, envía email via Resend, guarda lead en DB

## Base de datos (Neon PostgreSQL)
Tablas usadas:
- `site_config` (key TEXT PK, value TEXT) — mantenimiento, banner
- `leads` (id, email, score, category, created_at) — quiz submissions
- `users` (uuid, username, password) — esquema Drizzle, no activo aún

## Panel de administración (`/admin`)
Acceso: contraseña → cookie HttpOnly HMAC-SHA256, 24h expiración
Tabs:
1. **Inicio** — stats: total leads, últimos 7/30 días, score promedio
2. **Leads** — tabla CRM con email, score, categoría, fecha
3. **Salud** — health check de DB, Resend, env vars
4. **Configuración** — banner editable (texto, tipo info/warning/success, toggle)

## Variables de entorno requeridas en Vercel
- `DATABASE_URL` — Neon connection string
- `ADMIN_PASSWORD` — contraseña del panel admin
- `ADMIN_JWT_SECRET` — secret HMAC para cookies de admin
- `RESEND_API_KEY` — para envío de emails del quiz
- `RESEND_AUDIENCE_ID` — para guardar contactos en Resend
- `VITE_CALENDLY_URL` — link de Calendly para CTAs de auditoría

## Seguridad implementada
- Validación Zod en /api/subscribe (email + score 0-100)
- CORS header restringido a techbyflo.com
- Security headers en vercel.json (CSP, X-Frame-Options, etc.)
- Admin: cookie HttpOnly + timingSafeEqual + token con expiración
- allowedHosts:true eliminado de vite.config
- Contraseñas nunca en código, siempre process.env

## Commits relevantes (rama main)
- `6df8178` — Panel admin expandido (leads, health, banner, stats)
- `a5d4c80` — Usar Neon en vez de Vercel KV
- `a00a134` — Panel admin inicial + routing
- `7dbaf9d` — Nueva landing + fixes de seguridad críticos

**Why:** Proyecto personal de negocio de privacidad digital para autónomos españoles. Flo trabaja full-time en Holanda.
**How to apply:** Al trabajar en este proyecto, tener en cuenta la oferta actual, el stack y las variables de entorno requeridas.
