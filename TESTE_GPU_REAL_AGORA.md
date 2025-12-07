# 🐜 TESTE: Detectar e Registrar GPU REAL

## 🎯 OBJETIVO
Usar o script Python para detectar sua GPU NVIDIA real e registrar no marketplace

## ✅ PRÉ-REQUISITOS

1. **GPU NVIDIA instalada**
2. **Drivers NVIDIA instalados**
3. **Python instalado** (com psutil e requests)
4. **Backend rodando** na porta 3004

## 🧪 TESTE PASSO A PASSO

### 1. Verificar se nvidia-smi funciona

```powershell
nvidia-smi
```

**Deve mostrar:**
```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 535.xx       Driver Version: 535.xx       CUDA Version: 12.x   |
|-------------------------------+----------------------+----------------------+
| GPU  Name            TCC/WDDM | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ... WDDM  | 00000000:01:00.0  On |                  N/A |
| 30%   45C    P8    15W / 350W |    500MiB / 24576MiB |      2%      Default |
+-------------------------------+----------------------+----------------------+
```

### 2. Instalar dependências Python (se necessário)

```powershell
pip install psutil requests
```

### 3. Verificar se backend está rodando

```powershell
# Testar endpoint
curl http://localhost:3004/api/providers
```

**Deve retornar:** JSON com lista de providers (pode estar vazia)

### 4. Rodar script de detecção

```powershell
python register-my-gpu.py
```

**Saída esperada:**
```
============================================================
🚀 QUBIX - Registro Automático de GPU Real
============================================================

🔍 Detectando hardware...

✅ Hardware detectado:
   GPU: NVIDIA GeForce RTX 3060 (12.0 GB)
   CPU: 8 cores
   RAM: 32.0 GB

📤 Registrando GPU no marketplace...
   GPU: NVIDIA GeForce RTX 3060
   VRAM: 12.0 GB
   CPU: 8 cores
   RAM: 32.0 GB
   Preço: 1.0 QUBIC/hora
   Worker ID: real-gpu-20241204123456

✅ GPU REGISTRADA COM SUCESSO!
   Provider ID: 123
   Status: Online

🌐 Ver no marketplace:
   http://localhost:3004/app/marketplace

💾 Informações salvas em: provider-info.json

============================================================
🎉 PRONTO! Sua GPU está no marketplace!
============================================================

📋 Próximos passos:
   1. Abra: http://localhost:3004/app/marketplace
   2. Veja sua GPU listada
   3. Cliente pode alugar e mandar jobs
```

### 5. Verificar no navegador

1. Abrir: http://localhost:3004/app/marketplace
2. Procurar sua GPU na lista
3. Deve aparecer com:
   - ✅ Nome real da GPU (ex: RTX 3060)
   - ✅ VRAM real (ex: 12 GB)
   - ✅ Status: Online
   - ✅ Preço calculado automaticamente

### 6. Verificar arquivo gerado

```powershell
cat provider-info.json
```

**Deve conter:**
```json
{
  "providerId": "123",
  "workerId": "real-gpu-20241204123456",
  "qubicAddress": "QUBICTESTABCDEF...",
  "gpu": {
    "model": "NVIDIA GeForce RTX 3060",
    "vram": 12.0,
    "vendor": "NVIDIA",
    "type": "native"
  },
  "registeredAt": "2024-12-04T12:34:56.789Z"
}
```

## ❌ POSSÍVEIS PROBLEMAS

### Problema 1: nvidia-smi não encontrado
**Erro:** `'nvidia-smi' is not recognized...`

**Solução:**
- Instalar drivers NVIDIA: https://www.nvidia.com/Download/index.aspx
- Reiniciar computador após instalação

### Problema 2: Backend não está rodando
**Erro:** `Não foi possível conectar ao backend`

**Solução:**
```powershell
cd backend
npm run dev
```

### Problema 3: Módulo Python não encontrado
**Erro:** `ModuleNotFoundError: No module named 'psutil'`

**Solução:**
```powershell
pip install psutil requests
```

### Problema 4: GPU não aparece no marketplace
**Erro:** Script roda mas GPU não aparece

**Solução:**
1. Verificar console do backend (deve mostrar POST /api/providers/quick-register)
2. Verificar se banco de dados está conectado
3. Tentar com USE_MOCK_DATA=true no .env

## 🎯 RESULTADO ESPERADO

✅ **Script roda sem erros**
✅ **GPU real detectada (não "Browser GPU")**
✅ **Provider registrado no backend**
✅ **GPU aparece no marketplace**
✅ **Arquivo provider-info.json criado**

## 📝 PRÓXIMO PASSO

Se tudo funcionou:
- ✅ GPU real registrada
- ✅ Aparece no marketplace
- ✅ Specs corretas (VRAM, cores, etc)

**Avançar para PASSO 2:** Consumer alugar essa GPU e criar job

---

## 🚀 TESTE RÁPIDO (1 comando)

```powershell
# Tudo de uma vez
python register-my-gpu.py && start http://localhost:3004/app/marketplace
```

Isso vai:
1. Detectar e registrar GPU
2. Abrir marketplace no navegador automaticamente
