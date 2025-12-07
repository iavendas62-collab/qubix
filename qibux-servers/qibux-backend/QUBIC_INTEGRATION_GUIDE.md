# 🔷 Guia de Integração Qubic - QUBIX

## 📚 Biblioteca Instalada

```bash
@qubic-lib/qubic-ts-library
```

Esta é a biblioteca oficial TypeScript para interagir com a rede Qubic.

## 🎯 Etapas Implementadas

### ✅ ETAPA 4: Criação de Wallet

**Arquivo:** `backend/src/services/qubic-wallet.ts`

**Funcionalidades:**
- ✅ Criar nova wallet (seed + endereço)
- ✅ Importar wallet existente via seed
- ✅ Validação de endereços Qubic

**Exemplo de Uso:**

```typescript
import qubicWallet from './services/qubic-wallet';

// Criar nova wallet
const wallet = qubicWallet.createWallet();
console.log('Address:', wallet.publicId);
console.log('Seed:', wallet.seed);

// Importar wallet existente
const imported = qubicWallet.importWallet('YOUR_55_CHAR_SEED');
```

### ✅ ETAPA 5: Envio de Transações

**Funcionalidades:**
- ✅ Enviar transações na rede Qubic
- ✅ Assinatura automática com seed
- ✅ Conversão de unidades (QUBIC ↔ smallest unit)

**Exemplo de Uso:**

```typescript
// Inicializar conexão
await qubicWallet.initialize();

// Enviar 1 QUBIC
const amount = qubicWallet.toSmallestUnit(1.0);
const tx = await qubicWallet.sendTransaction(
  'YOUR_SEED',
  'RECIPIENT_ADDRESS',
  amount
);

console.log('TX Hash:', tx.txHash);
```

### ✅ ETAPA 8: Consulta de Saldo

**Funcionalidades:**
- ✅ Consultar saldo de qualquer endereço
- ✅ Retorna valor em QUBIC e unidades menores
- ✅ Verificação de status de transação

**Exemplo de Uso:**

```typescript
// Consultar saldo
const balance = await qubicWallet.getBalance('ADDRESS');
console.log('Balance:', balance.balanceQubic, 'QUBIC');

// Verificar transação
const status = await qubicWallet.getTransactionStatus('TX_HASH');
```

## 🧪 Testes

### Executar Suite de Testes

```bash
cd backend
npm run test:qubic
```

Este comando executa:
1. ✅ Criação de wallet
2. ✅ Consulta de saldo
3. 🔄 Envio de transação (requer wallet com fundos)
4. 🔄 Verificação de status

### Teste Manual Passo a Passo

#### 1. Criar Wallet

```bash
cd backend
npm run test:qubic
```

Isso irá gerar:
- **Public ID** (endereço): 55 caracteres maiúsculos
- **Seed**: 55 caracteres para recuperação

⚠️ **IMPORTANTE:** Salve o seed em local seguro!

#### 2. Obter Fundos (Testnet)

Opções para obter QUBIC de teste:

**Opção A: Faucet Oficial**
- Acesse: https://testnet.qubic.org/faucet
- Cole seu Public ID
- Solicite fundos

**Opção B: Discord/Telegram**
- Entre no Discord/Telegram oficial do Qubic
- Procure pelo canal de faucet
- Solicite fundos para testnet

#### 3. Verificar Saldo

Edite o script de teste para verificar seu saldo:

```typescript
// Em test-qubic-wallet.ts
await testBalanceQuery('SEU_PUBLIC_ID_AQUI');
```

#### 4. Enviar Transação

Descomente a seção de transação no script:

```typescript
const tx = await testTransaction(
  'SEU_SEED',
  'ENDERECO_DESTINO',
  1.0 // Quantidade em QUBIC
);
```

## 🔧 Configuração

### Variáveis de Ambiente

Crie/edite `backend/.env`:

```env
# Qubic Network
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org
QUBIC_WS_URL=wss://testnet-ws.qubic.org
QUBIC_EXPLORER_URL=https://testnet.qubic.org

# Platform Wallet (para escrow)
QUBIC_PLATFORM_SEED=your_platform_seed_here
QUBIC_PLATFORM_ADDRESS=your_platform_address_here

# Transaction Settings
QUBIC_CONFIRMATIONS=3
QUBIC_GAS_LIMIT=1000000
```

