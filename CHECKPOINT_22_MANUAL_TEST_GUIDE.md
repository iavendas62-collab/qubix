# Checkpoint 22: End-to-End Job Flow Manual Testing Guide

This guide provides step-by-step instructions to manually test the complete job flow from upload to completion.

## Prerequisites

Before starting, ensure:
- [ ] Backend server is running (`npm run dev` in backend/)
- [ ] Frontend server is running (`npm run dev` in frontend/)
- [ ] Database is accessible and seeded with test data
- [ ] At least one provider is registered and online
- [ ] Test files are available (test-files/sample-mnist.py, test-files/sample-stable-diffusion.py)

## Test Flow Overview

```
Upload File → Analyze → Match GPU → Configure → Create Escrow → 
Launch Job → Monitor Progress → Complete → Release Payment → 
Verify Earnings → Check Explorer
```

---

## Step 1: Upload File and Verify Analysis

### Test Case 1.1: Upload MNIST Training Script

**Actions:**
1. Navigate to the Job Submission page
2. Locate the drag-and-drop upload zone
3. Drag `test-files/sample-mnist.py` into the drop zone
4. Observe the upload progress bar

**Expected Results:**
- [ ] Drop zone highlights when file is dragged over it
- [ ] Progress bar shows 0% → 100% smoothly
- [ ] "Upload complete" message appears with checkmark icon
- [ ] "Analyzing..." status shows with spinner
- [ ] Analysis completes within 5 seconds
- [ ] Detected job type: `mnist_training`
- [ ] Detected framework: `pytorch`
- [ ] Estimated VRAM: 4-8 GB
- [ ] Estimated Compute: 10-15 TFLOPS
- [ ] Confidence level: `high`

**Screenshot Location:** `screenshots/step1-upload-analysis.png`

### Test Case 1.2: Upload Stable Diffusion Script

**Actions:**
1. Clear previous upload
2. Drag `test-files/sample-stable-diffusion.py` into the drop zone

**Expected Results:**
- [ ] Detected job type: `stable_diffusion`
- [ ] Detected framework: `pytorch`
- [ ] Estimated VRAM: 8-12 GB
- [ ] Keywords detected: `diffusers`, `StableDiffusionPipeline`

### Test Case 1.3: Invalid File Rejection

**Actions:**
1. Try to upload a .txt file or file > 500MB

**Expected Results:**
- [ ] Error message displays: "Unsupported file format"
- [ ] List of supported formats shown: `.py, .ipynb, .csv, .json, Dockerfile`
- [ ] OR "File too large" with size limit shown

---

## Step 2: Select GPU and Verify Matching

### Test Case 2.1: View Compatible GPUs

**Actions:**
1. After successful analysis, proceed to GPU selection step
2. Observe the list of compatible GPUs

**Expected Results:**
- [ ] GPUs are displayed as cards with visual badges
- [ ] Compatible GPUs have GREEN badge
- [ ] Borderline GPUs have YELLOW badge with warnings
- [ ] Insufficient GPUs have RED badge and are disabled
- [ ] Each card shows:
  - GPU model name
  - VRAM capacity
  - Estimated completion time (e.g., "5 minutes 30 seconds")
  - Total cost estimate (e.g., "0.125 QUBIC")
  - Cost-benefit score
  - Provider location

### Test Case 2.2: GPU Sorting

**Actions:**
1. Click sort dropdown
2. Try each sort option:
   - Cost-benefit (default)
   - Price (low to high)
   - Performance (high to low)
   - Availability

**Expected Results:**
- [ ] GPUs reorder correctly for each sort option
- [ ] Default sort is by cost-benefit score (descending)
- [ ] Top 3 recommendations are highlighted

### Test Case 2.3: GPU Selection

**Actions:**
1. Click on a compatible GPU card
2. Observe selection state

