###############################################################################
#Calculation of the number of the ions given a concentration and the MM of the# 
###############################################################################

export prot_elec
using PDBTools


# One IL + Water
function sol_elec(data)

  cation1 = data.cation 
  anion1  = data.anion

  MM1  = data.MM
  c    = data.c

  lx = 50
  ly = 50 
  lz = 50

  sides = [lx, ly, lz]

  vsol   = lx*ly*lz*1.e-27                                        # Volume (total=solution) / L  
  nions  = round(Int64, vsol * c * 6.02e23)                       # number of ions 
  vions  = nions * MM1 * 1.e-3 / (6.02e23)                        # volume occupied by the ions
  nwater = round(Int64,(vsol - vions) * 6.02e23 / (18*1.e-3))     # number of water molecules to fill the box

  return nions, nwater, sides

end






# concentration calc based on Professor Leandro's script
# conversion factor from mL/mol to Å^3/molecule
const CMV = 1e24 / 6.02e23

# conversion factor from mol/L to molecules/Å^3
const CMC = 6.02e23 / 1e27

"""
Interpolate a value from a (x,y) data matrix
"""
function interpolate(x, ρ)
    i = findfirst(d -> d > x, ρ[:, 1])
    dρdx = (ρ[i, 2] - ρ[i-1, 2]) / (ρ[i, 1] - ρ[i-1, 1])
    d = ρ[i-1, 2] + dρdx * (x - ρ[i-1, 1])
    return d
end

"""
Find by bisection which is the molar fraction that is consistent
with a desired volume fraction (%), given a data table of densities
as a function of the molar fractions.
"""
function find_x(
    vv, 
    cossolvent_mass, 
    density_pure, 
    densities::Matrix;
    tol=1e-5, 
    maxit=1000)

    xl = densities[1, 1]
    xr = densities[end, 1]
    if xl < xr
        increasing = true
    else
        increasing = false
    end
    x = (xr - xl) / 2
    xnew = convert_c(
        vv, "%vv" => "x", density=interpolate(x, densities),
        molar_mass=cossolvent_mass, density_pure=density_pure
    )
    it = 0
    while abs(xnew - x) > tol
        if xnew > x
            increasing ? xl = x : xr = x
        else
            increasing ? xr = x : xl = x
        end
        x = (xr + xl) / 2
        xnew = convert_c(
            vv, "%vv" => "x", density=interpolate(x, densities),
            molar_mass=cossolvent_mass, density_pure=density_pure
        )
        it += 1
        it > maxit && error("Maximum number of iterations achieved.")
    end
    return x
end

"""
Convert concentrations.
"""
function convert_c(
    cin, units;
    density=nothing, # solution
    density_pure=nothing, # cossolvent
    molar_mass=18.0, # cossolvent
    molar_mass_water=18.0,
    density_water=1.0
)

    # If the units didn't change, just return the input concentrations
    units[1] == units[2] && return cin

    ρ = density # density of the solution
    ρc = density_pure # density of the pure cossolvent
    Mw = molar_mass_water # molar mass of water
    Mc = molar_mass # molar mass of the cossolvent

    # nc and nw are the molar concentrations
    if units[1] == "%vv"
        if isnothing(ρc)
            error("Density of pure solvent is required to convert from %vv.")
        end
        vv = cin / 100
        nc = (ρc * vv / Mc)
        if units[2] == "x"
            if isnothing(ρ)
                error("Density of solution is required to convert to molar fraction.")
            end
            nw = (ρ - nc * Mc) / Mw
            return nc / (nc + nw)
        end
        if units[2] == "mol/L"
            return 1000 * nc
        end
    end

    if units[1] == "x"
        if isnothing(ρ)
            error("Density of solution is required to convert from molar fraction.")
        end
        x = cin
        nc = ρ / (Mc + Mw * (1 - x) / x)
        if units[2] == "mol/L"
            return 1000 * nc
        end
        if units[2] == "%vv"
            if isnothing(ρc)
                error("Density of pure solvent is required to convert to %vv.")
            end
            nw = nc * (1 - x) / x
            Vc = nc * Mc / ρc
            vv = 100 * Vc
            return vv
        end
    end

    if units[1] == "mol/L"
        if isnothing(ρ)
            error("Density of solution is required to convert from molarity.")
        end
        nc = cin / 1000
        nw = (ρ - nc * Mc) / Mw
        if units[2] == "x"
            return nc / (nc + nw)
        end
        if units[2] == "%vv"
            if isnothing(ρc)
                error("Density of pure solvent is required to convert to %vv.")
                return nothing
            end
            Vc = nc * Mc / ρc
            vv = 100 * Vc
            return vv
        end
    end

end

