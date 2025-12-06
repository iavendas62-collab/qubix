# QuickProvider Component

## Overview

The `QuickProvider` component implements one-click GPU provider registration for the QUBIX platform. It automatically detects GPU hardware using browser APIs (WebGPU/WebGL) and registers the provider with the backend, or falls back to native worker installation if browser detection is unavailable.

## Features

- ✅ **Automatic GPU Detection**: Uses WebGPU API with WebGL fallback
- ✅ **CPU & RAM Detection**: Detects available hardware resources
- ✅ **One-Click Registration**: Minimal user interaction required
- ✅ **Error Handling**: Comprehensive error handling with retry logic
- ✅ **Progress Tracking**: Visual progress bar and status updates
- ✅ **Native Worker Fallback**: Downloads installer if browser detection fails
- ✅ **OS Detection**: Automatically detects Windows, macOS, or Linux
- ✅ **Real-time Feedback**: Toast notifications and status messages
- ✅ **Responsive Design**: Works on desktop, tablet, and mobile

## Installation

The component is located at `frontend/src/components/QuickProvider.tsx` and can be imported directly:

```typescript
import { QuickProvider } from '../components/QuickProvider';
```

## Usage

### Basic Usage

```typescript
import { QuickProvider } from '../components/QuickProvider';

function MyPage() {
  return (
    <div>
      <QuickProvider />
    </div>
  );
}
```

### With Callbacks

```typescript
import { QuickProvider } from '../components/QuickProvider';

function MyPage() {
  const handleSuccess = (provider) => {
    console.log('Provider registered:', provider);
    // Navigate to dashboard or show success message
  };

  const handleError = (error) => {
    console.error('Registration failed:', error);
    // Show custom error handling
  };

  return (
    <QuickProvider 
      onSuccess={handleSuccess}
      onError={handleError}
    />
  );
}
```

## Props

### QuickProviderProps

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `onSuccess` | `(provider: any) => void` | No | Callback fired when registration succeeds |
| `onError` | `(error: Error) => void` | No | Callback fired when registration fails |

## Component State

### ProviderStatus

The component cycles through the following states:

- `idle`: Initial state, ready to start
- `detecting`: Detecting GPU hardware
- `downloading`: Downloading native worker installer
- `installing`: Installing native worker
- `registering`: Registering with backend
- `online`: Successfully registered and online
- `error`: An error occurred

### QuickProviderState

```typescript
interface QuickProviderState {
  status: ProviderStatus;
  progress: number;        // 0-100
  gpuInfo: GPUInfo | null;
  cpuInfo: CPUInfo | null;
  ramInfo: RAMInfo | null;
  error: string | null;
  workerId: string | null;
}
```

## Data Types

### GPUInfo

```typescript
interface GPUInfo {
  vendor?: string;         // GPU vendor (NVIDIA, AMD, Intel)
  model?: string;          // GPU model name
  renderer?: string;       // WebGL renderer string
  architecture?: string;   // GPU architecture
  device?: string;         // Device identifier
  description?: string;    // Full description
  vram?: number;          // VRAM in GB (not available in browser)
  type: 'webgpu' | 'webgl' | 'native';
}
```

### CPUInfo

```typescript
interface CPUInfo {
  model?: string;  // CPU model name
  cores?: number;  // Number of CPU cores
}
```

### RAMInfo

```typescript
interface RAMInfo {
  total?: number;  // Total RAM in GB
}
```

## Detection Methods

### 1. WebGPU Detection (Primary)

The component first attempts to use the WebGPU API:

```typescript
const adapter = await navigator.gpu.requestAdapter();
const info = await adapter.requestAdapterInfo();
```

**Supported Browsers:**
- Chrome 113+
- Edge 113+
- Opera 99+

### 2. WebGL Detection (Fallback)

If WebGPU is unavailable, falls back to WebGL:

```typescript
const gl = canvas.getContext('webgl');
const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
const renderer = gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);
```

**Supported Browsers:**
- All modern browsers
- Firefox, Safari, older Chrome/Edge versions

### 3. Native Worker (Last Resort)

If browser detection fails completely, downloads a native worker installer:

- **Windows**: `install-windows.bat`
- **macOS**: `install.sh`
- **Linux**: `install-linux.sh`

## Registration Flow

```
1. User clicks "Share My GPU"
   ↓
2. Detect CPU & RAM (progress: 10%)
   ↓
3. Attempt WebGPU detection (progress: 20%)
   ↓
4. If WebGPU fails, try WebGL (progress: 40%)
   ↓
5. If browser detection succeeds:
   - Register with backend (progress: 70%)
   - Complete (progress: 100%)
   ↓
6. If browser detection fails:
   - Download native worker (progress: 30%)
   - Install worker (progress: 60%)
   - Poll for registration (progress: varies)
```

## Backend Integration

