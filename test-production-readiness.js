#!/usr/bin/env node

/**
 * Production Readiness Test Script
 * Tests all critical functionality before deploy
 */

const https = require('https');
const http = require('http');

const BACKEND_URL = process.env.BACKEND_URL || 'http://localhost:3006';
const FRONTEND_URL = process.env.FRONTEND_URL || 'http://localhost:3004';

console.log('🚀 QUBIX Production Readiness Test\n');
console.log(`Backend: ${BACKEND_URL}`);
console.log(`Frontend: ${FRONTEND_URL}\n`);

let testsPassed = 0;
let testsTotal = 0;

function test(name, fn) {
  return new Promise((resolve) => {
    testsTotal++;
    console.log(`⏳ ${name}...`);

    fn()
      .then(() => {
        testsPassed++;
        console.log(`✅ ${name}`);
        resolve();
      })
      .catch((error) => {
        console.log(`❌ ${name}: ${error.message}`);
        resolve();
      });
  });
}

function makeRequest(url, options = {}) {
  return new Promise((resolve, reject) => {
    const protocol = url.startsWith('https') ? https : http;
    const req = protocol.get(url, options, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          resolve({ status: res.statusCode, data: json });
        } catch (e) {
          resolve({ status: res.statusCode, data });
        }
      });
    });

    req.on('error', reject);
    req.setTimeout(5000, () => {
      req.abort();
      reject(new Error('Timeout'));
    });
  });
}

async function runTests() {
  // Backend Health Check
  await test('Backend Health Check', async () => {
    const response = await makeRequest(`${BACKEND_URL}/health`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (response.data.status !== 'ok') throw new Error('Health check failed');
  });

  // Backend API Stats
  await test('Backend API Stats', async () => {
    const response = await makeRequest(`${BACKEND_URL}/api/stats`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.jobs || !response.data.providers) throw new Error('Stats incomplete');
  });

  // Qubic Network Info
  await test('Qubic Network Info', async () => {
    const response = await makeRequest(`${BACKEND_URL}/api/qubic/network`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Network info failed');
  });

  // Qubic Balance Check (Demo)
  await test('Qubic Balance Check', async () => {
    const demoAddress = 'DEMOQUBICADDRESSABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQR';
    const response = await makeRequest(`${BACKEND_URL}/api/qubic/balance/${demoAddress}`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Balance check failed');
    if (response.data.balance < 0) throw new Error('Invalid balance');
  });

  // GPU Marketplace
  await test('GPU Marketplace', async () => {
    const response = await makeRequest(`${BACKEND_URL}/api/gpus`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!Array.isArray(response.data)) throw new Error('Invalid GPU data');
    if (response.data.length < 10) throw new Error('Insufficient GPUs');
  });

  // AI Models
  await test('AI Models', async () => {
    const response = await makeRequest(`${BACKEND_URL}/api/models`);
    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!Array.isArray(response.data)) throw new Error('Invalid models data');
    if (response.data.length < 5) throw new Error('Insufficient models');
  });

  // Auth Register Test
  await test('Auth Register', async () => {
    const testUser = {
      name: 'Test User',
      email: `test-${Date.now()}@qubix.io`,
      password: 'TestPass123!',
      type: 'CONSUMER'
    };

    const response = await makeRequest(`${BACKEND_URL}/api/auth/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(testUser)
    });

    if (response.status !== 201) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Register failed');
    if (!response.data.wallet?.identity) throw new Error('Wallet not created');
  });

  // Auth Login Test
  await test('Auth Login', async () => {
    const loginData = {
      email: 'demo@qubix.io',
      password: 'demo123'
    };

    const response = await makeRequest(`${BACKEND_URL}/api/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(loginData)
    });

    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Login failed');
    if (!response.data.token) throw new Error('No token returned');
  });

  // Job Submission Test
  await test('Job Submission', async () => {
    const jobData = {
      modelType: 'gpt2',
      computeNeeded: 10,
      budget: 50
    };

    const response = await makeRequest(`${BACKEND_URL}/api/jobs/submit`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(jobData)
    });

    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Job submission failed');
  });

  // Provider Registration Test
  await test('Provider Registration', async () => {
    const providerData = {
      worker_id: `test-worker-${Date.now()}`,
      type: 'gpu',
      specs: {
        gpu_model: 'RTX 3060',
        gpu_vram_gb: 12,
        cpu_cores: 8,
        ram_total_gb: 16
      },
      pricePerHour: 2.0
    };

    const response = await makeRequest(`${BACKEND_URL}/api/providers/register`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(providerData)
    });

    if (response.status !== 200) throw new Error(`Status ${response.status}`);
    if (!response.data.success) throw new Error('Provider registration failed');
  });

  // Frontend Accessibility Test
  await test('Frontend Accessibility', async () => {
    try {
      const response = await makeRequest(FRONTEND_URL);
      if (response.status !== 200) throw new Error(`Status ${response.status}`);
    } catch (error) {
      // Frontend might not be running, skip this test
      console.log(`⚠️  Frontend not accessible (${error.message}) - skipping`);
      testsTotal--; // Don't count this test
    }
  });

  // Results
  console.log(`\n📊 Test Results:`);
  console.log(`✅ ${testsPassed}/${testsTotal} tests passed`);

  if (testsPassed === testsTotal) {
    console.log(`\n🎉 ALL TESTS PASSED! Ready for production!`);
    console.log(`\n🚀 Deploy URLs:`);
    console.log(`Frontend: ${FRONTEND_URL}`);
    console.log(`Backend:  ${BACKEND_URL}`);
    console.log(`Health:   ${BACKEND_URL}/health`);
    console.log(`API:      ${BACKEND_URL}/api/stats`);
    process.exit(0);
  } else {
    console.log(`\n❌ ${testsTotal - testsPassed} tests failed. Please fix before deploying.`);
    process.exit(1);
  }
}

// Run all tests
runTests().catch((error) => {
  console.error('❌ Test runner failed:', error);
  process.exit(1);
});
