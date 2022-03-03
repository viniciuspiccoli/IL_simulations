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
    

     conc(146, 197, 3.0)             




