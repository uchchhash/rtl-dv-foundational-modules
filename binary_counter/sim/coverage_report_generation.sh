#!/bin/bash


iccr
set_merge -union
merge ./cov_work/scope/* -output merged_cov

load_test ./cov_work/scope/merged_cov
report_html *



