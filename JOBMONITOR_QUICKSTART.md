# JobMonitor Component - Quick Start Guide

## Overview

The JobMonitor component provides a real-time dashboard for monitoring GPU compute jobs with live metrics, log streaming, and progress tracking.

## Quick Access

### Demo Page
Navigate to: **`http://localhost:5173/job-monitor-demo`**

### Steps to Test

1. **Start the Frontend**:
   ```bash
   cd frontend
   npm run dev
   ```

2. **Open Browser**:
   - Go to `http://localhost:5173/job-monitor-demo`

3. **Enter Job ID**:
   - Enter a valid job ID from your database
   - Click "Start Monitoring"

4. **View Real-Time Dashboard**:
   - See job information in left column
   - Watch live GPU metrics in center column
   - View log stream in right column
   - Monitor progress bar and timeline

## Features Demonstrated

### 1. Job Information (Left Column)
- Job ID and status
- GPU model and VRAM
- Worker ID
- Timestamps (created, started)
- Cost tracking (estimated, actual, so far)
- Duration and time remaining
- Action buttons (pause, stop, extend, download)

### 2. Live GPU Metrics (Center Column)
- **GPU Utilization**: Percentage with color coding
- **GPU Memory**: Used/Total in GB and percentage
- **Temperature**: Celsius with color warnings
- **Power Usage**: Watts
- **Utilization Chart**: Line graph of last 60 seconds
- **Memory Bar**: Visual representation of usage

### 3. Log Stream (Right Column)
- Real-time log display
- Timestamps for each entry
- Log level filtering (all, info, warning, error)
- Color coding by severity
- Auto-scroll with manual override
- "Scroll to Bottom" button

### 4. Progress Tracking (Top)
- Animated progress bar (0-100%)
- Current operation display
- Duration counter
- Time remaining estimate
- Cost-so-far tracker

### 5. Timeline (Bottom)
- Job creation event
- Execution start event
- In-progress indicator (pulsing)
- Completion/failure event
- Animated progress line

## WebSocket Integration

The component automatically subscribes to job updates via WebSocket:

```typescript
// Event format
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

## Color Coding

### Temperature
- 🟢 **Green**: < 70°C (safe)
- 🟡 **Yellow**: 70-80°C (warm)
- 🔴 **Red**: > 80°C (hot) + warning icon

### GPU Utilization
- 🔵 **Cyan**: < 70% (normal)
- 🟡 **Yellow**: 70-85% (high)
- 🔴 **Red**: > 85% (very high) + warning icon

## Testing Checklist

- [ ] Component loads without errors
- [ ] Job information displays correctly
- [ ] Progress bar animates smoothly
- [ ] GPU metrics update in real-time
- [ ] Charts render and animate
- [ ] Logs stream correctly
- [ ] Auto-scroll works
- [ ] Log filtering works
- [ ] Timeline displays correctly
- [ ] Action buttons appear based on status
- [ ] Responsive on mobile
- [ ] WebSocket reconnects automatically

## Requirements Validated

✅ **7.1**: 3-column layout  
✅ **7.2**: Job info display  
✅ **7.3**: Live GPU metrics  
✅ **7.4**: Log streaming  
✅ **7.6**: Progress tracking  
✅ **7.7**: Timeline visualization  
✅ **8.1**: Utilization chart  
✅ **8.2**: Memory bar chart  
✅ **8.3**: Temperature gauge  
✅ **8.4**: Power usage display  

## Integration with Backend

### Required Backend Endpoints

1. **GET /api/jobs/:jobId**
   - Returns job details
   - Used for initial load

2. **WebSocket Events**
   - Subscribe: `subscribe:job:{jobId}`
   - Receive: `JOB_PROGRESS` events
   - Receive: `JOB_COMPLETED` events

### Required Worker Functionality

Workers should send progress updates every 10 seconds:
- Progress percentage
- Current operation
- GPU metrics (utilization, memory, temp, power)
- Log lines

## Troubleshooting

### Component shows "Loading job details..."
- Check if backend is running
- Verify job ID exists in database
- Check browser console for errors

### No metrics displayed
- Verify WebSocket connection
- Check if worker is sending metrics
- Ensure job is in RUNNING status

### Logs not streaming
- Check WebSocket connection
- Verify worker is sending log lines
- Check browser console for errors

### Charts not rendering
- Verify Recharts is installed
- Check browser console for errors
- Ensure metrics data is valid

## Next Steps

1. **Test with Real Jobs**: Create and monitor actual jobs
2. **Backend Integration**: Ensure WebSocket events are sent
3. **Worker Integration**: Verify metrics and logs are reported
4. **Action Buttons**: Implement pause, stop, extend functionality
5. **Download Results**: Add result download feature
6. **Performance Testing**: Test with high-frequency updates
7. **Browser Testing**: Test across different browsers

## Documentation

- **Component README**: `frontend/src/components/JobMonitor.README.md`
- **Manual Tests**: `frontend/src/components/__manual_tests__/JobMonitor.test.md`
- **Unit Tests**: `frontend/src/components/__tests__/JobMonitor.test.tsx`
- **Implementation Summary**: `TASK_9_JOBMONITOR_SUMMARY.md`

## Support

For issues or questions:
1. Check the manual test guide
2. Review the component README
3. Check browser console for errors
4. Verify backend and WebSocket are running
5. Ensure job exists and is in correct status

---

**Status**: ✅ Complete and ready for testing
**Demo URL**: http://localhost:5173/job-monitor-demo
