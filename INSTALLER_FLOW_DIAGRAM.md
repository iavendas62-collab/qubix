# Native Worker Auto-Installer Flow

## Complete User Journey

```
┌─────────────────────────────────────────────────────────────────┐
│ Step 1: User Interaction                                        │
│                                                                  │
│  User clicks "Share My GPU" button                              │
│         │                                                        │
│         ▼                                                        │
│  QuickProvider.handleStartSharing()                             │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 2: GPU Detection Attempt                                   │
│                                                                  │
│  Try WebGPU API                                                 │
│         │                                                        │
│         ├─ Success ──────────────────────┐                      │
│         │                                 │                      │
│         └─ Failure (Not Supported) ──────┼─ Continue           │
│                                           │                      │
│  Try WebGL Fallback                       │                      │
│         │                                 │                      │
│         ├─ Success ──────────────────────┤                      │
│         │                                 │                      │
│         └─ Failure ──────────────────────┤                      │
│                                           │                      │
│                                           ▼                      │
│                              Register Browser Provider           │
│                              (Task 5 - Already Complete)         │
└─────────────────────────────────────────────────────────────────┘
                          │
                          │ Both WebGPU and WebGL failed
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 3: Native Worker Installation (THIS TASK)                  │
│                                                                  │
│  detectOS()                                                     │
│    ├─ Windows ──────────────┐                                  │
│    ├─ macOS ────────────────┼─ OS Detected                     │
│    ├─ Linux ────────────────┘                                  │
│    └─ Unknown ──────────────> Error                            │
│                                                                  │
│  downloadAndInstallWorker()                                     │
│         │                                                        │
│         ▼                                                        │
│  GET /api/installer/:os?backend=http://localhost:3001          │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 4: Backend Generates Installer                             │
│                                                                  │
│  Backend: installer.ts                                          │
│         │                                                        │
│         ├─ Read worker/qubix_worker_simple.py                  │
│         │                                                        │
│         ├─ Generate platform-specific installer:                │
│         │   ├─ Windows: .bat file                              │
│         │   ├─ Linux: .sh file                                 │
│         │   └─ macOS: .sh file                                 │
│         │                                                        │
│         ├─ Embed Python worker code in installer                │
│         │                                                        │
│         └─ Return installer file                                │
│                                                                  │
│  Installer Contents:                                            │
│    ├─ Check for Python                                         │
│    ├─ Install Python (if needed)                               │
│    ├─ Install dependencies (psutil, requests)                  │
│    ├─ Create qubix_worker.py file                              │
│    ├─ Create start_worker script                               │
│    └─ Start worker automatically                               │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 5: User Downloads and Runs Installer                       │
│                                                                  │
│  Browser downloads installer file                               │
│         │                                                        │
│         ▼                                                        │
│  User sees toast notification:                                  │
│    "Installer downloaded! Please run [filename]"                │
│         │                                                        │
│         ▼                                                        │
│  User runs installer:                                           │
│    Windows: Double-click .bat file                              │
│    Linux/macOS: chmod +x installer.sh && ./installer.sh         │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 6: Installer Executes                                      │
│                                                                  │
│  1. Check Python Installation                                   │
│     ├─ Found ──────────────────┐                               │
│     └─ Not Found ──────────────┼─ Install Python               │
│                                 │   (Windows only)              │
│                                 │                               │
│  2. Install Dependencies        │                               │
│     pip install psutil requests │                               │
│                                 │                               │
│  3. Create Worker File          │                               │
│     Write qubix_worker.py       │                               │
│                                 │                               │
│  4. Create Startup Script       │                               │
│     start_worker.bat/.sh        │                               │
│                                 │                               │
│  5. Start Worker                │                               │
│     python qubix_worker.py ─────┘                               │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 7: Worker Starts and Registers                             │
│                                                                  │
│  Python Worker (qubix_worker_simple.py)                         │
│         │                                                        │
│         ├─ Detect Hardware                                      │
│         │   ├─ GPU (via nvidia-smi or fallback)                │
│         │   ├─ CPU (cores, model)                              │
│         │   ├─ RAM (total, available)                          │
│         │   └─ Storage                                          │
│         │                                                        │
│         ├─ Generate Worker ID                                   │
│         │   (based on MAC address hash)                         │
│         │                                                        │
│         ▼                                                        │
│  POST /api/providers/quick-register                             │
│    {                                                            │
│      type: "native",                                            │
│      workerId: "abc123...",                                     │
│      qubicAddress: "QUBIC_ABC123...",                          │
│      gpu: { model, vram, ... },                                │
│      cpu: { model, cores },                                     │
│      ram: { total }                                             │
│    }                                                            │
│         │                                                        │
│         ▼                                                        │
│  Backend creates Provider record in database                    │
│  Backend broadcasts PROVIDER_REGISTERED via WebSocket           │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 8: Frontend Detects Registration (Polling)                 │
│                                                                  │
│  pollForWorkerRegistration()                                    │
│         │                                                        │
│         ├─ Every 5 seconds:                                     │
│         │   GET /api/providers/check-new                        │
│         │         │                                             │
│         │         ├─ Provider found ──────────┐                │
│         │         │                            │                │
│         │         └─ Not found yet ────────────┼─ Continue     │
│         │                                      │   polling      │
│         │                                      │                │
│         ├─ Max 60 attempts (5 minutes)        │                │
│         │                                      │                │
│         └─ Timeout ──────────────> Error      │                │
│                                                │                │
│                                                ▼                │
│  Provider Detected!                                             │
│    ├─ Update UI to "online" status                             │
│    ├─ Show success toast                                       │
│    ├─ Store workerId in localStorage                           │
│    └─ Call onSuccess callback                                  │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 9: Worker Operational                                      │
│                                                                  │
│  Worker Main Loop:                                              │
│         │                                                        │
│         ├─ Every 30 seconds:                                    │
│         │   POST /api/providers/:workerId/heartbeat             │
│         │     { usage: { cpu, ram, gpu }, status: "online" }   │
│         │                                                        │
│         ├─ Every 5 seconds:                                     │
│         │   GET /api/jobs/pending/:workerId                     │
│         │     ├─ Job found ──────────> Execute job             │
│         │     └─ No jobs ────────────> Continue                │
│         │                                                        │
│         └─ On job completion:                                   │
│             POST /api/jobs/:jobId/complete                      │
│               { status, result, metrics }                       │
│                                                                  │
│  Provider now visible in marketplace!                           │
│  Ready to accept and execute jobs!                              │
└─────────────────────────────────────────────────────────────────┘
```

