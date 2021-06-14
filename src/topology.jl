#export Topology

function topology(file,dict, data)
         f = open(file,"r")
         for line in eachline(f)
           println(line)
         end
       end



function top(dict,top_dir, prot_file, data, nions, nwat)
  
#  anion  = data.anion
#  cation = data.cation

#  file = open("$prot_dir/topol.top","r")  
  file = open(prot_file,"r")
  nlines = countlines(file)# number of lines of the original topol.top

 # println(nlines)
 # println(file)

  for line in eachline(file)
    println(line)
    println("está dentro do loop")
  end
  
  println("passou do loop")



#  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations

#  println("vai iniciar o loop")
#
#  n = 0
#  for line in eachline(file)
#     println("entrou no loop")
#     n = n + 1
#     if n==19
#       println("passou da linha 19")
#       println(topol,"#define _FF_OPLS")
#       println(topol,"#define _FF_OPLSAA")
#     elseif n==26
#       println("   ")
#       println("passou da linha 26")
#       println(topol,"$top_dir/$(data.cat_atomtypes)")
#       println(topol,"$top_dir/$(data.cat_par)")
#       println(topol,"$top_dir/$(data.an_atomtypes)")
#       println(topol,"$top_dir/$(data.an_par)")
#     elseif n>19 && n != 26 && occursin("SOL",line)==false
#       println(topol, line)
#       println("hehe")
#     elseif occursin("SOL",line)==true
#       println(topol,line)
#       println(topol,"SOL                $nwater")
#       println(topol,"$(dict[anion])                $nions")	
#       println(topol,"$(dict[cation])                $nions")
#     end
#  end
#
#  close(file)
#  close(topol)
 
end
