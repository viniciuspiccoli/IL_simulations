

@with_kw struct Data_il
  protein::String
  MMP::Float64

  cation::String
  anion::String

  MM::Float64  
  c::Float64

  cat_atomtypes::String = "$(cation)_atomtypes_VSIL.itp"
  cat_par::String = "$(cation)_VSIL.itp"

  an_atomtypes::String = "$(anion)_atomtypes_VSIL.itp"
  an_par::String = "$(anion)_VSIL.itp" 
end

struct Data_2il
  Protein::String
  MMP::Float64
  cation::String
  anion::String
  anion2::String
  
  MM1::Float64
  MM2::Float64
  c::Float64
end

struct Data_elec
  cation::String
  anion::String
  
  MM::Float64  
  c::Float64
end

struct Data_twoelec
  cation::String
  anion1::String  
  MM1::Float64 
  anion2::String  
  MM2::Float64 

  c::Float64
end

