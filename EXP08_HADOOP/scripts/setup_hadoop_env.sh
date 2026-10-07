#!/bin/bash
# ==============================================================================
# Experiment 08: Hadoop 2.7.3 Single Node Cluster Setup & Runner
# Automates the configuration, NameNode formatting, daemon launch, and WordCount.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXP_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$EXP_DIR/config"

echo "[*] Step 1: Checking Java 8 installation..."
if ! command -v java &> /dev/null; then
    echo "[!] Java not found. Please install Java 8 (e.g., sudo apt-get install -y openjdk-8-jdk)."
    exit 1
fi

JAVA_VER=$(java -version 2>&1 | head -n 1)
echo "[+] Detected Java: $JAVA_VER"

echo "[*] Step 2: Locating Hadoop 2.7.3 installation directory..."
if [ -z "$HADOOP_HOME" ]; then
    if [ -d "$EXP_DIR/hadoop-2.7.3" ]; then
        export HADOOP_HOME="$EXP_DIR/hadoop-2.7.3"
    elif [ -d "/usr/local/hadoop" ]; then
        export HADOOP_HOME="/usr/local/hadoop"
    else
        echo "[!] HADOOP_HOME not set and hadoop-2.7.3 not found in $EXP_DIR."
        echo "[!] Extract hadoop-2.7.3.tar.gz into $EXP_DIR or set HADOOP_HOME."
        exit 1
    fi
fi

echo "[+] Using HADOOP_HOME=$HADOOP_HOME"
export PATH="$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH"

echo "[*] Step 3: Copying lab configuration files to $HADOOP_HOME/etc/hadoop/..."
cp "$CONFIG_DIR/core-site.xml" "$HADOOP_HOME/etc/hadoop/"
cp "$CONFIG_DIR/hdfs-site.xml" "$HADOOP_HOME/etc/hadoop/"
cp "$CONFIG_DIR/mapred-site.xml" "$HADOOP_HOME/etc/hadoop/"
cp "$CONFIG_DIR/yarn-site.xml" "$HADOOP_HOME/etc/hadoop/"
cp "$CONFIG_DIR/slaves" "$HADOOP_HOME/etc/hadoop/"

echo "[*] Step 4: Formatting NameNode (if not already formatted)..."
if [ ! -d "/home/hadoop/hadoopdata/hdfs/namenode" ]; then
    "$HADOOP_HOME/bin/hdfs" namenode -format -force
fi

echo "[*] Step 5: Starting HDFS daemons (NameNode, DataNode)..."
"$HADOOP_HOME/sbin/start-dfs.sh"

echo "[*] Step 6: Starting YARN daemons (ResourceManager, NodeManager)..."
"$HADOOP_HOME/sbin/start-yarn.sh"

echo "[*] Step 7: Verifying running daemons with jps..."
jps

echo "=============================================================================="
echo "Hadoop daemons are up!"
echo "NameNode Web UI:       http://localhost:50070"
echo "ResourceManager Web UI: http://localhost:8088"
echo "=============================================================================="
