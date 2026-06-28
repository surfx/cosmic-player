#!/bin/bash
clear

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
"$DIR/kill.sh"

LOG_DIR="$DIR/logs"
mkdir -p "$LOG_DIR"
rm -f "$LOG_DIR"/*
LOG_FILE="$LOG_DIR/debug-$(date +%Y%m%d-%H%M%S).log"

cd "$DIR/.."
RUST_LOG=warn,cosmic_player=debug cargo run -- "$@" --foreground > "$LOG_FILE" 2>&1
