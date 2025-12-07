# 🔐 Instalação - Sistema de Autenticação

## 📦 Dependências Necessárias

Execute no backend:

```bash
cd backend

# Instalar dependências de autenticação
npm install bcryptjs jsonwebtoken
npm install --save-dev @types/bcryptjs @types/jsonwebtoken

# Regenerar Prisma Client
npx prisma generate
```

## 🗄️ Migração do Banco de Dados

```bash
# Criar migration
npx prisma migrate dev --name add-auth-and-qubic

# Ou resetar banco (CUIDADO: apaga dados!)
npx prisma migrate reset
```

## ⚙️ Variáveis de Ambiente

Adicione ao `backend/.env`:

```env
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/qubix?schema=public"

# JWT
JWT_SECRET="your-super-secret-jwt-key-change-in-production"

# Qubic
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org
QUBIC_PLATFORM_SEED=your-platform-seed-here
QUBIC_PLATFORM_ADDRESS=your-platform-identity-here
```

## 🚀 Testar Autenticação

```bash
# 1. Iniciar backend
npm run dev

# 2. Testar registro (em outro terminal)
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "senha123",
    "name": "Test User",
    "type": "CONSUMER"
  }'

# 3. Testar login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "senha123"
  }'
```

## ✅ Checklist

- [ ] Dependências instaladas
- [ ] Prisma Client gerado
- [ ] Migration executada
- [ ] Variáveis de ambiente configuradas
- [ ] Backend rodando
- [ ] Teste de registro funcionando
- [ ] Teste de login funcionando
