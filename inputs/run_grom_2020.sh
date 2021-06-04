#PBS -S /bin/bash
#PBS -m abe
#PBS -q route
#PBS -N NAME
#PBS -l walltime=72:00:00
#PBS -l select=1:ncpus=8:ngpus=1:Qlist=Allnodes
#PBS -V
#PBS -o RUN/jobout
#PBS -e RUN/joberr
#!/bin/bash

 run=RUN
 cd $PBS_O_WORKDIR
   
 ## Carregando modulo do fftw e gromacs
  
 export PATH=/home/viniciusp/programas/packmol 
 export PATH=/softwares/plumed-2.6.2/bin  
 export PATH=/softwares/plumed-2.6.2/lib  

 source /etc/profile.d/modules.sh

 module load cuda/cuda-10.1
 module load fftw/fftw-3.3.8
 module load gromacs/gromacs-pmed-mpi-cuda-2020.4    
 echo "hostname " `hostname`


cd $run

   
   packmol < box.inp > box.log   
  
   gmx_mpi grompp -f mim.mdp -c system.pdb -p topol.top -o em.tpr -maxwarn 5
   gmx_mpi mdrun -v -deffnm em -nb auto -ntmpi 1 -pin on

   rm em.trr

   gmx_mpi grompp -f nvt.mdp -c em.gro -r em.gro  -p topol.top -o nvt.tpr -maxwarn 5
   gmx_mpi mdrun -v -deffnm nvt -nb auto -ntmpi 1 -pin on
   
   rm nvt.trr

   gmx_mpi grompp -f npt.mdp -c nvt.gro -r nvt.gro   -t nvt.cpt -p topol.top -o npt.tpr -maxwarn 5
   gmx_mpi mdrun -v -deffnm npt -nb auto -ntmpi 1 -pin on

   rm npt.trr

   gmx_mpi grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o free.tpr -maxwarn 5
   gmx_mpi mdrun -v -deffnm free -nb auto -ntmpi 1 -pin on

   rm free.trr

   gmx_mpi grompp -f md_prod.mdp -c free.gro -t free.cpt -p topol.top -o md_prod.tpr -maxwarn 5
   gmx_mpi mdrun -v -deffnm md_prod -nb auto -ntmpi 1 -s md_prod.tpr -pin on

   rm md_prod.trr
   
   #commands to process the gromacs trajectory
  
     for a in "gro" "xtc"; do
 
         echo 1 0 |gmx_mpi trjconv -s md_prod.tpr -f md_prod."$a" -o processed."$a" -ur compact -pbc mol -center 
   
     done

  
   gmx_mpi editconf -f  processed.gro -o simul_teste.pdb
   catdcd -o simul.dcd -xtc processed.xtc
   julia put_names_pdb.jl > simul.pdb
   echo exit | vmd -e vmd_psf_maker.vmd




