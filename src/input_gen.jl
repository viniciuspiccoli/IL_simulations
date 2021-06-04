
function input_gen(nions, nwaters, ,a)
      
      nwat = nwaters + 58

      io = open("box.inp","w")      
      println(io,"tolerance 2.0")
      println(io,"output system.pdb")
      println(io,"add_box_sides 1.0")
      println(io,"filetype pdb")
      println(io,"seed -1")
      println(io,"                  ")
      println(io,"structure ubq.pdb")
      println(io," number 1")
      println(io," center")
      println(io," fixed 0. 0. 0. 0. 0. 0.")
      println(io,"end structure")
      println(io,"                  ") 
      println(io,"structure WATER.pdb")
      println(io," number $nwat")
      println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
      println(io,"end structure")
      println(io,"                  ") 
      println(io,"structure $(Nome)_VSIL.pdb")
      println(io," number $(2*nil)")
      println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
      println(io,"end structure")
      println(io,"                  ")

      if a=="two"
        println(io,"structure $(Nomean2)_VSIL.pdb")
        println(io," number $nil")
        println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
        println(io,"end structure")
      end

    #  println(io,"                  ") 
   #   println(io,"structure $(Nome2)_VSIL.pdb")
   #   println(io," number $nil")
   #   println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
   #   println(io,"end structure")
      println(io,"                  ") 
      println(io,"structure $(Nomean)_VSIL.pdb")
      println(io," number $nil")
      println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
      println(io,"end structure")
  
      close(io)
  
      topa = open("topola.top","r+")
  
      # number of lines !
      nlines = 0
      for line in eachline(topa)
        nlines += 1
      end
  
      close(topa)
  
      topa = open("topola.top","r+")
      top = open("topol.top","w")
      ntline = 0

      for line in eachline(topa) 

        ntline += 1
      
        if occursin("AN1",line) && ntline != nlines && ntline < nlines - 4 
          println(top,replace(line,"AN1" => "$Nomean",count = 1))
        elseif occursin("CA1",line) && ntline < nlines - 4 
          println(top,replace(line,"CA1" => "$Nome",count = 1))
        elseif occursin("AN2",line) && ntline < nlines - 4 
          println(top,replace(line,"AN2" => "$Nomean2",count = 1))
        elseif occursin("CA2",line) && ntline < nlines - 4 
          println(top,replace(line,"CA2" => "$Nome2",count = 1))
        elseif ntline == (nlines - 4)
          println(top,replace(line,line => "SOL               $(nwat + 58)",count = 1)) # 58 cristalization water molecules

        # data for the ions
                                                                                            
        elseif ntline == (nlines - 1)
          if Nomean == "DCA"
            println(top,replace(line,line => "NC                $nil",count = 1)) 
          elseif Nomean == "BF4"
            println(top,replace(line,line => "BF4                $nil",count = 1)) 
          elseif Nomean == "NO3"  
            println(top,replace(line,line => "NO3                $nil",count = 1))
          elseif Nomean == "Cl"
            println(top,replace(line,line => "Cl                 $nil",count = 1))
          elseif Nomean == "SCN" 
            println(top,replace(line,line => "SCN                $nil",count = 1))
          end                                                                                      
        elseif ntline == (nlines - 3) 
          println(top,replace(line,line => "$(Nome[1:3])                $(2*nil) ",count = 1))          
        elseif ntline == (nlines - 2)
          if Nomean2 == "DCA"
            println(top,replace(line,line => "NC                $nil",count = 1)) 
          elseif Nomean2 == "BF4"
            println(top,replace(line,line => "BF4                $nil",count = 1))
          elseif Nomean2 == "NO3"  
            println(top,replace(line,line => "NO3                $nil",count = 1))
          elseif Nomean2 == "Cl"
            println(top,replace(line,line => "Cl                 $nil",count = 1))
          elseif Nomean2 == "SCN" 
            println(top,replace(line,line => "SCN                $nil",count = 1))
          end  
       # elseif  ntline == nlines
       #   println(top,replace(line,line => "$(Nome2[1:3])                $nil ",count = 1))        
        else
          println(top,line)
        end
      end
      close(top)
      close(topa)
  
  end
