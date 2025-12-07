# Metrics Visualization Demo Guide

## Quick Start

To see the enhanced metrics visualization in action:

### 1. Start the Backend
```bash
cd backend
npm run dev
```

### 2. Start the Frontend
```bash
cd frontend
npm run dev
```

### 3. Navigate to JobMonitor Demo
Open your browser and go to:
```
http://localhost:5173/demo/job-monitor
```

Or if using the main app:
```
http://localhost:5173/jobs/{job-id}
```

## What You'll See

### Enhanced Metrics Section (Center Column)

#### 1. Current Metrics Cards (Top)
Four cards displaying real-time values:
- **GPU Utilization** (Cyan/Yellow/Red based on value)
  - Shows percentage with 1 decimal place
  - Alert icon appears when >85%
  - "High usage" warning displayed
  
- **GPU Memory** (Purple)
  - Shows percentage used
  - Displays "X.XX GB / Y.YY GB" below
  
- **Temperature** (Green/Yellow/Red based on value)
  - Shows temperature in Celsius
  - Alert icon appears when >80°C
  - "High temp" warning displayed
  
- **Power Usage** (Yellow)
  - Shows wattage with no decimals

#### 2. GPU Utilization Line Chart
- **Location:** Below metrics cards
- **Title:** "GPU Utilization (Last 60s)"
- **Features:**
  - Smooth animated line
  - Color changes based on current value
  - Grid lines for reference
  - Hover to see exact percentage and time

#### 3. GPU Memory Bar Chart
- **Location:** Below utilization chart
- **Title:** "Memory Usage"
- **Features:**
  - Horizontal stacked bar
  - Purple for used, gray for free
  - Hover to see exact GB values
  - Text below showing total

#### 4. Temperature Gauge
- **Location:** Below memory chart
- **Title:** "Temperature Gauge"
- **Features:**
  - Large temperature display
  - Color-coded text
  - Status text ("Normal", "Warm", "Hot")
  - Color bar showing ranges
  - Animated position indicator

#### 5. Power Usage Trend Chart
- **Location:** Below temperature gauge
- **Title:** "Power Usage Trend"
- **Features:**
  - Yellow line chart
  - Last 10 data points
  - Hover to see exact wattage and time
  - Trend indicator (↑/↓) below
  - Current power display

## Testing Scenarios

### Scenario 1: Normal Operation
**Expected Metrics:**
- GPU Utilization: 30-60% (Cyan)
- Temperature: 50-65°C (Green)
- Memory: 40-70% used
- Power: 150-250W

**What to Check:**
- All charts display smoothly
- Colors are cyan/green (normal)
- No warning icons
- Tooltips work on hover

### Scenario 2: High Load
**Expected Metrics:**
- GPU Utilization: 85-95% (Red)
- Temperature: 75-85°C (Yellow/Red)
- Memory: 80-95% used
- Power: 300-400W

**What to Check:**
- Utilization line turns red
- Temperature text turns yellow/red
- Alert icons appear
- Warning messages display
- Charts still animate smoothly

### Scenario 3: Idle State
**Expected Metrics:**
- GPU Utilization: 0-10% (Cyan)
- Temperature: 30-45°C (Green)
- Memory: 10-20% used
- Power: 50-100W

**What to Check:**
- Charts show low values
- All colors are normal (cyan/green)
- No warnings
- Charts update even with low values

## Interactive Features to Test

### 1. Hover Tooltips
**How to Test:**
- Move mouse over any chart
- Tooltip should appear immediately
- Should show exact value with unit
- Should show timestamp
- Should have dark theme styling

**Expected Behavior:**
- Smooth fade-in animation
- Follows mouse cursor
- Disappears when mouse leaves
- No lag or stuttering

### 2. Real-time Updates
**How to Test:**
- Watch charts for 30 seconds
- Observe data points being added
- Check if old points are removed
- Verify smooth transitions

**Expected Behavior:**
- New data appears every 2 seconds
- Line extends smoothly
- Old data slides off left side
- No jumps or glitches

### 3. Color Transitions
**How to Test:**
- Wait for utilization to cross 70% threshold
- Wait for utilization to cross 85% threshold
- Wait for temperature to cross 70°C
- Wait for temperature to cross 80°C

**Expected Behavior:**
- Colors change smoothly
- Line chart color updates
- Text color updates
- Alert icons appear/disappear

### 4. Threshold Warnings
**How to Test:**
- Monitor GPU utilization card
- Monitor temperature card
- Look for alert icons
- Look for warning text

