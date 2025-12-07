# ⚡ QUBIX - Quick Start

## 🚀 Start em 30 segundos

### 1. Backend
```bash
cd backend
node mock-server.js
```
✅ Backend rodando em http://localhost:3001

### 2. Frontend
```bash
cd frontend
npm start
```
✅ Frontend rodando em http://localhost:3000

### 3. Abrir Browser
```
http://localhost:3000
```

---

## 🎯 O que testar

### ✅ FASE 1 - Tudo Funcional

1. **Dashboard**
   - Stats em tempo real
   - Job activity chart
   - Recent jobs da API

2. **GPU Marketplace**
   - 22 GPUs disponíveis
   - Filtros: price, model, location, status
   - Sorting: price, rating, VRAM
   - Refresh button

3. **Launch Instance**
   - 3-step wizard
   - 4 environments (Jupyter, SSH, VSCode, API)
   - Duration slider (1-24h)
   - Redundancy toggle
   - Cost estimator
   - Connection details

4. **My Instances**
   - Real-time monitoring
   - GPU usage graphs
   - Temperature & memory
   - Logs streaming
   - Connect & Stop buttons

5. **Wallet**
   - Connect MetaMask (ou mock)
   - Show balance & address
   - Disconnect option

---

## 📁 Arquivos Importantes

- `FASE_1_COMPLETA.md` - O que foi implementado
- `DEMO_SCRIPT.md` - Roteiro de demonstração
- `MASTER_PLAN.md` - Business plan completo
- `IMPLEMENTATION_CHECKLIST.md` - Progresso

---

## 🔧 Comandos Úteis

### Verificar se está rodando
```bash
# Backend
curl http://localhost:3001/health

# Frontend
curl http://localhost:3000
```

### Parar processos
```bash
# Windows
Ctrl + C no terminal

# Ou matar processos
taskkill /F /IM node.exe
```

### Reinstalar dependências
```bash
# Backend
cd backend
npm install

# Frontend
cd frontend
npm install
```

---

## 🐛 Troubleshooting

### Porta 3001 em uso
```bash
# Windows
netstat -ano | findstr :3001
taskkill /PID <PID> /F
```

### Porta 3000 em uso
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### Erro de CORS
- Confirme backend rodando
- Verifique console do browser (F12)

### GPUs não carregam
- Teste API: http://localhost:3001/api/gpus
- Verifique network tab no browser

---

## 📊 API Endpoints

```
GET  /health                      - Health check
GET  /api/stats                   - Network stats
GET  /api/gpus                    - List GPUs
GET  /api/gpus?model=RTX%204090   - Filter by model
GET  /api/gpus?priceRange=0-10    - Filter by price
GET  /api/jobs/user/:userId       - User jobs
POST /api/jobs/submit             - Submit job
GET  /api/providers               - List providers
GET  /api/models                  - List models
```

---

## 🎨 Tech Stack

- **Frontend**: React 18 + TypeScript + TailwindCSS
- **Backend**: Express + Node.js
- **Icons**: Lucide React
- **Styling**: AWS-inspired design system

---

## ✅ Status

- ✅ Backend: Running
- ✅ Frontend: Running
- ✅ API: 22 GPUs available
- ✅ TypeScript: 0 errors
- ✅ Demo: Ready

---

**Pronto para demo! 🚀**
