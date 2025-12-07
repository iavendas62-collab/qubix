# 🧪 Como Testar a Integração Qubic

## ⚡ Teste Rápido (2 minutos)

```bash
cd backend
npm run test:qubic-basico
```

**Resultado esperado**: ✅ 6/6 testes passando (100%)

## 📋 Opções de Teste

### 1. Teste Básico (Sem Rede) ⭐ RECOMENDADO
```bash
npm run test:qubic-basico
```

**O que testa:**
- ✅ Criação de carteiras
- ✅ Importação de carteiras
- ✅ Validação de identities
- ✅ Conversões de valores
- ✅ Validação de seeds
- ✅ Múltiplas carteiras

**Tempo**: ~2 segundos  
**Requer**: Nada (funciona offline)  
**Status**: ✅ 100% funcionando

### 2. Teste com Rede (Requer Nó)
```bash
npm run test:qubic
```

**O que testa:**
- ✅ Criação de carteiras
- ⏳ Conexão com nó Qubic
- ⏳ Consulta de saldo

**Tempo**: ~10 segundos  
**Requer**: Nó Qubic válido configurado  
**Status**: ⏳ Requer configuração

### 3. Exemplos Práticos
```bash
npm run exemplo:qubic
```

**O que mostra:**
- 6 exemplos de uso
- Cenários reais
- Código comentado

**Tempo**: ~5 segundos  
**Requer**: Nada (modo demonstração)  
**Status**: ✅ Funcionando

## 🎯 Resultado dos Testes

### Teste Básico - Saída Esperada

```
============================================================
🧪 TESTE BÁSICO - INTEGRAÇÃO QUBIC
============================================================

📝 TESTE 1: Criar Carteira
✅ TESTE 1 PASSOU

📝 TESTE 2: Importar Carteira
✅ TESTE 2 PASSOU

📝 TESTE 3: Validar Identity
✅ TESTE 3 PASSOU

📝 TESTE 4: Conversões de Valor
✅ TESTE 4 PASSOU

📝 TESTE 5: Validação de Seed
✅ TESTE 5 PASSOU

📝 TESTE 6: Criar Múltiplas Carteiras
✅ TESTE 6 PASSOU

============================================================
📊 RESUMO DOS TESTES

   ✅ Testes passados: 6
   ❌ Testes falhados: 0
   📈 Taxa de sucesso: 100%
============================================================

🎉 TODOS OS TESTES PASSARAM!
```

## 🔧 Configuração (Opcional)

Para testar com rede, configure `.env`:

```env
QUBIC_NETWORK=testnet
QUBIC_RPC_URL=https://testnet-rpc.qubic.org
QUBIC_PLATFORM_SEED=seu-seed-aqui
QUBIC_PLATFORM_ADDRESS=sua-identity-aqui
```

## 📝 Exemplos de Uso

### Criar Carteira
```typescript
import qubicWallet from './services/qubic-wallet';

const wallet = await qubicWallet.createWallet();
console.log('Identity:', wallet.identity);
console.log('Seed:', wallet.seed);
```

### Importar Carteira
```typescript
const wallet = await qubicWallet.importWallet('seu-seed-de-55-chars');
console.log('Identity:', wallet.identity);
```

### Validar Identity
```typescript
const isValid = qubicWallet.validateIdentity('IDENTITY_AQUI');
console.log('Válida:', isValid);
```

### Converter Valores
```typescript
// QUBIC para unidades
const units = qubicWallet.toSmallestUnit(1.5);
console.log('1.5 QUBIC =', units, 'units');

// Unidades para QUBIC
const qubic = qubicWallet.toQubic(1500000000n);
console.log('1500000000 units =', qubic, 'QUBIC');
```

## 🐛 Troubleshooting

### Erro: "Cannot find module"
```bash
cd backend
npm install
```

### Erro: "tsx not found"
```bash
npm install -g tsx
# ou
npx tsx src/scripts/test-qubic-basico.ts
```

### Erro de conexão (teste com rede)
- Normal se nó não estiver configurado
- Use `test:qubic-basico` para testar offline
- Configure nó válido no `.env`

## ✅ Checklist de Testes

- [ ] Executei `npm run test:qubic-basico`
- [ ] Todos os 6 testes passaram
- [ ] Criei uma carteira de teste
- [ ] Importei a carteira criada
- [ ] Validei uma identity
- [ ] Converti valores QUBIC ↔ units
- [ ] Li a documentação em `GUIA_RAPIDO_QUBIC.md`

## 📚 Documentação

### Para Começar
- **[GUIA_RAPIDO_QUBIC.md](backend/GUIA_RAPIDO_QUBIC.md)** - Guia rápido

### Para Aprofundar
- **[QUBIC_LIBRARY_INTEGRATION.md](backend/QUBIC_LIBRARY_INTEGRATION.md)** - Detalhes técnicos
- **[INTEGRACAO_QUBIC_COMPLETA.md](INTEGRACAO_QUBIC_COMPLETA.md)** - Visão geral
- **[TESTES_QUBIC_RESULTADO.md](TESTES_QUBIC_RESULTADO.md)** - Resultados dos testes

### Código
- **[qubic-wallet.ts](backend/src/services/qubic-wallet.ts)** - Serviço principal
- **[test-qubic-basico.ts](backend/src/scripts/test-qubic-basico.ts)** - Testes
- **[exemplo-qubic.ts](backend/src/scripts/exemplo-qubic.ts)** - Exemplos

## 🎯 Próximos Passos

### Depois dos Testes
1. ✅ Testes básicos passando
2. ⏳ Configure nó Qubic (opcional)
3. ⏳ Teste com carteira financiada
4. ⏳ Integre com sua aplicação

### Desenvolvimento
1. Use o serviço `qubic-wallet` no seu código
2. Implemente sistema de escrow
3. Adicione rotas de API
4. Configure monitoramento

## 💡 Dicas

### Para Desenvolvimento
- Use `test:qubic-basico` para validação rápida
- Mantenha seeds em variáveis de ambiente
- Teste sempre na testnet primeiro
- Documente suas integrações

### Para Produção
- Configure nós redundantes
- Implemente retry logic
- Adicione logging
- Monitore transações

## 🎉 Conclusão

**A integração está pronta e testada!**

Execute agora:
```bash
cd backend
npm run test:qubic-basico
```

E veja a mágica acontecer! 🚀

---

**Última atualização**: 29/11/2025  
**Status**: ✅ Pronto para uso
