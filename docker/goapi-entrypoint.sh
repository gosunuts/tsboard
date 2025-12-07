#!/bin/sh
set -e

if [ "${RUN_MIGRATIONS:-false}" = "true" ]; then
  echo "[goapi] applying migrations (./goapi-linux-x86 update)..."
  ./goapi-linux-x86 update
fi

echo "[goapi] starting server on port ${GOAPI_PORT:-3003}"
exec ./goapi-linux-x86
