using IL_simulations

top_dir   = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/VSIL/ITP"
input_dir = "/home/viniciusp/Documents/doutorado/ANALYSE/Repository/IL_simulations.jl/ubiquitin_files"

MM1     =  201.06
MMP     =  8560
cation1 = "BMIM"
anion1  = "NO3"
c       =  0.50

data = Data_il("$top_dir/ubq.pdb", MMP, cation1, anion1,MM1,c)


number_of_ions("ubq.pdb", MMP, cation1, anion1, MM1, c; cube=false)





