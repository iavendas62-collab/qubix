# JobMonitor Component - Manual Test Guide

## Test Environment Setup

1. Start the backend server:
   ```bash
   cd backend
   npm run dev
   ```

2. Start the frontend:
   ```bash
   cd frontend
   npm run dev
   ```

3. Navigate to: `http://localhost:5173/job-monitor-demo`

## Test Cases

### TC1: Component Loading
**Objective**: Verify component loads and displays initial state

**Steps**:
1. Navigate to `/job-monitor-demo`
2. Enter a valid job ID
3. Click "Start Monitoring"

**Expected Results**:
- ✅ Component displays loading state initially
- ✅ 3-column layout appears after data loads
- ✅ Job information displays in left column
- ✅ Metrics section shows "Waiting for metrics..." if no data yet
- ✅ Logs section shows "No logs yet..." if empty

**Requirements**: 7.1, 7.2

---

### TC2: Job Information Display
**Objective**: Verify all job information is displayed correctly

**Steps**:
1. Monitor a job with complete information
2. Verify all fields are present

**Expected Results**:
- ✅ Job ID displayed (truncated)
- ✅ Status badge shows correct status with color
- ✅ GPU model displayed
- ✅ VRAM amount shown
- ✅ Hourly rate displayed in QUBIC
- ✅ Worker ID shown (truncated)
- ✅ Created timestamp formatted correctly
- ✅ Started timestamp shown if job started
- ✅ Estimated cost displayed

**Requirements**: 7.2

---

### TC3: Progress Bar and Current Operation
**Objective**: Verify progress tracking displays correctly

**Steps**:
1. Monitor a running job
2. Observe progress bar updates

**Expected Results**:
- ✅ Progress bar shows percentage (0-100%)
- ✅ Progress bar animates smoothly
- ✅ Current operation string displays
- ✅ Progress percentage shown in top right
- ✅ Progress updates in real-time via WebSocket

**Requirements**: 7.6

---

### TC4: Time and Cost Tracking
**Objective**: Verify time and cost calculations

**Steps**:
1. Monitor a running job
2. Observe duration, time remaining, and cost

**Expected Results**:
- ✅ Duration updates every second
- ✅ Duration formatted correctly (Xh Ym Zs)
- ✅ Time remaining displays or shows "Calculating..."
- ✅ Time remaining formatted correctly
- ✅ Cost so far displays in QUBIC
- ✅ Cost updates in real-time

**Requirements**: 7.2, 12.2, 12.3

---

### TC5: GPU Metrics Display
**Objective**: Verify live GPU metrics are displayed correctly

**Steps**:
1. Monitor a job with GPU metrics
2. Wait for metrics to arrive via WebSocket

**Expected Results**:
- ✅ GPU Utilization shows percentage with color coding
- ✅ GPU Memory shows percentage and GB values
- ✅ Temperature shows in Celsius with color coding
- ✅ Power usage shows in Watts
- ✅ Metrics update every 2 seconds
- ✅ Warning icons appear for high values

**Requirements**: 7.3, 8.1, 8.2, 8.3, 8.4

---

### TC6: GPU Utilization Chart
**Objective**: Verify utilization chart displays and animates

**Steps**:
1. Monitor a job with metrics
2. Observe the line chart

**Expected Results**:
- ✅ Line chart displays with last 60 seconds of data
- ✅ Chart animates smoothly as new data arrives
- ✅ X-axis hidden for cleaner look
- ✅ Y-axis shows 0-100 range
- ✅ Tooltip shows exact values on hover
- ✅ Chart keeps only last 30 data points

**Requirements**: 8.1

---

### TC7: Memory Bar Chart
**Objective**: Verify memory usage visualization

**Steps**:
1. Monitor a job with metrics
2. Observe memory bar

**Expected Results**:
- ✅ Bar shows used/total ratio
- ✅ Bar animates smoothly
- ✅ Gradient color (purple to pink)
- ✅ Percentage matches calculation

