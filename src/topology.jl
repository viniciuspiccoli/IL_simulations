#export top

# one IL + Protein + water
function top(dict,top_dir, prot_dir, data, nions, nwater)
  anion  = data.anion
  cation = data.cation
  file = open("$prot_dir/topol.top","r")  
  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations
  n = 0
  for line in eachline(file)
     n = n + 1
     if n==19
       println(topol,"#define _ff_opls")
       println(topol,"#define _ff_oplsaa")
       println(topol,"                 ")
     elseif n==22
       println(topol,"      ")
       println(topol,"; load atom types and molecules")
       println(topol,"#include \"$top_dir/$(data.cat_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.cat_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an_par)\" ")
       println(topol,"             ")
     elseif n>19 && n != 22 && occursin("sol",line)==false
       println(topol, line)
     elseif occursin("sol",line)==true
       println(topol,line)
       println(topol,"SOL                $nwater")
       println(topol,"$(dict[anion])                $nions")	
       println(topol,"$(dict[cation])                $nions")
     end
  end
  close(file)
  close(topol)
end


# Two ILs +  water
function topelec(dict,top_dir, ionic_dir, data, ncat, nan, nwater)
  anion1  = data.anion1
  anion2  = data.anion2 
  cation  = data.cation
  file = open("$ionic_dir/topol.top","r")  
  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations
  n = 0
  for line in eachline(file)
     n = n + 1
     if n==7
       println(topol,"      ")
       println(topol,"; load atom types and molecules")
       println(topol,"#include \"$top_dir/$(data.cat_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.cat_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an1_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an1_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an2_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an2_par)\" ")
       println(topol,"             ")
     elseif  n != 7 && occursin("Compound",line)==false
       println(topol, line)
     elseif occursin("Compound",line)==true
       println(topol,line)
       println(topol,"SOL                $nwater")
       println(topol,"$(dict[anion1])                $nan")
       println(topol,"$(dict[anion2])                $nan")
       println(topol,"$(dict[cation])                $ncat")
     end
  end
  close(file)
  close(topol)
end



# one IL +  water
function topelec(dict,top_dir, ionic_dir, data, nions, nwater)
  anion   = data.anion
  cation  = data.cation
  file = open("$ionic_dir/topol.top","r")  
  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations
  n = 0
  for line in eachline(file)
     n = n + 1
     if n==7
       println(topol,"      ")
       println(topol,"; load atom types and molecules")
       println(topol,"#include \"$top_dir/$(data.cat_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.cat_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an_par)\" ")
       println(topol,"             ")
     elseif  n != 7 && occursin("Compound",line)==false
       println(topol, line)
     elseif occursin("Compound",line)==true
       println(topol,line)
       println(topol,"SOL                $nwater")
       println(topol,"$(dict[anion])                $nions")
       println(topol,"$(dict[cation])                $nions")
     end
  end
  close(file)
  close(topol)
end



# Two IL + Protein + water
function top(dict,top_dir, prot_dir, data, ncat, nan, nwater)
  anion1 = data.anion1
  anion2 = data.anion2
  cation = data.cation
  file = open("$prot_dir/topol.top","r")  
  topol  = open("./topol.top","w") # creation of the topol.top which will be used in the simulations
  n = 0
  for line in eachline(file)
     n = n + 1
     if n==19
       println(topol,"#define _ff_opls")
       println(topol,"#define _ff_oplsaa")
       println(topol,"                 ")
     elseif n==22
       println(topol,"      ")
       println(topol,"; load atom types and molecules")
       println(topol,"#include \"$top_dir/$(data.cat_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.cat_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an1_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an1_par)\" ")
       println(topol,"#include \"$top_dir/$(data.an2_atomtypes)\" ")
       println(topol,"#include \"$top_dir/$(data.an2_par)\" ")
       println(topol,"             ")
     elseif n>19 && n != 22 && occursin("sol",line)==false
       println(topol, line)
     elseif occursin("sol",line)==true
       println(topol,line)
       println(topol,"SOL                $nwater")
       println(topol,"$(dict[anion1])                $nan")	
       println(topol,"$(dict[anion2])                $nan")	
       println(topol,"$(dict[cation])                $ncat")
     end
  end
  close(file)
  close(topol)
end