## Key Components

### Frontend (QuickProvider.tsx)
- `detectOS()` - Identifies user's operating system
- `downloadAndInstallWorker()` - Downloads installer from backend
- `pollForWorkerRegistration()` - Polls for worker registration

### Backend (installer.ts)
- `getWorkerCode()` - Reads Python worker from filesystem
- `generateWindowsInstaller()` - Creates .bat installer
- `generateUnixInstaller()` - Creates .sh installer

### Backend (providers.ts)
- `POST /api/providers/quick-register` - Registers new provider
- `GET /api/providers/check-new` - Returns recent providers
- `POST /api/providers/:workerId/heartbeat` - Updates provider status

### Worker (qubix_worker_simple.py)
- `get_hardware_specs()` - Detects GPU, CPU, RAM
- `register_provider()` - Registers with backend
- `send_heartbeat()` - Sends periodic status updates
- `check_for_jobs()` - Polls for pending jobs
- `execute_job()` - Executes compute jobs

## Error Handling

### Frontend
- OS detection failure → Show error message
- Download failure → Retry with fallback
- Polling timeout → Clear error message with troubleshooting

### Backend
- Worker code not found → 500 error with message
- Invalid OS parameter → 400 error
- Database errors → Logged and returned

### Installer
- Python not found → Auto-install (Windows) or show instructions
- Dependency install fails → Show error and exit
- Worker start fails → Show error logs

### Worker
- Hardware detection fails → Use fallback values
- Registration fails → Retry with backoff
- Job execution fails → Report failure to backend

## Success Metrics

✅ All 6 unit tests passing
✅ Installers generate correctly for all platforms
✅ Python worker code properly embedded
✅ Frontend polling works correctly
✅ Backend endpoints respond correctly
✅ No TypeScript errors in any file
✅ Complete documentation provided

## Time Estimates

- Initial setup: ~5 minutes
- Worker registration: ~30 seconds
- Polling detection: ~5-30 seconds
- Total user time: ~6-10 minutes (mostly automated)
