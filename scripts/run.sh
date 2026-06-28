#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# "$DIR/kill.sh"
cd "$DIR/.."
if [ -f "./target/debug/cosmic-player" ]; then
    ./target/debug/cosmic-player "$@"
else
    cargo run -- "$@"
fi
