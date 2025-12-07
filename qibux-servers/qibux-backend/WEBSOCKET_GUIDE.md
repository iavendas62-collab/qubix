# WebSocket Implementation Guide

## Overview

The QUBIX platform uses WebSockets for real-time bidirectional communication between the backend and frontend. This enables instant updates for marketplace changes, provider status, GPU metrics, and job progress.

## Architecture

### Backend (Node.js)

**Location:** `backend/src/websocket/index.ts`

The backend implements a `WebSocketManager` class that handles:
- Connection management (tracking connected clients)
- Subscription system (marketplace, providers, jobs)
- Broadcasting updates to subscribed clients
- Automatic heartbeat to detect stale connections
- Graceful shutdown

### Frontend (React)

**Location:** `frontend/src/services/websocket.ts`

The frontend implements a `WebSocketClient` class with:
- Automatic reconnection with exponential backoff (1s, 2s, 4s, up to 5s)
- Subscription management
- Event handling system
- Ping/pong heartbeat
- Connection state tracking

**React Hooks:** `frontend/src/hooks/useWebSocket.ts`

Provides convenient React hooks:
- `useWebSocket()` - Core WebSocket functionality
- `useMarketplaceUpdates()` - Subscribe to marketplace events
- `useProviderMetrics()` - Subscribe to provider GPU metrics
- `useJobProgress()` - Subscribe to job progress updates

## Event Types

### Client → Server

- `subscribe:marketplace` - Subscribe to marketplace updates
- `subscribe:provider` - Subscribe to specific provider updates (requires `subscriptionId`)
- `subscribe:job` - Subscribe to specific job updates (requires `subscriptionId`)
- `unsubscribe` - Unsubscribe from a subscription (requires `subscriptionId`)
- `ping` - Heartbeat ping

### Server → Client

- `pong` - Heartbeat response
- `subscribed` - Confirmation of subscription
- `PROVIDER_REGISTERED` - New provider registered
- `PROVIDER_STATUS_CHANGED` - Provider status changed (online/offline/busy)
- `GPU_METRICS_UPDATE` - Real-time GPU metrics update
- `JOB_PROGRESS` - Job execution progress update
- `JOB_COMPLETED` - Job completed
- `MARKETPLACE_UPDATE` - General marketplace update
- `error` - Error message

## Usage Examples

### Backend - Broadcasting Updates

```typescript
// In your route or service
const { wsManager } = services;

// Broadcast new provider registration
wsManager.broadcastProviderRegistered({
  id: provider.id,
  workerId: provider.workerId,
  gpuModel: provider.gpuModel,
  pricePerHour: provider.pricePerHour
});

// Broadcast provider status change
wsManager.broadcastProviderStatusChanged(providerId, {
  isOnline: true,
  isAvailable: true
});

// Broadcast GPU metrics
wsManager.broadcastGPUMetrics(providerId, {
  cpuPercent: 45.2,
  ramPercent: 60.1,
  gpuPercent: 80.5,
  gpuTemp: 72
});

// Broadcast job progress
wsManager.broadcastJobProgress(jobId, {
  progress: 75,
  status: 'running'
});

// Broadcast job completion
wsManager.broadcastJobCompleted(jobId, {
  status: 'completed',
  result: { /* ... */ }
});
```

### Frontend - Using React Hooks

```typescript
import { useMarketplaceUpdates } from '../hooks/useWebSocket';

function MarketplaceComponent() {
  const [providers, setProviders] = useState([]);

  useMarketplaceUpdates((data) => {
    console.log('Marketplace update:', data);
    // Update your state based on the event type
    // data will contain the update information
  });

  return (
    <div>
      {/* Your marketplace UI */}
    </div>
  );
}
```

