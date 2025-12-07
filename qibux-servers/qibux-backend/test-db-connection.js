const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient({
  log: ['query', 'error', 'warn'],
});

async function testConnection() {
  console.log('🔍 Testando conexão com Supabase...\n');
  
  try {
    console.log('📡 Tentando conectar...');
    await prisma.$connect();
    console.log('✅ Conectado ao Supabase com sucesso!\n');
    
    console.log('🔍 Testando query simples...');
    const result = await prisma.$queryRaw`SELECT 1 as test`;
    console.log('✅ Query executada:', result);
    
    console.log('\n🔍 Verificando tabelas...');
    const tables = await prisma.$queryRaw`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `;
    console.log('📊 Tabelas encontradas:', tables.length);
    tables.forEach(t => console.log('  -', t.table_name));
    
  } catch (error) {
    console.error('\n❌ Erro ao conectar:', error.message);
    console.error('\n📋 Detalhes do erro:');
    console.error('   Código:', error.code);
    console.error('   Meta:', error.meta);
    
    if (error.message.includes('ECONNREFUSED')) {
      console.error('\n💡 Possíveis causas:');
      console.error('   1. Projeto Supabase pausado ou inativo');
      console.error('   2. Credenciais incorretas');
      console.error('   3. Firewall bloqueando a conexão');
      console.error('   4. URL do banco incorreta');
    }
  } finally {
    await prisma.$disconnect();
    console.log('\n🔌 Desconectado');
  }
}

testConnection();
