# 🔧 Corrigir Consumer Dashboard e My Instances

## 📋 Problemas:

1. ❌ Consumer Dashboard com dados mockados
2. ❌ My Instances vazio
3. ❌ Rent não cria instância
4. ❌ Jobs não aparecem como instâncias

## ✅ Solução:

### Conceito: Jobs = Instances

No contexto do QUBIX:
- **Instance** = GPU alugada + Job rodando
- Quando você faz Rent + Submit Job = Cria uma Instance
- My Instances = Lista de Jobs (ativos e histórico)

### Fluxo Correto:

```
Rent GPU → Submit Job → Job = Instance → Aparece em My Instances
```

## 🔧 Correções Necessárias:

### 1. Consumer Dashboard
**Conectar com API de Jobs:**
```typescript
// Buscar jobs do usuário
GET /api/jobs?userId=...

// Calcular stats:
- Active Instances = jobs com status RUNNING
- Total Spent = soma de actualCost
- Hours Used = soma de durations
```

### 2. My Instances
**Mostrar Jobs como Instances:**
```typescript
// Buscar jobs do usuário
GET /api/jobs?userId=...

// Cada job é uma "instance":
{
  id: job.id,
  gpuModel: job.provider.gpuModel,
  status: job.status, // RUNNING, COMPLETED, FAILED
  startedAt: job.startedAt,
  cost: job.actualCost,
  progress: job.progress
}
```

### 3. Criar Job após Rent
**Já está redirecionando para Job Submit!**
- ✅ Rent → Redireciona para `/app/jobs/submit?gpuId=...`
- ✅ User submete job
- ✅ Job é criado
- ✅ Aparece em My Instances

## 📝 Nomenclatura AWS:

**AWS EC2:**
- Instances = Máquinas virtuais
- Running = Rodando
- Stopped = Parado
- Terminated = Terminado

**QUBIX (equivalente):**
- Instances = Jobs em GPUs alugadas
- Running = Job executando
- Completed = Job finalizado
- Failed = Job falhou

## 🎯 Implementação Rápida:

### Opção 1: Jobs = Instances (Simples)
- My Instances lista todos os jobs
- Cada job mostra GPU usada
- Status: Running/Completed/Failed

### Opção 2: Criar tabela Instances (Complexo)
- Criar modelo Instance no banco
- Rent cria Instance
- Job vincula a Instance
- My Instances lista Instances

**Recomendação: Opção 1 (mais rápido para MVP)**

## ✅ Checklist:

- [ ] Consumer Dashboard busca jobs reais
- [ ] Calcula stats baseado em jobs
- [ ] My Instances lista jobs do usuário
- [ ] Cada job mostra como "instance"
- [ ] Status colorido (verde=running, azul=completed)
- [ ] Botão para ver detalhes do job
- [ ] Botão para monitorar job ativo

## 🚀 Próximo Passo:

Vou implementar:
1. Conectar Consumer Dashboard com API
2. Fazer My Instances listar jobs
3. Adicionar filtros e status
