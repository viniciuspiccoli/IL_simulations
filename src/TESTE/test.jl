# example of input

using IL_simulations, PDBTools

top_dir     =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
pdb_dir     =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/PDB"
input_dir   =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"
top_ion_dir =  "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ion_files"


atoms   = readPDB("$input_dir/ubq.pdb")
MMP     = mass(atoms)

#cation1 = "BMIM"
#anion1  = "NO3"
#anion2  = "DCA" 

function molarmass(anion, cation, pdb_dir)
  atcation = readPDB("$pdb_dir/$(cation)_VSIL.pdb")
  atanion  = readPDB("$pdb_dir/$(anion)_VSIL.pdb")    
  MMIL = mass(atcation) + mass(atanion)
  return MMIL 
end

#MMIL  = molarmass(anion1, cation1, pdb_dir)
#MMIL2 = molarmass(anion2, cation1, pdb_dir)
#c       =  0.10
#
### test with one IL/salt and a protein/polymer
##cd("PONEIL")
##newil = EMIMCL
#
cation = "EMIM"
anion  = "Cl"
il     = "$(cation)$(anion)"
MMIL = molarmass(anion, cation, pdb_dir)
dir = pwd();
for i in ["0.50", "1.00", "1.50", "2.00", "2.50", "3.00"]
  for j in ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19","20"]
    cd("$dir/$il/$i/$j")
    conc = parse(Float64,i) 
    data = IL_simulations.Data_il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation, anion = anion,MM = MMIL,c=conc)
    nions, nwater, sides = prot_elec(data)
    IL_simulations.top(dict, top_dir, input_dir, data, nions, nwater)
    IL_simulations.pack_input(data,pdb_dir,nions,nwater,sides)
    IL_simulations.mdp_files_solute()
    IL_simulations.posre(input_dir)
    IL_simulations.analyzeIN(pdb_dir,data)
  end
end


## mixed system
#cation = "EMIM"
#anion1  = "Cl"
#anion2 = "NO3"
#il = "$(cation)$(anion1)$(anion2)"
#MMIL1 = molarmass(anion1, cation, pdb_dir)
#MMIL2 = molarmass(anion2, cation, pdb_dir)
#dir = pwd();
#for i in ["0.50", "1.00", "1.50", "2.00", "2.50", "3.00"]
#  for j in ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19","20"]
#    cd("$dir/$il/$i/$j")
#    conc = parse(Float64,i) 
#    data = IL_simulations.Data_2il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation, anion1 = anion1, anion2 = anion2, MM1 = MMIL1, MM2 = MMIL2 , c=conc)
#    ncat, nan, nwater, sides = prot_melec(data)
#    println("data for the simulation")
#    println("ncations = $ncat")
#    println("nanions = $nan and $nan")
#    IL_simulations.top(dict, top_dir, input_dir, data, ncat, nan, nwater)
#    println("passou da topologia")
#    IL_simulations.pack_input(data,pdb_dir, ncat, nan, nwater,sides)
#    IL_simulations.mdp_files_solute(input_dir)
#    IL_simulations.posre(input_dir)
#    IL_simulations.analyzeIN2(pdb_dir,data)
#  end
#end


# test with two ILs/salts and a protein/polymer -same cation
#cd("../PTWOIL")
#data = IL_simulations.Data_2il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation1, anion1 = anion1, anion2 = anion2, MM1 = MMIL, MM2 = MMIL2,c=c)
#ncat, nan, nwater, sides = prot_melec(data)
#IL_simulations.top(dict, top_dir, input_dir, data, ncat, nan, nwater)
#IL_simulations.pack_input(data, pdb_dir, ncat, nan, nwater, sides)
#IL_simulations.mdp_files()




#println("PONEIL")
## test with one IL/salt
#cd("../ONEIL") 
#data = IL_simulations.Data_elec(cation = cation1, anion = anion1, MM = MMIL,c=c)
#nions, nwater, sides = sol_elec(data)
#IL_simulations.topelec(dict, top_dir, top_ion_dir, data, nions, nwater)
#IL_simulations.pack_input_sol(data,pdb_dir,nions,nwater,sides)
#IL_simulations.mdp_files()

#println("ONEIL")

#println("PTWOIL")

### test with two ILs/salts - same cation
#cd("../TWOIL")
#data = IL_simulations.Data_twoelec(cation = cation1, anion1 = anion1, anion2 = anion2 , MM1 = MMIL, MM2 = MMIL2, c=c)
#ncat, nan, nwater, sides = sol_melec(data)
#IL_simulations.topelec(dict,top_dir, top_ion_dir, data, ncat, nan, nwater)
#IL_simulations.pack_input_elec(data, pdb_dir, ncat, nan, nwater, sides)
#IL_simulations.mdp_files()
#
#
#println("TWOIL")

