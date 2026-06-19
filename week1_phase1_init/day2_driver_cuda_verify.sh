#!/bin/bash
# =============================================================
# DGX Spark — CUDA Verification Script
# Week 1, Day 2 — dgx-financial-spark-ml portfolio
# System: NVIDIA DGX Spark (arm64 / Grace Hopper)
# =============================================================

set -e

echo "=============================================="
echo " DGX Spark CUDA Verification"
echo " $(date)"
echo "=============================================="

echo ""
echo "=== System Architecture ==="
uname -m
dpkg --print-architecture

echo ""
echo "=== OS Version ==="
lsb_release -a 2>/dev/null

echo ""
echo "=== NVIDIA Driver Version ==="
nvidia-smi --query-gpu=driver_version --format=csv,noheader | head -1

echo ""
echo "=== CUDA Version (driver max supported) ==="
nvidia-smi | grep "CUDA Version"

echo ""
echo "=== CUDA Compiler Version (nvcc) ==="
nvcc --version

echo ""
echo "=== CUDA Toolkit Location ==="
ls /usr/local/ | grep cuda

echo ""
echo "=== GPU Details ==="
nvidia-smi --query-gpu=index,name,memory.total,compute_cap --format=csv

echo ""
echo "=== GPU Count ==="
nvidia-smi --query-gpu=name --format=csv,noheader | wc -l

echo ""
echo "=== GPU Topology ==="
nvidia-smi topo -m

echo ""
echo "=== Docker Platform ==="
docker info 2>/dev/null | grep -E "OSType|Architecture|Server Version" || echo "Docker not yet configured"

echo ""
echo "=== cuDNN Status ==="
echo "NOTE: cuDNN is NOT installed on the DGX Spark host OS — this is expected."
echo "cuDNN is bundled inside RAPIDS/NGC containers and accessed at runtime."
echo "Host cuDNN check is skipped for this system."

echo ""
echo "=== RAPIDS Container Compatibility Check ==="
echo "Driver: $(nvidia-smi --query-gpu=driver_version --format=csv,noheader | head -1)"
echo "CUDA:   13.0 (backward compatible with RAPIDS cuda12.x containers)"
echo "Arch:   $(uname -m) — requires arm64/aarch64 container variants"

echo ""
echo "=== deviceQuery Result ==="
~/cuda-samples/Samples/1_Utilities/deviceQuery/build/deviceQuery | tail -3

echo ""
echo "=== Bandwidth Summary ==="
echo "Missing: Test skipped since CUDA 13.0 Test utility was missing"
# ~/cuda-samples/Samples/1_Utilities/bandwidthTest/build/bandwidthTest | grep -E "Bandwidth|Result"

echo ""
echo "=== p2pBandwidthLatencyTest Result ==="
~/cuda-samples/Samples/5_Domain_Specific/p2pBandwidthLatencyTest/build/p2pBandwidthLatencyTest 

echo ""
echo "=============================================="
echo " CUDA Verification Complete"
echo "=============================================="
