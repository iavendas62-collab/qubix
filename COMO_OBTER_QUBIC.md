# 💰 Como Obter QUBIC - Guia Completo

## 🤔 O QUE É QUBIC?

QUBIC é a criptomoeda nativa da blockchain Qubic. Diferente de Bitcoin ou Ethereum, o Qubic tem características únicas:

- **Zero taxas de transação** (não precisa pagar gas fees)
- **15.5 milhões de TPS** (muito mais rápido que outras blockchains)
- **Finalidade instantânea** (transações confirmam em segundos)

---

## 🎯 PARA TESTAR (DEMO/HACKATHON)

### Opção 1: TESTNET (Recomendado para Demo) 🎮

**Não precisa comprar nada!** Use a testnet:

1. **Criar Carteira:**
   - Ir para: https://wallet.qubic.li
   - Criar nova carteira
   - Salvar Address (60 letras) e Seed (55 letras)

2. **Obter QUBIC de Teste (Grátis):**
   - Ir para: https://testnet.qubic.org/faucet
   - Colar seu endereço
   - Solicitar QUBIC de teste
   - Aguardar alguns minutos

3. **Usar no Qubix:**
   - Conectar carteira no Qubix
   - Ver saldo de teste
   - Fazer transações de teste
   - Criar escrow de teste

**Vantagens:**
- ✅ Grátis
- ✅ Sem risco
- ✅ Perfeito para demo
- ✅ Funciona igual à mainnet

---

### Opção 2: MODO MOCK (Mais Simples) 🎭

**Nem precisa de blockchain real!** Use dados simulados:

1. **Endereço Mock:**
   ```
   Address: QUBICTESTADDRESSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
   Seed: qubictestseedaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
   ```

2. **O que acontece:**
   - Interface funciona normalmente
   - Mostra saldo "fake"
   - Transações são simuladas
   - Perfeito para mostrar a UI

3. **Limitações:**
   - Não conecta com blockchain real
   - Não mostra saldo real
   - Transações não são verificáveis

**Vantagens:**
- ✅ Instantâneo
- ✅ Sem configuração
- ✅ Bom para testar UI
- ✅ Sem dependências

---

## 💸 PARA PRODUÇÃO (MAINNET)

### Como Comprar QUBIC Real:

#### 1. **Exchanges Centralizadas (CEX)**

**Principais exchanges que listam QUBIC:**

