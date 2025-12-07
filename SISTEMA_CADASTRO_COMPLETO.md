# 🎯 Sistema de Cadastro Completo - Qubix + Qubic

## ✅ Decisão de Arquitetura

**Cadastro na nossa infra (Qubix) + Carteira Qubic automática**

### Por quê?
- ✅ UX simples e familiar (email/senha)
- ✅ Recuperação de senha possível
- ✅ Controle total dos dados
- ✅ Carteira Qubic criada automaticamente
- ✅ Pagamentos descentralizados via Qubic

## 📁 Arquivos Criados

### Backend
1. ✅ `backend/prisma/schema.prisma` - Schema atualizado com User, Job, Transaction
2. ✅ `backend/src/routes/auth.ts` - Rotas de autenticação
3. ✅ `INSTALACAO_AUTH.md` - Guia de instalação

### Frontend
1. ✅ `frontend/src/pages/Register.tsx` - Tela de cadastro
2. ✅ `frontend/src/pages/Login.tsx` - Tela de login

### Documentação
1. ✅ `ARQUITETURA_CADASTRO_QUBIX.md` - Arquitetura detalhada
2. ✅ `SISTEMA_CADASTRO_COMPLETO.md` - Este documento

## 🚀 Como Implementar

### Passo 1: Instalar Dependências

```bash
cd backend

# Dependências de autenticação
npm install bcryptjs jsonwebtoken
npm install --save-dev @types/bcryptjs @types/jsonwebtoken

# Regenerar Prisma Client
npx prisma generate
```

### Passo 2: Configurar Banco de Dados

```bash
# Criar migration
npx prisma migrate dev --name add-auth-and-qubic
```

### Passo 3: Configurar Variáveis de Ambiente

Edite `backend/.env`:

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

### Passo 4: Atualizar Backend Index

Edite `backend/src/index.ts` para adicionar rota de auth:

```typescript
import authRoutes from './routes/auth';

// ...

app.use('/api/auth', authRoutes);
```

### Passo 5: Atualizar Frontend Routes

Edite `frontend/src/App.tsx` para adicionar rotas:

```typescript
import { Register } from './pages/Register';
import { Login } from './pages/Login';

// ...

<Route path="/register" element={<Register />} />
<Route path="/login" element={<Login />} />
```

## 🎨 Fluxo do Usuário

### 1. Cadastro

```
Usuário acessa /register
    ↓
Preenche: nome, email, senha, tipo (consumer/provider)
    ↓
Backend cria:
  - Usuário no PostgreSQL
  - Carteira Qubic automaticamente
    ↓
Retorna:
  - JWT token
  - Dados do usuário
  - Identity + Seed da carteira
    ↓
Frontend mostra tela de aviso:
  "⚠️ Guarde seu seed em local seguro!"
    ↓
Usuário confirma e vai para dashboard
```

### 2. Login

```
Usuário acessa /login
    ↓
Preenche: email, senha
    ↓
Backend valida e retorna:
  - JWT token
  - Dados do usuário
  - Saldo Qubic (opcional)
    ↓
Usuário vai para dashboard
```

### 3. Criar Job

```
Usuário logado cria job
    ↓
Sistema usa identity salva no banco
    ↓
Cria job com status PENDING_PAYMENT
    ↓
Instrui pagamento via Qubic
    ↓
Monitora transação
    ↓
Libera job quando confirmado
```

## 📊 Estrutura do Banco

### User
```typescript
{
  id: string
  email: string
  password: string (hash)
  name: string
  type: 'CONSUMER' | 'PROVIDER'
  qubicIdentity: string  // Salvo no banco
  // seed NUNCA é salvo!
}
```

### Job
```typescript
{
  id: string
  consumerId: string
  providerId: string
  price: number
  status: 'PENDING_PAYMENT' | 'PAYMENT_LOCKED' | 'PROCESSING' | 'COMPLETED' | 'PAID'
  escrowTxHash: string   // TX de lock
  paymentTxHash: string  // TX de release
}
```

### QubicTransaction
```typescript
{
  id: string
  txHash: string
  from: string  // Qubic identity
  to: string    // Qubic identity
  amount: number
  type: 'ESCROW_LOCK' | 'PAYMENT_RELEASE' | 'REFUND'
  status: 'PENDING' | 'CONFIRMED' | 'FAILED'
}
```

## 🔐 Segurança

### O que salvamos:
- ✅ Identity (pública) - Pode ser salva
- ✅ Email/Senha (hash) - Nossa autenticação
- ✅ Histórico de transações
- ❌ Seed - NUNCA salvar!

### Como proteger o Seed:
1. Retornar UMA VEZ no cadastro
2. Mostrar aviso grande
3. Permitir copiar/baixar
4. Usuário deve guardar com segurança
5. Não conseguimos recuperar se perder

## 🧪 Testar

### 1. Testar Backend

```bash
cd backend
npm run dev

# Em outro terminal
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "senha123",
    "name": "Test User",
    "type": "CONSUMER"
  }'
```

### 2. Testar Frontend

```bash
cd frontend
npm run dev

# Acesse:
# http://localhost:5173/register
# http://localhost:5173/login
```

## 📋 Checklist de Implementação

### Backend
- [ ] Instalar bcryptjs e jsonwebtoken
- [ ] Atualizar schema.prisma
- [ ] Criar migration
- [ ] Criar routes/auth.ts
- [ ] Adicionar rota no index.ts
- [ ] Configurar .env
- [ ] Testar registro
- [ ] Testar login

### Frontend
- [ ] Criar pages/Register.tsx
- [ ] Criar pages/Login.tsx
- [ ] Adicionar rotas no App.tsx
- [ ] Testar fluxo de cadastro
- [ ] Testar fluxo de login
- [ ] Testar salvamento de seed

### Integração
- [ ] Testar criação de carteira no cadastro
- [ ] Testar consulta de saldo no login
- [ ] Testar criação de job com identity
- [ ] Testar fluxo de pagamento completo

## 🎯 Próximos Passos

1. **Agora**: Implementar sistema de cadastro
2. **Hoje**: Testar fluxo completo
3. **Amanhã**: Integrar com jobs
4. **Esta semana**: Implementar escrow real
5. **Próxima semana**: Deploy e testes na testnet

## 💡 Dicas

### Para Desenvolvimento
- Use seeds de teste na testnet
- Implemente logs detalhados
- Teste recuperação de senha
- Valide todos os inputs

### Para Produção
- Use JWT_SECRET forte
- Implemente rate limiting
- Adicione 2FA (opcional)
- Monitore tentativas de login
- Backup do banco regularmente

## 📚 Documentação Relacionada

- `ARQUITETURA_CADASTRO_QUBIX.md` - Arquitetura detalhada
- `INSTALACAO_AUTH.md` - Guia de instalação
- `GUIA_TESTE_QUBIX.md` - Como testar
- `backend/GUIA_RAPIDO_QUBIC.md` - Integração Qubic

---

**🎉 Sistema de cadastro completo e pronto para implementar!**

**Resumo**: Fazemos cadastro na nossa infra (email/senha) e criamos carteira Qubic automaticamente. Melhor dos dois mundos! ✅
