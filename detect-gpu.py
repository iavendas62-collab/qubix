#!/usr/bin/env python3
"""
Simple GPU Detection Script
Returns JSON with GPU information
"""

import json
import sys

try:
    import GPUtil
    
    gpus = GPUtil.getGPUs()
    
    if not gpus:
        print(json.dumps({
            "success": True,
            "detected": False,
            "message": "No GPU detected"
        }))
        sys.exit(0)
    
    # Get first GPU
    gpu = gpus[0]
    
    result = {
        "success": True,
        "detected": True,
        "hardware": {
            "gpu_model": gpu.name,
            "gpu_vram_gb": round(gpu.memoryTotal / 1024),  # Convert MB to GB
            "vendor": "NVIDIA",
            "gpu_id": gpu.id,
            "gpu_load": gpu.load * 100,
            "gpu_temp": gpu.temperature,
            "gpu_memory_used": gpu.memoryUsed,
            "gpu_memory_total": gpu.memoryTotal
        }
    }
    
    print(json.dumps(result))
    
except ImportError:
    print(json.dumps({
        "success": False,
        "detected": False,
        "error": "GPUtil not installed. Run: pip install gputil"
    }))
    sys.exit(1)
    
except Exception as e:
    print(json.dumps({
        "success": False,
        "detected": False,
        "error": str(e)
    }))
    sys.exit(1)
