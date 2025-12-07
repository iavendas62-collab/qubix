# ProviderEarnings Component - Quick Start Guide

## 🚀 Quick Start

### 1. Access the Demo

Navigate to the demo page:
```
http://localhost:5173/provider-earnings-demo
```

### 2. Enter Your Qubic Address

You can either:
- Enter your own 60-character Qubic address
- Click "Use Sample Address" for a demo

### 3. View Your Dashboard

The dashboard displays:
- 💰 **Earnings Summary**: Total, today, week, month, pending
- 📊 **Performance Metrics**: Uptime, jobs completed, rating, avg rate
- 📈 **Earnings Chart**: Last 30 days visualization
- ⚡ **Active Jobs**: Live earnings counter (updates every 5s)
- 📜 **Transaction History**: With blockchain explorer links

## 🎯 Key Features

### Live Earnings Counter
Watch your earnings grow in real-time! The active jobs table updates every 5 seconds showing:
- Current duration
- Earnings so far (calculated live)
- Estimated total

### Auto-Refresh
Data automatically refreshes every 30 seconds to keep you updated.

### Blockchain Verification
Click the 🔗 icon next to any transaction to view it on the Qubic blockchain explorer.

### Manual Refresh
Click the "Refresh" button anytime to get the latest data immediately.

## 📱 Using in Your App

### Basic Usage

```tsx
import ProviderEarnings from './components/ProviderEarnings';

function MyProviderPage() {
  return (
    <ProviderEarnings 
      qubicAddress="YOUR_QUBIC_ADDRESS_HERE"
    />
  );
}
```

### With Provider ID (for WebSocket)

```tsx
<ProviderEarnings 
  providerId="provider-uuid"
  qubicAddress="QUBIC_ADDRESS"
/>
```

## 🔧 Backend Requirements

Ensure these endpoints are available:

1. **GET `/api/providers/my/earnings`**
   - Returns earnings summary and history

2. **GET `/api/providers/my/jobs`**
   - Returns active and completed jobs

3. **GET `/api/transactions/history/:userId`**
   - Returns transaction history

4. **WebSocket Server**
   - For live earnings updates

## 📊 What You'll See

### Earnings Summary Cards
- **Total Earned**: All-time earnings (green highlight)
- **Today**: Current day earnings (updates live)
- **This Week**: Last 7 days
- **This Month**: Current month
- **Pending**: Funds in escrow (yellow highlight)

### Performance Metrics
- **Uptime**: Your availability percentage
- **Jobs Completed**: Total successful jobs
- **Average Rating**: Your provider rating
- **Avg Hourly Rate**: Earnings per hour

### Active Jobs Table
Shows currently running jobs with:
- Job ID and client address
- GPU being used
- **Live duration counter** (updates every 5s)
- **Live earnings counter** (updates every 5s)
- Estimated total earnings
- Status badge

### Transaction History
Complete history of all transactions:
- Date and time
- Transaction type (color-coded)
- Amount (with +/- indicator)
- Status (pending/completed/failed)
- **Blockchain explorer link** 🔗

## ⚡ Live Updates

### Every 5 Seconds
- Active jobs duration updates
- Active jobs earnings recalculated

### Every 30 Seconds
- Full data refresh (silent)
- Earnings summary updates
- Transaction history updates

### Real-time (WebSocket)
- Today's earnings updates instantly
- Active jobs table updates
- New transactions appear immediately

## 🎨 Visual Indicators

### Colors
- 🟢 **Green**: Earnings, success, completed
- 🟡 **Yellow**: Pending, warnings
- 🔵 **Blue**: Information, links
- 🔴 **Red**: Failed, errors

### Icons
- 💰 **Dollar Sign**: Total earnings
- 📅 **Calendar**: Today's earnings
- 📈 **Trending Up**: Weekly earnings
- ⚡ **Activity**: Monthly earnings
- ⏰ **Clock**: Pending payouts
- 🏆 **Award**: Rating
- 🔗 **External Link**: Blockchain explorer

## 🧪 Testing

### Quick Test Checklist

1. **Load the demo page**
   - ✅ All cards display
   - ✅ Chart renders
   - ✅ Tables show data or empty state

2. **Watch live updates**
   - ✅ Active jobs duration increments every 5s
   - ✅ Earnings counter updates every 5s
   - ✅ "Last updated" timestamp increments

3. **Test refresh**
   - ✅ Click refresh button
   - ✅ Spinner appears
   - ✅ Data updates
   - ✅ Timestamp resets

4. **Check blockchain links**
   - ✅ Click external link icon
   - ✅ Opens Qubic explorer in new tab
   - ✅ URL format is correct

## 🐛 Troubleshooting

### No Data Showing
- Check if backend is running
- Verify Qubic address is valid (60 uppercase characters)
- Check browser console for errors

### Live Updates Not Working
- Verify WebSocket server is running
- Check WebSocket connection in browser console
- Ensure providerId is passed to component

### Earnings Not Calculating
- Check if jobs have `startedAt` timestamp
- Verify `pricePerHour` is set on provider
- Check browser console for calculation errors

### Chart Not Rendering
- Ensure Recharts is installed: `npm install recharts`
- Check if earnings history data is available
- Verify chart container has height

## 📚 Documentation

For detailed documentation, see:
- **Component README**: `frontend/src/components/ProviderEarnings.README.md`
- **Manual Tests**: `frontend/src/components/__manual_tests__/ProviderEarnings.test.md`
- **Implementation Summary**: `TASK_12_PROVIDER_EARNINGS_SUMMARY.md`

## 🎯 Next Steps

1. **Test the demo**: Visit `/provider-earnings-demo`
2. **Integrate in your app**: Add to provider dashboard
3. **Customize styling**: Adjust colors and layout
4. **Add features**: Export, filters, notifications
5. **Deploy**: Test in production environment

## 💡 Tips

- **Use WebSocket**: For the best real-time experience, ensure WebSocket is connected
- **Monitor Performance**: With many active jobs, consider pagination
- **Cache Data**: Backend should cache frequently accessed data
- **Error Handling**: Component handles errors gracefully, but log them for debugging

## 🎉 Success!

You now have a fully functional, real-time provider earnings dashboard! Watch your earnings grow as you provide GPU compute power to the QUBIX network.

---

**Need Help?**
- Check the console for error messages
- Review the component README
- Run the manual test plan
- Verify backend endpoints are accessible
