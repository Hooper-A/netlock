# Needed to enable scripts
Set-ExecutionPolicy Unrestricted -Scope process -Force

# Remove previous build outputs
Remove-Item "epb-setup.exe" -Force -Recurse -ErrorAction Ignore
Remove-Item "out" -Force -Recurse -ErrorAction Ignore
Remove-Item "backend_out" -Force -Recurse -ErrorAction Ignore
Remove-Item "backend_src\build\" -Force -Recurse -ErrorAction Ignore
Remove-Item "backend_src/dist/" -Force -Recurse -ErrorAction Ignore
Remove-Item "ackend_src/__pycache__/" -Force -Recurse -ErrorAction Ignore
Remove-Item "ackend_src/*.spec" -Force -Recurse -ErrorAction Ignore

# Build python part
.\.venv\Scripts\activate.ps1
pyinstaller backend_src/pytest1.py --distpath backend_out --workpath backend_src/build --specpath backend_src/ --onefile
deactivate

# Build it
npm run package

# Start the output for testing
# Start-Process -FilePath .\out\electron-python-base-win32-ia32\NetLock.exe

# Build the installer
& 'C:\Program Files (x86)\Inno Setup 6\ISCC.exe' /q .\scripts\inno_builder_script.iss
cp .\scripts\Output\NetLock.exe ./netlock-setup.exe
Remove-Item "scripts\Output" -Force -Recurse -ErrorAction Ignore

# Run the installer
Start-Process -FilePath .\netlock-setup.exe
