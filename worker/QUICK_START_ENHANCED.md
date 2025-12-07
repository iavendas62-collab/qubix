# QUBIX Enhanced Worker - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Prerequisites

- Python 3.8 or higher
- pip package manager
- (Optional) NVIDIA GPU with CUDA support

### Step 1: Install Dependencies

```bash
cd worker
pip install -r requirements.txt
```

**Note**: This installs basic dependencies. For full ML capabilities, see "Optional Dependencies" below.

### Step 2: Start the Worker

```bash
python qubix_worker_enhanced.py --backend http://127.0.0.1:3001
```

You should see:

```
╔═══════════════════════════════════════════════════════════╗
║   🚀 QUBIX WORKER - Enhanced Version                     ║
║   Full job execution with MNIST, Stable Diffusion, etc   ║
╚═══════════════════════════════════════════════════════════╝

🔌 Connecting to backend: http://127.0.0.1:3001

📊 Hardware detected:
   CPU: Intel Core i7-8550U (8 cores)
   RAM: 16.0 GB
   GPU: NVIDIA GeForce MX150 (4.0 GB VRAM)

✅ Provider registered successfully!

🟢 Worker online and polling for jobs...
   Worker ID: a1b2c3d4e5f6g7h8
   Poll interval: 5s
   Press Ctrl+C to stop
```

### Step 3: Submit a Test Job

The worker is now ready to accept jobs! Submit jobs through the backend API or dashboard.

## 📋 Command Line Options

### Basic Options

```bash
# Connect to different backend
python qubix_worker_enhanced.py --backend http://api.qubix.io

# Set custom price
python qubix_worker_enhanced.py --price 10.0

# Set provider name
python qubix_worker_enhanced.py --name "My Gaming PC"

# Set location
python qubix_worker_enhanced.py --location "US East (Virginia)"
```

### Combined Example

```bash
python qubix_worker_enhanced.py \
  --backend http://api.qubix.io \
  --price 8.5 \
  --name "RTX 4090 Workstation" \
  --location "US West (Oregon)"
```

## 🧪 Test the Worker

Run the test suite to verify everything works:

```bash
python test_enhanced_worker.py
```

Expected output:

```
╔═══════════════════════════════════════════════════════════╗
║   🧪 QUBIX Enhanced Worker Test Suite                    ║
╚═══════════════════════════════════════════════════════════╝

✅ PASS - GPU Metrics
✅ PASS - Progress Reporting
✅ PASS - Custom Script
✅ PASS - MNIST Training
✅ PASS - Stable Diffusion

Total: 5/5 tests passed
🎉 All tests passed!
```

## 📦 Optional Dependencies

### For MNIST Training (PyTorch)

```bash
# CPU only
pip install torch torchvision

# With CUDA 11.8
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu118

# With CUDA 12.1
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
```

### For Stable Diffusion

```bash
pip install diffusers transformers accelerate
```

### For GPU Metrics

Ensure nvidia-smi is installed and in your PATH:

```bash
# Test nvidia-smi
nvidia-smi

# Should show GPU information
```

## 🎯 Job Types Supported

### 1. MNIST Training

```json
{
  "id": "job-123",
  "jobType": "mnist_training",
  "inputData": {
    "epochs": 5,
    "batch_size": 64,
    "learning_rate": 0.01
  }
}
```

**What it does**: Trains a CNN on MNIST digit classification

**Duration**: 2-5 minutes (GPU) or 5-10 minutes (CPU)

### 2. Stable Diffusion

```json
{
  "id": "job-456",
  "jobType": "stable_diffusion",
  "inputData": {
    "prompt": "a beautiful sunset over mountains",
    "num_images": 4,
    "steps": 50
  }
}
```

**What it does**: Generates images from text prompts

**Duration**: 30-60 seconds per image (GPU)

### 3. Custom Script

```json
{
  "id": "job-789",
  "jobType": "custom_script",
  "inputData": {
    "script": "print('Hello from QUBIX!')",
    "scriptUrl": "https://example.com/script.py"
  }
}
```

**What it does**: Executes arbitrary Python scripts

**Duration**: Depends on script complexity

## 🔍 Monitoring

### Worker Status

The worker prints status updates:

```
💓 Heartbeat - CPU: 45.2% | RAM: 62.1%
📥 Job received via polling: job-123
🎯 Executing job: job-123
   Type: mnist_training
🧠 Starting MNIST training with PyTorch...
   Epoch 1/5: Loss=0.3421, Accuracy=89.23%
   Epoch 2/5: Loss=0.2156, Accuracy=93.45%
   ...
✅ Job completed: job-123 (245.67s)
```

### GPU Metrics

If nvidia-smi is available, GPU metrics are collected:

```
📊 Job job-123 progress: 50% - Training epoch 3/5
   GPU: 85.3% util, 72.1°C
```

## 🛠️ Troubleshooting

### Worker Won't Connect

**Problem**: `❌ Error registering: Connection refused`

**Solution**: Ensure backend is running:
```bash
cd backend
npm run dev
```

### PyTorch Not Found

**Problem**: `⚠️  PyTorch not available: No module named 'torch'`

**Solution**: Install PyTorch:
```bash
pip install torch torchvision
```

**Note**: Worker will fall back to simulation mode

### nvidia-smi Not Found

**Problem**: `⚠️  Failed to collect GPU metrics`

**Solution**: 
1. Install NVIDIA drivers
2. Ensure nvidia-smi is in PATH
3. Worker will continue without GPU metrics

### Job Execution Fails

**Problem**: `❌ Job failed: ...`

**Solution**: Check the error message and:
1. Verify dependencies are installed
2. Check script syntax (for custom scripts)
3. Ensure sufficient GPU memory
4. Review backend logs

## 📊 Performance Tips

### Optimize for Speed

1. **Use GPU**: Install CUDA-enabled PyTorch
2. **Increase Batch Size**: For MNIST training
3. **Reduce Steps**: For Stable Diffusion (trade quality for speed)
4. **Close Other Apps**: Free up GPU memory

### Optimize for Earnings

1. **Set Competitive Price**: Check marketplace rates
2. **Maximize Uptime**: Keep worker running 24/7
3. **Upgrade Hardware**: Better GPU = higher rates
4. **Good Location**: Lower latency = more jobs

## 🔐 Security Notes

- Scripts run in isolated temporary directories
- Subprocess timeout protection enabled
- No arbitrary code execution from untrusted sources
- Temporary files cleaned up after execution

## 📚 Additional Resources

- **Full Documentation**: See `ENHANCED_WORKER_README.md`
- **API Reference**: See backend API documentation
- **Troubleshooting**: See `ENHANCED_WORKER_README.md`
- **Examples**: See `test_enhanced_worker.py`

## 🆘 Getting Help

If you encounter issues:

1. Check the troubleshooting section above
2. Review the full documentation
3. Check backend logs
4. Run the test suite to isolate the problem

## 🎉 Success!

Your worker is now ready to earn QUBIC tokens by providing compute power to the QUBIX network!

**Next Steps**:
1. Keep the worker running
2. Monitor the dashboard for jobs
3. Track your earnings
4. Optimize your setup for maximum profit

Happy computing! 🚀
