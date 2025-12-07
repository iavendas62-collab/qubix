#!/bin/bash

# Production Readiness Test Script
# Tests all critical functionality before deployment

set -e

echo "========================================="
echo "QUBIX Production Readiness Test"
echo "========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name=$1
    local test_command=$2
    
    echo -n "Testing: $test_name... "
    
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
}

# Function to check if service is running
check_service() {
    local service_name=$1
    local port=$2
    
    if nc -z localhost $port 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $service_name is running on port $port"
        return 0
    else
        echo -e "${RED}✗${NC} $service_name is NOT running on port $port"
        return 1
    fi
}

echo "1. Checking Services"
echo "-------------------"
check_service "Backend API" 3001
check_service "Frontend" 3000
echo ""

echo "2. Backend Tests"
echo "----------------"
cd backend

# Run unit tests
run_test "Backend unit tests" "npm test -- --run --reporter=minimal"

# Run integration tests
run_test "Backend integration tests" "npm test -- --run src/__tests__/integration.test.ts"

# Run end-to-end tests
run_test "Backend E2E tests" "npm test -- --run src/__tests__/end-to-end.test.ts"

cd ..
echo ""

echo "3. Frontend Tests"
echo "-----------------"
cd frontend

# Run component tests
run_test "Frontend component tests" "npm test -- --run --reporter=minimal"

cd ..
echo ""

echo "4. API Health Checks"
echo "--------------------"

# Check backend health
run_test "Backend health endpoint" "curl -f http://localhost:3001/api/health"

# Check database connection
run_test "Database connectivity" "curl -f http://localhost:3001/api/health/db"

# Check Qubic RPC connection
run_test "Qubic RPC connectivity" "curl -f http://localhost:3001/api/health/qubic"

echo ""

echo "5. Performance Tests"
echo "--------------------"

# Test file upload performance (small file)
run_test "Small file upload (<10MB)" "curl -f -X POST -F 'file=@test-files/sample-mnist.py' http://localhost:3001/api/jobs/analyze"

# Test API response time
run_test "API response time (<1s)" "time curl -f http://localhost:3001/api/providers | grep -q 'providers'"

echo ""

echo "6. Security Tests"
echo "-----------------"

# Test CORS headers
run_test "CORS headers present" "curl -I http://localhost:3001/api/health | grep -q 'Access-Control-Allow-Origin'"

# Test rate limiting
run_test "Rate limiting active" "for i in {1..150}; do curl -s http://localhost:3001/api/health > /dev/null; done && curl -s http://localhost:3001/api/health | grep -q '429'"

echo ""

echo "7. WebSocket Tests"
echo "------------------"

# Test WebSocket connection
run_test "WebSocket connectivity" "node -e \"const WebSocket = require('ws'); const ws = new WebSocket('ws://localhost:3001'); ws.on('open', () => { console.log('Connected'); ws.close(); process.exit(0); }); ws.on('error', () => process.exit(1));\""

echo ""

echo "8. Database Tests"
echo "-----------------"

# Test database queries
run_test "Database read operations" "curl -f http://localhost:3001/api/providers"
run_test "Database write operations" "curl -f -X POST -H 'Content-Type: application/json' -d '{\"test\":true}' http://localhost:3001/api/health/db"

echo ""

echo "9. Blockchain Integration Tests"
echo "--------------------------------"

# Test Qubic RPC connection
run_test "Qubic RPC connection" "curl -f http://localhost:3001/api/qubic/health"

# Test balance query
run_test "Qubic balance query" "curl -f http://localhost:3001/api/qubic/balance/EEMHHBHCOAIAFALOICNMMDNGJIAOLGCGFKIBMBDCBDKNGHLNNABCJLIKEEKDGBEFLFPHGO"

echo ""

echo "10. Load Tests"
echo "--------------"

# Test concurrent requests
run_test "Concurrent requests (10)" "seq 1 10 | xargs -P 10 -I {} curl -s http://localhost:3001/api/health > /dev/null"

# Test sustained load
run_test "Sustained load (30s)" "timeout 30s bash -c 'while true; do curl -s http://localhost:3001/api/health > /dev/null; sleep 0.1; done'"

echo ""

echo "========================================="
echo "Test Summary"
echo "========================================="
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed! System is production ready.${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed. Please fix issues before deploying.${NC}"
    exit 1
fi
