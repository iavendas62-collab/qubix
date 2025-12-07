# 🔧 Troubleshooting - Provider Registration

## Erro: "Erro ao detectar hardware"

### Solução 1: Verificar Console do Navegador

1. Abra o DevTools (F12)
2. Vá para a aba "Console"
3. Clique em "Share My GPU" novamente
4. Veja os logs detalhados:

```
📤 Sending registration request...
   Worker ID: worker-xxxxx
   Qubic Address: QUBICTESTxxxxx
   GPU: { ... }
   CPU: { ... }
   RAM: { ... }
```

### Solução 2: Verificar Backend

Execute no terminal:

```powershell
# Testar endpoint de registro
$body = @{
    type = "browser"
    workerId = "test-worker-123"
    qubicAddress = "QUBICTESTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    gpu = @{
        model = "Test GPU"
        type = "webgl"
        vram = 8
    }
    cpu = @{
        cores = 8
        model = "Test CPU"
    }
    ram = @{
        total = 16
    }
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:3004/api/providers/quick-register" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body
```

### Solução 3: Limpar Cache e Tentar Novamente

```javascript
// No console do navegador (F12):
localStorage.clear();
location.reload();
```

### Solução 4: Usar Mock Data

Se a detecção continuar falhando, você pode registrar manualmente via API:

```powershell
# Registrar provider mock
$mockProvider = @{
    type = "browser"
    workerId = "manual-provider-001"
    qubicAddress = "QUBICTESTMANUALAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    gpu = @{
        model = "NVIDIA RTX 4090"
        type = "native"
        vram = 24
        vendor = "NVIDIA"
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
} | ConvertTo-Json

$response = Invoke-WebRequest `
    -Uri "http://localhost:3004/api/providers/quick-register" `
    -Method POST `
    -ContentType "application/json" `
    -Body $mockProvider

$response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 10
```

## Verificar se Provider Foi Registrado

```powershell
# Listar todos os providers
Invoke-WebRequest -Uri "http://localhost:3004/api/providers" -UseBasicParsing | 
    Select-Object -ExpandProperty Content | 
    ConvertFrom-Json | 
    ConvertTo-Json -Depth 10
```

## Logs Esperados (Sucesso)

No console do navegador, você deve ver:

```
⚠️ Using mock Qubic address for testing: QUBICTESTXXXXXXXXXXX
📤 Sending registration request...
   Worker ID: worker-1234567890-abc123
   Qubic Address: QUBICTESTXXXXXXXXXXX
   GPU: { model: "...", type: "webgl", ... }
📥 Response status: 200
✅ Registration response: { success: true, provider: {...} }
✅ Successfully registered as GPU provider!
```

## Erros Comuns

### Erro 1: "Invalid Qubic address format"
**Causa:** Endereço não tem 60 caracteres ou contém caracteres inválidos
**Solução:** O sistema agora gera automaticamente um endereço válido

### Erro 2: "No Qubic address found"
**Causa:** localStorage vazio e geração falhou
**Solução:** Código atualizado para gerar automaticamente

### Erro 3: "Registration failed with status 500"
**Causa:** Erro no backend (banco de dados, etc)
**Solução:** Verificar logs do backend no terminal

### Erro 4: "GPU detection failed"
**Causa:** Navegador não suporta WebGPU/WebGL
**Solução:** Sistema deve baixar worker nativo automaticamente

## Teste Rápido

Execute este comando para testar o fluxo completo:

```powershell
# Criar provider de teste
.\test-create-provider.ps1
```

Ou copie e cole no PowerShell:

```powershell
$testProvider = @{
    type = "browser"
    workerId = "quick-test-" + (Get-Date -Format "yyyyMMddHHmmss")
    qubicAddress = "QUBICTEST" + ("A" * 50)
    gpu = @{
        model = "Test GPU RTX 4090"
        type = "webgl"
        vram = 24
        vendor = "NVIDIA"
        renderer = "NVIDIA GeForce RTX 4090"
    }
    cpu = @{
        cores = 16
        model = "AMD Ryzen 9 7950X"
    }
    ram = @{
        total = 64
    }
    location = "America/Sao_Paulo"
} | ConvertTo-Json

Write-Host "Creating test provider..." -ForegroundColor Cyan
$response = Invoke-WebRequest `
    -Uri "http://localhost:3004/api/providers/quick-register" `
    -Method POST `
    -ContentType "application/json" `
    -Body $testProvider `
    -UseBasicParsing

if ($response.StatusCode -eq 200) {
    Write-Host "✅ Provider created successfully!" -ForegroundColor Green
    $data = $response.Content | ConvertFrom-Json
    Write-Host "Provider ID: $($data.provider.id)" -ForegroundColor Cyan
    Write-Host "Worker ID: $($data.provider.workerId)" -ForegroundColor Cyan
    Write-Host "GPU: $($data.provider.gpuModel)" -ForegroundColor Cyan
} else {
    Write-Host "❌ Failed to create provider" -ForegroundColor Red
    Write-Host $response.Content
}
```

## Próximos Passos

Após resolver o erro:

1. ✅ Provider registrado
2. ➡️ Verificar no marketplace: http://localhost:3004/app/marketplace
3. ➡️ Testar aluguel de GPU
4. ➡️ Submeter job
5. ➡️ Ver earnings

## Suporte

Se o problema persistir:
1. Copie os logs do console (F12)
2. Copie os logs do terminal do backend
3. Documente o erro exato
