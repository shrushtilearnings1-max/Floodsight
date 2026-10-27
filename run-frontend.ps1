# FloodSight Frontend Launcher (PowerShell)
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Starting FloodSight Frontend (Vite + React) - TeamPhoenix" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

Set-Location "$PSScriptRoot\frontend"
& npm.cmd run dev
