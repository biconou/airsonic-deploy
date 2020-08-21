#!/bin/bash

export BASE_DIR=`pwd`
export AIRSONIC_DIR=${BASE_DIR}/run

export JAVA_HOME=/mnt/DATA/software/java/jdk1.8.0_251
export PATH=${PATH}:${JAVA_HOME}/bin

export AIRSONIC_PORT=4040
export CONTEXT_PATH=airsonic

export JVM_HEAP=256m
