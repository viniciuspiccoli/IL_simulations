using Parameters

@with_kw Struct Data_il
  Protein::String
  MMP::Float64

  cation::String
  anion::String

  cat_atomtypes="$(cation)_atomtypes_VSIL.itp"
  cat_par="$(cation)_VSIL.itp"

  an_atomtypes="$(anion)_atomtypes_VSIL.itp"
  an_par="$(anion)_VSIL.itp"
  
  MM::Float64  
  c::Float64
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

