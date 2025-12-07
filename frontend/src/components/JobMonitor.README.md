# JobMonitor Component

Real-time job monitoring dashboard with live GPU metrics, log streaming, and progress tracking.

## Features

### 3-Column Layout
- **Left Column**: Job information (ID, status, GPU, times, cost)
- **Center Column**: Live GPU metrics with animated charts
- **Right Column**: Log stream with auto-scroll and filtering

### Real-Time Updates
- WebSocket subscription for job progress updates
- GPU metrics update every 2 seconds
- Live log streaming with auto-scroll
- Progress bar and time remaining calculation
- Cost tracking (cost so far)

### GPU Metrics Visualization
- **GPU Utilization**: Line chart showing last 60 seconds
- **GPU Memory**: Bar chart with used/total ratio
- **Temperature**: Gauge with color coding (green <70°C, yellow 70-80°C, red >80°C)
- **Power Usage**: Current wattage display
- **Threshold Warnings**: Highlights metrics exceeding safe thresholds

### Log Streaming
- Real-time log display with timestamps
- Log level filtering (all, info, warning, error)
- Auto-scroll with manual override
- Color-coded by severity

### Timeline
- Visual progress timeline
- Shows job creation, start, progress, and completion
- Animated progress indicator

### Action Buttons
- Pause Job (for running jobs)
- Stop Job (for running jobs)
- Extend Time (for running jobs)
- Download Results (for completed jobs)

## Usage

```tsx
import JobMonitor from '../components/JobMonitor';

function MyPage() {
  return (
    <JobMonitor 
      jobId="abc123..." 
      onClose={() => console.log('Monitor closed')}
    />
  );
}
```

## Props

```typescript
interface JobMonitorProps {
  jobId: string;           // Required: Job ID to monitor
  onClose?: () => void;    // Optional: Callback when monitor is closed
}
```

## Requirements Validated

- **7.1**: 3-column layout with job info, metrics, and logs
- **7.2**: Displays job ID, status, GPU, times, and cost
- **7.3**: Shows live GPU utilization, memory, temperature, and power
- **7.4**: Real-time log streaming with auto-scroll
- **7.6**: Progress percentage and current operation display
- **7.7**: Visual timeline with progress bar
- **8.1**: Animated line graph for GPU utilization (last 60 seconds)
- **8.2**: Bar chart for GPU memory (used/total)
- **8.3**: Temperature gauge with color coding
- **8.4**: Power usage display with historical trend

## WebSocket Events

The component subscribes to the following WebSocket events:

```typescript
{
  type: 'JOB_PROGRESS',
  jobId: string,
  progress: number,              // 0-100
  currentOperation: string,
  metrics: {
    gpuUtilization: number,      // 0-100
    gpuMemoryUsed: number,       // MB
    gpuMemoryTotal: number,      // MB
    gpuTemperature: number,      // Celsius
    powerUsage: number           // Watts
  },
  timeRemaining: number,         // seconds
  costSoFar: number,            // QUBIC
  logLines: string[]
}
```

## Demo

Visit `/job-monitor-demo` to see the component in action.

## Styling

The component uses:
- TailwindCSS for styling
- Recharts for data visualization
- Lucide React for icons
- Gradient backgrounds and animations
- Color-coded metrics based on thresholds

## Performance

- Keeps only last 30 data points (60 seconds at 2s intervals)
- Efficient log rendering with virtualization
- Smooth animations with CSS transitions
- Optimized re-renders with React hooks

## Accessibility

- Semantic HTML structure
- ARIA labels for interactive elements
- Keyboard navigation support
- Color-blind friendly color schemes
- High contrast text

## Browser Support

- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## Dependencies

- react ^18.2.0
- recharts ^2.15.4
- lucide-react ^0.555.0
- react-hot-toast ^2.6.0
- Custom WebSocket hooks (useJobProgress)
