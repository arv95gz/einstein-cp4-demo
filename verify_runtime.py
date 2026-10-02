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
definition_cells = [cell for cell in notebook['cells']
                    if 'cap-definition' in cell.get('metadata', {}).get('tags', [])]
assert len(definition_cells) == 8, 'Expected the eight scientific definition cells'
for index, cell in enumerate(definition_cells, start=1):
    exec(compile(preparse(''.join(cell['source'])),
                 f'demo-definition-{index}', 'exec'), globals())
assert callable(krawczyk_check)
assert Path(DRIVER_BIN).is_file()
print('SageMath kernel and multiprecision CAPD driver compile successfully.')
print('The full n=4 certification still requires a live execution test.')
