# 🔍 QUBIC RESEARCH GUIDE

## 🎯 Objective
Find the correct information to replace placeholders in the code with real Qubic integration.

---

## 📚 Step 1: Find Official Documentation

### Primary Resources
1. **Official Docs**: https://docs.qubic.org/
2. **GitHub**: https://github.com/qubic
3. **Discord**: Join Qubic Discord for developer support
4. **Medium/Blog**: Check for integration tutorials

### What to Look For
- [ ] Testnet RPC endpoint URL
- [ ] Testnet WebSocket URL
- [ ] Testnet block explorer URL
- [ ] Testnet faucet URL
- [ ] Transaction structure
- [ ] Address format (confirmed 55 characters?)
- [ ] How to sign transactions
- [ ] Available SDKs/libraries

---

## 🔧 Step 2: Find SDK/Library

### Option A: Official TypeScript SDK
```bash
# Check if this exists:
npm search @qubic-lib/qubic-ts-library
# or
npm search qubic-ts
```

**If found**, check:
- Installation command
- Basic usage example
- How to create wallet
- How to send transaction
- How to query balance

### Option B: JavaScript Library
```bash
npm search qubic-js
npm search qubic
```

### Option C: Direct RPC (Fallback)
If no SDK exists, we'll use direct HTTP/WebSocket calls to RPC endpoint.

**Need to find**:
- RPC endpoint URL
- RPC methods available
- Request/response format
- Authentication (if any)

---

## 💰 Step 3: Setup Testnet Wallet

### Create Wallet
1. Find wallet creation method:
   - Browser extension?
   - CLI tool?
   - Web interface?
   - SDK method?

2. Generate testnet wallet:
   ```
   Address: XXXXX... (55 characters)
   Private key/Seed: Keep secure!
   ```

3. Save credentials:
   ```bash
   # Add to .env
   QUBIC_PLATFORM_SEED=your_seed_here
   QUBIC_PLATFORM_ADDRESS=your_address_here
   ```

### Get Testnet Tokens
1. Find testnet faucet URL
2. Request tokens (usually 100-1000 for testing)
3. Verify balance received

---

## 🔍 Step 4: Verify Transaction Structure

### Find Out:
1. **Transaction Format**
   ```json
   {
     "from": "address",
     "to": "address",
     "amount": "number",
     "metadata": "optional?",
     "signature": "required?"
   }
   ```

2. **Metadata Support**
   - Can we add custom data to transactions?
   - Format: JSON? String? Bytes?
   - Size limit?

3. **Signing Process**
   - What algorithm? (Ed25519? Secp256k1?)
   - How to sign?
   - Where to include signature?

4. **Broadcasting**
   - RPC method name?
   - Response format?
   - How to get transaction hash?

---

## 🌐 Step 5: Find Explorer

### Testnet Explorer
- [ ] Find URL (e.g., https://testnet.qubic.org)
- [ ] Test with sample transaction
- [ ] Verify transaction details visible
- [ ] Check address lookup works

### What Explorer Should Show
- Transaction hash
- From/To addresses
- Amount
- Timestamp
- Confirmations
- Metadata (if supported)

---

## 📝 Step 6: Document Findings

### Create: `QUBIC_INTEGRATION_NOTES.md`

```markdown
# Qubic Integration Notes

## Network Information
- Testnet RPC: [URL]
- Testnet WS: [URL]
- Explorer: [URL]
- Faucet: [URL]

## SDK Information
- Package: [name]
- Version: [version]
- Install: npm install [package]
- Docs: [URL]

## Wallet
- Address format: [55 chars, uppercase?]
- Private key format: [seed phrase? hex?]
- Platform address: [your address]

## Transaction Structure
[Paste example transaction JSON]

## Code Examples
[Paste working code snippets]

## Limitations Found
- [List any limitations]
- [Workarounds needed]

## Next Steps
- [What needs to be implemented]
```

---

## 🚨 Common Issues & Solutions

### Issue: No TypeScript SDK
**Solution**: Use JavaScript SDK or direct RPC calls

### Issue: Testnet is down
**Solution**: 
1. Check Discord for status
2. Try mainnet (with caution)
3. Mock transactions for demo (last resort)

### Issue: No metadata support
**Solution**: 
1. Store job mapping in database
2. Use transaction amount as identifier
3. Create separate registry contract

### Issue: Faucet not working
**Solution**:
1. Ask in Discord
2. Use mainnet with small amounts
3. Ask team for testnet tokens

---

## ✅ Checklist Before Coding

- [ ] Found testnet RPC endpoint
- [ ] Found testnet explorer
- [ ] Created testnet wallet
- [ ] Got testnet tokens
- [ ] Sent test transaction
- [ ] Verified transaction on explorer
- [ ] Understand transaction structure
- [ ] Know how to sign transactions
- [ ] Have SDK or RPC method documented

---

## 🔧 Update Code Locations

Once you have the information, update these files:

### 1. `backend/src/config/qubic.config.ts`
```typescript
rpcEndpoint: 'REAL_URL_HERE',
wsEndpoint: 'REAL_URL_HERE',
explorerUrl: 'REAL_URL_HERE',
```

### 2. `backend/src/services/qubic.service.ts`
Replace all `TODO` comments with real implementation:
- `initialize()` - Real SDK initialization
- `getBalance()` - Real RPC call
- `sendTransaction()` - Real transaction creation
- `getTransaction()` - Real transaction query

### 3. `.env.example`
```bash
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://...
QUBIC_EXPLORER_URL=https://...
QUBIC_PLATFORM_SEED=your_seed
QUBIC_PLATFORM_ADDRESS=your_address
```

---

## 📞 Need Help?

### Resources
1. **Qubic Discord**: Ask in #developers channel
2. **GitHub Issues**: Check existing issues
3. **Stack Overflow**: Search for "qubic blockchain"
4. **Reddit**: r/qubic (if exists)

### Questions to Ask
- "What's the testnet RPC endpoint?"
- "Is there a TypeScript SDK?"
- "How do I create a testnet wallet?"
- "Where's the testnet faucet?"
- "Can transactions include metadata?"

---

## 🎯 Success Criteria

You're ready to code when you can:
1. ✅ Connect to testnet RPC
2. ✅ Query balance of an address
3. ✅ Create and sign a transaction
4. ✅ Broadcast transaction to network
5. ✅ Get transaction hash
6. ✅ View transaction on explorer
7. ✅ Wait for confirmations

---

## 📊 Time Estimate

- Research: 2-3 hours
- Wallet setup: 30 minutes
- First transaction: 1 hour
- Documentation: 30 minutes

**Total: 4-5 hours**

---

## 🚀 Next Steps

After completing research:
1. Update `DAY_1_PROGRESS.md` with findings
2. Update code with real implementation
3. Test first transaction
4. Verify on explorer
5. Move to Day 2 (Escrow implementation)

**Good luck! 🍀**
