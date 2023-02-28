###############################################################################
#Calculation of the number of the ions given a concentration and the MM of the# 
###############################################################################

export prot_elec
using PDBTools

# One IL + Protein + Water
function prot_elec(data; cube=false, charge=false)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  vprot = (MMP / 6.02e23) * 1e-3

  ### decidir aqui a melhore forma de calcular as caixas
 
 
#  if cube==false
#    lx,ly,lz = measure_prot(protein,30)  
#  elseif cube==true
    lx = 94
    ly = 94 
    lz = 94
#  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = - vprot + vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  if charge==false 
    return nions, nwater, sides
  else 
    return nions, nwater, charge, sides
  end

end


export sol_elec
# One IL + Water
function sol_elec(data)

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]

  vsol   = lx*ly*lz*1.e-27                                        # Volume (total=solution) / L  
  nions  = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions  = nions * MM1 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  return nions, nwater, sides

end


## funcao que serve para testar o método de cálculo
export solution_number
# One IL + Water
function solution_numbers(data, rho)

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]
   
  vbox = lx*ly*lz
  CMC  = 6.02e23 / (1.e27)
  cc = CMC * c # conversion of mol/L to molecules/Angs^3
  nc = cc * vbox
  nw = (6.02e23 * rho * vbox / 1.e24 - nc*data.MM) / 18.0158  

  return nc, nw, sides

end



export prot_melec
# two IL + Protein + Water
function prot_melec(data; cube=false, charge=false)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion1
  anion2  = data.anion2 

  MM1  = data.MM1
  MM2  = data.MM2
  c    = data.c

  vprot = (MMP / 6.02e23) * 1e-3 
#  if cube==false
#    lx,ly,lz = measure_prot(protein,30)  
#  elseif cube==true
    lx = 92
    ly = 94 
    lz = 98
#  end    

  sides = [lx, ly, lz]

  vtotal = lx*ly*lz*1.e-27                                      # volume in L
  vsol = - vprot + vtotal                                         # solution volume = volume of the box  - volume of the protein / L   
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = (nions * MM1 * 1.e-3 / (6.02e23)) + (nions * MM2 * 1.e-3 / (6.02e23))                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  nan = round(Int,(nions/2)) # same number of molecules for each anion = ncation/2
  # adjustment of the nions - If ncat % 2 != 0 -> ncat = ncat + 1 - ncat must be 2 times greater than nan
  ncat = 2 * nan

  if charge==false 
    return ncat, nan, nwater, sides
  else 
    return ncat, nan, charge, nwater, sides
  end

end


#the function above is correct for "some reason" that I do not know right now!
export protmelec2

function protmelec2(data)

  protein = data.protein
  MMP = data.MMP 

  cation1 = data.cation 
  anion1  = data.anion1
  anion2  = data.anion2 

  MM1  = data.MM1
  MM2  = data.MM2
  c    = data.c

  vol_box(a,b,c) = a*b*c*1e-27;
  vol_prot(m) = (m/(6.02e23))*1e-3;
  vol_wat(n,mw) = n * (mw/(6.02e23))*1e-3;
  vol_sol(vc,vp) = vc - vp;
  num_il(vs,cil) = round(Int64,(vs*cil*6.02e23));
  v_il(nil,mil) = (nil*mil*1e-3)/(6.02e23);
  num_wat(vs,vil) = round(Int128,((vs - vil) * 6.02e23) / (18*1e-3));

  #lx,ly,lz = measure_prot("ubq.pdb") 
   lx = 46
   ly = 47
   lz = 49
  
  vs   = vol_box(2*lx,2*ly,2*lz) - vol_prot(MMP); # Volume da solução
  nil  = round(Int64,(num_il(vs,c)/2));                           # Número de moléculas de IL para dada concentração
  nwat1 = num_wat(vs, v_il(nil,MM1) +  v_il(nil,MM2));                 # Número de moléculas de água para preencher, levando em conta os dois LIs
  nwat = nwat1

  sides = [2*lx, 2*ly, 2*lz]

  return 2*nil, nil, nwat, sides

end

export sol_melec

# two IL +  Water
function sol_melec(data; cube=false, charge=false)
  cation1 = data.cation 
  anion1  = data.anion1
  anion2  = data.anion2 

  MM1  = data.MM1
  MM2  = data.MM2
  c    = data.c

  lx = 80
  ly = 80 
  lz = 80

  sides = [lx, ly, lz]

  vsol = lx*ly*lz*1.e-27                                      # volume in L
  nions = round(Int64, vsol * c * 6.02e23)                      # number of ions 
  vions = nions * MM1 * 1.e-3 / (6.02e23) + nions * MM2 * 1.e-3 / (6.02e23)                       # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))   # number of water molecules to fill the box

  ncat = nions
  nan = round(Int,(nions/2)) # same number of molecules for each anion = ncation/2

  return ncat, nan, nwater, sides

end

