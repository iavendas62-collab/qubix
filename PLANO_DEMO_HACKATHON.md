# 🎯 PLANO DEMO HACKATHON - FLUXO COMPLETO

## ✅ O QUE JÁ FUNCIONA

1. **Marketplace com 20 GPUs** ✅
2. **Qubic Wallet conectado** ✅
3. **Dashboard Consumer** ✅
4. **Dashboard Provider** ✅
5. **Backend com rotas funcionando** ✅
6. **Mock data estruturado** ✅

---

## 🎬 FLUXO DEMO DESEJADO

### 1. PROVIDER: Auto-detectar e Registrar GPU
```
- Ir para "My Hardware"
- Clicar "Auto-Detectar"
- Sistema detecta GPU
- Preencher preço (ex: 2.0 QUBIC/hora)
- Registrar
- GPU aparece em "My Hardware"
```

### 2. CONSUMER: Ver GPU no Marketplace
```
- Trocar para Consumer
- Ir para "Marketplace"
- Ver GPU do provider listada (+ as 20 mock)
- Filtrar/buscar
- Clicar em GPU
```

### 3. CONSUMER: Alugar GPU e Criar Job
```
- Clicar "Rent GPU"
- Preencher detalhes do job:
  * Tipo: LLM Training
  * Horas: 2
  * Descrição: "Train GPT model"
- Sistema cria escrow automático (QUBIC)
- Submeter job
- Ver job em "My Jobs"
```

### 4. PROVIDER: Ver Job e Executar
```
- Ir para "Job Monitor"
- Ver job atribuído
- Job começa automaticamente (mock)
- Mostrar progresso: 0% → 100%
- Mostrar métricas GPU:
  * Utilização: 85%
  * Temperatura: 72°C
  * VRAM: 18GB/24GB
```

### 5. CONSUMER: Acompanhar Progresso
```
- Ir para "My Jobs"
- Ver job em execução
- Progresso atualiza em tempo real
- Ver métricas da GPU
- Ver logs do job
```

### 6. JOB COMPLETA
```
- Job atinge 100%
- Escrow libera pagamento automaticamente
- Provider recebe QUBIC
- Consumer vê resultado
```

### 7. VER TRANSAÇÕES QUBIC
```
- Ir para "Qubic Wallet"
- Ver histórico de transações:
  * Escrow criado: -4.0 QUBIC
  * Pagamento liberado: +4.0 QUBIC (provider)
- Ver TX hash na blockchain
- Mostrar zero taxas
```

---

## 🔧 CORREÇÕES NECESSÁRIAS

### PRIORIDADE ALTA (Essencial para demo)

#### 1. Auto-detect GPU Funcionar (15 min)
**Arquivo:** `frontend/src/hooks/useHardwareDetection.ts`
**Problema:** Detecta mas não registra corretamente
**Solução:** Garantir que após detectar, chama API de registro

#### 2. Hardware Aparecer no Marketplace (10 min)
**Arquivo:** `backend/src/routes/providers.ts`
**Problema:** Hardware registrado não aparece no marketplace
**Solução:** Endpoint `/api/providers` deve retornar MOCK + registrados

#### 3. Job Submit com Escrow Mock (20 min)
**Arquivos:** 
- `frontend/src/pages/consumer/JobSubmit.tsx`
- `backend/src/routes/jobs.ts`
**Problema:** Não cria escrow ao submeter job
**Solução:** Simular criação de escrow (mock) e associar ao job

#### 4. Job Progress Simulado (15 min)
**Arquivo:** `backend/src/routes/jobs.ts`
**Problema:** Job não progride automaticamente
**Solução:** Criar endpoint que simula progresso 0→100% em 30s

#### 5. Transações no Qubic Wallet (15 min)
**Arquivo:** `frontend/src/pages/QubicWallet.tsx`
**Problema:** Não mostra transações de escrow/pagamento
**Solução:** Adicionar seção de histórico de transações

---

## 📋 IMPLEMENTAÇÃO PASSO A PASSO

### PASSO 1: Corrigir Auto-detect (AGORA)
- [ ] Verificar hook useHardwareDetection
- [ ] Garantir que registra no backend
- [ ] Testar detecção + registro

### PASSO 2: Marketplace Mostrar Registrados
- [ ] Modificar `/api/providers` para incluir registrados
- [ ] Testar que GPU aparece no marketplace

### PASSO 3: Job Submit com Escrow
- [ ] Adicionar criação de escrow mock ao submeter job
- [ ] Salvar escrowTxHash no job
- [ ] Mostrar confirmação de escrow

### PASSO 4: Simular Execução do Job
- [ ] Criar endpoint `/api/jobs/:id/simulate`
- [ ] Progresso automático 0→100% em 30s
- [ ] Atualizar métricas GPU fake
- [ ] Completar job e liberar escrow

### PASSO 5: Histórico de Transações
- [ ] Adicionar seção no Qubic Wallet
- [ ] Mostrar escrow criado
- [ ] Mostrar pagamento liberado
- [ ] Mostrar TX hashes

---

## ⏱️ TEMPO ESTIMADO

- **Passo 1:** 15 min
- **Passo 2:** 10 min
- **Passo 3:** 20 min
- **Passo 4:** 15 min
- **Passo 5:** 15 min
- **Testes:** 15 min

**TOTAL: ~90 minutos**

---

## 🎥 ROTEIRO DE GRAVAÇÃO

Depois de tudo funcionando:

1. **Intro (30s):** Problema + Solução
2. **Provider (60s):** Auto-detect → Registrar GPU
3. **Consumer (60s):** Marketplace → Alugar GPU
4. **Job (90s):** Criar job → Ver progresso → Completar
5. **Qubic (60s):** Wallet → Transações → Zero taxas
6. **Conclusão (30s):** Recap + Visão

**Total: 5 minutos**

---

## ✅ CHECKLIST FINAL

Antes de gravar:

- [ ] Auto-detect funciona
- [ ] GPU aparece no marketplace
- [ ] Rent GPU funciona
- [ ] Job é criado com escrow
- [ ] Job progride automaticamente
- [ ] Métricas GPU aparecem
- [ ] Job completa
- [ ] Escrow libera pagamento
- [ ] Transações aparecem no wallet
- [ ] Tudo testado 2x

---

## 🚀 VAMOS COMEÇAR!

Qual passo você quer que eu implemente primeiro?

**Recomendo:** Começar pelo Passo 1 (Auto-detect) e ir em ordem.

Me confirme e eu começo! 💪