**Expected Results:**
- [ ] Selected GPU card is highlighted with border
- [ ] "Next" button becomes enabled
- [ ] Selection persists if navigating back

**Screenshot Location:** `screenshots/step2-gpu-matching.png`

---

## Step 3: Complete Wizard and Verify Escrow Creation

### Test Case 3.1: Advanced Configuration (Optional)

**Actions:**
1. Click "Next" to proceed to Step 3
2. Add environment variables (optional):
   - Key: `EPOCHS`, Value: `10`
   - Key: `BATCH_SIZE`, Value: `32`
3. Select Docker image (optional): `pytorch/pytorch:latest`
4. Choose output destination: `local`

**Expected Results:**
- [ ] Environment variables can be added/removed
- [ ] Docker image dropdown shows available images
- [ ] Output destination options: `ipfs`, `s3`, `local`
- [ ] "Skip" button is available
- [ ] Can navigate back without losing data

### Test Case 3.2: Payment & Launch

**Actions:**
1. Click "Next" to proceed to Step 4
2. Review the cost breakdown
3. Connect Qubic wallet (if not already connected)
4. Click "Launch Job" button

**Expected Results:**
- [ ] Cost breakdown shows:
  - Estimated duration: "X minutes Y seconds"
  - Per-minute rate: "0.025 QUBIC/min"
  - Total estimated cost: "Z QUBIC"
  - Current wallet balance
- [ ] Wallet connection modal appears if not connected
- [ ] Balance is sufficient (or error shown if not)
- [ ] "Launch Job" button is prominent and enabled

### Test Case 3.3: Escrow Transaction Creation

**Actions:**
1. After clicking "Launch Job", observe the escrow process
2. Wait for transaction confirmations

**Expected Results:**
- [ ] "Creating escrow..." status appears
- [ ] Transaction hash is displayed
- [ ] Qubic explorer link is clickable
- [ ] Confirmation counter shows: "0/3", "1/3", "2/3", "3/3"
- [ ] Each confirmation takes ~15 seconds
- [ ] Estimated confirmation time is displayed
- [ ] After 3 confirmations, status changes to "Job Created"
- [ ] Job ID is displayed
- [ ] Redirect to job monitoring dashboard

**Screenshot Location:** `screenshots/step3-escrow-creation.png`

**Verification:**
1. Click the Qubic explorer link
2. Verify transaction appears on explorer.qubic.org
3. Check transaction details:
   - [ ] Amount matches estimated cost
   - [ ] Memo field contains job ID
   - [ ] Status is "Confirmed"

---

## Step 4: Monitor Job and Verify Real-Time Updates

### Test Case 4.1: Job Monitoring Dashboard Layout

**Actions:**
1. Observe the 3-column layout of the monitoring dashboard

**Expected Results:**
- [ ] **Left Column** displays:
  - Job ID
  - Status badge (PENDING → ASSIGNED → RUNNING → COMPLETED)
  - GPU assigned (model name)
  - Start time
  - Elapsed time (updates every second)
  - Current cost (updates live)
  - Estimated total cost
- [ ] **Center Column** displays:
  - GPU Utilization line chart (last 60 seconds)
  - GPU Memory bar chart (used/total)
  - Temperature gauge with color coding:
    - Green: < 70°C
    - Yellow: 70-80°C
    - Red: > 80°C
  - Power usage display with trend
- [ ] **Right Column** displays:
  - Log stream with timestamps
  - Log level indicators (info/warning/error)
  - Auto-scroll enabled
  - Filter buttons (All/Info/Warning/Error)
- [ ] **Bottom Section** displays:
  - Progress bar (0-100%)
  - Time remaining estimate
  - Current operation text
  - Action buttons (Pause/Stop/Extend)

**Screenshot Location:** `screenshots/step4-monitoring-dashboard.png`

### Test Case 4.2: Real-Time Metrics Updates

**Actions:**
1. Watch the dashboard for 30 seconds
2. Observe metric updates

