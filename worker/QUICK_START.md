# QUBIX Worker Quick Start Guide

## Prerequisites

- Python 3.8 or higher
- `psutil` library: `pip install psutil`
- `requests` library: `pip install requests`
- (Optional) NVIDIA GPU with nvidia-smi for GPU metrics

## Installation

```bash
# Install dependencies
pip install psutil requests

# Optional: Install websockets for WebSocket support
pip install websockets
```

## Running the Worker

### Basic Usage

```bash
cd worker
python qubix_worker_simple.py --backend http://localhost:3001
```

### With Custom Configuration

```bash
python qubix_worker_simple.py \
  --backend http://localhost:3001 \
  --price 2.5 \
  --name "My Gaming PC" \
  --location "US East (Virginia)"
```

### Command Line Options

- `--backend URL`: Backend server URL (default: http://127.0.0.1:3001)
- `--price FLOAT`: Price per hour in QUBIC (default: 5.0)
- `--name STRING`: Provider name (default: Provider-{workerId})
- `--location STRING`: Geographic location (default: Local Network)

## Testing

### Run Unit Tests

```bash
python test_worker.py
```

Expected output:
```
✅ Hardware detection passed
✅ GPU metrics collection passed
✅ Job execution logic passed
✅ Result generation passed
✅ ALL TESTS PASSED
```

### Run Integration Tests

```bash
# Make sure backend is running first!
python test_integration.py
```

## What Happens When You Run the Worker

1. **Hardware Detection**: Worker detects CPU, RAM, GPU specifications
2. **Registration**: Worker registers with backend as a provider
3. **Heartbeat Loop**: Worker sends heartbeat every 30 seconds
4. **Job Polling**: Backend returns pending jobs in heartbeat response
5. **Job Execution**: Worker executes jobs and reports progress
6. **Completion**: Worker reports results and becomes available again

## Monitoring

### Console Output

The worker provides real-time console output:

```
🚀 QUBIX WORKER - Versão Simplificada
Conectando seu hardware ao QUBIX Compute Hub

🔌 Conectando ao backend: http://localhost:3001

📊 Hardware detectado:
   CPU: Intel Core i7-8550U (8 cores)
   RAM: 15.9 GB
   GPU: NVIDIA GeForce MX150 (4.0 GB VRAM)
   Storage: 79.43 GB livres

✅ Provider registrado com sucesso!
   ID: abc123def456
   Preço: 5.0 QUBIC/hora

🟢 Worker online e aguardando jobs...
   Worker ID: abc123def456
   Preço: 5.0 QUBIC/hora
   Pressione Ctrl+C para parar

💓 Heartbeat enviado - CPU: 20.8% | RAM: 69.4% | GPU: 0.0%
```

### When a Job Arrives

```
📥 Job pendente recebido via heartbeat

🎯 Executando job: job-123
   Tipo: training
   Compute: 2.0 unidades

   ⏳ Progresso: 10% | CPU: 45.2% | RAM: 71.3%
   ⏳ Progresso: 20% | CPU: 48.1% | RAM: 72.0%
   ...
   ⏳ Progresso: 100% | CPU: 52.3% | RAM: 73.5%

✅ Job concluído: job-123
   Tempo: 15.23s | CPU médio: 48.5%
   ✅ Resultado reportado com sucesso
```

## Troubleshooting

### Cannot Connect to Backend

```
❌ Erro no heartbeat: Connection refused
```

**Solution**: Make sure the backend is running:
```bash
cd backend
npm run dev
```

### GPU Not Detected

```
⚠️  Erro ao coletar métricas GPU: nvidia-smi not found
```

**Solution**: 
- Install NVIDIA drivers
- Ensure nvidia-smi is in PATH
- Worker will still function with CPU-only metrics

### Registration Failed

```
❌ Falha ao registrar: Invalid Qubic address format
```

**Solution**: Check that the backend is properly configured and the database is running.

## Stopping the Worker

Press `Ctrl+C` to gracefully stop the worker:

```
🛑 Desligando worker...
👋 Worker desconectado. Até logo!
```

## Advanced Usage

### Running Multiple Workers

You can run multiple workers on different machines or with different configurations:

```bash
# Worker 1 - High-end GPU
python qubix_worker_simple.py --price 3.0 --name "RTX 4090 Server"

# Worker 2 - Mid-range GPU
python qubix_worker_simple.py --price 1.5 --name "GTX 1080 Desktop"

# Worker 3 - CPU only
python qubix_worker_simple.py --price 0.5 --name "CPU Server"
```

### Custom Backend URL

For production deployments:

```bash
python qubix_worker_simple.py --backend https://api.qubix.io
```

### Environment Variables

You can also use environment variables:

```bash
export BACKEND_URL=http://localhost:3001
python qubix_worker_simple.py
```

## Next Steps

1. **Monitor Earnings**: Check your provider dashboard to see earnings
2. **Optimize Performance**: Adjust pricing based on demand
3. **Scale Up**: Run multiple workers for more capacity
4. **Production Deploy**: Use systemd or Docker for always-on operation

## Support

For issues or questions:
- Check the logs in the console output
- Review `ENHANCED_WORKER_GUIDE.md` for detailed documentation
- Run `test_worker.py` to verify functionality
- Check backend logs for API errors

## Production Deployment

### Using systemd (Linux)

Create `/etc/systemd/system/qubix-worker.service`:

```ini
[Unit]
Description=QUBIX Worker
After=network.target

[Service]
Type=simple
User=qubix
WorkingDirectory=/opt/qubix/worker
ExecStart=/usr/bin/python3 qubix_worker_simple.py --backend https://api.qubix.io
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable qubix-worker
sudo systemctl start qubix-worker
sudo systemctl status qubix-worker
```

### Using Docker

```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY worker/ /app/

RUN pip install psutil requests

CMD ["python", "qubix_worker_simple.py", "--backend", "http://backend:3001"]
```

Build and run:
```bash
docker build -t qubix-worker .
docker run -d --name qubix-worker qubix-worker
```

## Performance Tips

1. **Close Unnecessary Applications**: Free up GPU/CPU resources
2. **Monitor Temperature**: Ensure adequate cooling
3. **Stable Internet**: Reliable connection for heartbeat
4. **Power Settings**: Disable sleep/hibernation
5. **Update Drivers**: Keep GPU drivers up to date
