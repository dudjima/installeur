set-location "c:\"
If (-not (Test-Path "temp")) {New-Item -ItemType Directory -Name "temp"}
If (-not (Test-Path "Pyxvital")) { New-Item -ItemType Directory -Name "Pyxvital" }
If (-not (Test-Path "VZLan")) { New-Item -ItemType Directory -Name "VZLan" }
If (-not (Test-Path "PyxLan")) { New-Item -ItemType Directory -Name "PyxLan" }
set-location "C:\Program Files (x86)\"
If (-not (Test-Path "Comunica SAS")) { New-Item -ItemType Directory -Name "Comunica SAS" }
If (-not (Test-Path "santesocial")) { New-Item -ItemType Directory -Name "santesocial" }
set-location "C:\Program Files\"
If (-not (Test-Path "santesocial")) { New-Item -ItemType Directory -Name "santesocial" }
Start-Sleep -s 10