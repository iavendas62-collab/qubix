# Guia de Produção - Qubix com Supabase

## 1. Configurar Banco de Dados Supabase

### Passo 1: Configurar Connection String

Você já tem a connection string do Supabase:
```
postgresql://postgres:[YOUR_PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres
```

### Passo 2: Criar arquivo .env no backend

```bash
cd backend
cp .env.example .env
```

Edite o arquivo `.env`:

```env
# Database
DATABASE_URL="postgresql://postgres:[YOUR_PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres?pgbouncer=true"
DIRECT_URL="postgresql://postgres:[YOUR_PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres"

# JWT
JWT_SECRET="seu-secret-aqui-gere-com-openssl-rand-base64-64"

# Qubic (para produção)
QUBIC_NETWORK=mainnet
QUBIC_RPC_URL=https://rpc.qubic.org

# Application
NODE_ENV=production
PORT=3005
```

### Passo 3: Executar Migrations

```bash
cd backend

# Instalar dependências
npm install

# Gerar Prisma Client
npx prisma generate

# Executar migrations
npx prisma migrate deploy

# (Opcional) Popular com dados de exemplo
npx prisma db seed
```

### Passo 4: Verificar Tabelas

```bash
# Ver tabelas criadas
npx prisma studio
```

Ou acesse o Supabase Dashboard → Table Editor

## 2. Arquitetura de Produção

```
┌─────────────────┐
│   Cloudflare    │  ← CDN + DDoS Protection
│   (opcional)    │
└────────┬────────┘
         │
┌────────▼────────┐
│   NGINX/Caddy   │  ← Reverse Proxy + SSL
│   Load Balancer │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
┌───▼──┐  ┌──▼───┐
│ App  │  │ App  │  ← Backend Node.js (múltiplas instâncias)
│ #1   │  │ #2   │
└───┬──┘  └──┬───┘
    │        │
    └────┬───┘
         │
┌────────▼────────┐
│   Supabase      │  ← PostgreSQL + Auth + Storage
│   PostgreSQL    │
└─────────────────┘
         │
┌────────▼────────┐
│   Redis Cloud   │  ← Cache + Sessions (opcional)
└─────────────────┘
```

## 3. Opções de Deploy

### Opção A: Railway (Mais Fácil)

1. **Conectar GitHub**
   - Push seu código para GitHub
   - Conecte Railway ao repositório

2. **Configurar Variáveis**
   ```
   DATABASE_URL=postgresql://postgres:[PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres
   JWT_SECRET=seu-secret
   NODE_ENV=production
   ```

3. **Deploy Automático**
   - Railway detecta Node.js
   - Faz build e deploy automaticamente

**Custo:** ~$5-20/mês

### Opção B: Vercel (Frontend) + Railway (Backend)

**Frontend (Vercel):**
```bash
cd frontend
vercel --prod
```

**Backend (Railway):**
- Mesmo processo acima

**Custo:** Frontend grátis + Backend $5-20/mês

### Opção C: VPS (DigitalOcean/Hetzner)

**Mais controle, mais trabalho:**

```bash
# 1. Criar Droplet Ubuntu 22.04
# 2. Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# 3. Instalar PM2
sudo npm install -g pm2

# 4. Clonar repositório
git clone seu-repo
cd qubix

# 5. Setup Backend
cd backend
npm install
npx prisma generate
npx prisma migrate deploy

# 6. Iniciar com PM2
pm2 start npm --name "qubix-backend" -- start
pm2 save
pm2 startup

# 7. Setup Frontend
cd ../frontend
npm install
npm run build

# 8. Servir com NGINX
sudo apt install nginx
# Configurar nginx.conf (ver abaixo)
```

**Custo:** $5-10/mês (Hetzner) ou $12-24/mês (DigitalOcean)

### Opção D: Docker + VPS

```bash
# No servidor
git clone seu-repo
cd qubix

# Configurar .env
nano .env.production

# Build e iniciar
docker-compose -f docker-compose.prod.yml up -d

# Ver logs
docker-compose -f docker-compose.prod.yml logs -f
```

**Custo:** $5-10/mês

## 4. Configuração NGINX para Produção

```nginx
# /etc/nginx/sites-available/qubix
server {
    listen 80;
    server_name qubix.io www.qubix.io;
    
    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name qubix.io www.qubix.io;
    
    # SSL (Let's Encrypt)
    ssl_certificate /etc/letsencrypt/live/qubix.io/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/qubix.io/privkey.pem;
    
    # Frontend (static files)
    root /var/www/qubix/frontend/dist;
    index index.html;
    
    # Frontend routes
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Backend API
    location /api {
        proxy_pass http://localhost:3005;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
    
    # WebSocket
    location /ws {
        proxy_pass http://localhost:3005;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
    }
}
```

## 5. Escala Horizontal (Múltiplas Instâncias)

