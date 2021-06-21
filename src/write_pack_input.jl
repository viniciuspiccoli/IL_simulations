export pack_input

# one il + protein + water  
function pack_input(data, pdb_dir::String, nil, nwater, sides)


# println("""
#    teste
#    teste
# """)

  
  protein = data.protein
  cation  = data.cation
  anion   = data.anion

  lx = round(Int64,sides[1] / 2)
  ly = round(Int64,sides[2] / 2)
  lz = round(Int64,sides[3] / 2)

  io = open("box.inp","w")  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure $(protein)")
  println(io," number 1")
  println(io," center")
  println(io," fixed 0. 0. 0. 0. 0. 0.")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/WATER.pdb")
  println(io," number $nwater")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(cation)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(anion)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")

  close(io)

end


# one il + water  
function pack_input(data, pdb_dir::String, nil, nwater, sides)
  
  cation  = data.cation
  anion   = data.anion

  lx = round(Int64,sides[1] / 2)
  ly = round(Int64,sides[2] / 2)
  lz = round(Int64,sides[3] / 2)

  io = open("box.inp","w")  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure $pdb_dir/WATER.pdb")
  println(io," number $nwater")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(cation)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(anion)_VSIL.pdb")
  println(io," number $nil")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")

  close(io)

end




# two ils + protein + water
function pack_input(data, pdb_dir::String, ncat, nan, nwater, sides)
  
  protein = data.protein
  cation  = data.cation
  anion   = data.anion
  anion2  = data.anion2

  lx = round(Int64,sides[1] / 2)
  ly = round(Int64,sides[2] / 2)
  lz = round(Int64,sides[3] / 2)

  io = open("box.inp","w")  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ")
  println(io,"structure $(protein)")
  println(io," number 1")
  println(io," center")
  println(io," fixed 0. 0. 0. 0. 0. 0.")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/WATER.pdb")
  println(io," number $nwater")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(cation)_VSIL.pdb")
  println(io," number $ncat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(anion)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb2_dir/$(anion2)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")

  close(io)

end



# two ils + water
function pack_input(data, pdb_dir::String, ncat, nan, nwater, sides)
  
  cation  = data.cation
  anion   = data.anion
  anion2  = data.anion2

  lx = round(Int64,sides[1] / 2)
  ly = round(Int64,sides[2] / 2)
  lz = round(Int64,sides[3] / 2)

  io = open("box.inp","w")  
  println(io,"tolerance 2.0")
  println(io,"output system.pdb")
  println(io,"add_box_sides 1.0")
  println(io,"filetype pdb")
  println(io,"seed -1")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/WATER.pdb")
  println(io," number $nwater")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(cation)_VSIL.pdb")
  println(io," number $ncat")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb_dir/$(anion)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")
  println(io,"                  ") 
  println(io,"structure $pdb2_dir/$(anion2)_VSIL.pdb")
  println(io," number $nan")
  println(io," inside box -$(lx). -$(ly). -$(lz). $(lx). $(ly). $(lz).")
  println(io,"end structure")

  close(io)

end