- **MEXC** (https://www.mexc.com)
  - Par: QUBIC/USDT
  - Liquidez: Alta
  - KYC: Necessário

- **Gate.io** (https://www.gate.io)
  - Par: QUBIC/USDT
  - Liquidez: Média
  - KYC: Necessário

- **BitMart** (https://www.bitmart.com)
  - Par: QUBIC/USDT
  - Liquidez: Média
  - KYC: Necessário

**Processo:**
```
1. Criar conta na exchange
2. Fazer KYC (verificação de identidade)
3. Depositar USDT ou outra crypto
4. Comprar QUBIC
5. Sacar para sua carteira Qubic
```

#### 2. **Exchanges Descentralizadas (DEX)**

**Qubic ainda não tem DEX própria**, mas você pode:

- Usar bridges para trazer QUBIC de outras chains
- Aguardar lançamento de DEX nativa

#### 3. **Mineração (Mining)**

**Qubic usa Proof-of-Work:**

- Minerar com GPU/CPU
- Requer hardware potente
- Competitivo
- Recompensas em QUBIC

**Não recomendado para hackathon** (muito complexo)

---

## 🎬 PARA A DEMO DO HACKATHON

### Estratégia Recomendada:

#### Opção A: Testnet Real (Melhor para impressionar)
```
1. Criar carteira na testnet
2. Obter QUBIC grátis do faucet
3. Conectar no Qubix
4. Mostrar transações REAIS na blockchain
5. Destacar: "Isso é verificável on-chain!"
```

**Vantagens:**
- ✅ Impressiona os juízes
- ✅ Mostra integração real
- ✅ Transações verificáveis
- ✅ Grátis

#### Opção B: Mock + Explicação (Mais seguro)
```
1. Usar endereço mock
2. Mostrar interface funcionando
3. Explicar: "Em produção, conecta com blockchain real"
4. Mostrar código da integração
```

**Vantagens:**
- ✅ Sem dependências externas
- ✅ Sempre funciona
- ✅ Sem risco de falhas
- ✅ Foco na UI/UX

#### Opção C: Híbrido (Recomendado!) 🌟
```
1. Preparar carteira testnet com saldo
2. Ter mock como backup
3. Tentar mostrar real primeiro
4. Se falhar, usar mock e explicar
```

**Vantagens:**
- ✅ Melhor dos dois mundos
- ✅ Sem risco de demo quebrar
- ✅ Impressiona se funcionar
- ✅ Backup se falhar

---

## 📊 COMPARAÇÃO: TESTNET vs MAINNET

| Característica | Testnet | Mainnet |
|----------------|---------|---------|
| **Custo** | Grátis | Precisa comprar |
| **QUBIC** | Sem valor real | Valor real |
| **Faucet** | Sim | Não |
| **Transações** | Verificáveis | Verificáveis |
| **Velocidade** | Mesma | Mesma |
| **Taxas** | Zero | Zero |
| **Para Demo** | ✅ Perfeito | ❌ Desnecessário |
| **Para Produção** | ❌ Não usar | ✅ Usar |

---

## 🔧 CONFIGURAÇÃO NO QUBIX

### 1. Testnet (Recomendado):

**Backend (.env):**
```env
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org
QUBIC_EXPLORER_URL=https://testnet.qubic.org
```

**Frontend:**
- Conectar carteira testnet
- Ver saldo de teste
- Fazer transações de teste

### 2. Mainnet (Produção):

**Backend (.env):**
```env
QUBIC_NETWORK=mainnet
QUBIC_RPC_URL=https://rpc.qubic.org
QUBIC_EXPLORER_URL=https://qubic.org
```

**Frontend:**
- Conectar carteira real
- Ver saldo real
- Fazer transações reais

---

## 🎯 PASSO A PASSO PARA DEMO

### Preparação (Antes de Gravar):

1. **Criar Carteira Testnet:**
   ```
   1. Ir para https://wallet.qubic.li
   2. Clicar "Create New Wallet"
   3. Salvar Address e Seed em local seguro
   4. Copiar Address
   ```

2. **Obter QUBIC de Teste:**
   ```
   1. Ir para https://testnet.qubic.org/faucet
   2. Colar Address
   3. Clicar "Request QUBIC"
   4. Aguardar 2-5 minutos
   5. Verificar saldo em https://testnet.qubic.org
   ```

3. **Testar no Qubix:**
   ```
   1. Abrir http://localhost:3004/app/wallet
   2. Clicar "Connect Wallet"
   3. Colar Address e Seed
   4. Ver saldo carregar
   5. Testar enviar QUBIC (para outro endereço teste)
   6. Testar criar escrow
   ```

### Durante a Demo:

1. **Mostrar Wallet:**
   ```
   "Aqui está nossa integração com blockchain Qubic.
   Vou conectar minha carteira de teste..."
   [Conecta]
   "Veja, meu saldo REAL da testnet: X QUBIC."
   ```

2. **Mostrar Transação:**
   ```
   "Vou criar um escrow para um job..."
   [Cria escrow]
   "Pronto! Aqui está o TX hash.
   Posso verificar na blockchain: [mostra explorer]"
   ```

3. **Destacar Diferenciais:**
   ```
   "Zero taxas - completamente grátis.
   Finalidade instantânea - confirmou em segundos.
   Verificável on-chain - transparência total."
   ```

---

## 💡 DICAS IMPORTANTES

### Para Hackathon:
- ✅ Use testnet (grátis e funciona igual)
- ✅ Prepare carteira antes de gravar
- ✅ Tenha backup (mock) se testnet falhar
- ✅ Teste tudo antes de gravar
- ✅ Salve TX hashes para mostrar

### Para Produção:
- ⚠️ Use mainnet
- ⚠️ Compre QUBIC em exchange
- ⚠️ Guarde seeds com segurança
- ⚠️ Faça backup das carteiras
- ⚠️ Teste com valores pequenos primeiro

### Segurança:
- 🔒 Nunca compartilhe seu seed
- 🔒 Seed = acesso total à carteira
- 🔒 Guarde em local seguro
- 🔒 Faça backup offline
- 🔒 Use hardware wallet em produção

---

## 🚀 LINKS ÚTEIS

### Qubic Oficial:
- **Website:** https://qubic.org
- **Wallet:** https://wallet.qubic.li
- **Explorer Mainnet:** https://qubic.org/explorer
- **Explorer Testnet:** https://testnet.qubic.org
- **Faucet Testnet:** https://testnet.qubic.org/faucet
- **Documentação:** https://docs.qubic.org

### Exchanges:
- **MEXC:** https://www.mexc.com/exchange/QUBIC_USDT
- **Gate.io:** https://www.gate.io/trade/QUBIC_USDT
- **CoinMarketCap:** https://coinmarketcap.com/currencies/qubic/

### Comunidade:
- **Discord:** https://discord.gg/qubic
- **Twitter:** https://twitter.com/qubic_network
- **Telegram:** https://t.me/qubic_network

---

## ❓ FAQ

### P: Preciso comprar QUBIC para a demo?
**R:** Não! Use testnet com QUBIC grátis do faucet.

### P: Quanto custa QUBIC?
**R:** Varia. Veja em: https://coinmarketcap.com/currencies/qubic/

### P: Posso usar mock sem blockchain?
**R:** Sim! Use endereço mock para testar a UI.

### P: Testnet funciona igual mainnet?
**R:** Sim! Mesma velocidade, mesmas features, zero taxas.

### P: Como verifico transações?
**R:** Use o explorer: https://testnet.qubic.org (testnet) ou https://qubic.org (mainnet)

### P: Posso perder QUBIC de teste?
**R:** Não tem problema! É grátis, pode pedir mais no faucet.

### P: Quanto tempo leva para confirmar?
**R:** Segundos! Qubic é muito rápido.

### P: Tem taxas de transação?
**R:** Não! Zero taxas sempre.

---

## ✅ CHECKLIST PARA DEMO

- [ ] Criar carteira testnet
- [ ] Obter QUBIC do faucet
- [ ] Verificar saldo no explorer
- [ ] Testar conectar no Qubix
- [ ] Testar enviar QUBIC
- [ ] Testar criar escrow
- [ ] Salvar TX hashes
- [ ] Preparar endereço mock (backup)
- [ ] Testar tudo antes de gravar
- [ ] Ensaiar roteiro

---

## 🎉 RESUMO

### Para Hackathon/Demo:
1. **Use Testnet** (grátis, funciona igual)
2. **Obtenha QUBIC do faucet** (2-5 minutos)
3. **Teste no Qubix** (conectar, ver saldo, transações)
4. **Grave demo** (mostre transações reais)
5. **Destaque diferenciais** (zero taxas, velocidade, verificável)

### Para Produção:
1. **Use Mainnet**
2. **Compre QUBIC em exchange** (MEXC, Gate.io)
3. **Saque para carteira própria**
4. **Integre no Qubix**
5. **Teste com valores pequenos**

---

**Não precisa comprar nada para a demo!** Use testnet! 🎉
