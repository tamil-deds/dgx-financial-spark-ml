# NVIDIA DGX & Accelerated Apache Spark: Financial ML Engine

A 1-hour-a-day structured learning initiative dedicated to mastering the **NVIDIA DGX ecosystem**, **RAPIDS**, and **NVIDIA-Accelerated Apache Spark** (`rapids-4-spark`).

The objective of this repository is to build a high-throughput, GPU-accelerated data engineering and machine learning pipeline capable of processing institutional-grade market data.

---

## 🚀 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Compute** | NVIDIA DGX System (CUDA 12.x, NVIDIA Container Toolkit, Docker) |
| **GPU DataFrames** | RAPIDS cuDF — GPU-native pandas alternative |
| **Distributed Compute** | Apache Spark (Standalone) + NVIDIA RAPIDS Accelerator |
| **GPU ML** | RAPIDS cuML, XGBoost4J-Spark |
| **Data Source** | [Massive.com](https://massive.com) — Historical Stocks, Options, Tick-Level Trades, OHLCV flat files |

---

## 🗺️ Learning Phases

| Phase | Week | Topic | Status |
|-------|------|-------|--------|
| 1 | Week 1 | DGX Init, CUDA, Docker, NVIDIA Container Toolkit | ⏳ In Progress |
| 2 | Week 2 | GPU DataFrames with RAPIDS cuDF — Massive.com tick data | ⏳ Upcoming |
| 3 | Week 3 | Apache Spark + RAPIDS Accelerator — distributed pipelines | ⏳ Upcoming |
| 4 | Week 4 | GPU Feature Engineering — rolling VWAP, volatility, moving averages | ⏳ Upcoming |
| 5 | Week 5 | Accelerated ML — XGBoost4J-Spark, cuML anomaly detection | ⏳ Upcoming |

---

## 📈 Portfolio Goals

1. **Accelerated ETL** — Move financial CSV/Parquet preparation entirely onto DGX Tensor Cores
2. **GPU Feature Engineering** — Compute rolling VWAP, moving averages, and volatility matrices over billions of market rows under distributed Spark
3. **High-Fidelity Modeling** — Train parallelized GBDTs (XGBoost) to discover predictive market alpha signals

---

## 🗓️ Daily Progress Log

> **Note to Recruiters:** This repository is updated daily. Each entry represents exactly 1 hour of focused technical execution on live NVIDIA DGX hardware, committed the same day it was run.

### Phase 1 — DGX Initialization & CUDA Foundations

#### Week 1: Environment Provisioning & Baseline Performance

| Day | Date | Objective | Artifact |
|-----|------|-----------|----------|
| 1 | - | Hardware unboxing, first boot, GPU topology verification | `week1_phase1_init/day1_hardware_inventory.md` |
| 2 | - | CUDA driver verification, deviceQuery & bandwidthTest baselines | `week1_phase1_init/day2_driver_cuda_verify.sh` |
| 3 | - | Docker + NVIDIA Container Toolkit — GPU access inside containers | `week1_phase1_init/day3_docker_gpu_test.sh` |
| 4 | - | NGC container registry, first RAPIDS cuDF smoke test on GPU | `week1_phase1_init/day4_cudf_smoketest.py` |
| 5 | - | Full system benchmark report, repo scaffolding complete | `week1_phase1_init/day5_benchmark_results.md` |

*Dates and artifact links will be populated as each session is completed.*

---

### Phase 2 — GPU DataFrames with RAPIDS cuDF
*(Begins Week 2 — pending Phase 1 completion)*

---

### Phase 3 — Distributed Spark with RAPIDS Accelerator
*(Begins Week 3)*

---

## 📁 Repository Structure

```
dgx-financial-spark-ml/
├── week1_phase1_init/          # Phase 1: DGX setup, CUDA, Docker, RAPIDS
├── week2_phase2_cudf/          # Phase 2: cuDF on Massive.com financial data
├── week3_phase3_spark/         # Phase 3: Spark + RAPIDS Accelerator
├── week4_phase4_features/      # Phase 4: GPU feature engineering
├── week5_phase5_ml/            # Phase 5: XGBoost / cuML model training
└── assets/
    └── logs/                   # Benchmark outputs and diagnostic logs
```

---

## 🛑 Data Notice

Raw dataset files from [Massive.com](https://massive.com) are excluded from this repository via `.gitignore` due to file size constraints and licensing restrictions. All scripts are engineered to run against a local `/data/` directory. See individual week READMEs for the expected directory layout.

---

## 📚 Key References

- [NVIDIA DGX Documentation](https://docs.nvidia.com/dgx/)
- [RAPIDS Documentation](https://docs.rapids.ai)
- [NVIDIA RAPIDS Accelerator for Apache Spark](https://nvidia.github.io/spark-rapids/)
- [NGC Container Catalog — RAPIDS](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/rapidsai/containers/base)
- [CUDA Samples GitHub](https://github.com/NVIDIA/cuda-samples)
- [RAPIDS Example Notebooks](https://github.com/rapidsai/notebooks)
