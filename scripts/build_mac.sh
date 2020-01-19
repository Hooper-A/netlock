#!/bin/bash
# Cleanup previous build
rm -rf out/
rm -rf backend_src/build/ 
rm -rf backend_src/dist/
rm -rf backend_src/__pycache__/
rm -rf backend_src/*.spec
rm -rf backend_out/

# Build python stuff
source .venv/bin/activate
pyinstaller backend_src/pytest1.py --distpath backend_out --workpath backend_src/build --specpath backend_src/ --onefile 
deactivate

# Build and package
npm run make

# Open app
open out/electron-python-base-darwin-x64/electron-python-base.app/
