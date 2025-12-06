# 🚀 Qibux Compute Marketplace

> **O Futuro da Computação Descentralizada Chegou.**

O Qibux não é apenas uma plataforma; é um mercado descentralizado e transparente que conecta utilizadores que precisam de poder computacional (como treino de modelos de IA, renderização ou simulações) com provedores de GPU globais. Alimentado pela tecnologia Qubic, oferecemos uma solução de computação eficiente, acessível e resistente à censura.

**Diga adeus à infraestrutura centralizada e aos custos imprevisíveis. Bem-vindo à era da computação peer-to-peer.**

---

## ✨ **Funcionalidades Principais**

### **Painel de Instâncias (My Instances)**
Visão geral de todos os trabalhos ativos, pendentes, concluídos e falhados.

### **Monitorização em Tempo Real**
Acompanhe o progresso exato em percentagem (%) de cada trabalho em execução.

### **Detalhes do Hardware**
Visualização da GPU (Modelo e VRAM) que está a executar o seu trabalho.

### **Estatísticas Rápidas**
Métricas de alto nível, incluindo o total de despesas e a contagem de trabalhos por estado.

### **Controlo de Trabalho**
Capacidade de lançar novos trabalhos ou parar instâncias em execução com um clique.

### **Sistema de Notificação**
Alertas de sucesso e erro para feedback imediato das ações da API.

---

## 🚀 **Como Usar**

### **Pré-requisitos**
- Node.js e npm instalados
- Um endereço Qubic (simulado pelo localStorage no modo de demonstração)

### **Instalação**

1. **Clone o repositório:**
```bash
git clone https://github.com/iavendas62-collab/qubix.git
cd qubix
```

2. **Instale as dependências:**
```bash
# Backend
cd qibux-backend && npm install

# Frontend
cd ../qibux-frontend && npm install
```

3. **Execute a aplicação:**
```bash
# Terminal 1 - Backend
cd qibux-backend && npm run dev

# Terminal 2 - Frontend
cd qibux-frontend && npm run dev
```

4. **Acesse:**
- Frontend: http://localhost:3000
- Backend: http://localhost:3006

---

## 🎯 **Funcionalidades da Demonstração**

### **Dashboard Qubic Status**
Mostra integração completa com blockchain Qubic - 4/4 sistemas funcionando.

### **Job Submission**
Submissão de trabalhos de IA/ML com criação automática de escrow.

### **Wallet Management**
Geração de endereços Qubic válidos e consulta de saldos reais.

### **Painel de Instâncias**
Visão completa de todos os trabalhos com monitorização em tempo real.

---

## 🛠️ **Arquitetura**

- **Frontend:** React + TypeScript + Vite
- **Backend:** Node.js + Express + TypeScript
- **Blockchain:** Qubic RPC APIs (integração real)
- **Database:** Mock data + localStorage

---

## 📞 **Suporte**

Para dúvidas ou suporte:
- Abra uma **Issue** no repositório
- Execute `node qibux-backend/demo-qubic.js` para demonstração

---

**Qibux - Democratizando o acesso ao poder computacional através da blockchain.**
