using Parameters

struct Data_il
  Protein::String
  MMP::Float64
  cation::String
  anion::String
  
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