**Requirements**: 8.2

---

### TC8: Temperature Color Coding
**Objective**: Verify temperature thresholds and warnings

**Steps**:
1. Monitor jobs with different temperatures
2. Verify color changes

**Expected Results**:
- ✅ Green color for temp < 70°C
- ✅ Yellow color for temp 70-80°C
- ✅ Red color for temp > 80°C
- ✅ Warning icon appears for temp > 80°C
- ✅ "High temp" message displays

**Requirements**: 8.3, 8.5

---

### TC9: Utilization Warnings
**Objective**: Verify utilization threshold warnings

**Steps**:
1. Monitor job with high GPU utilization
2. Verify warnings appear

**Expected Results**:
- ✅ Cyan color for util < 70%
- ✅ Yellow color for util 70-85%
- ✅ Red color for util > 85%
- ✅ Warning icon appears for util > 85%
- ✅ "High usage" message displays

**Requirements**: 8.5

---

### TC10: Log Streaming
**Objective**: Verify real-time log display

**Steps**:
1. Monitor a job that produces logs
2. Observe log stream

**Expected Results**:
- ✅ Logs appear in real-time
- ✅ Timestamps formatted correctly
- ✅ Log levels shown ([INFO], [WARNING], [ERROR])
- ✅ Color coding by level (info: white, warning: yellow, error: red)
- ✅ Auto-scroll enabled by default
- ✅ Logs scroll to bottom automatically

**Requirements**: 7.4

---

### TC11: Log Filtering
**Objective**: Verify log level filtering

**Steps**:
1. Monitor a job with mixed log levels
2. Test each filter option

**Expected Results**:
- ✅ "All" shows all logs
- ✅ "Info" shows only info logs
- ✅ "Warning" shows only warning logs
- ✅ "Error" shows only error logs
- ✅ Filter dropdown works correctly
- ✅ Filtered logs display immediately

**Requirements**: 7.4

---

### TC12: Auto-Scroll Behavior
**Objective**: Verify auto-scroll functionality

**Steps**:
1. Monitor a job with many logs
2. Scroll up manually
3. Observe auto-scroll behavior

**Expected Results**:
- ✅ Auto-scroll enabled by default
- ✅ Auto-scroll disables when user scrolls up
- ✅ Auto-scroll button appears when disabled
- ✅ Filter icon highlights when auto-scroll enabled
- ✅ "Scroll to Bottom" button works
- ✅ Auto-scroll re-enables when at bottom

**Requirements**: 7.4

---

### TC13: Timeline Visualization
**Objective**: Verify timeline displays correctly

**Steps**:
1. Monitor a job through its lifecycle
2. Observe timeline updates

**Expected Results**:
- ✅ "Job Created" event shows with green dot
- ✅ "Execution Started" shows when job starts
- ✅ "In Progress" shows with pulsing blue dot
- ✅ Current operation displays in timeline
- ✅ "Completed" or "Failed" shows when done
- ✅ Progress line animates with job progress
- ✅ Timestamps formatted correctly

**Requirements**: 7.7

---

### TC14: Action Buttons - Running Job
**Objective**: Verify action buttons for running jobs

**Steps**:
1. Monitor a running job
2. Verify buttons appear

**Expected Results**:
- ✅ "Pause Job" button visible
- ✅ "Stop Job" button visible
- ✅ "Extend Time" button visible
- ✅ Buttons have correct icons
- ✅ Buttons have correct colors (yellow, red, cyan)
- ✅ Hover effects work

**Requirements**: 7.1

---

### TC15: Action Buttons - Completed Job
**Objective**: Verify action buttons for completed jobs

**Steps**:
1. Monitor a completed job
2. Verify button appears

**Expected Results**:
- ✅ "Download Results" button visible
- ✅ Button has download icon
- ✅ Button has green color
- ✅ Hover effect works

**Requirements**: 7.8

---

