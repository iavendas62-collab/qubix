@echo off
echo Sincronizando mudanças do repositorio principal para o clone...

REM Copiar mudanças do frontend
if exist "frontend\src\pages\SimpleProviderRegister.tsx" (
    copy "frontend\src\pages\SimpleProviderRegister.tsx" "qubix-git\qibux-frontend\src\pages\SimpleProviderRegister.tsx"
    echo Arquivo SimpleProviderRegister.tsx copiado para o clone.
)

REM Fazer commit e push no clone
cd qubix-git
git add .
git commit -m "sync: updated SimpleProviderRegister.tsx from main repo"
git push origin main
cd ..

echo Sincronizacao completa!
