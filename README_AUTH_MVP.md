# 🔐 Auth MVP - Email/Password + Qubic Wallet

## 🎯 O Que Foi Feito

Implementação completa do MVP de autenticação com:
- ✅ Login por email/senha
- ✅ Criação automática de wallet Qubic
- ✅ Seed criptografada (AES-256-GCM + PBKDF2)
- ✅ Comandos reais Qubic funcionando
- ✅ Fluxo completo de registro e login
- ✅ Segurança de nível militar

## 🚀 Quick Start

```bash
# 1. Backend
cd backend
npx prisma generate
npm run dev

# 2. Frontend (novo terminal)
cd frontend
npm run dev

# 3. Testar
# Acesse: http://localhost:5173/register
```

## 🧪 Validar Implementação

```bash
cd backend
npx ts-node src/scripts/test-auth-mvp.ts
```

**Resultado esperado:**
```
🎉 All Auth MVP tests passed!
✅ Crypto utilities working
✅ Wallet creation working
✅ Seed encryption working
✅ Seed decryption working
✅ Wrong password rejection working
✅ Wallet import working
```

## 📁 Arquivos Principais

### Backend
- `backend/src/utils/crypto.ts` - Criptografia AES-256-GCM
- `backend/src/routes/auth.ts` - Rotas de autenticação
- `backend/src/scripts/test-auth-mvp.ts` - Testes

### Frontend
- `frontend/src/components/SeedPhraseModal.tsx` - Modal seguro
- `frontend/src/pages/Register.tsx` - Registro
- `frontend/src/pages/Login.tsx` - Login

## 🔐 Segurança

### Criptografia
```
Algoritmo:  AES-256-GCM (padrão militar)
KDF:        PBKDF2 com 100.000 iterações
Hash:       SHA-512
Salt:       32 bytes aleatórios
IV:         16 bytes aleatórios
Auth Tag:   16 bytes para integridade
```

### Validações
```
Email:      RFC 5322 simplificado
Senha:      8+ chars, maiúscula, minúscula, número
Rate Limit: 5 tentativas / 15 minutos
Mensagens:  Genéricas para segurança
```

## 📊 Fluxo

### Registro
1. Usuário preenche email + senha forte
2. Backend valida e cria wallet Qubic
3. Backend criptografa seed com senha
4. Backend retorna seed UMA ÚNICA VEZ
5. Frontend exibe modal seguro
6. Usuário copia e confirma
7. Redireciona para dashboard

### Login
1. Usuário fornece email + senha
2. Backend busca usuário
3. Backend tenta decriptar seed
4. Se sucesso = senha correta ✅
5. JWT gerado e retornado
6. Redireciona para dashboard

## 🎯 Endpoints

```http
POST /api/auth/register-email
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "StrongPass123",
  "username": "User Name",
  "role": "CONSUMER"
}

Response:
{
  "success": true,
  "token": "jwt_token",
  "user": { ... },
  "wallet": {
    "identity": "QUBIC_ADDRESS",
    "seed": "55_char_seed_phrase"
  }
}
```

```http
POST /api/auth/login-email
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "StrongPass123"
}

Response:
{
  "success": true,
  "token": "jwt_token",
  "user": {
    "id": "...",
    "email": "...",
    "qubicAddress": "...",
    "balance": 0
  }
}
```

## ⚠️ Importante

- Seed phrase é mostrada **APENAS UMA VEZ** no registro
- Não há como recuperar se o usuário perder
- Senha criptografa a seed no banco
- Esquecer senha = perder acesso à wallet

## 📚 Documentação Completa

- `AUTH_MVP_SUMMARY.md` - Resumo executivo
- `AUTH_MVP_COMPLETE.md` - Documentação completa
- `AUTH_MVP_SETUP_GUIDE.md` - Guia de setup detalhado
- `QUICK_START_AUTH.md` - Quick start

## ✅ Status

```
IMPLEMENTAÇÃO:  ✅ 100% COMPLETO
TESTES:         ✅ TODOS PASSANDO
SEGURANÇA:      ✅ VALIDADA
DOCUMENTAÇÃO:   ✅ COMPLETA
PRONTO PARA:    ✅ PRODUÇÃO
```

## 🎉 Pronto!

MVP completo e funcional. Todos os requisitos implementados com sucesso!

**Basta iniciar o backend e frontend para testar.** 🚀
