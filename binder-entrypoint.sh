#!/bin/sh
set -eu
# Binder passes the port, authentication and session URL as arguments.
# Sage's shell exposes the Jupyter installed in Sage's Python environment.
exec sage -sh -c 'exec "$@"' binder "$@"
