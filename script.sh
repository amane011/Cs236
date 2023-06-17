#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: ./run.sh <Dataset folder path> <Jar file path> <Output folder path>"
    exit 1
fi

DATASET_PATH=$1
JAR_PATH=$2
OUTPUT_PATH=$3

cd /opt/homebrew/Cellar/hadoop/3.3.4/sbin 



hadoop fs -put $DATASET_PATH /data

hadoop jar $JAR_PATH/MapReduce-1.0-SNAPSHOT.jar org.example.Driver /data /tmp_op

hadoop jar $JAR_PATH/TopMonth-1.0-SNAPSHOT.jar org.example.Driver /tmp_op /myOutput

hadoop fs -get /myOutput $OUTPUT_PATH
hadoop fs -rm -r /tmp_op
hadoop fs -rm -r /data
hadoop fs -rm -r /myOutput


echo "Script completed successfully."
