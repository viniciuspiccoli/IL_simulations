using IL_simulations, PDBTools

top_dir     =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
pdb_dir     =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/PDB"
input_dir   =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"
top_ion_dir =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ion_files"


atoms   = readPDB("$input_dir/ubq.pdb")
MMP     = mass(atoms)

cation1 = "BMIM"
anion1  = "NO3"
anion2  = "DCA" 

function molarmass(anion, cation, pdb_dir)
  atcation = readPDB("$pdb_dir/$(cation)_VSIL.pdb")
  atanion  = readPDB("$pdb_dir/$(anion)_VSIL.pdb")    
  MMIL = mass(atcation) + mass(atanion)
#  println("molar mass of the ânion is = ", mass(atanion))
#  println("molar mass of the cation is = ", mass(atcation))
  return MMIL 
end

MMIL  = molarmass(anion1, cation1, pdb_dir)
MMIL2 = molarmass(anion2, cation1, pdb_dir)
c       =  0.10


## test with one IL/salt and a protein/polymer
cd("PONEIL")
data = IL_simulations.Data_il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation1, anion = anion1,MM = MMIL,c=c)
nions, nwater, sides = prot_elec(data)
IL_simulations.top(dict, top_dir, input_dir, data, nions, nwater)
IL_simulations.pack_input(data,pdb_dir,nions,nwater,sides)
IL_simulations.mdp_files_solute()


println("PONEIL")
# test with one IL/salt
cd("../ONEIL") 
data = IL_simulations.Data_elec(cation = cation1, anion = anion1, MM = MMIL,c=c)
nions, nwater, sides = sol_elec(data)
IL_simulations.topelec(dict, top_dir, top_ion_dir, data, nions, nwater)
IL_simulations.pack_input_sol(data,pdb_dir,nions,nwater,sides)
IL_simulations.mdp_files()

println("ONEIL")

# test with two ILs/salts and a protein/polymer -same cation
cd("../PTWOIL")
data = IL_simulations.Data_2il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation1, anion1 = anion1, anion2 = anion2, MM1 = MMIL, MM2 = MMIL2,c=c)
ncat, nan, nwater, sides = prot_melec(data)
IL_simulations.top(dict, top_dir, input_dir, data, ncat, nan, nwater)
IL_simulations.pack_input(data, pdb_dir, ncat, nan, nwater, sides)
IL_simulations.mdp_files()

println("PTWOIL")

## test with two ILs/salts - same cation
cd("../TWOIL")
data = IL_simulations.Data_twoelec(cation = cation1, anion1 = anion1, anion2 = anion2 , MM1 = MMIL, MM2 = MMIL2, c=c)
ncat, nan, nwater, sides = sol_melec(data)
IL_simulations.topelec(dict,top_dir, top_ion_dir, data, ncat, nan, nwater)
IL_simulations.pack_input_elec(data, pdb_dir, ncat, nan, nwater, sides)
IL_simulations.mdp_files()


println("TWOIL")

