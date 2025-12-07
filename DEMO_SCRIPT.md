# 🎬 QUBIX - Demo Script

## 🎯 Objetivo
Demonstrar a plataforma QUBIX funcionando com todas as features da FASE 1.

---

## 📋 Checklist Pré-Demo

- [ ] Backend rodando em http://localhost:3001
- [ ] Frontend rodando em http://localhost:3000
- [ ] Browser aberto (Chrome/Edge recomendado)
- [ ] Tela limpa (fechar outras abas)

---

## 🎬 ROTEIRO DA DEMO (5 minutos)

### 1. INTRODUÇÃO (30s)
**"Bem-vindo ao QUBIX - o marketplace descentralizado de computação AI na blockchain Qubic."**

- Mostre a tela inicial
- Destaque o design AWS-inspired
- Aponte a sidebar com todas as seções

### 2. DASHBOARD (45s)
**"Vamos começar pelo Dashboard, onde você tem uma visão geral da rede."**

- Mostre os 4 cards principais:
  - 1,234 jobs totais (45 ativos)
  - 89 providers ativos
  - 342 modelos AI disponíveis
  - 4,500 TFLOPS de compute
  
- Aponte o gráfico de Job Activity
- Mostre Network Stats com utilização
- Scroll até Recent Jobs
- Explique os status badges (COMPLETED, RUNNING, PENDING)

### 3. WALLET CONNECTION (30s)
**"Primeiro, vamos conectar nossa wallet."**

- Clique "Connect Wallet"
- Se tiver MetaMask: aceite conexão
- Se não: explique que está usando mock wallet
- Mostre o balance (ex: 5,432.18 QUBIC)
- Clique no wallet para abrir menu
- Mostre address completo
- Feche o menu

### 4. GPU MARKETPLACE (1m 30s)
**"Agora vamos ao coração da plataforma - o GPU Marketplace."**

- Clique "GPU Instances" no sidebar
- Mostre "22 instances found"
- **Demonstre os filtros**:
  - Price: selecione "0-10 QUBIC"
  - Model: selecione "RTX 4090"
  - Location: selecione "US"
  - Status: selecione "Available only"
  - Mostre como a lista filtra em tempo real
  
- **Demonstre o sorting**:
  - Sort by: "Price (Low to High)"
  - Sort by: "Rating (High to Low)"
  
- **Explique a tabela**:
  - GPU Model (RTX 4090, A100, H100, etc)
  - VRAM (10GB, 24GB, 80GB)
  - Location com ícone
  - Price/hour em QUBIC
  - Rating com estrelas
  - Status badge (Available/In Use)
  
- Clique "Refresh" para recarregar

### 5. LAUNCH INSTANCE WIZARD (1m 30s)
**"Vamos lançar uma instância GPU."**

- Clique "Launch" em uma GPU disponível (ex: RTX 4090)
- **Step 1: Configuration**
  - Mostre os 4 environments (Jupyter, SSH, VSCode, API)
  - Selecione "Jupyter" (para notebooks interativos)
  - Mostre dataset upload (opcional)
  - Ajuste duration slider para 4 horas
  - Toggle "Enable Redundancy" (2x GPUs)
  - Mostre cost estimator atualizar: 10 → 40 → 80 QUBIC
  - Clique "Launch Instance"
  
- **Step 2: Provisioning**
  - Mostre loading animation
  - Leia os status messages:
    - ✓ Allocating GPU resources
    - ✓ Installing environment
    - ⟳ Configuring network...
  - Aguarde 3 segundos
  
- **Step 3: Ready!**
  - Mostre checkmark verde
  - Mostre Instance ID gerado
  - Mostre Jupyter URL
  - Mostre API Token (com botão Copy)
  - Clique "Go to My Instances"

### 6. MY INSTANCES (1m)
**"Agora vamos gerenciar nossas instâncias ativas."**

