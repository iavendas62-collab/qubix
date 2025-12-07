# 🏗️ Arquitetura de Cadastro e Integração Qubic

## 🎯 Decisão de Arquitetura

### ✅ Recomendado: Cadastro na Nossa Infra + Carteira Qubic

```
┌─────────────────────────────────────────────────────────────┐
│                      QUBIX (Nossa Infra)                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Usuário se cadastra no Qubix                          │
│     ├─ Email/Senha (nossa autenticação)                   │
│     ├─ Dados salvos no PostgreSQL                         │
│     └─ JWT para sessão                                    │
│                                                             │
│  2. Sistema cria carteira Qubic automaticamente           │
│     ├─ Gera seed + identity                               │
│     ├─ Salva identity no banco                            │
│     └─ Retorna seed para usuário guardar                  │
│                                                             │
│  3. Pagamentos via Qubic                                  │
│     ├─ Usuário usa identity para transações               │
│     ├─ Escrow gerenciado pela plataforma                  │
│     └─ Histórico salvo no nosso banco                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                            ↓
                    ┌───────────────┐
                    │ Rede Qubic    │
                    │ (Pagamentos)  │
                    └───────────────┘
```

## 📊 Comparação de Abordagens

| Aspecto | Nossa Infra + Qubic ✅ | Só Qubic ❌ |
|---------|----------------------|-------------|
| Autenticação | Email/Senha familiar | Seed complexo |
| UX | Simples e intuitiva | Complicada |
| Recuperação | Reset de senha | Perda de seed = perda total |
| Dados | Perfil, histórico, etc | Apenas transações |
| Flexibilidade | Total controle | Limitado |
| Pagamentos | Qubic blockchain | Qubic blockchain |

## 🎯 Fluxo Recomendado

### 1. Cadastro do Usuário

```typescript
// Frontend → Backend
POST /api/auth/register
{
  "name": "João Silva",
  "email": "joao@example.com",
  "password": "senha123",
  "type": "consumer" // ou "provider"
}

// Backend processa:
1. Cria usuário no PostgreSQL
2. Cria carteira Qubic automaticamente
3. Salva identity no banco
4. Retorna dados + seed para usuário
```

### 2. Login do Usuário

```typescript
// Frontend → Backend
POST /api/auth/login
{
  "email": "joao@example.com",
  "password": "senha123"
}

// Backend retorna:
{
  "token": "jwt-token",
  "user": {
    "id": "user-123",
    "name": "João Silva",
    "email": "joao@example.com",
    "qubicIdentity": "YDKBSPZUBCQJ...",
    "balance": 10.5 // consultado do Qubic
  }
}
```

### 3. Pagamento de Job

```typescript
// Usuário já está logado (JWT)
// Sistema usa identity salva no banco
POST /api/jobs/create
{
  "modelId": "llama-3-8b",
  "prompt": "Explain AI",
  "price": 10
}

// Backend:
1. Busca identity do usuário no banco
2. Cria job
3. Instrui pagamento via Qubic
4. Monitora transação
5. Libera job quando confirmado
```

## 💾 Estrutura do Banco de Dados

### Schema Prisma Atualizado

```prisma
model User {
  id            String   @id @default(cuid())
  email         String   @unique
  password      String   // hash bcrypt
  name          String
  type          UserType // CONSUMER ou PROVIDER
  
  // Qubic Integration
  qubicIdentity String?  @unique // Identity pública
  qubicSeedHint String?  // Dica do seed (opcional)
  
  // Timestamps
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  // Relations
  jobsAsConsumer Job[] @relation("ConsumerJobs")
  jobsAsProvider Job[] @relation("ProviderJobs")
  transactions   Transaction[]
}

enum UserType {
  CONSUMER
  PROVIDER
}

model Job {
  id          String   @id @default(cuid())
  
  // Job details
  modelId     String
  prompt      String
  result      String?
  price       Float
  status      JobStatus
  
  // Users
  consumerId  String
  consumer    User     @relation("ConsumerJobs", fields: [consumerId], references: [id])
  providerId  String?
  provider    User?    @relation("ProviderJobs", fields: [providerId], references: [id])
  
  // Qubic Transactions
  escrowTxHash    String? // TX de lock
  paymentTxHash   String? // TX de release
  
  // Timestamps
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  completedAt DateTime?
}

enum JobStatus {
  PENDING_PAYMENT
  PAYMENT_LOCKED
  PROCESSING
  COMPLETED
  PAID
  FAILED
  REFUNDED
}

model Transaction {
  id          String   @id @default(cuid())
  
  // Transaction details
  txHash      String   @unique
  from        String   // Qubic identity
  to          String   // Qubic identity
  amount      Float
  type        TransactionType
  status      TransactionStatus
  
  // Relations
  userId      String
  user        User     @relation(fields: [userId], references: [id])
  jobId       String?
  
  // Timestamps
  createdAt   DateTime @default(now())
  confirmedAt DateTime?
}

enum TransactionType {
  ESCROW_LOCK
  PAYMENT_RELEASE
  REFUND
  DEPOSIT
  WITHDRAWAL
}

enum TransactionStatus {
  PENDING
  CONFIRMED
  FAILED
}
```

