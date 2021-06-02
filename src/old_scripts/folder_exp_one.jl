# vinicius- creation of the system directory
# Legend of the systems: 020 = 0.5, 0.35 = 1.0, 0.50 = 1.5, 0.65 = 2.0, 0.80 = 2.5, 0.95 = 3.0

  include("input_gen_one.jl")
" Example :: EMIMDCABF4 - The system will contain: EMIM (two mols), DCA and BF4 (each one with one mole)"
  function folder(name::String,MM1)
    concs  = ["0.50", "1.00", "1.50", "2.00", "2.50", "3.00"] 
    replic = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11","12", "13", "14", "15", "16", "17", "18", "19", "20"]
    gmds = ["gmd_an1.inp","gmd_sol.inp", "gmd_ca1.inp"] 
      
   
    println("entrou")

    main_dir = pwd()
    for c in concs
      for r in replic
        
        work_dir = joinpath(main_dir,name,c,r)
        cil = parse(Float64,c)            
        cd(work_dir)
        conc(MM1,"$(name[1:4])","$(name[5:7])",cil)
             
        for file in gmds
          w = open(file,"r+") 
          new = open("gmdx_$(file[5:7]).inp","w")
          
          # change names
          for line in eachline(w)
            if occursin("AN1",line)
              if "$(name[5:7])" == "DCA"
                println(new,replace(line, "AN1" => "NC", count=1))
              elseif "$(name[5:7])" == "BF4"
                println(new,replace(line, "AN1" => "BF4", count=1))
              elseif "$(name[5:7])" == "NO3"
                println(new,replace(line, "AN1" => "NO3", count=1))
              elseif  "$(name[5:7])" == "SCN"
                println(new,replace(line, "AN1" => "SCN", count=1))
              elseif  "$(name[5:7])" == "Cl "
                println(new,replace(line, "AN1" => "Cl ", count=1))
              end  
            elseif occursin("dist",line)
              println(new,replace(line, "dist" => "20", count=1))
            elseif  occursin("CA1",line)
              println(new,replace(line, "CA1" => "$(name[1:3])", count=1))
            else
              println(new,line)
            end  
            
          end
          close(new) 
          close(w) 
          
          rm(file) 
          
        end

        cd(main_dir) 
      end
    end
  end  
    
   
  folder("BMIMNO3",201.06) 

