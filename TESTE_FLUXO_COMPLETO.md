# 🧪 Teste do Fluxo Completo MVP - QUBIX

## ✅ Status: Servidores Rodando
- Frontend: http://localhost:3004/app/marketplace
- Backend: http://localhost:3004/api

---

## 📋 FLUXO DE TESTE

### 1️⃣ PROVIDER: IDENTIFICAR E REGISTRAR HARDWARE

**Objetivo:** Registrar uma GPU no marketplace

**Passos:**
1. Abra: http://localhost:3004/app/become-provider
2. Clique no botão **"Share My GPU"**
3. O sistema deve:
   - ✅ Detectar GPU via WebGPU/WebGL
   - ✅ Mostrar specs detectadas (GPU, CPU, RAM)
   - ✅ Registrar no backend
   - ✅ Mostrar status "Online"

**Resultado Esperado:**
```
✅ GPU detectada: [Nome da GPU]
✅ Registrado como Provider
✅ Status: Online
```

**Teste Manual:**
```bash
# Verificar se provider foi registrado
Invoke-WebRequest -Uri "http://localhost:3004/api/providers" -UseBasicParsing
```

---

### 2️⃣ MARKETPLACE: VER GPU DISPONÍVEL

**Objetivo:** Verificar se a GPU aparece no marketplace

**Passos:**
1. Abra: http://localhost:3004/app/marketplace
2. Verifique se sua GPU aparece na lista
3. Deve mostrar:
   - ✅ Nome da GPU
   - ✅ VRAM
   - ✅ Preço por hora
   - ✅ Status "Available" (verde)
   - ✅ Botão "Rent"

**Resultado Esperado:**
```
Lista de GPUs com:
- Sua GPU recém-registrada
- Status: Available
- Botão Rent ativo
```

---

### 3️⃣ CONSUMER: ALUGAR GPU

**Objetivo:** Selecionar uma GPU para alugar

**Passos:**
1. No marketplace, clique no botão **"Rent"** de uma GPU
2. Deve redirecionar para: `/app/rent/[gpu-id]`
3. Ou clique na GPU para ver detalhes

**Resultado Esperado:**
```
✅ Redirecionamento para página de aluguel
✅ Detalhes da GPU selecionada
```

---

### 4️⃣ CONSUMER: SUBMETER JOB

**Objetivo:** Criar e submeter um job de computação

**Passos:**
1. Abra: http://localhost:3004/app/jobs/submit
2. **Step 1: Upload & Analysis**
   - Arraste um arquivo Python (.py) ou use o sample
   - Sistema deve analisar e detectar tipo de job
   - Clique "Continue to GPU Selection"

3. **Step 2: GPU Selection**
   - Veja GPUs compatíveis
   - Selecione uma GPU
   - Clique "Continue to Configuration"

4. **Step 3: Advanced Config** (opcional)
   - Pode pular clicando "Skip this step"
   - Ou configurar env vars, Docker, etc.
   - Clique "Continue to Payment"

5. **Step 4: Payment & Launch**
   - Revise o resumo do job
   - Veja o custo estimado
   - Clique **"Launch Job"**

**Resultado Esperado:**
```
Step 1: ✅ Arquivo analisado
Step 2: ✅ GPU selecionada
Step 3: ✅ Config (opcional)
Step 4: ✅ Job criado com escrow
```

---

### 5️⃣ INTEGRAÇÃO QUBIC: ESCROW

**Objetivo:** Verificar criação de escrow na blockchain Qubic

**O que acontece automaticamente:**
1. Sistema cria transação de escrow
2. Aguarda 3 confirmações (0/3 → 1/3 → 2/3 → 3/3)
3. Após confirmado, job inicia

**Monitorar:**
- Console do navegador (F12)
- Deve mostrar logs:
```
🔒 Creating escrow transaction...
✅ Escrow transaction created: [TX_HASH]
   Explorer: https://explorer.qubic.org/tx/[TX_HASH]
⏳ Waiting for 3 confirmations...
   Confirmations: 1/3
   Confirmations: 2/3
   Confirmations: 3/3
✅ Escrow confirmed
📋 Creating job in database...
✅ Job created: [JOB_ID]
```

