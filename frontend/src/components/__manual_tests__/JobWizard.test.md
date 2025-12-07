# JobWizard Manual Test Plan

## Test Environment Setup

1. Start the backend server: `cd backend && npm run dev`
2. Start the frontend: `cd frontend && npm run dev`
3. Navigate to: `http://localhost:5173/job-wizard-demo`

## Test Cases

### TC1: Progress Indicator Display (Requirement 4.1)

**Steps:**
1. Load the JobWizard demo page
2. Observe the progress indicator at the top

**Expected Results:**
- ✅ Progress indicator shows 4 steps with icons
- ✅ Step 1 is highlighted as current (cyan color with glow)
- ✅ Steps 2-4 are shown as upcoming (gray)
- ✅ Each step shows label and number (1/4, 2/4, etc)
- ✅ Connector lines between steps are visible

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC2: Step 1 - File Upload & Analysis (Requirement 4.2)

**Steps:**
1. Drag and drop a Python file (e.g., `test-files/sample-mnist.py`)
2. Wait for upload and analysis to complete
3. Verify analysis results are displayed
4. Click "Continue to GPU Selection"

**Expected Results:**
- ✅ Drag-and-drop zone is visible and responsive
- ✅ File uploads with progress bar
- ✅ Analysis results show job type, framework, VRAM, compute, RAM
- ✅ "Continue" button appears after successful analysis
- ✅ Clicking "Continue" advances to Step 2
- ✅ Step 1 icon changes to checkmark (green)

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC3: Step 2 - GPU Selection (Requirement 4.2)

**Steps:**
1. Complete Step 1
2. Observe the GPU list in Step 2
3. Select a GPU by clicking on a card
4. Click "Continue to Configuration"

**Expected Results:**
- ✅ SmartMatcher component displays available GPUs
- ✅ GPUs show compatibility badges (recommended/compatible/borderline/insufficient)
- ✅ Each GPU card shows estimated time and cost
- ✅ Selected GPU is highlighted with cyan border
- ✅ "Continue" button appears after GPU selection
- ✅ Clicking "Continue" advances to Step 3

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC4: Step 3 - Advanced Configuration (Requirement 4.3)

**Steps:**
1. Complete Steps 1-2
2. In Step 3, add environment variables
3. Set Docker image (optional)
4. Set entry point (optional)
5. Change output destination
6. Adjust max duration
7. Click "Continue to Payment"

**Expected Results:**
- ✅ Environment variables section allows adding key-value pairs
- ✅ Can remove added environment variables
- ✅ Docker image input accepts text
- ✅ Entry point input accepts text
- ✅ Output destination dropdown has 3 options (local, ipfs, s3)
- ✅ Max duration accepts numeric input (1-168 hours)
- ✅ "Continue" button advances to Step 4

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC5: Step 3 - Skip Button (Requirement 4.8)

**Steps:**
1. Complete Steps 1-2
2. In Step 3, click "Skip this step" button
3. Verify navigation to Step 4

**Expected Results:**
- ✅ "Skip this step" button is visible in Step 3 header
- ✅ Clicking skip advances directly to Step 4
- ✅ Default advanced config values are preserved
- ✅ Can navigate back to Step 3 if needed

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC6: Step 4 - Job Summary (Requirement 4.4)

**Steps:**
1. Complete Steps 1-3
2. Review the job summary in Step 4
3. Verify all information is correct

**Expected Results:**
- ✅ Job summary shows job type, framework, file name, GPU model
- ✅ All fields display correct information from previous steps
- ✅ Summary is clearly formatted and readable

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC7: Step 4 - Cost Breakdown (Requirement 12.4)

**Steps:**
1. Complete Steps 1-3
2. Review the cost breakdown in Step 4

**Expected Results:**
- ✅ Shows GPU hourly rate
- ✅ Shows estimated duration
- ✅ Shows per-minute rate calculation
- ✅ Shows total estimated cost prominently
- ✅ All costs are in QUBIC currency
- ✅ Escrow information message is displayed

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC8: Step 4 - Payment & Launch (Requirement 4.5)

**Steps:**
1. Complete Steps 1-3
2. Click "Launch Job" button
3. Observe launch status updates
4. Wait for job to launch

**Expected Results:**
- ✅ Wallet section shows connected status
- ✅ "Launch Job" button is prominent and clickable
- ✅ Launch status shows: "Creating escrow transaction..."
- ✅ Launch status shows: "Waiting for confirmations..."
- ✅ Launch status shows: "Provisioning job..."
- ✅ Launch status shows: "Job launched successfully!"
- ✅ Loading spinner is visible during launch
- ✅ Success callback is triggered

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC9: Step Validation (Requirement 4.6)

