# 🔗 Rotas do Backend - Status e Conexão

## ✅ ROTAS QUE FUNCIONAM

### Providers (GPU/Hardware)
- ✅ `POST /api/providers/quick-register` - Registrar GPU
- ✅ `GET /api/providers` - Listar todas GPUs
- ✅ `GET /api/providers/:id` - Detalhes de uma GPU
- ✅ `GET /api/providers/my` - Minhas GPUs (provider)
- ✅ `DELETE /api/providers/:id` - Deletar GPU
- ✅ `POST /api/providers/:workerId/heartbeat` - Heartbeat do worker

### Jobs
- ✅ `POST /api/jobs/create` - Criar job
- ✅ `GET /api/jobs/:jobId` - Detalhes do job
- ✅ `GET /api/jobs/:jobId/monitor` - Monitorar job
- ✅ `POST /api/jobs/:jobId/progress` - Atualizar progresso
- ✅ `POST /api/jobs/:jobId/complete` - Completar job

### Qubic/Wallet
- ✅ `POST /api/qubic/wallet/connect` - Conectar wallet
- ✅ `GET /api/qubic/balance/:address` - Ver saldo
- ✅ `POST /api/qubic/escrow/lock` - Criar escrow
- ✅ `POST /api/qubic/escrow/release` - Liberar pagamento

### Health
- ✅ `GET /api/health` - Status do backend

## ❌ ROTAS QUE FALTAM CONECTAR NO FRONTEND

### 1. Rent GPU (Alugar)
**Problema:** Botão "Rent" não faz nada
**Solução:** Criar rota `/api/rentals/create`

### 2. Provider Dashboard
**Problema:** Painel do provider vazio
**Solução:** Usar rota existente `/api/providers/my`

### 3. My Hardware
**Problema:** Lista vazia, delete não funciona
**Solução:** Conectar com `/api/providers/my` e `/api/providers/:id`

### 4. Auto Detect
**Problema:** Não detecta nada
**Solução:** Criar endpoint `/api/hardware/detect` que chama Python

## 🔧 CORREÇÕES NECESSÁRIAS

### Correção 1: Criar endpoint de detecção
```typescript
// backend/src/routes/hardware.ts
router.post('/detect', async (req, res) => {
  // Executa register-my-gpu.py
  // Retorna hardware detectado
});
```

### Correção 2: Conectar botão Rent
```typescript
// frontend: onClick do botão Rent
navigate(`/app/rent/${gpuId}`);
// Página RentGPU deve carregar dados da GPU
```

### Correção 3: Provider Dashboard
```typescript
// frontend: useEffect no ProviderDashboard
fetch('/api/providers/my?qubicAddress=...')
// Mostrar lista de GPUs do provider
```

### Correção 4: Delete Hardware
```typescript
// frontend: onClick do botão Delete
await fetch(`/api/providers/${id}`, { method: 'DELETE' })
// Atualizar lista
```
