#!/bin/bash

# go through all arugments and print them all

COUNT=1

for ARG in "$@"; do
#          "$*" 不行
   echo "$COUNT. arugment: $ARG"
   let COUNT++
done
