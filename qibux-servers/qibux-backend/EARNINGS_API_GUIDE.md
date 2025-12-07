# Earnings Calculation Backend - API Guide

## Overview

The earnings calculation backend provides real-time earnings tracking for providers, including:
- Total earnings and period breakdowns (today, week, month)
- Live earnings calculation for active jobs (elapsed time × hourly rate)
- 30-day earnings history aggregation
- Average hourly rate calculation
- Pending payouts from escrow transactions
- WebSocket broadcasting every 5 seconds

**Requirements Implemented:** 9.1, 9.2, 9.6

## API Endpoints

### 1. Get Complete Provider Earnings

```http
GET /api/earnings/:providerId
```

Returns complete earnings data including summary, active jobs, transaction history, and performance metrics.

**Response:**
```json
{
  "success": true,
  "earnings": {
    "totalEarned": 150.5,
    "todayEarnings": 12.5,
    "weekEarnings": 45.0,
    "monthEarnings": 120.0,
    "pendingPayouts": 8.5,
    "averageHourlyRate": 2.35,
    "earningsHistory": [
      {
        "date": "2024-12-01",
        "amount": 5.0,
        "jobCount": 2
      }
      // ... 30 days
    ]
  },
  "activeJobs": [
    {
      "jobId": "job-123",
      "clientAddress": "QUBIC_ADDRESS...",
      "gpuUsed": "RTX 4090",
      "durationSoFar": 1800,
      "earningsSoFar": 1.25,
      "estimatedTotal": 5.0,
      "status": "running",
      "startedAt": "2024-12-02T10:00:00Z",
      "pricePerHour": 2.5
    }
  ],
  "transactionHistory": [
    {
      "id": "tx-123",
      "type": "EARNING",
      "amount": 5.0,
      "status": "COMPLETED",
      "qubicTxHash": "HASH...",
      "confirmations": 3,
      "createdAt": "2024-12-02T09:00:00Z",
      "completedAt": "2024-12-02T09:05:00Z"
    }
  ],
  "performanceMetrics": {
    "uptimePercent": 95,
    "jobsCompleted": 10,
    "averageRating": 4.5,
    "responseTime": 150
  }
}
```

### 2. Get Live Earnings Update (Lightweight)

```http
GET /api/earnings/:providerId/live
```

Optimized endpoint for frequent polling (every 5 seconds). Returns only today's earnings and active jobs.

**Response:**
```json
{
  "success": true,
  "todayEarnings": 12.5,
  "activeJobs": [
    {
      "jobId": "job-123",
      "durationSoFar": 1800,
      "earningsSoFar": 1.25,
      "estimatedTotal": 5.0,
      "status": "running"
    }
  ],
  "timestamp": "2024-12-02T10:30:00Z"
}
```

### 3. Get Earnings Summary Only

```http
GET /api/earnings/:providerId/summary
```

Returns only the earnings summary without transactions or active jobs.

**Response:**
```json
{
  "success": true,
  "earnings": {
    "totalEarned": 150.5,
    "todayEarnings": 12.5,
    "weekEarnings": 45.0,
    "monthEarnings": 120.0,
    "pendingPayouts": 8.5,
    "averageHourlyRate": 2.35,
    "earningsHistory": [...]
  }
}
```

### 4. Get Active Jobs with Live Earnings

```http
GET /api/earnings/:providerId/active-jobs
```

Returns only active jobs with live earnings calculations.

**Response:**
```json
{
  "success": true,
  "activeJobs": [
    {
      "jobId": "job-123",
      "clientAddress": "QUBIC_ADDRESS...",
      "durationSoFar": 1800,
      "earningsSoFar": 1.25,
      "estimatedTotal": 5.0,
      "status": "running",
      "pricePerHour": 2.5
    }
  ]
}
```

## WebSocket Events

### Subscribe to Provider Earnings

```javascript
// Client subscribes to provider earnings updates
ws.send(JSON.stringify({
  type: 'subscribe:provider',
  subscriptionId: 'provider-123'
}));
```

### Earnings Update Event

The server broadcasts earnings updates every 5 seconds for providers with active jobs:

```json
{
  "type": "EARNINGS_UPDATE",
  "data": {
    "providerId": "provider-123",
    "todayEarnings": 12.5,
    "activeJobs": [
      {
        "jobId": "job-123",
        "durationSoFar": 1800,
        "earningsSoFar": 1.25,
        "estimatedTotal": 5.0,
        "status": "running"
      }
    ],
    "timestamp": "2024-12-02T10:30:00Z"
  }
}
```

## Earnings Calculation Logic

### Today's Earnings

```typescript
// Sum of completed jobs today + earnings from active jobs
todayEarnings = completedJobsToday.reduce((sum, job) => sum + job.actualCost, 0)
              + activeJobs.reduce((sum, job) => sum + job.earningsSoFar, 0)
```

### Active Job Earnings (Live)

```typescript
// Earnings so far = (elapsed time in hours) × (price per hour)
const elapsedSeconds = (now - job.startedAt) / 1000;
const elapsedHours = elapsedSeconds / 3600;
const earningsSoFar = elapsedHours * provider.pricePerHour;
```

### Average Hourly Rate

```typescript
// Total earnings / total hours worked
const totalHoursWorked = completedJobs.reduce((sum, job) => {
  return sum + (job.actualDuration / 3600);
}, 0);
const averageHourlyRate = provider.totalEarnings / totalHoursWorked;
```

