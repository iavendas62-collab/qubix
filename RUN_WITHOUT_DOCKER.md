# 🚀 Run QUBIX Without Docker

## Prerequisites
- ✅ Node.js 20+ (you have v22.20.0)
- ✅ npm (you have 10.9.3)
- ❌ Docker (not required for basic demo)

## Quick Start (No Database Required)

### Option 1: Frontend Only (Fastest)

```powershell
# Terminal 1: Start Frontend
cd frontend
npm start
```

Then open: http://localhost:3000

**Note:** Backend API calls will fail, but you can see the UI.

---

### Option 2: Frontend + Mock Backend

We'll create a simple mock server for demo purposes.

#### Step 1: Create Mock Server

Create `backend/mock-server.js`:

```javascript
const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Mock data
const mockStats = {
  jobs: { total: 1234, active: 45 },
  providers: { total: 156, active: 89 },
  models: { total: 342 },
  network: {
    totalComputors: 676,
    availableCompute: 4500,
    averagePrice: 5.5
  }
};

const mockJobs = [
  {
    id: '1',
    userId: 'demo_user',
    modelType: 'gpt2',
    status: 'COMPLETED',
    computeNeeded: 10,
    budget: 50,
    createdAt: new Date(Date.now() - 86400000 * 2).toISOString(),
    provider: { id: '1', address: 'QUBIC_PROVIDER_1' }
  },
  {
    id: '2',
    userId: 'demo_user',
    modelType: 'bert',
    status: 'RUNNING',
    computeNeeded: 20,
    budget: 100,
    createdAt: new Date(Date.now() - 3600000).toISOString(),
    provider: { id: '2', address: 'QUBIC_PROVIDER_2' }
  },
  {
    id: '3',
    userId: 'demo_user',
    modelType: 'stable-diffusion',
    status: 'PENDING',
    computeNeeded: 30,
    budget: 150,
    createdAt: new Date(Date.now() - 600000).toISOString()
  }
];

const mockProviders = [
  {
    id: '1',
    address: 'QUBIC_PROVIDER_1_ABC123',
    computePower: 100,
    pricePerHour: 5.0,
    reputation: 0.95,
    totalJobs: 150,
    isActive: true
  },
  {
    id: '2',
    address: 'QUBIC_PROVIDER_2_DEF456',
    computePower: 200,
    pricePerHour: 8.0,
    reputation: 0.88,
    totalJobs: 89,
    isActive: true
  }
];

const mockModels = [
  {
    id: '1',
    name: 'Fine-tuned GPT-2 for Code',
    description: 'GPT-2 model fine-tuned on programming code',
    modelType: 'gpt2',
    price: 25,
    downloads: 245,
    owner: 'demo_user_1'
  },
  {
    id: '2',
    name: 'BERT Sentiment Analyzer',
    description: 'BERT model for sentiment analysis',
    modelType: 'bert',
    price: 30,
    downloads: 189,
    owner: 'demo_user_2'
  }
];

// Routes
app.get('/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.get('/api/stats', (req, res) => {
  res.json(mockStats);
});

app.get('/api/jobs/user/:userId', (req, res) => {
  res.json(mockJobs);
});

app.post('/api/jobs/submit', (req, res) => {
  const newJob = {
    id: Date.now().toString(),
    userId: req.headers['x-user-id'] || 'anonymous',
    ...req.body,
    status: 'PENDING',
    createdAt: new Date().toISOString()
  };
  mockJobs.push(newJob);
  res.json({ success: true, jobId: newJob.id });
});

app.get('/api/providers', (req, res) => {
  res.json(mockProviders);
});

app.post('/api/providers/register', (req, res) => {
  const newProvider = {
    id: Date.now().toString(),
    ...req.body,
    reputation: 0,
    totalJobs: 0,
    isActive: true
  };
  mockProviders.push(newProvider);
  res.json({ success: true, provider: newProvider });
});

app.get('/api/models', (req, res) => {
  res.json(mockModels);
});

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`
╔═══════════════════════════════════════╗
║   🎯 QUBIX MOCK SERVER                ║
║   Port: ${PORT}                         ║
║   Status: Running ✅                  ║
╚═══════════════════════════════════════╝

📊 Mock Data Available:
   - Jobs: ${mockJobs.length}
   - Providers: ${mockProviders.length}
   - Models: ${mockModels.length}

🌐 Endpoints:
   - GET  /health
   - GET  /api/stats
   - GET  /api/jobs/user/:userId
   - POST /api/jobs/submit
   - GET  /api/providers
   - POST /api/providers/register
   - GET  /api/models

Frontend: http://localhost:3000
Backend:  http://localhost:3001
  `);
});
```

#### Step 2: Run Mock Server

```powershell
# Terminal 1: Mock Backend
cd backend
node mock-server.js

# Terminal 2: Frontend
cd frontend
npm start
```

#### Step 3: Open Browser

Open http://localhost:3000

---

## What You'll See

### ✅ Working Features (with mock server):
- Dashboard with statistics
- Job submission form
- Job list with mock data
- Provider registration
- Model hub browser

### ⚠️ Limited Features (without real database):
- Data doesn't persist (resets on server restart)
- No real-time WebSocket updates
- No actual job execution
- No Qubic blockchain integration

---

## For Full Demo (Recommended)

Install Docker Desktop:
1. Download: https://www.docker.com/products/docker-desktop
2. Install and restart computer
3. Run: `docker-compose up -d`
4. Run: `cd backend && npm run migrate && npm run seed`
5. Run: `./run-demo.sh`

---

## Troubleshooting

### Port 3000 already in use
```powershell
# Find and kill process
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### Port 3001 already in use
```powershell
# Find and kill process
netstat -ano | findstr :3001
taskkill /PID <PID> /F
```

### npm install fails
```powershell
# Clear cache and retry
npm cache clean --force
npm install
```

---

## Quick Demo Script

1. **Start servers** (2 terminals)
2. **Open browser**: http://localhost:3000
3. **Show dashboard**: Point out statistics
4. **Submit job**: Fill form and submit
5. **View jobs**: See job in list
6. **Register provider**: Fill provider form
7. **Browse models**: Show model hub

---

**You're ready to demo! 🚀**
