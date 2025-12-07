const { qubicService } = require('./backend/src/services/qubic.service');

async function test() {
  try {
    console.log('🔍 Testando integração Qubic...');
    await qubicService.initialize();
    console.log('✅ Serviço Qubic inicializado');

    const wallet = await qubicService.connectWallet();
    console.log('✅ Carteira criada:', wallet.address.substring(0, 20) + '...');

    const balance = await qubicService.getBalance(wallet.address);
    console.log('💰 Saldo:', balance.balanceQubic, 'QUBIC');

  } catch (error) {
    console.error('❌ Erro na integração Qubic:', error.message);
  }
}

test();