## 🔐 Segurança

### O que salvamos no banco:
- ✅ **Identity** (pública) - Pode ser salva
- ✅ **Email/Senha** (hash) - Nossa autenticação
- ✅ **Histórico de transações** - Para auditoria
- ❌ **Seed** - NUNCA salvar no banco!

### Como lidar com o Seed:

```typescript
// No cadastro, retornamos o seed UMA VEZ
{
  "user": { ... },
  "wallet": {
    "identity": "YDKBSPZUBCQJ...",
    "seed": "bxzsurudltmrpkkljkks..." // ⚠️ Usuário deve guardar!
  },
  "warning": "Guarde o seed em local seguro! Não conseguiremos recuperá-lo."
}

// Opções para o usuário:
1. Copiar e colar em gerenciador de senhas
2. Anotar em papel e guardar em cofre
3. Usar extensão de carteira (futuro)
```

## 🎨 Fluxo de UX

### Tela de Cadastro

```
┌─────────────────────────────────────────┐
│         Cadastro no Qubix               │
├─────────────────────────────────────────┤
│                                         │
│  Nome:     [________________]           │
│  Email:    [________________]           │
│  Senha:    [________________]           │
│  Tipo:     ( ) Consumer  ( ) Provider  │
│                                         │
│  [ Criar Conta ]                        │
│                                         │
└─────────────────────────────────────────┘
                ↓
┌─────────────────────────────────────────┐
│    ✅ Conta Criada com Sucesso!        │
├─────────────────────────────────────────┤
│                                         │
│  Sua carteira Qubic foi criada:        │
│                                         │
│  Identity (pública):                    │
│  YDKBSPZUBCQJWGICTNPSVQSWAVCCRW...     │
│  [Copiar]                               │
│                                         │
│  ⚠️  IMPORTANTE: Guarde seu seed!      │
│                                         │
│  Seed (privado):                        │
│  bxzsurudltmrpkkljkks...                │
│  [Copiar] [Baixar]                      │
│                                         │
│  ⚠️  Não conseguiremos recuperar!      │
│                                         │
│  [ ] Li e entendi                       │
│  [ Continuar ]                          │
│                                         │
└─────────────────────────────────────────┘
```

### Tela de Login

```
┌─────────────────────────────────────────┐
│         Login no Qubix                  │
├─────────────────────────────────────────┤
│                                         │
│  Email:    [________________]           │
│  Senha:    [________________]           │
│                                         │
│  [ Entrar ]                             │
│                                         │
│  Esqueceu a senha?                      │
│                                         │
└─────────────────────────────────────────┘
```

## 🔄 Fluxo Completo

### 1. Usuário se Cadastra
```
Frontend                Backend                 Qubic
   |                       |                      |
   |--POST /register------>|                      |
   |                       |                      |
   |                       |--Create User-------->|
   |                       |  (PostgreSQL)        |
   |                       |                      |
   |                       |--Create Wallet------>|
   |                       |  (qubic-wallet)      |
   |                       |                      |
   |                       |<--Identity + Seed----|
   |                       |                      |
   |                       |--Save Identity------>|
   |                       |  (PostgreSQL)        |
   |                       |                      |
   |<--User + Wallet-------|                      |
   |                       |                      |
```

### 2. Usuário Cria Job
```
Frontend                Backend                 Qubic
   |                       |                      |
   |--POST /jobs---------->|                      |
   |  (JWT auth)           |                      |
   |                       |                      |
   |                       |--Get User Identity-->|
   |                       |  (PostgreSQL)        |
   |                       |                      |
   |                       |--Create Job--------->|
   |                       |  (PostgreSQL)        |
   |                       |                      |
   |<--Payment Info--------|                      |
   |                       |                      |
   |--Confirm Payment----->|                      |
   |  (via Qubic wallet)   |                      |
   |                       |                      |
   |                       |--Send TX------------>|
   |                       |                   (Blockchain)
   |                       |                      |
   |                       |<--TX Confirmed-------|
   |                       |                      |
   |<--Job Started---------|                      |
   |                       |                      |
```

## 💡 Vantagens desta Arquitetura

### Para o Usuário:
- ✅ Cadastro simples (email/senha)
- ✅ Login familiar
- ✅ Recuperação de senha possível
- ✅ Carteira Qubic criada automaticamente
- ✅ Pagamentos descentralizados

### Para a Plataforma:
- ✅ Controle total da UX
- ✅ Dados dos usuários no nosso banco
- ✅ Histórico completo
- ✅ Analytics e métricas
- ✅ Flexibilidade para evoluir

### Para o Ecossistema:
- ✅ Pagamentos on-chain (Qubic)
- ✅ Transparência nas transações
- ✅ Sem intermediários nos pagamentos
- ✅ Auditável

## 🚀 Implementação

Vou criar agora:
1. ✅ Schema Prisma atualizado
2. ✅ Rotas de autenticação
3. ✅ Telas de cadastro/login
4. ✅ Integração com Qubic

---

**Decisão Final**: Cadastro na nossa infra + Carteira Qubic automática ✅
