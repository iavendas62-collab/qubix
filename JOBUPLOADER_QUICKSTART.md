# JobUploader Component - Quick Start Guide

## 🚀 Quick Access

### Option 1: Demo Page (Recommended)
1. Start the backend: `cd backend && npm run dev`
2. Start the frontend: `cd frontend && npm run dev`
3. Open browser: **http://localhost:5173/job-uploader-demo**

### Option 2: Integration in Existing Pages
The component can be imported and used in any page:

```tsx
import { JobUploader } from '../components/JobUploader';

<JobUploader
  onFileAnalyzed={(analysis, file) => {
    console.log('Analysis:', analysis);
    // Handle next step
  }}
/>
```

## 📁 Test Files

Sample files are available in `test-files/`:

### MNIST Training Script
**File:** `test-files/sample-mnist.py`

**Expected Analysis:**
- Job Type: `mnist_training`
- Framework: `pytorch`
- VRAM: 4 GB
- Compute: 5 TFLOPS
- RAM: 8 GB
- Confidence: `high`

### Stable Diffusion Script
**File:** `test-files/sample-stable-diffusion.py`

**Expected Analysis:**
- Job Type: `stable_diffusion`
- Framework: `pytorch`
- VRAM: 12 GB
- Compute: 15 TFLOPS
- RAM: 16 GB
- Confidence: `high`

## 🎯 Quick Test Checklist

### Basic Functionality
- [ ] Drag file into drop zone
- [ ] See cyan border on drag
- [ ] Upload progress bar appears
- [ ] Analysis results display
- [ ] File preview shows name, size, type

### Error Handling
- [ ] Try uploading a PDF (should reject)
- [ ] Try uploading a very large file (should reject)
- [ ] Disconnect backend and try upload (should show error)

### Visual States
- [ ] Idle state (gray border)
- [ ] Dragging state (cyan border with glow)
- [ ] Validating state (spinner + progress)
- [ ] Valid state (green border + checkmark)
- [ ] Invalid state (red border + error)

## 🔧 Troubleshooting

### Backend Not Running
**Error:** Network error during upload

**Solution:**
```bash
cd backend
npm run dev
```
Backend should be running on http://127.0.0.1:3005

### Frontend Not Running
**Solution:**
```bash
cd frontend
npm run dev
```
Frontend should be running on http://localhost:5173

### File Not Analyzing
**Check:**
1. Backend console for errors
2. Browser console for network errors
3. File type is supported (.py, .ipynb, .csv, .json, Dockerfile)
4. File size is under 500MB

### Analysis Results Not Showing
**Check:**
1. Backend `/api/jobs/analyze` endpoint is working
2. File contains recognizable patterns (imports, keywords)
3. Browser console for JavaScript errors

## 📊 Component Props

```typescript
interface JobUploaderProps {
  onFileAnalyzed: (analysis: JobAnalysis, file: File) => void;
  onError?: (error: Error) => void;
  maxFileSize?: number; // Default: 500MB
  acceptedTypes?: string[]; // Default: ['.py', '.ipynb', '.csv', '.json', 'dockerfile']
}
```

## 🎨 Customization Examples

### Custom File Size Limit
```tsx
<JobUploader
  onFileAnalyzed={handleAnalysis}
  maxFileSize={1024 * 1024 * 1024} // 1GB
/>
```

### Custom Accepted Types
```tsx
<JobUploader
  onFileAnalyzed={handleAnalysis}
  acceptedTypes={['.py', '.ipynb']} // Only Python files
/>
```

### With Error Handling
```tsx
<JobUploader
  onFileAnalyzed={(analysis, file) => {
    console.log('Success:', analysis);
    // Navigate to next step
  }}
  onError={(error) => {
    console.error('Error:', error);
    // Show custom error UI
  }}
/>
```

## 📖 Full Documentation

For complete documentation, see:
- `frontend/src/components/JobUploader.README.md` - Component documentation
- `frontend/src/components/__manual_tests__/JobUploader.test.md` - Testing guide
- `TASK_2_IMPLEMENTATION_SUMMARY.md` - Implementation details

## 🎯 Next Steps

After testing the JobUploader:
1. Integrate into JobWizard (Task 5)
2. Connect to SmartMatcher (Task 4)
3. Implement property-based tests (Tasks 2.1, 2.2, 2.3)

## 💡 Tips

1. **Use Chrome DevTools** to inspect network requests
2. **Check Backend Logs** for analysis details
3. **Test Different File Types** to see detection accuracy
4. **Try Edge Cases** like empty files, very large files
5. **Test on Mobile** for responsive design

## 🐛 Known Limitations

- Single file upload only (by design)
- Maximum file size: 500MB (configurable)
- Analysis depends on backend availability
- Some file types may have lower confidence detection

## ✨ Features to Explore

1. **Drag-and-Drop**: Smooth animations and visual feedback
2. **Progress Tracking**: Real-time upload percentage
3. **Smart Analysis**: Automatic job type and framework detection
4. **GPU Requirements**: Estimated VRAM, compute, RAM
5. **Error Handling**: Clear messages for all failure cases
6. **File Preview**: Name, size, type display
7. **Confidence Scoring**: High, medium, low confidence levels

---

**Ready to test?** Navigate to http://localhost:5173/job-uploader-demo and start uploading! 🚀
