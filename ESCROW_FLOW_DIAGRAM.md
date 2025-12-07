# Escrow Payment System Flow Diagram

## Complete Escrow Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                         ESCROW LOCK FLOW                             │
└─────────────────────────────────────────────────────────────────────┘

Consumer                Frontend              Backend              Qubic Blockchain
   │                       │                      │                        │
   │  1. Create Job        │                      │                        │
   ├──────────────────────>│                      │                        │
   │                       │                      │                        │
   │                       │  2. Lock Escrow      │                        │
   │                       ├─────────────────────>│                        │
   │                       │  POST /api/escrow/lock                       │
   │                       │  {jobId, seed,       │                        │
   │                       │   provider, amount}  │                        │
   │                       │                      │                        │
   │                       │                      │  3. Create TX          │
   │                       │                      ├───────────────────────>│
   │                       │                      │  with job metadata     │
   │                       │                      │                        │
   │                       │                      │  4. TX Hash            │
   │                       │                      │<───────────────────────┤
   │                       │                      │                        │
   │                       │  5. Escrow Created   │                        │
   │                       │<─────────────────────┤                        │
   │                       │  {txHash, escrowId,  │                        │
   │                       │   confirmations: 0}  │                        │
   │                       │                      │                        │
   │  6. Show Status       │                      │                        │
   │  "0/3 Confirmations"  │                      │                        │
   │<──────────────────────┤                      │                        │
   │                       │                      │                        │
   │                       │  ╔═══════════════════╗                        │
   │                       │  ║ WebSocket Updates ║                        │
   │                       │  ╚═══════════════════╝                        │
   │                       │                      │                        │
   │                       │                      │  7. Poll Confirmations │
   │                       │                      │  (every 2 seconds)     │
   │                       │                      ├───────────────────────>│
   │                       │                      │                        │
   │                       │                      │  8. Status: 1/3        │
   │                       │                      │<───────────────────────┤
   │                       │                      │                        │
   │                       │  9. WS: ESCROW_UPDATE│                        │
   │                       │<─────────────────────┤                        │
   │                       │  {confirmations: 1,  │                        │
   │                       │   confirmationText:  │                        │
   │                       │   "1/3"}             │                        │
   │                       │                      │                        │
   │  10. Update UI        │                      │                        │
   │  "1/3 Confirmations"  │                      │                        │
   │  [████░░░░░░] 33%     │                      │                        │
   │<──────────────────────┤                      │                        │
   │                       │                      │                        │
   │                       │                      │  11. Status: 2/3       │
   │                       │                      │<───────────────────────┤
   │                       │                      │                        │
   │                       │  12. WS: ESCROW_UPDATE                        │
   │                       │<─────────────────────┤                        │
   │                       │  {confirmations: 2,  │                        │
   │                       │   confirmationText:  │                        │
   │                       │   "2/3"}             │                        │
   │                       │                      │                        │
   │  13. Update UI        │                      │                        │
   │  "2/3 Confirmations"  │                      │                        │
   │  [████████░░] 67%     │                      │                        │
   │<──────────────────────┤                      │                        │
   │                       │                      │                        │
   │                       │                      │  14. Status: 3/3       │
   │                       │                      │<───────────────────────┤
   │                       │                      │                        │
   │                       │  15. WS: ESCROW_UPDATE                        │
   │                       │<─────────────────────┤                        │
   │                       │  {confirmations: 3,  │                        │
   │                       │   status: "locked",  │                        │
   │                       │   confirmationText:  │                        │
   │                       │   "3/3"}             │                        │
   │                       │                      │                        │
   │  16. Update UI        │                      │                        │
   │  "3/3 Confirmations"  │                      │                        │
   │  [████████████] 100%  │                      │                        │
   │  ✓ Funds Locked       │                      │                        │
   │<──────────────────────┤                      │                        │
   │                       │                      │                        │
   │                       │  17. Job can now     │                        │
   │                       │      start execution │                        │
   │                       │                      │                        │


┌─────────────────────────────────────────────────────────────────────┐
│                      ESCROW RELEASE FLOW                             │
│                    (Job Completes Successfully)                      │
└─────────────────────────────────────────────────────────────────────┘

