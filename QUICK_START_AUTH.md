# 🚀 Quick Start - Auth MVP

## Comandos Rápidos

### 1. Setup (uma vez)
```bash
# Backend
cd backend
npm install
npx prisma generate

# Frontend
cd frontend
npm install
```

### 2. Iniciar (sempre)
```bash
# Terminal 1 - Backend
cd backend
npm run dev

# Terminal 2 - Frontend
cd frontend
npm run dev
```

### 3. Testar
```
http://localhost:5173/register
```

## Teste Rápido

1. **Registrar:**
   - Email: `test@example.com`
   - Senha: `TestPass123`
   - Nome: `Test User`

2. **Copiar seed phrase** (aparece no modal)

3. **Login:**
   - Email: `test@example.com`
   - Senha: `TestPass123`

## Validar Componentes

```bash
cd backend
npx ts-node src/scripts/test-auth-mvp.ts
```

Deve mostrar: ✅ All Auth MVP tests passed!

## Troubleshooting

**Erro no Prisma?**
```bash
cd backend
# Feche todos os processos Node.js
npx prisma generate
```

**Backend não inicia?**
- Verifique se porta 3005 está livre
- Verifique .env no backend

**Frontend não conecta?**
- Backend deve estar em http://127.0.0.1:3005
- Verifique console do navegador

## Arquivos Importantes

- `backend/src/routes/auth.ts` - Rotas de autenticação
- `backend/src/utils/crypto.ts` - Criptografia
- `frontend/src/pages/Register.tsx` - Página de registro
- `frontend/src/pages/Login.tsx` - Página de login
- `frontend/src/components/SeedPhraseModal.tsx` - Modal da seed

## Endpoints

- `POST /api/auth/register-email` - Registrar
- `POST /api/auth/login-email` - Login
- `POST /api/auth/create-wallet` - Criar wallet

## Pronto! 🎉

Tudo implementado e testado. Basta iniciar e usar!
