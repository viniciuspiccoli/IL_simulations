###
Calculation of the number of the ions given a concentration and the MM of the 
###

function number_of_ions(protein, MMP, cation1, anion1, MM1, c; cube=false, charge=false)

  vprot = (MMP / 6.02e23) * 1e-3 

  if cube==false
    lx,ly,lz = measure_prot(protein)  
  else
    lx = 90
    ly = 90 
    lz = 90
  end    

  vtotal = lx*ly*lz*1.e-27     # volume in L
  vsol = vprot - vtotal        # solution volume = volume of the box  - volume of the protein / L
   
  nions = round(Int64, vsol * c * 6.02e23)
  vions = nions * MM1 * 1.e-3

  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3)) 



# number of particles calculationa

# volume of the box (L)
vol_box(a,b,c) = a*b*c*1e-27;

# protein volume (L)  
vol_prot(m) = (m/(6.02e23))*1e-3;

# Water volume (L)
vol_wat(n,mw) = n * (mw/(6.02e23))*1e-3;

# Solution volume
vol_sol(vc,vp) = vc - vp;

# number of ionic liquids molecules
num_il(vs,cil) = round(Int128,(vs*cil*6.02e23));

# Volume of ionic liquids moleculres
v_il(nil,mil) = (nil*mil*1e-3)/(6.02e23);

# each ionic liquid will occupy the half of the volume      

# Number of water molecules
num_wat(vs,vil) = round(Int128,((vs - vil) * 6.02e23) / (18*1e-3));

println("vai calcular as dimensões")

# Box dimensions
lx,ly,lz = measure_prot("ubq.pdb") 

println("calculou dimensões")

      
# Total concentration of ions
c = conc;

vs   = vol_box(2*lx,2*ly,2*lz) - vol_prot(8560); # Volume da solução
nil  = round(Int,(num_il(vs,c)/2));                           # Número de moléculas de IL para dada concentração

nwat1 = num_wat(vs, v_il(nil,MM) +  v_il(nil,MM2));                 # Número de moléculas de água para preencher, levando em conta os dois LIs
 nwat2 = num_wat(vs,v_il(nil,MM2));
nwat = nwat1



end



