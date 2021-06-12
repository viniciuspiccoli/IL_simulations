include("./dic_data.jl")


export Topology

function Topology(dict,file::String,top_dir, input_dir, data::Data_il, nions, nwat)
  
  anion  = data.anion
  cation = data.cation
  file = open("$top_dir/topol.top","r")   

  nlines = countlines(file)      # number of lines of the original topol.top
  topol  = open("topol.top","w") # creation of the topol.top wichi will be used in the simulations
 
  n = 0
  for line in eachline(file)
     n = n + 1
     if n==19
       println(topol,"#define _FF_OPLS")
       println(topol,"#define _FF_OPLSAA")
     elseif n==26
       println("   ")
       println(topol,"$top_dir/$(data.cat_atomtypes)")
       println(topol,"$top_dir/$(data.cat_par)")
       println(topol,"$top_dir/$(data.an_atomtypes)")
       println(topol,"$top_dir/$(data.an_par)")
     elseif n>19 && n != 26 && occursin("SOL",line)==false
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