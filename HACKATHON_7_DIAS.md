# 🏆 QUBIX - Plano 7 Dias para Hackathon

## 🎯 Objetivo Final
Apresentação com:
- ✅ Frontend funcional (já pronto)
- ✅ Integração Qubic real
- ✅ 1 GPU real executando job
- ✅ Video demo de 5 minutos
- ✅ Slides de apresentação

---

## 📅 DIA 1 - Qubic Research & Setup

### Manhã (4h): Research Qubic
**Objetivo**: Entender como integrar com Qubic

#### Tarefas:
1. **Documentação Qubic** (1h)
   - [ ] Ler docs oficiais: https://qubic.org/docs
   - [ ] Entender arquitetura Qubic
   - [ ] Identificar APIs disponíveis
   - [ ] Verificar SDKs (JavaScript/Python)

2. **Wallet Setup** (1h)
   - [ ] Criar wallet Qubic testnet
   - [ ] Obter tokens testnet (faucet)
   - [ ] Testar envio de transação básica
   - [ ] Documentar processo

3. **Smart Contract Research** (1h)
   - [ ] Verificar se Qubic tem smart contracts
   - [ ] Se sim: estudar linguagem/sintaxe
   - [ ] Se não: planejar alternativa (backend escrow)
   - [ ] Definir arquitetura final

4. **SDK Testing** (1h)
   - [ ] Instalar SDK Qubic
   - [ ] Testar conexão com rede
   - [ ] Testar criação de transação
   - [ ] Testar query de balance

**Entregável**: Documento `QUBIC_INTEGRATION.md` com:
- Como conectar wallet
- Como criar transação
- Como verificar balance
- Limitações encontradas

### Tarde (4h): Implementação Básica

#### Tarefas:
1. **Backend Qubic Service** (2h)
   ```javascript
   // backend/src/services/qubic-service.js
   - connectWallet()
   - getBalance(address)
   - createTransaction(from, to, amount)
   - verifyTransaction(txHash)
   ```
   - [ ] Criar arquivo
   - [ ] Implementar funções básicas
   - [ ] Testar com testnet
   - [ ] Adicionar error handling

2. **Frontend Qubic Integration** (2h)
   ```typescript
   // frontend/src/services/qubic.ts
   - connectQubicWallet()
   - getWalletBalance()
   - signTransaction()
   ```
   - [ ] Criar service
   - [ ] Integrar no TopNavbar
   - [ ] Substituir MetaMask por Qubic
   - [ ] Testar conexão

**Entregável**: 
- Backend service funcionando
- Frontend conectando wallet Qubic
- Balance real aparecendo na UI

### Noite (2h): Testing & Documentation

#### Tarefas:
- [ ] Testar fluxo completo de wallet
- [ ] Documentar problemas encontrados
- [ ] Criar plano B se Qubic for muito limitado
- [ ] Commit código do dia

**Checkpoint Dia 1**:
- ✅ Wallet Qubic conecta no frontend
- ✅ Balance real aparece
- ✅ Entendo limitações da plataforma

---

## 📅 DIA 2 - Qubic Transactions & Escrow

### Manhã (4h): Transaction Flow

#### Tarefas:
1. **Escrow Logic** (2h)
   
   **Opção A: Smart Contract (se Qubic suportar)**
   ```cpp
   // contracts/SimpleEscrow.cpp
   - lockFunds(jobId, amount)
   - releaseFunds(jobId, provider)
   - refund(jobId, user)
   ```
   
   **Opção B: Backend Escrow (mais provável)**
   ```javascript
   // backend/src/services/escrow.js
   - createEscrow(jobId, userId, amount)
   - lockFunds(escrowId)
   - releaseFunds(escrowId, providerId)
   - refund(escrowId)
   ```
   
   - [ ] Escolher abordagem (A ou B)
   - [ ] Implementar lógica
   - [ ] Adicionar validações
   - [ ] Testar com testnet

2. **Transaction Creation** (2h)
   - [ ] Implementar criação de TX no launch job
   - [ ] Adicionar confirmação de TX
   - [ ] Mostrar TX hash na UI
   - [ ] Link para explorer (se existir)

**Entregável**: Escrow funcionando (smart contract ou backend)

### Tarde (4h): Integration com Frontend

#### Tarefas:
1. **Launch Job com Payment** (2h)
   ```typescript
   // Modificar LaunchInstanceWizard
   - Step 1: Config (já existe)
   - Step 2: Payment (NOVO)
     - Mostrar custo
     - Confirmar transação Qubic
     - Aguardar confirmação
   - Step 3: Provisioning
   - Step 4: Ready
   ```
   - [ ] Adicionar step de payment
   - [ ] Integrar com Qubic service
   - [ ] Mostrar loading durante TX
   - [ ] Mostrar TX hash quando completo

