const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient({
  log: ['error', 'warn'],
});

async function testSupabaseIntegration() {
  console.log('🔍 Testando Integração com Supabase\n');
  console.log('='.repeat(60));

  const tests = {
    connection: false,
    schema: false,
    crud: false,
    relations: false,
  };

  try {
    // 1. Teste de Conexão
    console.log('\n📡 1. TESTE DE CONEXÃO');
    console.log('-'.repeat(60));
    
    try {
      await prisma.$connect();
      console.log('✅ Conexão estabelecida com sucesso');
      tests.connection = true;
    } catch (error) {
      console.log('❌ Falha na conexão:', error.message);
      throw error;
    }

    // 2. Teste de Schema
    console.log('\n📊 2. TESTE DE SCHEMA');
    console.log('-'.repeat(60));
    
    try {
      const tables = await prisma.$queryRaw`
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'qubix' 
          AND table_name IN ('User', 'Provider', 'Job', 'Transaction', 'ProviderMetric', 'JobLog', 'JobMetric', 'Benchmark')
        ORDER BY table_name;
      `;
      
      console.log(`✅ ${tables.length}/8 tabelas encontradas:`);
      tables.forEach(t => console.log(`   - ${t.table_name}`));
      
      if (tables.length === 8) {
        tests.schema = true;
      } else {
        console.log('⚠️  Algumas tabelas estão faltando');
      }
    } catch (error) {
      console.log('❌ Erro ao verificar schema:', error.message);
    }

    // 3. Teste de CRUD
    console.log('\n📝 3. TESTE DE CRUD (User)');
    console.log('-'.repeat(60));
    
    try {
      // CREATE
      const testUser = await prisma.user.create({
        data: {
          qubicAddress: `TEST_${Date.now()}`,
          email: `test_${Date.now()}@qubix.com`,
          username: 'Test User',
          role: 'CONSUMER',
        },
      });
      console.log('✅ CREATE: Usuário criado com ID:', testUser.id);

      // READ
      const foundUser = await prisma.user.findUnique({
        where: { id: testUser.id },
      });
      console.log('✅ READ: Usuário encontrado:', foundUser.username);

      // UPDATE
      const updatedUser = await prisma.user.update({
        where: { id: testUser.id },
        data: { balance: 100 },
      });
      console.log('✅ UPDATE: Balance atualizado para:', updatedUser.balance);

      // DELETE
      await prisma.user.delete({
        where: { id: testUser.id },
      });
      console.log('✅ DELETE: Usuário removido');

      tests.crud = true;
    } catch (error) {
      console.log('❌ Erro no teste CRUD:', error.message);
    }

    // 4. Teste de Relações
    console.log('\n🔗 4. TESTE DE RELAÇÕES');
    console.log('-'.repeat(60));
    
    try {
      // Criar usuário
      const user = await prisma.user.create({
        data: {
          qubicAddress: `REL_TEST_${Date.now()}`,
          email: `rel_test_${Date.now()}@qubix.com`,
          role: 'BOTH',
        },
      });

      // Criar provider vinculado ao usuário
      const provider = await prisma.provider.create({
        data: {
          workerId: `WORKER_${Date.now()}`,
          userId: user.id,
          qubicAddress: user.qubicAddress,
          type: 'NATIVE',
          gpuModel: 'RTX 4090',
          gpuVram: 24,
          cpuModel: 'AMD Ryzen 9',
          cpuCores: 16,
          ramTotal: 64,
          pricePerHour: 5.0,
        },
      });
      console.log('✅ Provider criado e vinculado ao usuário');

      // Criar job vinculado ao usuário e provider
      const job = await prisma.job.create({
        data: {
          userId: user.id,
          providerId: provider.id,
          modelType: 'training',
          computeNeeded: 100,
          inputData: { test: true },
          estimatedCost: 10.0,
        },
      });
      console.log('✅ Job criado e vinculado ao usuário e provider');

      // Buscar usuário com relações
      const userWithRelations = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          providers: true,
          jobs: true,
        },
      });

      console.log('✅ Relações verificadas:');
      console.log(`   - Providers: ${userWithRelations.providers.length}`);
      console.log(`   - Jobs: ${userWithRelations.jobs.length}`);

      // Limpar dados de teste
      await prisma.job.delete({ where: { id: job.id } });
      await prisma.provider.delete({ where: { id: provider.id } });
      await prisma.user.delete({ where: { id: user.id } });
      console.log('✅ Dados de teste removidos');

      tests.relations = true;
    } catch (error) {
      console.log('❌ Erro no teste de relações:', error.message);
    }

    // 5. Teste de Índices
    console.log('\n🔍 5. TESTE DE ÍNDICES');
    console.log('-'.repeat(60));
    
    try {
      const indexes = await prisma.$queryRaw`
        SELECT 
          schemaname,
          tablename,
          indexname
        FROM pg_indexes 
        WHERE schemaname = 'qubix' 
          AND tablename IN ('User', 'Provider', 'Job', 'Transaction', 'ProviderMetric', 'JobLog', 'JobMetric', 'Benchmark')
        ORDER BY tablename, indexname;
      `;
      
      console.log(`✅ ${indexes.length} índices encontrados`);
      
      // Agrupar por tabela
      const indexesByTable = {};
      indexes.forEach(idx => {
        if (!indexesByTable[idx.tablename]) {
          indexesByTable[idx.tablename] = [];
        }
        indexesByTable[idx.tablename].push(idx.indexname);
      });

      Object.keys(indexesByTable).sort().forEach(table => {
        console.log(`   ${table}: ${indexesByTable[table].length} índices`);
      });
    } catch (error) {
      console.log('❌ Erro ao verificar índices:', error.message);
    }

    // Resumo Final
    console.log('\n' + '='.repeat(60));
    console.log('📊 RESUMO DOS TESTES');
    console.log('='.repeat(60));
    
    const results = [
      { name: 'Conexão', status: tests.connection },
      { name: 'Schema', status: tests.schema },
      { name: 'CRUD', status: tests.crud },
      { name: 'Relações', status: tests.relations },
    ];

    results.forEach(test => {
      console.log(`${test.status ? '✅' : '❌'} ${test.name}`);
    });

    const allPassed = Object.values(tests).every(t => t === true);
    
    console.log('\n' + '='.repeat(60));
    if (allPassed) {
      console.log('🎉 TODOS OS TESTES PASSARAM!');
      console.log('✅ Integração com Supabase está 100% funcional');
    } else {
      console.log('⚠️  ALGUNS TESTES FALHARAM');
      console.log('❌ Verifique os erros acima');
    }
    console.log('='.repeat(60));

  } catch (error) {
    console.log('\n❌ ERRO CRÍTICO:', error.message);
    console.log('\n📋 Detalhes:');
    console.log('   DATABASE_URL:', process.env.DATABASE_URL ? 'Configurada' : 'NÃO configurada');
    console.log('   DIRECT_URL:', process.env.DIRECT_URL ? 'Configurada' : 'NÃO configurada');
  } finally {
    await prisma.$disconnect();
    console.log('\n🔌 Desconectado do banco de dados\n');
  }
}

testSupabaseIntegration();
