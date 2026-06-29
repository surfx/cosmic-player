#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# "$DIR/kill.sh"
cd "$DIR/.."

# Prioritize Release binary for better performance
if [ -f "./target/release/cosmic-player" ]; then
    ./target/release/cosmic-player "$@"
elif [ -f "./target/debug/cosmic-player" ]; then
    ./target/debug/cosmic-player "$@"
else
    cargo run --release -- "$@"
fi
