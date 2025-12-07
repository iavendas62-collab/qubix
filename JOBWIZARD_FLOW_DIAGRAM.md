# JobWizard Flow Diagram

## Overall Wizard Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         JobWizard Entry                          │
│                    (User clicks "Submit Job")                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STEP 1: Upload & Analysis                     │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  • Drag-and-drop file upload zone                          │ │
│  │  • File validation (size, type)                            │ │
│  │  • Upload progress bar (0-100%)                            │ │
│  │  • Backend analysis call                                   │ │
│  │  • Display results:                                        │ │
│  │    - Job type (MNIST, Stable Diffusion, etc)              │ │
│  │    - Framework (PyTorch, TensorFlow, JAX)                 │ │
│  │    - Required VRAM, Compute, RAM                          │ │
│  │    - Confidence level                                      │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  Validation: ✅ File uploaded AND analysis complete              │
│                                                                   │
│  [Continue to GPU Selection] ──────────────────────────────────┐ │
└─────────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STEP 2: GPU Selection                         │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  • Fetch available GPUs from backend                       │ │
│  │  • SmartMatcher component integration                      │ │
│  │  • Display GPU cards with:                                 │ │
│  │    - Compatibility badge (recommended/compatible/etc)      │ │
│  │    - GPU specs (VRAM, RAM, model)                         │ │
│  │    - Estimated duration                                    │ │
│  │    - Estimated cost                                        │ │
│  │    - Cost-benefit score                                    │ │
│  │  • Sort options (cost-benefit, price, performance)        │ │
│  │  • Top 3 recommendations                                   │ │
│  │  • GPU selection (click to select)                        │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  Validation: ✅ GPU selected                                     │
│                                                                   │
│  [Back] ◄────────────────────┐  [Continue to Configuration] ──┐ │
└─────────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                 STEP 3: Advanced Configuration                   │
│                         (OPTIONAL)                               │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Environment Variables:                                     │ │
│  │  • Add key-value pairs                                     │ │
│  │  • Remove variables                                        │ │
│  │  • Display list of added vars                             │ │
│  │                                                             │ │
│  │  Docker Configuration:                                      │ │
│  │  • Docker image (optional)                                 │ │
│  │  • Entry point (optional)                                  │ │
│  │                                                             │ │
│  │  Output Settings:                                           │ │
│  │  • Output destination (local/IPFS/S3)                      │ │
│  │  • Maximum duration (1-168 hours)                          │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  Validation: ✅ Always valid (optional step)                     │
│                                                                   │
│  [Back] ◄────────┐  [Skip] ──────┐  [Continue to Payment] ────┐ │
└─────────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                  STEP 4: Payment & Launch                        │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Job Summary:                                               │ │
│  │  • Job type, framework                                     │ │
│  │  • File name                                               │ │
│  │  • Selected GPU model                                      │ │
│  │                                                             │ │
│  │  Cost Breakdown:                                            │ │
│  │  • GPU hourly rate                                         │ │
│  │  • Estimated duration                                      │ │
│  │  • Per-minute rate                                         │ │
│  │  • Total estimated cost (prominent)                        │ │
│  │  • Escrow information                                      │ │
│  │                                                             │ │
│  │  Wallet Info:                                               │ │
│  │  • Connected status                                        │ │
│  │  • Balance display                                         │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  [Back] ◄────────┐  [Cancel] ──────┐  [Launch Job] ──────────┐ │
└─────────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Launch Sequence                             │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Status: creating_escrow                                    │ │
│  │  "Creating escrow transaction..."                          │ │
│  │  • Create escrow transaction                               │ │
│  │  • Generate transaction hash                               │ │
│  └────────────────────────────────────────────────────────────┘ │
│                             │                                     │
│                             ▼                                     │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Status: confirming_tx                                      │ │
│  │  "Waiting for confirmations..."                            │ │
│  │  • Wait for blockchain confirmations                       │ │
│  │  • Display confirmation count (0/3, 1/3, 2/3, 3/3)        │ │
│  └────────────────────────────────────────────────────────────┘ │
│                             │                                     │
│                             ▼                                     │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Status: provisioning                                       │ │
│  │  "Provisioning job..."                                     │ │
│  │  • Create job in backend                                   │ │
│  │  • Assign to provider                                      │ │
│  │  • Store job metadata                                      │ │
│  └────────────────────────────────────────────────────────────┘ │
│                             │                                     │
│                             ▼                                     │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │  Status: launched                                           │ │
│  │  "Job launched successfully!"                              │ │
│  │  • Trigger onJobLaunched callback                          │ │
│  │  • Redirect to job monitor (future)                        │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## State Transitions

```
┌──────────────────────────────────────────────────────────────┐
│                     Wizard State Machine                      │
└──────────────────────────────────────────────────────────────┘

currentStep: 1 ──[file analyzed]──► currentStep: 2
                                           │
                                           │
                                    [GPU selected]
                                           │
                                           ▼
                                    currentStep: 3
                                           │
                                           │
                              [continue OR skip]
                                           │
                                           ▼
                                    currentStep: 4
                                           │
                                           │
                                    [launch job]
                                           │
                                           ▼
                                    launchStatus:
                                    idle → creating_escrow
                                         → confirming_tx
                                         → provisioning
                                         → launched
```

## Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         Data Persistence                         │
└─────────────────────────────────────────────────────────────────┘

Step 1: Upload File
  ├─► uploadedFile: File
  └─► jobAnalysis: JobAnalysis
        ├─ jobType
        ├─ detectedFramework
        ├─ estimatedVRAM
        ├─ estimatedCompute
        ├─ estimatedRAM
        └─ confidence

Step 2: Select GPU
  ├─► availableGPUs: Provider[]
  └─► selectedGPU: Provider
        ├─ id
        ├─ gpuModel
        ├─ gpuVram
        ├─ pricePerHour
        └─ ...

Step 3: Configure
  └─► advancedConfig: AdvancedConfig
        ├─ environmentVars: Record<string, string>
        ├─ dockerImage?: string
        ├─ entryPoint?: string
        ├─ outputDestination: 'ipfs' | 's3' | 'local'
        └─ maxDuration: number

Step 4: Launch
  ├─► estimatedCost: number
  ├─► walletBalance: number
  └─► launchStatus: string

All data persists when navigating back/forward!
```

## Validation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                      Validation Logic                            │
└─────────────────────────────────────────────────────────────────┘

validateStep(1):
  ├─ Check: jobAnalysis exists?
  ├─ Check: uploadedFile exists?
  └─ Result: valid = both exist

validateStep(2):
  ├─ Check: selectedGPU exists?
  └─ Result: valid = GPU selected

validateStep(3):
  └─ Result: always valid (optional)

validateStep(4):
  └─ Result: always valid (final step)

On "Continue" click:
  ├─ Call validateStep(currentStep)
  ├─ If valid: advance to next step
  └─ If invalid: show error toast
```

## Component Integration

```
┌─────────────────────────────────────────────────────────────────┐
│                    Component Hierarchy                           │
└─────────────────────────────────────────────────────────────────┘

JobWizard
  │
  ├─► Progress Indicator (custom)
  │     ├─ Step 1 icon + label
  │     ├─ Step 2 icon + label
  │     ├─ Step 3 icon + label
  │     └─ Step 4 icon + label
  │
  ├─► Step 1 Content
  │     └─► JobUploader
  │           ├─ Drag-and-drop zone
  │           ├─ File validation
  │           ├─ Upload progress
  │           └─ Analysis results
  │
  ├─► Step 2 Content
  │     └─► SmartMatcher
  │           ├─ GPU cards
  │           ├─ Compatibility badges
  │           ├─ Sort controls
  │           └─ Top recommendations
  │
  ├─► Step 3 Content (custom)
  │     ├─ Environment variables form
  │     ├─ Docker config form
  │     └─ Output settings form
  │
  └─► Step 4 Content (custom)
        ├─ Job summary card
        ├─ Cost breakdown card
        ├─ Wallet info card
        └─ Launch status card
```

## API Calls

```
┌─────────────────────────────────────────────────────────────────┐
│                         API Integration                          │
└─────────────────────────────────────────────────────────────────┘

Step 1:
  POST /api/jobs/analyze
    ├─ Input: FormData with file
    └─ Output: JobAnalysis

Step 2:
  GET /api/providers
    ├─ Input: none
    └─ Output: Provider[]

Step 4:
  POST /api/jobs/create
    ├─ Input: FormData with:
    │   ├─ file
    │   ├─ jobAnalysis
    │   ├─ providerId
    │   ├─ advancedConfig
    │   └─ escrowTxHash
    └─ Output: Job
```

## User Journey

```
┌─────────────────────────────────────────────────────────────────┐
│                      Typical User Flow                           │
└─────────────────────────────────────────────────────────────────┘

1. User lands on wizard
   └─► Sees Step 1 with upload zone

2. User drags file
   └─► Upload starts, progress bar shows
       └─► Analysis completes, results display
           └─► "Continue" button appears

3. User clicks "Continue"
   └─► Advances to Step 2
       └─► GPUs load and display
           └─► User browses options

4. User selects GPU
   └─► GPU card highlights
       └─► "Continue" button appears

5. User clicks "Continue"
   └─► Advances to Step 3
       └─► User sees advanced options

6. User either:
   a) Adds config and clicks "Continue"
   b) Clicks "Skip this step"
   └─► Advances to Step 4

7. User reviews summary
   └─► Checks cost breakdown
       └─► Clicks "Launch Job"

8. Launch sequence
   └─► Status updates show progress
       └─► Success message appears
           └─► Callback triggered
```

## Error Handling

```
┌─────────────────────────────────────────────────────────────────┐
│                       Error Scenarios                            │
└─────────────────────────────────────────────────────────────────┘

File Upload Error:
  ├─ File too large
  ├─ Invalid file type
  ├─ Network error
  └─► Show error toast, allow retry

GPU Fetch Error:
  ├─ Backend unavailable
  ├─ Network timeout
  └─► Show error message, allow retry

Job Launch Error:
  ├─ Escrow creation failed
  ├─ Job creation failed
  └─► Show error toast, reset to idle
```

This diagram provides a comprehensive visual overview of the JobWizard flow!
