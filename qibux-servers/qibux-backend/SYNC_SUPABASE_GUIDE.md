# 🔄 Guia de Sincronização Supabase

## Status Atual

✅ **Tabelas Existentes:**
- User
- Provider
- Job
- Transaction
- ProviderMetric

❌ **Tabelas Faltando:**
- JobLog (logs de execução)
- JobMetric (métricas em tempo real)
- Benchmark (benchmarks de performance)

✅ **ENUMs Existentes:**
- Role, ProviderType, JobStatus, TransactionType, TransactionStatus

---

## 📋 Opção 1: SQL Manual (Recomendado)

### Passo 1: Executar SQL no Supabase

1. Acesse o Supabase Dashboard
2. Vá em **SQL Editor**
3. Cole o conteúdo do arquivo `add-missing-tables.sql`
4. Clique em **Run**

### Passo 2: Verificar no Supabase

Após executar, verifique se as 3 tabelas foram criadas:
- JobLog
- JobMetric  
- Benchmark

---

## 🚀 Opção 2: Prisma Push (Automático)

Se preferir deixar o Prisma criar automaticamente:

```bash
cd backend
npx prisma db push
```

⚠️ **Atenção:** Este comando pode sobrescrever dados existentes se houver conflitos de schema.

---

## 🔍 Verificação

Execute o script de verificação:

```bash
node check-supabase-schema.js
```

Deve mostrar todas as tabelas com ✅

---

## 📊 Estrutura das Novas Tabelas

### JobLog
Armazena logs de execução dos jobs:
- `id` - UUID único
- `jobId` - Referência ao Job
- `timestamp` - Quando o log foi criado
- `level` - Nível (info, warning, error)
- `message` - Mensagem do log

### JobMetric
Métricas em tempo real durante execução:
- `id` - UUID único
- `jobId` - Referência ao Job
- `timestamp` - Quando a métrica foi coletada
- `gpuUtilization` - % de uso da GPU
- `gpuMemoryUsed` - Memória GPU usada
- `gpuMemoryTotal` - Memória GPU total
- `gpuTemperature` - Temperatura da GPU
- `powerUsage` - Consumo de energia

### Benchmark
Benchmarks de performance:
- `id` - UUID único
- `jobType` - Tipo de job (training, inference, etc)
- `gpuModel` - Modelo da GPU
- `baseTimeSeconds` - Tempo base em segundos
- `epochs`, `resolution`, `datasetSize` - Parâmetros opcionais

---

## ✅ Próximos Passos

Após sincronizar:

1. ✅ Verificar que todas as tabelas existem
2. ✅ Testar inserção de dados
3. ✅ Verificar foreign keys e índices
4. ✅ Executar seed se necessário

```bash
# Gerar Prisma Client atualizado
npx prisma generate

# (Opcional) Popular com dados de teste
npx prisma db seed
```
