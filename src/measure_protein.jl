#Function to measue the maximum dimensions (in each dimensions) of the protein
  export measure_prot
  function measure_prot(nome, side)
  
  ## Variables - Measurement of the protein(X, Y and Z axis)
    pdbfile = nome
    segment = "all"
    restype = "all"
    atomtype = "all"
    firstatom = "all"
    lastatom = "all"
  
  ## Open the file - 
    file = open("$pdbfile","r+")
    
    ## variables to compute the size of the protein
    natoms = 0
    var = 0

    for line in eachline(file)
  
      data = split(line)
      consider = false
      if data[1] == "ATOM" || data[1] == "HEATOM"
        natoms = natoms + 1
      #  ss = data[11]
      #  rt = data[4]
      #  at = data[3]
        consider = true
      else
        continue
      end  
  
      if firstatom != "all"
        if natoms < firstatom
          consider = false
        end
      end
  
      if lastatom != "all"    
        if natoms > lastatom  
          consider = false                                  
        end                    
      end                      
  
      if segment != "all"    
        if ss != segment  
          consider = false     
        end                    
      end                      
  
      if restype != "all"    
        if rt != restype  
          consider = false     
        end                    
      end                      
  
      if atomtype != "all"    
        if at != atomtype  
          consider = false     
        end                    
      end  
  
      if consider == true
        global x = parse(Float64,data[7])
        global y = parse(Float64,data[8])
        global z = parse(Float64,data[9])
      end
      
      if var == 1
        if x < xmin
            xmin = x
        end
        if y < ymin
            ymin = y
        end
        if z < zmin
            zmin = z
        end
        if x > xmax
            xmax = x
        end
        if y > ymax
            ymax = y
        end
        if z > zmax
            zmax = z
        end
      else
  
        global   xmin = x
        global   ymin = y
        global   zmin = z
        global   xmax = x
        global   ymax = y
        global   zmax = z
        var = 1
  
      end
  
    end
   
    ## Box size
    bx = round(Int,((xmax - xmin) + side + side)) 
    by = round(Int,((ymax - ymin) + side + side))
    bz = round(Int,((zmax - zmin) + side + side))
    
    close(file)  

    cfile = open("$pdbfile","r+")

    # charge calculation
    charge = 0
    nhis   = 0
    narg   = 0
    nlys   = 0
    nglu   = 0
    nasp   = 0 

    #mass=0

    marker = 0


    for line in eachline(cfile)
      data = split(line) 
      if data[1] == "ATOM" || data[1] == "HEATOM"
        if data[4]=="HIS" || data[4]=="HSD" && marker != data[6]
          nhis = nhis + 1 
          marker = data[6]
        elseif data[4]=="ARG" && marker != data[6]
          narg = narg + 1 
          marker = data[6]
        elseif data[4]=="LYS" && marker != data[6]
          nlys = nlys + 1
          marker = data[6]
        elseif data[4]=="GLU" && marker != data[6]
          nglu = nglu + 1
          marker = data[6]
        elseif data[4]=="ASP" && marker != data[6]
          nasp = nasp + 1
          marker = data[6]
        end
      end
    end
    close(cfile)
     
    charge = (nhis * 0)  + (narg * (+1)) + (nlys * (+1)) + (nglu * (-1)) + (nasp * (-1))

    return bx , by, bz, charge
  
  end
