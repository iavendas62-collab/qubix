# 🗄️ Como Iniciar o Banco de Dados

## Situação Atual

O sistema precisa de **PostgreSQL** rodando na porta `5432` para funcionar.

Você tem 3 opções:

---

## ✅ Opção 1: Instalar Docker Desktop (RECOMENDADO)

### Por que Docker?
- Mais fácil e rápido
- Não precisa instalar PostgreSQL no Windows
- Isola o banco de dados do sistema

### Passos:

1. **Baixar Docker Desktop:**
   - https://www.docker.com/products/docker-desktop/
   - Instalar e reiniciar o computador

2. **Iniciar Docker Desktop**
   - Abrir o aplicativo Docker Desktop
   - Aguardar até aparecer "Docker Desktop is running"

3. **Iniciar PostgreSQL e Redis:**
   ```powershell
   docker compose up -d postgres redis
   ```

4. **Verificar se está rodando:**
   ```powershell
   docker ps
   ```
   Deve mostrar containers `postgres` e `redis` rodando

---

## ⚙️ Opção 2: Instalar PostgreSQL no Windows

### Passos:

1. **Baixar PostgreSQL:**
   - https://www.postgresql.org/download/windows/
   - Baixar o instalador (versão 15 ou superior)

2. **Instalar:**
   - Executar o instalador
   - Senha: `qubix_dev_password` (ou anotar a senha que escolher)
   - Porta: `5432` (padrão)
   - Marcar "Launch Stack Builder" = NÃO

3. **Criar banco de dados:**
   ```powershell
   # Abrir psql (procurar "SQL Shell (psql)" no menu Iniciar)
   # Pressionar Enter para aceitar padrões
   # Digitar a senha que você criou
   
   CREATE DATABASE qubix;
   CREATE USER qubix WITH PASSWORD 'qubix_dev_password';
   GRANT ALL PRIVILEGES ON DATABASE qubix TO qubix;
   ```

4. **Atualizar .env do backend:**
   ```
   DATABASE_URL="postgresql://qubix:qubix_dev_password@localhost:5432/qubix"
   ```

5. **Rodar migrations:**
   ```powershell
   cd backend
   npx prisma migrate dev
   ```

---

## 🔧 Opção 3: Usar SQLite (Desenvolvimento Rápido)

### Vantagens:
- Não precisa instalar nada
- Banco de dados em arquivo local
- Mais rápido para testar

### Desvantagens:
- Menos recursos que PostgreSQL
- Não recomendado para produção

### Passos:

1. **Editar `backend/prisma/schema.prisma`:**
   ```prisma
   datasource db {
     provider = "sqlite"
     url      = "file:./dev.db"
   }
   ```

2. **Remover `schemas` dos models** (SQLite não suporta)
   - Procurar por `@@schema("qubix")` e remover todas as ocorrências

3. **Atualizar .env:**
   ```
   DATABASE_URL="file:./dev.db"
   ```

4. **Rodar migrations:**
   ```powershell
   cd backend
   npx prisma migrate dev --name init
   ```

---

## 🚀 Após Iniciar o Banco

1. **Rodar migrations (se ainda não rodou):**
   ```powershell
   cd backend
   npx prisma migrate dev
   ```

2. **Seed do banco (dados de teste):**
   ```powershell
   npx prisma db seed
   ```

3. **Reiniciar o backend:**
   - O backend deve conectar automaticamente

4. **Testar:**
   - Ir em My Instances
   - Clicar em "Open" em um job
   - Deve abrir a página de detalhes! 🎉

---

## 🔍 Verificar se está funcionando

```powershell
# Testar conexão com o banco
curl http://localhost:3006/api/jobs/1
```

Se retornar JSON (mesmo que seja erro "Job not found"), significa que o banco está conectado! ✅

Se retornar "Can't reach database server", o banco não está rodando. ❌

---

## 💡 Recomendação

Para desenvolvimento rápido: **Opção 1 (Docker)** ou **Opção 3 (SQLite)**

Para produção: **Opção 2 (PostgreSQL nativo)**
