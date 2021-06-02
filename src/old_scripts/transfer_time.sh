#!/bin/bash

  echo "Nome da pasta onde estão os arquivos .dat do IL - caixa alta"
  #DECIDIR SE É MELHOR PARTIRE DE UM PDB JÁ PROCESSADO NO PDB2GMX
  read il
  

  work_dir=/home/viniciusp/doutorado
  
  
  echo "Nome da pasta de il que quer copiar"
  read il_a
  mkdir $il_a
  cd $il_a
  
  for run in 0.50 1.00 1.50 2.00 2.50 3.00 ; do
    for i in {00..20}; do
      mkdir -p "$run"
      mkdir -p "$run"/"$i"
  
    \cp -f $work_dir/"$il"/"$run"/"$i"/simul.pdb                    $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/processed.xtc                $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/processed.gro                $work_dir/"$il_a"/"$run"/"$i"

    done
  done
  


