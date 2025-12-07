#!/bin/bash

# QUBIX Demo Runner
# Starts all services for demo

echo "╔═══════════════════════════════════════╗"
echo "║   🚀 QUBIX DEMO LAUNCHER             ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting QUBIX services...${NC}"
echo ""

# Start Docker services
echo "📦 Starting Docker services (PostgreSQL, Redis)..."
docker-compose up -d postgres redis

# Wait for services
echo "⏳ Waiting for services to be ready..."
sleep 5

# Check if services are running
if docker ps | grep -q postgres; then
    echo -e "${GREEN}✅ PostgreSQL is running${NC}"
else
    echo "❌ PostgreSQL failed to start"
    exit 1
fi

if docker ps | grep -q redis; then
    echo -e "${GREEN}✅ Redis is running${NC}"
else
    echo "❌ Redis failed to start"
    exit 1
fi

echo ""
echo "🔧 Setting up backend..."

# Backend setup
cd backend

if [ ! -d "node_modules" ]; then
    echo "📦 Installing backend dependencies..."
    npm install
fi

# Run migrations
echo "🗄️  Running database migrations..."
npx prisma migrate dev --name init || echo "Migrations already applied"

# Generate Prisma client
echo "🔨 Generating Prisma client..."
npx prisma generate

# Start backend in background
echo "🚀 Starting backend server..."
npm run dev &
BACKEND_PID=$!

cd ..

echo ""
echo "🎨 Setting up frontend..."

# Frontend setup
cd frontend

if [ ! -d "node_modules" ]; then
    echo "📦 Installing frontend dependencies..."
    npm install
fi

# Start frontend in background
echo "🚀 Starting frontend server..."
npm start &
FRONTEND_PID=$!

cd ..

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   ✅ QUBIX IS RUNNING!               ║"
echo "╠═══════════════════════════════════════╣"
echo "║   Frontend:  http://localhost:3000   ║"
echo "║   Backend:   http://localhost:3001   ║"
echo "║   API Docs:  http://localhost:3001/api ║"
echo "╚═══════════════════════════════════════╝"
echo ""
echo "📝 Demo Instructions:"
echo ""
echo "1. Open browser: http://localhost:3000"
echo "2. Explore dashboard"
echo "3. Submit a test job"
echo "4. Register as provider"
echo "5. Browse model hub"
echo ""
echo "Press Ctrl+C to stop all services"
echo ""

# Wait for user interrupt
trap "echo ''; echo 'Stopping services...'; kill $BACKEND_PID $FRONTEND_PID; docker-compose down; echo 'Done!'; exit" INT

# Keep script running
wait
