@echo off
echo ========================================
echo QUBIX - Iniciando com Novas Portas
echo ========================================
echo.

echo Matando processos Node.js...
taskkill /F /IM node.exe 2>nul

timeout /t 2 /nobreak >nul

echo.
echo Iniciando Backend na porta 4000...
start "QUBIX Backend :4000" cmd /k "cd backend && set PORT=4000 && npm run dev"

timeout /t 5 /nobreak >nul

echo.
echo Iniciando Frontend na porta 5000...
start "QUBIX Frontend :5000" cmd /k "cd frontend && set PORT=5000 && npm run dev"

echo.
echo Aguardando servidores iniciarem...
timeout /t 10 /nobreak >nul

echo.
echo Abrindo navegador...
start http://localhost:5000/register

echo.
echo ========================================
echo QUBIX INICIADO!
echo ========================================
echo.
echo Backend: http://127.0.0.1:4000
echo Frontend: http://localhost:5000
echo.
echo Pagina de registro aberta no navegador!
echo.
pause
