# Real-Time Metrics Streaming Backend Implementation

## Overview

This document describes the implementation of the real-time metrics streaming backend for QUBIX, which enables live monitoring of job execution with GPU metrics, logs, and progress updates.

**Requirements Implemented:** 7.5, 11.2, 11.3

## Architecture

### Database Schema

Two new models were added to the Prisma schema:

#### JobLog Model
Stores log entries from job execution:
```prisma
model JobLog {
  id        String   @id @default(uuid())
  jobId     String
  job       Job      @relation(fields: [jobId], references: [id], onDelete: Cascade)
  timestamp DateTime @default(now())
  level     String   // info, warning, error
  message   String
  
  @@index([jobId, timestamp])
}
```

#### JobMetric Model
Stores GPU metrics collected during job execution:
```prisma
model JobMetric {
  id              String   @id @default(uuid())
  jobId           String
  job             Job      @relation(fields: [jobId], references: [id], onDelete: Cascade)
  timestamp       DateTime @default(now())
  gpuUtilization  Float?
  gpuMemoryUsed   Float?
  gpuMemoryTotal  Float?
  gpuTemperature  Float?
  powerUsage      Float?
  
  @@index([jobId, timestamp])
}
```

### API Endpoints

#### POST /api/jobs/:jobId/progress
**Purpose:** Accept progress updates from workers with metrics and logs

**Request Body:**
```typescript
{
  workerId: string;
  progress: number;           // 0-100
  currentOperation?: string;  // e.g., "Training epoch 5/10"
  metrics?: {
    gpuUtilization: number;   // 0-100
    gpuMemoryUsed: number;    // MB
    gpuMemoryTotal: number;   // MB
    gpuTemperature: number;   // Celsius
    powerUsage: number;       // Watts
  };
  logLines?: Array<{
    level: 'info' | 'warning' | 'error';
    message: string;
    timestamp?: string;
  }>;
}
```

**Response:**
```typescript
{
  success: boolean;
  timeRemaining?: number;  // seconds
  costSoFar?: number;      // QUBIC tokens
}
```

**Features:**
- Validates progress (0-100)
- Updates job status to RUNNING when progress > 0
- Stores metrics in JobMetric table
- Stores logs in JobLog table
- Calculates time remaining based on progress and elapsed time
- Calculates cost-so-far based on elapsed time and hourly rate
- Broadcasts updates via WebSocket to subscribed clients

#### GET /api/jobs/:jobId/monitor
**Purpose:** Get comprehensive monitoring data for a job

**Response:**
```typescript
{
  success: boolean;
  job: {
    id: string;
    status: JobStatus;
    progress: number;
    currentOperation?: string;
    estimatedCost: number;
    actualCost?: number;
    createdAt: Date;
    startedAt?: Date;
    completedAt?: Date;
    provider: {...};
    user: {...};
  };
  metrics: {
    latest: JobMetric | null;
    history: JobMetric[];  // Last 60 seconds
  };
  logs: JobLog[];  // Last 100 entries
  timeRemaining?: number;
  costSoFar?: number;
}
```

#### GET /api/jobs/:jobId/metrics
**Purpose:** Get aggregated metrics for charts

**Query Parameters:**
- `timeRange`: Number of seconds to retrieve (default: 60)

**Response:**
```typescript
{
  success: boolean;
  metrics: JobMetric[];
  timeRange: number;
}
```

#### GET /api/jobs/:jobId/logs
**Purpose:** Get job logs with filtering

**Query Parameters:**
- `level`: Filter by log level (info, warning, error)
- `limit`: Number of logs to retrieve (default: 100)
- `offset`: Pagination offset (default: 0)

**Response:**
```typescript
{
  success: boolean;
  logs: JobLog[];
  total: number;
  limit: number;
  offset: number;
}
```

### WebSocket Events

#### JOB_PROGRESS
Broadcast when job progress is updated:
```typescript
{
  type: 'JOB_PROGRESS';
  data: {
    jobId: string;
    progress: number;
    currentOperation?: string;
    metrics?: GPUMetrics;
    timeRemaining?: number;
    costSoFar?: number;
    timestamp: string;
  };
}
```

#### JOB_LOGS
Broadcast when new logs are added:
```typescript
{
  type: 'JOB_LOGS';
  data: {
    jobId: string;
    logs: JobLog[];
    timestamp: string;
  };
}
```

