# Metrics Visualization Guide - JobMonitor Component

## Overview
The JobMonitor component now features advanced metrics visualization using Recharts, providing real-time GPU monitoring with professional-grade charts and visual indicators.

## Chart Types Implemented

### 1. GPU Utilization Line Chart
**Purpose:** Track GPU usage over time (last 60 seconds)

**Visual Features:**
- Smooth animated line showing utilization percentage
- Dynamic color coding:
  - 🔴 Red: >85% (High usage warning)
  - 🟡 Yellow: 70-85% (Moderate usage)
  - 🔵 Cyan: <70% (Normal operation)
- Grid lines for easy reading
- Hover to see exact percentage and timestamp

**Data Points:** 30 points (2-second intervals)

### 2. GPU Memory Bar Chart
**Purpose:** Show memory allocation (used vs free)

**Visual Features:**
- Horizontal stacked bar chart
- Purple gradient for used memory
- Gray for free memory
- Smooth 500ms animations
- Text display: "X.XX GB / Y.YY GB"
- Hover to see exact values

### 3. Temperature Gauge
**Purpose:** Monitor GPU temperature with visual warnings

**Visual Features:**
- Large temperature display with color coding:
  - 🟢 Green: <70°C (Normal)
  - 🟡 Yellow: 70-80°C (Warm)
  - 🔴 Red: >80°C (Hot)
- Color bar indicator showing temperature ranges
- Animated position marker
- Status text below temperature

**Thresholds:**
- 0-70°C: Normal (Green)
- 70-80°C: Warm (Yellow)
- 80-100°C: Hot (Red)

### 4. Power Usage Trend Chart
**Purpose:** Track power consumption over time

**Visual Features:**
- Yellow line chart showing wattage
- Last 10 data points displayed
- Trend indicator (↑/↓) showing increase/decrease
- Current power display below chart
- Hover to see exact wattage and timestamp

## Threshold Warnings

### GPU Utilization Warnings
- **>85%:** Red text + alert icon + "High usage" message
- **70-85%:** Yellow text
- **<70%:** Cyan text (normal)

### Temperature Warnings
- **>80°C:** Red text + alert icon + "High temp" message
- **70-80°C:** Yellow text
- **<70°C:** Green text (normal)

## Interactive Features

### Hover Tooltips
All charts include interactive tooltips that display:
- Exact metric values with appropriate units
- Timestamps in local time format
- Consistent dark theme styling
- Smooth fade-in animations

### Real-time Updates
- Metrics update every 2 seconds via WebSocket
- Charts animate smoothly on data changes
- No jarring transitions or flickers
- Automatic data point limiting (last 60 seconds)

## Color Scheme

### Chart Colors
- **Utilization Line:** Dynamic (Red/Yellow/Cyan based on value)
- **Memory Used:** Purple (#a855f7)
- **Memory Free:** Gray (#334155)
- **Temperature:** Dynamic (Red/Yellow/Green based on value)
- **Power:** Yellow (#eab308)

### Background Colors
- **Chart Background:** Slate-900 (#0f172a)
- **Card Background:** Slate-800 (#1e293b)
- **Grid Lines:** Slate-700 (#334155)

## Usage Example

```typescript
import JobMonitor from './components/JobMonitor';

function App() {
  return (
    <JobMonitor jobId="job-123" />
  );
}
```

## Data Flow

1. **WebSocket Connection:** Component subscribes to job updates
2. **Metrics Received:** GPU metrics arrive every 2 seconds
3. **State Update:** Metrics added to state array (limited to 30 points)
4. **Chart Rendering:** Recharts automatically re-renders with new data
5. **Animations:** Smooth transitions between data points

## Performance Optimization

### Data Limiting
- Utilization chart: Last 30 points (60 seconds)
- Power chart: Last 10 points (20 seconds)
- Memory chart: Current state only

### Animation Settings
- Line charts: 300ms duration
- Bar charts: 500ms duration
- Temperature gauge: 500ms transitions
- Disabled dots on line charts for better performance

### Responsive Design
- All charts use ResponsiveContainer
- Adapts to screen size automatically
- Mobile-friendly layout

## Accessibility

### Visual Indicators
- Color coding supplemented with text labels
- Alert icons for warnings
- Status text ("Normal", "Warm", "Hot")
- Percentage displays alongside visual bars

### Tooltips
- Large, readable text
- High contrast colors
- Clear labels and units
- Timestamp information

## Browser Compatibility

Tested and working on:
- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

## Troubleshooting

### Charts Not Displaying
- Verify Recharts is installed: `npm list recharts`
- Check browser console for errors
- Ensure metrics data is being received via WebSocket

### Animations Stuttering
- Check if too many data points are being stored
- Verify WebSocket update frequency (should be 2s)
- Clear browser cache and reload

### Colors Not Changing
- Verify threshold values in helper functions
- Check if latestMetrics is defined
- Inspect metric values in browser console

## Future Enhancements

Potential improvements for future versions:
1. Chart export functionality (PNG/SVG)
2. Zoom and pan controls
3. Historical data view (beyond 60 seconds)
4. Customizable thresholds
5. Metric comparison (multiple jobs)
6. Alert notifications
7. Chart presets (performance/efficiency/balanced)

## Related Files

- **Component:** `frontend/src/components/JobMonitor.tsx`
- **Hook:** `frontend/src/hooks/useWebSocket.ts`
- **Types:** Defined inline in component
- **Styles:** Tailwind CSS classes

## Support

For issues or questions:
1. Check the implementation summary: `TASK_11_METRICS_VISUALIZATION_SUMMARY.md`
2. Review the design document: `.kiro/specs/qubix-hackathon-critical-features/design.md`
3. Check requirements: `.kiro/specs/qubix-hackathon-critical-features/requirements.md`

## Conclusion

The metrics visualization system provides a professional, production-ready monitoring experience that rivals commercial platforms while maintaining real-time performance and visual clarity. All charts are fully animated, interactive, and provide clear visual feedback for system health monitoring.
