# 🔧 Guia de Correção - Conexão Supabase

**Problema Identificado:** Não consegue conectar ao Supabase

---

## 🎯 Problema: Porta 6543 vs 5432

### ❌ O que estava errado:
```env
DATABASE_URL="...@db.xxx.supabase.co:6543/postgres?pgbouncer=true"
```

**Porta 6543** = Connection Pooling (só funciona DENTRO do Supabase)

### ✅ Correção aplicada:
```env
DATABASE_URL="...@db.xxx.supabase.co:5432/postgres"
```

**Porta 5432** = Conexão direta (funciona de qualquer lugar)

---

## 🔍 Diagnóstico Atual

Mesmo com a porta correta (5432), ainda não conecta. Possíveis causas:

### 1. Projeto Supabase Pausado ⏸️

**Como verificar:**
1. Acesse: https://supabase.com/dashboard
2. Selecione seu projeto QUBIX
3. Verifique se aparece "Project is paused"

**Como resolver:**
- Clique em "Resume project"
- Aguarde ~2 minutos para o banco iniciar

---

### 2. Senha Incorreta 🔑

**Senha atual no .env:**
```
%40Llplac1234
```

Isso é `@Llplac1234` (URL-encoded)

**Como verificar:**
1. Supabase Dashboard → Settings → Database
2. Clique em "Reset database password"
3. Copie a nova senha
4. Atualize o `.env`

**Formato correto:**
```env
# Se a senha for: MyP@ssw0rd!
# No .env use URL-encoded:
DATABASE_URL="postgresql://postgres:MyP%40ssw0rd%21@db.xxx.supabase.co:5432/postgres"

# Ou use aspas simples e escape:
DATABASE_URL='postgresql://postgres:MyP@ssw0rd!@db.xxx.supabase.co:5432/postgres'
```

---

### 3. Firewall / IP Bloqueado 🚫

**Como verificar:**
1. Supabase Dashboard → Settings → Database
2. Role até "Connection pooling"
3. Verifique "Network Restrictions"

**Como resolver:**

**Opção A: Permitir todos os IPs (desenvolvimento)**
```
Add restriction: 0.0.0.0/0
```

**Opção B: Adicionar seu IP específico**
1. Descubra seu IP: https://whatismyipaddress.com/
2. Adicione no Supabase: `SEU_IP/32`

---

### 4. URL do Banco Incorreta 🔗

**Como obter a URL correta:**

1. Supabase Dashboard → Settings → Database
2. Procure por "Connection string"
3. Selecione **"URI"** (não Pooler)
4. Copie a string completa

**Exemplo:**
```
postgresql://postgres:[YOUR-PASSWORD]@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres
```

5. Substitua `[YOUR-PASSWORD]` pela senha real
6. URL-encode caracteres especiais:
   - `@` → `%40`
   - `!` → `%21`
   - `#` → `%23`
   - `$` → `%24`
   - `%` → `%25`

---

## ✅ Checklist de Verificação

Execute estes passos em ordem:

### Passo 1: Verificar Status do Projeto
- [ ] Projeto está ativo (não pausado)
- [ ] Aguardou 2 minutos após reativar

### Passo 2: Verificar Credenciais
- [ ] URL do banco está correta
- [ ] Senha está correta
- [ ] Senha está URL-encoded corretamente

### Passo 3: Verificar Firewall
- [ ] IP está na whitelist OU
- [ ] "Allow all IPs" está habilitado

### Passo 4: Testar Conexão
```bash
cd backend
node test-supabase-integration.js
```

Deve mostrar:
```
✅ Conexão estabelecida com sucesso
```

---

## 🚀 Solução Rápida

**Se você tem acesso ao Supabase Dashboard:**

1. **Copie a connection string correta:**
   - Settings → Database → Connection string → URI
   - Copie a string completa

2. **Atualize o `.env`:**
   ```env
   DATABASE_URL="[COLE AQUI A STRING DO SUPABASE]"
   DIRECT_URL="[MESMA STRING]"
   ```

3. **Teste:**
   ```bash
   node test-supabase-integration.js
   ```

---

## 📝 Exemplo de .env Correto

```env
# Database - Supabase PostgreSQL
DATABASE_URL="postgresql://postgres:SuaSenhaAqui@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres"
DIRECT_URL="postgresql://postgres:SuaSenhaAqui@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres"

# JWT
JWT_SECRET="qubix-super-secret-jwt-key-change-in-production-2024"

# Server
PORT=3005
NODE_ENV=development

# CORS
FRONTEND_URL=http://localhost:5173
```

---

## 🆘 Ainda não funciona?

**Me envie estas informações:**

1. **Status do projeto:**
   - Está ativo ou pausado?

2. **Connection string do Supabase:**
   - Settings → Database → Connection string (URI mode)
   - **Remova a senha antes de enviar!**
   - Exemplo: `postgresql://postgres:***@db.xxx.supabase.co:5432/postgres`

3. **Configuração de rede:**
   - Settings → Database → Network Restrictions
   - Está permitindo seu IP?

4. **Erro completo:**
   - Output do comando `node test-supabase-integration.js`

---

## 📊 Após Conectar com Sucesso

Execute estes comandos para validar tudo:

```bash
# 1. Verificar schema
node verify-schema-sync.js

# 2. Gerar Prisma Client
npx prisma generate

# 3. Testar integração completa
node test-supabase-integration.js
```

Deve mostrar:
```
🎉 TODOS OS TESTES PASSARAM!
✅ Integração com Supabase está 100% funcional
```

---

**Última atualização:** 03/12/2025  
**Status:** Aguardando correção de conexão
