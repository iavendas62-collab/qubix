# QuickProvider Component - Manual Test Guide

## Overview
This document provides manual testing instructions for the QuickProvider component.

## Test Environment Setup

1. Ensure backend is running on `http://127.0.0.1:3001`
2. Ensure PostgreSQL database is set up and migrations are run
3. Start the frontend development server: `npm run dev` in the frontend directory
4. Navigate to `/share-gpu` route

## Test Cases

### Test 1: Initial Render (Idle State)
**Steps:**
1. Navigate to `/share-gpu`
2. Observe the QuickProvider component

**Expected Results:**
- ✅ Component displays "Ready to share your GPU" message
- ✅ "Share My GPU" button is visible and enabled
- ✅ Benefits section shows three cards: Instant Setup, Earn QUBIC, Secure
- ✅ Status icon shows CPU icon (not spinning)

### Test 2: GPU Detection - WebGPU Success
**Prerequisites:** Browser with WebGPU support (Chrome 113+, Edge 113+)

**Steps:**
1. Click "Share My GPU" button
2. Observe the detection process

**Expected Results:**
- ✅ Status changes to "Detecting GPU hardware..."
- ✅ Progress bar appears and animates
- ✅ Status icon changes to spinning loader
- ✅ GPU information is detected and displayed
- ✅ Hardware info card shows GPU model, vendor, and detection type (WEBGPU)
- ✅ CPU cores are displayed
- ✅ RAM information is shown (if available)

### Test 3: GPU Detection - WebGL Fallback
**Prerequisites:** Browser without WebGPU but with WebGL support

**Steps:**
1. Click "Share My GPU" button
2. Observe the detection process

**Expected Results:**
- ✅ Status changes to "Detecting GPU hardware..."
- ✅ WebGPU detection fails silently
- ✅ WebGL detection succeeds
- ✅ GPU information shows renderer from WebGL
- ✅ Detection type shows "WEBGL"

### Test 4: Browser Registration Success
**Prerequisites:** 
- Valid Qubic address in localStorage (key: 'qubicAddress')
- Backend `/api/providers/quick-register` endpoint is functional

**Steps:**
1. Set a valid Qubic address: `localStorage.setItem('qubicAddress', 'A'.repeat(60))`
2. Click "Share My GPU" button
3. Wait for detection and registration

**Expected Results:**
- ✅ Status progresses through: detecting → registering → online
- ✅ Progress bar reaches 100%
- ✅ Success toast notification appears
- ✅ Status icon changes to green checkmark
- ✅ Message shows "Your GPU is now online and earning!"
- ✅ "View Dashboard" button appears
- ✅ workerId is stored in localStorage

### Test 5: Registration Error - No Qubic Address
**Prerequisites:** No Qubic address in localStorage

**Steps:**
1. Clear localStorage: `localStorage.removeItem('qubicAddress')`
2. Click "Share My GPU" button

**Expected Results:**
- ✅ Error state is triggered
- ✅ Red error box appears with message about missing Qubic address
- ✅ Status icon shows red X
- ✅ "Retry Registration" button appears
- ✅ Error toast notification appears

### Test 6: Registration Error - Backend Failure
**Prerequisites:** Backend is not running or returns error

**Steps:**
1. Stop the backend server
2. Click "Share My GPU" button
3. Wait for detection to complete

**Expected Results:**
- ✅ Detection succeeds
- ✅ Registration fails with network error
- ✅ Error state is displayed
- ✅ Error message explains the failure
- ✅ "Retry Registration" button appears

### Test 7: Retry Mechanism
**Prerequisites:** Previous registration failed

**Steps:**
1. Trigger a registration error (see Test 5 or 6)
2. Fix the issue (add Qubic address or start backend)
3. Click "Retry Registration" button

**Expected Results:**
- ✅ Registration process restarts
- ✅ Retry counter increments (shown in error message)
- ✅ Maximum 3 retry attempts allowed
- ✅ After 3 failed attempts, retry button is disabled

### Test 8: Native Worker Fallback
**Prerequisites:** Browser without WebGPU or WebGL support (or mock the detection to fail)

**Steps:**
1. Mock GPU detection to fail (modify code temporarily)
2. Click "Share My GPU" button

**Expected Results:**
- ✅ Status changes to "Downloading native worker..."
- ✅ OS detection occurs
- ✅ Appropriate installer file is downloaded based on OS
- ✅ Status changes to "Installing worker..."
- ✅ Toast notification with installation instructions appears
- ✅ Component begins polling for worker registration

