#!/bin/zsh

set -u

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR" || exit 1

if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "Node.js or npm was not found. Please install Node.js first:"
  echo "https://nodejs.org/"
  echo ""
  read "?Press Enter to close..."
  exit 1
fi

# `python3 -m pip install --user xiaohongshu-cli` installs xhs outside the
# non-interactive shell PATH used by this launcher. Pass its absolute path to
# the local server when present so searches work without manual PATH setup.
PYTHON_USER_BIN="$(python3 -c 'import site; print(site.USER_BASE)' 2>/dev/null)/bin"
if [[ -x "$PYTHON_USER_BIN/xhs" ]]; then
  export XHS_CLI_COMMAND="$PYTHON_USER_BIN/xhs"
fi

node scripts/start-fixed.mjs

echo ""
read "?Server stopped. Press Enter to close..."
