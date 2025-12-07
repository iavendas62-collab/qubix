# Escrow Payment System

Complete implementation of the escrow payment system for QUBIX platform with real Qubic blockchain integration.

## Overview

The escrow system ensures secure payments between consumers and providers by:
- Locking funds before job execution
- Holding funds during job execution
- Releasing payment on successful completion
- Refunding on job failure
- Real-time status updates via WebSocket

## Requirements Implemented

### ✅ Requirement 6.1: Escrow Before Execution
- Funds are locked in escrow before job starts
- Consumer balance is verified before locking
- Transaction is created on Qubic blockchain

### ✅ Requirement 6.2: Escrow Metadata Inclusion
- Job ID included in transaction metadata
- Provider address stored in transaction
- Duration and amount tracked in database

### ✅ Requirement 6.3: Funds Locked During Execution
- Escrow status tracked in database
- Funds cannot be double-spent
- Status checks available via API

### ✅ Requirement 6.4: Payment Release on Success
- Automatic release when job completes
- Payment sent to provider's Qubic address
- Platform fee deducted (configurable %)
- Transaction hash returned with explorer link

### ✅ Requirement 6.5: Refund on Failure
- Automatic refund when job fails
- Full amount returned to consumer
- Transaction hash returned with explorer link

### ✅ Requirement 6.6: Wait for 3 Confirmations
- Confirmation polling implemented
- Waits for 3 blockchain confirmations
- Progress updates broadcast via WebSocket
- Timeout handling (10 minutes max)

### ✅ Requirement 6.7: Display Confirmation Count
- UI displays "0/3", "1/3", "2/3", "3/3"
- Real-time updates via WebSocket
- Progress bar visualization
- Estimated time remaining

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend (React)                          │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  EscrowStatus Component                                │ │
│  │  - Displays confirmation count (0/3, 1/3, 2/3, 3/3)   │ │
│  │  - Shows transaction hash with explorer link          │ │
│  │  - Real-time updates via WebSocket                    │ │
│  │  - Progress bar visualization                         │ │
│  └────────────────────────────────────────────────────────┘ │
└───────────────────────────┬─────────────────────────────────┘
                            │
                    REST API + WebSocket
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                    Backend (Node.js)                         │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  Escrow Service                                        │ │
│  │  - lockEscrow()      - Lock funds before job          │ │
│  │  - releaseEscrow()   - Release on completion          │ │
│  │  - refundEscrow()    - Refund on failure              │ │
│  │  - getEscrowStatus() - Check current status           │ │
│  │  - pollConfirmations() - Wait for 3 confirmations     │ │
│  └────────────────────────────────────────────────────────┘ │
│                            │                                 │
│  ┌────────────────────────▼────────────────────────────────┐│
│  │  Qubic Service                                          ││
│  │  - createEscrow()    - Create blockchain transaction   ││
│  │  - releasePayment()  - Send payment to provider        ││
│  │  - refundEscrow()    - Send refund to consumer         ││
│  │  - verifyTransaction() - Check confirmation status     ││
│  │  - waitForConfirmation() - Poll until confirmed        ││
│  └─────────────────────────────────────────────────────────┘│
│                            │                                 │
│  ┌────────────────────────▼────────────────────────────────┐│
│  │  WebSocket Manager                                      ││
│  │  - Broadcast escrow updates to subscribed clients      ││
│  │  - Send confirmation progress (0/3, 1/3, 2/3, 3/3)     ││
│  └─────────────────────────────────────────────────────────┘│
└───────────────────────────┬─────────────────────────────────┘
                            │
                    Qubic RPC API
                            │
