###############################################################################
#Calculation of the number of the ions given a concentration and the MM of the# 
###############################################################################

export number_of_ions

include("./measure_protein.jl")

# One IL + Protein + Water
function number_of_ions(data::Data_IL; cube=false, charge=false)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz = measure_prot(protein,30)  
  elseif cube==true
    lx = 90
    ly = 90 
    lz = 90
  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = vprot - vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  if charge==false 
    return nions, nwater, sides
  else 
    return nions, nwater, charge, sides
  end

  println("###############################")
  println("Concentration = $c")
  println("Number of water molecular = $nwater")
  println("Number of cations = $(nions)")
  println("Number of anions  = $(nions)")

end



# IL + Water
function number_of_ions(cation1, anion1, MM1, c)

  lx = 50
  ly = 50 
  lz = 50
  
  sides = [lx,ly,lz]

  vsol =  lx*ly*lz*1.e-27                                       # solution volume = volume of the box     
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  return nions, nwater, sides
 
end


# Two IL + Protein + Water ==== Same cation
function number_of_ions(protein, MMP, cation1, anion1, MM1, cation2, anion2, MM2, c; cube=false, charge=false)

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz = measure_prot(protein,30)  
  elseif cube==true
    lx = 90
    ly = 90 
    lz = 90
  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = vprot - vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions

  vions = (nions * MM1 * 1.e-3 /(6.02e23))  + (nions * MM2 * 1.e-3 / (6.02e23))         # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  ncat = nions
  nan1 = round(Int,(nions/2)) 
  nan2 = round(Int,(nions/2))

  if charge==false 
    return ncat, nan1, nan2, nwater, sides
  else 
    return ncat, nan1, nan2, nwater, charge, sides
  end

end

# Two IL + Water ==== Same cation
function number_of_ions(cation1, anion1, MM1, cation2, anion2, MM2, c)

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]

  vsol = lx*ly*lz*1.e-27                                        # volume in L
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions

  vions  = (nions * MM1 * 1.e-3 / (6.02e23))   + (nions * MM2 * 1.e-3 / (6.02e23))           # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  ncat = nions
  nan1 = round(Int,(nions/2)) 
  nan2 = round(Int,(nions/2))

  return ncat, nan1, nan2, nwater, sides

end



