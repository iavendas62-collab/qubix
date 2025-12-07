# 🐜 TESTE PASSO 1: Auto-detect GPU

## ✅ O QUE VERIFICAMOS

1. **Hook useHardwareDetection** - ✅ Existe e está completo
2. **Endpoint /api/providers/quick-register** - ✅ Existe e está completo
3. **Fluxo:** Frontend detecta → Chama API → Backend registra

## 🧪 TESTE MANUAL

### Passo a Passo:

1. **Iniciar Backend**
   ```bash
   cd backend
   npm run dev
   ```

2. **Iniciar Frontend**
   ```bash
   cd frontend
   npm run dev
   ```

3. **Abrir Aplicação**
   - Ir para: http://localhost:5173
   - Login com qualquer endereço Qubic

4. **Ir para Provider → My Hardware**
   - Clicar em "Auto-Detectar"
   - Observar console do navegador
   - Observar console do backend

### O Que Deve Acontecer:

✅ **Frontend:**
- Status muda para "Detectando..."
- Detecta GPU via WebGPU ou WebGL
- Status muda para "Registrando..."
- Chama `/api/providers/quick-register`
- Status muda para "Sucesso!"
- Mostra GPU detectada

✅ **Backend:**
- Recebe POST em `/api/providers/quick-register`
- Valida dados
- Cria ou atualiza provider no banco
- Retorna success: true

✅ **Resultado:**
- GPU aparece em "My Hardware"
- Pode ver specs (modelo, VRAM, cores, RAM)
- Status: Online e Available

## 🔍 VERIFICAR NO CONSOLE

### Frontend (F12):
```
📝 Endereço Qubic: ABCD...
🔍 Detectando hardware...
✅ GPU detectada: NVIDIA GeForce RTX 3060
📡 Registrando provider...
✅ Provider registrado com sucesso!
```

### Backend:
```
POST /api/providers/quick-register
✅ Provider criado: worker-xxx
GPU: NVIDIA GeForce RTX 3060
VRAM: 12GB
```

## ❌ POSSÍVEIS PROBLEMAS

### 1. Backend não está rodando
**Sintoma:** Erro de conexão no frontend
**Solução:** Iniciar backend com `npm run dev`

### 2. Banco de dados não conectado
**Sintoma:** Erro Prisma no backend
**Solução:** 
- Verificar se PostgreSQL está rodando
- Ou usar `USE_MOCK_DATA=true` no .env

### 3. GPU não detectada
**Sintoma:** "Browser GPU" genérico
**Solução:** Normal! Navegador não expõe GPU real por segurança

### 4. Provider não aparece na lista
**Sintoma:** Lista vazia após registro
**Solução:** Verificar endpoint `/api/providers/my`

## 🎯 PRÓXIMO PASSO

Se tudo funcionar:
- ✅ Auto-detect OK
- ✅ Registro OK
- ✅ GPU aparece na lista

**Avançar para PASSO 2:** Fazer GPU aparecer no Marketplace

---

## 📝 NOTAS

- O auto-detect usa WebGPU/WebGL (limitado no navegador)
- Para demo, isso é suficiente
- GPU real seria detectada via Python script no worker nativo
- Para hackathon, foco é no fluxo, não na detecção perfeita