"""
Function that generates an input file for Packmol. By default, the concentrations is given in mol/L, but it can also be given in molar fraction "x" or volume percentage "%vv", using `cunit="x"` or `cunit="%vv"`. 
"""
function write_input(
    pdbfile::String, solvent_file::String, concentration::Real, box_side::Real;
    water_file="tip3p.pdb",
    density=1.0,
    density_pure_solvent=nothing,
    cunit="mol/L",
    packmol_input="box.inp",
    packmol_output="system.pdb")

    protein = readPDB(pdbfile)
    cossolvent = readPDB(solvent_file)

    # molar masses (g/mol)
    Mp = mass(protein)
    Mc = mass(cossolvent)
    Mw = 18.01528 # for water

    # aliases for clearer formulas
    ρ = density # of the solution
    ρc = density_pure_solvent # of the pure solvent

    # Convert concentration to mol/L
    cc_mol = convert_c(concentration, cunit => "mol/L", density=ρ, density_pure=ρc, molar_mass=Mc)
    c_vv = convert_c(concentration, cunit => "%vv", density=ρ, density_pure=ρc, molar_mass=Mc)
    c_x = convert_c(concentration, cunit => "x", density=ρ, density_pure=ρc, molar_mass=Mc)

    # Convert cossolvent concentration in molecules/Å³
    cc = CMC * cc_mol

    # Box volume (Å³)
    vbox = box_side^3

    # Solution volume (vbox - vprotein)
    vs = vbox - CMV * Mp / ρ

    # number of cossolvent molecules: cossolvent concentration × volume of the solution
    nc = round(Int, cc * vs)

    #
    # number of water molecules, obtained from the mass difference
    #
    # nc (molecules) / NA (mol) * Mc (g/mol) is the mass of the cossolvent molecules
    # ρ*vs is the total mass of the solution (density (g/L) × volume (L) 
    # ρ*vs - (nc/NA)*Mc is the mass of water in the solution (g)
    # (ρ*vs - (nc/NA)*Mc)/Mw is the number of mols of water in the solution (mol)
    # NA*(ρ*vs - (nc/NA)*Mc)/Mw is the number of water molcules
    # rearranging: nw = (NA*ρ*vs - nc*Mc)/Mw 
    # But since we have vs in Å³, we need the conversion vs = vs / 1e24, and we have
    # nw = (NA*ρ*vs/1e24 - nc*Mc)/Mw 
    # given that CMV = 1e24/NA, we have nw = (ρ*vs/CMV - nc*Mc)/Mw
    nw = round(Int, (ρ * vs / CMV - nc * Mc) / Mw)

    # Final density of the solution
    ρ = CMV * (Mc * nc + Mw * nw) / vs

    # Final cossolvent concentration (mol/L)
    cc_f = 1000 * (nc / vs) * CMV

    # Final water concentration (mol/L)
    cw_f = 1000 * (nw / vs) * CMV

    # Final recovered concentration in %vv
    vv = 100 * CMV * (nc * Mc / ρc) / vs

    println(
        """
        Summary:
        ========
        Target concentration = $cc_mol mol/L
                             = $c_vv %vv
                             = $c_x x
                             = $cc molecules/Å³
        Box volume = $vbox Å³
        Solution volume = $vs Å³   
        Density = $ρ g/mL
        Protein molar mass = $Mp g/mol
        Cossolvent molar mass = $Mc g/mol
        Number of cossolvent molecules = $nc molecules
        Number of water molecules = $nw molecules
        Final cossolvent concentration = $cc_f mol/L
        Final water concentration = $cw_f mol/L
                                  = $(CMC*cw_f) molecules/Å³
        Final solvent density = $ρ g/mL
        Final %vv concentration = $vv %
        Final molar fraction = $(nc/(nc+nw))
        """)

    l = box_side / 2
    open(packmol_input, "w") do io
        println(io,
            """
            tolerance 2.0
            output $packmol_output
            add_box_sides 1.0
            filetype pdb
            seed -1
            structure $pdbfile
              number 1
              center
              fixed 0. 0. 0. 0. 0. 0.
            end structure
            structure $water_file
              number $nw
              inside box -$l -$l -$l $l $l $l
            end structure
            """)
        if nc > 0
            println(io,
                """
                structure $solvent_file
                  number $nc
                  inside box -$l -$l -$l $l $l $l
                end structure
                """)
        end
    end
    println("Wrote file: $packmol_input")

end # function write_input

end # module




# example of input

#=

#
# run with julia AAQAA_60vv.jl 
#

using PackmolInputCreator

# Directory where this script is hosted
script_dir = @__DIR__

# Density as a function of molar fraction of TFE
#   FE mol frac  Density (g/mL) ref: https://doi.org/10.1023/A:1005147318013
ρ = [ 0.00       0.99707       
      0.00130    0.99931       
      0.00178    1.00013       
      0.00264    1.00161       
      0.00318    1.00253       
      0.00587    1.00711       
      0.00792    1.01061       
      0.00841    1.01145       
      0.01362    1.02009       
      0.01550    1.02331       
      0.01966    1.03032       
      0.02837    1.04416       
      0.04430    1.06827       
      0.06485    1.09668       
      0.07171    1.10545       
      0.08744    1.12449       
      0.1071     1.14364       
      0.1526     1.18115       
      0.2126     1.22017       
      0.2960     1.26039       
      0.4245     1.30204       
      0.6088     1.33868       
      0.7820     1.36029       
      0.9451     1.37873       
      1.0000     1.38217  ]

# What we want
concentration = 50.0 #%vv

# Find to what molar fraction this volume fraction corresponds
x = find_x(concentration, 100.4, 1.38217, ρ)
println("Molar fraction = $x")

# Iterpolate to get density given molar fraction
density = interpolate(x,ρ)
println("Density = $density")

data_dir="$script_dir/../InputData"
pdbfile = "$data_dir/PDB/AAQAA.pdb"
solvent_file = "$data_dir/PDB/tfe.pdb"
water_file = "$data_dir/PDB/tip4p2005.pdb"
box_size = 56.

write_input(pdbfile, solvent_file, concentration, box_size,
            water_file=water_file,
            density=density,
            density_pure_solvent=1.38217,
            box_file="box.inp",cunit="%vv")

=#
