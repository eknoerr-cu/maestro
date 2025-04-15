#!/bin/bash
set -e

echo "Starting AI Cyber Challenge multi-agent system with Voilà..."

pwd
ls -la
echo "Contents of src directory:"
ls -la src/

cd src

if [ -f "linear gui.ipynb" ]; then
    echo "Running with Voilà..."
    voila --no-browser --port=8866 --Voila.ip=0.0.0.0 --Voila.custom_display_url="http://localhost:8866/" "linear gui.ipynb"
else
    echo "Error: linear gui.ipynb not found in $(pwd)/src!"
    exit 1
fi