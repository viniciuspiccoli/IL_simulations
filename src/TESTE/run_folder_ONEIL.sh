#!/bin/bash

echo "NAME OF THE IONIC LIQUID "
#DECIDIR SE É MELHOR PARTIRE DE UM PDB JÁ PROCESSADO NO PDB2GMX
read il
mkdir $il
cd $il

for run in 0.50 1.00 1.50 2.00 2.50 3.00 ; do
  for i in {00..20}; do

    mkdir -p "$run"
    mkdir -p "$run"/"$i"
 
  done
done   
