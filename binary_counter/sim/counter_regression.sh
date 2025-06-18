#!/bin/bash

chmod +x ./counter_run.sh

while read -r line
do
     filename=$(basename "$line")
     test_name="${filename%.*}"
    ./counter_run.sh -mode Coverage -test_name $test_name -half_Period 10
done <filelist.f