**Expected Results:**
- [ ] GPU utilization chart updates every 2 seconds
- [ ] New data points animate smoothly onto the chart
- [ ] Memory bar updates in real-time
- [ ] Temperature gauge updates with smooth transitions
- [ ] Power usage updates with trend indicator (↑/↓)
- [ ] No flickering or jarring updates

### Test Case 4.3: Live Log Streaming

**Actions:**
1. Observe the log stream in the right column
2. Scroll up in the log area
3. Let new logs arrive

**Expected Results:**
- [ ] New log lines appear at the bottom
- [ ] Timestamps are accurate
- [ ] Log levels are color-coded:
  - Info: Blue
  - Warning: Yellow
  - Error: Red
- [ ] Auto-scroll resumes when scrolled to bottom
- [ ] Auto-scroll pauses when scrolled up
- [ ] Filter buttons work correctly

### Test Case 4.4: Progress Updates

**Actions:**
1. Watch the progress bar and current operation text
2. Observe updates every 10 seconds

**Expected Results:**
- [ ] Progress bar increases from 0% to 100%
- [ ] Current operation text updates:
  - "Initializing..."
  - "Loading model..."
  - "Training epoch 1/5"
  - "Training epoch 2/5"
  - etc.
- [ ] Time remaining decreases
- [ ] Time remaining is formatted: "5 minutes 30 seconds"

### Test Case 4.5: Threshold Warnings

**Actions:**
1. Wait for GPU metrics to exceed thresholds (if they do)

**Expected Results:**
- [ ] GPU utilization > 85%: Yellow highlight
- [ ] GPU utilization > 95%: Red highlight
- [ ] Temperature > 70°C: Yellow highlight
- [ ] Temperature > 80°C: Red highlight
- [ ] Warning icon appears next to metric

### Test Case 4.6: Chart Hover Tooltips

**Actions:**
1. Hover over data points on the GPU utilization chart
2. Hover over the memory bar
3. Hover over the temperature gauge

**Expected Results:**
- [ ] Tooltip appears showing:
  - Exact value
  - Timestamp
  - Unit (%, GB, °C, W)
- [ ] Tooltip follows cursor
- [ ] Tooltip disappears when cursor leaves

**Screenshot Location:** `screenshots/step4-metrics-charts.png`

---

## Step 5: Verify Job Completion and Payment Release

### Test Case 5.1: Job Completion

**Actions:**
1. Wait for job to complete (or simulate completion)
2. Observe the completion status

**Expected Results:**
- [ ] Status changes to "COMPLETED" (green badge)
- [ ] Progress bar reaches 100%
- [ ] Current operation: "Job completed successfully"
- [ ] Completion time is displayed
- [ ] Final cost is calculated and displayed
- [ ] "Download Results" button appears
- [ ] Success notification toast appears

### Test Case 5.2: Payment Release

**Actions:**
1. Observe the payment release process
2. Check for release transaction

**Expected Results:**
- [ ] "Releasing payment..." status appears
- [ ] Release transaction hash is displayed
- [ ] Qubic explorer link for release transaction
- [ ] Confirmation counter: "0/3" → "3/3"
- [ ] "Payment released" notification appears
- [ ] Final transaction details shown:
  - Amount released
  - Provider address
  - Transaction fee

**Screenshot Location:** `screenshots/step5-completion-payment.png`

**Verification:**
1. Click the release transaction explorer link
2. Verify on explorer.qubic.org:
   - [ ] Transaction is confirmed
   - [ ] Amount matches job cost
   - [ ] Recipient is provider's address

### Test Case 5.3: Job Failure Scenario

**Actions:**
1. If a job fails, observe the refund process

**Expected Results:**
- [ ] Status changes to "FAILED" (red badge)
- [ ] Error message is displayed
- [ ] "Refunding..." status appears
- [ ] Refund transaction hash is displayed
- [ ] Funds return to consumer's wallet
- [ ] Refund transaction appears in explorer

