# Database Quick Reference Card

## 🚀 Quick Start

```bash
# Automated setup (Windows)
setup-database.bat

# Automated setup (Linux/macOS)
./setup-database.sh

# Manual setup
docker-compose up -d postgres
npm run migrate
npm run seed
```

## 📋 Common Commands

```bash
# Verify database connection
npm run db:verify

# View database in browser
npm run db:studio

# Run migrations
npm run migrate

# Generate Prisma client
npm run generate

# Seed database
npm run seed

# Reset database (⚠️ deletes all data)
npm run db:reset
```

## 🗄️ Database Models

| Model | Purpose | Key Fields |
|-------|---------|------------|
| **User** | Platform users | `qubicAddress`, `role`, `balance` |
| **Provider** | GPU providers | `workerId`, `gpuModel`, `isOnline` |
| **Job** | Compute jobs | `status`, `progress`, `estimatedCost` |
| **Transaction** | Payments | `type`, `amount`, `qubicTxHash` |
| **ProviderMetric** | GPU metrics | `gpuPercent`, `gpuTemp`, `timestamp` |

## 🔗 Relationships

```
User ──┬─→ Provider (one-to-many)
       ├─→ Job (one-to-many)
       └─→ Transaction (one-to-many)

Provider ──┬─→ Job (one-to-many)
           └─→ ProviderMetric (one-to-many)

Job ──→ Transaction (one-to-one)
```

## 💻 Code Examples

### Create User
```typescript
const user = await prisma.user.create({
  data: {
    qubicAddress: 'QUBIC_ADDRESS',
    email: 'user@example.com',
    role: 'CONSUMER',
    balance: 100.0,
  },
});
```

### Create Provider
```typescript
const provider = await prisma.provider.create({
  data: {
    workerId: 'worker_001',
    userId: user.id,
    qubicAddress: user.qubicAddress,
    type: 'NATIVE',
    gpuModel: 'NVIDIA RTX 4090',
    gpuVram: 24.0,
    cpuModel: 'AMD Ryzen 9',
    cpuCores: 16,
    ramTotal: 64.0,
    pricePerHour: 2.5,
  },
});
```

### Create Job
```typescript
const job = await prisma.job.create({
  data: {
    userId: user.id,
    modelType: 'stable-diffusion',
    computeNeeded: 10.0,
    inputData: { prompt: 'A sunset' },
    estimatedCost: 25.0,
  },
});
```

### Query with Relations
```typescript
const userWithProviders = await prisma.user.findUnique({
  where: { id: userId },
  include: {
    providers: true,
    jobs: true,
  },
});
```

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| Connection refused | `docker-compose up -d postgres` |
| Auth failed | Check `.env` DATABASE_URL |
| Migration error | `npm run db:reset` |
| Import error | `npm run generate` |
| Port in use | Stop other PostgreSQL instances |

## 📚 Documentation

- **Detailed Setup**: [DATABASE_SETUP.md](./DATABASE_SETUP.md)
- **Quick Start**: [QUICK_START.md](./QUICK_START.md)
- **Complete Guide**: [README_DATABASE.md](./README_DATABASE.md)
- **Completion Summary**: [DATABASE_SETUP_COMPLETE.md](./DATABASE_SETUP_COMPLETE.md)

## 🌐 URLs

- **Prisma Studio**: http://localhost:5555
- **Backend API**: http://localhost:3000
- **PostgreSQL**: localhost:5432

## ⚙️ Configuration

```env
# .env file
DATABASE_URL="postgresql://qubix:qubix_dev_password@localhost:5432/qubix?schema=public"
```

## 📊 Sample Data

After running `npm run seed`:
- 3 users (1 consumer, 2 providers)
- 3 GPU providers (2 online, 1 offline)
- 4 jobs (various states)
- 3 transactions
- 10 provider metrics

---

**Need Help?** Run `npm run db:verify` for diagnostics
