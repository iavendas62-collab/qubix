# ⚡ Referência Rápida - Sincronização Supabase

## 🎯 TL;DR

Você precisa adicionar ao Supabase:
- ✅ 3 tabelas novas
- ✅ 14 colunas em tabelas existentes  
- ✅ 7 índices para performance

---

## 🚀 Execução Rápida (2 minutos)

### 1. Copie o SQL
```bash
# Abra este arquivo:
backend/sync-missing-columns-and-tables.sql
```

### 2. Execute no Supabase
1. Supabase Dashboard → SQL Editor
2. Cole o SQL
3. Run

### 3. Verifique
```bash
cd backend
node verify-schema-sync.js
```

Pronto! ✅

---

## 📊 O que será adicionado

### Tabelas Novas (3)
```
JobLog      → Logs de execução
JobMetric   → Métricas GPU em tempo real
Benchmark   → Benchmarks de performance
```

### Colunas na Tabela Job (13)
```
jobType, framework, fileName, fileUrl
requiredVRAM, requiredCompute, requiredRAM
advancedConfig, currentOperation
estimatedDuration, actualDuration
escrowTxHash, releaseTxHash
```

### Colunas na Tabela Transaction (1)
```
confirmations → Confirmações blockchain
```

### Índices (7)
```
Transaction_userId_createdAt_idx
Transaction_qubicTxHash_idx
ProviderMetric_providerId_timestamp_idx
JobLog_jobId_timestamp_idx
JobMetric_jobId_timestamp_idx
Benchmark_jobType_idx
Benchmark_gpuModel_idx
```

---

## 🔍 Verificação Rápida

### Antes de executar:
```bash
node check-supabase-schema.js
```
Deve mostrar: ❌ 3 tabelas faltando

### Depois de executar:
```bash
node verify-schema-sync.js
```
Deve mostrar: ✅ Schema 100% sincronizado!

---

## 📁 Arquivos Importantes

| Arquivo | Descrição |
|---------|-----------|
| `sync-missing-columns-and-tables.sql` | **SQL para executar** |
| `verify-schema-sync.js` | Script de verificação |
| `COMPLETE_SYNC_GUIDE.md` | Guia completo |
| `SCHEMA_DIFF_REPORT.md` | Relatório detalhado |

---

## ⚠️ Importante

- ✅ O SQL é **seguro** - usa `IF NOT EXISTS`
- ✅ Não vai **sobrescrever** dados existentes
- ✅ Pode executar **múltiplas vezes** sem problemas
- ✅ Adiciona apenas o que está **faltando**

---

## 🎯 Impacto

Após sincronizar, você terá:
- ✅ Logs em tempo real
- ✅ Monitoramento de GPU
- ✅ Estimativas de tempo precisas
- ✅ Rastreamento de pagamentos
- ✅ Matching inteligente de GPUs

---

## 💡 Dica Pro

Execute nesta ordem:
```bash
# 1. Execute o SQL no Supabase Dashboard
# 2. Verifique
node verify-schema-sync.js

# 3. Gere o Prisma Client
npx prisma generate

# 4. Teste
npm run dev
```

---

## 🆘 Problemas?

### Não consegue conectar?
→ Use SQL Manual no Supabase Dashboard

### Erro "column already exists"?
→ Normal! Significa que já existe, continue

### Erro "type does not exist"?
→ Execute primeiro: `backend/supabase-setup.sql`

---

## ✅ Checklist

- [ ] Abri o Supabase Dashboard
- [ ] Copiei o SQL de `sync-missing-columns-and-tables.sql`
- [ ] Executei no SQL Editor
- [ ] Rodei `verify-schema-sync.js`
- [ ] Vejo ✅ Schema 100% sincronizado!
- [ ] Executei `npx prisma generate`
- [ ] Testei a aplicação

---

**Tempo total:** ~2 minutos ⚡
