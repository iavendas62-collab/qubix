# Setup Manual do Supabase via Dashboard

Como você não consegue conectar via linha de comando (provavelmente rede IPv4-only), vamos configurar pelo Dashboard do Supabase.

## Passo 1: Acessar o SQL Editor

1. Acesse: https://supabase.com/dashboard
2. Selecione seu projeto
3. Vá em **SQL Editor** (ícone de banco de dados na lateral)

## Passo 2: Executar o SQL de Criação das Tabelas

Copie e cole o SQL abaixo no editor e clique em **RUN**:

```sql
-- ============================================
-- QUBIX DATABASE SCHEMA
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- ENUMS
-- ============================================

CREATE TYPE "Role" AS ENUM ('CONSUMER', 'PROVIDER', 'BOTH');
CREATE TYPE "ProviderType" AS ENUM ('BROWSER', 'NATIVE');
CREATE TYPE "JobStatus" AS ENUM ('PENDING', 'ASSIGNED', 'RUNNING', 'COMPLETED', 'FAILED', 'CANCELLED');
CREATE TYPE "TransactionType" AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'PAYMENT', 'REFUND', 'ESCROW_HOLD', 'ESCROW_RELEASE');
CREATE TYPE "TransactionStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED');

-- ============================================
-- TABLES
-- ============================================

-- Users Table
CREATE TABLE "User" (
    "id" TEXT PRIMARY KEY DEFAULT uuid_generate_v4()::TEXT,
    "qubicAddress" TEXT UNIQUE NOT NULL,
    "email" TEXT UNIQUE,
    "username" TEXT,
    "role" "Role" DEFAULT 'CONSUMER' NOT NULL,
    "balance" DOUBLE PRECISION DEFAULT 0 NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

-- Providers Table
CREATE TABLE "Provider" (
    "id" TEXT PRIMARY KEY DEFAULT uuid_generate_v4()::TEXT,
    "workerId" TEXT UNIQUE NOT NULL,
    "userId" TEXT NOT NULL,
    "qubicAddress" TEXT NOT NULL,
    "type" "ProviderType" NOT NULL,
    "name" TEXT,
    "gpuModel" TEXT NOT NULL,
    "gpuVram" DOUBLE PRECISION NOT NULL,
    "cpuModel" TEXT,
    "cpuCores" INTEGER,
    "ramTotal" DOUBLE PRECISION,
    "location" TEXT,
    "pricePerHour" DOUBLE PRECISION NOT NULL,
    "isOnline" BOOLEAN DEFAULT false NOT NULL,
    "isAvailable" BOOLEAN DEFAULT true NOT NULL,
    "totalEarnings" DOUBLE PRECISION DEFAULT 0 NOT NULL,
    "totalJobs" INTEGER DEFAULT 0 NOT NULL,
    "registeredAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastHeartbeat" TIMESTAMP(3),
    CONSTRAINT "Provider_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE
);

-- Provider Metrics Table
CREATE TABLE "ProviderMetric" (
    "id" TEXT PRIMARY KEY DEFAULT uuid_generate_v4()::TEXT,
    "providerId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "cpuPercent" DOUBLE PRECISION,
    "ramPercent" DOUBLE PRECISION,
    "gpuPercent" DOUBLE PRECISION,
    "gpuTemp" DOUBLE PRECISION,
    "gpuMemUsed" DOUBLE PRECISION,
    CONSTRAINT "ProviderMetric_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES "Provider"("id") ON DELETE CASCADE
);

-- Jobs Table
CREATE TABLE "Job" (
    "id" TEXT PRIMARY KEY DEFAULT uuid_generate_v4()::TEXT,
    "userId" TEXT NOT NULL,
    "providerId" TEXT,
    "modelType" TEXT NOT NULL,
    "status" "JobStatus" DEFAULT 'PENDING' NOT NULL,
    "progress" INTEGER DEFAULT 0 NOT NULL,
    "inputData" JSONB,
    "outputData" JSONB,
    "estimatedCost" DOUBLE PRECISION NOT NULL,
    "actualCost" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "error" TEXT,
    CONSTRAINT "Job_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE,
    CONSTRAINT "Job_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES "Provider"("id") ON DELETE SET NULL
);

-- Transactions Table
CREATE TABLE "Transaction" (
    "id" TEXT PRIMARY KEY DEFAULT uuid_generate_v4()::TEXT,
    "userId" TEXT NOT NULL,
    "type" "TransactionType" NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" "TransactionStatus" DEFAULT 'PENDING' NOT NULL,
    "qubicTxHash" TEXT,
    "jobId" TEXT,
    "providerId" TEXT,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "completedAt" TIMESTAMP(3),
    "metadata" JSONB,
    CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE,
    CONSTRAINT "Transaction_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES "Job"("id") ON DELETE SET NULL,
    CONSTRAINT "Transaction_providerId_fkey" FOREIGN KEY ("providerId") REFERENCES "Provider"("id") ON DELETE SET NULL
);

-- ============================================
-- INDEXES
-- ============================================

CREATE INDEX "Provider_userId_idx" ON "Provider"("userId");
CREATE INDEX "Provider_qubicAddress_idx" ON "Provider"("qubicAddress");
CREATE INDEX "Provider_isOnline_isAvailable_idx" ON "Provider"("isOnline", "isAvailable");
CREATE INDEX "ProviderMetric_providerId_timestamp_idx" ON "ProviderMetric"("providerId", "timestamp");
CREATE INDEX "Job_userId_idx" ON "Job"("userId");
CREATE INDEX "Job_providerId_idx" ON "Job"("providerId");
CREATE INDEX "Job_status_idx" ON "Job"("status");
CREATE INDEX "Transaction_userId_idx" ON "Transaction"("userId");
CREATE INDEX "Transaction_jobId_idx" ON "Transaction"("jobId");
CREATE INDEX "Transaction_providerId_idx" ON "Transaction"("providerId");

-- ============================================
-- SEED DATA (Opcional)
-- ============================================

-- Criar usuário de teste
INSERT INTO "User" ("id", "qubicAddress", "username", "role", "balance", "updatedAt")
VALUES 
  ('test-user-1', 'TESTQUBICADDRESS1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ12345', 'demo_user', 'BOTH', 1000.0, CURRENT_TIMESTAMP);

-- Criar provider de teste
INSERT INTO "Provider" (
  "id", "workerId", "userId", "qubicAddress", "type", "name",
  "gpuModel", "gpuVram", "cpuModel", "cpuCores", "ramTotal",
  "location", "pricePerHour", "isOnline", "isAvailable", "updatedAt"
)
VALUES (
  'test-provider-1',
  'worker-demo-001',
  'test-user-1',
  'TESTQUBICADDRESS1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ12345',
  'NATIVE',
  'Demo GPU',
  'NVIDIA RTX 4090',
  24.0,
  'AMD Ryzen 9 5950X',
  16,
  64.0,
  'São Paulo, Brazil',
  1.5,
  true,
  true,
  CURRENT_TIMESTAMP
);

-- Verificar criação
SELECT 'Users' as table_name, COUNT(*) as count FROM "User"
UNION ALL
SELECT 'Providers', COUNT(*) FROM "Provider"
UNION ALL
SELECT 'Jobs', COUNT(*) FROM "Job"
UNION ALL
SELECT 'Transactions', COUNT(*) FROM "Transaction";
```

