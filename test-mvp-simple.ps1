# Script de Teste Simples MVP - QUBIX

Write-Host "🚀 Testando MVP QUBIX..." -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:3004"

Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "TESTE 1: Health Check" -ForegroundColor White
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/health" -UseBasicParsing -TimeoutSec 5
    Write-Host "✅ Health Check OK" -ForegroundColor Green
} catch {
    Write-Host "❌ Health Check FAILED" -ForegroundColor Red
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "TESTE 2: Providers API" -ForegroundColor White
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/providers" -UseBasicParsing -TimeoutSec 5
    $providers = $response.Content | ConvertFrom-Json
    Write-Host "✅ Providers API OK - $($providers.Count) providers" -ForegroundColor Green
} catch {
    Write-Host "❌ Providers API FAILED" -ForegroundColor Red
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "TESTE 3: GPUs API" -ForegroundColor White
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/gpus" -UseBasicParsing -TimeoutSec 5
    $gpus = $response.Content | ConvertFrom-Json
    Write-Host "✅ GPUs API OK - $($gpus.Count) GPUs" -ForegroundColor Green
} catch {
    Write-Host "❌ GPUs API FAILED" -ForegroundColor Red
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "TESTE 4: Jobs API" -ForegroundColor White
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

try {
    $response = Invoke-WebRequest -Uri "$baseUrl/api/jobs" -UseBasicParsing -TimeoutSec 5
    Write-Host "✅ Jobs API OK" -ForegroundColor Green
} catch {
    Write-Host "❌ Jobs API FAILED" -ForegroundColor Red
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "TESTE 5: Frontend Pages" -ForegroundColor White
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan

$pages = @(
    "Marketplace|$baseUrl/app/marketplace",
    "Become Provider|$baseUrl/app/become-provider",
    "Job Submit|$baseUrl/app/jobs/submit"
)

foreach ($page in $pages) {
    $parts = $page -split '\|'
    $name = $parts[0]
    $url = $parts[1]
    
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5
        Write-Host "✅ $name OK" -ForegroundColor Green
    } catch {
        Write-Host "❌ $name FAILED" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ TESTES CONCLUÍDOS" -ForegroundColor Green
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Cyan
Write-Host "  1. Abra: http://localhost:3004/app/marketplace" -ForegroundColor White
Write-Host "  2. Siga o guia: TESTE_FLUXO_COMPLETO.md" -ForegroundColor White
Write-Host ""
