#!/bin/bash



#EU AINDA NÃO ENTENDI O QUE SERIA ESSA "LIST.TXT"

#!/bin/bash
if [ $# -eq 0 ] ; then
  echo "Run with: ./sub.sh list.txt"
  exit
fi
list=$1


file=gmd_NO3.dat
grep="# Output of gmd.f90: Using MINIMUM distance to solute."


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
  name=BF$conc$num
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

echo "não deu erro"

cd $run

  # Simulations
  \rm -f $run/*.log $run/jobout $run/joberr
  sed -e "s?NAME?$name?" comput_gmd.sh > $run/comput_gmd-temp.sh
  sed -e "s?RUN?$run?" $run/comput_gmd-temp.sh > $run/comput_gmd.sh
  \rm -f $run/comput_gmd-temp.sh
  chmod +x $run/comput_gmd.sh
  qsub $run/comput_gmd.sh

done



