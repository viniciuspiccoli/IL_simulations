  # os arquivos dcd e trr são os mais pesado. Sendo assim, eles serão apagados. Em um eventual necessidade do arquivo dcd, ele pode ser
  # facilmente criado a partir do arquivo processed.xtc por meio do catdcd.
  
  for pasta in BMIMDCANO3 BMIMBF4NO3 BMIMNO3 ; do                                             # EMIMNO3 EMIMDCANO3 EMIMBF4NO3 ; do
    for i in 0.50 1.00 1.50 2.00 2.50 3.00; do
      for a in {00..20};do 
#        cp run-gromacs.sh  ~/doutorado/"$pasta"/"$i"/"$a"

         
      # cd /home/viniciusp/doutorado/"$pasta"/"$i"/"$a"
      ##  cp /home/viniciusp/doutorado/put_names_pdb.jl . 
      ##  gmx_mpi editconf -f  processed.gro -o simul_teste.pdb
      ## 
      ##  rm md_prod.xtc
      ##  catdcd -o simul.dcd -xtc processed.xtc
      ##  julia put_names_pdb.jl > simul.pdb
      ##  echo exit | vmd -e vmd_psf_maker.vmd


     # gmx_mpi editconf -f processed.gro -o processed.pdb  
      #  gmx_mpi editconf -f "$pasta"/"$i"/"$a"/processed.gro -o "$pasta"/"$i"/"$a"/processed.pdb
      #  cp  md_prod.mdp ~/doutorado/"$pasta"/"$i"/"$a"
      #   rm  ~/mestrado/denaturated_prot/"$pasta"/"$i"/"$a"/dina.xtc
         rm  ~/doutorado/"$pasta"/"$i"/"$a"/\#*
         rm  ~/doutorado/"$pasta"/"$i"/"$a"/*.trr 
         rm  ~/doutorado/"$pasta"/"$i"/"$a"/simul.dcd
      #   rm  ~/mestrado/denaturated_prot/"$pasta"/"$i"/"$a"/processed*
      #   rm  ~/mestrado/denaturated_prot/"$pasta"/"$i"/"$a"/*.dat
 
 
      done
    done
  done 
  
