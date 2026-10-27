# FloodSight Backend Launcher (PowerShell)
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Starting FloodSight Backend API (FastAPI) - TeamPhoenix" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$env:PYTHONPATH = "backend"
if (Test-Path "backend\venv\Scripts\python.exe") {
    & ".\backend\venv\Scripts\python.exe" -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
} else {
    Write-Host "[ERROR] backend\venv not found. Run: python -m venv backend\venv and pip install -r backend\requirements.txt" -ForegroundColor Red
}
