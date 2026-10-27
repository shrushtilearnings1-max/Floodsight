@echo off
echo ============================================================
echo   Starting FloodSight Backend API (FastAPI) - TeamPhoenix
echo ============================================================
cd /d "%~dp0"
if not exist "backend\venv\Scripts\python.exe" (
    echo [ERROR] Virtual environment not found at backend\venv
    echo Run: python -m venv backend\venv ^&^& .\backend\venv\Scripts\pip install -r backend\requirements.txt
    pause
    exit /b 1
)
set PYTHONPATH=backend
.\backend\venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
