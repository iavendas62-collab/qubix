# 🚀 Setup Testnet Qubic - AGORA!

## 📋 PASSO A PASSO

### PASSO 1: Criar Carteira (2 minutos)

1. **Abrir o navegador e ir para:**
   ```
   https://wallet.qubic.li
   ```

2. **Clicar em "Create New Wallet"**

3. **Você verá:**
   - **Public ID (Address):** 60 letras MAIÚSCULAS
   - **Seed:** 55 letras minúsculas

4. **IMPORTANTE - SALVAR AGORA:**
   - Copiar o Address
   - Copiar o Seed
   - Salvar em arquivo de texto seguro

**Exemplo do que você vai ver:**
```
Public ID: ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH
Seed: abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxy
```

---

### PASSO 2: Obter QUBIC Grátis (3 minutos)

1. **Abrir nova aba:**
   ```
   https://testnet.qubic.org/faucet
   ```

2. **Colar seu Address** (os 60 caracteres)

3. **Clicar "Request QUBIC"**

4. **Aguardar 2-5 minutos**
   - Você receberá QUBIC de teste
   - Pode ser 100, 1000 ou mais QUBIC

5. **Verificar saldo:**
   ```
   https://testnet.qubic.org/address/[SEU_ADDRESS]
   ```

---

### PASSO 3: Configurar Backend (1 minuto)

Já está configurado! Verificar:
```env
# backend/.env
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org
```

✅ Já está correto!

---

### PASSO 4: Testar no Qubix (2 minutos)

1. **Abrir Qubix:**
   ```
   http://localhost:3004/app/wallet
   ```

2. **Clicar "Connect Wallet"**

3. **Colar:**
   - Address (60 caracteres)
   - Seed (55 caracteres)

4. **Ver saldo carregar!** 🎉

---

## 🎯 COMANDOS RÁPIDOS

### Abrir Wallet Qubic:
```powershell
Start-Process "https://wallet.qubic.li"
```

### Abrir Faucet:
```powershell
Start-Process "https://testnet.qubic.org/faucet"
```

### Abrir Qubix Wallet:
```powershell
Start-Process "http://localhost:3004/app/wallet"
```

---

## ✅ CHECKLIST

- [ ] Criar carteira em wallet.qubic.li
- [ ] Salvar Address e Seed
- [ ] Solicitar QUBIC no faucet
- [ ] Aguardar 2-5 minutos
- [ ] Verificar saldo no explorer
- [ ] Conectar no Qubix
- [ ] Ver saldo aparecer

---

## 🆘 TROUBLESHOOTING

### Faucet não funciona:
- Aguardar mais tempo (até 10 min)
- Tentar novamente
- Verificar se Address está correto

### Saldo não aparece no Qubix:
- Verificar se Address está correto
- Clicar no botão "Refresh"
- Aguardar alguns segundos
- Verificar console do navegador (F12)

### Backend não conecta:
- Verificar se backend está rodando
- Verificar porta 3006
- Ver logs do backend

---

## 📝 SALVAR CREDENCIAIS

Criar arquivo: `qubic-testnet-credentials.txt`

```
=== QUBIC TESTNET CREDENTIALS ===

Address (Public ID):
[COLAR AQUI - 60 caracteres]

Seed (Private Key):
[COLAR AQUI - 55 caracteres]

Network: Testnet
Faucet: https://testnet.qubic.org/faucet
Explorer: https://testnet.qubic.org

Data: 2024-12-04
Projeto: Qubix Hackathon

⚠️ NUNCA COMPARTILHAR O SEED!
```

---

## 🎬 PRÓXIMOS PASSOS

Depois de configurar:

1. **Testar Enviar QUBIC:**
   - Criar segunda carteira
   - Enviar QUBIC entre elas
   - Ver TX no explorer

2. **Testar Escrow:**
   - Criar escrow de teste
   - Ver TX no explorer
   - Salvar TX hash

3. **Gravar Demo:**
   - Mostrar saldo real
   - Criar transação
   - Mostrar no explorer

---

## 🚀 COMEÇAR AGORA

Execute estes comandos:

```powershell
# 1. Abrir wallet para criar carteira
Start-Process "https://wallet.qubic.li"

# 2. Aguardar você criar e copiar credenciais
Write-Host "Criou a carteira? Copiou Address e Seed? (Pressione Enter)" -ForegroundColor Yellow
Read-Host

# 3. Abrir faucet
Start-Process "https://testnet.qubic.org/faucet"

# 4. Aguardar você solicitar QUBIC
Write-Host "Solicitou QUBIC no faucet? (Pressione Enter)" -ForegroundColor Yellow
Read-Host

# 5. Aguardar 2 minutos
Write-Host "Aguardando 2 minutos para QUBIC chegar..." -ForegroundColor Cyan
Start-Sleep -Seconds 120

# 6. Abrir Qubix
Start-Process "http://localhost:3004/app/wallet"

Write-Host ""
Write-Host "✅ Pronto! Agora conecte sua carteira no Qubix!" -ForegroundColor Green
```

---

**VAMOS LÁ! Comece pelo PASSO 1!** 🚀
