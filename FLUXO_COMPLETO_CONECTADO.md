# 🔗 Fluxo Completo - Tudo Conectado

## 🎯 Objetivo: Hardware Real → Marketplace → Cliente → Job → Execução

---

## 1️⃣ REGISTRAR HARDWARE REAL

### Opção A: Script Python (Recomendado)
```bash
python register-my-gpu.py
```

**O que faz:**
1. Detecta GPU via `nvidia-smi`
2. Detecta CPU e RAM via `psutil`
3. Chama `POST /api/providers/quick-register`
4. GPU aparece no marketplace

### Opção B: Auto-Detect no Frontend (Novo!)
```
http://localhost:3004/app/provider/register
```

Clique em "Auto Detect" → Chama `/api/hardware/detect` → Registra automaticamente

---

## 2️⃣ VER NO MARKETPLACE

```
http://localhost:3004/app/marketplace
```

**Rota:** `GET /api/providers` ou `GET /api/gpus`

**Retorna:**
```json
[
  {
    "id": "1764796305552",
    "model": "NVIDIA GeForce MX150",
    "vram": 4.0,
    "price": 0.5,
    "available": true,
    "provider": "real-gpu-20251203181145"
  }
]
```

---

## 3️⃣ ALUGAR GPU (Rent)

### Frontend:
```typescript
// Marketplace.tsx - Botão Rent
onClick={() => navigate(`/app/rent/${provider.id}`)}
```

### Página Rent:
```
http://localhost:3004/app/rent/1764796305552
```

**Carrega dados:**
```typescript
const response = await fetch(`/api/providers/${gpuId}`);
const gpu = await response.json();
```

**Mostra:**
- Specs da GPU
- Preço por hora
- Botão "Submit Job"

---

## 4️⃣ SUBMETER JOB

### Página:
```
http://localhost:3004/app/jobs/submit
```

### Wizard (4 steps):

**Step 1: Upload File**
- Upload Python script
- `POST /api/jobs/analyze` → Analisa requirements

**Step 2: Select GPU**
- Mostra GPUs compatíveis
- `POST /api/providers/match` → Matching inteligente

**Step 3: Config (opcional)**
- Env vars, Docker, etc.

**Step 4: Launch**
- Cria escrow: `POST /api/qubic/escrow/lock`
- Aguarda 3 confirmações
- Cria job: `POST /api/jobs/create`

---

## 5️⃣ WORKER EXECUTA

### Worker Python:
```python
# worker/qubix_worker_enhanced.py

while True:
    # 1. Poll for jobs
    jobs = requests.get(f'{BACKEND}/api/jobs/pending/{WORKER_ID}')
    
    # 2. Execute job
    result = execute_job(job)
    
    # 3. Report progress
    requests.post(f'{BACKEND}/api/jobs/{job_id}/progress', {
        'progress': 50,
        'metrics': gpu_metrics
    })
    
    # 4. Complete
    requests.post(f'{BACKEND}/api/jobs/{job_id}/complete', {
        'status': 'completed',
        'result': result
    })
```

---

## 6️⃣ MONITORAR JOB

### Página:
```
http://localhost:3004/app/jobs/{jobId}/monitor
```

**Rota:** `GET /api/jobs/{jobId}/monitor`

**WebSocket:** Recebe updates em tempo real
- Progress: 0% → 100%
- GPU metrics
- Logs

---

## 7️⃣ PROVIDER VÊ EARNINGS

### Página:
```
http://localhost:3004/app/provider/earnings
```

**Rota:** `GET /api/providers/my/earnings?qubicAddress=...`

**Mostra:**
- Total ganho
- Ganhos de hoje (atualiza a cada 5s)
- Jobs ativos
- Histórico de transações

---

## 8️⃣ MY HARDWARE (Provider)

### Página:
```
http://localhost:3004/app/provider/hardware
```

**Rota:** `GET /api/providers/my?qubicAddress=...`

**Mostra lista de GPUs do provider**

**Delete:**
```typescript
await fetch(`/api/providers/${id}`, { method: 'DELETE' });
```

---

## 🔗 MAPA DE ROTAS CONECTADAS

### Provider Flow:
```
register-my-gpu.py
    ↓
POST /api/providers/quick-register
    ↓
GET /api/providers (marketplace)
    ↓
GET /api/providers/:id (details)
    ↓
DELETE /api/providers/:id (remove)
```

### Consumer Flow:
```
GET /api/providers (browse)
    ↓
POST /api/jobs/analyze (upload file)
    ↓
POST /api/providers/match (find GPU)
    ↓
POST /api/qubic/escrow/lock (payment)
    ↓
POST /api/jobs/create (create job)
    ↓
GET /api/jobs/:id/monitor (watch)
```

### Worker Flow:
```
GET /api/jobs/pending/:workerId
    ↓
POST /api/jobs/:id/progress
    ↓
POST /api/jobs/:id/complete
    ↓
POST /api/qubic/escrow/release
```

---

## ✅ CHECKLIST DE CONEXÕES

- [x] Hardware detection → Backend
- [x] Backend → Database
- [x] Marketplace → API
- [ ] Rent button → Rent page
- [ ] Job submit → Escrow
- [ ] Escrow → Job creation
- [ ] Job → Worker
- [ ] Worker → Progress updates
- [ ] Progress → Monitor page
- [ ] Completion → Earnings
- [ ] Earnings → Provider dashboard

---

## 🐛 PROBLEMAS E SOLUÇÕES

### Problema 1: Rent não faz nada
**Causa:** Rota não conectada
**Solução:** Adicionar navigate no onClick

### Problema 2: Provider dashboard vazio
**Causa:** Não busca dados da API
**Solução:** Adicionar useEffect com fetch

### Problema 3: Delete não funciona
**Causa:** Endpoint existe mas frontend não chama
**Solução:** Adicionar onClick com DELETE request

### Problema 4: Auto-detect não funciona
**Causa:** Endpoint não existia
**Solução:** ✅ Criado `/api/hardware/detect`

---

## 🚀 PRÓXIMOS PASSOS

1. ✅ Hardware detectado e registrado
2. ✅ Aparece no marketplace
3. ➡️ **Conectar botão Rent**
4. ➡️ **Conectar Provider Dashboard**
5. ➡️ **Conectar My Hardware**
6. ➡️ **Testar fluxo completo**
7. ➡️ **Gravar vídeo**

---

**Agora temos TODAS as rotas criadas. Falta conectar o frontend!**
