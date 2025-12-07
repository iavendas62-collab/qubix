# 🚀 QUBIX - Fluxo Simplificado

## Visão Geral

```
┌─────────────────────────────────────────────────────────────────┐
│                         QUBIX                                   │
│              Marketplace de GPU Descentralizado                 │
├────────────────────────┬────────────────────────────────────────┤
│   🖥️ PROVIDER          │   🎮 CALLER (Usuário)                  │
│   (Quem tem GPU)       │   (Quem precisa de GPU)                │
├────────────────────────┼────────────────────────────────────────┤
│   1. Baixa Worker      │   1. Escolhe o que quer fazer          │
│   2. Roda 1 comando    │   2. Seleciona GPU                     │
│   3. GPU online! 💰    │   3. Conecta e usa! 🎮                 │
└────────────────────────┴────────────────────────────────────────┘
```

---

## 🖥️ LADO DO PROVIDER (Quem tem hardware)

### Processo em 3 passos:

**1. Escolhe Sistema Operacional**
- Windows / Linux / Mac

**2. Copia e executa o comando**
```bash
# Windows
pip install psutil requests
python worker.py

# Linux/Mac
pip3 install psutil requests
python3 worker.py
```

**3. Pronto!**
- Worker detecta automaticamente CPU/GPU/RAM
- Registra no marketplace
- Começa a receber jobs e ganhar QUBIC

### O que o Worker faz:
- Detecta hardware (nvidia-smi, psutil)
- Registra como provider no backend
- Envia heartbeat a cada 30s
- Pega jobs pendentes
- Executa e reporta progresso
- Recebe pagamento em QUBIC

---

## 🎮 LADO DO CALLER (Quem precisa de GPU)

### Processo em 4 passos:

**1. Escolhe o caso de uso**
- 🎮 Gaming (Cyberpunk, GTA V, CS2)
- 🎬 Renderização 3D (Blender, Cinema 4D)
- 🧠 IA/ML (Stable Diffusion, LLaMA, PyTorch)
- 💻 Desenvolvimento (CUDA, Docker, Unreal)

**2. Sistema recomenda GPUs**
- Filtra por VRAM mínimo necessário
- Ordena por recomendação e preço
- Mostra disponibilidade em tempo real

**3. Confirma e conecta**
- Vê preço por hora
- Escolhe método de conexão
- Paga em QUBIC

**4. Usa!**
- Gaming: Moonlight/Parsec (stream)
- IA/Dev: Jupyter Lab ou SSH
- Renderização: Acesso remoto

---

## 🔧 MÉTODOS DE CONEXÃO

| Caso de Uso | Método Principal | Alternativa |
|-------------|------------------|-------------|
| Gaming | Moonlight | Parsec |
| IA/ML | Jupyter Lab | SSH |
| Renderização | VNC/RDP | SSH + X11 |
| Desenvolvimento | VSCode Remote | SSH |

### Gaming (Moonlight)
```
1. Baixa Moonlight (moonlight-stream.org)
2. Conecta no endereço fornecido
3. Joga com latência mínima!
```

### IA/ML (Jupyter)
```
1. Abre URL no navegador
2. Ambiente Python pronto
3. GPU disponível via CUDA
```

### SSH (Terminal)
```bash
ssh root@gpu-xxx.qubix.network
# Senha fornecida no painel
```

---

## 💰 MODELO DE NEGÓCIO

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   CALLER    │────▶│   QUBIX     │────▶│  PROVIDER   │
│  Paga QUBIC │     │  5% taxa    │     │ Recebe 95%  │
└─────────────┘     └─────────────┘     └─────────────┘
```

### Preços por hora (QUBIC):
| GPU | Preço/hora |
|-----|------------|
| RTX 3080 | 5-6 |
| RTX 4080 | 8-9 |
| RTX 4090 | 10-13 |
| A100 | 35-52 |
| H100 | 78-80 |

---

## 🏗️ ARQUITETURA TÉCNICA

```
┌─────────────────────────────────────────────────────────────────┐
│                        FRONTEND (React)                         │
│  - Dashboard com estatísticas                                   │
│  - Marketplace de GPUs                                          │
│  - Wizard de conexão                                            │
│  - Painel do Provider                                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        BACKEND (Node.js)                        │
│  - API REST                                                     │
│  - Autenticação JWT                                             │
│  - Orchestrator de jobs                                         │
│  - Integração Qubic                                             │
└─────────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   PostgreSQL    │  │  Qubic Network  │  │    Workers      │
│   (Prisma ORM)  │  │  (Blockchain)   │  │   (Python)      │
└─────────────────┘  └─────────────────┘  └─────────────────┘
```

---

## 📁 ESTRUTURA DO PROJETO

```
qubix/
├── frontend/           # React + Vite + TypeScript
│   ├── src/
│   │   ├── pages/
│   │   │   ├── QubixApp.tsx      # Dashboard principal
│   │   │   ├── BecomeProvider.tsx # Wizard para providers
│   │   │   ├── UseGPU.tsx        # Wizard para callers
│   │   │   ├── Login.tsx         # Tela de login
│   │   │   └── Register.tsx      # Cadastro + wallet
│   │   └── services/
│   │       └── qubicApi.ts       # Chamadas à API
│
├── backend/            # Node.js + Express
│   ├── src/
│   │   ├── routes/     # Endpoints da API
│   │   ├── services/   # Lógica de negócio
│   │   └── prisma/     # Schema do banco
│   └── mock-server.js  # Servidor para demo
│
├── worker/             # Python
│   └── qubix_worker_simple.py  # Worker simplificado
│
└── contracts/          # Smart Contracts Qubic
    ├── ProviderRegistry.cpp
    └── JobEscrow.cpp
```

---

## 🎯 PRÓXIMOS PASSOS

1. **Fase 2**: Integração wallet Qubic real
2. **Fase 3**: Deploy cloud (Vercel + Railway)
3. **Fase 4**: Smart contracts de escrow
4. **Fase 5**: Streaming de GPU (Moonlight/Parsec)
