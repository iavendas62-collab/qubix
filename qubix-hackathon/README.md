# 🚀 Qibux Compute Marketplace

> **O Futuro da Computação Descentralizada Chegou.**

O Qibux não é apenas uma plataforma; é um mercado descentralizado e transparente que conecta utilizadores que precisam de poder computacional (como treino de modelos de IA, renderização ou simulações) com provedores de GPU globais. Alimentado pela tecnologia Qubic, oferecemos uma solução de computação eficiente, acessível e resistente à censura.

**Diga adeus à infraestrutura centralizada e aos custos imprevisíveis. Bem-vindo à era da computação peer-to-peer.**

---

## ✨ **Proposta de Valor**

### **1. Descentralização Total**
Utilizamos o endereço Qubic do utilizador para gerir e faturar todos os trabalhos. Isto garante que a propriedade, a faturação e o acesso são totalmente descentralizados e seguros.

### **2. Transparência e Custo**
Todos os custos são fixos ou estimados em QUBIC e monitorizados em tempo real. Os utilizadores têm visibilidade total sobre o custo por hora e o desempenho da GPU.

### **3. Foco em Modelos de IA**
O Qibux foi otimizado para a execução de modelos pesados, oferecendo painéis dedicados para monitorizar o progresso, o estado e o hardware subjacente de cada instância.

---

## 💡 **Funcionalidades Principais**

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

## 🛠️ **Tecnologias Utilizadas**

O Qibux é construído sobre uma pilha de tecnologias modernas para garantir velocidade e estabilidade:

| Componente | Tecnologia | Descrição |
|------------|------------|-----------|
| **Frontend** | React (com TypeScript) | Interface de utilizador rápida e modular |
| **Estilização** | Tailwind CSS | Design responsivo, moderno e esteticamente agradável |
| **Roteamento** | react-router-dom (HashRouter) | Navegação simples de página única |
| **Ícones** | Lucide React | Ícones vetoriais limpos e expressivos |
| **Backend/Faturação** | Qubic Ledger | Autenticação e transações descentralizadas (Simulação) |

---

## 🚀 **Como Começar**

### **Pré-requisitos**
- Node.js e npm instalados
- Um endereço Qubic (simulado pelo localStorage no modo de demonstração)

### **Instalação (Ambiente de Desenvolvimento)**

1. **Clone o repositório:**
```bash
git clone [SEU_REPOSITORIO_AQUI]
cd qibux-compute-marketplace
```

2. **Instale as dependências:**
```bash
npm install
```

3. **Execute a aplicação:**
```bash
npm run dev
```

4. **Acesse a aplicação:**
A aplicação será iniciada e você poderá ver o painel "My Instances" no navegador, carregando dados de trabalhos simulados. Geralmente disponível em `http://localhost:3000` ou conforme configurado no terminal.

---

## 📈 **Estatísticas do Painel (Em Tempo Real)**

A secção de estatísticas fornece uma visão instantânea da sua utilização:

| Métrica | Descrição |
|---------|-----------|
| **Pending** | Trabalhos que aguardam atribuição a uma GPU |
| **Running** | Trabalhos que estão atualmente a ser processados |
| **Completed** | Trabalhos concluídos com sucesso e prontos para o resultado |
| **Total Spent** | O custo acumulado (em QUBIC) de todos os trabalhos |

---

## 🎯 **Funcionalidades da Demonstração**

### **Dashboard Qubic Status**
- Mostra integração completa com blockchain Qubic
- 4/4 sistemas funcionando (RPC, Wallet, Balance, Escrow)
- Status da rede em tempo real

### **Job Submission**
- Submissão de trabalhos de IA/ML
- Criação automática de escrow
- Redução de saldo da wallet em tempo real

### **Wallet Management**
- Geração de endereços Qubic válidos
- Consulta de saldos reais na blockchain
- Histórico de transações persistente

---

## 🤝 **Contribuições**

O Qibux está a construir o futuro da computação. Encorajamos ativamente contribuições!

- **Issues:** Relatórios de bugs ou sugestões
- **Pull Requests:** Novas funcionalidades
- **Discussões:** Melhorias na arquitetura

**O Qibux é uma iniciativa da comunidade Qubic para democratizar o acesso ao poder de processamento de GPU.**

---

## 📞 **Suporte**

Para dúvidas ou suporte:
- Abra uma **Issue** no repositório
- Consulte a documentação técnica em `docs/`
- Execute o script de demonstração: `node backend/demo-qubic.js`
