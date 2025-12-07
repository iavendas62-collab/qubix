@echo off
echo Sincronizando mudanças do clone para o repositorio principal...

REM Copiar mudanças do clone
if exist "qubix-git\qibux-frontend\src\pages\SimpleProviderRegister.tsx" (
    copy "qubix-git\qibux-frontend\src\pages\SimpleProviderRegister.tsx" "frontend\src\pages\SimpleProviderRegister.tsx"
    echo Arquivo SimpleProviderRegister.tsx copiado do clone.
)

REM Fazer commit e push no repositorio principal
git add .
git commit -m "sync: updated SimpleProviderRegister.tsx from clone"
git push origin master

echo Sincronizacao do clone para principal completa!