---

## Step 6: Check Provider Earnings Update

### Test Case 6.1: Provider Earnings Dashboard

**Actions:**
1. Navigate to Provider Dashboard (or switch to provider view)
2. Observe the earnings summary

**Expected Results:**
- [ ] **Earnings Summary Cards** display:
  - Total Earned (all time)
  - Today's Earnings
  - This Week
  - This Month
  - Pending Payouts
  - Average Hourly Rate
- [ ] **Earnings History Chart** shows:
  - Line graph of last 30 days
  - Daily earnings plotted
  - Hover tooltips with exact amounts
- [ ] **Active Jobs Table** displays:
  - Job ID
  - Client address (truncated)
  - GPU used
  - Duration so far (updates live)
  - Earnings so far (updates live)
  - Estimated total
  - Status

**Screenshot Location:** `screenshots/step6-provider-earnings.png`

### Test Case 6.2: Live Earnings Updates

**Actions:**
1. Watch the "Today's Earnings" card for 10 seconds
2. Observe active jobs table

**Expected Results:**
- [ ] Today's earnings updates every 5 seconds
- [ ] Active jobs "Duration so far" increments every second
- [ ] Active jobs "Earnings so far" updates every 5 seconds
- [ ] Earnings calculation is accurate: (duration in hours) × (hourly rate)
- [ ] No flickering or jarring updates

### Test Case 6.3: Completed Job in Earnings

**Actions:**
1. After job completes, check the earnings dashboard
2. Verify the completed job appears

**Expected Results:**
- [ ] Job moves from "Active Jobs" to completed
- [ ] Total Earned increases by job amount
- [ ] Today's Earnings increases by job amount
- [ ] Jobs Completed count increments
- [ ] Average Hourly Rate recalculates
- [ ] Transaction appears in history

### Test Case 6.4: Performance Metrics

**Actions:**
1. Observe the performance metrics section

**Expected Results:**
- [ ] Uptime percentage is displayed
- [ ] Jobs completed count is accurate
- [ ] Average rating is shown (if applicable)
- [ ] Response time is displayed

---

## Step 7: Verify Transaction in Qubic Explorer

### Test Case 7.1: Transaction History Display

**Actions:**
1. Navigate to Transaction History page
2. Observe the transaction list

**Expected Results:**
- [ ] Transactions are displayed in a table with columns:
  - Date & Time
  - Type (Escrow Lock, Release, Refund, Payment, Earning)
  - Amount (QUBIC)
  - Status (Pending, Confirmed, Failed)
  - Transaction Hash (truncated, with copy button)
  - Explorer Link (clickable icon)
- [ ] Transactions are sorted by date (newest first)
- [ ] Pagination works if > 10 transactions
- [ ] Each transaction row is clickable for details

**Screenshot Location:** `screenshots/step7-transaction-history.png`

### Test Case 7.2: Transaction Details Modal

**Actions:**
1. Click on a transaction row
2. Observe the details modal

**Expected Results:**
- [ ] Modal displays full transaction details:
  - Full transaction hash (with copy button)
  - Type
  - Amount
  - Status with icon
  - Confirmations (X/3)
  - Block height (if confirmed)
  - Timestamp
  - From address
  - To address
  - Job ID (if applicable)
  - Memo/Notes
- [ ] "View in Explorer" button opens explorer.qubic.org
- [ ] Close button works

### Test Case 7.3: Explorer Link Validation

**Actions:**
1. Click "View in Explorer" for escrow transaction
2. Click "View in Explorer" for release transaction
3. Verify both transactions on explorer.qubic.org

**Expected Results:**
- [ ] Escrow transaction on explorer shows:
  - Correct amount
  - Status: Confirmed
  - Memo contains job ID
  - From: Consumer address
  - To: Escrow/Provider address
