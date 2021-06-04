#Calculation of the number of the ions given a concentration and the MM of the 

include("./measure_protein.jl")

export number_of_ions

function number_of_ions(protein, MMP, cation1, anion1, MM1, c; cube=false)

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz, charge = measure_prot(protein, 30)  
  else
    lx = 45
    ly = 45 
    lz = 45
  end    
  vtotal = 2*lx*2*ly*2*lz*1.e-27     # volume in L
  vsol   = vtotal - vprot      # solution volume = volume of the box  - volume of the protein / L
  
  nions  = vsol * c * 6.02e23
  nions  = round(Int128, nions)
  vions  = nions * MM1 * 1.e-3 /(6.02e23)
  nwater = ((vsol - vions) * 6.02e23) / (18*1.e-3)
  nwater = round(Int64, nwater) 

  println("###############################")
  println("Concentration = $c")
  println("Number of water molecular = $nwater")
  println("Number of cations = $(nions)")
  println("Number of anions  = $(nions)")

  return nions, nwater
end


MM1     =  201.06
MMP     =  8560
cation1 = "BMIM"
anion1  = "NO3"
c       =  0.50

number_of_ions("ubq.pdb", MMP, cation1, anion1, MM1, c; cube=false)

function number_of_ions(protein, MMP, cation1, anion1, MM1, cation2, anion2, MM2, c; cube=false)

  vprot = (MMP / 6.02e23) * 1e-3 
  if cube==false
    lx,ly,lz, charge = measure_prot(protein, 30)  
  else
    lx = 45
    ly = 45 
    lz = 45
  end    
  vtotal = 2*lx*2*ly*2*lz*1.e-27     # volume in L
  vsol   = vtotal - vprot      # solution volume = volume of the box  - volume of the protein / L
  
  nions  = vsol * c * 6.02e23
  nions  = round(Int128, nions)
  vions  = (((nions/2) * MM1) + (nions/2) * MM2) * 1.e-3 /(6.02e23)
  nwater = ((vsol - vions) * 6.02e23) / (18*1.e-3)
  nwater = round(Int64, nwater) 

  return nions, nwater
end


function number_of_ions(side,cation1, anion1, MM1, c; cube=false)

  vsol = (side^3)*1.e-27     # volume in L
  
  nions  = vsol * c * 6.02e23
  nions  = round(Int128, nions)
  vions  = nions * MM1 * 1.e-3 /(6.02e23)
  nwater = ((vsol - vions) * 6.02e23) / (18*1.e-3)
  nwater = round(Int64, nwater) 

  return nions, nwater
end


function number_of_ions(side,cation1, anion1, MM1, cation2, anion2, MM2, c; cube=false)

  vsol = (side^3)*1.e-27     # volume in L
  
  nions  = vsol * c * 6.02e23
  nions  = round(Int128, nions)
  vions  = ((nions/2) * MM1) + ((nions/2) * MM2) * 1.e-3 /(6.02e23)
  nwater = ((vsol - vions) * 6.02e23) / (18*1.e-3)
  nwater = round(Int64, nwater) 

  return nions, nwater
end











