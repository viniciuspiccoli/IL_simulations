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

echo "Name of the anion2.pdb"
read an2

#echo " Name of the cation2.pdb"
#read cat2

for run in 0.50 1.00 1.50 2.00 2.50 3.00 ; do
  for i in {00..04}; do

    mkdir -p "$run"
    mkdir -p "$run"/"$i"

    #\cp -f $workdir/input_files/files_simul/top/topola_twocat.top        $workdir/"$il"/"$run"/"$i"/topola.top

    \cp -f $workdir/input_files/four_ions/topola.top                     $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/run_itp_vmd/*                $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/four_ions/*.mdp                          $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/input_files/files_simul/julia/*                      $workdir/"$il"/"$run"/"$i"/
    \cp -f $workdir/four_ions/input_gen_sol.jl                           $workdir/"$il"/"$run"/"$i"/input_gen.jl
    \cp -f $pdbdir/"$an1"_VSIL.pdb                                       $workdir/"$il"/"$run"/"$i"/
    \cp -f $pdbdir/"$cat1"_VSIL.pdb                                      $workdir/"$il"/"$run"/"$i"/
    \cp -f $pdbdir/"$an2"_VSIL.pdb                                       $workdir/"$il"/"$run"/"$i"/
#   \cp -f $pdbdir/"$cat2".pdb                                           $workdir/"$il"/"$run"/"$i"/
    \cp -f $pdbdir/WATER.pdb                                             $workdir/"$il"/"$run"/"$i"/
 
  done
done   
