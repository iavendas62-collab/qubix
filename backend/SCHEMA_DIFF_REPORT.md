# 📊 Relatório de Diferenças: Supabase vs Prisma Schema

## 🔍 Análise Completa

### ✅ Tabelas Existentes no Supabase
- User
- Provider
- Job
- Transaction
- ProviderMetric

### ❌ Tabelas Faltando no Supabase
- **JobLog** - Logs de execução dos jobs
- **JobMetric** - Métricas em tempo real (GPU, memória)
- **Benchmark** - Benchmarks de performance

---

## 📋 Colunas Faltantes por Tabela

### Tabela: Job
**Colunas que existem no Prisma mas faltam no Supabase:**

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `jobType` | TEXT | Tipo do job (training, inference, custom_script) |
| `framework` | TEXT | Framework usado (pytorch, tensorflow) |
| `fileName` | TEXT | Nome do arquivo enviado |
| `fileUrl` | TEXT | URL do arquivo no storage |
| `requiredVRAM` | DOUBLE | VRAM mínima necessária (GB) |
| `requiredCompute` | DOUBLE | Poder computacional necessário |
| `requiredRAM` | DOUBLE | RAM mínima necessária (GB) |
| `advancedConfig` | JSONB | Configurações avançadas |
| `currentOperation` | TEXT | Operação atual em execução |
| `estimatedDuration` | INTEGER | Duração estimada (segundos) |
| `actualDuration` | INTEGER | Duração real (segundos) |
| `escrowTxHash` | TEXT | Hash da transação de escrow |
| `releaseTxHash` | TEXT | Hash da transação de release |

**Total: 13 colunas faltando**

### Tabela: Transaction
**Colunas que existem no Prisma mas faltam no Supabase:**

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| `confirmations` | INTEGER | Número de confirmações na blockchain |

**Total: 1 coluna faltando**

---

## 🎯 Índices Faltantes

### Transaction
- `Transaction_userId_createdAt_idx` - Para queries de histórico por usuário
- `Transaction_qubicTxHash_idx` - Para busca por hash de transação

### ProviderMetric
- `ProviderMetric_providerId_timestamp_idx` - Para queries de métricas por provider

---

## 📝 Resumo de Ações Necessárias

### 1. Adicionar Colunas
- ✅ 13 colunas na tabela `Job`
- ✅ 1 coluna na tabela `Transaction`

### 2. Criar Tabelas
- ✅ `JobLog` (4 colunas + índice)
- ✅ `JobMetric` (7 colunas + índice)
- ✅ `Benchmark` (9 colunas + 2 índices)

### 3. Criar Índices
- ✅ 2 índices para `Transaction`
- ✅ 1 índice para `ProviderMetric`
- ✅ 1 índice para `JobLog`
- ✅ 1 índice para `JobMetric`
- ✅ 2 índices para `Benchmark`

---

## 🚀 Como Aplicar as Mudanças

### Opção 1: SQL Manual (Recomendado)
1. Abra o Supabase Dashboard
2. Vá em **SQL Editor**
3. Cole o conteúdo de `sync-missing-columns-and-tables.sql`
4. Execute

### Opção 2: Prisma Push (Automático)
```bash
cd backend
npx prisma db push
```

⚠️ **Atenção:** Certifique-se de ter backup antes de executar!

---

## ✅ Verificação Pós-Execução

Após executar o SQL, verifique:

```bash
node check-supabase-schema.js
```

Deve mostrar:
- ✅ Todas as 8 tabelas existentes
- ✅ Todos os ENUMs existentes
- ✅ Nenhuma tabela faltando

---

## 📊 Impacto das Mudanças

### Funcionalidades que dependem dessas mudanças:

1. **JobLog** - Sistema de logs em tempo real
2. **JobMetric** - Monitoramento de GPU/CPU durante execução
3. **Benchmark** - Estimativa de tempo de execução
4. **Job.escrowTxHash** - Rastreamento de pagamentos
5. **Job.requiredVRAM** - Matching inteligente de GPUs
6. **Transaction.confirmations** - Status de confirmação blockchain

---

## 🔧 Troubleshooting

### Se o Prisma não conectar:
1. Verifique se o Supabase está ativo
2. Confirme as credenciais no `.env`
3. Teste a conexão: `node test-db-connection.js`

### Se houver erro de coluna duplicada:
- Algumas colunas podem já existir
- O SQL usa `IF NOT EXISTS` para evitar erros
- Execute mesmo assim, ele vai pular as que já existem

### Se houver erro de tipo de dados:
- Verifique se os ENUMs estão criados
- Execute primeiro o `supabase-setup.sql` se necessário
