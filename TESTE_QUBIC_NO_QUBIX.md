# 🧪 Como Testar Qubic no Qubix

## 🎯 Visão Geral

Este guia mostra como testar a integração Qubic dentro da aplicação Qubix (plataforma de computação distribuída).

## ⚡ Teste Rápido (30 segundos)

```bash
# 1. Entre no backend
cd backend

# 2. Execute o teste básico
npm run test:qubic-basico
```

**Resultado esperado**: ✅ 6/6 testes passando

---

## 📋 Cenários de Teste no Qubix

### 🎯 Cenário 1: Carteira do Consumidor

**Objetivo**: Consumidor cria carteira para pagar por jobs

```bash
cd backend
npx tsx src/scripts/exemplo-qubic.ts
```

**O que acontece:**
1. ✅ Cria carteira do consumidor
2. ✅ Exibe identity e seed
3. ✅ Valida formato

**Uso no Qubix:**
- Consumidor se registra na plataforma
- Sistema cria carteira Qubic automaticamente
- Identity é salva no banco de dados

### 🎯 Cenário 2: Carteira do Provider

**Objetivo**: Provider cria carteira para receber pagamentos

```typescript
// backend/src/scripts/test-provider-wallet.ts
import qubicWallet from '../services/qubic-wallet';

async function criarCarteiraProvider() {
  // Criar carteira
  const wallet = await qubicWallet.createWallet();
  
  console.log('🏢 Provider Wallet:');
  console.log('   Identity:', wallet.identity);
  console.log('   Seed:', wallet.seed);
  
  // Salvar no banco (exemplo)
  // await prisma.provider.update({
  //   where: { id: providerId },
  //   data: { qubicIdentity: wallet.identity }
  // });
  
  return wallet;
}

criarCarteiraProvider();
```

### 🎯 Cenário 3: Carteira da Plataforma (Escrow)

**Objetivo**: Plataforma gerencia escrow de pagamentos

```typescript
// backend/src/scripts/test-platform-wallet.ts
import qubicWallet from '../services/qubic-wallet';

async function configurarPlataforma() {
  // Criar carteira da plataforma
  const platformWallet = await qubicWallet.createWallet();
  
  console.log('🏦 Platform Wallet (Escrow):');
  console.log('   Identity:', platformWallet.identity);
  console.log('   Seed:', platformWallet.seed);
  
  console.log('\n⚠️  IMPORTANTE:');
  console.log('   1. Guarde o seed em local MUITO seguro');
  console.log('   2. Adicione ao .env como QUBIC_PLATFORM_SEED');
  console.log('   3. Esta carteira gerenciará todos os pagamentos');
  
  return platformWallet;
}

configurarPlataforma();
```

---

## 🔄 Fluxo Completo de Pagamento no Qubix

### Passo 1: Setup Inicial

```bash
# 1. Criar carteiras de teste
cd backend
npx tsx -e "
import qubicWallet from './src/services/qubic-wallet';

async function setup() {
  const consumer = await qubicWallet.createWallet();
  const provider = await qubicWallet.createWallet();
  const platform = await qubicWallet.createWallet();
  
  console.log('👤 Consumer:', consumer.identity);
  console.log('🏢 Provider:', provider.identity);
  console.log('🏦 Platform:', platform.identity);
  
  console.log('\n💾 Salve estes dados para os próximos testes!');
}

setup();
"
```

### Passo 2: Simular Job com Pagamento

