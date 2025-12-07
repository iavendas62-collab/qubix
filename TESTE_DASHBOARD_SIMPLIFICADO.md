# 🧪 TESTE: Dashboard Provider Simplificado

## 📋 O QUE VAMOS TESTAR

Dashboard novo com Python auto-detect integrado:
- ✅ Stats (earnings, jobs, hardware)
- ✅ Botão "Auto-Detect GPU (Python)"
- ✅ Lista de hardware com earnings
- ✅ Controles (pause, play, delete)

## 🔧 SETUP

### 1. Adicionar Rota Temporária

Edite: `frontend/src/App.tsx` ou o arquivo de rotas

Adicione rota temporária:
```tsx
import ProviderDashboardSimple from './pages/provider/DashboardSimple';

// Nas rotas:
<Route path="/app/provider/test" element={<ProviderDashboardSimple />} />
```

### 2. Verificar Backend Rodando

```powershell
# Backend deve estar na porta 3006
curl http://localhost:3006/api/providers
```

### 3. Verificar Python Funciona

```powershell
python register-my-gpu.py
```

## 🎯 TESTE PASSO A PASSO

### TESTE 1: Dashboard Vazio (Sem Hardware)

1. **Abrir:** http://localhost:5173/app/provider/test

2. **Deve Ver:**
   ```
   ┌─────────────────────────────────────┐
   │ Provider Dashboard                  │
   ├─────────────────────────────────────┤
   │ Stats:                              │
   │ • Total Earnings: 0.00 QUBIC        │
   │ • Active Jobs: 0                    │
   │ • Hardware Online: 0 of 0           │
   ├─────────────────────────────────────┤
   │ 🎯 Add Your First GPU               │
   │                                     │
   │ [Auto-Detect GPU (Python)]          │
   │                                     │
   │ Requires Python, nvidia-smi...      │
   └─────────────────────────────────────┘
   ```

3. **Verificar:**
   - [ ] Stats aparecem zerados
   - [ ] Botão "Auto-Detect GPU" visível
   - [ ] Mensagem de ajuda aparece
   - [ ] Sem erros no console

### TESTE 2: Auto-Detect GPU

1. **Clicar:** "Auto-Detect GPU (Python)"

2. **Deve Ver:**
   ```
   Botão muda para: [⟳ Detecting...]
   
   Status aparece: 🔍 Detecting GPU with Python...
   ```

3. **Aguardar 2-5 segundos**

4. **Se Sucesso:**
   ```
   Status: ✅ GPU detected and registered!
   
   GPU aparece na lista:
   ┌─────────────────────────────────────┐
   │ 🟢 NVIDIA GeForce MX150             │
   │ 4GB VRAM • 4 cores • 15.9GB RAM     │
   │ 0.5 QUBIC/hour • Local Machine      │
   │                                     │
   │ 💰 0.00 QUBIC                       │
   │ 0 jobs                              │
   │                                     │
   │ [⚙️] [⏸️] [🗑️]                       │
   └─────────────────────────────────────┘
   ```

5. **Se Erro:**
   ```
   Status: ❌ Error: [mensagem]
   
   Possíveis erros:
   - Backend não rodando
   - Python não instalado
   - nvidia-smi não encontrado
   - GPU não detectada
   ```

### TESTE 3: Dashboard com Hardware

1. **Após GPU detectada, deve ver:**
   ```
   Stats atualizados:
   • Total Earnings: 0.00 QUBIC (da GPU)
   • Hardware Online: 1 of 1
   
   Seção "My Hardware (1)":
   • GPU listada com specs
   • Earnings: 0.00 QUBIC
   • Jobs: 0
   • Botões de controle
   ```

2. **Verificar:**
   - [ ] Stats atualizaram
   - [ ] GPU aparece na lista
   - [ ] Specs corretas (modelo, VRAM, cores, RAM)
   - [ ] Botões funcionam (hover)
   - [ ] Botão "Add More" aparece

### TESTE 4: Controles

1. **Testar Pause:**
   - Clicar botão ⏸️
   - Status deve mudar para "Offline"
   - Botão muda para ▶️ (Play)

2. **Testar Play:**
   - Clicar botão ▶️
   - Status volta para "Online"
   - Botão volta para ⏸️

3. **Testar Delete:**
   - Clicar botão 🗑️
   - Confirmar no popup
   - GPU deve sumir da lista
   - Dashboard volta para estado vazio

### TESTE 5: Adicionar Mais GPUs

1. **Com 1 GPU já registrada**
2. **Clicar:** "Add More"
3. **Deve:** Rodar detecção novamente
4. **Resultado:** 
   - Se mesma GPU: Atualiza existente
   - Se GPU diferente: Adiciona nova

## ✅ CHECKLIST COMPLETO

### Visual
- [ ] Dashboard carrega sem erros
- [ ] Stats aparecem corretamente
- [ ] Botão "Auto-Detect" visível e clicável
- [ ] Mensagens de status aparecem
- [ ] GPU aparece após detecção
- [ ] Specs corretas (modelo, VRAM, etc)
- [ ] Earnings aparecem (mesmo que 0.00)
- [ ] Botões de controle funcionam

### Funcional
- [ ] Auto-detect chama backend
- [ ] Backend roda Python script
- [ ] GPU é registrada
- [ ] Lista atualiza automaticamente
- [ ] Pause/Play funciona
- [ ] Delete funciona
- [ ] Stats atualizam

### Console (F12)
- [ ] Sem erros JavaScript
- [ ] Logs de fetch aparecem
- [ ] Respostas da API corretas

### Backend Console
- [ ] POST /api/hardware/detect recebido
- [ ] Python script executado
- [ ] GPU registrada (log)
- [ ] Resposta enviada

## 🐛 TROUBLESHOOTING

### Erro: "Backend não rodando"
```powershell
cd backend
npm run dev
```

### Erro: "Python não encontrado"
```powershell
python --version
# Se não funcionar, instalar Python
```

### Erro: "nvidia-smi não encontrado"
```powershell
nvidia-smi
# Se não funcionar, instalar drivers NVIDIA
```

### Erro: "GPU não aparece"
1. Verificar console do backend
2. Verificar resposta da API
3. Verificar se qubicAddress está correto

## 📸 SCREENSHOTS PARA DEMO

Se tudo funcionar, tire screenshots de:

1. **Dashboard vazio** - Antes de adicionar GPU
2. **Detectando** - Botão em loading
3. **Sucesso** - GPU detectada
4. **Dashboard com GPU** - Lista completa
5. **Stats** - Earnings e métricas

## 🎯 PRÓXIMO PASSO

Se tudo funcionar:
- ✅ Substituir Dashboard antigo pelo novo
- ✅ Remover páginas duplicadas
- ✅ Simplificar sidebar
- ✅ Testar fluxo completo da demo

---

## 🚀 COMANDO RÁPIDO

```powershell
# Abrir dashboard de teste
start http://localhost:5173/app/provider/test
```

**Me diga o que você vê!** 👀