**Expected Behavior:**
- Alert icon appears when threshold exceeded
- Warning text displays below value
- Icon and text disappear when below threshold
- Colors match warning level

## Visual Inspection Checklist

### Layout
- [ ] All charts are properly aligned
- [ ] No overlapping elements
- [ ] Consistent spacing between charts
- [ ] Cards have proper padding
- [ ] Text is readable

### Colors
- [ ] Cyan for normal utilization
- [ ] Yellow for moderate utilization
- [ ] Red for high utilization
- [ ] Green for normal temperature
- [ ] Yellow for warm temperature
- [ ] Red for hot temperature
- [ ] Purple for memory used
- [ ] Gray for memory free
- [ ] Yellow for power line

### Typography
- [ ] Large numbers are bold and prominent
- [ ] Labels are smaller and gray
- [ ] Units are clearly visible
- [ ] Font sizes are consistent
- [ ] Text is not cut off

### Animations
- [ ] Line charts animate smoothly
- [ ] Bar charts animate smoothly
- [ ] No stuttering or lag
- [ ] Transitions are fluid
- [ ] No flashing or flickering

### Responsiveness
- [ ] Charts resize with window
- [ ] Layout adapts to screen size
- [ ] No horizontal scrolling
- [ ] All elements visible
- [ ] Touch-friendly on mobile

## Performance Testing

### CPU Usage
**How to Test:**
1. Open browser DevTools
2. Go to Performance tab
3. Record for 30 seconds
4. Check CPU usage

**Expected:**
- CPU usage <10% when idle
- CPU usage <30% during updates
- No memory leaks
- Smooth 60fps animations

### Memory Usage
**How to Test:**
1. Open browser DevTools
2. Go to Memory tab
3. Take heap snapshot
4. Wait 5 minutes
5. Take another snapshot
6. Compare sizes

**Expected:**
- Memory usage stable
- No significant growth over time
- Old data points garbage collected
- No memory leaks

### Network Usage
**How to Test:**
1. Open browser DevTools
2. Go to Network tab
3. Monitor WebSocket traffic
4. Check message frequency

**Expected:**
- WebSocket messages every 2 seconds
- Message size <1KB
- No failed requests
- Stable connection

## Troubleshooting

### Charts Not Displaying
**Possible Causes:**
- Recharts not installed
- WebSocket not connected
- No metrics data received
- Browser compatibility issue

**Solutions:**
1. Check console for errors
2. Verify WebSocket connection
3. Check if metrics are being sent
4. Try different browser

### Animations Stuttering
**Possible Causes:**
- Too many data points
- High CPU usage
- Browser performance issues
- Too frequent updates

**Solutions:**
1. Check data point limit (should be 30)
2. Close other browser tabs
3. Check CPU usage
4. Reduce update frequency

### Colors Not Changing
**Possible Causes:**
- Threshold values incorrect
- Metrics not updating
- CSS not loading
- State not updating

**Solutions:**
1. Check metric values in console
2. Verify WebSocket updates
3. Check browser DevTools
4. Refresh page

### Tooltips Not Working
**Possible Causes:**
- Mouse events not firing
- Recharts configuration issue
- CSS z-index problem
- Browser compatibility

**Solutions:**
1. Check browser console
2. Verify Recharts version
3. Try different browser
4. Check CSS conflicts

## Demo Data

If you need to test without a real job, you can use mock data:

```typescript
// Mock metrics for testing
const mockMetrics = {
  gpuUtilization: 75.5,
  gpuMemoryUsed: 16384, // MB
  gpuMemoryTotal: 24576, // MB
  gpuTemperature: 72.3,
  powerUsage: 285,
  timestamp: new Date()
};
```

## Screenshots

Take screenshots of:
1. Normal operation (all green/cyan)
2. High load (red/yellow warnings)
3. Hover tooltips
4. Different screen sizes
5. Different browsers

## Video Recording

Record a video showing:
1. Charts updating in real-time
2. Smooth animations
3. Color transitions
4. Hover interactions
5. Responsive design

## Feedback Collection

After testing, note:
- What works well
- What could be improved
- Any bugs or issues
- Performance observations
- User experience feedback

## Next Steps

After successful demo:
1. Share screenshots with team
2. Gather feedback
3. Make adjustments if needed
4. Prepare for production deployment
5. Update documentation

---

**Demo Status:** Ready for Testing

**Last Updated:** December 2, 2025

**Demo URL:** http://localhost:5173/demo/job-monitor

**Contact:** Check TASK_11_METRICS_VISUALIZATION_SUMMARY.md for details
