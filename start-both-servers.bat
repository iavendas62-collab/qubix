@echo off
echo ========================================
echo     QIBUX SERVERS - START SCRIPT
echo ========================================
echo.

echo Starting Qibux Backend Server...
start "Qibux Backend" cmd /k "cd qibux-backend && npm install && npm run dev"

timeout /t 3 /nobreak >nul

echo Starting Qibux Frontend Server...
start "Qibux Frontend" cmd /k "cd qibux-frontend && npm install && npm run dev"

echo.
echo ========================================
echo Servers starting...
echo Backend: http://localhost:3006
echo Frontend: http://localhost:3000
echo ========================================
echo.
echo Press any key to close this window...
pause >nul
