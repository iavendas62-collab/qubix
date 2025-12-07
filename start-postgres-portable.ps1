# Script para rodar PostgreSQL Portable (sem instalação)
# Usa PostgreSQL via Chocolatey ou baixa versão portable

Write-Host "🗄️  Iniciando PostgreSQL..." -ForegroundColor Cyan

# Verificar se PostgreSQL já está rodando
$pgRunning = Get-Process -Name postgres -ErrorAction SilentlyContinue
if ($pgRunning) {
    Write-Host "✅ PostgreSQL já está rodando!" -ForegroundColor Green
    exit 0
}

# Opção 1: Tentar usar Chocolatey
Write-Host "📦 Verificando Chocolatey..." -ForegroundColor Yellow
$chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue

if ($chocoInstalled) {
    Write-Host "✅ Chocolatey encontrado! Instalando PostgreSQL..." -ForegroundColor Green
    choco install postgresql15 -y --params '/Password:qubix_dev_password /Port:5432'
    
    # Aguardar serviço iniciar
    Start-Sleep -Seconds 5
    
    # Criar banco de dados
    $env:PGPASSWORD = "qubix_dev_password"
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -c "CREATE DATABASE qubix;"
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -c "CREATE USER qubix WITH PASSWORD 'qubix_dev_password';"
    & "C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE qubix TO qubix;"
    
    Write-Host "✅ PostgreSQL instalado e configurado!" -ForegroundColor Green
    exit 0
}

# Opção 2: Instruções para instalação manual
Write-Host ""
Write-Host "❌ Chocolatey não encontrado." -ForegroundColor Red
Write-Host ""
Write-Host "📋 OPÇÕES PARA INSTALAR POSTGRESQL:" -ForegroundColor Yellow
Write-Host ""
Write-Host "OPÇÃO 1 - Instalar Chocolatey (Recomendado):" -ForegroundColor Cyan
Write-Host "  1. Abrir PowerShell como Administrador"
Write-Host "  2. Executar:"
Write-Host "     Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
Write-Host "  3. Fechar e abrir novo PowerShell"
Write-Host "  4. Executar: .\start-postgres-portable.ps1"
Write-Host ""
Write-Host "OPÇÃO 2 - Instalar PostgreSQL manualmente:" -ForegroundColor Cyan
Write-Host "  1. Baixar: https://www.postgresql.org/download/windows/"
Write-Host "  2. Instalar com senha: qubix_dev_password"
Write-Host "  3. Porta: 5432"
Write-Host "  4. Criar banco:"
Write-Host "     - Abrir SQL Shell (psql)"
Write-Host "     - CREATE DATABASE qubix;"
Write-Host "     - CREATE USER qubix WITH PASSWORD 'qubix_dev_password';"
Write-Host "     - GRANT ALL PRIVILEGES ON DATABASE qubix TO qubix;"
Write-Host ""
Write-Host "OPÇÃO 3 - Usar dados mockados (sem banco):" -ForegroundColor Cyan
Write-Host "  O sistema já tem dados de teste em memória!"
Write-Host "  Jobs ID 1, 2, 3 já existem e funcionam."
Write-Host "  Limitação: Dados não persistem após reiniciar."
Write-Host ""

exit 1