Provider               Backend              Qubic Blockchain        Consumer
   │                      │                        │                    │
   │  1. Job Complete     │                        │                    │
   ├─────────────────────>│                        │                    │
   │  {jobId, result}     │                        │                    │
   │                      │                        │                    │
   │                      │  2. Release Escrow     │                    │
   │                      │  POST /api/escrow/     │                    │
   │                      │  release               │                    │
   │                      │                        │                    │
   │                      │  3. Send Payment       │                    │
   │                      ├───────────────────────>│                    │
   │                      │  to provider address   │                    │
   │                      │  (amount - platform    │                    │
   │                      │   fee)                 │                    │
   │                      │                        │                    │
   │                      │  4. TX Hash            │                    │
   │                      │<───────────────────────┤                    │
   │                      │                        │                    │
   │                      │  5. WS: ESCROW_UPDATE  │                    │
   │                      ├────────────────────────┼───────────────────>│
   │                      │  {status: "released",  │                    │
   │                      │   txHash, explorerUrl} │                    │
   │                      │                        │                    │
   │  6. Payment Received │                        │                    │
   │  ✓ 47.5 QUBIC        │                        │                    │
   │<─────────────────────┤                        │                    │
   │  (50 - 5% fee)       │                        │                    │
   │                      │                        │                    │


┌─────────────────────────────────────────────────────────────────────┐
│                       ESCROW REFUND FLOW                             │
│                         (Job Fails)                                  │
└─────────────────────────────────────────────────────────────────────┘

Provider               Backend              Qubic Blockchain        Consumer
   │                      │                        │                    │
   │  1. Job Failed       │                        │                    │
   ├─────────────────────>│                        │                    │
   │  {jobId, error}      │                        │                    │
   │                      │                        │                    │
   │                      │  2. Refund Escrow      │                    │
   │                      │  POST /api/escrow/     │                    │
   │                      │  refund                │                    │
   │                      │                        │                    │
   │                      │  3. Send Refund        │                    │
   │                      ├───────────────────────>│                    │
   │                      │  to consumer address   │                    │
   │                      │  (full amount)         │                    │
   │                      │                        │                    │
   │                      │  4. TX Hash            │                    │
   │                      │<───────────────────────┤                    │
   │                      │                        │                    │
   │                      │  5. WS: ESCROW_UPDATE  │                    │
   │                      ├────────────────────────┼───────────────────>│
   │                      │  {status: "refunded",  │                    │
   │                      │   txHash, explorerUrl} │                    │
   │                      │                        │                    │
   │                      │                        │  6. Refund Received│
   │                      │                        │  ✓ 50 QUBIC        │
   │                      │                        │<───────────────────┤
   │                      │                        │                    │


┌─────────────────────────────────────────────────────────────────────┐
│                    UI CONFIRMATION DISPLAY                           │
└─────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│  Escrow Status                              [⏱ Confirming] │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  Confirmations                                        2/3   │
│  [████████████████████░░░░░░░░] 67%                        │
│  Waiting for blockchain confirmations...                   │
│  (~15s per confirmation)                                   │
│                                                             │
│  Amount                                          50 QUBIC   │
│                                                             │
│  Transaction Hash                                           │
│  abc123...xyz789                              [View ↗]     │
│                                                             │
└────────────────────────────────────────────────────────────┘

After 3 confirmations:

┌────────────────────────────────────────────────────────────┐
│  Escrow Status                                  [✓ Locked] │
├────────────────────────────────────────────────────────────┤
│                                                             │
│  Confirmations                                        3/3   │
│  [████████████████████████████████] 100%                   │
│  ✓ Funds are securely locked in escrow                     │
│                                                             │
│  Amount                                          50 QUBIC   │
│                                                             │
│  Transaction Hash                                           │
│  abc123...xyz789                              [View ↗]     │
│                                                             │
└────────────────────────────────────────────────────────────┘
```

## Key Features Illustrated

1. **Real-time Confirmation Updates**
   - WebSocket broadcasts every confirmation (0/3 → 1/3 → 2/3 → 3/3)
   - Progress bar updates smoothly
   - Estimated time displayed

2. **Three-Way Flow**
   - Lock: Consumer → Platform (escrow)
   - Release: Platform → Provider (payment)
   - Refund: Platform → Consumer (refund)

3. **Status Tracking**
   - Database tracks all transactions
   - WebSocket broadcasts all status changes
   - UI updates in real-time

4. **Security**
   - 3 confirmations required before job starts
   - Funds locked during execution
   - Cannot be double-spent
   - All transactions on blockchain

5. **User Experience**
   - Clear visual feedback
   - Progress bar with percentage
   - Status badges with icons
   - Transaction links to explorer
   - Estimated time remaining
