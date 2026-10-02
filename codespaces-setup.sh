#!/usr/bin/env bash
set -euo pipefail

# Expose the Jupyter applications already installed in Sage's Python environment.
# Codespaces' JupyterLab editor starts these applications from the user's PATH.
sage -python - <<'PY'
import sysconfig
from pathlib import Path

scripts = Path(sysconfig.get_path("scripts"))
user_bin = Path.home() / ".local" / "bin"
user_bin.mkdir(parents=True, exist_ok=True)
for name in ("jupyter", "jupyter-lab", "jupyter-notebook"):
    source = scripts / name
    target = user_bin / name
    if not source.is_file():
        raise RuntimeError(f"Missing Sage Jupyter application: {source}")
    if source.resolve() != target.resolve():
        if target.is_symlink():
            target.unlink()
        elif target.exists():
            raise RuntimeError(f"Refusing to replace existing application: {target}")
        target.symlink_to(source)
print("SageMath Jupyter applications are available for Codespaces.")
PY

# Check the real workspace copy, including compilation of the CAPD driver.
sage -python verify_runtime.py
