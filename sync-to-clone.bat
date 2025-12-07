@echo off
echo Sincronizando mudanças do repositorio principal para o clone...

REM Copiar mudanças do frontend
if exist "frontend\src\pages\SimpleProviderRegister.tsx" (
    copy "frontend\src\pages\SimpleProviderRegister.tsx" "qubix-git\qibux-frontend\src\pages\SimpleProviderRegister.tsx"
    echo Arquivo SimpleProviderRegister.tsx copiado para o clone.
)

REM Copiar configurações do Vercel se existirem
if exist "vercel.json" (
    copy "vercel.json" "qubix-git\vercel.json"
    echo Arquivo vercel.json copiado para o clone.
)

if exist "package.json" (
    copy "package.json" "qubix-git\package.json"
    echo Arquivo package.json copiado para o clone.
)

REM Fazer commit e push no clone
cd qubix-git
git add .
git commit -m "sync: updated files from main repo"
git push origin main
cd ..

echo Sincronizacao completa!
