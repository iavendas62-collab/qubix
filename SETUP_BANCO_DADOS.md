# 🗄️ Setup do Banco de Dados

## Opção 1: PostgreSQL Local (Recomendado para Desenvolvimento)

### Windows

```bash
# 1. Baixar PostgreSQL
# https://www.postgresql.org/download/windows/

# 2. Instalar com configurações padrão
# Usuário: postgres
# Senha: postgres (ou sua escolha)
# Porta: 5432

# 3. Criar banco de dados
psql -U postgres
CREATE DATABASE qubix;
\q

# 4. Configurar .env
# DATABASE_URL="postgresql://postgres:postgres@localhost:5432/qubix?schema=public"

# 5. Rodar migration
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
```

### Linux/Mac

```bash
# 1. Instalar PostgreSQL
# Ubuntu/Debian
sudo apt-get install postgresql postgresql-contrib

# Mac
brew install postgresql

# 2. Iniciar serviço
sudo service postgresql start  # Linux
brew services start postgresql # Mac

# 3. Criar banco
sudo -u postgres psql
CREATE DATABASE qubix;
\q

# 4. Configurar .env
# DATABASE_URL="postgresql://postgres:postgres@localhost:5432/qubix?schema=public"

# 5. Rodar migration
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
```

## Opção 2: Docker (Mais Rápido)

```bash
# 1. Iniciar PostgreSQL com Docker
docker run --name qubix-postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=qubix \
  -p 5432:5432 \
  -d postgres:15

# 2. Verificar se está rodando
docker ps

# 3. Configurar .env
# DATABASE_URL="postgresql://postgres:postgres@localhost:5432/qubix?schema=public"

# 4. Rodar migration
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
```

## Opção 3: Supabase (Cloud Grátis)

```bash
# 1. Criar conta em https://supabase.com

# 2. Criar novo projeto

# 3. Copiar Connection String
# Settings → Database → Connection String

# 4. Configurar .env
# DATABASE_URL="postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres"

# 5. Rodar migration
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
```

## Opção 4: Neon (Cloud Grátis)

```bash
# 1. Criar conta em https://neon.tech

# 2. Criar novo projeto

# 3. Copiar Connection String

# 4. Configurar .env
# DATABASE_URL="postgresql://[user]:[password]@[host]/[database]?sslmode=require"

# 5. Rodar migration
cd backend
npx prisma migrate dev --name add-auth-and-qubic-integration
```

## Verificar Conexão

```bash
cd backend

# Testar conexão
npx prisma db pull

# Ver status
npx prisma migrate status

# Abrir Prisma Studio (GUI)
npx prisma studio
```

## Comandos Úteis

```bash
# Criar migration
npx prisma migrate dev --name nome-da-migration

# Aplicar migrations em produção
npx prisma migrate deploy

# Resetar banco (CUIDADO: apaga tudo!)
npx prisma migrate reset

# Gerar Prisma Client
npx prisma generate

# Abrir Prisma Studio
npx prisma studio

# Ver schema do banco
npx prisma db pull
```

## Troubleshooting

### Erro: "Can't reach database server"
```bash
# Verificar se PostgreSQL está rodando
# Windows
services.msc # Procurar por PostgreSQL

# Linux
sudo service postgresql status

# Docker
docker ps
```

### Erro: "Authentication failed"
```bash
# Verificar credenciais no .env
# Usuário e senha devem estar corretos
```

### Erro: "Database does not exist"
```bash
# Criar banco manualmente
psql -U postgres
CREATE DATABASE qubix;
\q
```

## Próximos Passos

Depois de configurar o banco:

1. ✅ Rodar migration
2. ✅ Gerar Prisma Client
3. ✅ Testar autenticação
4. ✅ Criar usuário de teste

```bash
# Testar criação de usuário
cd backend
npm run dev

# Em outro terminal
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "senha123",
    "name": "Test User",
    "type": "CONSUMER"
  }'
```

---

**Recomendação**: Use Docker (Opção 2) para desenvolvimento rápido! 🐳