### API Endpoint

The component calls the following endpoint:

```
POST /api/providers/quick-register
```

### Request Body

```json
{
  "type": "browser" | "native",
  "workerId": "worker-1234567890-abc123",
  "qubicAddress": "AAAA...AAAA",
  "gpu": {
    "vendor": "NVIDIA",
    "model": "GeForce RTX 4090",
    "type": "webgpu"
  },
  "cpu": {
    "model": "8-core CPU",
    "cores": 8
  },
  "ram": {
    "total": 16
  },
  "location": "America/New_York"
}
```

### Response

```json
{
  "success": true,
  "provider": {
    "id": "uuid",
    "workerId": "worker-1234567890-abc123",
    "gpuModel": "GeForce RTX 4090",
    "isOnline": true,
    ...
  },
  "isNew": true
}
```

## Error Handling

### Common Errors

1. **No Qubic Address**
   - Error: "No Qubic address found. Please connect your wallet first."
   - Solution: User must set `qubicAddress` in localStorage

2. **Backend Unavailable**
   - Error: "Registration failed: Failed to fetch"
   - Solution: Ensure backend is running on `http://127.0.0.1:3001`

3. **Invalid Qubic Address**
   - Error: "Invalid Qubic address format"
   - Solution: Backend validates address format (60 uppercase letters)

4. **GPU Detection Failed**
   - Behavior: Automatically falls back to native worker download
   - No error shown to user

### Retry Logic

- Maximum 3 retry attempts
- Retry counter displayed in error message
- After 3 failures, retry button is disabled
- User must refresh page to reset retry counter

## Styling

The component uses:
- **TailwindCSS** for styling
- **Lucide React** for icons
- **React Hot Toast** for notifications
- **Custom Card components** from `./ui/Card`
- **Custom Button component** from `./ui/Button`

### Color Scheme

- Primary: Cyan (`cyan-500`, `cyan-400`)
- Success: Green (`green-500`)
- Error: Red (`red-500`, `red-300`)
- Background: Dark slate (`slate-900`, `slate-950`)

## LocalStorage Keys

The component uses the following localStorage keys:

| Key | Type | Description |
|-----|------|-------------|
| `qubicAddress` | string | User's Qubic wallet address (required) |
| `workerId` | string | Generated worker ID (set after registration) |

## Dependencies

```json
{
  "react": "^18.2.0",
  "react-hot-toast": "^2.6.0",
  "lucide-react": "^0.555.0",
  "clsx": "^2.0.0"
}
```

## Browser Compatibility

| Browser | WebGPU | WebGL | Native Worker |
|---------|--------|-------|---------------|
| Chrome 113+ | ✅ | ✅ | ✅ |
| Edge 113+ | ✅ | ✅ | ✅ |
| Firefox | ❌ | ✅ | ✅ |
| Safari | ❌ | ✅ | ✅ |
| Opera 99+ | ✅ | ✅ | ✅ |

## Performance

- **GPU Detection**: < 1 second (WebGPU) or < 500ms (WebGL)
- **Registration**: < 3 seconds (backend API call)
- **Total Flow**: < 10 seconds (detection + registration)

## Accessibility

- ✅ Keyboard navigation support
- ✅ Screen reader compatible
- ✅ WCAG AA color contrast
- ✅ Focus indicators on interactive elements
- ✅ Status announcements for screen readers

## Testing

See `__manual_tests__/QuickProvider.test.md` for comprehensive manual testing guide.

## Example Integration

See `frontend/src/pages/QuickProviderDemo.tsx` for a complete example of integrating the QuickProvider component into a page.

## Requirements Validation

This component satisfies the following requirements from the spec:

- ✅ **Requirement 1.1**: Automatic GPU hardware detection
- ✅ **Requirement 1.2**: Provider registration within 10 seconds
- ✅ **Requirement 1.3**: Immediate marketplace display (via backend WebSocket)
- ✅ **Requirement 1.4**: Clear error messages with recovery options
- ✅ **Requirement 1.5**: Browser-based GPU detection (WebGPU)
- ✅ **Requirement 1.6**: Native worker installation fallback

## Future Enhancements

Potential improvements for future versions:

1. **VRAM Detection**: Add native worker for accurate VRAM detection
2. **GPU Benchmarking**: Run quick benchmark to determine pricing tier
3. **Multi-GPU Support**: Detect and register multiple GPUs
4. **Real-time Monitoring**: Show live GPU metrics during registration
5. **Offline Mode**: Queue registration for when backend is available
6. **Advanced Settings**: Allow users to customize pricing and availability

## Support

For issues or questions:
- Check the manual test guide: `__manual_tests__/QuickProvider.test.md`
- Review the design document: `.kiro/specs/qubix-enterprise-upgrade/design.md`
- Check backend logs for API errors
- Verify Qubic address is set in localStorage

