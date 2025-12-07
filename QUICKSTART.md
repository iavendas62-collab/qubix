# Qubix Compute Hub - Quick Start Guide

## Prerequisites

- Node.js 20+
- Docker & Docker Compose
- Python 3.8+ (for SDK)
- PostgreSQL 15+
- Redis 7+

## Installation

### 1. Clone Repository
```bash
git clone https://github.com/qubix/compute-hub.git
cd compute-hub
```

### 2. Setup Environment
```bash
# Backend
cd backend
cp .env.example .env
# Edit .env with your configuration
```

### 3. Start Services with Docker
```bash
# From root directory
docker-compose up -d
```

This starts:
- PostgreSQL (port 5432)
- Redis (port 6379)
- Backend API (port 3001)
- Frontend (port 3000)

### 4. Run Database Migrations
```bash
cd backend
npm run migrate
```

### 5. Access Application
- Frontend: http://localhost:3000
- Backend API: http://localhost:3001
- API Docs: http://localhost:3001/api

---

## Manual Setup (Without Docker)

### Backend
```bash
cd backend
npm install
npm run migrate
npm run dev
```

### Frontend
```bash
cd frontend
npm install
npm start
```

### Database
```bash
# Start PostgreSQL
psql -U postgres -c "CREATE DATABASE qubix;"

# Start Redis
redis-server
```

---

## Using the CLI

### Install CLI
```bash
cd cli
npm install
npm link
```

### Submit a Job
```bash
qubix compute submit \
  --model gpt2 \
  --dataset https://example.com/data.csv \
  --compute 10 \
  --budget 100
```

### Check Job Status
```bash
qubix status <job_id>
```

### List Models
```bash
qubix models
```

---

## Using the Python SDK

### Install SDK
```bash
cd sdk
pip install -e .
```

### Example Usage
```python
from qubix import QubixClient

# Initialize client
client = QubixClient(api_url="http://localhost:3001")

# Submit job
job = client.submit_job(
    model_type="gpt2",
    dataset="https://example.com/data.csv",
    compute_needed=10,
    budget=100
)

print(f"Job ID: {job.job_id}")

# Check status
status = job.get_status()
print(f"Status: {status['status']}")
```

---

## Testing

### Backend Tests
```bash
cd backend
npm test
```

### Frontend Tests
```bash
cd frontend
npm test
```

### Integration Tests
```bash
npm run test:integration
```

---

## Common Tasks

### Register as Provider
1. Go to http://localhost:3000/provider
2. Enter your Qubic address
3. Set compute power and price
4. Click "Register as Provider"

### Submit Compute Job
1. Go to http://localhost:3000/jobs/submit
2. Select model type
3. Enter dataset URL
4. Set compute requirements and budget
5. Click "Submit Job"

### Browse Models
1. Go to http://localhost:3000/models
2. Browse available models
3. Click "Download" to get model

---

## Troubleshooting

### Backend won't start
- Check PostgreSQL is running: `psql -U postgres -l`
- Check Redis is running: `redis-cli ping`
- Verify .env configuration

### Frontend can't connect to backend
- Ensure backend is running on port 3001
- Check CORS settings in backend
- Verify proxy configuration in vite.config.ts

### Database migration errors
- Drop and recreate database: `npm run migrate:reset`
- Check Prisma schema syntax
- Verify DATABASE_URL in .env

### Qubic node connection fails
- Check QUBIC_RPC_HOST and QUBIC_RPC_PORT
- Verify Qubic node is running
- Use mock mode for development (set MOCK_QUBIC=true)

---

## Development Workflow

### 1. Create Feature Branch
```bash
git checkout -b feature/my-feature
```

### 2. Make Changes
- Edit code
- Add tests
- Update documentation

### 3. Test Locally
```bash
npm test
npm run build
```

### 4. Commit & Push
```bash
git add .
git commit -m "feat: add my feature"
git push origin feature/my-feature
```

### 5. Create Pull Request
- Open PR on GitHub
- Wait for CI/CD checks
- Request review

---

## Production Deployment

### Build for Production
```bash
# Backend
cd backend
npm run build

# Frontend
cd frontend
npm run build
```

### Deploy with Docker
```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Environment Variables
Set these in production:
- `NODE_ENV=production`
- `DATABASE_URL=<production_db>`
- `REDIS_URL=<production_redis>`
- `QUBIC_RPC_HOST=<mainnet_node>`
- `JWT_SECRET=<secure_secret>`

---

## Next Steps

1. Read [Architecture Documentation](docs/ARCHITECTURE.md)
2. Check [API Documentation](docs/API.md)
3. Review [Hackathon Plan](docs/HACKATHON_PLAN.md)
4. Join our Discord: https://discord.gg/qubix
5. Follow on Twitter: @QubixCompute

---

## Support

- GitHub Issues: https://github.com/qubix/compute-hub/issues
- Discord: https://discord.gg/qubix
- Email: support@qubix.io
- Documentation: https://docs.qubix.io