**Verificar no Backend:**
```bash
# Ver jobs criados
Invoke-WebRequest -Uri "http://localhost:3004/api/jobs" -UseBasicParsing
```

---

### 6️⃣ MONITORAR JOB

**Objetivo:** Ver job executando em tempo real

**Passos:**
1. Após job criado, deve redirecionar para: `/app/jobs/[job-id]/monitor`
2. Dashboard deve mostrar:
   - ✅ Status do job
   - ✅ GPU metrics (utilização, temperatura, memória)
   - ✅ Logs em tempo real
   - ✅ Progresso (0-100%)
   - ✅ Custo acumulado

**Resultado Esperado:**
```
Dashboard com 3 colunas:
- Esquerda: Info do job
- Centro: Métricas GPU (gráficos)
- Direita: Logs streaming
```

---

### 7️⃣ PROVIDER: VER EARNINGS

**Objetivo:** Provider vê ganhos em tempo real

**Passos:**
1. Abra: http://localhost:3004/app/provider/earnings
2. Deve mostrar:
   - ✅ Total ganho
   - ✅ Ganhos de hoje (atualizando a cada 5s)
   - ✅ Jobs ativos
   - ✅ Histórico de transações

**Resultado Esperado:**
```
Dashboard Provider:
- Total Earnings: X QUBIC
- Today: Y QUBIC (atualizando)
- Active Jobs: 1
- Transaction History com links para explorer
```

---

## 🐛 PROBLEMAS COMUNS E SOLUÇÕES

### Problema 1: GPU não detectada
**Solução:**
- Navegador pode não suportar WebGPU
- Sistema baixa worker nativo automaticamente
- Ou use mock data para teste

### Problema 2: Escrow timeout
**Solução:**
- Verificar se backend Qubic está configurado
- Checar logs do backend
- Pode usar modo mock para teste

### Problema 3: Job não inicia
**Solução:**
- Verificar se worker está rodando
- Checar logs do backend
- Verificar se provider está online

---

## 🧪 TESTES AUTOMATIZADOS

### Teste Backend API
```bash
# Testar endpoints principais
Invoke-WebRequest -Uri "http://localhost:3004/api/health" -UseBasicParsing
Invoke-WebRequest -Uri "http://localhost:3004/api/providers" -UseBasicParsing
Invoke-WebRequest -Uri "http://localhost:3004/api/jobs" -UseBasicParsing
```

### Teste Frontend
```bash
# Abrir páginas principais
start http://localhost:3004/app/marketplace
start http://localhost:3004/app/become-provider
start http://localhost:3004/app/jobs/submit
start http://localhost:3004/app/provider/earnings
```

---

## ✅ CHECKLIST FINAL

Antes de gravar o vídeo, confirme:

- [ ] Provider consegue registrar GPU
- [ ] GPU aparece no marketplace
- [ ] Consumer consegue selecionar GPU
- [ ] JobWizard funciona (4 steps)
- [ ] Escrow é criado (ver logs)
- [ ] Job é criado no backend
- [ ] Monitor mostra job em tempo real
- [ ] Provider vê earnings atualizando
- [ ] Transações têm link para explorer

---

## 🎬 PRÓXIMO PASSO: GRAVAR VÍDEO

Quando tudo estiver funcionando 100%, siga o roteiro:

1. **Intro (30s):** Problema + Solução
2. **Provider (1min):** Registrar GPU em 1 clique
3. **Marketplace (1min):** Mostrar GPUs disponíveis
4. **Job Submit (2min):** Wizard completo
5. **Escrow (1min):** Mostrar transação Qubic
6. **Monitor (1min):** Dashboard tempo real
7. **Earnings (1min):** Provider ganhando
8. **Conclusão (30s):** Diferenciais

**Total: 7-8 minutos**

---

## 📞 SUPORTE

Se encontrar problemas:
1. Abra console do navegador (F12)
2. Veja logs do backend
3. Verifique este checklist
4. Documente o erro para correção
