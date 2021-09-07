# function to calculate the molar mass of an ionic liquid
function molarmass(anion, cation, pdb_dir)
  atcation = readPDB("$pdb_dir/$(cation)_VSIL.pdb")
  atanion  = readPDB("$pdb_dir/$(anion)_VSIL.pdb")
  MMIL = mass(atcation) + mass(atanion)
  return MMIL
end
