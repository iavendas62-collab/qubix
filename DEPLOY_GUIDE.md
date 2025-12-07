# 🚀 QUBIX Deploy Guide - Railway (Fácil)

## 📋 Pré-requisitos

1. **Conta Railway**: [railway.app](https://railway.app)
2. **GitHub Account**: Para conectar o repositório

## 🚀 Deploy em 5 Minutos

### 1. Fork & Clone
```bash
# Fork este repositório no GitHub
# Clone seu fork
git clone https://github.com/SEU_USERNAME/qubic-trading-sdk.git
cd qubic-trading-sdk
```

### 2. Railway Setup

#### A) Criar Projeto no Railway
1. Acesse [railway.app](https://railway.app)
2. Clique **"New Project"**
3. Selecione **"Deploy from GitHub repo"**
4. Conecte sua conta GitHub
5. Selecione o repositório `qubic-trading-sdk`

#### B) Configurar Banco PostgreSQL
1. No painel Railway, clique **"+ Add"**
2. Selecione **"Database"** → **"PostgreSQL"**
3. Railway criará automaticamente:
   - Host, Port, Database Name
   - Username, Password
   - DATABASE_URL

#### C) Configurar Variáveis de Ambiente
No painel Railway, vá para **"Variables"** do seu projeto:

```bash
# Database (já criado automaticamente)
DATABASE_URL=postgresql://...

# JWT Secret (gerar seguro)
JWT_SECRET=openssl rand -base64 64

# Qubic Network
QUBIC_NETWORK=mainnet
QUBIC_RPC_URL=https://rpc.qubic.org

# Opcionais
LOG_LEVEL=info
NODE_ENV=production
```

### 3. Deploy Automático

Railway detectará automaticamente:
- ✅ **railway.json** - Configuração de deploy
- ✅ **Dockerfile.prod** - Build otimizado
- ✅ **package.json** - Scripts de produção

**Deploy acontecerá automaticamente!**

### 4. Verificar Deploy

1. **URL da Aplicação**: Railway fornece automaticamente
2. **Health Check**: `https://your-app.railway.app/health`
3. **API**: `https://your-app.railway.app/api/stats`

## 🔧 Configuração Manual (Opcional)

Se precisar customizar, Railway permite:

### Custom Domain
```bash
# Settings → Domains
# Adicionar seu domínio
qubix.io
```

### Environment Variables Avançadas
```bash
# Para produção full
QUBIC_PLATFORM_SEED=YOUR_PLATFORM_SEED
QUBIC_PLATFORM_ADDRESS=YOUR_PLATFORM_ADDRESS
JWT_SECRET=YOUR_SECURE_JWT_SECRET
```

## 📊 Monitoramento

### Logs em Tempo Real
```bash
# Railway Dashboard → Deployments → View Logs
```

### Health Checks
- Railway monitora automaticamente `/health`
- Alerts se aplicação cair

### Database
- Railway PostgreSQL tem backup automático
- Monitor de performance incluído

## 💰 Custos Railway

### Free Tier (Perfeito para Teste)
- ✅ 512MB RAM
- ✅ 1GB Disk
- ✅ $5/mês crédito
- ⚠️ Sleeps after inactivity

### Hobby Plan ($5/mês)
- ✅ 1GB RAM
- ✅ 5GB Disk
- ✅ Sem sleep
- ✅ Custom domains

### Pro Plan ($10/mês)
- ✅ 2GB RAM
- ✅ 10GB Disk
- ✅ Redis incluído

## 🎯 URLs Após Deploy

```
Frontend: https://your-app.railway.app
API:      https://your-app.railway.app/api
Health:   https://your-app.railway.app/health
Stats:    https://your-app.railway.app/api/stats
```

## 🔍 Troubleshooting

### Build Falhando
```bash
# Verificar logs no Railway Dashboard
# Problemas comuns:
# - DATABASE_URL não setada
# - JWT_SECRET muito fraca
# - Porta conflitante (Railway usa $PORT)
```

### Database Connection
```bash
# Railway cria DATABASE_URL automaticamente
# Verificar se PostgreSQL está "healthy"
```

### Qubic API
```bash
# Em produção, usar mainnet
QUBIC_NETWORK=mainnet
QUBIC_RPC_URL=https://rpc.qubic.org
```

## 🎉 Pronto!

Seu app QUBIX estará online em:
**`https://your-app.railway.app`**

### Demo Credentials
- **demo@qubix.io** / demo123 (Consumer + Wallet)
- **provider@qubix.io** / provider123 (Provider)

---

**🚀 Deploy concluído em 5 minutos!**