```typescript
// backend/src/scripts/test-job-payment.ts
import qubicWallet from '../services/qubic-wallet';

async function simularJobComPagamento() {
  console.log('🎬 SIMULAÇÃO: Job com Pagamento Qubic\n');
  
  // 1. Criar carteiras
  console.log('1️⃣  Criando carteiras...');
  const consumer = await qubicWallet.createWallet();
  const provider = await qubicWallet.createWallet();
  const platform = await qubicWallet.createWallet();
  
  console.log('   ✅ Consumer:', consumer.identity.substring(0, 20) + '...');
  console.log('   ✅ Provider:', provider.identity.substring(0, 20) + '...');
  console.log('   ✅ Platform:', platform.identity.substring(0, 20) + '...');
  
  // 2. Simular criação de job
  console.log('\n2️⃣  Consumer cria job...');
  const job = {
    id: 'job-123',
    model: 'llama-3-8b',
    price: 10, // 10 QUBIC
    consumer: consumer.identity,
    provider: provider.identity,
    status: 'pending'
  };
  console.log('   ✅ Job criado:', job.id);
  console.log('   💰 Preço:', job.price, 'QUBIC');
  
  // 3. Simular lock de escrow
  console.log('\n3️⃣  Bloqueando pagamento em escrow...');
  console.log('   📤 Consumer → Platform:', job.price, 'QUBIC');
  console.log('   🔒 Status: LOCKED');
  
  // 4. Simular execução do job
  console.log('\n4️⃣  Provider executa job...');
  console.log('   ⏳ Processando...');
  console.log('   ✅ Job completado!');
  
  // 5. Simular release de pagamento
  console.log('\n5️⃣  Liberando pagamento...');
  const platformFee = job.price * 0.05; // 5%
  const providerAmount = job.price - platformFee;
  
  console.log('   💸 Platform → Provider:', providerAmount, 'QUBIC (95%)');
  console.log('   💰 Platform fee:', platformFee, 'QUBIC (5%)');
  console.log('   ✅ Pagamento liberado!');
  
  // 6. Resumo
  console.log('\n📊 RESUMO:');
  console.log('   Consumer pagou:', job.price, 'QUBIC');
  console.log('   Provider recebeu:', providerAmount, 'QUBIC');
  console.log('   Platform ganhou:', platformFee, 'QUBIC');
  console.log('   Status:', '✅ COMPLETO');
  
  console.log('\n💡 Para implementar de verdade:');
  console.log('   1. Financie a carteira do consumer na testnet');
  console.log('   2. Use qubicWallet.sendTransaction() para cada etapa');
  console.log('   3. Aguarde confirmações entre transações');
  console.log('   4. Salve TX hashes no banco de dados');
}

simularJobComPagamento();
```

Execute:
```bash
npx tsx src/scripts/test-job-payment.ts
```

---

## 🔗 Integração com API do Qubix

### Rota: Criar Carteira para Usuário

```typescript
// backend/src/routes/wallet.ts
import express from 'express';
import qubicWallet from '../services/qubic-wallet';
import { prisma } from '../lib/prisma';

const router = express.Router();

// POST /api/wallet/create
router.post('/create', async (req, res) => {
  try {
    const { userId, type } = req.body; // type: 'consumer' | 'provider'
    
    // Criar carteira Qubic
    const wallet = await qubicWallet.createWallet();
    
    // Salvar no banco
    await prisma.user.update({
      where: { id: userId },
      data: {
        qubicIdentity: wallet.identity,
        // NUNCA salve o seed no banco!
        // Envie para o usuário guardar
      }
    });
    
    res.json({
      success: true,
      identity: wallet.identity,
      seed: wallet.seed, // Usuário deve guardar com segurança
      message: 'Carteira criada! Guarde o seed em local seguro.'
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

export default router;
```

### Rota: Consultar Saldo

```typescript
// POST /api/wallet/balance
router.post('/balance', async (req, res) => {
  try {
    const { identity } = req.body;
    
    // Inicializar cliente
    await qubicWallet.initializeClient();
    
    // Consultar saldo
    const balance = await qubicWallet.getBalance(identity);
    
    res.json({
      success: true,
      identity: balance.identity,
      balance: balance.energyQubic,
      balanceRaw: balance.energy.toString()
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  } finally {
    await qubicWallet.close();
  }
});
```

### Rota: Criar Job com Escrow

```typescript
// POST /api/jobs/create-with-escrow
router.post('/create-with-escrow', async (req, res) => {
  try {
    const { consumerId, providerId, modelId, price } = req.body;
    
    // 1. Buscar identities
    const consumer = await prisma.user.findUnique({ where: { id: consumerId } });
    const provider = await prisma.user.findUnique({ where: { id: providerId } });
    
    if (!consumer.qubicIdentity || !provider.qubicIdentity) {
      throw new Error('Usuários precisam ter carteiras Qubic');
    }
    
    // 2. Criar job no banco
    const job = await prisma.job.create({
      data: {
        consumerId,
        providerId,
        modelId,
        price,
        status: 'pending_payment'
      }
    });
    
    // 3. Instruções para pagamento
    res.json({
      success: true,
      job: job,
      payment: {
        from: consumer.qubicIdentity,
        to: process.env.QUBIC_PLATFORM_ADDRESS, // Escrow
        amount: price,
        message: 'Envie este valor para iniciar o job'
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

---

## 🧪 Testes de Integração

### Teste 1: Criar Usuário com Carteira

```typescript
// backend/src/tests/integration/user-wallet.test.ts
import qubicWallet from '../../services/qubic-wallet';

