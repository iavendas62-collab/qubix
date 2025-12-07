# Setup do Supabase para QUBIX

## Status Atual

✅ **Conexão com Supabase funcionando**
- Banco de dados: `db.kkbvkjwhmstrapyzvfcw.supabase.co`
- Conexão testada e confirmada

❌ **Tabelas do QUBIX não criadas**
- O banco tem 6 tabelas existentes de outros projetos
- As tabelas do QUBIX precisam ser criadas

## O que falta fazer:

### Opção 1: Criar as tabelas manualmente no Supabase Dashboard

1. Acesse: https://supabase.com/dashboard/project/kkbvkjwhmstrapyzvfcw
2. Vá em "SQL Editor"
3. Cole e execute o SQL do arquivo: `backend/prisma/migrations/20241130000000_init/migration.sql`
4. Cole e execute o SQL do arquivo: `backend/prisma/migrations/20241202000000_add_benchmarks_table/migration.sql`

### Opção 2: Usar um banco de dados limpo

1. Crie um novo projeto no Supabase
2. Atualize as credenciais no `backend/.env`
3. Execute: `cd backend && npx prisma migrate deploy`

### Opção 3: Continuar sem banco (modo degradado)

O backend pode rodar sem banco de dados, mas com funcionalidade limitada:
- ✅ API endpoints funcionam
- ✅ WebSocket funciona
- ❌ Não salva dados
- ❌ Não persiste usuários/jobs

## Recomendação

**Use a Opção 1** - É a mais rápida e não afeta as tabelas existentes.

Basta copiar o conteúdo dos arquivos SQL e executar no SQL Editor do Supabase.

## Depois de criar as tabelas:

1. Reinicie o backend: `cd backend && npm run dev`
2. O backend vai conectar automaticamente
3. Teste o login no frontend: http://localhost:3000
