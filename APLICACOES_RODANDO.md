# 🚀 Aplicações Rodando

## ✅ Status

### Backend
- **Status:** ✅ RODANDO
- **URL:** http://127.0.0.1:3005
- **Process ID:** 33

### Frontend
- **Status:** ✅ RODANDO
- **URL:** http://localhost:3000
- **Process ID:** 34

## 🔗 Links de Acesso

### Páginas Principais
- **Landing Page:** http://localhost:3000/
- **Registro:** http://localhost:3000/register
- **Login:** http://localhost:3000/login
- **Dashboard:** http://localhost:3000/select-profile

### Endpoints da API
- **Health Check:** http://127.0.0.1:3005/api/health
- **Criar Wallet:** POST http://127.0.0.1:3005/api/auth/create-wallet
- **Registrar:** POST http://127.0.0.1:3005/api/auth/register-email
- **Login:** POST http://127.0.0.1:3005/api/auth/login-email

## 🧪 Testar Agora

### 1. Abrir no Navegador
```
http://localhost:3000/register
```

### 2. Registrar Novo Usuário
- **Nome:** Test User
- **Email:** test@example.com
- **Senha:** TestPass123
- **Confirmar Senha:** TestPass123
- **Tipo:** Consumer ou Provider

### 3. Copiar Seed Phrase
- Modal aparecerá automaticamente
- Copiar e guardar em local seguro
- Marcar checkbox "já salvei"
- Clicar em "Continue to Dashboard"

### 4. Fazer Login
```
http://localhost:3000/login
```
- **Email:** test@example.com
- **Senha:** TestPass123

## 📊 Monitorar Logs

### Backend
```bash
# Ver logs em tempo real
# Os logs aparecem automaticamente no terminal
```

### Frontend
```bash
# Ver logs no navegador
# Abrir DevTools (F12) → Console
```

## 🛑 Parar Aplicações

Se precisar parar:
```bash
# No terminal onde está rodando, pressione:
Ctrl + C
```

Ou use o Kiro para parar os processos.

## ⚠️ Avisos

### Redis
- Backend mostra erro de Redis (não crítico)
- Sistema funciona sem Redis
- Para produção, configure Redis no .env

### Heartbeat
- Mensagens de heartbeat 404 são normais
- Ocorrem quando não há providers conectados

### Rate Limiting
- Login: 5 tentativas / 15 minutos
- Se exceder, aguarde ou reinicie backend

## 🎯 Próximos Passos

1. **Testar Registro:**
   - Acesse http://localhost:3000/register
   - Crie uma conta
   - Copie a seed phrase

2. **Testar Login:**
   - Acesse http://localhost:3000/login
   - Faça login com as credenciais

3. **Explorar Dashboard:**
   - Após login, explore as funcionalidades
   - Consumer: submeter jobs
   - Provider: registrar hardware

## 🔧 Troubleshooting

### Frontend não carrega?
- Verifique se está em http://localhost:3000
- Limpe cache do navegador (Ctrl + Shift + R)
- Verifique console do navegador (F12)

### Backend não responde?
- Verifique se está em http://127.0.0.1:3005
- Teste: http://127.0.0.1:3005/api/health
- Verifique logs no terminal

### Erro ao registrar?
- Verifique se senha tem 8+ caracteres
- Senha deve ter maiúscula, minúscula e número
- Exemplo válido: TestPass123

### Modal da seed não aparece?
- Verifique console do navegador (F12)
- Pode haver erro de validação
- Tente registrar novamente

## 📝 Notas

- ✅ Backend rodando na porta 3005
- ✅ Frontend rodando na porta 3000
- ✅ Hot reload ativo (mudanças aplicadas automaticamente)
- ✅ Auth MVP completo e funcional
- ✅ Wallet Qubic criada automaticamente
- ✅ Seed criptografada com segurança

## 🎉 Pronto para Usar!

Ambas as aplicações estão rodando e prontas para teste.

**Comece agora:** http://localhost:3000/register