### Endpoints RPC Conhecidos

**Testnet:**
- RPC: `https://testnet-rpc.qubic.org`
- WebSocket: `wss://testnet-ws.qubic.org`
- Explorer: `https://testnet.qubic.org`

**Mainnet:**
- RPC: `https://rpc.qubic.org`
- WebSocket: `wss://ws.qubic.org`
- Explorer: `https://explorer.qubic.org`

## 📊 Estrutura de Arquivos

```
backend/
├── src/
│   ├── services/
│   │   ├── qubic-wallet.ts       # ✅ Nova implementação real
│   │   ├── qubic.service.ts      # 🔄 Serviço de escrow (atualizar)
│   │   └── qubic-client.ts       # 🔄 Cliente legado
│   ├── config/
│   │   └── qubic.config.ts       # ✅ Configuração
│   └── scripts/
│       └── test-qubic-wallet.ts  # ✅ Suite de testes
└── package.json                   # ✅ Dependências
```

## 🔄 Próximos Passos

### 1. Integrar com Escrow (qubic.service.ts)

Atualizar `qubic.service.ts` para usar `qubic-wallet.ts`:

```typescript
import qubicWallet from './qubic-wallet';

async createEscrow(jobId, consumer, provider, amount) {
  // Usar qubicWallet.sendTransaction() com metadata
  const tx = await qubicWallet.sendTransaction(
    platformSeed,
    platformAddress,
    amount
  );
  
  // Armazenar metadata do escrow no banco
  await prisma.escrow.create({
    data: { jobId, txHash: tx.txHash, ... }
  });
}
```

### 2. Adicionar Metadata às Transações

Qubic suporta metadata em transações. Implementar:

```typescript
interface TransactionMetadata {
  type: 'escrow_lock' | 'job_payment' | 'escrow_refund';
  jobId: string;
  provider?: string;
  timestamp: number;
}
```

### 3. Implementar Monitoramento de Transações

Criar worker para monitorar confirmações:

```typescript
async function monitorTransaction(txHash: string) {
  const status = await qubicWallet.getTransactionStatus(txHash);
  
  if (status.confirmed) {
    // Atualizar status no banco
    await updateJobStatus(jobId, 'funded');
  }
}
```

### 4. Criar Endpoints API

Adicionar rotas REST para:
- `POST /api/wallet/create` - Criar wallet
- `GET /api/wallet/:address/balance` - Consultar saldo
- `POST /api/transactions/send` - Enviar transação
- `GET /api/transactions/:hash` - Status da transação

## 🐛 Troubleshooting

### Erro: "Qubic connector not initialized"

**Solução:** Chame `await qubicWallet.initialize()` antes de usar.

### Erro: "Invalid address format"

**Solução:** Endereços Qubic têm 55 caracteres maiúsculos. Verifique o formato.

### Erro: "Insufficient balance"

**Solução:** Certifique-se de que a wallet tem fundos suficientes + taxa de rede.

### Transação não confirmada

**Solução:** 
1. Verifique o tick atual da rede
2. Aguarde alguns blocos
3. Verifique no explorer

## 📖 Recursos Adicionais

- **Documentação Oficial:** https://docs.qubic.org
- **GitHub:** https://github.com/qubic-lib/qubic-ts-library
- **Explorer Testnet:** https://testnet.qubic.org
- **Discord:** https://discord.gg/qubic

## ✅ Checklist de Implementação

- [x] Instalar @qubic-lib/qubic-ts-library
- [x] Implementar criação de wallet (ETAPA 4)
- [x] Implementar envio de transações (ETAPA 5)
- [x] Implementar consulta de saldo (ETAPA 8)
- [x] Criar suite de testes
- [ ] Obter fundos de testnet
- [ ] Testar transação real
- [ ] Integrar com sistema de escrow
- [ ] Adicionar endpoints API
- [ ] Implementar monitoramento de transações
- [ ] Documentar fluxo completo
- [ ] Testar em produção (mainnet)

## 🎉 Status Atual

✅ **Etapas 4, 5 e 8 implementadas e prontas para teste!**

Execute `npm run test:qubic` para começar.
