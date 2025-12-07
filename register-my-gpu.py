#!/usr/bin/env python3
"""
Script simples para detectar e registrar sua GPU real no marketplace
"""

import subprocess
import json
import requests
import platform
import psutil
from datetime import datetime

# Configuração
BACKEND_URL = "http://localhost:3004/api"

def detect_gpu():
    """Detecta GPU NVIDIA usando nvidia-smi"""
    try:
        result = subprocess.run(
            ['nvidia-smi', '--query-gpu=name,memory.total', '--format=csv,noheader'],
            capture_output=True,
            text=True,
            check=True
        )
        
        output = result.stdout.strip()
        if output:
            parts = output.split(',')
            gpu_name = parts[0].strip()
            gpu_vram_mb = int(parts[1].strip().split()[0])
            gpu_vram_gb = gpu_vram_mb / 1024
            
            return {
                'model': gpu_name,
                'vram': round(gpu_vram_gb, 1),
                'vendor': 'NVIDIA',
                'type': 'native'
            }
    except Exception as e:
        print(f"❌ Erro ao detectar GPU: {e}")
        return None

def detect_cpu():
    """Detecta informações da CPU"""
    try:
        cpu_count = psutil.cpu_count(logical=False) or psutil.cpu_count()
        cpu_name = platform.processor() or f"{cpu_count}-core CPU"
        
        return {
            'cores': cpu_count,
            'model': cpu_name
        }
    except Exception as e:
        print(f"⚠️  Erro ao detectar CPU: {e}")
        return {'cores': 4, 'model': 'Unknown CPU'}

def detect_ram():
    """Detecta memória RAM total"""
    try:
        ram_bytes = psutil.virtual_memory().total
        ram_gb = ram_bytes / (1024 ** 3)
        return {'total': round(ram_gb, 1)}
    except Exception as e:
        print(f"⚠️  Erro ao detectar RAM: {e}")
        return {'total': 8}

def generate_qubic_address():
    """Gera endereço Qubic mock para teste (60 caracteres uppercase)"""
    import random
    import string
    # Endereço Qubic tem exatamente 60 caracteres uppercase
    return ''.join(random.choices(string.ascii_uppercase, k=60))

def register_provider(gpu, cpu, ram):
    """Registra provider no backend"""
    
    # Gerar IDs únicos
    worker_id = f"real-gpu-{datetime.now().strftime('%Y%m%d%H%M%S')}"
    qubic_address = generate_qubic_address()
    
    # Calcular preço baseado na GPU
    vram = gpu['vram']
    if vram >= 24:
        price = 2.0
    elif vram >= 16:
        price = 1.5
    elif vram >= 8:
        price = 1.0
    else:
        price = 0.5
    
    # Dados do provider
    provider_data = {
        'type': 'native',
        'workerId': worker_id,
        'qubicAddress': qubic_address,
        'gpu': gpu,
        'cpu': cpu,
        'ram': ram,
        'location': 'Local Machine',
        'pricePerHour': price
    }
    
    print("\nRegistrando GPU no marketplace...")
    print(f"   GPU: {gpu['model']}")
    print(f"   VRAM: {gpu['vram']} GB")
    print(f"   CPU: {cpu['cores']} cores")
    print(f"   RAM: {ram['total']} GB")
    print(f"   Preco: {price} QUBIC/hora")
    print(f"   Worker ID: {worker_id}")
    
    try:
        response = requests.post(
            f"{BACKEND_URL}/providers/quick-register",
            json=provider_data,
            timeout=10
        )
        
        if response.status_code == 200:
            data = response.json()
            if data.get('success'):
                provider = data.get('provider', {})
                print("\nGPU REGISTRADA COM SUCESSO!")
                print(f"   Provider ID: {provider.get('id')}")
                print(f"   Status: Online")
                print(f"\nVer no marketplace:")
                print(f"   http://localhost:3004/app/marketplace")
                
                # Salvar info localmente
                with open('provider-info.json', 'w') as f:
                    json.dump({
                        'providerId': provider.get('id'),
                        'workerId': worker_id,
                        'qubicAddress': qubic_address,
                        'gpu': gpu,
                        'registeredAt': datetime.now().isoformat()
                    }, f, indent=2)
                
                print(f"\nInformacoes salvas em: provider-info.json")
                return True
            else:
                print(f"\nErro: {data.get('error', 'Unknown error')}")
                return False
        else:
            print(f"\nErro HTTP {response.status_code}")
            print(f"   {response.text}")
            return False
            
    except requests.exceptions.ConnectionError:
        print("\nErro: Nao foi possivel conectar ao backend")
        print("   Verifique se o servidor esta rodando em http://localhost:3004")
        return False
    except Exception as e:
        print(f"\nErro ao registrar: {e}")
        return False

def main():
    print("=" * 60)
    print("QUBIX - Registro Automatico de GPU Real")
    print("=" * 60)
    print()
    
    # Detectar hardware
    print("Detectando hardware...")
    
    gpu = detect_gpu()
    if not gpu:
        print("\nGPU NVIDIA nao detectada!")
        print("   Certifique-se de que:")
        print("   1. Voce tem uma GPU NVIDIA")
        print("   2. Os drivers estao instalados")
        print("   3. nvidia-smi esta funcionando")
        return
    
    cpu = detect_cpu()
    ram = detect_ram()
    
    print(f"\nHardware detectado:")
    print(f"   GPU: {gpu['model']} ({gpu['vram']} GB)")
    print(f"   CPU: {cpu['cores']} cores")
    print(f"   RAM: {ram['total']} GB")
    
    # Registrar
    success = register_provider(gpu, cpu, ram)
    
    if success:
        print("\n" + "=" * 60)
        print("PRONTO! Sua GPU esta no marketplace!")
        print("=" * 60)
        print("\nProximos passos:")
        print("   1. Abra: http://localhost:3004/app/marketplace")
        print("   2. Veja sua GPU listada")
        print("   3. Cliente pode alugar e mandar jobs")
        print()

if __name__ == '__main__':
    main()