┌───────────────────────────▼─────────────────────────────────┐
│                  Qubic Blockchain Network                    │
│  - Transaction creation and signing                          │
│  - Transaction broadcasting                                  │
│  - Confirmation tracking                                     │
│  - Explorer: https://explorer.qubic.org                     │
└──────────────────────────────────────────────────────────────┘
```

## API Endpoints

### POST /api/escrow/lock
Lock funds in escrow for a job.

**Request:**
```json
{
  "jobId": "uuid",
  "consumerSeed": "55-character-seed",
  "providerAddress": "60-character-qubic-identity",
  "amount": 50,
  "duration": 24
}
```

**Response:**
```json
{
  "success": true,
  "escrowId": "uuid",
  "txHash": "transaction-hash",
  "explorerUrl": "https://explorer.qubic.org/tx/...",
  "confirmations": 0,
  "message": "Escrow locked successfully. Waiting for confirmations..."
}
```

### POST /api/escrow/release
Release payment to provider on job completion.

**Request:**
```json
{
  "jobId": "uuid",
  "providerAddress": "60-character-qubic-identity",
  "amount": 50
}
```

**Response:**
```json
{
  "success": true,
  "txHash": "transaction-hash",
  "explorerUrl": "https://explorer.qubic.org/tx/...",
  "releasedAmount": 47.5,
  "message": "Payment released to provider successfully"
}
```

### POST /api/escrow/refund
Refund consumer if job fails.

**Request:**
```json
{
  "jobId": "uuid",
  "consumerAddress": "60-character-qubic-identity",
  "amount": 50
}
```

**Response:**
```json
{
  "success": true,
  "txHash": "transaction-hash",
  "explorerUrl": "https://explorer.qubic.org/tx/...",
  "refundedAmount": 50,
  "message": "Escrow refunded to consumer successfully"
}
```

### GET /api/escrow/status/:jobId
Get escrow status for a job.

**Response:**
```json
{
  "success": true,
  "escrow": {
    "escrowId": "uuid",
    "jobId": "uuid",
    "status": "locked",
    "amount": 50,
    "confirmations": 3,
    "confirmationText": "3/3",
    "txHash": "transaction-hash",
    "explorerUrl": "https://explorer.qubic.org/tx/...",
    "createdAt": "2024-01-01T00:00:00Z",
    "completedAt": "2024-01-01T00:01:00Z"
  }
}
```

### GET /api/escrow/pending
Get all pending escrows (monitoring/admin).

**Response:**
```json
{
  "success": true,
  "escrows": [
    {
      "escrowId": "uuid",
      "jobId": "uuid",
      "status": "pending",
      "amount": 50,
      "confirmations": 1,
      "confirmationText": "1/3",
      "txHash": "transaction-hash",
      "explorerUrl": "https://explorer.qubic.org/tx/...",
      "createdAt": "2024-01-01T00:00:00Z"
    }
  ],
  "count": 1
}
```

## WebSocket Events

### ESCROW_UPDATE
Broadcast to clients subscribed to `job:{jobId}`.

**Event Data:**
```json
{
  "type": "ESCROW_UPDATE",
  "data": {
    "jobId": "uuid",
    "status": "confirming",
    "confirmations": 2,
    "requiredConfirmations": 3,
    "confirmationText": "2/3",
    "txHash": "transaction-hash",
    "explorerUrl": "https://explorer.qubic.org/tx/...",
    "timestamp": "2024-01-01T00:00:30Z"
  }
}
```

**Status Values:**
- `creating` - Escrow transaction being created
- `pending` - Transaction submitted, waiting for first confirmation
- `confirming` - Receiving confirmations (1/3, 2/3)
- `confirmed` / `locked` - 3 confirmations received, funds locked
- `releasing` - Payment being released to provider
- `released` - Payment successfully released
- `refunding` - Refund being processed
- `refunded` - Refund successfully completed
- `failed` / `error` - Transaction failed

## Frontend Integration

### Using EscrowStatus Component

```tsx
import { EscrowStatus } from '@/components/EscrowStatus';

function JobDetails({ jobId }: { jobId: string }) {
  const handleStatusChange = (status) => {
    console.log('Escrow status changed:', status);
    // Update job status, enable/disable actions, etc.
  };

  return (
    <div>
      <h2>Job Details</h2>
      <EscrowStatus 
        jobId={jobId}
        onStatusChange={handleStatusChange}
      />
    </div>
  );
}
```

### Features:
- ✅ Real-time confirmation count display (0/3, 1/3, 2/3, 3/3)
- ✅ Visual progress bar
- ✅ Status badges with icons
- ✅ Transaction hash with explorer link
- ✅ WebSocket auto-reconnection
- ✅ Error handling and display
- ✅ Loading states

## Database Schema

```prisma
model Transaction {
  id              String    @id @default(uuid())
  userId          String
  user            User      @relation(fields: [userId], references: [id])
  jobId           String?   @unique
  job             Job?      @relation(fields: [jobId], references: [id])
  
  type            TransactionType
  amount          Float
  status          TransactionStatus
  
  qubicTxHash     String?
  
  createdAt       DateTime  @default(now())
  completedAt     DateTime?
}

