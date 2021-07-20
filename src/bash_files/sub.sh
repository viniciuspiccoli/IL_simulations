
#!/bin/bash
if [ $# -eq 0 ] ; then
  echo "Run with: ./sub.sh list.txt"
  exit
fi
list=$1

#file=md_prod.log
#grep="Finished mdrun on rank 0"

file=processed.gro
grep="Protein"


nrun=0
for run in `cat $list`; do
  nrun=`expr $nrun + 1`

  name=(${run//\// })
  n=${#name[@]}
  i=`expr $n - 1`
  j=`expr $n - 2`
  k=`expr $n - 3`
  
  catil=${name[$k]:0:3}
  anion=${name[$k]:4:6}
  conc=`echo ${name[$j]} | sed -s 's/\.//'`
  num=${name[$i]}
  #name=$anion$num
  name=B$conc-$num  # BMIMNO3
  echo "$name"

  # Check if simulation is already run
  a=`grep -s "$grep" $run/$file`
  if [[ $a == *"$grep"* ]]; then
    echo "$nrun ENDED: $run"
    continue
  else
    a=`qstat -u viniciusp | grep $name`
    if [[ $a == *"$name"* ]]; then
      echo "$nrun ON QUEUE: $run"
      continue
    else
      echo "$nrun SUB: $run" 
    fi
  fi

  # Simulations
  \rm -f $run/*.log $run/jobout $run/joberr
  sed -e "s?NAME?$name?" run-gromacs.sh > $run/run-gromacs-temp.sh
  sed -e "s?RUN?$run?" $run/run-gromacs-temp.sh > $run/run-gromacs.sh
  \rm -f $run/run-gromacs-temp.sh
  chmod +x $run/run-gromacs.sh
  qsub $run/run-gromacs.sh

done
