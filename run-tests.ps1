# FloodSight Full Test Suite (PowerShell)
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Running FloodSight Full Test Suite - TeamPhoenix" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$env:PYTHONPATH = "backend"
Write-Host "`n[1/2] Running Backend Tests (pytest)..." -ForegroundColor Yellow
& ".\backend\venv\Scripts\python.exe" -m pytest backend
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Backend tests failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "`n[2/2] Running Frontend Tests (vitest)..." -ForegroundColor Yellow
Set-Location "frontend"
& npm.cmd test
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Frontend tests failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}
Set-Location ".."

Write-Host "`n============================================================" -ForegroundColor Green
Write-Host "  ALL TESTS PASSED SUCCESSFULLY! (20 Backend, 19 Frontend)" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
