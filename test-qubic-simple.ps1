# Teste Simples da Integração Qubic
Write-Host "🧪 Testando Integração Qubic..." -ForegroundColor Cyan
Write-Host ""

# Teste Backend
Write-Host "1. Testando Backend (porta 3006)..." -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "http://localhost:3006/health" -Method Get -ErrorAction Stop
    Write-Host "   ✅ Backend respondendo" -ForegroundColor Green
    Write-Host "   Status: $($health.status)" -ForegroundColor Gray
} catch {
    Write-Host "   ❌ Backend não está respondendo" -ForegroundColor Red
    Write-Host "   Inicie com: cd backend; npm run dev" -ForegroundColor Yellow
}

Write-Host ""

# Teste Frontend
Write-Host "2. Testando Frontend (porta 3004)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3004" -Method Get -UseBasicParsing -ErrorAction Stop
    Write-Host "   ✅ Frontend respondendo" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Frontend não está respondendo" -ForegroundColor Red
    Write-Host "   Inicie com: cd frontend; npm run dev" -ForegroundColor Yellow
}

Write-Host ""

# Teste Endpoint Qubic
Write-Host "3. Testando Endpoint Qubic..." -ForegroundColor Yellow
try {
    $testAddr = "A" * 60  # 60 letras A
    $balance = Invoke-RestMethod -Uri "http://localhost:3006/api/qubic/balance/$testAddr" -Method Get -ErrorAction Stop
    Write-Host "   ✅ Endpoint Qubic respondendo" -ForegroundColor Green
} catch {
    Write-Host "   ⚠️  Endpoint retornou erro (esperado para endereço teste)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "=" -repeat 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "🎯 Próximo Passo:" -ForegroundColor Green
Write-Host "   Abra no navegador: http://localhost:3004/app/wallet" -ForegroundColor White
Write-Host ""
Write-Host "Para conectar carteira de teste:" -ForegroundColor Cyan
Write-Host "   Address: QUBICTESTADDRESSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" -ForegroundColor Gray
Write-Host "   Seed: qubictestseedaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" -ForegroundColor Gray
Write-Host ""
