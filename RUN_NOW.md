# 🚀 RUN QUBIX NOW - Quick Start

## ⚡ Fastest Way to Run (5 minutes)

### Option 1: Docker Compose (Recommended)

```bash
# 1. Start everything
docker-compose up -d

# 2. Wait 30 seconds for services to start

# 3. Open browser
open http://localhost:3000
```

**That's it!** ✅

---

### Option 2: Manual Setup (If Docker doesn't work)

```bash
# Terminal 1: Start PostgreSQL & Redis
docker-compose up -d postgres redis

# Terminal 2: Backend
cd backend
npm install
npm run migrate
npm run seed
npm run dev

# Terminal 3: Frontend
cd frontend
npm install
npm start

# Terminal 4: Open browser
open http://localhost:3000
```

---

## 🧪 Test the Demo

### 1. View Dashboard
- Go to `http://localhost:3000`
- See network statistics
- View active jobs and providers

### 2. Submit a Job
- Click "Submit Job"
- Fill form:
  - Model: GPT-2
  - Dataset: `https://example.com/data.csv`
  - Compute: 10 TFLOPS
  - Budget: 50 QUBIC
- Click "Submit Job"
- See job in "My Jobs"

### 3. Register as Provider
- Click "Provider"
- Fill form:
  - Address: `QUBIC_TEST_ADDRESS`
  - Compute Power: 100 TFLOPS
  - Price: 5 QUBIC/hour
- Click "Register"

### 4. Browse Models
- Click "Model Hub"
- See available AI models
- Click "Download" on any model

---

## 📊 What You'll See

### Dashboard
- **Total Jobs**: 4 (from seed data)
- **Active Providers**: 2
- **AI Models**: 3
- **Network Compute**: Available

### Sample Jobs (from seed data)
1. ✅ **Completed**: GPT-2 training (2 days ago)
2. 🔄 **Running**: BERT training (1 hour ago)
3. ⏳ **Pending**: Stable Diffusion (10 min ago)
4. ❌ **Failed**: LLaMA training (1 day ago)

### Sample Providers
1. **Provider 1**: 100 TFLOPS, $5/hour, 95% reputation
2. **Provider 2**: 200 TFLOPS, $8/hour, 88% reputation
3. **Provider 3**: 50 TFLOPS, $3/hour, 92% reputation (offline)

### Sample Models
1. **Fine-tuned GPT-2 for Code** - 245 downloads
2. **BERT Sentiment Analyzer** - 189 downloads
3. **Stable Diffusion Art Generator** - 512 downloads

---

## 🔧 Troubleshooting

### Port Already in Use
```bash
# Kill processes on ports
lsof -ti:3000 | xargs kill -9  # Frontend
lsof -ti:3001 | xargs kill -9  # Backend
lsof -ti:5432 | xargs kill -9  # PostgreSQL
lsof -ti:6379 | xargs kill -9  # Redis
```

### Database Connection Error
```bash
# Reset database
cd backend
npx prisma migrate reset
npm run seed
```

### Frontend Won't Start
```bash
cd frontend
rm -rf node_modules
npm install
npm start
```

### Backend Won't Start
```bash
cd backend
rm -rf node_modules
npm install
npx prisma generate
npm run dev
```

---

## 🎬 For Demo Day

### Before Presenting:
```bash
# 1. Start services
./run-demo.sh

# 2. Verify everything works
curl http://localhost:3001/health
# Should return: {"status":"ok"}

# 3. Open browser
open http://localhost:3000

# 4. Test job submission
# (manually test in browser)
```

### During Presentation:
1. Show dashboard (30 sec)
2. Submit job (60 sec)
3. Show provider setup (60 sec)
4. Explain architecture (60 sec)
5. Show business model (30 sec)
6. Q&A (90 sec)

---

## 📱 URLs

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:3001
- **API Health**: http://localhost:3001/health
- **API Stats**: http://localhost:3001/api/stats
- **API Jobs**: http://localhost:3001/api/jobs
- **API Providers**: http://localhost:3001/api/providers
- **API Models**: http://localhost:3001/api/models

---

## 🧪 API Testing

### Get Stats
```bash
curl http://localhost:3001/api/stats
```

### Submit Job
```bash
curl -X POST http://localhost:3001/api/jobs/submit \
  -H "Content-Type: application/json" \
  -H "x-user-id: test_user" \
  -d '{
    "modelType": "gpt2",
    "dataset": "https://example.com/data.csv",
    "computeNeeded": 10,
    "budget": 50
  }'
```

### List Jobs
```bash
curl http://localhost:3001/api/jobs/user/test_user
```

### Register Provider
```bash
curl -X POST http://localhost:3001/api/providers/register \
  -H "Content-Type: application/json" \
  -d '{
    "address": "QUBIC_TEST_PROVIDER",
    "computePower": 100,
    "pricePerHour": 5
  }'
```

### List Providers
```bash
curl http://localhost:3001/api/providers
```

### List Models
```bash
curl http://localhost:3001/api/models
```

---

## ✅ Success Checklist

- [ ] Services running (check `docker ps`)
- [ ] Frontend loads at http://localhost:3000
- [ ] Backend responds at http://localhost:3001/health
- [ ] Dashboard shows statistics
- [ ] Can submit job
- [ ] Can register provider
- [ ] Can browse models
- [ ] No console errors

---

## 🎯 Next Steps

1. ✅ Run the system
2. ✅ Test all features
3. ⏳ Record demo video
4. ⏳ Create pitch deck
5. ⏳ Practice presentation
6. ⏳ Deploy to production

---

**You're ready to demo! 🚀**