### Earnings History (30 Days)

```typescript
// Aggregate earnings by date for last 30 days
const dailyEarnings = {};
completedJobs.forEach(job => {
  const dateKey = job.completedAt.toISOString().split('T')[0];
  dailyEarnings[dateKey] = (dailyEarnings[dateKey] || 0) + job.actualCost;
});

// Fill in missing days with 0
for (let i = 29; i >= 0; i--) {
  const date = new Date();
  date.setDate(date.getDate() - i);
  const dateKey = date.toISOString().split('T')[0];
  earningsHistory.push({
    date: dateKey,
    amount: dailyEarnings[dateKey] || 0,
    jobCount: dailyJobCounts[dateKey] || 0
  });
}
```

## Frontend Integration Example

### React Hook for Live Earnings

```typescript
import { useEffect, useState } from 'react';
import { useWebSocket } from './useWebSocket';

export function useLiveEarnings(providerId: string) {
  const [earnings, setEarnings] = useState(null);
  const { subscribe, unsubscribe } = useWebSocket();

  useEffect(() => {
    // Subscribe to earnings updates
    subscribe(`provider:${providerId}`, (event) => {
      if (event.type === 'EARNINGS_UPDATE') {
        setEarnings(event.data);
      }
    });

    // Initial fetch
    fetch(`/api/earnings/${providerId}/live`)
      .then(res => res.json())
      .then(data => setEarnings(data));

    return () => {
      unsubscribe(`provider:${providerId}`);
    };
  }, [providerId]);

  return earnings;
}
```

### Usage in Component

```typescript
function ProviderEarningsDashboard({ providerId }) {
  const earnings = useLiveEarnings(providerId);

  if (!earnings) return <div>Loading...</div>;

  return (
    <div>
      <h2>Today's Earnings: {earnings.todayEarnings.toFixed(2)} QUBIC</h2>
      <h3>Active Jobs:</h3>
      {earnings.activeJobs.map(job => (
        <div key={job.jobId}>
          <p>Job: {job.jobId}</p>
          <p>Earnings So Far: {job.earningsSoFar.toFixed(4)} QUBIC</p>
          <p>Duration: {Math.floor(job.durationSoFar / 60)} minutes</p>
        </div>
      ))}
    </div>
  );
}
```

## Performance Considerations

### Caching Strategy

- **Complete earnings data**: Cache for 30 seconds
- **Live updates**: No caching, always fresh
- **Earnings history**: Cache for 5 minutes (changes infrequently)

### Database Optimization

```sql
-- Index for fast completed jobs query
CREATE INDEX idx_jobs_provider_status_completed 
ON jobs(provider_id, status, completed_at) 
WHERE status = 'COMPLETED';

-- Index for fast active jobs query
CREATE INDEX idx_jobs_provider_status_running 
ON jobs(provider_id, status, started_at) 
WHERE status = 'RUNNING';

-- Index for fast transaction query
CREATE INDEX idx_transactions_user_type_status 
ON transactions(user_id, type, status, created_at);
```

### WebSocket Broadcasting

- Broadcasts only for providers with active jobs
- 5-second interval (configurable)
- Lightweight payload (only essential data)
- Automatic cleanup when no subscribers

## Testing

### Manual Testing

```bash
# 1. Start the backend server
npm run dev

# 2. Create a test provider with active jobs
# (Use the provider registration endpoint)

# 3. Test the earnings endpoint
curl http://localhost:3001/api/earnings/PROVIDER_ID

# 4. Test live updates
curl http://localhost:3001/api/earnings/PROVIDER_ID/live

# 5. Connect WebSocket and subscribe
# (Use a WebSocket client like wscat)
wscat -c ws://localhost:3001
> {"type":"subscribe:provider","subscriptionId":"PROVIDER_ID"}
```

### Expected Behavior

1. **Initial Load**: Complete earnings data loads in < 500ms
2. **Live Updates**: WebSocket broadcasts every 5 seconds
3. **Active Job Earnings**: Updates in real-time as jobs progress
4. **Calculation Accuracy**: Earnings = (elapsed time / 3600) × price per hour
5. **History Aggregation**: 30 days of data, grouped by date

## Troubleshooting

### No earnings updates via WebSocket

- Check if provider has active jobs (status = 'RUNNING')
- Verify WebSocket connection is established
- Confirm subscription to correct provider ID
- Check server logs for broadcaster errors

### Incorrect earnings calculations

- Verify job `startedAt` timestamp is set correctly
- Check provider `pricePerHour` is accurate
- Ensure `actualDuration` is in seconds
- Verify completed jobs have `actualCost` or `estimatedCost`

### Missing earnings history

- Check if jobs have `completedAt` timestamps
- Verify date range calculations (last 30 days)
- Ensure timezone handling is consistent

## Next Steps

1. **Add caching layer** (Redis) for high-traffic scenarios
2. **Implement rate limiting** on earnings endpoints
3. **Add earnings projections** based on current active jobs
4. **Create earnings analytics** (trends, forecasts)
5. **Add earnings notifications** (milestones, thresholds)

## Related Documentation

- [WebSocket Guide](./WEBSOCKET_GUIDE.md)
- [Provider API](./docs/PROVIDER_API.md)
- [Job Management](./JOB_MANAGEMENT_IMPLEMENTATION.md)
- [Escrow System](./ESCROW_SYSTEM.md)
