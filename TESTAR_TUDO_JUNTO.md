# 🚀 Como Testar Tudo Junto - Frontend + Backend

## ✅ Status Atual

- ✅ **Frontend**: Rodando em http://localhost:3001/
- ⏳ **Backend**: Precisa iniciar
- ⏳ **Banco**: Precisa configurar

## 🎯 Opções de Teste

### Opção 1: Teste Rápido (Sem Banco) ⭐ RECOMENDADO

Teste o frontend visualmente sem precisar de banco de dados.

```bash
# Frontend já está rodando em http://localhost:3001/

# Acesse no navegador:
1. http://localhost:3001/login
2. http://localhost:3001/register

# Você verá as telas, mas não conseguirá criar conta ainda
# (precisa do backend rodando)
```

### Opção 2: Teste com Backend Mock

Teste com backend rodando, mas sem banco de dados real.

```bash
# Terminal 1: Frontend (já rodando)
cd frontend
npm run dev
# Rodando em http://localhost:3001/

# Terminal 2: Backend Mock
cd backend
npm run test:auth
# Testa autenticação sem banco
```

### Opção 3: Teste Completo (Com Banco) 🎯

Teste completo com frontend + backend + banco de dados.

#### Passo 1: Configurar Banco (Escolha uma opção)

**Opção A: Docker (Mais Rápido)**
```bash
docker run --name qubix-postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=qubix \
  -p 5432:5432 \
  -d postgres:15
```

**Opção B: PostgreSQL Local**
```bash
# Instalar PostgreSQL
# Windows: https://www.postgresql.org/download/windows/
# Linux: sudo apt-get install postgresql
# Mac: brew install postgresql

# Criar banco
psql -U postgres
CREATE DATABASE qubix;
\q
```

**Opção C: Supabase (Cloud Grátis)**
```bash
# 1. Criar conta em https://supabase.com
# 2. Criar projeto
# 3. Copiar connection string
# 4. Atualizar backend/.env
```

#### Passo 2: Configurar .env

Edite `backend/.env`:
```env
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/qubix?schema=public"
JWT_SECRET="qubix-super-secret-jwt-key-change-in-production-2024"
```

#### Passo 3: Rodar Migration

```bash
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
npx prisma generate
```

#### Passo 4: Iniciar Backend

```bash
# Terminal 2 (novo)
cd backend
npm run dev
# Rodando em http://localhost:3000/
```

#### Passo 5: Testar no Navegador

```
1. Acesse: http://localhost:3001/register

2. Preencha:
   - Nome: Test User
   - Email: test@example.com
   - Senha: senha123
   - Tipo: Consumer

3. Clique em "Create Account"

4. Você verá:
   ✅ Conta criada
   ✅ Carteira Qubic criada
   ✅ Identity e Seed exibidos
   ⚠️  Aviso para guardar seed

5. Confirme e vá para dashboard

6. Teste login:
   - Volte para /login
   - Email: test@example.com
   - Senha: senha123
   - Clique em "Sign In"
   - Deve ir para dashboard
```

## 📊 Fluxo Visual Completo

```
┌─────────────────────────────────────────────────────────────┐
│                    TESTE COMPLETO                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Frontend (http://localhost:3001/)                      │
│     ├─ /login        → Tela de login                       │
│     ├─ /register     → Tela de cadastro                    │
│     └─ /dashboard    → Dashboard (protegido)               │
│                                                             │
│  2. Backend (http://localhost:3000/)                       │
│     ├─ POST /api/auth/register → Criar conta              │
│     ├─ POST /api/auth/login    → Login                    │
│     └─ GET  /api/auth/me       → Dados do usuário         │
│                                                             │
│  3. Banco de Dados (PostgreSQL)                            │
│     ├─ User          → Usuários                            │
│     ├─ Job           → Jobs                                │
│     └─ Transaction   → Transações Qubic                    │
│                                                             │
│  4. Qubic Blockchain                                       │
│     └─ Carteira criada automaticamente                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## 🧪 Checklist de Testes

### Teste Visual (Sem Backend)
- [ ] Acessar http://localhost:3001/
- [ ] Ver tela de login
- [ ] Clicar em "Create one"
- [ ] Ver tela de registro
- [ ] Ver formulário completo
- [ ] Ver opções Consumer/Provider

### Teste com Backend Mock
- [ ] Rodar `npm run test:auth`
- [ ] Ver registro simulado
- [ ] Ver login simulado
- [ ] Ver JWT gerado
- [ ] Ver carteira Qubic criada

### Teste Completo
- [ ] Banco configurado
- [ ] Migration rodada
- [ ] Backend iniciado
- [ ] Frontend acessível
- [ ] Criar conta real
- [ ] Ver carteira Qubic
- [ ] Copiar/baixar seed
- [ ] Fazer login
- [ ] Acessar dashboard

## 🎬 Demonstração Passo a Passo

### 1. Iniciar Serviços

```bash
# Terminal 1: Frontend
cd frontend
npm run dev
# ✅ http://localhost:3001/

