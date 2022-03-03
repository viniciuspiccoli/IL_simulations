 using IL_simulations, PDBTools

  top_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/VSIL/ITP"
  pdb_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/VSIL/PDB" 
  input_dir="/home/viniciusp/Documents/doutorado/repo/IL_simulations.jl/ubiquitin_files"

  let
  
    atoms   = readPDB("$input_dir/ubq.pdb")
    MMP     = mass(atoms)
    cation  = "EMIM" 
    anion1  = "DCA"
    anion2  = "BF4"

    il = "$(cation)$(anion1)$(anion2)"
    MMIL1 = molarmass(anion1, cation, pdb_dir)
    MMIL2 = molarmass(anion2, cation, pdb_dir)
    dir = pwd();

    for i in ["0.50", "1.00", "1.50", "2.00", "2.50", "3.00"]
      conc = parse(Float64,i)
      data = IL_simulations.Data_2il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation, anion1 = anion1, anion2 = anion2, MM1 = MMIL1, MM2 = MMIL2 , c=conc)
      ncat, nan, nwater, sides = prot_melec(data)
      println("data for the simulation - $il")
      println("ncations = $ncat")
      println("nanions = $nan and $nan")
      println("nwater = $nwater")
      println("  ")
    end
   
  end




