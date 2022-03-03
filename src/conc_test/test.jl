 using IL_simulations, PDBTools

  top_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/VSIL/ITP"
  pdb_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/VSIL/PDB" 
  input_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/ubiquitin_files"
      

   function conc(MM, MM2, conc)

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
     c = conc;
     vs   = vol_box(2*lx,2*ly,2*lz) - vol_prot(8560); # Volume da solução
     nil  = round(Int64,(num_il(vs,c)/2));                           # Número de moléculas de IL para dada concentração
     nwat1 = num_wat(vs, v_il(nil,MM) +  v_il(nil,MM2));                 # Número de moléculas de água para preencher, levando em conta os dois LIs
     nwat = nwat1

     println("ncations = $(2*nil)")       
     println("nanions = $(nil) and $(nil)")
     println("nwater = $nwat")

end
 





let

  
  
    atoms   = readPDB("$input_dir/ubq.pdb")
    MMP     =  8579.94
    cation  = "EMIM" 
    anion1  = "Cl"
    anion2  = "BF4"

    println(MMP)

    il = "$(cation)$(anion1)$(anion2)"
    MMIL1 = molarmass(anion1, cation, pdb_dir)
    MMIL2 = molarmass(anion2, cation, pdb_dir)
    dir = pwd();

    
      c = 3.0
      data = IL_simulations.Data_2il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation, anion1 = anion1, anion2 = anion2, MM1 = MMIL1, MM2 = MMIL2 , c=c)
      ncat, nan, nwater, sides = protmelec2(data)
      println("data for the simulation - $il")

      println("==== Regular calculation")
      println("ncations = $ncat")
      println("nanions = $nan and $nan")
      println("nwater = $nwater")
      println("  ")

      println("==== Old calculation")      
      conc(146, 197, c)             
      println("   ")
    
   


end