**Steps:**
1. Start wizard at Step 1
2. Try to click "Continue" without uploading a file
3. Upload a file and proceed to Step 2
4. Try to click "Continue" without selecting a GPU
5. Select a GPU and proceed

**Expected Results:**
- ✅ Cannot proceed from Step 1 without file upload
- ✅ Error toast shows: "Please upload and analyze a file first"
- ✅ Cannot proceed from Step 2 without GPU selection
- ✅ Error toast shows: "Please select a GPU"
- ✅ Can proceed after completing required fields

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC10: Back Navigation & Data Persistence (Requirement 4.7)

**Steps:**
1. Complete Step 1 (upload file)
2. Complete Step 2 (select GPU)
3. Complete Step 3 (add env vars)
4. In Step 4, click "Back" button
5. Verify Step 3 data is preserved
6. Click "Back" again to Step 2
7. Verify selected GPU is still highlighted
8. Click "Back" to Step 1
9. Verify uploaded file is still shown

**Expected Results:**
- ✅ "Back" button is visible on Steps 2-4
- ✅ Clicking "Back" navigates to previous step
- ✅ All entered data is preserved when going back
- ✅ File upload state is preserved
- ✅ GPU selection is preserved
- ✅ Advanced config (env vars, docker, etc) is preserved
- ✅ Can navigate forward again with preserved data

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC11: Cancel Wizard

**Steps:**
1. Start wizard and complete Step 1
2. Click "Cancel" button in Step 4
3. Confirm cancellation in dialog

**Expected Results:**
- ✅ "Cancel" button is visible in Step 4
- ✅ Confirmation dialog appears
- ✅ Cancelling triggers onCancel callback
- ✅ Wizard state is cleared

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC12: Responsive Design

**Steps:**
1. Load wizard on desktop (1920x1080)
2. Load wizard on tablet (768x1024)
3. Load wizard on mobile (375x667)

**Expected Results:**
- ✅ Progress indicator adapts to screen size
- ✅ GPU cards stack properly on smaller screens
- ✅ Forms are usable on mobile
- ✅ Buttons are accessible on all screen sizes
- ✅ No horizontal scrolling required

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC13: Error Handling

**Steps:**
1. Disconnect backend server
2. Try to proceed from Step 1 to Step 2
3. Observe error handling

**Expected Results:**
- ✅ Error toast appears when GPU fetch fails
- ✅ Loading state is cleared
- ✅ User can retry or go back
- ✅ No crashes or blank screens

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

### TC14: Visual Polish

**Steps:**
1. Navigate through all wizard steps
2. Observe animations and transitions
3. Check hover states and interactions

**Expected Results:**
- ✅ Step transitions are smooth
- ✅ Progress indicator updates smoothly
- ✅ Buttons have hover effects
- ✅ Cards have hover effects
- ✅ Loading spinners are visible and smooth
- ✅ Colors follow design system (cyan/blue theme)
- ✅ Icons are appropriate and clear

**Status:** ⬜ Not Tested | ✅ Pass | ❌ Fail

---

## Test Summary

| Test Case | Status | Notes |
|-----------|--------|-------|
| TC1: Progress Indicator | ⬜ | |
| TC2: Step 1 Upload | ⬜ | |
| TC3: Step 2 GPU Selection | ⬜ | |
| TC4: Step 3 Advanced Config | ⬜ | |
| TC5: Step 3 Skip | ⬜ | |
| TC6: Step 4 Summary | ⬜ | |
| TC7: Step 4 Cost Breakdown | ⬜ | |
| TC8: Step 4 Launch | ⬜ | |
| TC9: Step Validation | ⬜ | |
| TC10: Back Navigation | ⬜ | |
| TC11: Cancel Wizard | ⬜ | |
| TC12: Responsive Design | ⬜ | |
| TC13: Error Handling | ⬜ | |
| TC14: Visual Polish | ⬜ | |

**Overall Status:** ⬜ Not Started | 🟡 In Progress | ✅ Complete

## Notes

- The wizard integrates JobUploader and SmartMatcher components
- Backend API endpoints must be available for full functionality
- Escrow integration is currently mocked for demo purposes
- Real Qubic wallet integration will be added in future tasks

## Tester Information

- **Tester Name:** _________________
- **Test Date:** _________________
- **Environment:** _________________
- **Browser:** _________________
- **Screen Resolution:** _________________