### Test 9: OS Detection
**Steps:**
1. Open browser console
2. Run: `navigator.userAgent`
3. Verify OS detection logic

**Expected Results:**
- ✅ Windows: userAgent contains 'win' → detects as 'windows'
- ✅ macOS: userAgent contains 'mac' → detects as 'macos'
- ✅ Linux: userAgent contains 'linux' → detects as 'linux'
- ✅ Unknown: falls back to 'unknown'

### Test 10: Progress Bar Animation
**Steps:**
1. Click "Share My GPU" button
2. Observe progress bar

**Expected Results:**
- ✅ Progress bar appears when status is not 'idle' or 'error'
- ✅ Progress animates smoothly (CSS transition)
- ✅ Progress values: detecting (20%), registering (70%), online (100%)
- ✅ Gradient color (cyan to blue)

### Test 11: Callback Props
**Prerequisites:** Custom onSuccess and onError handlers

**Steps:**
1. Modify QuickProviderDemo to log callbacks
2. Trigger successful registration
3. Trigger failed registration

**Expected Results:**
- ✅ onSuccess callback is called with provider data on success
- ✅ onError callback is called with Error object on failure
- ✅ Callbacks receive correct data

### Test 12: WorkerId Generation
**Steps:**
1. Open browser console
2. Click "Share My GPU" multiple times (after clearing state)
3. Check localStorage for workerId

**Expected Results:**
- ✅ Each registration generates unique workerId
- ✅ Format: `worker-{timestamp}-{random}`
- ✅ workerId is stored in localStorage
- ✅ workerId is sent to backend in registration request

### Test 13: Responsive Design
**Steps:**
1. Test on desktop (1920x1080)
2. Test on tablet (768x1024)
3. Test on mobile (375x667)

**Expected Results:**
- ✅ Component is centered and max-width constrained
- ✅ Card layout adapts to screen size
- ✅ Buttons remain accessible
- ✅ Text is readable at all sizes
- ✅ Benefits grid adjusts for mobile (3 columns → stacked)

### Test 14: Accessibility
**Steps:**
1. Navigate using keyboard only (Tab, Enter, Space)
2. Test with screen reader
3. Check color contrast

**Expected Results:**
- ✅ All interactive elements are keyboard accessible
- ✅ Focus indicators are visible
- ✅ Button states are announced by screen readers
- ✅ Status messages are announced
- ✅ Color contrast meets WCAG AA standards

## Integration Tests

### Integration Test 1: Full Registration Flow
**Steps:**
1. Start with clean state (no localStorage data)
2. Set valid Qubic address
3. Click "Share My GPU"
4. Wait for completion
5. Click "View Dashboard"

**Expected Results:**
- ✅ Complete flow works end-to-end
- ✅ Provider is registered in database
- ✅ WebSocket broadcast occurs
- ✅ Navigation to dashboard succeeds

### Integration Test 2: Backend API Integration
**Steps:**
1. Monitor network requests in DevTools
2. Complete registration flow

**Expected Results:**
- ✅ POST request to `/api/providers/quick-register`
- ✅ Request body contains: type, workerId, qubicAddress, gpu, cpu, ram
- ✅ Response contains: success, provider, isNew
- ✅ Proper error handling for 4xx/5xx responses

## Performance Tests

### Performance Test 1: Detection Speed
**Expected Results:**
- ✅ WebGPU detection completes in < 1 second
- ✅ WebGL fallback completes in < 500ms
- ✅ Total detection time < 2 seconds

### Performance Test 2: Registration Speed
**Expected Results:**
- ✅ Registration API call completes in < 3 seconds
- ✅ Total flow (detection + registration) < 10 seconds

## Browser Compatibility

Test on the following browsers:
- ✅ Chrome 113+ (WebGPU support)
- ✅ Edge 113+ (WebGPU support)
- ✅ Firefox (WebGL fallback)
- ✅ Safari (WebGL fallback)

## Notes

- The component requires a valid Qubic address in localStorage
- Backend must be running for registration to succeed
- WebSocket functionality is handled separately by the backend
- Native worker installation requires user interaction (download and run)

## Known Limitations

1. Browser GPU detection is limited compared to native detection
2. VRAM information not available via WebGPU/WebGL APIs
3. Polling for native worker registration has 5-minute timeout
4. Maximum 3 retry attempts for failed registrations

