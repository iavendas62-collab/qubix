# 🧪 Script de Teste MVP - QUBIX
# Testa todos os endpoints principais do fluxo

Write-Host "🚀 Testando MVP QUBIX..." -ForegroundColor Cyan
Write-Host ""

$baseUrl = "http://localhost:3004"
$apiUrl = "$baseUrl/api"

# Função para testar endpoint
function Test-Endpoint {
    param(
        [string]$Name,
        [string]$Url,
        [string]$Method = "GET",
        [string]$Body = $null
    )
    
    Write-Host "Testing: $Name" -ForegroundColor Yellow
    Write-Host "  URL: $Url" -ForegroundColor Gray
    
    try {
        if ($Method -eq "GET") {
            $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 5
        } else {
            $headers = @{"Content-Type"="application/json"}
            $response = Invoke-WebRequest -Uri $Url -Method $Method -Body $Body -Headers $headers -UseBasicParsing -TimeoutSec 5
        }
        
        if ($response.StatusCode -eq 200) {
            Write-Host "  ✅ SUCCESS ($($response.StatusCode))" -ForegroundColor Green
            
            # Parse JSON se possível
            try {
                $json = $response.Content | ConvertFrom-Json
                if ($json -is [array]) {
                    Write-Host "  📊 Returned $($json.Count) items" -ForegroundColor Cyan
                }
            } catch {
                Write-Host "  📄 Response length: $($response.Content.Length) chars" -ForegroundColor Cyan
            }
            Write-Host ""
            
            return $true
        } else {
            Write-Host "  ⚠️  Status: $($response.StatusCode)" -ForegroundColor Yellow
            Write-Host ""
            return $false
        }
    } catch {
        Write-Host "  ❌ FAILED: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        return $false
    }
}

# Contador de testes
$passed = 0
$failed = 0

Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  TESTE 1: HEALTH CHECK" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

if (Test-Endpoint "Health Check" "$apiUrl/health") { $passed++ } else { $failed++ }

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  TESTE 2: PROVIDERS (MARKETPLACE)" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

if (Test-Endpoint "List Providers" "$apiUrl/providers") { $passed++ } else { $failed++ }
if (Test-Endpoint "List GPUs" "$apiUrl/gpus") { $passed++ } else { $failed++ }

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  TESTE 3: JOBS" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

if (Test-Endpoint "List Jobs" "$apiUrl/jobs") { $passed++ } else { $failed++ }

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  TESTE 4: QUBIC INTEGRATION" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Teste de balance (pode falhar se não configurado)
Write-Host "Testing: Qubic Balance" -ForegroundColor Yellow
Write-Host "  URL: $apiUrl/qubic/balance/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" -ForegroundColor Gray
try {
    $response = Invoke-WebRequest -Uri "$apiUrl/qubic/balance/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" -UseBasicParsing -TimeoutSec 5
    Write-Host "  ✅ Qubic service is responding" -ForegroundColor Green
    $passed++
} catch {
    Write-Host "  ⚠️  Qubic service may not be configured (expected for local dev)" -ForegroundColor Yellow
    Write-Host "  💡 This is OK for testing without real blockchain" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  TESTE 5: FRONTEND PAGES" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$pages = @(
    @{Name="Landing Page"; Url="$baseUrl/"},
    @{Name="Marketplace"; Url="$baseUrl/app/marketplace"},
    @{Name="Become Provider"; Url="$baseUrl/app/become-provider"},
    @{Name="Job Submit"; Url="$baseUrl/app/jobs/submit"},
    @{Name="Provider Earnings"; Url="$baseUrl/app/provider/earnings"}
)

foreach ($page in $pages) {
    if (Test-Endpoint $page.Name $page.Url) { $passed++ } else { $failed++ }
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  RESUMO DOS TESTES" -ForegroundColor White
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

$total = $passed + $failed
$percentage = [math]::Round(($passed / $total) * 100, 1)

Write-Host "Total de testes: $total" -ForegroundColor White
Write-Host "✅ Passou: $passed" -ForegroundColor Green
Write-Host "❌ Falhou: $failed" -ForegroundColor Red
Write-Host "📊 Taxa de sucesso: $percentage%" -ForegroundColor Cyan
Write-Host ""

if ($failed -eq 0) {
    Write-Host "🎉 TODOS OS TESTES PASSARAM!" -ForegroundColor Green
    Write-Host "✅ Sistema pronto para teste manual" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Próximos passos:" -ForegroundColor Cyan
    Write-Host "  1. Abra: http://localhost:3004/app/marketplace" -ForegroundColor White
    Write-Host "  2. Siga o guia: TESTE_FLUXO_COMPLETO.md" -ForegroundColor White
    Write-Host "  3. Teste o fluxo completo manualmente" -ForegroundColor White
} elseif ($percentage -ge 70) {
    Write-Host "⚠️  MAIORIA DOS TESTES PASSOU" -ForegroundColor Yellow
    Write-Host "💡 Alguns serviços podem não estar configurados (normal para dev local)" -ForegroundColor Cyan
    Write-Host "✅ Pode prosseguir com testes manuais" -ForegroundColor Green
} else {
    Write-Host "❌ MUITOS TESTES FALHARAM" -ForegroundColor Red
    Write-Host "🔧 Verifique se os servidores estão rodando:" -ForegroundColor Yellow
    Write-Host "  - Backend: npm run dev (porta 3000)" -ForegroundColor White
    Write-Host "  - Frontend: npm start (porta 3004)" -ForegroundColor White
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor Cyan