enum TransactionType {
  PAYMENT
  EARNING
  REFUND
  ESCROW_LOCK
  ESCROW_RELEASE
}

enum TransactionStatus {
  PENDING
  COMPLETED
  FAILED
}
```

## Testing

### Run Test Script
```bash
cd backend
npm run test:escrow
```

### Manual Testing Flow

1. **Lock Escrow:**
```bash
curl -X POST http://localhost:3001/api/escrow/lock \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "test-job-id",
    "consumerSeed": "your-55-char-seed",
    "providerAddress": "PROVIDER_QUBIC_ADDRESS_60_CHARS",
    "amount": 50,
    "duration": 24
  }'
```

2. **Check Status:**
```bash
curl http://localhost:3001/api/escrow/status/test-job-id
```

3. **Release Payment:**
```bash
curl -X POST http://localhost:3001/api/escrow/release \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "test-job-id",
    "providerAddress": "PROVIDER_QUBIC_ADDRESS_60_CHARS",
    "amount": 50
  }'
```

4. **Refund (Alternative):**
```bash
curl -X POST http://localhost:3001/api/escrow/refund \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "test-job-id",
    "consumerAddress": "CONSUMER_QUBIC_ADDRESS_60_CHARS",
    "amount": 50
  }'
```

## Configuration

### Environment Variables

```env
# Qubic Configuration
QUBIC_RPC_ENDPOINT=https://rpc.qubic.org/v1
QUBIC_EXPLORER_URL=https://explorer.qubic.org
QUBIC_PLATFORM_SEED=your-platform-seed-55-chars
QUBIC_PLATFORM_ADDRESS=your-platform-address-60-chars
QUBIC_PLATFORM_FEE_PERCENT=5
QUBIC_CONFIRMATIONS=3
QUBIC_CONFIRMATION_TIMEOUT=600000
```

### Platform Fee
The platform takes a configurable percentage fee from each payment:
- Default: 5%
- Provider receives: 95% of payment
- Platform receives: 5% of payment

Example:
- Job cost: 50 QUBIC
- Provider receives: 47.5 QUBIC
- Platform receives: 2.5 QUBIC

## Error Handling

### Common Errors

**Insufficient Balance:**
```json
{
  "success": false,
  "error": "Insufficient balance. Required: 50 QUBIC, Available: 30 QUBIC"
}
```

**Escrow Already Exists:**
```json
{
  "success": false,
  "error": "Escrow already exists for this job"
}
```

**No Confirmed Escrow:**
```json
{
  "success": false,
  "error": "No confirmed escrow found for this job"
}
```

**Confirmation Timeout:**
```json
{
  "success": false,
  "error": "Transaction confirmation timeout (600000ms)"
}
```

### Retry Logic
- Transaction creation: 3 retries with exponential backoff (2s, 4s, 8s)
- Balance queries: 3 retries with exponential backoff
- Confirmation polling: Continues for up to 10 minutes

## Security Considerations

1. **Seed Storage:** Never store seed phrases in database or logs
2. **API Authentication:** Implement authentication for escrow endpoints
3. **Amount Validation:** Always validate amounts are positive
4. **Address Validation:** Verify Qubic identity format (60 chars)
5. **Double-Spend Prevention:** Check for existing escrow before locking
6. **Transaction Verification:** Always verify on blockchain before marking complete

## Monitoring

### Metrics to Track
- Pending escrows count
- Average confirmation time
- Failed transactions rate
- Refund rate
- Platform fees collected

### Logs
All escrow operations are logged with:
- Transaction type
- Amount
- Status
- Job ID
- Transaction hash
- Error messages (if any)

## Production Checklist

- [ ] Set QUBIC_PLATFORM_SEED in production environment
- [ ] Verify platform wallet has sufficient balance
- [ ] Configure platform fee percentage
- [ ] Set up monitoring for pending escrows
- [ ] Implement authentication for escrow endpoints
- [ ] Set up alerts for failed transactions
- [ ] Test with small amounts first
- [ ] Monitor Qubic explorer for all transactions
- [ ] Set up backup for transaction records
- [ ] Document recovery procedures

## Support

For issues or questions:
- Check transaction on https://explorer.qubic.org
- Review logs for error messages
- Verify wallet balances
- Check network connectivity to Qubic RPC
- Contact Qubic support for blockchain issues