# Terminal 2: Backend (se tiver banco)
cd backend
npm run dev
# ✅ http://localhost:3000/
```

### 2. Testar Registro

```
1. Abra: http://localhost:3001/register

2. Preencha:
   Nome: João Silva
   Email: joao@example.com
   Senha: senha123
   Confirmar: senha123
   Tipo: Consumer

3. Clique: "Create Account"

4. Aguarde...

5. Veja tela de sucesso:
   ✅ Conta criada!
   🔑 Identity: UAUVFILKHPAXXDAJWDMMSMPSTYODRQYUQMKFMXIXKEKIIJSNLSSOVICABNAH
   🔐 Seed: tbpdaldakphcdycuiipl...
   
6. Copie o seed!

7. Marque: "I have saved my seed phrase"

8. Clique: "Continue to Dashboard"

9. Veja: Dashboard do Qubix
```

### 3. Testar Login

```
1. Abra nova aba: http://localhost:3001/login

2. Preencha:
   Email: joao@example.com
   Senha: senha123

3. Clique: "Sign In"

4. Veja: Dashboard do Qubix
```

## 🔍 Verificar Funcionamento

### No Navegador (F12)

```javascript
// Console do navegador

// Verificar token
localStorage.getItem('token')
// Deve retornar: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

// Verificar usuário
JSON.parse(localStorage.getItem('user'))
// Deve retornar: { id, email, name, qubicIdentity, ... }

// Limpar (logout)
localStorage.clear()
```

### Network Tab

```
1. Abra F12 → Network

2. Faça registro

3. Veja request:
   POST http://localhost:3000/api/auth/register
   Status: 201 Created
   Response: { token, user, wallet }

4. Faça login

5. Veja request:
   POST http://localhost:3000/api/auth/login
   Status: 200 OK
   Response: { token, user }
```

## 🚨 Troubleshooting

### Frontend não carrega
```bash
# Verificar se está rodando
cd frontend
npm run dev

# Acessar URL correta
http://localhost:3001/
```

### Backend não responde
```bash
# Verificar se está rodando
cd backend
npm run dev

# Verificar porta
http://localhost:3000/
```

### Erro de CORS
```
Causa: Backend não configurado para aceitar frontend
Solução: Backend já tem CORS configurado
```

### Erro de banco
```
Causa: PostgreSQL não está rodando
Solução: Iniciar PostgreSQL ou usar Docker
```

### Token inválido
```
Causa: Token expirado ou inválido
Solução: Fazer logout e login novamente
localStorage.clear()
```

## 📚 Documentação Relacionada

- `FRONTEND_RODANDO.md` - Frontend em detalhes
- `MODELO_RODADO_SUCESSO.md` - Backend testado
- `SETUP_BANCO_DADOS.md` - Configurar banco
- `SISTEMA_CADASTRO_COMPLETO.md` - Sistema completo

## ✅ Resumo

### O que está pronto:
- ✅ Frontend rodando (http://localhost:3001/)
- ✅ Páginas de login e registro
- ✅ Rotas configuradas
- ✅ Proteção de rotas
- ✅ Backend implementado
- ✅ Integração Qubic
- ✅ Testes mock funcionando

### O que precisa:
- ⏳ Banco de dados configurado
- ⏳ Backend rodando
- ⏳ Teste completo

### Como testar agora:
```bash
# Opção 1: Visual (sem backend)
Acesse: http://localhost:3001/

# Opção 2: Mock (sem banco)
cd backend && npm run test:auth

# Opção 3: Completo (com banco)
1. Configurar PostgreSQL
2. Rodar migration
3. Iniciar backend
4. Testar no navegador
```

---

**🎉 Tudo pronto para testar!**

**Recomendação**: Comece com Opção 1 (visual) para ver as telas, depois configure o banco para teste completo!
