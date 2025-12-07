# JobWizard Quick Start Guide

## What is JobWizard?

JobWizard is a 4-step guided wizard that makes job submission on QUBIX incredibly easy. It walks users through:
1. **Upload & Analysis** - Drag-and-drop file upload with automatic analysis
2. **GPU Selection** - Smart matching with cost/performance recommendations
3. **Advanced Config** - Optional environment variables and Docker settings
4. **Payment & Launch** - Review, pay with escrow, and launch

## Quick Test (5 minutes)

### Prerequisites
```bash
# Terminal 1 - Backend
cd backend
npm install
npm run dev

# Terminal 2 - Frontend
cd frontend
npm install
npm run dev
```

### Test Steps

1. **Open the Demo**
   - Navigate to: `http://localhost:5173/job-wizard-demo`

2. **Step 1: Upload a File**
   - Drag and drop `test-files/sample-mnist.py` into the upload zone
   - Wait for analysis to complete
   - Verify it detects "MNIST Training" with PyTorch
   - Click "Continue to GPU Selection"

3. **Step 2: Select a GPU**
   - Browse the available GPUs
   - Notice the compatibility badges (green = recommended)
   - Click on a GPU card to select it
   - Observe the estimated time and cost
   - Click "Continue to Configuration"

4. **Step 3: Advanced Config (Optional)**
   - Try adding an environment variable: `EPOCHS=10`
   - Or click "Skip this step" to proceed quickly
   - Click "Continue to Payment"

5. **Step 4: Review & Launch**
   - Review the job summary
   - Check the cost breakdown
   - Click "Launch Job"
   - Watch the launch status updates:
     - Creating escrow transaction...
     - Waiting for confirmations...
     - Provisioning job...
     - Job launched successfully!

## Key Features to Test

### ✅ Progress Indicator
- Watch the step indicator at the top
- Current step glows in cyan
- Completed steps show green checkmarks
- Connector lines show progress

### ✅ Data Persistence
- Go to Step 3, add some config
- Click "Back" to Step 2
- Click "Next" to return to Step 3
- Your config should still be there!

### ✅ Validation
- Try clicking "Continue" without uploading a file
- Try clicking "Continue" without selecting a GPU
- You should see error messages

### ✅ Skip Functionality
- In Step 3, click "Skip this step"
- You should jump directly to Step 4

### ✅ Cost Breakdown
- In Step 4, check the cost breakdown
- Should show:
  - GPU hourly rate
  - Estimated duration
  - Per-minute rate
  - Total estimated cost

## What to Look For

### Good Signs ✅
- Smooth transitions between steps
- Clear visual feedback
- Loading spinners during operations
- Error messages are helpful
- All data is preserved when going back
- Cost calculations are displayed
- Launch status updates in real-time

### Issues to Report ❌
- Steps don't advance
- Data is lost when going back
- No error messages
- Buttons don't work
- Layout is broken on mobile
- TypeScript errors in console

## Testing Different Scenarios

### Scenario 1: Quick Submission
1. Upload file
2. Select first recommended GPU
3. Skip advanced config
4. Launch immediately

**Time:** ~30 seconds

### Scenario 2: Full Configuration
1. Upload file
2. Compare multiple GPUs
3. Add environment variables
4. Set Docker image
5. Change output destination
6. Review and launch

**Time:** ~2 minutes

### Scenario 3: Navigation Test
1. Complete Step 1
2. Complete Step 2
3. Add config in Step 3
4. Go back to Step 2
5. Change GPU selection
6. Go forward to Step 3
7. Verify config is still there
8. Proceed to Step 4

**Time:** ~1 minute

## Common Issues & Solutions

### Issue: "Failed to fetch providers"
**Solution:** Make sure backend is running on port 3005

### Issue: "Analysis failed"
**Solution:** Check that the backend job analysis endpoint is working

### Issue: GPU list is empty
**Solution:** Backend needs at least one provider registered

### Issue: Launch button doesn't work
**Solution:** Check browser console for errors

## Manual Test Checklist

Use this checklist for thorough testing:

- [ ] Progress indicator displays correctly
- [ ] Step 1: File upload works
- [ ] Step 1: Analysis results display
- [ ] Step 2: GPU list loads
- [ ] Step 2: GPU selection works
- [ ] Step 2: Compatibility badges show
- [ ] Step 3: Can add environment variables
- [ ] Step 3: Can remove environment variables
- [ ] Step 3: Docker config works
- [ ] Step 3: Skip button works
- [ ] Step 4: Job summary is correct
- [ ] Step 4: Cost breakdown displays
- [ ] Step 4: Launch button works
- [ ] Back button preserves data
- [ ] Validation prevents invalid progression
- [ ] Error messages are clear
- [ ] Loading states are visible
- [ ] Responsive on mobile
- [ ] No console errors

## Next Steps

After testing the JobWizard:

1. **Report Issues**: Document any bugs or UX issues
2. **Suggest Improvements**: What could make it better?
3. **Integration**: Ready to integrate into main app flow
4. **Real Blockchain**: Next task will add real Qubic wallet integration

## Demo Video Script

If recording a demo:

1. **Intro (10s)**: "This is the JobWizard - a 4-step guided experience for job submission"
2. **Step 1 (20s)**: "Drag and drop your file, and it automatically analyzes GPU requirements"
3. **Step 2 (20s)**: "Smart matching recommends the best GPUs based on cost and performance"
4. **Step 3 (15s)**: "Optionally configure advanced settings, or skip for quick submission"
5. **Step 4 (20s)**: "Review the cost breakdown and launch with escrow payment"
6. **Launch (15s)**: "Watch real-time status updates as the job launches"
7. **Outro (10s)**: "Simple, guided, and production-ready"

**Total:** ~2 minutes

## Questions?

- Check `frontend/src/components/JobWizard.README.md` for detailed documentation
- Review `frontend/src/components/__manual_tests__/JobWizard.test.md` for full test plan
- See `TASK_5_JOBWIZARD_SUMMARY.md` for implementation details

## Success Criteria

The JobWizard is working correctly if:
- ✅ All 4 steps are accessible
- ✅ Data persists when navigating back
- ✅ Validation prevents invalid submissions
- ✅ Cost breakdown is accurate
- ✅ Launch flow completes successfully
- ✅ No TypeScript or runtime errors
- ✅ UI is responsive and polished

Happy testing! 🚀
