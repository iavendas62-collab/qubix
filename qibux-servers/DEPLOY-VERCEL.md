# 🚀 Deploy Qibux no Vercel

> **Guia completo para deploy do Qibux Compute Marketplace no Vercel**

---

## 📋 **Pré-requisitos**

- Conta no [Vercel](https://vercel.com)
- GitHub/GitLab account
- Node.js 18+ instalado localmente

---

## 🎯 **Passo 1: Deploy do Frontend (React)**

### **1.1 Conectar Repositório**
1. Acesse [vercel.com](https://vercel.com)
2. Clique **"New Project"**
3. Importe seu repositório Git
4. Selecione a pasta `qibux-servers/qibux-frontend`

### **1.2 Configurar Build**
O Vercel detectará automaticamente as configurações do `vercel.json`:

```json
{
  "framework": null,
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm install",
  "devCommand": "npm run dev",
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
```

### **1.3 Configurar Environment Variables**
No Vercel Dashboard, adicione as variáveis:

```
VITE_API_URL=https://your-backend-url.vercel.app/api
VITE_WS_URL=wss://your-backend-url.vercel.app
VITE_QUBIC_NETWORK=mainnet
VITE_QUBIC_RPC_URL=https://rpc.qubic.org
```

### **1.4 Deploy**
1. Clique **"Deploy"**
2. Aguarde o build (2-3 minutos)
3. ✅ Frontend estará online!

---

## 🔧 **Passo 2: Deploy do Backend (Node.js)**

### **Opção A: Vercel Serverless (Recomendado)**

1. **Criar novo projeto** no Vercel
2. **Selecionar pasta:** `qibux-servers/qibux-backend`
3. **Configurar build:**
   ```json
   {
     "framework": null,
     "buildCommand": "npm run build",
     "installCommand": "npm install",
     "devCommand": "npm run dev"
   }
   ```
4. **Environment Variables:**
   ```
   NODE_ENV=production
   PORT=3006
   ```

### **Opção B: Railway (Alternativa)**
1. Acesse [railway.app](https://railway.app)
2. **"New Project"** → **"Deploy from GitHub"**
3. Selecione pasta `qibux-servers/qibux-backend`
4. Railway detectará automaticamente Node.js
5. **Environment Variables:**
   ```
   NODE_ENV=production
   PORT=3006
   ```

### **Opção C: Render**
1. Acesse [render.com](https://render.com)
2. **"New"** → **"Web Service"**
3. Conecte seu repositório
4. **Build Command:** `npm install`
5. **Start Command:** `npm run dev`
6. **Environment:** `NODE_ENV=production`

---

## 🔗 **Passo 3: Conectar Frontend ao Backend**

### **Atualizar URLs no Frontend**
Após deploy do backend, atualize as variáveis no Vercel:

```
VITE_API_URL=https://your-backend-app.vercel.app/api
VITE_WS_URL=wss://your-backend-app.vercel.app
```

### **Re-deploy Frontend**
1. Vá para o projeto frontend no Vercel
2. **"Deployments"** → **"Redeploy"**
3. Ou faça push no Git para trigger automático

---

## 🌐 **URLs de Produção**

Após deploy, você terá:

- **Frontend:** `https://your-frontend-app.vercel.app`
- **Backend:** `https://your-backend-app.vercel.app`

### **Páginas Importantes:**
- **Dashboard:** `https://your-frontend-app.vercel.app/qubic-status`
- **API Health:** `https://your-backend-app.vercel.app/health`
- **API Docs:** `https://your-backend-app.vercel.app/api/qubic/status`

---

## ⚙️ **Configurações Avançadas**

### **Custom Domain**
1. No Vercel Dashboard → **"Settings"** → **"Domains"**
2. Adicione seu domínio personalizado
3. Configure DNS conforme instruções

### **Environment Variables**
```bash
# Produção
NODE_ENV=production
VITE_API_URL=https://api.yourdomain.com/api
VITE_WS_URL=wss://api.yourdomain.com

# Desenvolvimento
NODE_ENV=development
VITE_API_URL=http://localhost:3006/api
VITE_WS_URL=ws://localhost:3006
```

### **CORS Configuration**
Para produção, configure CORS no backend:

```javascript
const corsOptions = {
  origin: ['https://your-frontend-app.vercel.app'],
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
};
```

---

## 🧪 **Teste em Produção**

### **1. Testar Frontend**
```bash
curl https://your-frontend-app.vercel.app
# Deve retornar HTML do React
```

### **2. Testar API**
```bash
curl https://your-backend-app.vercel.app/health
# Deve retornar: {"status":"ok"}
```

### **3. Testar Qubic Integration**
```bash
curl https://your-backend-app.vercel.app/api/qubic/status
# Deve retornar dados da blockchain
```

---

## 🚨 **Troubleshooting**

### **Build Falhando**
- Verifique se todas dependências estão em `package.json`
- Certifique-se que `build` script existe
- Verifique logs do build no Vercel

### **API não conecta**
- ✅ URLs corretas nas environment variables?
- ✅ Backend está rodando?
- ✅ CORS configurado?

### **WebSocket não funciona**
- ✅ Use `wss://` em produção
- ✅ Backend suporta WebSocket?
- ✅ Porta correta (80/443)?

---

## 📊 **Performance no Vercel**

### **Frontend (Static)**
- ⚡ **CDN Global** - Entrega ultra-rápida
- ⚡ **Edge Functions** - Próximo do usuário
- ⚡ **Auto-scaling** - Sem limites

### **Backend (Serverless)**
- ⚡ **Cold starts** - Primeiro request pode ser lento
- ⚡ **15min timeout** - Para operações longas
- ⚡ **Pay-per-use** - Custa apenas quando usado

---

## 🎉 **Deploy Completo!**

Após seguir estes passos, você terá:

✅ **Frontend React** rodando no Vercel
✅ **Backend Node.js** em produção
✅ **API Qubic** funcionando
✅ **WebSocket** conectado
✅ **URLs de produção** ativas

**🌟 Qibux agora está online e acessível globalmente!**

---

## 📞 **Suporte**

- **Vercel Docs:** https://vercel.com/docs
- **Qibux Issues:** Abra issue no repositório
- **Community:** Discord/Telegram do Qubic
