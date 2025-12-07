#!/bin/bash

# QUBIX Test Setup Script
# Tests all components of the system

echo "╔═══════════════════════════════════════╗"
echo "║   🧪 QUBIX TEST SUITE                ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0

test_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ PASS${NC}: $2"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAIL${NC}: $2"
        ((FAILED++))
    fi
}

echo "📦 Testing Prerequisites..."
echo ""

# Test Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    test_result 0 "Node.js installed ($NODE_VERSION)"
else
    test_result 1 "Node.js not found"
fi

# Test npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    test_result 0 "npm installed ($NPM_VERSION)"
else
    test_result 1 "npm not found"
fi

# Test Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    test_result 0 "Python installed ($PYTHON_VERSION)"
else
    test_result 1 "Python not found"
fi

# Test Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    test_result 0 "Docker installed ($DOCKER_VERSION)"
else
    test_result 1 "Docker not found"
fi

# Test PostgreSQL
if command -v psql &> /dev/null; then
    PSQL_VERSION=$(psql --version)
    test_result 0 "PostgreSQL installed ($PSQL_VERSION)"
else
    test_result 1 "PostgreSQL not found (optional for local dev)"
fi

# Test Redis
if command -v redis-cli &> /dev/null; then
    REDIS_VERSION=$(redis-cli --version)
    test_result 0 "Redis installed ($REDIS_VERSION)"
else
    test_result 1 "Redis not found (optional for local dev)"
fi

echo ""
echo "📁 Testing Project Structure..."
echo ""

# Test backend files
test -f "backend/package.json" && test_result 0 "backend/package.json exists" || test_result 1 "backend/package.json missing"
test -f "backend/tsconfig.json" && test_result 0 "backend/tsconfig.json exists" || test_result 1 "backend/tsconfig.json missing"
test -f "backend/prisma/schema.prisma" && test_result 0 "Prisma schema exists" || test_result 1 "Prisma schema missing"

# Test frontend files
test -f "frontend/package.json" && test_result 0 "frontend/package.json exists" || test_result 1 "frontend/package.json missing"
test -f "frontend/vite.config.ts" && test_result 0 "Vite config exists" || test_result 1 "Vite config missing"

# Test worker files
test -f "worker/qubix_worker.py" && test_result 0 "Worker client exists" || test_result 1 "Worker client missing"
test -f "worker/requirements.txt" && test_result 0 "Worker requirements exists" || test_result 1 "Worker requirements missing"

# Test contracts
test -f "contracts/JobEscrow.cpp" && test_result 0 "JobEscrow contract exists" || test_result 1 "JobEscrow contract missing"
test -f "contracts/ProviderRegistry.cpp" && test_result 0 "ProviderRegistry contract exists" || test_result 1 "ProviderRegistry contract missing"

# Test documentation
test -f "README.md" && test_result 0 "README.md exists" || test_result 1 "README.md missing"
test -f "docs/ARCHITECTURE.md" && test_result 0 "Architecture docs exist" || test_result 1 "Architecture docs missing"
test -f "docs/API.md" && test_result 0 "API docs exist" || test_result 1 "API docs missing"

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║   📊 TEST RESULTS                    ║"
echo "╠═══════════════════════════════════════╣"
echo -e "║   ${GREEN}Passed: $PASSED${NC}                        ║"
echo -e "║   ${RED}Failed: $FAILED${NC}                        ║"
echo "╚═══════════════════════════════════════╝"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed! Ready to run QUBIX.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Start services: docker-compose up -d"
    echo "2. Install backend: cd backend && npm install"
    echo "3. Install frontend: cd frontend && npm install"
    echo "4. Run migrations: cd backend && npm run migrate"
    echo "5. Start backend: cd backend && npm run dev"
    echo "6. Start frontend: cd frontend && npm start"
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed. Please fix issues before running.${NC}"
    exit 1
fi
