FROM sagemath/sagemath:10.7

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates git cmake g++ libgmp-dev libmpfr-dev \
    && rm -rf /var/lib/apt/lists/*

# Pin a CAPD release, rather than following a changing development branch.
RUN git clone --depth 1 --branch v6.0.0 https://github.com/CAPDGroup/CAPD.git /opt/capd-source \
    && cmake -S /opt/capd-source -B /opt/capd-source/build \
       -DCMAKE_INSTALL_PREFIX=/opt/capd \
       -DCMAKE_BUILD_TYPE=Release -DCAPD_ENABLE_MULTIPRECISION=ON \
       -DCAPD_BUILD_TESTS=OFF -DCAPD_BUILD_EXAMPLES=OFF \
    && cmake --build /opt/capd-source/build --parallel 2 \
    && cmake --install /opt/capd-source/build

ENV CAPD_PREFIX=/opt/capd
ENV CAPD_CONFIG=/opt/capd/bin/capd-config
ENV RP_CXX=/usr/bin/g++
ENV SAGE_NUM_THREADS=1
ENV OMP_NUM_THREADS=1
ENV OPENBLAS_NUM_THREADS=1

COPY binder-entrypoint.sh /usr/local/bin/binder-entrypoint
RUN chmod 755 /usr/local/bin/binder-entrypoint
USER sage
RUN test "$(id -u)" = 1000
RUN sage -pip install --no-cache-dir 'voila==0.5.8' 'notebook>=7,<8' 'jupyterlab>=4,<5' 'jupyterhub>=5,<6'

WORKDIR /home/sage
COPY --chown=sage:sage demo.ipynb README.md verify_runtime.py ./
COPY --chown=sage:sage jupyter_server_config.py ./.jupyter/jupyter_server_config.py
RUN sage -sh -c 'jupyter server extension enable voila --sys-prefix'
RUN sage -python verify_runtime.py

ENTRYPOINT ["/usr/local/bin/binder-entrypoint"]
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
