    
  using PDBTools, ComplexMixtures

  # basic selections
  atoms   = readPDB(systemPDB)
  prot    = select(atoms, "Protein")
  solute  = Selection(prot,nmols=1)

  # selections for solvent components
  solv    = select(atoms,"resname BMI")
  cation = Selection(solv, natomspermol=26)
  
  solv    = select(atoms,"resname NO3")
  anion  = Selection(solv, natomspermol=4)
  
  solv    = select(atoms, "resname SOL")
  water  = Selection(solv, natomspermol=3)

  # options for the calculation
  options = ComplexMixtures.Options(dbulk=20.,GC=true,GC_threshold=0.5)

  # cation calculation
  trajectory = Trajectory("processed.xtc",solute,cation)
  results = mddf(trajectory, options)
  write(results,"gmd_BMI.dat")

  # anion calculation
  trajectory = Trajectory("processed.xtc",solute,anion)
  results = mddf(trajectory, options)
  write(results,"gmd_NO3.dat")

  # water calculation
  trajectory = Trajectory("processed.xtc",solute,water)
  results = mddf(trajectory, options)
  write(results,"gmd_SOL.dat")


