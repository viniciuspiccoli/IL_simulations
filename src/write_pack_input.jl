export pack_input
  
function pack_input(protein, cation, anion, nil, nwater, sides)

  lx = sides[1]
  ly = sides[2]
  lz = sides[3]

  io = open("box.inp","w")  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure $(protein).pdb")
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
  println(io,"structure $(cation)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")

  close(io)

end



function pack_input(cation, anion, nil, nwater, sides)

  lx = sides[1]
  ly = sides[2]
  lz = sides[3]

  io = open("box.inp","w")
  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure WATER.pdb")
  println(io," number $nwat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(cation)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  close(io)

end


function pack_input(protein, cation, anion1, anion2, ncat, nan, nwater, sides)

  lx = sides[1]
  ly = sides[2]
  lz = sides[3]

  io = open("box.inp","w")
  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure $(protein).pdb")
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
  println(io,"structure $(cation)_VSIL.pdb")
  println(io," number $ncat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion1)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion2)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  close(io)

end




function pack_input(cation, anion1, anion2, ncat, nan, nwater, sides)

  lx = sides[1]
  ly = sides[2]
  lz = sides[3]

  io = open("box.inp","w")
  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ") 
  println(io,"structure WATER.pdb")
  println(io," number $nwat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(cation)_VSIL.pdb")
  println(io," number $ncat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion1)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $(anion2)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  close(io)

end

