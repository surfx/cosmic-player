#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
"$DIR/kill.sh"
cd "$DIR/.."

if [[ "$1" == "--release" ]]; then
    echo "Building in RELEASE mode..."
    cargo build --release
else
    echo "Building in DEBUG mode... (Hint: use --release for an optimized build)"
    cargo build
fi
