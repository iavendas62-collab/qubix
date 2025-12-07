@echo off
echo Starting QUBIX servers...
echo.

echo Starting Backend Server on port 3006...
start "Backend Server" cmd /k "cd backend && node mock-server.js"

timeout /t 3 /nobreak > nul

echo Starting Frontend Server on port 3004...
start "Frontend Server" cmd /k "cd frontend && npm run dev"

echo.
echo Servers starting...
echo Backend: http://localhost:3006
echo Frontend: http://localhost:3004
echo.
echo Press any key to close this window...
pause > nul
