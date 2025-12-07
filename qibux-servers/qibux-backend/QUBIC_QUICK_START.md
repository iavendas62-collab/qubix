# Qubic Integration Quick Start Guide

## 🚀 Quick Start

### 1. Setup Environment

```bash
# .env file
QUBIC_PLATFORM_SEED=your-55-char-lowercase-seed
QUBIC_PLATFORM_ADDRESS=your-60-char-uppercase-identity
QUBIC_NETWORK=testnet
```

### 2. Test the Service

```bash
cd backend
npx tsx src/scripts/test-qubic-service-basic.ts
```

### 3. Use in Code

```typescript
import qubicService from './services/qubic.service';

// Initialize
await qubicService.initialize();

// Connect wallet
const wallet = await qubicService.connectWallet();
console.log(`Address: ${wallet.address}`);
console.log(`Balance: ${wallet.balance} QUBIC`);

// Get balance (cached for 30s)
const balance = await qubicService.getBalance(address);
console.log(`Balance: ${balance.balanceQubic} QUBIC`);
console.log(`Cached: ${balance.cached}`);

// Create transaction
const tx = await qubicService.createTransaction(
  fromSeed,
  toAddress,
  10.5, // amount in QUBIC
  { type: 'payment' } // optional metadata
);
console.log(`TX Hash: ${tx.hash}`);
console.log(`Explorer: ${qubicService.getExplorerUrl(tx.hash)}`);

// Wait for confirmation
await qubicService.waitForConfirmation(tx.hash, 3, (current, required) => {
  console.log(`Confirmations: ${current}/${required}`);
});
```

## 📡 API Endpoints

### Connect Wallet

```bash
curl -X POST http://localhost:3000/api/qubic/wallet/connect \
  -H "Content-Type: application/json" \
  -d '{"seed": "optional-55-char-seed"}'
```

### Get Balance

```bash
curl http://localhost:3000/api/qubic/balance/YOUR_60_CHAR_IDENTITY
```

### Create Transaction

```bash
curl -X POST http://localhost:3000/api/qubic/transaction \
  -H "Content-Type: application/json" \
  -d '{
    "fromSeed": "your-55-char-seed",
    "toAddress": "recipient-60-char-identity",
    "amount": 10.5,
    "metadata": {"type": "payment"}
  }'
```

### Create Escrow

```bash
curl -X POST http://localhost:3000/api/qubic/escrow/lock \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "job-123",
    "consumerSeed": "consumer-seed",
    "providerAddress": "provider-identity",
    "amount": 50.0
  }'
```

### Release Payment

```bash
curl -X POST http://localhost:3000/api/qubic/escrow/release \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "job-123",
    "providerAddress": "provider-identity",
    "amount": 50.0
  }'
```

### Get Transaction Status

```bash
curl http://localhost:3000/api/qubic/transaction/TX_HASH
```

### Get Explorer URL

```bash
curl http://localhost:3000/api/qubic/explorer/TX_HASH
```

## 🔧 Common Use Cases

### Job Escrow Flow

```typescript
// 1. Create escrow when job launches
const escrowTx = await qubicService.createEscrow(
  jobId,
  consumerSeed,
  providerAddress,
  50.0 // amount in QUBIC
);

// 2. Wait for confirmation
await qubicService.waitForConfirmation(escrowTx, 3);

// 3. Job executes...

// 4. On success: release payment
const releaseTx = await qubicService.releasePayment(
  jobId,
  providerAddress,
  50.0
);
// Provider receives: 47.5 QUBIC (50 - 5% fee)
// Platform keeps: 2.5 QUBIC

// 5. On failure: refund consumer
const refundTx = await qubicService.refundEscrow(
  jobId,
  consumerAddress,
  50.0
);
```

### Balance Monitoring

```typescript
// Get balance (uses cache if < 30s old)
const balance1 = await qubicService.getBalance(address);
console.log(`Balance: ${balance1.balanceQubic} QUBIC (cached: ${balance1.cached})`);

// Force fresh balance
qubicService.clearBalanceCache(address);
const balance2 = await qubicService.getBalance(address);
console.log(`Fresh balance: ${balance2.balanceQubic} QUBIC`);
```

### Transaction Monitoring

```typescript
// Create transaction
const tx = await qubicService.createTransaction(seed, toAddress, amount);

// Poll for status
const checkStatus = async () => {
  const status = await qubicService.verifyTransaction(tx.hash);
  console.log(`Status: ${status.status}`);
  console.log(`Confirmations: ${status.confirmations}/3`);
  
  if (status.status === 'confirmed') {
    console.log('Transaction confirmed!');
  } else if (status.status === 'failed') {
    console.log('Transaction failed!');
  } else {
    // Check again in 2 seconds
    setTimeout(checkStatus, 2000);
  }
};

checkStatus();
```

