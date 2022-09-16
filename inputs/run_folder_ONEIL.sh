#!/bin/bash

echo "NAME OF THE IONIC LIQUID "
#DECIDIR SE É MELHOR PARTIRE DE UM PDB JÁ PROCESSADO NO PDB2GMX
read il
mkdir $il
cd $il

workdir=/home/viniciusp/doutorado 
pdbdir=/home/viniciusp/VSIL/PDB

echo "Name of the anion.pdb"
read an1

echo " Name of the cation.pdb"
read cat1

for run in 0.50 1.00 1.50 2.00 2.50 3.00 ; do
  for i in {00..20}; do

    mkdir -p "$run"
    mkdir -p "$run"/"$i"

    \cp -f $workdir/input_files/files_simul/top/topola_one.top        $workdir/"$il"/"$run"/"$i"/topola.top
    \cp -f $workdir/input_files/files_simul/run_itp_vmd/*                $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/prot_pdb/ubq.pdb             $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/mdp/*                        $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/julia/*                      $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/gmd/*                        $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_gen_one.jl                                    $workdir/"$il"/"$run"/"$i"/input_gen.jl
    \cp -f $pdbdir/"$an1"_VSIL.pdb                                       $workdir/"$il"/"$run"/"$i"/
    \cp -f $pdbdir/"$cat1"_VSIL.pdb                                      $workdir/"$il"/"$run"/"$i"/
    \cp -f $pdbdir/WATER.pdb                                             $workdir/"$il"/"$run"/"$i"/
 
  done
done   
