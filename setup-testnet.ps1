# Setup Testnet Qubic - Automatizado
# Este script vai te guiar passo a passo

Write-Host ""
Write-Host "🚀 SETUP TESTNET QUBIC - QUBIX HACKATHON" -ForegroundColor Cyan
Write-Host "=" -repeat 60 -ForegroundColor Cyan
Write-Host ""

# Passo 1: Criar Carteira
Write-Host "📋 PASSO 1: Criar Carteira Qubic" -ForegroundColor Yellow
Write-Host ""
Write-Host "Vou abrir o Qubic Wallet no seu navegador..." -ForegroundColor White
Write-Host "1. Clique em 'Create New Wallet'" -ForegroundColor Gray
Write-Host "2. Copie o Address (60 caracteres)" -ForegroundColor Gray
Write-Host "3. Copie o Seed (55 caracteres)" -ForegroundColor Gray
Write-Host "4. Salve em local seguro!" -ForegroundColor Gray
Write-Host ""

Start-Process "https://wallet.qubic.li"
Start-Sleep -Seconds 3

Write-Host "Pressione Enter quando tiver criado e copiado as credenciais..." -ForegroundColor Yellow
Read-Host

# Passo 2: Solicitar QUBIC
Write-Host ""
Write-Host "📋 PASSO 2: Obter QUBIC Grátis" -ForegroundColor Yellow
Write-Host ""
Write-Host "Vou abrir o Faucet no seu navegador..." -ForegroundColor White
Write-Host "1. Cole seu Address (60 caracteres)" -ForegroundColor Gray
Write-Host "2. Clique 'Request QUBIC'" -ForegroundColor Gray
Write-Host "3. Aguarde 2-5 minutos" -ForegroundColor Gray
Write-Host ""

Start-Process "https://testnet.qubic.org/faucet"
Start-Sleep -Seconds 3

Write-Host "Pressione Enter quando tiver solicitado QUBIC..." -ForegroundColor Yellow
Read-Host

# Aguardar QUBIC chegar
Write-Host ""
Write-Host "⏳ Aguardando QUBIC chegar (2 minutos)..." -ForegroundColor Cyan
Write-Host ""

for ($i = 120; $i -gt 0; $i--) {
    Write-Progress -Activity "Aguardando QUBIC" -Status "$i segundos restantes" -PercentComplete ((120 - $i) / 120 * 100)
    Start-Sleep -Seconds 1
}

Write-Progress -Activity "Aguardando QUBIC" -Completed

# Passo 3: Verificar Backend
Write-Host ""
Write-Host "📋 PASSO 3: Verificar Backend" -ForegroundColor Yellow
Write-Host ""

try {
    $health = Invoke-RestMethod -Uri "http://localhost:3006/health" -Method Get -ErrorAction Stop
    Write-Host "✅ Backend está rodando!" -ForegroundColor Green
} catch {
    Write-Host "❌ Backend não está rodando!" -ForegroundColor Red
    Write-Host "   Inicie com: cd backend; npm run dev" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Pressione Enter quando o backend estiver rodando..." -ForegroundColor Yellow
    Read-Host
}

# Passo 4: Verificar Frontend
Write-Host ""
Write-Host "📋 PASSO 4: Verificar Frontend" -ForegroundColor Yellow
Write-Host ""

try {
    $response = Invoke-WebRequest -Uri "http://localhost:3004" -Method Get -UseBasicParsing -ErrorAction Stop
    Write-Host "✅ Frontend está rodando!" -ForegroundColor Green
} catch {
    Write-Host "❌ Frontend não está rodando!" -ForegroundColor Red
    Write-Host "   Inicie com: cd frontend; npm run dev" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Pressione Enter quando o frontend estiver rodando..." -ForegroundColor Yellow
    Read-Host
}

# Passo 5: Abrir Qubix Wallet
Write-Host ""
Write-Host "📋 PASSO 5: Conectar no Qubix" -ForegroundColor Yellow
Write-Host ""
Write-Host "Vou abrir o Qubix Wallet no seu navegador..." -ForegroundColor White
Write-Host "1. Clique 'Connect Wallet'" -ForegroundColor Gray
Write-Host "2. Cole seu Address (60 caracteres)" -ForegroundColor Gray
Write-Host "3. Cole seu Seed (55 caracteres)" -ForegroundColor Gray
Write-Host "4. Veja seu saldo aparecer!" -ForegroundColor Gray
Write-Host ""

Start-Sleep -Seconds 2
Start-Process "http://localhost:3004/app/wallet"

Write-Host ""
Write-Host "=" -repeat 60 -ForegroundColor Cyan
Write-Host "🎉 SETUP COMPLETO!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Próximos passos:" -ForegroundColor Cyan
Write-Host "   1. Conecte sua carteira no Qubix" -ForegroundColor White
Write-Host "   2. Veja seu saldo de teste" -ForegroundColor White
Write-Host "   3. Teste enviar QUBIC" -ForegroundColor White
Write-Host "   4. Teste criar escrow" -ForegroundColor White
Write-Host "   5. Grave a demo!" -ForegroundColor White
Write-Host ""
Write-Host "💡 Dica: Salve suas credenciais em local seguro!" -ForegroundColor Yellow
Write-Host ""
Write-Host "🏆 BOA SORTE NO HACKATHON!" -ForegroundColor Green
Write-Host ""
