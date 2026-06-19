#!/bin/bash
# day3_docker_gpu_test.sh
set -e
echo "=== Docker Version ===" && docker --version
echo "=== nvidia-ctk Version ===" && nvidia-ctk --version
echo "=== Runtime Config ===" && cat /etc/docker/daemon.json
echo "=== GPU Access Inside Container ==="
docker run --rm --gpus all \
  nvidia/cuda:12.4.1-base-ubuntu22.04 \
  nvidia-smi --query-gpu=index,name,memory.total --format=csv
echo "=== PASS: All GPUs accessible inside Docker ==="

