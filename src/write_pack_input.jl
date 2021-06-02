###
Script to create inputs for packmol for systems:
i = 1 - One IL or one type of salt
i = 2 - Two ILs of two salts
i = 0 - Solution of IL or salt
###

  




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
      println(io,"structure $(Nomean2)_VSIL.pdb")
      println(io," number $nil")
      println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
      println(io,"end structure")
   #   println(io,"                  ") 
   #   println(io,"structure $(Nome2)_VSIL.pdb")
   #   println(io," number $nil")
   #   println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
   #   println(io,"end structure")
      println(io,"                  ") 
      println(io,"structure $(Nomean)_VSIL.pdb")
      println(io," number $nil")
      println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
      println(io,"end structure")




