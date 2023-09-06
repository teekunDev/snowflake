#!/usr/bin/env bash

pkill -f "wnp.py"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
python3 $SCRIPT_DIR/py/wnp.py & disown