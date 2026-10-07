@echo off
setlocal
echo ==============================================================================
echo Experiment 05: CloudSim Custom Scheduling Algorithm Simulation
echo ==============================================================================

rem Determine script directory
set "BASE_DIR=%~dp0"
set "JAR_PATH=%BASE_DIR%cloudsim-3.0.3\jars\cloudsim-3.0.3.jar"
set "SRC_DIR=%BASE_DIR%src"
set "BIN_DIR=%BASE_DIR%bin"

if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"

echo [*] Checking Java installation...
java -version 2>nul
if %errorlevel% neq 0 (
    echo [!] Java is not found in PATH. Please install Java JDK 8 and add to PATH.
    pause
    exit /b 1
)

echo [*] Compiling Custom Schedulers and Simulation Demo...
javac -cp "%JAR_PATH%" -d "%BIN_DIR%" "%SRC_DIR%\org\cloudbus\cloudsim\CloudletSchedulerPriority.java" "%SRC_DIR%\org\cloudbus\cloudsim\CloudletSchedulerSJF.java" "%SRC_DIR%\CustomSchedulingSimulationDemo.java"

if %errorlevel% neq 0 (
    echo [!] Compilation failed.
    pause
    exit /b %errorlevel%
)

echo [*] Running CustomSchedulingSimulationDemo...
java -cp "%BIN_DIR%;%JAR_PATH%" CustomSchedulingSimulationDemo

echo ==============================================================================
echo Simulation execution completed.
echo ==============================================================================
pause
