# day4_cudf_smoketest.py
import cudf, cupy as cp

print(f"cuDF version: {cudf.__version__}")

n_rows = 10_000_000
df = cudf.DataFrame({
    "price":    cp.random.uniform(100, 500,     n_rows, dtype=cp.float32),
    "volume":   cp.random.randint(100, 10000,   n_rows),
    "symbol":   cp.random.choice([0, 1, 2, 3, 4], n_rows)
    })

print(f"Shape: {df.shape} | GPU Memory: {df.memory_usage(deep=True).sum()/1e6:.1f} MB")

summary = df.groupby("symbol").agg(
            mean_price=("price","mean"),
            total_volume=("volume","sum"),
            count=("price","count")
            )

print(summary)
print("cuDF smoke test: PASS ✅")

