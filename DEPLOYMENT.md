# QUBIX Production Deployment Guide

This guide covers deploying QUBIX to a production environment with PostgreSQL, WebSocket support, SSL certificates, and security configurations.

## Prerequisites

- Docker 20.10+ and Docker Compose v2
- A domain name (e.g., qubix.io)
- SSL certificates (Let's Encrypt recommended)
- A server with at least 2GB RAM and 20GB storage

## Quick Start

### 1. Clone and Configure

```bash
# Clone the repository
git clone https://github.com/your-org/qubix.git
cd qubix

# Copy environment template
cp .env.production.example .env.production

# Edit with your values
nano .env.production
```

### 2. Configure Environment Variables

Edit `.env.production` with secure values:

```bash
# Database - USE STRONG PASSWORDS!
POSTGRES_PASSWORD=your_secure_password_here_min_32_chars
REDIS_PASSWORD=your_secure_redis_password_here

# Security - Generate with: openssl rand -base64 64
JWT_SECRET=your_generated_jwt_secret_here

# Qubic Blockchain
QUBIC_NETWORK=mainnet
QUBIC_PLATFORM_SEED=your_55_char_seed
QUBIC_PLATFORM_ADDRESS=your_55_char_address

# Your domain
FRONTEND_URL=https://your-domain.com
VITE_WS_URL=wss://your-domain.com/ws
```

### 3. Setup SSL Certificates

#### Option A: Let's Encrypt (Recommended)

```bash
# Install certbot
sudo apt install certbot

# Generate certificates
sudo certbot certonly --standalone -d your-domain.com -d www.your-domain.com

# Copy to project
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem ./ssl/
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem ./ssl/
sudo chown $USER:$USER ./ssl/*.pem
```

#### Option B: Self-Signed (Testing Only)

```bash
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ssl/privkey.pem \
    -out ssl/fullchain.pem \
    -subj "/CN=localhost"
```

### 4. Deploy

```bash
# Linux/macOS
chmod +x scripts/deploy.sh
./scripts/deploy.sh

# Windows
scripts\deploy.bat
```

## Manual Deployment Steps

### Build Images

```bash
docker compose -f docker-compose.prod.yml build --no-cache
```

### Start Services

```bash
docker compose -f docker-compose.prod.yml --env-file .env.production up -d
```

### Run Migrations

```bash
docker compose -f docker-compose.prod.yml exec backend npx prisma migrate deploy
```

### Verify Deployment

```bash
# Check container status
docker ps --filter "name=qubix"

# Check backend health
curl https://your-domain.com/api/health

# View logs
docker compose -f docker-compose.prod.yml logs -f
```

## Architecture

```
                    ┌─────────────────┐
                    │   Internet      │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  Nginx (443)    │
                    │  SSL Termination│
                    │  Security Headers│
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
     ┌────────▼────┐  ┌──────▼──────┐  ┌───▼───┐
     │  Frontend   │  │  Backend    │  │  WS   │
     │  (Static)   │  │  API (:3001)│  │ Server│
     └─────────────┘  └──────┬──────┘  └───────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
     ┌────────▼────┐  ┌──────▼──────┐
     │  PostgreSQL │  │    Redis    │
     │   (:5432)   │  │   (:6379)   │
     └─────────────┘  └─────────────┘
```

## Security Configuration

### Security Headers (Nginx)

The production nginx config includes:

- `X-Frame-Options: SAMEORIGIN` - Prevents clickjacking
- `X-Content-Type-Options: nosniff` - Prevents MIME sniffing
- `X-XSS-Protection: 1; mode=block` - XSS protection
- `Strict-Transport-Security` - Forces HTTPS
- `Content-Security-Policy` - Controls resource loading
- `Referrer-Policy` - Controls referrer information

### CORS Configuration

CORS is configured in the backend to only allow requests from your frontend domain:

```typescript
// backend/src/index.ts
app.use(cors({
  origin: process.env.FRONTEND_URL,
  credentials: true
}));
```

### Rate Limiting

Nginx rate limiting is configured:
- API: 10 requests/second with burst of 20
- WebSocket: 5 connections/second with burst of 10

## Database Management

### Backup Database

```bash
docker compose -f docker-compose.prod.yml exec postgres \
    pg_dump -U qubix qubix > backup_$(date +%Y%m%d).sql
```

### Restore Database

```bash
docker compose -f docker-compose.prod.yml exec -T postgres \
    psql -U qubix qubix < backup_20241201.sql
```

### Access Database

```bash
docker compose -f docker-compose.prod.yml exec postgres \
    psql -U qubix qubix
```

## Monitoring

### View Logs

```bash
# All services
docker compose -f docker-compose.prod.yml logs -f

# Specific service
docker compose -f docker-compose.prod.yml logs -f backend
```

### Health Checks

```bash
# Backend health
curl https://your-domain.com/api/health

# Database health
docker compose -f docker-compose.prod.yml exec postgres pg_isready
```

### Container Stats

```bash
docker stats --filter "name=qubix"
```

## SSL Certificate Renewal

### Auto-renewal with Certbot

```bash
# Add to crontab
0 0 1 * * certbot renew --quiet && docker compose -f docker-compose.prod.yml restart frontend
```

## Scaling

### Horizontal Scaling

For high traffic, consider:

1. **Load Balancer**: Add nginx upstream with multiple backend instances
2. **Database Replication**: PostgreSQL read replicas
3. **Redis Cluster**: For session/cache distribution

### Vertical Scaling

Adjust container resources in `docker-compose.prod.yml`:

```yaml
backend:
  deploy:
    resources:
      limits:
        cpus: '2'
        memory: 2G
```

## Troubleshooting

### Container Won't Start

```bash
# Check logs
docker compose -f docker-compose.prod.yml logs backend

# Check environment
docker compose -f docker-compose.prod.yml config
```

### Database Connection Issues

```bash
# Test connection
docker compose -f docker-compose.prod.yml exec backend \
    npx prisma db pull
```

### WebSocket Not Connecting

1. Check nginx WebSocket proxy configuration
2. Verify SSL certificates are valid
3. Check firewall allows port 443

### SSL Certificate Issues

```bash
# Test certificate
openssl s_client -connect your-domain.com:443 -servername your-domain.com
```

## Rollback

```bash
# Stop current deployment
docker compose -f docker-compose.prod.yml down

# Restore previous images
docker compose -f docker-compose.prod.yml pull

# Start with previous version
docker compose -f docker-compose.prod.yml up -d
```

## Support

For issues, check:
1. Container logs: `docker compose logs`
2. Health endpoints: `/api/health`
3. Database connectivity
4. SSL certificate validity
