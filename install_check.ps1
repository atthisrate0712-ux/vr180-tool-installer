# install_check.ps1
$ErrorActionPreference = "Stop"

$ROOT = "C:\VR180_Tool"
$VENV = Join-Path $ROOT "venv"
$PY   = Join-Path $VENV "Scripts\python.exe"
$SCRIPT = Join-Path $ROOT "make_vr180.py"
$DEPTH_DIR = Join-Path $ROOT "Depth-Anything-V2-main"
$CKPT_DIR  = Join-Path $DEPTH_DIR "checkpoints"

Write-Host "===================================="
Write-Host "Install Check: VR180 Pipeline"
Write-Host "===================================="

function Ok($msg){ Write-Host "[OK]  $msg" -ForegroundColor Green }
function Ng($msg){ Write-Host "[NG]  $msg" -ForegroundColor Red }

# 1) Root
if (Test-Path $ROOT) { Ok "Root folder exists" } else { Ng "Root folder not found"; exit 1 }

# 2) Script
if (Test-Path $SCRIPT) { Ok "make_vr180.py found" } else { Ng "make_vr180.py not found"; exit 1 }

# 3) venv
if (Test-Path $PY) { Ok "venv python found" } else { Ng "venv not found"; exit 1 }

# 4) ffmpeg
$ff = Get-Command ffmpeg -ErrorAction SilentlyContinue
if ($ff) { Ok "ffmpeg found" } else { Ng "ffmpeg NOT found in PATH"; exit 1 }

# 5) GPU
$nv = Get-Command nvidia-smi -ErrorAction SilentlyContinue
if ($nv) { Ok "nvidia-smi found (GPU OK)" } else { Write-Host "[WARN] nvidia-smi not found" -ForegroundColor Yellow }

# 6) Depth-Anything
if (Test-Path $DEPTH_DIR) { Ok "Depth-Anything folder found" } else { Ng "Depth-Anything folder missing"; exit 1 }
if (Test-Path $CKPT_DIR) { Ok "checkpoints folder found" } else { Ng "checkpoints folder missing"; exit 1 }

Write-Host "`n===================================="
Ok "All checks passed!"
Write-Host "===================================="