### TC16: WebSocket Connection
**Objective**: Verify WebSocket connectivity

**Steps**:
1. Monitor a job
2. Check browser console for WebSocket messages
3. Disconnect network briefly

**Expected Results**:
- ✅ WebSocket connects on component mount
- ✅ Subscribes to job updates
- ✅ Receives JOB_PROGRESS events
- ✅ Handles disconnection gracefully
- ✅ Reconnects automatically
- ✅ Resubscribes after reconnection

**Requirements**: 7.5

---

### TC17: Metrics Update Frequency
**Objective**: Verify metrics update at correct interval

**Steps**:
1. Monitor a running job
2. Time the metrics updates
3. Verify frequency

**Expected Results**:
- ✅ Metrics update every 2 seconds (±0.5s)
- ✅ Updates are smooth and not jarring
- ✅ No duplicate updates
- ✅ No missed updates

**Requirements**: 7.5, Property 24

---

### TC18: Chart Hover Tooltips
**Objective**: Verify chart tooltips display correctly

**Steps**:
1. Monitor a job with metrics
2. Hover over utilization chart

**Expected Results**:
- ✅ Tooltip appears on hover
- ✅ Shows exact utilization value
- ✅ Shows "Utilization" label
- ✅ Tooltip styled correctly (dark background)
- ✅ Tooltip follows cursor

**Requirements**: 8.6

---

### TC19: Responsive Layout
**Objective**: Verify layout works on different screen sizes

**Steps**:
1. Monitor a job
2. Resize browser window
3. Test on mobile device

**Expected Results**:
- ✅ 3-column layout on desktop (lg breakpoint)
- ✅ Stacked layout on mobile
- ✅ All content remains accessible
- ✅ Charts resize appropriately
- ✅ No horizontal scrolling
- ✅ Touch interactions work on mobile

**Requirements**: 7.1

---

### TC20: Error Handling
**Objective**: Verify error states are handled

**Steps**:
1. Enter invalid job ID
2. Monitor job with backend error
3. Disconnect WebSocket

**Expected Results**:
- ✅ Error toast appears for fetch failures
- ✅ Component doesn't crash
- ✅ Graceful degradation without WebSocket
- ✅ Error messages are helpful
- ✅ Retry mechanisms work

**Requirements**: Error Handling

---

### TC21: Performance with Many Logs
**Objective**: Verify performance with large log volume

**Steps**:
1. Monitor a job that produces many logs
2. Observe performance

**Expected Results**:
- ✅ No lag or stuttering
- ✅ Smooth scrolling
- ✅ Memory usage stays reasonable
- ✅ No memory leaks
- ✅ Component remains responsive

**Requirements**: Performance

---

### TC22: Multiple Metrics Data Points
**Objective**: Verify chart handles data correctly

**Steps**:
1. Monitor a job for 60+ seconds
2. Observe chart behavior

**Expected Results**:
- ✅ Chart keeps only last 30 data points
- ✅ Old data points removed automatically
- ✅ Chart doesn't grow indefinitely
- ✅ Smooth transitions as data updates
- ✅ No performance degradation

**Requirements**: 8.1

---

## Browser Compatibility Testing

Test the component in:
- [ ] Chrome 90+
- [ ] Firefox 88+
- [ ] Safari 14+
- [ ] Edge 90+

## Accessibility Testing

- [ ] Keyboard navigation works
- [ ] Screen reader announces updates
- [ ] Color contrast meets WCAG standards
- [ ] Focus indicators visible
- [ ] Interactive elements have labels

## Performance Benchmarks

- [ ] Initial load < 1s
- [ ] Metrics update < 100ms
- [ ] Log rendering < 50ms per entry
- [ ] Memory usage < 100MB
- [ ] No memory leaks after 10 minutes

## Notes

- Test with real backend and WebSocket server
- Use browser DevTools to monitor network and performance
- Check console for errors or warnings
- Verify all requirements are met
- Document any issues found
