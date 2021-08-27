


# cd $PBS_O_WORKDIR
# export PATH=$PATH:/home/viniciusp/programas/julia-1.5.0/bin
# source /etc/profile.d/modules.sh
# echo "hostname " `hostname`
# cd $run
#
#
# julia -t 8 /home/viniciusp/doutorado/sub_mddf/mddf_kbi_BF4NO3.jl
#
# parte que eu preciso submeter para rodar o programa
# 



#  # Function to calculate mean results taking all the simulations performed
#  function final_results(trajs,results::Vector{CM.Result},solute,solvent,options)
#    for i in 1:length(trajs)
#      trajectory = CM.Trajectory(trajs[i],solute,solvent)
#      results[i] = CM.mddf(trajectory,options)
#    end
#    return CM.merge(results)
#  end
#
## data
#  ils   = [ "EMIMBF4NO3"]     # , "EMIMDCANO3", "EMIMBF4NO3"]
#  concs = ["1.00", "1.50" , "2.00", "2.50", "3.00"]
#  trajs = ["./00/processed.xtc", "./01/processed.xtc", "./02/processed.xtc","./03/processed.xtc", "./04/processed.xtc", "./05/processed.xtc","./06/processed.xtc", "./07/processed.xtc", "./08/processed.xtc","./09/processed.xtc", "./10/processed.xtc", "./11/processed.xtc","./12/processed.xtc", "./13/processed.xtc", "./14/processed.xtc","./15/processed.xtc", "./16/processed.xtc", "./17/processed.xtc","./18/processed.xtc", "./19/processed.xtc", "./20/processed.xtc"]
#
#
#for il in ils # loop through the ionic liquids
#
#    for c in concs # loop through the concentrations simulated
#
#      cd("/home/viniciusp/doutorado/$il/$c")
#
#      # solute - protein
#      atoms   = PDBTools.readPDB("./00/processed.pdb")
#      protein = PDBTools.select(atoms,"not resname SOL and not resname EMI and not resname BF4 and not resname NO3")
#      solute  = CM.Selection(protein,nmols=1)
#
#      options = CM.Options(dbulk=20.,GC=true,GC_threshold=0.5)
#
#      # vectors
#      resultts_wat = Vector{CM.Result}(undef,21)
#      resultts_cat = Vector{CM.Result}(undef,21)
#      resultts_an1 = Vector{CM.Result}(undef,21)
#      resultts_an2 = Vector{CM.Result}(undef,21)
#      resultts_ans = Vector{CM.Result}(undef,21)
#
# # water
#      if isfile("gmd_sol.json")==false
#        water_sel =  PDBTools.select(atoms,"resname SOL")
#        water     =  CM.Selection(water_sel,natomspermol=3)
#
#        results_water = final_results(trajs,resultts_wat,solute,water,options)
#        CM.save(results_water, "gmd_sol.json")
#        CM.write(results_water,"gmd_sol_$c.dat")
#      end
#
#      # cation
#      if isfile("gmd_$(il[1:3]).json")==false
#        cation_sel =  PDBTools.select(atoms,"resname $(il[1:3])")
#        cation     =  CM.Selection(cation_sel,natomspermol=20)
#
#        results_cation = final_results(trajs, resultts_cat, solute, cation, options)
#        CM.save(results_cation,  "gmd_$(il[1:3]).json")
#        CM.write(results_cation, "gmd_$(il[1:3])_$c.dat")
#      end
#
#      # anion 1
#      if isfile("gmd_$(il[5:7]).json")==false
#        anion1_sel =  PDBTools.select(atoms,"resname $(il[5:7])")
#        anion1     =  CM.Selection(anion1_sel,natomspermol=5)
#
#        results_an1 = final_results(trajs,resultts_an1,solute,anion1,options)
#        CM.save(results_an1, "gmd_$(il[5:7]).json")
#        CM.write(results_an1,"gmd_$(il[5:7])_$c.dat")
#      else
#   # anion 2
#      if isfile("gmd_NO3.json")==false
#        anion2_sel =  PDBTools.select(atoms,"resname NO3")
#        anion2     =  CM.Selection(anion2_sel,natomspermol=4)
#
#
#        results_an2 = final_results(trajs,resultts_an2,solute,anion2,options)
#        CM.save(results_an2, "gmd_NO3.json")
#        CM.write(results_an2,"gmd_NO3_$c.dat")
#      end
#
#      # anions as one component
#      if isfile("gmd_$(il[5:7])_$(il[8:10]).json")==false
#        anions_sel =  PDBTools.select(atoms,"resname $(il[5:7]) or resname $(il[8:10])")
#        anions     =  CM.Selection(anions_sel,natomspermol=9)
#
#        results_ans = final_results(trajs,resultts_ans,solute,anions,options)
#        CM.save(results_ans, "gmd_$(il[5:7])_$(il[8:10]).json")
#        CM.write(results_ans,"gmd_$(il[5:7])_$(il[8:10])_$c.dat")
#      end
#    end
#
#  end
#end


# PRECISO FAZER UM FUNÇÃO QUE PEGA MAKE_CMRUN E EXECUTA A PARTIR DOS DADOS
# PRECISO DE UMA FUNCAÇÃO QUE CALCULA O NÚMERO DE ÁTOMOS DE CADA COMPONENTE
#
# using ComplexMixtures, PDBTools; const CM=ComplexMixtures

function make_CMrun(data, systemPDB, natoms::Vector)
  io = open("analysis.jl","w")
  an = data.anion
  cat = data.cation 
  println(io,"""    
  using PDBTools, ComplexMixtures

  # basic selections
  atoms   = readPDB(systemPDB)
  prot    = select(atoms, "Protein")
  solute  = Selection(prot,nmols=1)

  # selections for solvent components
  solv    = select(atoms,"resname $(cat[1:3])")
  cation = Selection(solv, natomspermol=$(natoms[1]))
  
  solv    = select(atoms,"resname $(an)")
  anion  = Selection(solv, natomspermol=$(natoms[2]))
  
  solv    = select(atoms, "resname SOL")
  water  = Selection(solv, natomspermol=3)

  # options for the calculation
  options = ComplexMixtures.Options(dbulk=20.,GC=true,GC_threshold=0.5)

  # cation calculation
  trajectory = Trajectory("processed.xtc",solute,cation)
  results = mddf(trajectory, options)
  write(results,"gmd_$(cat[1:3]).dat")

  # anion calculation
  trajectory = Trajectory("processed.xtc",solute,anion)
  results = mddf(trajectory, options)
  write(results,"gmd_$(an).dat")

  # water calculation
  trajectory = Trajectory("processed.xtc",solute,water)
  results = mddf(trajectory, options)
  write(results,"gmd_SOL.dat")

""")

end

# function that will aplly make_CMrun with data and the number of atoms of each solvent molecule
function analyzeIN(pdb_dir, data)

  cationPDB = "$(data.cation)_VSIL.pdb"
  anionPDB  = "$(data.anion)_VSIL.pdb"
  
  ncation = length(PDBTools.readPDB("$pdb_dir/$cationPDB"))
  nanion  = length(PDBTools.readPDB("$pdb_dir/$anionPDB"))
  
  protein = data.protein
  systemPDB = "$(pdb_dir)/$protein"
  make_CMrun(data,systemPDB,[ncation, nanion])
  
end


