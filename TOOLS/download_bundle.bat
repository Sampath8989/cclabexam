@echo off
REM ==============================================================================
REM Cloud Computing Laboratory - Package Downloader Batch Launcher
REM ==============================================================================
setlocal EnableDelayedExpansion

set SCRIPT_DIR=%~dp0
set ROOT_DIR=%SCRIPT_DIR%..

echo ==============================================================================
echo Cloud Computing Lab - Automated Package Downloader
echo Root Directory: %ROOT_DIR%
echo ==============================================================================

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%download_bundle.ps1" %*

echo.
echo Process finished. Press any key to exit.
pause >nul
