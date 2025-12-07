# Quick Start Guide - QUBIX Backend

## Prerequisites

- Node.js 18+ installed
- Docker Desktop (recommended) OR PostgreSQL 14+ installed locally

## Setup Steps

### 1. Install Dependencies

```bash
npm install
```

### 2. Setup Database

#### Option A: Automated Setup (Recommended)

**Windows:**
```cmd
setup-database.bat
```

**Linux/macOS:**
```bash
chmod +x setup-database.sh
./setup-database.sh
```

#### Option B: Manual Setup

See [DATABASE_SETUP.md](./DATABASE_SETUP.md) for detailed instructions.

### 3. Configure Environment

The `.env` file is already configured for local development. Update if needed:

```env
DATABASE_URL="postgresql://qubix:qubix_dev_password@localhost:5432/qubix?schema=public"
```

### 4. Run Migrations (if not done automatically)

```bash
npm run migrate
```

### 5. Start the Server

```bash
npm run dev
```

The backend will be available at http://localhost:3000

## Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run migrate` - Run database migrations
- `npm run generate` - Generate Prisma client
- `npm run seed` - Seed database with sample data

## Database Management

### View Database in Prisma Studio

```bash
npx prisma studio
```

Opens a web interface at http://localhost:5555

### Reset Database

```bash
npx prisma migrate reset
```

### Create New Migration

```bash
npx prisma migrate dev --name your_migration_name
```

## Troubleshooting

### Database connection errors

1. Ensure PostgreSQL is running:
   ```bash
   docker ps | grep postgres
   ```

2. Check DATABASE_URL in `.env`

3. Test connection:
   ```bash
   npx prisma db pull
   ```

### Port already in use

If port 3000 is already in use, update `PORT` in `.env`:

```env
PORT=3001
```

### Migration errors

Reset and recreate database:

```bash
npx prisma migrate reset
npm run migrate
```

## Next Steps

1. Review the database schema in `prisma/schema.prisma`
2. Check API endpoints in `src/routes/`
3. Test Qubic integration with `npm run test:qubic`
4. Read the full documentation in `DATABASE_SETUP.md`
