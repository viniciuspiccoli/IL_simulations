#export top

function top(dict,top_dir, prot_dir, data, nions, nwater)
  
  anion  = data.anion
  cation = data.cation

  file = open("$prot_dir/topol.top","r")  
#  nlines = countlines(f)# number of lines of the original topol.top

  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations

  n = 0
  for line in eachline(file)
     n = n + 1
     if n==19
       println(topol,"#define _FF_OPLS")
       println(topol,"#define _FF_OPLSAA")
       println(topol,"                 ")
     elseif n==22
       println(topol,"      ")
       println(topol,"; LOAD Atom types and Molecules")
       println(topol,"#include \"$top_dir/$(data.cat_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.cat_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an_par)\" ")
       println(topol,"             ")
     elseif n>19 && n != 22 && occursin("SOL",line)==false
       println(topol, line)
     elseif occursin("SOL",line)==true
       println(topol,line)
       println(topol,"SOL                $nwater")
       println(topol,"$(dict[anion])                $nions")	
       println(topol,"$(dict[cation])                $nions")
     end
  end

  close(file)
  close(topol)
 
end