2. **Transaction History** (2h)
   - [ ] Criar página de transações
   - [ ] Listar TXs do usuário
   - [ ] Mostrar status (pending/confirmed)
   - [ ] Link para explorer

**Entregável**: 
- Launch job cria transação Qubic real
- TX hash aparece na UI
- Funds são locked

### Noite (2h): Testing End-to-End

#### Tarefas:
- [ ] Testar fluxo: Connect wallet → Launch job → TX criada
- [ ] Verificar TX no explorer (se existir)
- [ ] Documentar fluxo completo
- [ ] Fix bugs encontrados

**Checkpoint Dia 2**:
- ✅ Launch job cria TX Qubic real
- ✅ Funds são locked em escrow
- ✅ TX hash visível na UI

---

## 📅 DIA 3 - GPU Worker Setup

### Manhã (4h): Worker Development

#### Tarefas:
1. **GPU Detection** (1h)
   ```python
   # worker/gpu_detector.py
   import torch
   import GPUtil
   
   def detect_gpu():
       - Get GPU model
       - Get VRAM
       - Get temperature
       - Get utilization
   ```
   - [ ] Criar script
   - [ ] Testar na sua máquina
   - [ ] Retornar JSON com specs

2. **Worker Registration** (1h)
   ```python
   # worker/qubix_worker.py
   def register_worker():
       gpu_info = detect_gpu()
       response = requests.post(
           'http://localhost:3001/api/providers/register',
           json={
               'address': QUBIC_ADDRESS,
               'gpu': gpu_info,
               'price_per_hour': 10
           }
       )
   ```
   - [ ] Implementar registro
   - [ ] Enviar specs da GPU
   - [ ] Receber worker ID
   - [ ] Salvar localmente

3. **Job Polling** (2h)
   ```python
   def poll_jobs():
       while True:
           jobs = requests.get(
               f'http://localhost:3001/api/jobs/available?workerId={WORKER_ID}'
           ).json()
           
           if jobs:
               execute_job(jobs[0])
           
           time.sleep(5)
   ```
   - [ ] Implementar polling
   - [ ] Aceitar job
   - [ ] Atualizar status
   - [ ] Loop infinito

**Entregável**: Worker registra GPU e faz polling

### Tarde (4h): Job Execution

#### Tarefas:
1. **Simple Job: MNIST Training** (3h)
   ```python
   # worker/jobs/mnist_trainer.py
   import torch
   import torch.nn as nn
   from torchvision import datasets, transforms
   
   def train_mnist(epochs=5):
       # 1. Load dataset
       # 2. Create simple CNN
       # 3. Train model
       # 4. Save model
       # 5. Return metrics
   ```
   - [ ] Implementar CNN simples
   - [ ] Download MNIST dataset
   - [ ] Train por 5 epochs
   - [ ] Log progresso
   - [ ] Salvar modelo

2. **Job Executor** (1h)
   ```python
   def execute_job(job):
       job_id = job['id']
       job_type = job['type']
       
       # Update status: RUNNING
       update_job_status(job_id, 'RUNNING')
       
       # Execute
       if job_type == 'mnist_training':
           result = train_mnist()
       
       # Update status: COMPLETED
       update_job_status(job_id, 'COMPLETED', result)
   ```
   - [ ] Implementar executor
   - [ ] Adicionar logging
   - [ ] Error handling
   - [ ] Upload resultado

**Entregável**: Worker executa job MNIST na sua GPU

### Noite (2h): Testing Worker

#### Tarefas:
- [ ] Testar registro de GPU
- [ ] Testar polling
- [ ] Testar execução de job
- [ ] Verificar logs
- [ ] Monitorar GPU (nvidia-smi)

**Checkpoint Dia 3**:
- ✅ Worker registra sua GPU
- ✅ Worker recebe jobs
- ✅ Worker executa MNIST training
- ✅ Logs aparecem em tempo real

---

## 📅 DIA 4 - Backend Real & Integration

### Manhã (4h): Backend Implementation

#### Tarefas:
1. **Database Setup** (1h)
   ```bash
   # Usar Prisma + SQLite (simples)
   npx prisma init
   npx prisma migrate dev
   npx prisma generate
   ```
   - [ ] Configurar Prisma
   - [ ] Criar schema (Job, Provider, Transaction)
   - [ ] Rodar migrations
   - [ ] Seed inicial

