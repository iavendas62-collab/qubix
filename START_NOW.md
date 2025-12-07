# ⚡ START NOW - Quick Commands

## 🚀 COMEÇAR AGORA (5 minutos)

### Step 1: Limpar e Organizar
```bash
# Criar branch para hackathon
git checkout -b hackathon-mvp

# Limpar arquivos desnecessários
rm -rf node_modules
rm -rf frontend/node_modules
rm -rf backend/node_modules

# Reinstalar dependências
cd backend && npm install
cd ../frontend && npm install
```

### Step 2: Instalar Dependências Extras
```bash
# Frontend - adicionar packages necessários
cd frontend
npm install lucide-react recharts clsx date-fns @radix-ui/react-slider @radix-ui/react-select

# Backend - já tem tudo
cd ../backend
```

### Step 3: Rodar Mock Server
```bash
# Terminal 1: Backend Mock
cd backend
node mock-server.js

# Deve mostrar:
# 🎯 QUBIX MOCK SERVER
# Port: 3001
# Status: Running ✅
```

### Step 4: Rodar Frontend
```bash
# Terminal 2: Frontend
cd frontend
npm start

# Deve abrir: http://localhost:3000
```

### Step 5: Verificar
```bash
# Abrir browser
open http://localhost:3000

# Testar API
curl http://localhost:3001/health
# Deve retornar: {"status":"ok"}
```

---

## 📋 DIA 1 - TASKS DETALHADAS

### Manhã (9h-13h): Setup & Infrastructure

#### Task 1.1: Design System (1h)
```bash
# Criar arquivo de cores
# frontend/src/styles/colors.ts

export const colors = {
  aws: {
    dark: '#232F3E',
    orange: '#FF9900',
    blue: '#146EB4',
    green: '#1E8900',
    red: '#D13212',
    gray: '#545B64',
    light: '#FAFAFA',
  }
}
```

#### Task 1.2: TailwindCSS Config (30min)
```javascript
// frontend/tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        aws: {
          dark: '#232F3E',
          orange: '#FF9900',
          blue: '#146EB4',
          green: '#1E8900',
          red: '#D13212',
          gray: '#545B64',
          light: '#FAFAFA',
        }
      }
    }
  }
}
```

#### Task 1.3: Instalar Lucide Icons (15min)
```bash
cd frontend
npm install lucide-react
```

#### Task 1.4: Criar Components Base (2h)
```bash
# Criar estrutura
mkdir -p frontend/src/components/ui
mkdir -p frontend/src/components/layout

# Criar arquivos
touch frontend/src/components/layout/Sidebar.tsx
touch frontend/src/components/layout/Header.tsx
touch frontend/src/components/layout/Layout.tsx
touch frontend/src/components/ui/Button.tsx
touch frontend/src/components/ui/Card.tsx
```

---

### Tarde (14h-18h): Sidebar + Layout

#### Task 2.1: Sidebar Component (2h)
Já criamos `Sidebar.tsx`, agora melhorar:
- [ ] Adicionar hover effects
- [ ] Adicionar active states
- [ ] Adicionar collapse/expand
- [ ] Adicionar user menu no bottom

#### Task 2.2: Header Component (1h)
```tsx
// frontend/src/components/layout/Header.tsx
- [ ] Search bar
- [ ] Notifications icon
- [ ] User avatar
- [ ] Breadcrumbs
```

#### Task 2.3: Layout Component (1h)
```tsx
// frontend/src/components/layout/Layout.tsx
- [ ] Sidebar + Header + Content
- [ ] Responsive (mobile menu)
- [ ] Scroll handling
```

---

### Noite (19h-21h): Mock Data

#### Task 3.1: Expandir Mock Server (2h)
```javascript
// backend/mock-server.js

// Adicionar 20+ GPUs
const mockGPUs = [
  {
    id: '1',
    model: 'NVIDIA RTX 4090',
    vram: 24,
    location: 'São Paulo, Brazil',
    price: 10,
    rating: 4.9,
    available: true,
    provider: 'provider-1'
  },
  {
    id: '2',
    model: 'NVIDIA A100',
    vram: 80,
    location: 'Virginia, US',
    price: 50,
    rating: 5.0,
    available: true,
    provider: 'provider-2'
  },
  // ... adicionar mais 18 GPUs
]

// Endpoint
app.get('/api/gpus', (req, res) => {
  res.json(mockGPUs);
});
```

---

## 🎯 CHECKLIST DIA 1

### Manhã:
- [ ] Design system criado
- [ ] TailwindCSS configurado
- [ ] Lucide icons instalado
- [ ] Components base criados

### Tarde:
- [ ] Sidebar melhorado
- [ ] Header criado
- [ ] Layout criado
- [ ] Responsive funcionando

### Noite:
- [ ] Mock server expandido
- [ ] 20+ GPUs adicionados
- [ ] Endpoints testados
- [ ] Commit & push

---

## 📊 PROGRESS CHECK

### End of Day 1:
```
✅ Design system: Done
✅ Layout AWS-like: Done
✅ Mock data: Done
✅ Components: Done

Progress: ▓▓░░░░░░░░ 20% (2/10h)
```

---

## 🚨 TROUBLESHOOTING

### Frontend não inicia:
```bash
cd frontend
rm -rf node_modules
npm install
npm start
```

### Backend não inicia:
```bash
cd backend
rm -rf node_modules
npm install
node mock-server.js
```

### Port já em uso:
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Mac/Linux
lsof -ti:3000 | xargs kill -9
```

---

## 💪 MOTIVATION

**Você tem 14 dias para:**
- 🏆 Ganhar hackathon
- 💰 Lançar produto real
- 🚀 Conseguir primeiros clientes
- 💵 Fazer primeira venda

**Cada hora conta!**

**BORA! 🔥**

---

## 📞 NEED HELP?

### Resources:
- EXECUTION_PLAN_14_DAYS.md (plano completo)
- PROGRESS_TRACKER.md (acompanhar progresso)
- MASTER_PLAN.md (visão geral)
- CLOUD_SETUP.md (infraestrutura)

### Questions?
- Review documentation
- Check examples
- Google it
- Ask ChatGPT
- Keep moving forward!

---

**START TIME:** Now
**END TIME:** 14 days from now
**GOAL:** $10M ARR in 24 months

**LET'S GO! 🚀💰**