```typescript
import { useProviderMetrics } from '../hooks/useWebSocket';

function ProviderDashboard({ providerId }) {
  const [metrics, setMetrics] = useState(null);

  useProviderMetrics(providerId, (data) => {
    setMetrics(data.metrics);
  });

  return (
    <div>
      {metrics && (
        <div>
          <p>GPU Usage: {metrics.gpuPercent}%</p>
          <p>Temperature: {metrics.gpuTemp}°C</p>
        </div>
      )}
    </div>
  );
}
```

```typescript
import { useJobProgress } from '../hooks/useWebSocket';

function JobMonitor({ jobId }) {
  const [progress, setProgress] = useState(0);

  useJobProgress(jobId, (data) => {
    if (data.progress) {
      setProgress(data.progress.progress);
    }
  });

  return (
    <div>
      <progress value={progress} max={100} />
      <span>{progress}%</span>
    </div>
  );
}
```

### Frontend - Direct WebSocket Client Usage

```typescript
import { getWebSocketClient, WSEventType } from '../services/websocket';

const wsClient = getWebSocketClient();

// Connect
await wsClient.connect();

// Subscribe to marketplace
wsClient.subscribeToMarketplace();

// Listen for events
wsClient.on(WSEventType.PROVIDER_REGISTERED, (data) => {
  console.log('New provider:', data);
});

// Subscribe to specific provider
wsClient.subscribeToProvider('provider-123');

// Listen for metrics
wsClient.on(WSEventType.GPU_METRICS_UPDATE, (data) => {
  console.log('Metrics:', data);
});

// Unsubscribe
wsClient.unsubscribe('provider:provider-123');

// Disconnect
wsClient.disconnect();
```

## Connection Management

### Automatic Reconnection

The client automatically reconnects when the connection is lost:
- Uses exponential backoff: 1s, 2s, 4s, 8s (max 5s per requirements)
- Maximum 10 reconnection attempts
- Automatically resubscribes to all previous subscriptions after reconnection

### Heartbeat

- Client sends `ping` every 30 seconds
- Server tracks last ping time for each client
- Server closes connections that haven't pinged in 60 seconds
- Server checks for stale connections every 30 seconds

## API Endpoints

### GET /api/websocket/stats

Get WebSocket server statistics.

**Response:**
```json
{
  "success": true,
  "stats": {
    "totalClients": 15,
    "totalSubscriptions": 8,
    "subscriptionDetails": [
      {
        "subscriptionId": "marketplace",
        "subscriberCount": 10
      },
      {
        "subscriptionId": "provider:abc123",
        "subscriberCount": 3
      }
    ]
  }
}
```

## Testing

### Manual Testing

1. Start the backend server
2. Open browser console
3. Connect to WebSocket:
```javascript
const ws = new WebSocket('ws://localhost:3001');
ws.onopen = () => console.log('Connected');
ws.onmessage = (e) => console.log('Message:', JSON.parse(e.data));
ws.send(JSON.stringify({ type: 'subscribe:marketplace' }));
```

### Integration Testing

Test WebSocket functionality by:
1. Registering a new provider (should broadcast `PROVIDER_REGISTERED`)
2. Updating provider status (should broadcast `PROVIDER_STATUS_CHANGED`)
3. Submitting a job (should broadcast `JOB_PROGRESS` and `JOB_COMPLETED`)

## Requirements Validation

This implementation satisfies the following requirements:

- **7.1**: WebSocket connection established when user opens marketplace ✅
- **7.2**: New provider registrations broadcast to all connected clients ✅
- **7.3**: GPU availability updates sent automatically ✅
- **7.4**: GPU rental status updates sent immediately ✅
- **7.5**: Automatic reconnection within 5 seconds on disconnection ✅

## Performance Considerations

- Each client maintains its own subscription set
- Broadcasts only sent to subscribed clients
- Stale connections automatically cleaned up
- Minimal memory footprint per connection
- Efficient message routing using Map data structures

## Security Considerations

- WebSocket connections should be upgraded to WSS (secure) in production
- Consider adding authentication tokens for WebSocket connections
- Rate limiting should be implemented for subscription requests
- Validate all incoming messages to prevent injection attacks