2. **Job Queue** (2h)
   ```javascript
   // backend/src/services/job-queue.js
   class JobQueue {
       async createJob(userId, gpuId, config) {
           // 1. Create job in DB
           // 2. Create Qubic TX (escrow)
           // 3. Assign to worker
           // 4. Return job ID
       }
       
       async updateJobStatus(jobId, status, result) {
           // 1. Update DB
           // 2. If completed: release funds
           // 3. Notify user
       }
   }
   ```
   - [ ] Implementar queue
   - [ ] Integrar com Qubic
   - [ ] Adicionar job matching
   - [ ] Error handling

3. **API Routes** (1h)
   ```javascript
   // Substituir mock-server.js
   POST /api/jobs/create
   GET  /api/jobs/:id
   POST /api/jobs/:id/status
   GET  /api/jobs/available (para workers)
   ```
   - [ ] Implementar rotas
   - [ ] Conectar ao DB
   - [ ] Validações
   - [ ] Testing

**Entregável**: Backend real com DB e job queue

### Tarde (4h): End-to-End Integration

#### Tarefas:
1. **Frontend → Backend → Worker** (2h)
   - [ ] Frontend envia job para backend real
   - [ ] Backend cria TX Qubic
   - [ ] Backend notifica worker
   - [ ] Worker executa job
   - [ ] Worker reporta resultado
   - [ ] Backend libera pagamento
   - [ ] Frontend mostra resultado

2. **Real-time Updates** (2h)
   ```javascript
   // Opção simples: Polling
   useEffect(() => {
       const interval = setInterval(() => {
           fetch(`/api/jobs/${jobId}`)
               .then(res => res.json())
               .then(job => setJobStatus(job.status))
       }, 2000)
       return () => clearInterval(interval)
   }, [jobId])
   ```
   - [ ] Implementar polling no frontend
   - [ ] Atualizar status em tempo real
   - [ ] Mostrar progresso
   - [ ] Mostrar logs (se possível)

**Entregável**: Fluxo completo funcionando

### Noite (2h): Testing & Bug Fixes

#### Tarefas:
- [ ] Testar fluxo completo 5x
- [ ] Fix bugs críticos
- [ ] Melhorar error messages
- [ ] Adicionar retry logic

**Checkpoint Dia 4**:
- ✅ Frontend → Backend → Worker funcionando
- ✅ Job executa na GPU real
- ✅ Pagamento Qubic processa
- ✅ Resultado aparece no frontend

---

## 📅 DIA 5 - Testing & Refinement

### Manhã (4h): Comprehensive Testing

#### Tarefas:
1. **Happy Path Testing** (1h)
   - [ ] User conecta wallet
   - [ ] User lança job
   - [ ] Job executa
   - [ ] User recebe resultado
   - [ ] Payment processa
   - [ ] Repetir 10x

2. **Error Scenarios** (2h)
   - [ ] Wallet sem saldo
   - [ ] Worker offline
   - [ ] Job falha
   - [ ] Network error
   - [ ] TX falha
   - [ ] Adicionar handling para cada

3. **Performance Testing** (1h)
   - [ ] Medir tempo de execução
   - [ ] Otimizar gargalos
   - [ ] Adicionar caching se necessário
   - [ ] Verificar memory leaks

**Entregável**: Sistema estável e robusto

### Tarde (4h): UI Polish & Monitoring

#### Tarefas:
1. **Monitoring Dashboard** (2h)
   ```typescript
   // Adicionar em My Instances
   - Real GPU metrics (da sua máquina)
   - Live logs streaming
   - Progress bar real
   - Temperature graph
   ```
   - [ ] Implementar métricas reais
   - [ ] Adicionar graphs
   - [ ] Mostrar logs do worker
   - [ ] Polish visual

2. **Transaction Explorer** (2h)
   - [ ] Criar página de TXs
   - [ ] Mostrar histórico
   - [ ] Link para Qubic explorer
   - [ ] Status badges

**Entregável**: UI polida com monitoring real

### Noite (2h): Documentation

#### Tarefas:
- [ ] Atualizar README.md
- [ ] Documentar setup do worker
- [ ] Criar troubleshooting guide
- [ ] Preparar FAQ

**Checkpoint Dia 5**:
- ✅ Sistema testado e estável
- ✅ UI mostra dados reais
- ✅ Documentação completa

---

## 📅 DIA 6 - Demo Recording

### Manhã (4h): Recording Preparation

#### Tarefas:
1. **Setup Recording Environment** (1h)
   - [ ] Instalar OBS Studio
   - [ ] Configurar layout multi-tela
   - [ ] Testar áudio/video
   - [ ] Preparar terminal com logs coloridos