## 🔐 Security Best Practices

### 1. Seed Management

```typescript
// ✅ Good: Never log full seed
console.log(`Seed: ${seed.substring(0, 10)}...`);

// ❌ Bad: Logging full seed
console.log(`Seed: ${seed}`);
```

### 2. Environment Variables

```bash
# ✅ Good: Store in .env (gitignored)
QUBIC_PLATFORM_SEED=your-seed

# ❌ Bad: Hardcoded in code
const seed = "mysecretseeddonttellanyone...";
```

### 3. Input Validation

```typescript
// ✅ Good: Validate before use
if (!qubicService.validateIdentity(address)) {
  throw new Error('Invalid identity format');
}

// ❌ Bad: No validation
await qubicService.getBalance(userInput);
```

## 🐛 Troubleshooting

### Connection Timeout

```
Error: Balance request timeout
```

**Solution:** Check network connectivity to Qubic RPC endpoint

```bash
# Test connection
curl https://testnet-rpc.qubic.org/health
```

### Invalid Identity Format

```
Error: Invalid Qubic identity format
```

**Solution:** Ensure identity is 60 uppercase characters

```typescript
const identity = 'ABCD...'; // Must be 60 chars, uppercase
```

### Insufficient Balance

```
Error: Insufficient balance
```

**Solution:** Check balance before transaction

```typescript
const balance = await qubicService.getBalance(address);
if (balance.balanceQubic < amount) {
  throw new Error('Insufficient balance');
}
```

### Cache Issues

```
Balance seems stale
```

**Solution:** Clear cache to force fresh query

```typescript
qubicService.clearBalanceCache(address);
const freshBalance = await qubicService.getBalance(address);
```

## 📊 Monitoring

### Health Check

```typescript
// Check if service is initialized
try {
  await qubicService.initialize();
  console.log('✅ Service healthy');
} catch (error) {
  console.error('❌ Service unhealthy:', error);
}
```

### Platform Balance

```typescript
// Monitor platform wallet balance
const platformBalance = await qubicService.getBalance(
  process.env.QUBIC_PLATFORM_ADDRESS
);

if (platformBalance.balanceQubic < 100) {
  console.warn('⚠️  Platform balance low!');
}
```

### Transaction Success Rate

```typescript
let successCount = 0;
let failCount = 0;

// Track transaction outcomes
try {
  await qubicService.createTransaction(...);
  successCount++;
} catch (error) {
  failCount++;
}

const successRate = successCount / (successCount + failCount);
console.log(`Success rate: ${(successRate * 100).toFixed(2)}%`);
```

## 🎯 Performance Tips

### 1. Use Balance Cache

```typescript
// ✅ Good: Let cache work
const balance = await qubicService.getBalance(address);

// ❌ Bad: Clearing cache unnecessarily
qubicService.clearBalanceCache(address);
const balance = await qubicService.getBalance(address);
```

### 2. Batch Operations

```typescript
// ✅ Good: Batch balance queries
const addresses = ['addr1', 'addr2', 'addr3'];
const balances = await Promise.all(
  addresses.map(addr => qubicService.getBalance(addr))
);

// ❌ Bad: Sequential queries
for (const addr of addresses) {
  await qubicService.getBalance(addr); // Slow!
}
```

### 3. Async Confirmation Polling

```typescript
// ✅ Good: Non-blocking confirmation
qubicService.waitForConfirmation(txHash, 3)
  .then(() => console.log('Confirmed!'))
  .catch(err => console.error('Failed:', err));

// Continue with other work...

// ❌ Bad: Blocking confirmation
await qubicService.waitForConfirmation(txHash, 3); // Blocks for up to 2 minutes
```

## 📚 Additional Resources

- **Full Documentation:** `backend/QUBIC_INTEGRATION_COMPLETE.md`
- **Test Scripts:** `backend/src/scripts/test-qubic-*.ts`
- **API Routes:** `backend/src/routes/qubic.ts`
- **Service Code:** `backend/src/services/qubic.service.ts`
- **Qubic Docs:** https://docs.qubic.org
- **Qubic Explorer:** https://explorer.qubic.org

## ✅ Checklist

Before going to production:

- [ ] Platform wallet configured with seed
- [ ] Platform wallet funded with QUBIC
- [ ] RPC endpoints verified for mainnet
- [ ] Explorer URLs tested
- [ ] Integration tests passing
- [ ] Monitoring setup
- [ ] Error alerting configured
- [ ] Rate limiting implemented
- [ ] Backup seed stored securely

---

**Need Help?** Check the full documentation in `QUBIC_INTEGRATION_COMPLETE.md`
