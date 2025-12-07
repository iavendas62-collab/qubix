# Cost Estimation System Guide

## Overview

The Cost Estimation System provides accurate duration and cost predictions for GPU compute jobs using benchmark data and parameter-based adjustments. It supports reactive recalculation within 500ms of configuration changes.

**Requirements Implemented:**
- 12.1: Duration estimation from benchmarks
- 12.2: Human-readable time format
- 12.3: Cost calculation formula
- 12.4: Cost breakdown display
- 12.5: Reactive estimate recalculation (≤500ms)
- 12.6: Estimate ranges for uncertain predictions
- 14.1: Job type detection
- 14.2: Benchmark lookup
- 14.3: Parameter-based adjustment
- 14.4: Conservative estimates when benchmarks unavailable
- 14.5: Confidence level display

## Architecture

### Database Schema

```prisma
model Benchmark {
  id              String    @id @default(uuid())
  jobType         String
  gpuModel        String
  baseTimeSeconds Int
  
  // Optional parameters
  epochs          Int?
  resolution      Int?
  datasetSize     Int?
  
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
  
  @@unique([jobType, gpuModel])
  @@index([jobType])
  @@index([gpuModel])
}
```

### Benchmark Data

The system includes benchmarks for:

**MNIST Training:**
- RTX 4090: 120s (5 epochs, 10k dataset)
- RTX 4080: 150s
- RTX 3090: 180s
- RTX 3080: 220s
- RTX 3070: 280s
- RTX 3060: 350s

**Stable Diffusion:**
- RTX 4090: 300s (512x512)
- RTX 4080: 400s
- RTX 3090: 450s
- RTX 3080: 550s
- RTX 3070: 700s

**Inference:**
- RTX 4090: 60s
- RTX 4080: 80s
- RTX 3090: 100s
- RTX 3080: 120s
- RTX 3070: 150s

**Custom Scripts:**
- Conservative estimates: 600-1400s depending on GPU

## API Endpoints

### Calculate Cost Estimate

```http
POST /api/cost-estimation/calculate
Content-Type: application/json

{
  "jobType": "mnist_training",
  "gpuModel": "RTX 4090",
  "pricePerHour": 2.5,
  "parameters": {
    "epochs": 10,
    "resolution": 1024,
    "datasetSize": 20000
  }
}
```

**Response:**
```json
{
  "success": true,
  "estimate": {
    "estimatedDuration": 240,
    "estimatedDurationFormatted": "4 minutes",
    "estimatedCost": 0.1667,
    "perMinuteRate": 0.0417,
    "totalCost": 0.1667,
    "confidence": "high",
    "costBreakdown": {
      "baseRate": 2.5,
      "duration": "4 minutes",
      "total": 0.1667
    }
  }
}
```

### Calculate Estimate Range

For uncertain estimates (low confidence):

```http
POST /api/cost-estimation/calculate-range
Content-Type: application/json

{
  "jobType": "custom_script",
  "gpuModel": "Unknown GPU",
  "pricePerHour": 2.0
}
```

**Response:**
```json
{
  "success": true,
  "minEstimate": {
    "estimatedDuration": 840,
    "estimatedDurationFormatted": "14 minutes",
    "estimatedCost": 0.4667,
    "confidence": "low"
  },
  "maxEstimate": {
    "estimatedDuration": 1560,
    "estimatedDurationFormatted": "26 minutes",
    "estimatedCost": 0.8667,
    "confidence": "low"
  },
  "confidence": "low"
}
```

### Get Benchmarks

```http
GET /api/cost-estimation/benchmarks/mnist_training
```

**Response:**
```json
{
  "success": true,
  "jobType": "mnist_training",
  "benchmarks": {
    "RTX 4090": 120,
    "RTX 4080": 150,
    "RTX 3090": 180,
    "RTX 3080": 220,
    "RTX 3070": 280,
    "RTX 3060": 350
  }
}
```

## Parameter Adjustments

### Linear Scaling

**Epochs and Dataset Size:**
- 2x epochs = 2x duration
- 2x dataset = 2x duration

Example:
```
Base: 5 epochs, 10k dataset = 180s
Adjusted: 10 epochs, 20k dataset = 720s (4x)
```

### Quadratic Scaling

