# 🎯 Guia Completo de Sincronização Supabase

## 📊 Situação Atual

Baseado na análise do seu schema atual, identificamos:

### ✅ O que já existe:
- 5 tabelas principais: User, Provider, Job, Transaction, ProviderMetric
- Todos os ENUMs necessários
- Estrutura básica funcionando

### ❌ O que está faltando:
- **3 tabelas novas:** JobLog, JobMetric, Benchmark
- **13 colunas na tabela Job** (jobType, framework, fileName, etc)
- **1 coluna na tabela Transaction** (confirmations)
- **7 índices** para melhorar performance

---

## 🚀 Passo a Passo para Sincronizar

### Opção 1: SQL Manual no Supabase (RECOMENDADO)

#### 1. Abra o Supabase Dashboard
- Acesse: https://supabase.com/dashboard
- Selecione seu projeto QUBIX

#### 2. Vá para o SQL Editor
- Menu lateral → SQL Editor
- Clique em "New query"

#### 3. Cole o SQL de Sincronização
Copie TODO o conteúdo do arquivo:
```
backend/sync-missing-columns-and-tables.sql
```

#### 4. Execute
- Clique em "Run" ou pressione Ctrl+Enter
- Aguarde a execução (deve levar ~5 segundos)

#### 5. Verifique o Resultado
Execute no terminal:
```bash
cd backend
node verify-schema-sync.js
```

Deve mostrar: ✅ Schema 100% sincronizado!

---

### Opção 2: Prisma Push (Automático)

⚠️ **Atenção:** Só use se conseguir conectar ao Supabase

```bash
cd backend
npx prisma db push
```

Se der erro de conexão, use a Opção 1.

---

## 📋 O que o SQL vai fazer?

### Parte 1: Adicionar Colunas
```sql
-- Na tabela Job (13 novas colunas)
ALTER TABLE "Job" ADD COLUMN "jobType" TEXT;
ALTER TABLE "Job" ADD COLUMN "framework" TEXT;
ALTER TABLE "Job" ADD COLUMN "fileName" TEXT;
-- ... e mais 10 colunas

-- Na tabela Transaction (1 nova coluna)
ALTER TABLE "Transaction" ADD COLUMN "confirmations" INTEGER;
```

### Parte 2: Criar Tabelas
```sql
-- JobLog: Para logs de execução
CREATE TABLE "JobLog" (...);

-- JobMetric: Para métricas em tempo real
CREATE TABLE "JobMetric" (...);

-- Benchmark: Para estimativas de performance
CREATE TABLE "Benchmark" (...);
```

### Parte 3: Criar Índices
```sql
-- Para melhorar performance de queries
CREATE INDEX "Transaction_userId_createdAt_idx" ...;
CREATE INDEX "JobLog_jobId_timestamp_idx" ...;
-- ... e mais 5 índices
```

---

## ✅ Verificação Pós-Sincronização

### 1. Verificar Schema
```bash
node verify-schema-sync.js
```

Deve mostrar:
```
✅ User
✅ Provider
✅ Job
✅ Transaction
✅ ProviderMetric
✅ JobLog
✅ JobMetric
✅ Benchmark

✅ Schema 100% sincronizado!
```

### 2. Testar Conexão
```bash
node test-db-connection.js
```

### 3. Gerar Prisma Client
```bash
npx prisma generate
```

---

## 🎯 Funcionalidades que Dependem Disso

Após sincronizar, estas funcionalidades vão funcionar:

1. **Sistema de Logs** (JobLog)
   - Logs em tempo real durante execução
   - Histórico de operações

2. **Monitoramento de GPU** (JobMetric)
   - Uso de GPU/CPU em tempo real
   - Temperatura e consumo de energia

3. **Estimativa de Tempo** (Benchmark)
   - Previsão de duração baseada em benchmarks
   - Cálculo de custo mais preciso

4. **Rastreamento de Pagamentos** (escrowTxHash, releaseTxHash)
   - Tracking de transações blockchain
   - Status de escrow

5. **Matching Inteligente** (requiredVRAM, requiredCompute)
   - Encontrar GPU ideal para cada job
   - Validação de requisitos

---

## 🔧 Troubleshooting

### Erro: "column already exists"
✅ **Normal!** O SQL usa `IF NOT EXISTS`, então vai pular colunas que já existem.

### Erro: "relation already exists"
✅ **Normal!** Significa que a tabela já foi criada antes.

### Erro: "cannot connect to database"
❌ **Problema de conexão**
- Verifique se o Supabase está ativo
- Confirme as credenciais no `.env`
- Use a Opção 1 (SQL Manual)

### Erro: "type does not exist"
❌ **ENUMs faltando**
- Execute primeiro: `backend/supabase-setup.sql`
- Depois execute: `backend/sync-missing-columns-and-tables.sql`

---

## 📊 Arquivos Criados

1. **sync-missing-columns-and-tables.sql** - SQL completo de sincronização
2. **SCHEMA_DIFF_REPORT.md** - Relatório detalhado das diferenças
3. **verify-schema-sync.js** - Script de verificação
4. **COMPLETE_SYNC_GUIDE.md** - Este guia

---

## 🎉 Próximos Passos

Após sincronizar com sucesso:

1. ✅ Gerar Prisma Client: `npx prisma generate`
2. ✅ Testar a aplicação: `npm run dev`
3. ✅ Verificar logs no console
4. ✅ Testar criação de jobs
5. ✅ Verificar métricas em tempo real

---

## 💡 Dicas

- **Backup:** O Supabase faz backup automático, mas você pode exportar antes
- **Rollback:** Se algo der errado, você pode restaurar do backup
- **Teste:** Execute em ambiente de desenvolvimento primeiro
- **Documentação:** Mantenha este guia para referência futura

---

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs do Supabase
2. Execute `verify-schema-sync.js` para diagnóstico
3. Consulte `SCHEMA_DIFF_REPORT.md` para detalhes
