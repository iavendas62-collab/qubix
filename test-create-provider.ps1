# Script para criar provider de teste

Write-Host "🧪 Criando Provider de Teste..." -ForegroundColor Cyan
Write-Host ""

$testProvider = @{
    type = "browser"
    workerId = "test-provider-" + (Get-Date -Format "yyyyMMddHHmmss")
    qubicAddress = "QUBICTEST" + ("A" * 50)
    gpu = @{
        model = "NVIDIA GeForce RTX 4090"
        type = "webgl"
        vram = 24
        vendor = "NVIDIA"
        renderer = "NVIDIA GeForce RTX 4090"
        description = "High-end GPU for AI/ML workloads"
    }
    cpu = @{
        cores = 16
        model = "AMD Ryzen 9 7950X"
    }
    ram = @{
        total = 64
    }
    location = "America/Sao_Paulo"
    pricePerHour = 2.0
} | ConvertTo-Json -Depth 10

Write-Host "📤 Enviando requisição..." -ForegroundColor Yellow
Write-Host "   Endpoint: http://localhost:3004/api/providers/quick-register" -ForegroundColor Gray
Write-Host ""

try {
    $response = Invoke-WebRequest `
        -Uri "http://localhost:3004/api/providers/quick-register" `
        -Method POST `
        -ContentType "application/json" `
        -Body $testProvider `
        -UseBasicParsing

    if ($response.StatusCode -eq 200) {
        Write-Host "✅ PROVIDER CRIADO COM SUCESSO!" -ForegroundColor Green
        Write-Host ""
        
        $data = $response.Content | ConvertFrom-Json
        
        Write-Host "📋 Detalhes do Provider:" -ForegroundColor Cyan
        Write-Host "   ID: $($data.provider.id)" -ForegroundColor White
        Write-Host "   Worker ID: $($data.provider.workerId)" -ForegroundColor White
        Write-Host "   GPU: $($data.provider.gpuModel)" -ForegroundColor White
        Write-Host "   VRAM: $($data.provider.gpuVram) GB" -ForegroundColor White
        Write-Host "   CPU: $($data.provider.cpuModel)" -ForegroundColor White
        Write-Host "   RAM: $($data.provider.ramTotal) GB" -ForegroundColor White
        Write-Host "   Preço: $($data.provider.pricePerHour) QUBIC/hora" -ForegroundColor White
        Write-Host "   Status: Online" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "🌐 Verificar no Marketplace:" -ForegroundColor Cyan
        Write-Host "   http://localhost:3004/app/marketplace" -ForegroundColor White
        Write-Host ""
        
        # Abrir marketplace automaticamente
        Start-Process "http://localhost:3004/app/marketplace"
    } else {
        Write-Host "❌ Falha ao criar provider" -ForegroundColor Red
        Write-Host "   Status: $($response.StatusCode)" -ForegroundColor Yellow
        Write-Host "   Response: $($response.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ ERRO ao criar provider" -ForegroundColor Red
    Write-Host "   $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "💡 Verifique se o backend está rodando:" -ForegroundColor Cyan
    Write-Host "   http://localhost:3004/api/health" -ForegroundColor White
}
