using IL_simulations


top_dir   = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
input_dir = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"

MM1     =  201.06
MMP     =  8560.
cation1 = "BMIM"
anion1  = "NO3"
c       =  2.50

data = IL_simulations.Data_il(protein="$input_dir/ubq.pdb", MMP = MMP, cation = cation1, anion = anion1,MM = MM1,c=c)
nions, nwater, sides = number_of_ions(data)

input_dir = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files/topol.top"




#Topology(dict, top_dir, input_dir, data, nions, nwater)





