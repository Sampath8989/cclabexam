# Experiment 08: Hadoop 2.7.3 Single-Node Cluster & WordCount MapReduce

## 1. Experiment Overview
- **Title**: Install Hadoop single node cluster and run simple applications like WordCount.
- **Primary Source**: Lab Manual Section *EX NO.: 8* (Pages 51–58).
- **Aim**: To install and configure an Apache Hadoop 2.7.3 pseudo-distributed single-node cluster on Linux (or Ubuntu VM), configure core XML descriptors (`core-site.xml`, `hdfs-site.xml`, `mapred-site.xml`, `yarn-site.xml`), format the HDFS NameNode, launch HDFS and YARN daemons, verify daemon processes with `jps`, view the NameNode web UI at `http://localhost:50070`, and execute a MapReduce WordCount job.

---

## 2. Required Software & Specifications

| Software / Component | Exact Version | Filename | Download Source / URL | Size (Bytes) | SHA256 Checksum |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Apache Hadoop Package** | 2.7.3 | `hadoop-2.7.3.tar.gz` | [Apache Official Archive](https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz) | 214,092,195 | `D489DF3808244B906EB38F4D081BA49E50C4603DB03EFD5E594A1E98B09259C2` |
| **Java Development Kit** | 8u412 (Adoptium) / 8u101 | `OpenJDK8U-jdk_x64_linux.tar.gz` | [Adoptium Temurin 8 Archive](https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u412-b08/OpenJDK8U-jdk_x64_linux_hotspot_8u412b08.tar.gz) | ~100 MB | Verified OpenJDK 8 Distribution |
| **Oracle JDK 8u101 (Legacy)** | 8u101 | `jdk-8u101-linux-i586.tar.gz` | [Oracle Java SE Archive](https://www.oracle.com/java/technologies/downloads/archive/) | ~180 MB | Historical (Requires Oracle Account) |
| **Hadoop XML Configurations** | 2.7.3 | `config/` directory | Included in repository | - | `core-site`, `hdfs-site`, `mapred-site`, `yarn-site`, `hadoop-env.sh`, `slaves` |
| **WordCount MapReduce Source**| 1.0 | `src/WordCount.java` | Included in repository | - | Complete MapReduce application |
| **Sample Dataset** | 1.0 | `data/input.txt` | Included in repository | - | Sample input for MapReduce |

---

## 3. Discontinuation & Compatibility Analysis
- **Hadoop 2.7.3**: Apache Hadoop 2.x is officially superseded by Hadoop 3.x, but 2.7.3 is fully preserved on the official Apache Software Foundation archive (`archive.apache.org`).
- **Java Compatibility Constraint**: Hadoop 2.7.3 **STRICTLY requires Java 7 or Java 8**. Running Hadoop 2.7.3 with Java 11, 17, or 21 causes fatal JVM crashes and reflection failures (`Unrecognized VM option 'CMSClassUnloadingEnabled'`). Always use JDK 8.
- **Offline Cluster Operation**: Once downloaded and extracted, the entire pseudo-distributed cluster and MapReduce engine run 100% locally and offline without external network communication.

---

## 4. Step-by-Step Setup Sequence (From Lab Manual)

### Step 1: Extract Java 8 & Hadoop 2.7.3
```bash
# In your home or lab directory:
tar -xvf jdk-8u*-linux-*.tar.gz
tar -xvf hadoop-2.7.3.tar.gz
```

### Step 2: Configure Environment Variables in `~/.bashrc`
Add the following lines to the end of `~/.bashrc`:
```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64   # or path to extracted JDK 8
export HADOOP_HOME=/home/hadoop/hadoop-2.7.3
export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
```
Apply the changes:
```bash
source ~/.bashrc
java -version
hadoop version
```

### Step 3: Copy Pre-Configured XML Files
Copy all XML configuration files from `EXP08_HADOOP/config/` into `$HADOOP_HOME/etc/hadoop/`:
```bash
cp config/* $HADOOP_HOME/etc/hadoop/
```
Included configurations:
- `core-site.xml`: Defines HDFS default URI `hdfs://localhost:9000`
- `hdfs-site.xml`: Sets replication factor to `1` and defines local metadata storage directories
- `mapred-site.xml`: Sets framework to `yarn`
- `yarn-site.xml`: Enables MapReduce shuffle service
- `hadoop-env.sh`: Exports `JAVA_HOME`
- `slaves`: Specifies `localhost`

### Step 4: Format the HDFS NameNode
```bash
cd $HADOOP_HOME
bin/hdfs namenode -format
```
*(Verify output ends with: `Storage directory ... has been successfully formatted`)*

### Step 5: Start Hadoop Daemons
```bash
# Start HDFS (NameNode, DataNode, SecondaryNameNode)
sbin/start-dfs.sh

# Start YARN (ResourceManager, NodeManager)
sbin/start-yarn.sh
```
*(Alternatively: `sbin/start-all.sh`)*

### Step 6: Verify Active Daemons with `jps`
Run:
```bash
jps
```
Expected output (all 5 core daemons present):
```
12345 NameNode
12456 DataNode
12567 SecondaryNameNode
12678 ResourceManager
12789 NodeManager
12890 Jps
```

### Step 7: Access Web Dashboards
- **HDFS NameNode UI**: Open `http://localhost:50070`
- **YARN ResourceManager UI**: Open `http://localhost:8088`

### Step 8: Run MapReduce WordCount
```bash
# Create HDFS input directory
hdfs dfs -mkdir -p /input

# Upload sample text file
hdfs dfs -put data/input.txt /input/

# Run built-in Hadoop MapReduce WordCount example
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /input /output

# View results from HDFS
hdfs dfs -cat /output/part-r-00000
```
Expected output:
```
cloud       2
computing   2
experiment  1
hadoop      3
hello       2
hdfs        1
laboratory  1
mapreduce   2
node        1
single      1
word        1
yarn        1
```

---

## 5. Modern Windows PC Notes
If running Hadoop natively on Windows (outside Linux VM):
Hadoop requires Windows native binary helpers (`winutils.exe` and `hadoop.dll`) in `$HADOOP_HOME\bin` to interact with Windows NTFS file permissions. It is strongly recommended to run Hadoop 2.7.3 inside the **EXP02 Ubuntu VM** or **WSL2** as specified in the lab manual.
