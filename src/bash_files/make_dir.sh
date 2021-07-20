#!/bin/bash

echo  "NAME OF THE IONIC LIQUID"
read  il
mkdir $il
cd    $il

workdir=/home/viniciusp/doutorado 
pdbdir=/home/viniciusp/VSIL/PDB

for run in 0.50 1.00 1.50 2.00 2.50 3.00 ; do
  for i in {00..20}; do

    mkdir -p "$run"
    mkdir -p "$run"/"$i"

    \cp -f $workdir/input_files/files_simul/mdp/*                        $workdir/"$il"/"$run"/"$i"/
 
  done
done   
