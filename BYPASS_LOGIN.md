# 🚀 BYPASS LOGIN - Entrar Direto

## Problema
Login não está funcionando por causa de configuração de porta.

## Solução Rápida

### Opção 1: Entrar Direto via Console

1. Abra: http://localhost:3004/signin
2. Pressione F12 (Console)
3. Cole e execute:

```javascript
localStorage.setItem('token', 'demo-token');
localStorage.setItem('qubicAddress', 'QUBICTESTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
localStorage.setItem('user', JSON.stringify({
  qubicAddress: 'QUBICTESTAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
  role: 'BOTH'
}));
window.location.href = '/app/provider/test';
```

4. Pressione Enter
5. Você será redirecionado para o dashboard de teste!

### Opção 2: Acessar Direto

Simplesmente acesse:
```
http://localhost:3004/app/provider/test
```

Se pedir login, use a Opção 1.

## Depois de Entrar

Você verá o dashboard simplificado com:
- Stats (earnings, jobs, hardware)
- Botão "Auto-Detect GPU (Python)"
- Lista de hardware (vazia no início)

Clique em "Auto-Detect GPU" e veja sua MX150 aparecer!

---

## Corrigir Login Depois

Para corrigir o login de verdade, precisamos:
1. Verificar qual porta o frontend está chamando
2. Ajustar configuração
3. Reiniciar frontend

Mas por agora, use o bypass para testar! 🚀