## Calculations

### Time Remaining
```typescript
const elapsedMs = Date.now() - job.startedAt.getTime();
const elapsedSeconds = elapsedMs / 1000;
const estimatedTotalSeconds = (elapsedSeconds / progress) * 100;
const timeRemaining = Math.max(0, estimatedTotalSeconds - elapsedSeconds);
```

### Cost So Far
```typescript
const elapsedHours = elapsedSeconds / 3600;
const costSoFar = elapsedHours * provider.pricePerHour;
```

## Usage Example

### Worker Sending Progress Update
```typescript
const progressUpdate = {
  workerId: 'worker_123',
  progress: 45,
  currentOperation: 'Training epoch 5/10',
  metrics: {
    gpuUtilization: 87,
    gpuMemoryUsed: 18000,
    gpuMemoryTotal: 24000,
    gpuTemperature: 72,
    powerUsage: 350
  },
  logLines: [
    { level: 'info', message: 'Epoch 5/10 completed' },
    { level: 'info', message: 'Loss: 0.0234, Accuracy: 98.5%' }
  ]
};

const response = await fetch(`/api/jobs/${jobId}/progress`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(progressUpdate)
});

const result = await response.json();
console.log(`Time remaining: ${result.timeRemaining}s`);
console.log(`Cost so far: ${result.costSoFar} QUBIC`);
```

### Frontend Monitoring Job
```typescript
// Subscribe to job updates via WebSocket
ws.send(JSON.stringify({
  type: 'subscribe:job',
  subscriptionId: jobId
}));

// Listen for progress updates
ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  
  if (message.type === 'JOB_PROGRESS') {
    const { progress, currentOperation, metrics, timeRemaining, costSoFar } = message.data;
    
    // Update UI
    updateProgressBar(progress);
    updateCurrentOperation(currentOperation);
    updateGPUMetrics(metrics);
    updateTimeRemaining(timeRemaining);
    updateCostSoFar(costSoFar);
  }
  
  if (message.type === 'JOB_LOGS') {
    const { logs } = message.data;
    appendLogs(logs);
  }
};

// Fetch initial monitoring data
const response = await fetch(`/api/jobs/${jobId}/monitor`);
const data = await response.json();

// Display job info
displayJobInfo(data.job);

// Display metrics history for charts
displayMetricsChart(data.metrics.history);

// Display logs
displayLogs(data.logs);
```

## Performance Considerations

### Metrics Aggregation
- Metrics are indexed by `(jobId, timestamp)` for fast retrieval
- Default time range is 60 seconds (last 30 data points at 2s intervals)
- Queries are optimized to fetch only necessary fields

### Log Storage
- Logs are stored with cascade delete when job is deleted
- Pagination is supported for large log volumes
- Filtering by level is indexed for performance

### WebSocket Broadcasting
- Only subscribed clients receive updates
- Updates are sent immediately when progress is reported
- No polling required from frontend

## Testing

Run the test script to verify the implementation:

```bash
cd backend
npx ts-node src/scripts/test-metrics-streaming.ts
```

The test script verifies:
1. Job progress updates with metrics
2. Metrics storage in JobMetric table
3. Logs storage in JobLog table
4. Time remaining calculation
5. Cost-so-far calculation
6. Metrics aggregation (last 60 seconds)
7. Log filtering by level

## Requirements Validation

### Requirement 7.5: Metrics Update Frequency
✅ **Implemented:** WebSocket broadcasts updates every time worker reports (typically every 2 seconds)

### Requirement 11.2: Progress Report Frequency
✅ **Implemented:** Workers can report progress every 10 seconds, backend accepts and stores all updates

### Requirement 11.3: Progress Report Completeness
✅ **Implemented:** Progress updates include:
- Progress percentage (0-100)
- Current operation string
- GPU metrics (utilization, memory, temperature, power)
- Log lines with levels

## Next Steps

1. **Task 11:** Add metrics visualization with Recharts in frontend
2. **Task 15:** Enhance Python worker to collect and report metrics
3. **Task 16:** Implement job completion and payment release

## Related Files

- `backend/prisma/schema.prisma` - Database schema
- `backend/src/routes/jobs.ts` - API endpoints
- `backend/src/websocket/index.ts` - WebSocket manager
- `backend/src/scripts/test-metrics-streaming.ts` - Test script
