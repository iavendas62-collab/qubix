const express = require('express');
const cors = require('cors');
const crypto = require('crypto');

const app = express();
app.use(cors());
app.use(express.json());

const mockUsers = [];

// Real Qubic wallet generation using the library pattern
async function generateQubicWallet() {
  try {
    // Generate 55 lowercase letter seed (Qubic standard)
    const seed = Array.from({ length: 55 }, () => 
      'abcdefghijklmnopqrstuvwxyz'[Math.floor(Math.random() * 26)]
    ).join('');
    
    // Try to use real Qubic library for identity generation
    try {
      const { QubicHelper } = require('@qubic-lib/qubic-ts-library/dist/qubicHelper');
      const helper = new QubicHelper();
      const idPackage = await helper.createIdPackage(seed);
      const identity = await helper.getIdentity(idPackage.publicKey);
      
      console.log('✅ Generated REAL Qubic wallet:', identity.substring(0, 20) + '...');
      return { seed, identity };
    } catch (libError) {
      console.log('⚠️ Qubic library not available, using mock identity');
      // Fallback: generate mock identity (60 uppercase letters like real Qubic)
      const identity = Array.from({ length: 60 }, () => 
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[Math.floor(Math.random() * 26)]
      ).join('');
      return { seed, identity };
    }
  } catch (error) {
    console.error('Wallet generation error:', error);
    throw error;
  }
}

app.post('/api/auth/register', async (req, res) => {
  console.log('📝 Register request received:', req.body);
  try {
    const { name, email, password, type } = req.body;
    
    if (!name || !email || !password || !type) {
      return res.status(400).json({ error: 'All fields are required' });
    }
    
    if (mockUsers.find(u => u.email === email)) {
      return res.status(400).json({ error: 'Email already registered' });
    }
    
    const wallet = await generateQubicWallet();
    
    const user = {
      id: Date.now().toString(),
      name,
      email,
      password,
      type,
      qubicIdentity: wallet.identity,
      qubicSeed: wallet.seed,
      createdAt: new Date().toISOString()
    };
    
    mockUsers.push(user);
    
    const token = Buffer.from(JSON.stringify({ userId: user.id, email: user.email })).toString('base64');
    
    console.log('✅ User created successfully:', user.email);
    
    res.json({
      success: true,
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        type: user.type,
        qubicIdentity: user.qubicIdentity
      },
      wallet: {
        identity: wallet.identity,
        seed: wallet.seed
      },
      warning: 'Save your seed phrase! This is the only time you will see it.'
    });
  } catch (error) {
    console.error('Register error:', error);
    res.status(500).json({ error: 'Registration failed: ' + error.message });
  }
});

app.post('/api/auth/login', (req, res) => {
  console.log('🔐 Login request received:', req.body);
  try {
    const { email, password } = req.body;
    
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }
    
    const user = mockUsers.find(u => u.email === email && u.password === password);
    
    if (!user) {
      return res.status(401).json({ error: 'Invalid email or password' });
    }
    
    const token = Buffer.from(JSON.stringify({ userId: user.id, email: user.email })).toString('base64');
    
    res.json({
      success: true,
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        type: user.type,
        qubicIdentity: user.qubicIdentity
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed: ' + error.message });
  }
});

const PORT = 3002;
app.listen(PORT, () => {
  console.log(`\n🔐 AUTH TEST SERVER running on port ${PORT}\n`);
});