describe('User Wallet Integration', () => {
  it('should create user with Qubic wallet', async () => {
    // Criar carteira
    const wallet = await qubicWallet.createWallet();
    
    // Validar
    expect(wallet.seed).toHaveLength(55);
    expect(wallet.identity).toHaveLength(60);
    expect(qubicWallet.validateIdentity(wallet.identity)).toBe(true);
  });
  
  it('should import existing wallet', async () => {
    // Criar carteira
    const wallet1 = await qubicWallet.createWallet();
    
    // Importar com mesmo seed
    const wallet2 = await qubicWallet.importWallet(wallet1.seed);
    
    // Deve ter mesma identity
    expect(wallet2.identity).toBe(wallet1.identity);
  });
});
```

### Teste 2: Fluxo de Pagamento

```typescript
// backend/src/tests/integration/payment-flow.test.ts
describe('Payment Flow', () => {
  it('should simulate complete payment flow', async () => {
    // Setup
    const consumer = await qubicWallet.createWallet();
    const provider = await qubicWallet.createWallet();
    const platform = await qubicWallet.createWallet();
    
    // Validar carteiras
    expect(consumer.identity).toBeDefined();
    expect(provider.identity).toBeDefined();
    expect(platform.identity).toBeDefined();
    
    // Simular valores
    const jobPrice = 10;
    const platformFee = jobPrice * 0.05;
    const providerAmount = jobPrice - platformFee;
    
    expect(providerAmount).toBe(9.5);
    expect(platformFee).toBe(0.5);
  });
});
```

---

## 📊 Dashboard de Monitoramento

### Script de Monitoramento

```typescript
// backend/src/scripts/monitor-wallets.ts
import qubicWallet from '../services/qubic-wallet';
import { prisma } from '../lib/prisma';

async function monitorarCarteiras() {
  console.log('📊 MONITOR DE CARTEIRAS QUBIX\n');
  
  // Buscar usuários com carteiras
  const users = await prisma.user.findMany({
    where: { qubicIdentity: { not: null } }
  });
  
  console.log(`👥 Total de usuários: ${users.length}\n`);
  
  // Inicializar cliente
  await qubicWallet.initializeClient();
  
  // Consultar saldos
  for (const user of users) {
    try {
      const balance = await qubicWallet.getBalance(user.qubicIdentity);
      console.log(`👤 ${user.name}`);
      console.log(`   Identity: ${user.qubicIdentity.substring(0, 20)}...`);
      console.log(`   Saldo: ${balance.energyQubic} QUBIC\n`);
    } catch (error) {
      console.log(`❌ Erro ao consultar ${user.name}: ${error.message}\n`);
    }
  }
  
  await qubicWallet.close();
}

monitorarCarteiras();
```

---

## 🚀 Comandos Úteis

### Desenvolvimento
```bash
# Teste básico (offline)
npm run test:qubic-basico

# Exemplos práticos
npm run exemplo:qubic

# Criar carteira de teste
npx tsx -e "
import qubicWallet from './src/services/qubic-wallet';
qubicWallet.createWallet().then(w => console.log(w));
"
```

### Produção
```bash
# Monitorar carteiras
npx tsx src/scripts/monitor-wallets.ts

# Verificar saldo da plataforma
npx tsx -e "
import qubicWallet from './src/services/qubic-wallet';
async function check() {
  await qubicWallet.initializeClient();
  const balance = await qubicWallet.getBalance(process.env.QUBIC_PLATFORM_ADDRESS);
  console.log('Platform balance:', balance.energyQubic, 'QUBIC');
  await qubicWallet.close();
}
check();
"
```

---

## ✅ Checklist de Testes no Qubix

### Setup Inicial
- [ ] Executar `npm run test:qubic-basico`
- [ ] Criar carteira da plataforma
- [ ] Adicionar seed ao `.env`
- [ ] Configurar nó Qubic (opcional)

### Testes de Carteira
- [ ] Criar carteira de consumidor
- [ ] Criar carteira de provider
- [ ] Importar carteira existente
- [ ] Validar identities

### Testes de Integração
- [ ] Criar usuário com carteira via API
- [ ] Consultar saldo via API
- [ ] Simular fluxo de pagamento
- [ ] Testar escrow

### Testes de Produção
- [ ] Financiar carteira na testnet
- [ ] Enviar transação real
- [ ] Verificar confirmação
- [ ] Monitorar saldos

---

## 🎯 Próximos Passos

1. **Agora**: Execute `npm run test:qubic-basico`
2. **Hoje**: Crie carteiras de teste para consumer/provider
3. **Amanhã**: Integre com rotas da API
4. **Esta semana**: Implemente sistema de escrow
5. **Próxima semana**: Teste com transações reais na testnet

---

## 📞 Suporte

- **Documentação**: `backend/GUIA_RAPIDO_QUBIC.md`
- **Exemplos**: `backend/src/scripts/exemplo-qubic.ts`
- **Testes**: `backend/src/scripts/test-qubic-basico.ts`

---

**🎉 Pronto para testar no Qubix!**  
Execute: `cd backend && npm run test:qubic-basico`
