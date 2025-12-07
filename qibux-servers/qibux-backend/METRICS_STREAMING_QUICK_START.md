# Real-Time Metrics Streaming - Quick Start Guide

## For Workers: Sending Progress Updates

### Basic Progress Update
```typescript
const response = await fetch(`${API_URL}/api/jobs/${jobId}/progress`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    workerId: 'your_worker_id',
    progress: 45,  // 0-100
    currentOperation: 'Training epoch 5/10'
  })
});

const result = await response.json();
console.log(`Time remaining: ${result.timeRemaining}s`);
console.log(`Cost so far: ${result.costSoFar} QUBIC`);
```

### Progress Update with GPU Metrics
```typescript
await fetch(`${API_URL}/api/jobs/${jobId}/progress`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    workerId: 'your_worker_id',
    progress: 45,
    currentOperation: 'Training epoch 5/10',
    metrics: {
      gpuUtilization: 87,      // 0-100
      gpuMemoryUsed: 18000,    // MB
      gpuMemoryTotal: 24000,   // MB
      gpuTemperature: 72,      // Celsius
      powerUsage: 350          // Watts
    }
  })
});
```

### Progress Update with Logs
```typescript
await fetch(`${API_URL}/api/jobs/${jobId}/progress`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    workerId: 'your_worker_id',
    progress: 45,
    currentOperation: 'Training epoch 5/10',
    logLines: [
      { level: 'info', message: 'Epoch 5/10 completed' },
      { level: 'info', message: 'Loss: 0.0234, Accuracy: 98.5%' },
      { level: 'warning', message: 'GPU temperature high: 82°C' }
    ]
  })
});
```

### Complete Progress Update
```typescript
await fetch(`${API_URL}/api/jobs/${jobId}/progress`, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    workerId: 'your_worker_id',
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
  })
});
```

## For Frontend: Monitoring Jobs

### Get Initial Monitoring Data
```typescript
const response = await fetch(`${API_URL}/api/jobs/${jobId}/monitor`);
const data = await response.json();

// Access job details
console.log(`Status: ${data.job.status}`);
console.log(`Progress: ${data.job.progress}%`);
console.log(`Operation: ${data.job.currentOperation}`);

// Access latest metrics
if (data.metrics.latest) {
  console.log(`GPU: ${data.metrics.latest.gpuUtilization}%`);
  console.log(`Temp: ${data.metrics.latest.gpuTemperature}°C`);
}

// Access metrics history for charts
const metricsHistory = data.metrics.history;

// Access logs
const logs = data.logs;

// Access calculations
console.log(`Time remaining: ${data.timeRemaining}s`);
console.log(`Cost so far: ${data.costSoFar} QUBIC`);
```

### Subscribe to Real-Time Updates
```typescript
const ws = new WebSocket(WS_URL);

ws.onopen = () => {
  // Subscribe to job updates
  ws.send(JSON.stringify({
    type: 'subscribe:job',
    subscriptionId: jobId
  }));
};

ws.onmessage = (event) => {
  const message = JSON.parse(event.data);
  
  switch (message.type) {
    case 'JOB_PROGRESS':
      const { progress, currentOperation, metrics, timeRemaining, costSoFar } = message.data;
      
      // Update UI
      updateProgressBar(progress);
      updateCurrentOperation(currentOperation);
      
      if (metrics) {
        updateGPUUtilization(metrics.gpuUtilization);
        updateGPUMemory(metrics.gpuMemoryUsed, metrics.gpuMemoryTotal);
        updateGPUTemperature(metrics.gpuTemperature);
        updatePowerUsage(metrics.powerUsage);
      }
      
      updateTimeRemaining(timeRemaining);
      updateCostSoFar(costSoFar);
      break;
      
    case 'JOB_LOGS':
      const { logs } = message.data;
      appendLogs(logs);
      break;
      
    case 'JOB_COMPLETED':
      const { status, result } = message.data;
      handleJobCompletion(status, result);
      break;
  }
};
```

### Get Metrics for Charts
```typescript
// Get last 60 seconds of metrics
const response = await fetch(`${API_URL}/api/jobs/${jobId}/metrics?timeRange=60`);
const data = await response.json();

// Use metrics for charts
const chartData = data.metrics.map(m => ({
  timestamp: new Date(m.timestamp),
  gpuUtilization: m.gpuUtilization,
  gpuTemperature: m.gpuTemperature,
  gpuMemoryUsed: m.gpuMemoryUsed
}));

// Render with Recharts
<LineChart data={chartData}>
  <Line dataKey="gpuUtilization" stroke="#8884d8" />
  <Line dataKey="gpuTemperature" stroke="#82ca9d" />
</LineChart>
```

### Get Filtered Logs
```typescript
// Get info logs only
const response = await fetch(`${API_URL}/api/jobs/${jobId}/logs?level=info&limit=50`);
const data = await response.json();

data.logs.forEach(log => {
  console.log(`[${log.level}] ${log.timestamp}: ${log.message}`);
});

// Pagination
const page2 = await fetch(`${API_URL}/api/jobs/${jobId}/logs?limit=50&offset=50`);
```

## Python Worker Example

