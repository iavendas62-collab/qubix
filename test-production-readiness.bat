@echo off
REM Production Readiness Test Script for Windows
REM Tests all critical functionality before deployment

setlocal enabledelayedexpansion

echo =========================================
echo QUBIX Production Readiness Test
echo =========================================
echo.

set TESTS_PASSED=0
set TESTS_FAILED=0

echo 1. Checking Services
echo -------------------
call :check_service "Backend API" 3001
call :check_service "Frontend" 3000
echo.

echo 2. Backend Tests
echo ----------------
cd backend
call npm test -- --run --reporter=minimal
if %ERRORLEVEL% EQU 0 (
    set /a TESTS_PASSED+=1
    echo [PASSED] Backend tests
) else (
    set /a TESTS_FAILED+=1
    echo [FAILED] Backend tests
)
cd ..
echo.

echo 3. Frontend Tests
echo -----------------
cd frontend
call npm test -- --run --reporter=minimal
if %ERRORLEVEL% EQU 0 (
    set /a TESTS_PASSED+=1
    echo [PASSED] Frontend tests
) else (
    set /a TESTS_FAILED+=1
    echo [FAILED] Frontend tests
)
cd ..
echo.

echo 4. API Health Checks
echo --------------------
curl -f http://localhost:3001/api/health
if %ERRORLEVEL% EQU 0 (
    set /a TESTS_PASSED+=1
    echo [PASSED] Backend health endpoint
) else (
    set /a TESTS_FAILED+=1
    echo [FAILED] Backend health endpoint
)
echo.

echo =========================================
echo Test Summary
echo =========================================
echo Tests Passed: %TESTS_PASSED%
echo Tests Failed: %TESTS_FAILED%
echo.

if %TESTS_FAILED% EQU 0 (
    echo [SUCCESS] All tests passed! System is production ready.
    exit /b 0
) else (
    echo [ERROR] Some tests failed. Please fix issues before deploying.
    exit /b 1
)

:check_service
netstat -an | findstr ":%~2" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] %~1 is running on port %~2
) else (
    echo [ERROR] %~1 is NOT running on port %~2
)
goto :eof
