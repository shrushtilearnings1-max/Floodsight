@echo off
echo ============================================================
echo   Running FloodSight Full Test Suite - TeamPhoenix
echo ============================================================
cd /d "%~dp0"

echo.
echo [1/2] Running Backend Tests (pytest)...
set PYTHONPATH=backend
.\backend\venv\Scripts\python.exe -m pytest backend
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Backend tests failed!
    exit /b %ERRORLEVEL%
)

echo.
echo [2/2] Running Frontend Tests (vitest)...
cd frontend
call npm.cmd test
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Frontend tests failed!
    exit /b %ERRORLEVEL%
)

echo.
echo ============================================================
echo   ALL TESTS PASSED SUCCESSFULLY!
echo ============================================================
