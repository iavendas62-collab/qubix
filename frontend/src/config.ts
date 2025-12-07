/**
 * Frontend Configuration - URLs CORRETAS
 * ATENÇÃO: Usa proxy do Vite em desenvolvimento
 */

// Backend API Base URL
// Em desenvolvimento: usa proxy do Vite (/api)
// Em produção: usa URL completa do backend
export const API_BASE_URL = import.meta.env.VITE_API_URL || '/api';

// WebSocket URL
export const WS_URL = import.meta.env.VITE_WS_URL || 'ws://localhost:3006';

// Qubic Network
export const QUBIC_NETWORK = import.meta.env.VITE_QUBIC_NETWORK || 'testnet';
export const QUBIC_RPC_URL = QUBIC_NETWORK === 'mainnet'
  ? 'https://rpc.qubic.org'
  : 'https://testnet-rpc.qubic.org';

// Helper to build API URLs - SIMPLES e DIRETO
export const apiUrl = (path: string) => {
  // Remove leading slash if present
  const cleanPath = path.startsWith('/') ? path.slice(1) : path;

  // Sempre usar API_BASE_URL + clean path
  // Em desenvolvimento: /api (proxy do Vite)
  // Em produção: http://backend:3006/api
  return `${API_BASE_URL}/${cleanPath}`;
};

// Example usage:
// apiUrl('auth/login') -> /api/auth/login (desenvolvimento)
// apiUrl('qubic/escrow/create') -> /api/qubic/escrow/create

console.log('🔧 Frontend Config:', {
  API_BASE_URL,
  WS_URL,
  QUBIC_NETWORK,
  QUBIC_RPC_URL
});
