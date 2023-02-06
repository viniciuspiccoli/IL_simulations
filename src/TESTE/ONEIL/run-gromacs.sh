  gmx grompp -f mim.mdp -c system.pdb -p topol.top -o em.tpr -maxwarn 1
  gmx mdrun -v -deffnm em 

  
#  rm em.trr
#
#  gmx grompp -f nvt.mdp -c em.gro -n line.ndx -p topol.top -o equil.tpr -maxwarn 3
#  gmx mdrun -v -deffnm equil -nb auto -ntmpi 1
#
#
#  rm nvt.trr
#
#  gmx grompp -f npt.mdp -c equil.gro -n line.ndx -p topol.top -o equil_npt.tpr -maxwarn 3
#  gmx mdrun -v -deffnm equil_npt -nb auto -ntmpi 1
#
#
#  rm npt.trr
#
#  gmx grompp -f md.mdp -c equil_npt.gro -n line.ndx -p topol.top -t equil_npt.cpt -o dina.tpr -maxwarn 3
#  gmx mdrun -v -deffnm dina -nb auto -ntmpi 1
#
#
#  rm dina.trr
#
#  for a in "gro" "xtc"; do
# 
#    echo 1 0 |gmx trjconv -s dina.tpr -f dina."$a" -o processed_dina."$a" -ur compact -pbc mol -center 
#   
#  done
#
#
#
#
