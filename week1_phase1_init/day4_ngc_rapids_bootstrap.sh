#!/bin/bash
# =============================================================
# NGC CLI Setup + RAPIDS Container Bootstrap
# Week 1, Day 4 — dgx-financial-spark-ml portfolio
#
# System: NVIDIA DGX Spark (arm64 / aarch64, CUDA 13.0)
# NOTE: RAPIDS containers are built for CUDA 12.x but are fully
#       compatible with the CUDA 13.0 driver (backward compatible).
#       Docker auto-selects the arm64 image from multi-arch manifests.
# =============================================================

set -e

echo "=============================================="
echo " NGC CLI + RAPIDS Bootstrap"
echo " System: $(uname -m) | CUDA: $(nvcc --version | grep release | awk '{print $5}' | tr -d ',')"
echo "=============================================="

# ── Step 1: NGC CLI Installation (arm64) ──────────────────────
echo ""
echo "=== Installing NGC CLI (arm64) ==="

NGC_VERSION="3.41.4"
ARCH=$(uname -m)   # aarch64 on DGX Spark
CLI_DIR="/tmp"
mkdir -p ${CLI_DIR}

if [ "$ARCH" = "aarch64" ]; then
    NGC_ZIP="ngccli_arm64.zip"
else
    NGC_ZIP="ngccli_linux.zip"
fi

wget --content-disposition \
  "https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/${NGC_VERSION}/files/${NGC_ZIP}" \
  -O ${CLI_DIR}/ngccli.zip

unzip -o ${CLI_DIR}/ngccli.zip -d ${CLI_DIR}/ngc-install
chmod u+x ${CLI_DIR}/ngc-install/ngc-cli/ngc
sudo unlink /usr/local/bin/ngc
sudo ln -s ${CLI_DIR}/ngc-install/ngc-cli/ngc /usr/local/bin/ngc

echo "NGC CLI installed: $(ngc --version 2>/dev/null || ngc version 2>/dev/null)"

# ── Step 2: NGC Configuration ─────────────────────────────────
echo ""
echo "=== NGC Configuration ==="
echo "Run 'ngc config set' to authenticate with your API key."
echo "API keys: https://ngc.nvidia.com → Dashboard → API Keys"
echo ""
echo "Current config (if already set):"
ngc config current 2>/dev/null || echo "Not configured yet — run 'ngc config set'"

# ── Step 3: Verify Docker platform ───────────────────────────
echo ""
echo "=== Docker Platform ==="
docker info | grep -E "OSType|Architecture|Server Version"

# ── Step 4: RAPIDS container compatibility check ──────────────
echo ""
echo "=== RAPIDS Container Compatibility ==="
echo "Driver CUDA: 13.0 (supports all CUDA 12.x containers)"
echo "Host arch:   $(uname -m)"
echo "Target tag:  nvcr.io/nvidia/rapidsai/base:26.06-cuda13-py3.12"
echo ""
echo "Checking arm64 manifest availability..."
docker manifest inspect nvcr.io/nvidia/rapidsai/base:26.06-cuda13-py3.12 2>/dev/null \
  | python3 -c "
import sys, json
data = json.load(sys.stdin)
manifests = data.get('manifests', [])
archs = [m.get('platform',{}).get('architecture','?') for m in manifests]
print(f'Available architectures: {archs}')
arm = any('arm64' in a or 'aarch64' in a for a in archs)
print(f'arm64/aarch64 available: {arm}')
" 2>/dev/null || echo "manifest inspect unavailable — will verify on pull"

# ── Step 5: Pull RAPIDS container ─────────────────────────────
echo ""
echo "=== Pulling RAPIDS Container (~10-15 GB) ==="
echo "This will automatically select the arm64 variant."
echo ""
docker pull nvcr.io/nvidia/rapidsai/base:26.06-cuda13-py3.12

echo ""
echo "=== Installed RAPIDS Images ==="
docker images | grep rapids

echo ""
echo "=============================================="
echo " NGC + RAPIDS Bootstrap Complete"
echo "=============================================="

# ── Step 6: Execute cuDF Smoke Test Script on RAPIDS container ─────────────────────────────
echo ""
echo "=== Executing cuDF Script on RAPIDS Image ==="
docker run --rm --gpus all   -v /home/tamil/dgx-financial-spark-ml:/workspace   nvcr.io/nvidia/rapidsai/base:26.06-cuda13-py3.12   python /workspace/week1_phase1_init/day4_cudf_smoketest.py

