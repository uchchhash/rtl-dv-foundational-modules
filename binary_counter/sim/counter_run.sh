#!/bin/bash

Half_Period=""
mode=""
test_name=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -Half_Period) Half_Period="$2"; shift ;;
        -mode) mode="$2" ; shift;;
        -test_case) test_case="$2"; shift;;
    esac
    shift
done
if [ "$mode" == "Gui" ]; then
        irun -access +rwc -timescale 1ns/1ps +Half_Period=$Half_Period -f filelist.f +$test_name -gui
elif [ "$mode" == "Coverage" ]; then
        irun -access +rwc -timescale 1ns/1ps +Half_Period=$Half_Period  -coverage all -covtest $test_name -f filelist.f +$test_name
else [ "$mode" == "Batch" ]; 
        irun -access +rwc -timescale 1ns/1ps +Half_Period=$Half_Period  -f filelist.f +$test_name
fi  