2. **Script Refinement** (1h)
   ```
   [0:00-0:30] Intro
   "Hi, I'm [name] and this is QUBIX..."
   
   [0:30-1:00] Problem
   "AI compute is expensive and centralized..."
   
   [1:00-2:00] Solution
   "QUBIX is a decentralized marketplace..."
   
   [2:00-4:00] Demo
   - Connect wallet
   - Browse GPUs
   - Launch job
   - Watch execution
   - See result
   
   [4:00-4:30] Tech & Business
   "Built with React, Qubic blockchain..."
   
   [4:30-5:00] Call to Action
   "Join us in democratizing AI compute..."
   ```
   - [ ] Escrever script completo
   - [ ] Praticar narração
   - [ ] Timing de cada seção
   - [ ] Preparar transições

3. **Dry Runs** (2h)
   - [ ] Fazer 5 dry runs completos
   - [ ] Identificar pontos de falha
   - [ ] Preparar plano B para cada
   - [ ] Otimizar timing

**Entregável**: Script pronto e testado

### Tarde (4h): Recording

#### Tarefas:
1. **Take 1-3** (2h)
   - [ ] Gravar primeira versão completa
   - [ ] Review e identificar problemas
   - [ ] Gravar segunda versão
   - [ ] Review novamente
   - [ ] Gravar terceira versão (backup)

2. **B-Roll** (1h)
   - [ ] Gravar close-ups de código
   - [ ] Gravar terminal com logs
   - [ ] Gravar GPU monitor (nvidia-smi)
   - [ ] Gravar Qubic explorer

3. **Screenshots** (1h)
   - [ ] Capturar todas as telas importantes
   - [ ] Capturar TX hash
   - [ ] Capturar resultado do job
   - [ ] Organizar em pasta

**Entregável**: Video raw gravado

### Noite (2h): Basic Editing

#### Tarefas:
- [ ] Importar no editor (DaVinci Resolve free)
- [ ] Cortar erros/pausas
- [ ] Adicionar transições
- [ ] Adicionar música de fundo (baixo volume)
- [ ] Export em 1080p

**Checkpoint Dia 6**:
- ✅ Video demo de 5 min gravado
- ✅ Editado e polido
- ✅ Screenshots de backup

---

## 📅 DIA 7 - Presentation Prep

### Manhã (4h): Slides Creation

#### Tarefas:
1. **Slide Deck** (3h)
   ```
   Slide 1: Title
   - QUBIX logo
   - Tagline: "Decentralized AI Compute Marketplace"
   - Your name
   
   Slide 2: Problem
   - AI compute is expensive ($3/hour)
   - Centralized (AWS, GCP)
   - No transparency
   
   Slide 3: Solution
   - P2P GPU marketplace
   - Blockchain-powered (Qubic)
   - Pay-per-second
   
   Slide 4: Demo
   - [EMBED VIDEO]
   
   Slide 5: How It Works
   - Architecture diagram
   - User → Platform → Provider
   - Smart contract escrow
   
   Slide 6: Tech Stack
   - Frontend: React + TypeScript
   - Backend: Node.js + Prisma
   - Blockchain: Qubic
   - Worker: Python + PyTorch
   
   Slide 7: Market Opportunity
   - $10B AI compute market
   - Growing 40% YoY
   - Underutilized GPUs worldwide
   
   Slide 8: Business Model
   - 15% platform fee
   - $50 average job
   - 1000 jobs/day = $7.5K revenue/day
   
   Slide 9: Traction
   - MVP functional
   - 1 GPU provider (demo)
   - Ready for beta users
   
   Slide 10: Roadmap
   - Q1: Beta launch + 10 providers
   - Q2: 100 providers + enterprise
   - Q3: Global expansion
   - Q4: 1000 providers
   
   Slide 11: Team
   - Your background
   - Advisors (if any)
   - Open positions
   
   Slide 12: Ask
   - Seeking: Feedback + Early users
   - Contact: email/twitter
   - GitHub: link
   ```
   - [ ] Criar slides no Canva/PowerPoint
   - [ ] Adicionar imagens/icons
   - [ ] Embed video demo
   - [ ] Polish design

2. **Backup Materials** (1h)
   - [ ] PDF do slide deck
   - [ ] Video separado (caso embed falhe)
   - [ ] Screenshots impressos
   - [ ] One-pager resumo

**Entregável**: Slide deck completo

### Tarde (4h): Pitch Practice

#### Tarefas:
1. **Solo Practice** (2h)
   - [ ] Praticar pitch 10x
   - [ ] Gravar e assistir
   - [ ] Melhorar pontos fracos
   - [ ] Timing (deve ser 5-7 min)

