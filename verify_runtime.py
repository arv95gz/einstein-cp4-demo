"""Build-time compatibility check; this does NOT certify the n=4 case."""
import json
import os
from pathlib import Path
from sage.all import *
from sage.repl.preparse import preparse
from jupyter_client.kernelspec import KernelSpecManager

notebook = json.loads(Path('demo.ipynb').read_text(encoding='utf-8'))
assert os.getuid() == 1000
specs = KernelSpecManager().find_kernel_specs()
assert 'sagemath' in specs, f'SageMath kernel not registered: {specs}'
for index in range(1, 9):
    exec(compile(preparse(''.join(notebook['cells'][index]['source'])),
                 f'demo-cell-{index}', 'exec'), globals())
assert callable(krawczyk_check)
assert Path(DRIVER_BIN).is_file()
print('SageMath kernel and multiprecision CAPD driver compile successfully.')
print('The full n=4 certification still requires a live execution test.')
