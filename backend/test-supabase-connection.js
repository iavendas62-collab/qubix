// Test Supabase Connection
const { Client } = require('pg');

const testConnection = async () => {
  console.log('🔍 Testando conexão com Supabase...\n');
  
  // Teste 1: Direct Connection
  console.log('📡 Teste 1: Direct Connection (porta 5432)');
  const directClient = new Client({
    connectionString: 'postgresql://postgres:%40Llplac1234@db.kkbvkjwhmstrapyzvfcw.supabase.co:5432/postgres',
    ssl: { rejectUnauthorized: false }
  });
  
  try {
    await directClient.connect();
    console.log('✅ Direct Connection: SUCESSO!\n');
    
    const result = await directClient.query('SELECT version()');
    console.log('📊 PostgreSQL Version:', result.rows[0].version.split(' ')[0], '\n');
    
    await directClient.end();
  } catch (error) {
    console.log('❌ Direct Connection: FALHOU');
    console.log('Erro:', error.message, '\n');
  }
  
  // Teste 2: Pooler Connection
  console.log('📡 Teste 2: Pooler Connection (porta 6543)');
  const poolerClient = new Client({
    connectionString: 'postgresql://postgres:%40Llplac1234@db.kkbvkjwhmstrapyzvfcw.supabase.co:6543/postgres?pgbouncer=true',
    ssl: { rejectUnauthorized: false }
  });
  
  try {
    await poolerClient.connect();
    console.log('✅ Pooler Connection: SUCESSO!\n');
    
    await poolerClient.end();
  } catch (error) {
    console.log('❌ Pooler Connection: FALHOU');
    console.log('Erro:', error.message, '\n');
  }
  
  console.log('🏁 Teste concluído!');
  console.log('\n💡 Dicas:');
  console.log('- Se ambos falharam: Verifique firewall/rede');
  console.log('- Se apenas Direct falhou: Use Session Pooler');
  console.log('- Se apenas Pooler falhou: Use Direct Connection');
};

testConnection().catch(console.error);
