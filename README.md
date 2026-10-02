# Einstein metric on CP⁴: live certification

This is a presentation demo of the n = 4 calculation from
*Inhomogeneous Einstein metrics on complex projective spaces*, by
Gonzalo Cao-Labora and Alberto Rodríguez-Vázquez.

[Open the notebook and run each cell yourself](https://mybinder.org/v2/gh/arv95gz/einstein-cp4-demo/main?urlpath=lab%2Ftree%2Fdemo.ipynb)

Opening that link launches a temporary Binder computer and opens JupyterLab.
Run the notebook from top to bottom with Shift+Enter using the SageMath kernel.
Each of the eight definition cells is followed by an example with visible output:
symbolic coefficients, Catalan bounds, series enclosures, parameter derivatives,
ODE propagation, the matching error, and the final certification.

The examples perform real calculations. There are no saved certification outputs.
Examples 6–8 include slower ODE integrations; Example 8 clears the ODE cache before
the full certification. No paid subscription is required.

[Run all cells automatically with Voilà](https://mybinder.org/v2/gh/arv95gz/einstein-cp4-demo/main?urlpath=voila%2Frender%2Fdemo.ipynb)
is also available, but runs the examples as well as the final calculation.

## Status

The original online build and full n = 4 certification succeeded using SageMath
10.7 and CAPD v6.0.0. That certification took 100.6 seconds, excluding setup.
The new presentation examples add extra calculations, so a complete run takes
longer. Rehearse the cell-by-cell version before the talk; Binder timings vary.

## Scientific code and modifications

The mathematical code in original cells 1–5 and 7–8 is unchanged. Cell 6 only
changes the compiler/library configuration for Linux and assigns unique
temporary filenames to each kernel. The final call uses the exact n = 4
parameters from original cell 9, with a cleared ODE cache. Kernel metadata and
presentation text are adapted for the web page. The presentation examples call
the same scientific functions; readiness messages are appended to definition
cells. The build check selects those cells by tags and does not run the examples.

The original notebook is available with the paper's TeX source:
https://arxiv.org/abs/2608.16880

Original notebook SHA-256: `f09cc0a217b4a6932e6b7f3339d69537a7529dcd3b1546162ed3f3352b3b444b`

The software setup selects SageMath 10.7, CAPD v6.0.0 with multiprecision enabled,
and Voilà 0.5.8. The original notebook did not specify a CAPD release; this
selection was checked by the successful full live certification described above.
A successful build alone is not a certification.

## During a presentation

The first launch builds the environment and may take a long time. Test it well
before the talk. Later launches may still need to start or download an image.
Binder provides 1 GB guaranteed RAM, at most 2 GB, and can close idle sessions.
It is a free community service, so startup and availability are not guaranteed.

Once a test has succeeded, the slide can link to the demo above. Keep a tested
session available during the talk. A fresh render of `voila/render/demo.ipynb`
in that session starts a fresh calculation; saved output is never presented as
a new run. Do not enable Voilà kernel preheating.

## Reproduce with Docker

```sh
docker build -t einstein-cp4-demo .
docker run --rm -p 8888:8888 einstein-cp4-demo
```

Use the Jupyter URL printed in the terminal, then open `lab/tree/demo.ipynb`
within that session. The server preserves Jupyter's token authentication.

## Hosting references

- https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
- https://mybinder.readthedocs.io/en/latest/about/user-guidelines.html
- https://voila.readthedocs.io/en/stable/deploy.html
- https://github.com/CAPDGroup/CAPD/releases/tag/v6.0.0