- [ ] Release transaction on explorer shows:
  - Correct amount (job cost)
  - Status: Confirmed
  - From: Escrow address
  - To: Provider address
- [ ] Explorer URLs are in format: `https://explorer.qubic.org/tx/{hash}`

**Screenshot Location:** `screenshots/step7-explorer-verification.png`

### Test Case 7.4: Transaction Filtering

**Actions:**
1. Use the filter dropdown to filter by type
2. Try each filter option:
   - All
   - Escrow Lock
   - Escrow Release
   - Refund
   - Payment
   - Earning

**Expected Results:**
- [ ] Transactions filter correctly by type
- [ ] Count updates to show filtered results
- [ ] "Clear filters" button appears when filtered

### Test Case 7.5: Transaction Status Updates

**Actions:**
1. Create a new transaction (start a new job)
2. Watch the transaction status in real-time

**Expected Results:**
- [ ] Transaction appears immediately with status "Pending"
- [ ] Confirmation count updates: 0/3 → 1/3 → 2/3 → 3/3
- [ ] Status changes to "Confirmed" after 3 confirmations
- [ ] Estimated confirmation time is shown
- [ ] Auto-refresh works (updates without page reload)

---

## Complete Flow Summary Checklist

After completing all steps above, verify:

- [ ] ✓ Step 1: File upload and analysis - PASSED
- [ ] ✓ Step 2: GPU matching - PASSED
- [ ] ✓ Step 3: Escrow creation and job launch - PASSED
- [ ] ✓ Step 4: Real-time monitoring - PASSED
- [ ] ✓ Step 5: Job completion and payment release - PASSED
- [ ] ✓ Step 6: Provider earnings update - PASSED
- [ ] ✓ Step 7: Transaction verification - PASSED

---

## Additional Verification Tests

### WebSocket Connection

**Actions:**
1. Open browser DevTools → Network tab → WS filter
2. Observe WebSocket connection

**Expected Results:**
- [ ] WebSocket connects to `ws://localhost:8080` (or production URL)
- [ ] Connection status: "Connected" (green indicator)
- [ ] Messages are being sent/received
- [ ] If connection drops, auto-reconnect within 5 seconds

### Error Handling

**Test scenarios:**
1. Disconnect internet during job monitoring
2. Try to launch job with insufficient balance
3. Upload invalid file
4. Try to select incompatible GPU

**Expected Results:**
- [ ] Error messages are clear and helpful
- [ ] No crashes or blank screens
- [ ] Retry options are provided
- [ ] User can recover from errors

### Performance

**Metrics to check:**
- [ ] File upload < 5 seconds for 100MB file
- [ ] Analysis completes < 5 seconds
- [ ] GPU matching < 2 seconds
- [ ] Dashboard loads < 1 second
- [ ] Metrics update every 2 seconds (±0.5s)
- [ ] No memory leaks (check DevTools Memory tab)

### Cross-Browser Compatibility

**Test on:**
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)

**Verify:**
- [ ] All features work identically
- [ ] No visual glitches
- [ ] Animations are smooth
- [ ] WebSocket works

### Mobile Responsiveness

**Test on:**
- [ ] iPhone (Safari)
- [ ] Android (Chrome)
- [ ] Tablet (iPad)

**Verify:**
- [ ] Layout adapts to screen size
- [ ] Touch interactions work
- [ ] Drag-and-drop works (or alternative provided)
- [ ] Charts are readable
- [ ] No horizontal scrolling

---

## Issues Found

Document any issues found during testing:

| Step | Issue Description | Severity | Status |
|------|------------------|----------|--------|
|      |                  |          |        |

---

## Test Completion

**Tester Name:** ___________________________

**Date:** ___________________________

**Overall Result:** [ ] PASS [ ] FAIL [ ] PARTIAL

**Notes:**
_______________________________________________________________
_______________________________________________________________
_______________________________________________________________

**Signature:** ___________________________