2. **Mock Presentation** (2h)
   - [ ] Apresentar para amigo/colega
   - [ ] Receber feedback
   - [ ] Ajustar baseado em feedback
   - [ ] Praticar Q&A

**Entregável**: Pitch ensaiado e polido

### Noite (2h): Final Checks

#### Tarefas:
1. **Technical Checklist** (1h)
   - [ ] Sistema funcionando
   - [ ] Worker rodando
   - [ ] Backend online
   - [ ] Frontend deployado (Vercel/Netlify)
   - [ ] Video uploaded (YouTube unlisted)
   - [ ] GitHub repo público e organizado

2. **Presentation Checklist** (1h)
   - [ ] Slides finalizados
   - [ ] Video testado
   - [ ] Backup materials prontos
   - [ ] Laptop carregado
   - [ ] Adaptadores/cabos
   - [ ] Plano B se tech falhar

**Checkpoint Dia 7**:
- ✅ Slides prontos
- ✅ Video demo polido
- ✅ Pitch ensaiado
- ✅ Sistema funcionando
- ✅ PRONTO PARA HACKATHON! 🚀

---

## 📊 Checklist Final

### Antes da Apresentação
- [ ] Sistema testado e funcionando
- [ ] Video demo carregado
- [ ] Slides no laptop
- [ ] Backup em USB
- [ ] GitHub repo público
- [ ] Demo live pronto (se pedirem)
- [ ] Pitch ensaiado
- [ ] Q&A preparado

### Durante Apresentação
- [ ] Começar com hook forte
- [ ] Mostrar video demo
- [ ] Explicar tech stack
- [ ] Mostrar código (se perguntarem)
- [ ] Pitch business model
- [ ] Responder perguntas com confiança
- [ ] Terminar com call to action

### Possíveis Perguntas
**Técnicas:**
- "Como você garante segurança?"
- "E se o provider não entregar?"
- "Como escala para 1000 GPUs?"
- "Por que Qubic e não Ethereum?"

**Business:**
- "Qual o TAM?"
- "Quem são os competidores?"
- "Como você vai adquirir usuários?"
- "Qual o unit economics?"

**Prepare respostas para todas!**

---

## 🎯 Success Metrics

### Must Have (Essencial)
- ✅ Video demo mostrando fluxo completo
- ✅ 1 GPU real executando job
- ✅ Transação Qubic real
- ✅ Frontend profissional
- ✅ Pitch de 5-7 minutos

### Nice to Have (Bonus)
- ⭐ Live demo funcionando
- ⭐ Multiple jobs executados
- ⭐ Real-time logs streaming
- ⭐ Qubic explorer mostrando TXs
- ⭐ GitHub stars/forks

### Wow Factor (Diferencial)
- 🚀 Job executando AO VIVO durante apresentação
- 🚀 Mostrar TX confirmando na blockchain
- 🚀 Comparação de custo (QUBIX vs AWS)
- 🚀 Roadmap ambicioso mas realista

---

## 💡 Tips Finais

### Do's ✅
- Foque no storytelling, não só tech
- Mostre paixão pelo problema
- Seja honesto sobre limitações
- Demonstre tração (mesmo que pequena)
- Tenha plano B para tudo

### Don'ts ❌
- Não prometa o que não pode entregar
- Não critique competidores diretamente
- Não entre em detalhes técnicos demais
- Não passe do tempo
- Não ignore perguntas difíceis

### Se Algo Der Errado
- **Video não roda**: Use screenshots + narração
- **Live demo falha**: "Como vocês viram no video..."
- **Pergunta difícil**: "Ótima pergunta, ainda estamos explorando isso..."
- **Tempo acabando**: Pule para slide final (ask)

---

## 🏆 Resultado Esperado

Após 7 dias você terá:
- ✅ Sistema funcional com Qubic integration
- ✅ 1 GPU real executando jobs
- ✅ Video demo profissional
- ✅ Slide deck completo
- ✅ Pitch ensaiado
- ✅ Alta chance de impressionar juízes

**Boa sorte! Você consegue! 🚀**

---

## 📞 Suporte Durante os 7 Dias

Se precisar de ajuda:
1. **Dia 1-2**: Foque em fazer Qubic funcionar, mesmo que básico
2. **Dia 3-4**: Worker é crítico, teste muito
3. **Dia 5**: Não adicione features novas, só polish
4. **Dia 6**: Grave múltiplas takes, escolha a melhor
5. **Dia 7**: Pratique pitch até decorar

**Lembre-se**: Melhor ter algo simples funcionando do que algo complexo quebrado!