## Passo 3: Verificar se Funcionou

Você deve ver uma mensagem de sucesso e uma tabela mostrando:
```
table_name    | count
--------------+-------
Users         | 1
Providers     | 1
Jobs          | 0
Transactions  | 0
```

## Passo 4: Testar Conexão do Backend

Agora que as tabelas estão criadas, vamos testar se o backend consegue conectar:

```bash
cd backend
npm run dev
```

O backend deve iniciar e conectar ao Supabase!

## Passo 5: Verificar Dados via Supabase Dashboard

1. Vá em **Table Editor** no Supabase Dashboard
2. Você deve ver as tabelas: User, Provider, Job, Transaction, ProviderMetric
3. Clique em cada uma para ver os dados

## Alternativa: Usar Supabase Studio Local

Se preferir uma interface gráfica local:

```bash
cd backend
npx prisma studio
```

Isso abre uma interface web em `http://localhost:5555` onde você pode ver e editar os dados.

## Troubleshooting

### Erro: "relation already exists"
Se você já executou o SQL antes, delete as tabelas primeiro:

```sql
DROP TABLE IF EXISTS "Transaction" CASCADE;
DROP TABLE IF EXISTS "Job" CASCADE;
DROP TABLE IF EXISTS "ProviderMetric" CASCADE;
DROP TABLE IF EXISTS "Provider" CASCADE;
DROP TABLE IF EXISTS "User" CASCADE;
DROP TYPE IF EXISTS "TransactionStatus";
DROP TYPE IF EXISTS "TransactionType";
DROP TYPE IF EXISTS "JobStatus";
DROP TYPE IF EXISTS "ProviderType";
DROP TYPE IF EXISTS "Role";
```

Depois execute o SQL de criação novamente.

### Backend não conecta
Verifique se o .env está correto:
```env
DATABASE_URL="postgresql://postgres:%40Llplac1234@db.kkbvkjwhmstrapyzvfcw.supabase.co:6543/postgres?pgbouncer=true&connection_limit=1"
```

### Rede IPv4-only
Se você está em uma rede IPv4-only, o Supabase pode não funcionar. Opções:
1. Use um VPN
2. Configure IPv6 na sua rede
3. Use outro serviço de banco (Railway, Render, etc.)

## Próximos Passos

Depois que o banco estiver configurado:

1. **Iniciar Backend:**
   ```bash
   cd backend
   npm run dev
   ```

2. **Iniciar Frontend:**
   ```bash
   cd frontend
   npm run dev
   ```

3. **Testar o Sistema:**
   - Acesse http://localhost:5173
   - Faça login/registro
   - Adicione hardware como provider
   - Alugue GPU como consumer

## Deploy para Produção

Quando estiver pronto para produção:

1. **Railway (Recomendado):**
   - Conecte seu GitHub
   - Configure as variáveis de ambiente
   - Deploy automático

2. **Vercel (Frontend) + Railway (Backend):**
   - Frontend: `vercel --prod`
   - Backend: Deploy no Railway

3. **VPS (Controle Total):**
   - Siga o guia em PRODUCTION_SETUP.md
