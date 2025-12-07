# JobWizard Component

## Overview

The JobWizard is a 4-step guided wizard component for job submission in the QUBIX platform. It provides a streamlined user experience for uploading files, selecting GPUs, configuring advanced settings, and launching jobs with escrow payment.

## Features

### Step 1: Upload & Analysis
- Drag-and-drop file upload interface
- Automatic job type detection
- GPU requirements extraction
- File validation and preview

### Step 2: GPU Selection
- Smart GPU matching based on job requirements
- Compatibility scoring and badges
- Cost and duration estimates
- Top 3 recommendations
- Sortable GPU list

### Step 3: Advanced Configuration (Optional)
- Environment variables management
- Docker image configuration
- Entry point customization
- Output destination selection
- Maximum duration setting
- Skip button for quick submission

### Step 4: Payment & Launch
- Job summary review
- Detailed cost breakdown
- Wallet balance display
- Escrow transaction creation
- Real-time launch status updates

## Requirements Implemented

- **4.1**: Progress indicator showing current step (1/4, 2/4, etc)
- **4.2**: Step 1 (Upload & Analysis) and Step 2 (GPU Selection) integration
- **4.3**: Step 3 (Advanced Config) with env vars, Docker, and output settings
- **4.4**: Step 4 (Payment & Launch) with cost breakdown
- **4.5**: Payment confirmation with wallet integration
- **4.6**: Step validation before allowing next
- **4.7**: Back/Next navigation with data persistence
- **4.8**: Skip button for Step 3 (advanced config)
- **12.4**: Cost breakdown display (per-minute rate + total)

## Usage

```tsx
import { JobWizard } from '../components/JobWizard';

function MyPage() {
  const handleJobLaunched = (job: Job) => {
    console.log('Job launched:', job);
    // Navigate to job monitor or show success message
  };

  const handleCancel = () => {
    // Handle wizard cancellation
  };

  return (
    <JobWizard
      onJobLaunched={handleJobLaunched}
      onCancel={handleCancel}
    />
  );
}
```

## Props

### JobWizardProps

| Prop | Type | Required | Description |
|------|------|----------|-------------|
| `onJobLaunched` | `(job: Job) => void` | Yes | Callback when job is successfully launched |
| `onCancel` | `() => void` | Yes | Callback when user cancels the wizard |

## State Management

The wizard maintains the following state:

- **currentStep**: Current wizard step (1-4)
- **jobAnalysis**: Analysis results from file upload
- **uploadedFile**: The uploaded file
- **selectedGPU**: Selected GPU provider
- **advancedConfig**: Advanced configuration settings
- **estimatedCost**: Calculated job cost
- **walletBalance**: User's wallet balance
- **launchStatus**: Job launch progress status
- **availableGPUs**: List of available GPU providers

## Data Persistence

The wizard preserves all entered data when navigating between steps using the Back button. This ensures users don't lose their configuration when reviewing previous steps.

## Validation

Each step is validated before allowing progression:

1. **Step 1**: Requires file upload and successful analysis
2. **Step 2**: Requires GPU selection
3. **Step 3**: Always valid (optional configuration)
4. **Step 4**: Validates all previous steps before launch

## Launch Flow

1. User clicks "Launch Job" button
2. Status: `creating_escrow` - Creates escrow transaction
3. Status: `confirming_tx` - Waits for blockchain confirmations
4. Status: `provisioning` - Creates job in backend
5. Status: `launched` - Job successfully launched
6. Callback `onJobLaunched` is triggered

## Demo

Visit `/job-wizard-demo` to see the JobWizard in action.

## Integration with Other Components

- **JobUploader**: Handles file upload and analysis in Step 1
- **SmartMatcher**: Provides GPU matching and selection in Step 2
- **QubicService**: (Future) Will handle real blockchain transactions

## Styling

The component uses:
- TailwindCSS for styling
- Lucide React for icons
- Custom Card and Button components
- Gradient backgrounds and animations
- Responsive design for mobile/tablet

## Future Enhancements

1. Real Qubic wallet integration
2. Live balance updates
3. Transaction confirmation polling
4. Job cost estimation from benchmarks
5. Multi-file upload support
6. Job templates and presets
7. Advanced GPU filtering options
8. Real-time GPU availability updates