- Mostre os 3 summary cards:
  - 2 Active Instances
  - 60.00 QUBIC Total Cost
  - 66% Avg GPU Usage
  
- **Primeira instância**:
  - Mostre ID, status badge, model
  - Mostre quick stats (GPU 87%, Memory 18.5/24GB, Temp 72°C)
  - Clique "Show Details"
  
- **Expanded view**:
  - Mostre GPU Usage graph (animated bars)
  - Mostre Recent Logs streaming
  - Mostre Connection Details (Jupyter URL)
  - Clique "Connect" → abre em nova aba (ou mostra alert)
  
- **Stop instance**:
  - Clique "Stop"
  - Confirme no alert
  - Mostre instance removida

### 7. FEATURES ADICIONAIS (30s)
**"A plataforma tem muito mais funcionalidades."**

- Mostre sidebar:
  - CPU Instances (em desenvolvimento)
  - Datasets (em desenvolvimento)
  - Models (em desenvolvimento)
  - Billing & Usage (em desenvolvimento)
  
- Clique "Refresh" no Dashboard
- Mostre auto-refresh funcionando

### 8. ENCERRAMENTO (30s)
**"Resumindo o que vimos:"**

- ✅ Dashboard com métricas em tempo real
- ✅ 22 GPUs disponíveis com filtros avançados
- ✅ Launch wizard completo (3 steps)
- ✅ Monitoring em tempo real
- ✅ Wallet integration (MetaMask)
- ✅ Design profissional AWS-inspired

**"QUBIX está pronto para democratizar o acesso à computação AI usando a blockchain Qubic."**

---

## 🎯 PONTOS-CHAVE PARA DESTACAR

### Tecnologia
- **Blockchain Qubic**: Descentralização real
- **22 GPUs**: RTX 4090, A100, H100, V100
- **4 Environments**: Jupyter, SSH, VSCode, API
- **Real-time**: Monitoring, logs, updates

### UX/UI
- **AWS-inspired**: Design profissional
- **Filtros avançados**: Price, model, location, status
- **Wizard intuitivo**: 3 steps simples
- **Monitoring completo**: GPU, memory, temperature

### Business
- **Pay-per-hour**: Modelo flexível
- **Redundancy**: Fault tolerance opcional
- **Cost estimator**: Transparência total
- **Marketplace**: Providers competem no preço

---

## 🚨 TROUBLESHOOTING

### Backend não responde
```bash
cd backend
node mock-server.js
```

### Frontend não carrega
```bash
cd frontend
npm start
```

### Wallet não conecta
- Use mock wallet (funciona sem MetaMask)
- Ou instale MetaMask extension

### GPUs não aparecem
- Verifique console do browser (F12)
- Confirme backend em http://localhost:3001/api/gpus

---

## 📊 DADOS PARA MENCIONAR

- **22 GPUs** disponíveis no marketplace
- **1,234 jobs** processados na rede
- **89 providers** ativos
- **342 modelos AI** disponíveis
- **4,500 TFLOPS** de compute disponível
- **$5.50/hora** preço médio
- **67%** utilização da rede

---

## 🎬 VARIAÇÕES DA DEMO

### Demo Curta (2 min)
1. Dashboard (30s)
2. GPU Marketplace + Filtros (45s)
3. Launch Wizard (45s)

### Demo Técnica (10 min)
- Adicione explicação do código
- Mostre API endpoints
- Explique TypeScript types
- Demonstre real-time updates

### Demo Investidor (3 min)
- Foque em business model
- Destaque unit economics
- Mostre roadmap (MASTER_PLAN.md)
- Explique go-to-market

---

## ✅ CHECKLIST PÓS-DEMO

- [ ] Responder perguntas
- [ ] Compartilhar links:
  - GitHub repo
  - MASTER_PLAN.md
  - FASE_1_COMPLETA.md
- [ ] Coletar feedback
- [ ] Agendar follow-up

---

**Boa sorte com a demo! 🚀**
