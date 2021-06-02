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
  
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_sol.dat                            $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NC.dat                             $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BF4.dat                            $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NO3.dat                            $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BMI.dat                            $work_dir/"$il_a"/"$run"/"$i"

    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_sol-GMD_ATOM_CONTRIB.dat           $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NC-GMD_ATOM_CONTRIB.dat            $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BF4-GMD_ATOM_CONTRIB.dat           $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NO3-GMD_ATOM_CONTRIB.dat           $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BMI-GMD_ATOM_CONTRIB.dat           $work_dir/"$il_a"/"$run"/"$i"

    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_sol-GMD_ATOM_SOLUTE_CONTRIB.dat    $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NC-GMD_ATOM_SOLUTE_CONTRIB.dat     $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BF4-GMD_ATOM_SOLUTE_CONTRIB.dat    $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_NO3-GMD_ATOM_SOLUTE_CONTRIB.dat    $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/gmd_BMI-GMD_ATOM_SOLUTE_CONTRIB.dat    $work_dir/"$il_a"/"$run"/"$i"
 
 
    # arquivos para outras análises   
 
   # \cp -f work_dir/"$il"/"$run"/"$i"/simul.dcd                    work_dir/"$il_a"/"$run"/"$i"  
    \cp -f $work_dir/"$il"/"$run"/"$i"/simul.pdb                    $work_dir/"$il_a"/"$run"/"$i"
#    \cp -f $work_dir/"$il"/"$run"/"$i"/md_prod.tpr                  $work_dir/"$il_a"/"$run"/"$i"
    \cp -f $work_dir/"$il"/"$run"/"$i"/md_prod.edr                  $work_dir/"$il_a"/"$run"/"$i"
#   # \cp -f $work_dir/"$il"/"$run"/"$i"/processed.xtc                $work_dir/"$il_a"/"$run"/"$i"
#    \cp -f $work_dir/"$il"/"$run"/"$i"/processed.gro                $work_dir/"$il_a"/"$run"/"$i"
#    \cp -f $work_dir/"$il"/"$run"/"$i"/simul.psf                    $work_dir/"$il_a"/"$run"/"$i"
#    \cp -f $work_dir/"$il"/"$run"/"$i"/topol.top                    $work_dir/"$il_a"/"$run"/"$i"
#    \cp -f $work_dir/"$il"/"$run"/"$i"/md_prod.cpt                   $work_dir/"$il_a"/"$run"/"$i"


#    \cp -f /home/viniciusp/mestrado/"$il"/"$run"/"$i"/md_prod.tpr  ~/mestrado/"$il_a"/"$run"/"$i"/md_prod.tpr  
#    \cp -f /home/viniciusp/mestrado/"$il"/"$run"/"$i"/md_prod.edr  ~/mestrado/"$il_a"/"$run"/"$i"/md_prod.edr 
   
    done
     \cp -f $work_dir/"$il"/"$run"/*.dat  $work_dir/"$il_a"/"$run"  

  done
  


