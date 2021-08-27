    
  using PDBTools, ComplexMixtures

  # basic selections
  atoms   = readPDB(systemPDB)
  prot    = select(atoms, "Protein")
  solute  = Selection(prot,nmols=1)

  # selections for solvent components
  solv    = select(atoms,"resname EMIM")
  cation = Selection(solv, natomspermol=20)
  
  solv    = select(atoms,"resname Cl")
  anion  = Selection(solv, natomspermol=1)
  
  solv    = select(atoms, "resname SOL")
  water  = Selection(solv, natomspermol=3)

  # options for the calculation
  options = ComplexMixtures.Options(dbulk=20.,GC=true,GC_threshold=0.5)

  # cation calculation
  trajectory = Trajectory("processed.xtc",solute,solvent)
  results = mddf(trajectory, options)
  write(results,"gmd_EMIM.dat")

  # anion calculation
  trajectory = Trajectory("processed.xtc",solute,solvent)
  results = mddf(trajectory, options)
  write(results,"gmd_Cl.dat")

  # water calculation
  trajectory = Trajectory("processed.xtc",solute,solvent)
  results = mddf(trajectory, options)
  write(results,"gmd_SOL.dat")


