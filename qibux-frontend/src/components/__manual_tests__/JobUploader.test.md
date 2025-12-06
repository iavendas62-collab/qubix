# JobUploader Component - Manual Testing Guide

## Prerequisites

1. Backend server running on `http://127.0.0.1:3005`
2. Frontend dev server running
3. Test files available in `test-files/` directory

## Test Cases

### Test 1: Basic Drag-and-Drop (Requirements 1.1, 1.2)

**Steps:**
1. Navigate to `/job-uploader-demo`
2. Drag `sample-mnist.py` from `test-files/` folder
3. Hover over the drop zone

**Expected Results:**
- ✅ Drop zone border changes to cyan with glow effect
- ✅ Background color changes to cyan/10
- ✅ Smooth transition animations
- ✅ Cursor changes to indicate drop is allowed

**Status:** ⬜ Pass ⬜ Fail

---

### Test 2: File Upload and Progress (Requirements 15.1, 15.2)

**Steps:**
1. Drop `sample-mnist.py` into the upload zone
2. Observe the upload progress

**Expected Results:**
- ✅ Progress bar appears showing 0-100%
- ✅ "Analyzing file..." message displays
- ✅ Spinner icon animates during upload
- ✅ Checkmark appears on completion
- ✅ "Upload complete" message displays

**Status:** ⬜ Pass ⬜ Fail

---

### Test 3: File Preview (Requirement 1.4)

**Steps:**
1. After successful upload, check the file preview section

**Expected Results:**
- ✅ File name displays correctly
- ✅ File size shows in appropriate unit (KB/MB)
- ✅ File type displays
- ✅ File icon appears
- ✅ Checkmark icon shows for valid files

**Status:** ⬜ Pass ⬜ Fail

---

### Test 4: Analysis Results Display (Requirements 15.3, 15.4)

**Steps:**
1. Upload `sample-mnist.py`
2. Wait for analysis to complete
3. Check the analysis results section

**Expected Results:**
- ✅ Job Type: "mnist training"
- ✅ Framework: "pytorch"
- ✅ Required VRAM: 4 GB
- ✅ Required Compute: 5 TFLOPS
- ✅ Required RAM: 8 GB
- ✅ Confidence: "high" (green color)
- ✅ Results displayed in grid layout

**Status:** ⬜ Pass ⬜ Fail

---

### Test 5: Stable Diffusion Detection

**Steps:**
1. Clear previous upload
2. Upload `sample-stable-diffusion.py`
3. Check analysis results

**Expected Results:**
- ✅ Job Type: "stable diffusion"
- ✅ Framework: "pytorch"
- ✅ Required VRAM: 12 GB
- ✅ Required Compute: 15 TFLOPS
- ✅ Confidence: "high"

**Status:** ⬜ Pass ⬜ Fail

---

### Test 6: File Size Validation (Requirement 15.5)

**Steps:**
1. Create a file larger than 500MB (or modify maxFileSize prop to 1MB for testing)
2. Try to upload the large file

**Expected Results:**
- ✅ Upload is rejected
- ✅ Error message displays: "File size exceeds 500MB limit..."
- ✅ Red border appears on drop zone
- ✅ Error icon displays
- ✅ Toast notification shows error

**Status:** ⬜ Pass ⬜ Fail

---

### Test 7: Invalid File Type (Requirements 1.7, 15.6)

**Steps:**
1. Try to upload an unsupported file (e.g., `.pdf`, `.png`, `.mp4`)

**Expected Results:**
- ✅ Upload is rejected
- ✅ Error message displays: "Unsupported file format. Supported formats: .py, .ipynb, .csv, .json, dockerfile"
- ✅ Red border appears
- ✅ Error icon displays
- ✅ Toast notification shows error

**Status:** ⬜ Pass ⬜ Fail

---

### Test 8: Click to Browse Fallback

**Steps:**
1. Click on the drop zone (don't drag)
2. Select a file from the file picker dialog

**Expected Results:**
- ✅ File picker dialog opens
- ✅ Only supported file types are selectable
- ✅ Selected file uploads normally
- ✅ Same validation and analysis occurs

**Status:** ⬜ Pass ⬜ Fail

---

### Test 9: Multiple File Handling (Requirement 1.8)

**Steps:**
1. Try to drag multiple files at once
2. Observe behavior

**Expected Results:**
- ✅ Only the first file is processed
- ✅ Other files are ignored (or rejected with message)
- ✅ No errors occur
- ✅ Component remains stable

**Status:** ⬜ Pass ⬜ Fail

---

### Test 10: Clear Functionality

**Steps:**
1. Upload a file successfully
2. Click the "Clear" button

**Expected Results:**
- ✅ File preview disappears
- ✅ Analysis results disappear
- ✅ Component resets to initial state
- ✅ Drop zone returns to default appearance
- ✅ Ready for new upload

**Status:** ⬜ Pass ⬜ Fail

---

### Test 11: Network Error Handling

**Steps:**
1. Stop the backend server
2. Try to upload a file

**Expected Results:**
- ✅ Error message displays
- ✅ Toast notification shows network error
- ✅ Component doesn't crash
- ✅ User can retry after restarting backend

**Status:** ⬜ Pass ⬜ Fail

---

### Test 12: Validation Speed (Requirement 1.3)

**Steps:**
1. Upload a small file (< 1MB)
2. Measure time from drop to validation result

**Expected Results:**
- ✅ Validation completes within 1 second
- ✅ No noticeable lag
- ✅ Smooth user experience

**Status:** ⬜ Pass ⬜ Fail

---

### Test 13: Visual Feedback Consistency

**Steps:**
1. Test all drag states (enter, over, leave)
2. Test all validation states (idle, validating, valid, invalid)

**Expected Results:**
- ✅ Border colors change appropriately
- ✅ Icons change based on state
- ✅ Animations are smooth
- ✅ No visual glitches
- ✅ Colors match design system

**Status:** ⬜ Pass ⬜ Fail

---

### Test 14: Responsive Design

**Steps:**
1. Test on different screen sizes (mobile, tablet, desktop)
2. Resize browser window

**Expected Results:**
- ✅ Component adapts to screen size
- ✅ Text remains readable
- ✅ Buttons are accessible
- ✅ No horizontal scrolling
- ✅ Touch-friendly on mobile

**Status:** ⬜ Pass ⬜ Fail

---

### Test 15: Accessibility

**Steps:**
1. Navigate using keyboard only (Tab, Enter, Escape)
2. Test with screen reader

**Expected Results:**
- ✅ Drop zone is keyboard accessible
- ✅ File picker opens with Enter/Space
- ✅ Clear button is keyboard accessible
- ✅ Screen reader announces state changes
- ✅ ARIA labels are present

**Status:** ⬜ Pass ⬜ Fail

---

## Test Summary

**Total Tests:** 15
**Passed:** ___
**Failed:** ___
**Skipped:** ___

## Notes

_Add any additional observations or issues here_

---

## Sign-off

**Tester Name:** _______________
**Date:** _______________
**Environment:** _______________
**Browser:** _______________
**OS:** _______________