```python
import requests
import time
import subprocess

def get_gpu_metrics():
    """Get GPU metrics using nvidia-smi"""
    try:
        result = subprocess.run([
            'nvidia-smi',
            '--query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu,power.draw',
            '--format=csv,noheader,nounits'
        ], capture_output=True, text=True)
        
        values = result.stdout.strip().split(',')
        return {
            'gpuUtilization': float(values[0]),
            'gpuMemoryUsed': float(values[1]),
            'gpuMemoryTotal': float(values[2]),
            'gpuTemperature': float(values[3]),
            'powerUsage': float(values[4])
        }
    except Exception as e:
        print(f"Error getting GPU metrics: {e}")
        return None

def report_progress(job_id, worker_id, progress, operation, logs=[]):
    """Report progress to backend"""
    metrics = get_gpu_metrics()
    
    data = {
        'workerId': worker_id,
        'progress': progress,
        'currentOperation': operation,
        'metrics': metrics,
        'logLines': logs
    }
    
    response = requests.post(
        f'{API_URL}/api/jobs/{job_id}/progress',
        json=data
    )
    
    result = response.json()
    print(f"Progress: {progress}% - Time remaining: {result.get('timeRemaining')}s")
    return result

# Example usage in training loop
for epoch in range(10):
    # Training code here...
    
    progress = int((epoch + 1) / 10 * 100)
    operation = f'Training epoch {epoch + 1}/10'
    logs = [
        {'level': 'info', 'message': f'Epoch {epoch + 1} completed'},
        {'level': 'info', 'message': f'Loss: {loss:.4f}, Accuracy: {acc:.2f}%'}
    ]
    
    report_progress(job_id, worker_id, progress, operation, logs)
    time.sleep(10)  # Report every 10 seconds
```

## React Component Example

```typescript
import { useEffect, useState } from 'react';
import { LineChart, Line, XAxis, YAxis, Tooltip } from 'recharts';

function JobMonitor({ jobId }) {
  const [job, setJob] = useState(null);
  const [metrics, setMetrics] = useState([]);
  const [logs, setLogs] = useState([]);
  const [timeRemaining, setTimeRemaining] = useState(null);
  const [costSoFar, setCostSoFar] = useState(null);

  useEffect(() => {
    // Fetch initial data
    fetch(`/api/jobs/${jobId}/monitor`)
      .then(res => res.json())
      .then(data => {
        setJob(data.job);
        setMetrics(data.metrics.history);
        setLogs(data.logs);
        setTimeRemaining(data.timeRemaining);
        setCostSoFar(data.costSoFar);
      });

    // Subscribe to WebSocket updates
    const ws = new WebSocket(WS_URL);
    
    ws.onopen = () => {
      ws.send(JSON.stringify({
        type: 'subscribe:job',
        subscriptionId: jobId
      }));
    };

    ws.onmessage = (event) => {
      const message = JSON.parse(event.data);
      
      if (message.type === 'JOB_PROGRESS') {
        const { progress, currentOperation, metrics: newMetrics, timeRemaining, costSoFar } = message.data;
        
        setJob(prev => ({
          ...prev,
          progress,
          currentOperation
        }));
        
        if (newMetrics) {
          setMetrics(prev => [...prev.slice(-29), newMetrics]);
        }
        
        setTimeRemaining(timeRemaining);
        setCostSoFar(costSoFar);
      }
      
      if (message.type === 'JOB_LOGS') {
        setLogs(prev => [...prev, ...message.data.logs]);
      }
    };

    return () => ws.close();
  }, [jobId]);

  return (
    <div>
      <h2>Job {jobId}</h2>
      <p>Status: {job?.status}</p>
      <p>Progress: {job?.progress}%</p>
      <p>Operation: {job?.currentOperation}</p>
      <p>Time Remaining: {timeRemaining}s</p>
      <p>Cost So Far: {costSoFar} QUBIC</p>
      
      <LineChart width={600} height={300} data={metrics}>
        <XAxis dataKey="timestamp" />
        <YAxis />
        <Tooltip />
        <Line dataKey="gpuUtilization" stroke="#8884d8" />
        <Line dataKey="gpuTemperature" stroke="#82ca9d" />
      </LineChart>
      
      <div>
        <h3>Logs</h3>
        {logs.map((log, i) => (
          <div key={i}>[{log.level}] {log.message}</div>
        ))}
      </div>
    </div>
  );
}
```

## Testing

Run the test script:
```bash
cd backend
npx ts-node src/scripts/test-metrics-streaming.ts
```

## Troubleshooting

### Worker not receiving time remaining
- Ensure job has `startedAt` timestamp
- Ensure progress > 0
- Check that provider has `pricePerHour` set

### Metrics not appearing in charts
- Check that metrics are being sent in progress updates
- Verify timeRange parameter (default 60 seconds)
- Ensure metrics have valid numeric values

### Logs not streaming
- Verify WebSocket connection is established
- Check that logLines array is properly formatted
- Ensure log level is one of: info, warning, error

### Cost calculation incorrect
- Verify provider `pricePerHour` is set correctly
- Check that job `startedAt` timestamp exists
- Ensure elapsed time calculation is correct

## API Reference

See full documentation: `backend/METRICS_STREAMING_IMPLEMENTATION.md`