### Com Load Balancer

```nginx
# NGINX Load Balancer
upstream backend {
    least_conn;  # Algoritmo de balanceamento
    server 10.0.1.1:3005;
    server 10.0.1.2:3005;
    server 10.0.1.3:3005;
}

server {
    location /api {
        proxy_pass http://backend;
    }
}
```

### Com Redis para Sessions

```typescript
// backend/src/index.ts
import Redis from 'ioredis';
import session from 'express-session';
import RedisStore from 'connect-redis';

const redis = new Redis(process.env.REDIS_URL);

app.use(session({
  store: new RedisStore({ client: redis }),
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false
}));
```

## 6. Monitoramento

### Logs Centralizados

```bash
# PM2 Logs
pm2 logs qubix-backend

# Docker Logs
docker-compose logs -f --tail=100

# Sentry (Error Tracking)
npm install @sentry/node
```

### Métricas

```typescript
// backend/src/monitoring.ts
import * as Sentry from '@sentry/node';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV
});
```

### Health Checks

Já implementado em `/api/health`:
- Database connectivity
- Redis connectivity
- System metrics

## 7. Backup Automático

### Supabase Backups

Supabase faz backup automático, mas você pode fazer backups manuais:

```bash
# Backup manual
pg_dump "postgresql://postgres:[PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres" > backup.sql

# Restore
psql "postgresql://postgres:[PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres" < backup.sql
```

### Backup Automático com Cron

```bash
# Adicionar ao crontab
0 2 * * * /usr/local/bin/backup-qubix.sh
```

```bash
#!/bin/bash
# backup-qubix.sh
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump "$DATABASE_URL" | gzip > /backups/qubix_$DATE.sql.gz

# Manter apenas últimos 7 dias
find /backups -name "qubix_*.sql.gz" -mtime +7 -delete
```

## 8. Segurança

### Checklist de Segurança

- [ ] SSL/TLS habilitado (Let's Encrypt)
- [ ] Firewall configurado (UFW/iptables)
- [ ] Rate limiting no NGINX
- [ ] Variáveis de ambiente seguras
- [ ] Senhas fortes (min 32 caracteres)
- [ ] JWT secret aleatório
- [ ] CORS configurado corretamente
- [ ] SQL injection protection (Prisma já protege)
- [ ] XSS protection (headers de segurança)
- [ ] Backups automáticos
- [ ] Monitoramento de erros (Sentry)
- [ ] Logs de auditoria

### Headers de Segurança

```typescript
// backend/src/middleware/security.ts
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
}));
```

## 9. Performance

### Database Indexing

```sql
-- Já implementado no Prisma schema
-- Verificar índices:
SELECT * FROM pg_indexes WHERE tablename = 'Provider';
```

### Caching

```typescript
// Cache de queries frequentes
import NodeCache from 'node-cache';
const cache = new NodeCache({ stdTTL: 600 }); // 10 min

app.get('/api/providers', async (req, res) => {
  const cached = cache.get('providers');
  if (cached) return res.json(cached);
  
  const providers = await prisma.provider.findMany();
  cache.set('providers', providers);
  res.json(providers);
});
```

### CDN para Assets

- Cloudflare (grátis)
- AWS CloudFront
- Vercel Edge Network (automático)

## 10. Custos Estimados

### Setup Mínimo (Hobby)
- Supabase: Grátis (até 500MB)
- Railway: $5/mês
- Domínio: $12/ano
- **Total: ~$5-10/mês**

### Setup Médio (Startup)
- Supabase Pro: $25/mês
- Railway/Render: $20/mês
- Redis Cloud: $10/mês
- Cloudflare: Grátis
- **Total: ~$55/mês**

### Setup Grande (Escala)
- Supabase Pro: $25/mês
- VPS (4GB RAM): $20/mês × 3 = $60/mês
- Redis Cloud: $30/mês
- Load Balancer: $10/mês
- Cloudflare Pro: $20/mês
- **Total: ~$145/mês**

## 11. Próximos Passos

1. **Agora (MVP):**
   - Configurar Supabase
   - Deploy no Railway/Vercel
   - Testar com usuários reais

2. **Curto Prazo (1-3 meses):**
   - Adicionar Redis para cache
   - Implementar rate limiting
   - Configurar monitoramento

3. **Médio Prazo (3-6 meses):**
   - Escalar horizontalmente
   - Adicionar CDN
   - Otimizar queries

4. **Longo Prazo (6+ meses):**
   - Kubernetes (se necessário)
   - Multi-região
   - Auto-scaling

## Comandos Rápidos

```bash
# Desenvolvimento
npm run dev

# Produção (local)
npm run build
npm start

# Deploy Railway
railway up

# Deploy Vercel
vercel --prod

# Migrations
npx prisma migrate deploy

# Ver banco
npx prisma studio
```
