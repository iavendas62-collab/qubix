# 🚀 Qibux Servers - Servidores Separados

> **Estrutura organizada com frontend e backend independentes**

Esta pasta contém os servidores Qibux organizados em projetos separados para facilitar desenvolvimento e manutenção.

---

## 📁 Estrutura

```
qibux-servers/
├── qibux-frontend/          # React App (porta 3000)
├── qibux-backend/           # API Node.js (porta 3006)
├── start-both-servers.bat   # Script para iniciar ambos
├── .gitignore              # Git ignore limpo
└── README.md               # Este arquivo
```

---

## 🚀 Como Usar

### **Opção 1: Iniciar Ambos Automaticamente**
```bash
# Executa npm install e npm run dev em ambos os projetos
./start-both-servers.bat
```

### **Opção 2: Iniciar Manualmente**

#### **Backend (Terminal 1):**
```bash
cd qibux-backend
npm install
npm run dev
```
**URL:** http://localhost:3006

#### **Frontend (Terminal 2):**
```bash
cd qibux-frontend
npm install
npm run dev
```
**URL:** http://localhost:3000

---

## 🔧 Funcionalidades Disponíveis

### **Dashboard Qubic Status**
- URL: `http://localhost:3000/qubic-status`
- Mostra integração completa com blockchain Qubic
- 4/4 sistemas funcionando (RPC, Wallet, Balance, Escrow)

### **Job Submission**
- Submissão de trabalhos de IA/ML
- Criação automática de escrow
- Redução de saldo da wallet em tempo real

### **Wallet Management**
- Geração de endereços Qubic válidos
- Consulta de saldos reais na blockchain
- Histórico de transações persistente

### **Painel de Instâncias**
- Visão geral de todos os trabalhos
- Monitorização em tempo real
- Controles de trabalho

---

## 🛠️ Desenvolvimento

### **Frontend (qibux-frontend)**
- **Framework:** React + TypeScript
- **Styling:** Tailwind CSS
- **Roteamento:** React Router
- **API:** Axios para comunicação com backend

### **Backend (qibux-backend)**
- **Runtime:** Node.js + Express
- **Blockchain:** Integração Qubic (real/simulada)
- **Database:** Mock data + localStorage
- **WebSocket:** Tempo real para métricas

---

## 🎯 Demonstração

1. **Inicie os servidores** com `./start-both-servers.bat`
2. **Abra** `http://localhost:3000/qubic-status`
3. **Veja** 4/4 sistemas funcionando ✅
4. **Teste** job submission e wallet
5. **Explore** o painel de instâncias

---

## 📦 O Que Está Incluído

### **✅ Frontend Completo:**
- Todas as páginas e componentes
- Integração com APIs Qubic
- Dashboard e painéis funcionais
- Sistema de autenticação

### **✅ Backend Completo:**
- Todas as rotas da API
- Serviços Qubic (real/simulado)
- Mock server com dados de teste
- WebSocket para tempo real

### **✅ Configuração Completa:**
- Scripts de inicialização
- Arquivos de configuração
- Dependências organizadas
- Ambiente de desenvolvimento pronto

---

## 🚀 **Deploy no Vercel**

Para colocar online, siga o guia completo:

📖 **[DEPLOY-VERCEL.md](DEPLOY-VERCEL.md)** - Guia passo-a-passo

### **Deploy Rápido:**
1. **Frontend:** Importe `qibux-frontend` no Vercel
2. **Backend:** Use Railway ou Render para Node.js
3. **Conecte:** Atualize URLs no frontend
4. **🎉 Online!**

---

## 🚀 Pronto para Desenvolvimento!

**Estrutura limpa e organizada para desenvolvimento independente de frontend e backend.**

**Pronto para deploy no Vercel!** 🌐
