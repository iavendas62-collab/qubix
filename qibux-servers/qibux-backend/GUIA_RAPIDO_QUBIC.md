# 🚀 Guia Rápido - Integração Qubic

## ✅ Status da Integração

A biblioteca oficial `@qubic-lib/qubic-ts-library` está **totalmente integrada** e pronta para uso!

## 📦 O que foi feito

1. ✅ Instalada biblioteca oficial `@qubic-lib/qubic-ts-library` v0.1.6
2. ✅ Implementado serviço de carteira (`qubic-wallet.ts`)
3. ✅ Criado script de teste (`test-qubic-wallet.ts`)
4. ✅ Integradas todas as funcionalidades principais:
   - Criação de carteiras
   - Importação via seed
   - Consulta de saldo
   - Envio de transações
   - Validação de identidades

## 🎯 Como Usar

### 1. Testar a Integração

```bash
cd backend
npx ts-node src/scripts/test-qubic-wallet.ts
```

Este script irá:
- ✅ Criar uma nova carteira Qubic
- ✅ Exibir identity e seed
- ✅ Consultar saldo (será 0 para carteira nova)

### 2. Usar no Código

```typescript
import qubicWallet from './services/qubic-wallet';

// Criar carteira
const wallet = await qubicWallet.createWallet();
console.log('Identity:', wallet.identity);
console.log('Seed:', wallet.seed); // GUARDE COM SEGURANÇA!

// Consultar saldo
await qubicWallet.initializeClient();
const balance = await qubicWallet.getBalance(wallet.identity);
console.log('Saldo:', balance.energyQubic, 'QUBIC');

// Enviar transação (precisa de saldo)
const amount = qubicWallet.toSmallestUnit(1.0); // 1 QUBIC
const tx = await qubicWallet.sendTransaction(
  'seu-seed-aqui',
  'IDENTITY_DESTINO',
  amount
);
console.log('TX Hash:', tx.hash);

// Fechar conexão
await qubicWallet.close();
```

### 3. Exemplo Completo

```typescript
async function exemploCompleto() {
  try {
    // 1. Criar carteira
    const wallet = await qubicWallet.createWallet();
    console.log('✅ Carteira criada:', wallet.identity);
    
    // 2. Inicializar conexão
    await qubicWallet.initializeClient();
    console.log('✅ Conectado à rede Qubic');
    
    // 3. Consultar saldo
    const balance = await qubicWallet.getBalance(wallet.identity);
    console.log('💰 Saldo:', balance.energyQubic, 'QUBIC');
    
    // 4. Se tiver saldo, enviar transação
    if (balance.energyQubic > 0) {
      const amount = qubicWallet.toSmallestUnit(0.1);
      const tx = await qubicWallet.sendTransaction(
        wallet.seed,
        'IDENTITY_DESTINO',
        amount
      );
      console.log('📤 Transação enviada:', tx.hash);
    }
    
    // 5. Fechar
    await qubicWallet.close();
    
  } catch (error) {
    console.error('❌ Erro:', error);
  }
}
```

## 🔑 Funcionalidades Disponíveis

### Criação de Carteira
```typescript
const wallet = await qubicWallet.createWallet();
// Retorna: { seed, identity, index }
```

### Importar Carteira
```typescript
const wallet = await qubicWallet.importWallet('seu-seed-de-55-caracteres');
```

### Consultar Saldo
```typescript
await qubicWallet.initializeClient();
const balance = await qubicWallet.getBalance('IDENTITY');
// Retorna: { identity, energy, energyQubic }
```

### Enviar Transação
```typescript
const amount = qubicWallet.toSmallestUnit(1.5); // 1.5 QUBIC
const tx = await qubicWallet.sendTransaction(
  'sender-seed',
  'recipient-identity',
  amount
);
// Retorna: { hash, from, to, amount }
```

### Validar Identity
```typescript
const isValid = qubicWallet.validateIdentity('IDENTITY_AQUI');
```

### Conversões
```typescript
// QUBIC para menor unidade
const units = qubicWallet.toSmallestUnit(1.5); // 1500000000

// Menor unidade para QUBIC
const qubic = qubicWallet.toQubic(1500000000n); // 1.5
```

