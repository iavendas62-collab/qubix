# 🎬 ROTEIRO: Gravar Auto-detect e Dashboard

## 🎯 Objetivo
Mostrar a detecção automática da GPU e ela aparecendo no dashboard em tempo real.

---

## 📋 PREPARAÇÃO (Antes de Gravar)

### 1. Limpar Estado Anterior
```powershell
# Deletar arquivo de registro anterior
del provider-info.json
```

### 2. Verificar Aplicações Rodando
- ✅ Backend na porta 3006
- ✅ Frontend na porta 3004
- ✅ Ambos devem estar rodando

### 3. Abrir Abas do Navegador
- Aba 1: http://localhost:3004/app/marketplace
- Aba 2: Terminal (PowerShell)

### 4. Preparar Terminal
```powershell
# Limpar tela
cls

# Navegar para pasta do projeto
cd C:\Users\pedro\Desktop\qubic-trading-sdk
```

---

## 🎬 ROTEIRO DE GRAVAÇÃO

### CENA 1: Mostrar Marketplace Vazio (10 segundos)

**Ação:**
1. Mostrar navegador em http://localhost:3004/app/marketplace
2. Scroll pela lista de GPUs
3. Destacar que são GPUs mock (de exemplo)

**Narração:**
> "Aqui temos o marketplace com GPUs disponíveis. Agora vou adicionar minha GPU real usando auto-detecção."

---

### CENA 2: Terminal - Auto-detect (20 segundos)

**Ação:**
1. Alternar para terminal
2. Mostrar comando:
   ```powershell
   python register-my-gpu.py
   ```
3. Executar comando
4. Aguardar output completo

**Narração:**
> "Vou rodar o script de auto-detecção que usa nvidia-smi para detectar minha GPU real."

**Output Esperado:**
```
============================================================
QUBIX - Registro Automatico de GPU Real
============================================================

Detectando hardware...

Hardware detectado:
   GPU: NVIDIA GeForce MX150 (4.0 GB)
   CPU: 4 cores
   RAM: 15.9 GB

Registrando GPU no marketplace...
   GPU: NVIDIA GeForce MX150
   VRAM: 4.0 GB
   CPU: 4 cores
   RAM: 15.9 GB
   Preco: 0.5 QUBIC/hora
   Worker ID: real-gpu-XXXXXXXXXX

GPU REGISTRADA COM SUCESSO!
   Provider ID: mock-XXXXXXXXXXXXX
   Status: Online
```

---

### CENA 3: Mostrar Arquivo JSON (10 segundos)

**Ação:**
1. No terminal:
   ```powershell
   cat provider-info.json
   ```
2. Mostrar conteúdo do arquivo

**Narração:**
> "O sistema salvou as informações da GPU em um arquivo JSON."

**Output Esperado:**
```json
{
  "providerId": "mock-1764882423679",
  "workerId": "real-gpu-20251204180703",
  "qubicAddress": "HMGCVKR...",
  "gpu": {
    "model": "NVIDIA GeForce MX150",
    "vram": 4.0,
    "vendor": "NVIDIA",
    "type": "native"
  },
  "registeredAt": "2025-12-04T18:07:03.681617"
}
```

---

### CENA 4: Voltar ao Marketplace (15 segundos)

**Ação:**
1. Alternar para navegador
2. Refresh da página (F5)
3. Scroll até encontrar a MX150
4. Destacar a GPU (pode estar no topo se já estava no mock)

**Narração:**
> "Voltando ao marketplace, minha GPU MX150 agora está listada e disponível para aluguel."

---

### CENA 5: Mostrar Detalhes da GPU (10 segundos)

**Ação:**
1. Clicar na GPU MX150
2. Mostrar specs:
   - 4GB VRAM
   - 4 cores
   - 15.9GB RAM
   - 0.5 QUBIC/hora
   - Status: Online

**Narração:**
> "Aqui estão as especificações detectadas automaticamente: 4GB de VRAM, 4 cores de CPU, e preço de 0.5 QUBIC por hora."

---

## ⏱️ TEMPO TOTAL: ~65 segundos (1 minuto)

---

## 🎥 DICAS DE GRAVAÇÃO

### Antes de Gravar
- [ ] Fechar abas desnecessárias
- [ ] Limpar desktop
- [ ] Aumentar fonte do terminal (Ctrl + +)
- [ ] Aumentar zoom do navegador (Ctrl + +)
- [ ] Testar áudio
- [ ] Fazer teste de gravação

### Durante Gravação
- ✅ Falar devagar e claro
- ✅ Pausar entre comandos
- ✅ Mostrar mouse/cursor
- ✅ Aguardar outputs completos
- ✅ Não cortar muito rápido

### Depois de Gravar
- [ ] Revisar vídeo
- [ ] Cortar erros
- [ ] Adicionar música de fundo (baixo volume)
- [ ] Adicionar legendas (opcional)
- [ ] Exportar em boa qualidade (1080p)

---

## 🎯 ALTERNATIVA SIMPLIFICADA (30 segundos)

Se quiser mais rápido:

1. **Terminal:** Rodar `python register-my-gpu.py` (15s)
2. **Navegador:** Mostrar marketplace com GPU (10s)
3. **Conclusão:** "GPU detectada e registrada automaticamente" (5s)

---

## 📝 SCRIPT DE NARRAÇÃO COMPLETO

```
[CENA 1 - Marketplace]
"Aqui temos o marketplace Qubix com GPUs disponíveis para aluguel.
Agora vou adicionar minha GPU real usando auto-detecção."

[CENA 2 - Terminal]
"Vou rodar o script de auto-detecção que usa nvidia-smi 
para detectar minha GPU real."

[Aguardar output]

"Como podem ver, o sistema detectou automaticamente:
GPU NVIDIA GeForce MX150 com 4GB de VRAM,
4 cores de CPU e 15.9GB de RAM."

[CENA 3 - JSON]
"O sistema salvou as informações em um arquivo JSON
com todos os detalhes da GPU."

[CENA 4 - Marketplace]
"Voltando ao marketplace, minha GPU agora está listada
e disponível para aluguel por 0.5 QUBIC por hora."

[CENA 5 - Detalhes]
"Aqui estão as especificações detectadas automaticamente,
prontas para serem alugadas por qualquer consumidor."

[CONCLUSÃO]
"Detecção automática, registro instantâneo, 
e disponibilização no marketplace. 
Tudo integrado com blockchain Qubic."
```

---

## 🚀 COMANDO ÚNICO PARA TESTAR

```powershell
# Limpar, rodar e mostrar
cls; python register-my-gpu.py; cat provider-info.json
```

---

**Boa sorte com a gravação! 🎬🚀**
