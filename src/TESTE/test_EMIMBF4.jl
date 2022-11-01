using IL_simulations, PDBTools

top_dir     =  "/home/viniciusp/Insync/viniciuspiccoli2008@hotmail.com/OneDrive/Documents_linux/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
pdb_dir     =  "/home/viniciusp/Insync/viniciuspiccoli2008@hotmail.com/OneDrive/Documents_linux/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/PDB"
input_dir   =  "/home/viniciusp/Insync/viniciuspiccoli2008@hotmail.com/OneDrive/Documents_linux/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"
top_ion_dir =  "/home/viniciusp/Insync/viniciuspiccoli2008@hotmail.com/OneDrive/Documents_linux/doutorado/ANALYSE/Repository/IL_simulations.jl/ion_files"


#atoms   = readPDB("$input_dir/ubq.pdb")
#MMP     = mass(atoms)


function molarmass(anion, cation, pdb_dir)
  atcation = readPDB("$pdb_dir/$(cation)_VSIL.pdb")
  atanion  = readPDB("$pdb_dir/$(anion)_VSIL.pdb")    
  MMIL = mass(atcation) + mass(atanion)
  return MMIL 
end

cation = "EMIM"
anion  = "BF4"
c       =  0.50

MMIL = molarmass(anion, cation, pdb_dir)

dir = pwd();

cd("../ONEIL") 
data = IL_simulations.Data_elec(cation = cation1, anion = anion1, MM = MMIL,c=c)
nions, nwater, sides = sol_elec(data)
IL_simulations.topelec(dict, top_dir, top_ion_dir, data, nions, nwater)
IL_simulations.pack_input_sol(data,pdb_dir,nions,nwater,sides)
IL_simulations.mdp_files()


### test with two ILs/salts - same cation
cd("../TWOIL")
data = IL_simulations.Data_twoelec(cation = cation1, anion1 = anion1, anion2 = anion2 , MM1 = MMIL, MM2 = MMIL2, c=c)
ncat, nan, nwater, sides = sol_melec(data)
IL_simulations.topelec(dict,top_dir, top_ion_dir, data, ncat, nan, nwater)
IL_simulations.pack_input_elec(data, pdb_dir, ncat, nan, nwater, sides)
IL_simulations.mdp_files()