## 🌐 Configuração de Rede

Edite `backend/src/config/qubic.config.ts`:

```typescript
export const QUBIC_CONFIG = {
  network: 'testnet', // ou 'mainnet'
  rpcEndpoint: 'https://testnet-rpc.qubic.org',
  // ...
};
```

## 🔐 Variáveis de Ambiente

Crie/edite `backend/.env`:

```env
# Rede Qubic
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org

# Carteira da Plataforma (para escrow)
QUBIC_PLATFORM_SEED=seu-seed-da-plataforma-aqui
QUBIC_PLATFORM_ADDRESS=sua-identity-da-plataforma-aqui
```

## 📊 Estrutura dos Dados

### WalletInfo
```typescript
{
  seed: string;        // 55 caracteres lowercase
  identity: string;    // Identity pública (60+ chars uppercase hex)
  index: number;       // Índice da carteira (padrão: 0)
}
```

### BalanceInfo
```typescript
{
  identity: string;    // Identity consultada
  energy: bigint;      // Saldo em menor unidade
  energyQubic: number; // Saldo em QUBIC (energy / 1e9)
}
```

### TransactionResult
```typescript
{
  hash: string;        // Hash da transação
  from: string;        // Identity remetente
  to: string;          // Identity destinatário
  amount: bigint;      // Valor em menor unidade
}
```

## 🧪 Testes

### Teste Básico (sem saldo necessário)
```bash
npx ts-node src/scripts/test-qubic-wallet.ts
```

### Teste com Transação (precisa de saldo)
Edite `test-qubic-wallet.ts` e descomente a seção de teste de transação:

```typescript
const tx = await testTransaction(
  wallet.seed,
  'IDENTITY_DESTINO',
  0.1 // 0.1 QUBIC
);
```

## 💡 Dicas Importantes

1. **Seeds são sensíveis**: Nunca compartilhe ou commite seeds no git
2. **Testnet primeiro**: Sempre teste na testnet antes de usar mainnet
3. **Saldo necessário**: Transações precisam de saldo + taxa
4. **Tick atual**: Transações usam o tick atual + buffer
5. **Conexão assíncrona**: Aguarde conexão antes de consultar saldo

## 🐛 Troubleshooting

### "Connector not initialized"
```typescript
// Sempre inicialize antes de usar
await qubicWallet.initializeClient();
```

### "Insufficient balance"
```typescript
// Verifique saldo antes de enviar
const balance = await qubicWallet.getBalance(identity);
if (balance.energyQubic < amount) {
  console.log('Saldo insuficiente');
}
```

### "Invalid seed format"
```typescript
// Seed deve ter exatamente 55 caracteres lowercase
const seed = 'abcdefghijklmnopqrstuvwxyz...'; // 55 chars
```

### "Balance request timeout"
```typescript
// Aguarde conexão estabilizar
await qubicWallet.initializeClient();
await new Promise(resolve => setTimeout(resolve, 2000));
const balance = await qubicWallet.getBalance(identity);
```

## 📚 Próximos Passos

1. ✅ Integração básica completa
2. ⏳ Testar com carteira financiada na testnet
3. ⏳ Implementar sistema de escrow
4. ⏳ Integrar com rotas da API
5. ⏳ Adicionar monitoramento de transações

## 🔗 Links Úteis

- [Documentação Qubic](https://qubic.org)
- [qubic-ts-library no NPM](https://www.npmjs.com/package/@qubic-lib/qubic-ts-library)
- [Qubic Explorer](https://explorer.qubic.org)
- [Qubic GitHub](https://github.com/qubic)

## 📞 Suporte

Para dúvidas sobre a integração, consulte:
- `QUBIC_LIBRARY_INTEGRATION.md` - Detalhes técnicos
- `QUBIC_INTEGRATION_GUIDE.md` - Guia de integração original
- Código fonte em `backend/src/services/qubic-wallet.ts`

---

**Status**: ✅ Pronto para uso!  
**Última atualização**: 29/11/2025
