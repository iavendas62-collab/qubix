# 🔒 Guia de Segurança - Qubix

## ⚠️ NUNCA COMPARTILHE:

### Chaves de API
- ❌ OpenAI API Keys
- ❌ Supabase Passwords
- ❌ JWT Secrets
- ❌ Qubic Seeds/Private Keys
- ❌ Qualquer coisa em arquivos `.env`

### O que fazer se expor acidentalmente:

1. **Revogue IMEDIATAMENTE**
2. **Crie nova chave**
3. **Atualize o .env**
4. **Verifique logs de uso**

## 🔐 Boas Práticas

### 1. Variáveis de Ambiente

```bash
# ✅ CORRETO - Use .env (nunca commite)
OPENAI_API_KEY=sk-proj-...
DATABASE_URL=postgresql://...

# ❌ ERRADO - Nunca hardcode no código
const apiKey = "sk-proj-abc123..."
```

### 2. Arquivo .env

```bash
# Sempre no .gitignore
echo ".env" >> .gitignore
echo ".env.*" >> .gitignore
echo "!.env.example" >> .gitignore
```

### 3. Compartilhar Configurações

```bash
# ✅ Use .env.example (sem valores reais)
OPENAI_API_KEY=your-key-here
DATABASE_URL=your-database-url

# ❌ Nunca compartilhe .env real
```

## 🛡️ Checklist de Segurança

### Desenvolvimento
- [ ] .env no .gitignore
- [ ] Senhas fortes (min 32 caracteres)
- [ ] JWT secret aleatório
- [ ] Nunca commitar chaves

### Produção
- [ ] SSL/TLS habilitado
- [ ] Firewall configurado
- [ ] Rate limiting ativo
- [ ] Logs de auditoria
- [ ] Backups automáticos
- [ ] Monitoramento de erros
- [ ] 2FA habilitado em serviços

## 🔑 Gerando Secrets Seguros

### JWT Secret
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('base64'))"
```

### Senha Forte
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### Qubic Seed (55 caracteres)
Use o Qubic Wallet oficial para gerar seeds seguros.

## 🚨 Se Você Expôs uma Chave

### OpenAI
1. Acesse: https://platform.openai.com/api-keys
2. Delete a chave exposta
3. Crie nova chave
4. Verifique uso em: https://platform.openai.com/usage

### Supabase
1. Acesse: https://supabase.com/dashboard
2. Settings → Database → Reset password
3. Atualize .env com nova senha

### GitHub (se commitou)
1. Revogue a chave
2. Remova do histórico:
```bash
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all
```
3. Force push (cuidado!)

## 📋 Rotação de Chaves

Recomendado a cada:
- **JWT Secrets**: 90 dias
- **API Keys**: 180 dias
- **Database Passwords**: 180 dias
- **Qubic Seeds**: Nunca (use nova wallet)

## 🔍 Auditoria

### Verificar se há chaves expostas
```bash
# Procurar por padrões suspeitos
git log -p | grep -i "api.key\|password\|secret"

# Usar ferramentas
npm install -g git-secrets
git secrets --scan
```

## 📞 Contatos de Emergência

- **OpenAI Support**: https://help.openai.com
- **Supabase Support**: https://supabase.com/support
- **GitHub Security**: security@github.com

## ✅ Resumo

1. **Nunca** compartilhe chaves
2. **Sempre** use .env
3. **Revogue** se expor
4. **Monitore** uso
5. **Rotacione** regularmente
