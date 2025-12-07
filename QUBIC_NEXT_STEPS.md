# 🚀 Próximos Passos - Integração Qubic

## ✅ O Que Foi Feito

1. **Biblioteca Instalada:** `@qubic-lib/qubic-ts-library`
2. **Serviço de Wallet:** `backend/src/services/qubic-wallet.ts`
3. **Suite de Testes:** `backend/src/scripts/test-qubic-wallet.ts`
4. **Documentação:** `backend/QUBIC_INTEGRATION_GUIDE.md`

## 🎯 Ações Imediatas (Próximos 30 minutos)

### 1. Testar Criação de Wallet (5 min)

```bash
cd backend
npm run test:qubic
```

**Resultado Esperado:**
- ✅ Nova wallet criada
- ✅ Public ID (endereço) gerado
- ✅ Seed phrase exibido
- ✅ Saldo consultado (será 0)

**⚠️ IMPORTANTE:** Salve o seed phrase gerado!

### 2. Obter Fundos de Testnet (10 min)

**Opção A: Faucet Web**
```
1. Acesse: https://testnet.qubic.org/faucet
2. Cole seu Public ID
3. Solicite fundos
4. Aguarde confirmação
```

**Opção B: Discord/Telegram**
```
1. Entre no Discord oficial do Qubic
2. Procure canal #testnet-faucet
3. Use comando: !faucet SEU_PUBLIC_ID
```

### 3. Verificar Saldo (2 min)

Edite `backend/src/scripts/test-qubic-wallet.ts`:

```typescript
// Linha ~100, substitua:
await testBalanceQuery('SEU_PUBLIC_ID_AQUI');
```

Execute novamente:
```bash
npm run test:qubic
```

### 4. Enviar Transação de Teste (5 min)

No mesmo arquivo, descomente as linhas ~110-120:

```typescript
const tx = await testTransaction(
  'SEU_SEED',
  'ENDERECO_DESTINO', // Use outro endereço ou crie uma segunda wallet
  0.1 // Enviar 0.1 QUBIC
);

await testTransactionStatus(tx.txHash);
```

Execute:
```bash
npm run test:qubic
```

### 5. Verificar no Explorer (3 min)

```
https://testnet.qubic.org/tx/SEU_TX_HASH
```

## 📋 Checklist de Validação

- [ ] Wallet criada com sucesso
- [ ] Seed phrase salvo em local seguro
- [ ] Fundos recebidos do faucet
- [ ] Saldo consultado corretamente
- [ ] Transação enviada com sucesso
- [ ] Transação confirmada no explorer

## 🔄 Próxima Fase: Integração com QUBIX

### 1. Criar Wallet da Plataforma

```bash
cd backend
npm run test:qubic
```

Salve o resultado em `backend/.env`:

```env
QUBIC_PLATFORM_SEED=seed_gerado_aqui
QUBIC_PLATFORM_ADDRESS=public_id_gerado_aqui
```

### 2. Atualizar Serviço de Escrow

Editar `backend/src/services/qubic.service.ts`:

```typescript
import qubicWallet from './qubic-wallet';

async createEscrow(jobId, consumer, provider, amount) {
  // Inicializar
  await qubicWallet.initialize();
  
  // Enviar transação
  const tx = await qubicWallet.sendTransaction(
    consumer.seed, // Seed do consumidor
    this.platformAddress, // Endereço da plataforma
    BigInt(amount)
  );
  
  // Salvar no banco
  await prisma.escrow.create({
    data: {
      jobId,
      txHash: tx.txHash,
      amount,
      consumer,
      provider,
      status: 'locked'
    }
  });
  
  return tx.txHash;
}
```

### 3. Criar Endpoints API

Criar `backend/src/routes/wallet.ts`:

```typescript
import express from 'express';
import qubicWallet from '../services/qubic-wallet';

const router = express.Router();

// POST /api/wallet/create
router.post('/create', async (req, res) => {
  const wallet = qubicWallet.createWallet();
  res.json(wallet);
});

// GET /api/wallet/:address/balance
router.get('/:address/balance', async (req, res) => {
  await qubicWallet.initialize();
  const balance = await qubicWallet.getBalance(req.params.address);
  res.json(balance);
});

export default router;
```

### 4. Adicionar ao Frontend

Atualizar `frontend/src/services/qubic.ts`:

```typescript
export async function createWallet() {
  const response = await fetch('/api/wallet/create', {
    method: 'POST'
  });
  return response.json();
}

export async function getBalance(address: string) {
  const response = await fetch(`/api/wallet/${address}/balance`);
  return response.json();
}
```

## 🎯 Objetivos da Semana

### Dia 1 (Hoje)
- [x] Instalar biblioteca Qubic
- [x] Implementar wallet service
- [x] Criar testes
- [ ] Validar com transação real

### Dia 2
- [ ] Integrar com sistema de escrow
- [ ] Criar endpoints API
- [ ] Testar fluxo completo

### Dia 3
- [ ] Adicionar UI de wallet no frontend
- [ ] Implementar monitoramento de transações
- [ ] Testes end-to-end

### Dia 4-5
- [ ] Implementar smart contracts (se necessário)
- [ ] Adicionar sistema de notificações
- [ ] Documentação final

## 📞 Suporte

**Documentação:**
- Guia completo: `backend/QUBIC_INTEGRATION_GUIDE.md`
- Docs oficiais: https://docs.qubic.org

**Comunidade:**
- Discord: https://discord.gg/qubic
- GitHub: https://github.com/qubic-lib/qubic-ts-library

## 🐛 Problemas Comuns

### "Cannot find module '@qubic-lib/qubic-ts-library'"

```bash
cd backend
npm install
```

### "Qubic connector not initialized"

Adicione antes de usar:
```typescript
await qubicWallet.initialize();
```

### "Transaction failed: insufficient balance"

Certifique-se de ter fundos suficientes + taxa de rede.

## 🎉 Status

**Etapas 4, 5 e 8: ✅ IMPLEMENTADAS**

Agora é só testar! Execute:

```bash
cd backend
npm run test:qubic
```

Boa sorte! 🚀