**Resolution (for image generation):**
- 2x resolution = 4x duration
- Formula: `(newRes / baseRes)²`

Example:
```
Base: 512x512 = 300s
Adjusted: 1024x1024 = 1200s (4x)
```

## Frontend Integration

### React Hook

```typescript
import { useCostEstimation } from '../hooks/useCostEstimation';

function MyComponent() {
  const { estimate, loading, error } = useCostEstimation({
    jobType: 'mnist_training',
    gpuModel: 'RTX 4090',
    pricePerHour: 2.5,
    parameters: {
      epochs: 10,
      datasetSize: 20000
    },
    debounceMs: 500 // Reactive recalculation within 500ms
  });

  if (loading) return <div>Calculating...</div>;
  if (error) return <div>Error: {error}</div>;
  
  return (
    <div>
      <p>Duration: {estimate.estimatedDurationFormatted}</p>
      <p>Cost: {estimate.totalCost.toFixed(4)} QUBIC</p>
      <p>Confidence: {estimate.confidence}</p>
    </div>
  );
}
```

### Cost Estimation Component

```typescript
import { CostEstimation } from '../components/CostEstimation';

<CostEstimation
  jobType="stable_diffusion"
  gpuModel="RTX 3090"
  pricePerHour={2.0}
  parameters={{ resolution: 1024 }}
  showRange={false}
/>
```

## Confidence Levels

### High Confidence
- Benchmark exists for exact GPU and job type
- Parameters within ±50% of benchmark parameters
- Display: Green badge, single estimate

### Medium Confidence
- Benchmark exists but parameters differ significantly
- Parameters >50% different from benchmark
- Display: Yellow badge, single estimate with note

### Low Confidence
- No benchmark for GPU/job type combination
- Using conservative default estimates
- Display: Orange badge, estimate range (±30%)

## Testing

### Run Test Script

```bash
cd backend
npm run test:cost-estimation
```

### Test Scenarios

1. **Basic Estimation:** Default parameters
2. **Parameter Adjustment:** Varying epochs, resolution, dataset
3. **Multiple GPUs:** Compare across different models
4. **Unknown GPU:** Test low confidence range
5. **Reactive Recalculation:** Verify <500ms response

### Expected Results

```
✅ Duration estimates match benchmarks
✅ Parameter adjustments scale correctly
✅ Cost = Duration × Hourly Rate
✅ Human-readable format is clear
✅ Confidence levels are accurate
✅ Recalculation completes within 500ms
```

## Performance Considerations

### Database Queries
- Benchmarks indexed by `jobType` and `gpuModel`
- Unique constraint prevents duplicates
- Query time: <10ms

### Calculation Speed
- In-memory calculations: <1ms
- Database lookup: <10ms
- Total API response: <50ms
- Frontend debounce: 500ms (configurable)

### Caching Strategy
- Benchmarks rarely change → cache in memory
- Estimates are parameter-specific → no caching
- Frontend debouncing prevents excessive requests

## Migration

### Apply Migration

```bash
cd backend
npx prisma migrate deploy
```

### Seed Benchmarks

```bash
npx prisma db seed
```

## Troubleshooting

### Issue: Estimates seem inaccurate

**Solution:**
1. Check if benchmark exists for GPU/job type
2. Verify parameters are reasonable
3. Review confidence level
4. Add more benchmarks if needed

### Issue: Slow recalculation

**Solution:**
1. Check database connection
2. Verify indexes are created
3. Increase debounce time if needed
4. Monitor API response times

### Issue: Low confidence for known GPUs

**Solution:**
1. Add benchmark to database
2. Run seed script to populate
3. Verify GPU model name matches exactly

## Future Enhancements

1. **Machine Learning:** Train model on actual job durations
2. **User Feedback:** Collect actual vs estimated times
3. **Dynamic Benchmarks:** Update based on real performance
4. **Provider-Specific:** Account for provider hardware variations
5. **Network Factors:** Consider data transfer times

## Related Documentation

- [GPU Matching Implementation](./GPU_MATCHING_IMPLEMENTATION.md)
- [Job Analysis Service](./JOB_ANALYSIS_IMPLEMENTATION.md)
- [Database Schema](./prisma/schema.prisma)
- [API Documentation](../docs/API.md)
