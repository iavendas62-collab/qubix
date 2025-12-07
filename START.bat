@echo off
echo ========================================
echo INICIANDO QUBIX
echo ========================================
echo.

echo Matando processos na porta 3005...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3005') do taskkill /F /PID %%a 2>nul

echo.
echo Iniciando Backend...
start "QUBIX Backend" cmd /k "cd backend && npm run dev"

timeout /t 3 /nobreak >nul

echo.
echo Iniciando Frontend...
start "QUBIX Frontend" cmd /k "cd frontend && npm run dev"

echo.
echo ========================================
echo QUBIX INICIADO!
echo ========================================
echo.
echo Backend: http://127.0.0.1:3005
echo Frontend: http://localhost:3000
echo.
echo Aguarde alguns segundos e acesse:
echo http://localhost:3000/register
echo.
pause
