#!/bin/bash
clear

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
"$DIR/kill.sh"

# Check if user wants release mode
MODE_FLAG=""
if [[ "$1" == "--release" ]]; then
    MODE_FLAG="--release"
    shift
else
    echo "Tip: Run './scripts/debug.sh --release' for maximum performance."
fi

LOG_DIR="$DIR/logs"
mkdir -p "$LOG_DIR"
rm -f "$LOG_DIR"/*
LOG_FILE="$LOG_DIR/debug-$(date +%Y%m%d-%H%M%S).log"

cd "$DIR/.."
echo "Building and Running cosmic-player..."
RUST_LOG=warn,cosmic_player=debug cargo run $MODE_FLAG -- "$@" --foreground > "$LOG_FILE" 2>&1
