#!/bin/bash
set -e
echo "=============================================================================="
echo "Experiment 05: CloudSim Custom Scheduling Algorithm Simulation"
echo "=============================================================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JAR_PATH="$SCRIPT_DIR/cloudsim-3.0.3/jars/cloudsim-3.0.3.jar"
SRC_DIR="$SCRIPT_DIR/src"
BIN_DIR="$SCRIPT_DIR/bin"

mkdir -p "$BIN_DIR"

echo "[*] Compiling Custom Schedulers and Simulation Demo..."
javac -cp "$JAR_PATH" -d "$BIN_DIR" \
    "$SRC_DIR/org/cloudbus/cloudsim/CloudletSchedulerPriority.java" \
    "$SRC_DIR/org/cloudbus/cloudsim/CloudletSchedulerSJF.java" \
    "$SRC_DIR/CustomSchedulingSimulationDemo.java"

echo "[*] Running CustomSchedulingSimulationDemo..."
java -cp "$BIN_DIR:$JAR_PATH" CustomSchedulingSimulationDemo

echo "=============================================================================="
echo "Simulation execution completed."
echo "=============================================================================="
