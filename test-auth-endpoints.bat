@echo off
echo ========================================
echo Testing Auth MVP Endpoints
echo ========================================
echo.

echo 1. Testing wallet creation...
curl -X POST http://127.0.0.1:3005/api/auth/create-wallet -H "Content-Type: application/json"
echo.
echo.

echo 2. Testing registration (will fail if backend not running)...
curl -X POST http://127.0.0.1:3005/api/auth/register-email ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@example.com\",\"password\":\"TestPass123\",\"username\":\"Test User\",\"role\":\"CONSUMER\"}"
echo.
echo.

echo 3. Testing login (will fail if user not registered)...
curl -X POST http://127.0.0.1:3005/api/auth/login-email ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@example.com\",\"password\":\"TestPass123\"}"
echo.
echo.

echo ========================================
echo Tests complete!
echo ========================================
pause
