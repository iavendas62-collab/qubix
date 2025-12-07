# 🚀 Qubix - Decentralized GPU Compute Marketplace

> P2P GPU marketplace powered by Qubic blockchain with zero-fee transactions and smart contract escrow

[![Qubic](https://img.shields.io/badge/Powered%20by-Qubic-00D4FF)](https://qubic.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Hackathon](https://img.shields.io/badge/Hackathon-Qubic%202024-green)](https://lablab.ai)

---

## 🎯 The Problem

- **Expensive:** Cloud GPU providers charge $2-5/hour
- **Wasteful:** Millions of GPUs sit idle worldwide
- **Costly:** Ethereum transactions cost $5-50 in fees
- **Risky:** No trust mechanism between parties

## 💡 Our Solution

**Qubix** connects GPU owners with those who need compute power, using **Qubic blockchain** for:

- ✅ **Zero transaction fees**
- ✅ **Instant payments** (seconds, not minutes)
- ✅ **Smart contract escrow** (automatic protection)
- ✅ **15.5M TPS** (unlimited scalability)

---

## ✨ Features

### For Consumers

- 🔍 **Browse Marketplace:** 20+ GPUs available
- 📤 **Upload Jobs:** Drag & drop your code
- 🤖 **Auto-matching:** AI finds best GPU for your job
- 📊 **Real-time Monitoring:** Track progress and metrics
- 💰 **Pay with QUBIC:** Zero fees, instant settlement

### For Providers

- 🖥️ **Auto-detect GPU:** One-click registration
- 💵 **Earn QUBIC:** Get paid for idle GPU time
- 📈 **Track Earnings:** Real-time dashboard
- 🔒 **Protected Payments:** Escrow guarantees payment
- ⚡ **Instant Payouts:** No waiting, no fees

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────┐
│                     Qubix Platform                       │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  ┌─────────────┐         ┌─────────────┐               │
│  │  Consumer   │────────▶│  Marketplace│               │
│  │  Dashboard  │         │   (Browse)  │               │
│  └─────────────┘         └─────────────┘               │
│         │                       │                        │
│         ▼                       ▼                        │
│  ┌─────────────┐         ┌─────────────┐               │
│  │ Job Wizard  │────────▶│   Backend   │               │
│  │ (Upload)    │         │   (API)     │               │
│  └─────────────┘         └─────────────┘               │
│         │                       │                        │
│         │                       ▼                        │
│         │                ┌─────────────┐                │
│         │                │    Qubic    │                │
│         │                │  Blockchain │                │
│         │                │  (Escrow)   │                │
│         │                └─────────────┘                │
│         │                       │                        │
│         ▼                       ▼                        │
│  ┌─────────────┐         ┌─────────────┐               │
│  │   Monitor   │◀────────│   Provider  │               │
│  │ (Progress)  │         │   (Worker)  │               │
│  └─────────────┘         └─────────────┘               │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- Node.js 18+
- Python 3.8+ (for GPU detection)
- NVIDIA GPU (optional, for providers)
- Qubic wallet (created automatically)

### Installation

```bash
# Clone repository
git clone https://github.com/yourusername/qubix.git
cd qubix

# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Start backend
cd backend
npm run dev

# Start frontend (new terminal)
cd frontend
npm run dev
```

### Access

- Frontend: http://localhost:3004
- Backend API: http://localhost:3006
- API Docs: http://localhost:3006/api-docs

---

## 🎮 Usage

### As a Consumer

1. **Browse Marketplace**
   ```
   Navigate to Marketplace → See available GPUs
   ```

2. **Submit Job**
   ```
   Upload your code → Auto-detect requirements → Select GPU → Submit
   ```

3. **Monitor Progress**
   ```
   View real-time metrics → See logs → Get results
   ```

### As a Provider

1. **Register GPU**
   ```bash
   python register-my-gpu.py
   ```

2. **Monitor Earnings**
   ```
   Provider Dashboard → See active jobs → Track earnings
   ```

3. **Withdraw**
   ```
   Qubic Wallet → View balance → Withdraw to external wallet
   ```

---

## 💻 Tech Stack

### Frontend
- React 18
- TypeScript
- Vite
- TailwindCSS
- Recharts

### Backend
- Node.js
- Express
- TypeScript
- Prisma ORM
- WebSocket

### Blockchain
- Qubic
- @qubic-lib/qubic-ts-library
- Smart contracts (Escrow)

### Infrastructure
- PostgreSQL
- Redis
- Docker

---

## 🔐 Security

- ✅ Escrow smart contracts
- ✅ Seed phrase encryption
- ✅ Rate limiting
- ✅ Input validation
- ✅ CORS protection
- ✅ Environment variables

---

## 📊 Why Qubic?

| Feature | Ethereum | Solana | **Qubic** |
|---------|----------|--------|-----------|
| TX Fee | $5-50 | $0.001 | **$0** |
| Finality | 15 min | 13s | **Seconds** |
| TPS | 15 | 65K | **15.5M** |
| Escrow Cost | High | Medium | **Free** |

**Result:** Qubic makes micro-transactions viable for GPU rentals!

---

## 🎯 Roadmap

### Phase 1: MVP ✅
- [x] Marketplace
- [x] Job submission
- [x] Qubic integration
- [x] Escrow system

### Phase 2: Testnet 🔄
- [ ] Deploy to testnet
- [ ] Hardware verification
- [ ] Performance optimization

### Phase 3: Mainnet 📅
- [ ] Mainnet launch
- [ ] Mobile app
- [ ] Enterprise features

---

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md)

---

## 📄 License

MIT License - see [LICENSE](LICENSE)

---

## 🏆 Hackathon

Built for **Qubic: Hack the Future Hackathon**

- **Track:** Nostromo Launchpad
- **Prize Pool:** $44,550
- **Date:** December 2024

---

## 👥 Team

[Your team information]

---

## 📞 Contact

- **Email:** contact@qubix.ai
- **Twitter:** [@QubixAI](https://twitter.com/QubixAI)
- **Discord:** [Join our server](https://discord.gg/qubix)

---

## 🙏 Acknowledgments

Special thanks to:
- Qubic team for amazing technology
- lablab.ai for hosting the hackathon
- Community for feedback and support

---

**Built with ❤️ on Qubic blockchain**

[⭐ Star us on GitHub](https://github.com/yourusername/qubix) | [🐛 Report Bug](https://github.com/yourusername/qubix/issues) | [💡 Request Feature](https://github.com/yourusername/qubix/issues)
