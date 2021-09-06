function posre(topdir)
 # posre.itp file
  file   = open("$topdir/posre.itp","r+")
  file_new = open("./posre.itp","w")
  for line in eachline(file)
    println(file_new,line)
  end
  close(file)
  close(file_new) 
end


### functoin to print mdp_files

function mdp_files_solute()
  
 

  # minimization
  file = open("mim.mdp", "w")
  println(file,"""
  ;Parameters describing what to do, when to stop and what to save
  integrator  = steep         ; Algorithm (steep = steepest descent minimization)
  emtol       = 100.0        ; Stop minimization when the maximum force < 100.0 kJ/mol/nm
  emstep      = 0.01          ; Minimization step size
  nsteps      = 50000         ; Maximum number of (minimization) steps to perform
  
  ; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
  nstlist         = 1         ; Frequency to update the neighbor list and long range forces
  cutoff-scheme   = Verlet    ; Buffered neighbor searching
  ns_type         = grid      ; Method to determine neighbor list (simple, grid)
  coulombtype     = PME       ; Treatment of long range electrostatic interactions
  rcoulomb        = 1.0       ; Short-range electrostatic cut-off
  rvdw            = 1.0       ; Short-range Van der Waals cut-off
  pbc             = xyz       ; Periodic Boundary Conditions in all 3 dimensions
  """)
  close(file)
  
  # NVT equilibration
  file=open("nvt.mdp","w")
  println(file,"""
  ; title                   = OPLS Ubiquitin solvated by water with a ionicliquid being a cosolute NVT equilibration 
  define                  = -DPOSRES  ; position restrain the protein
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 500000     ; 2 * 50000 = 1000 ps
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 5000       ; save coordinates every 1.0 ps
  nstvout                 = 5000       ; save velocities every 1.0 ps
  nstenergy               = 5000       ; save energies every 1.0 ps
  nstlog                  = 5000       ; update log file every 1.0 ps
  ; Bond parameters
  
  continuation            = no        ; first dynamics run
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Nonbonded settings 
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
  tau_t                   = 0.1     0.1           ; time constant, in ps
  ref_t                   = 300     300           ; reference temperature, one for each group, in K
  ; Pressure coupling is off
  pcoupl                  = no        ; no pressure coupling in NVT
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Velocity generation
  gen_vel                 = yes       ; assign velocities from Maxwell distribution
  gen_temp                = 300       ; temperature for Maxwell distribution
  gen_seed                = -1        ; generate a random seed
  
  ;freezegrps              = Protein
  ;freezedim               = X Y Z
  """)
  close(file)
  
  
  
  
  # NPT equilibration
  file=open("npt.mdp","w")
  println(file,"""
  ; title                   =OPLSsystem  NPT equilibration 
  define                  = -DPOSRES  ; position restrain the protein
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 2500000    ; 2 * 2500000 = 5000 ps
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 0       ; save coordinates every 1.0 ps
  nstvout                 = 0      ; save velocities every 1.0 ps
  nstenergy               = 50000       ; save energies every 1.0 ps
  nstlog                  = 50000       ; update log file every 1.0 ps
  ; Bond parameters
  continuation            = yes       ; Restarting after NVT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = all-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Nonbonded settings 
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
  tau_t                   = 0.1     0.1           ; time constant, in ps
  ref_t                   = 300     300           ; reference temperature, one for each group, in K
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  refcoord_scaling        = com
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off """)
  close(file)
  
  # free simulation
  file=open("md.mdp","w")
  println(file,"""
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 500000    ; 2 * 500000 = 1000 ps (1 ns)
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 0         ; suppress bulky .trr file by specifying 
  nstvout                 = 0         ; 0 for output frequency of nstxout,
  nstfout                 = 0         ; nstvout, and nstfout
  nstenergy               = 5000      ; save energies every 10.0 ps
  nstlog                  = 5000      ; update log file every 10.0 ps
  nstxout-compressed      = 5000      ; save compressed coordinates every 10.0 ps
  compressed-x-grps       = System    ; save the whole system
  ; Bond parameters
  continuation            = yes       ; Restarting after NPT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Neighborsearching
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
  tau_t                   = 0.1     0.1           ; time constant, in ps
  ref_t                   = 300     300           ; reference temperature, one for each group, in K
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  ; Periodic boundary conditions
  pbc                     = xyz      ; 3-D PBC
  ; Dispersion correction
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off """)
  close(file)
  
  # production
  file=open("md_prod.mdp","w")
  println(file,"""
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 5000000    ; 2 *5000000 =10000 ps (10 ns)
  dt                      = 0.002     ; 2 fs
  tinit                   = 1000      ; we have already simulated 1000 ps
  ; Output control
  nstxout                 = 0         ; suppress bulky .trr file by specifying 
  nstvout                 = 0         ; 0 for output frequency of nstxout,
  nstfout                 = 0         ; nstvout, and nstfout
  nstenergy               = 5000      ; save energies every 100.0 ps
  nstlog                  = 5000      ; update log file every 100.0 ps
  nstxout-compressed      = 5000      ; save compressed coordinates every 100.0 ps
  compressed-x-grps       = System    ; save the whole system
  ; Bond parameters
  continuation            = yes       ; Restarting after NPT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Neighborsearching
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = Protein Non-Protein   ; two coupling groups - more accurate
  tau_t                   = 0.1     0.1           ; time constant, in ps
  ref_t                   = 300     300           ; reference temperature, one for each group, in K
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Dispersion correction
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off 
  
  ;energygrps = Protein SOL BMI BF4 NO3""")
  close(file)

end


function mdp_files()
  # minimization
  file = open("mim.mdp", "w")
  println(file,"""
  ;Parameters describing what to do, when to stop and what to save
  integrator  = steep         ; Algorithm (steep = steepest descent minimization)
  emtol       = 100.0        ; Stop minimization when the maximum force < 100.0 kJ/mol/nm
  emstep      = 0.01          ; Minimization step size
  nsteps      = 50000         ; Maximum number of (minimization) steps to perform
  
  ; Parameters describing how to find the neighbors of each atom and how to calculate the interactions
  nstlist         = 1         ; Frequency to update the neighbor list and long range forces
  cutoff-scheme   = Verlet    ; Buffered neighbor searching
  ns_type         = grid      ; Method to determine neighbor list (simple, grid)
  coulombtype     = PME       ; Treatment of long range electrostatic interactions
  rcoulomb        = 1.0       ; Short-range electrostatic cut-off
  rvdw            = 1.0       ; Short-range Van der Waals cut-off
  pbc             = xyz       ; Periodic Boundary Conditions in all 3 dimensions
  """)
  close(file)
  
  # NVT equilibration
  file=open("nvt.mdp","w")
  println(file,"""
  ; title                   = OPLS Ubiquitin solvated by water with a ionicliquid being a cosolute NVT equilibration 
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 500000     ; 2 * 50000 = 1000 ps
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 5000       ; save coordinates every 1.0 ps
  nstvout                 = 5000       ; save velocities every 1.0 ps
  nstenergy               = 5000       ; save energies every 1.0 ps
  nstlog                  = 5000       ; update log file every 1.0 ps
  ; Bond parameters
  
  continuation            = no        ; first dynamics run
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Nonbonded settings 
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = System  
  tau_t                   = 0.1     
  ref_t                   = 300     
  ; Pressure coupling is off
  pcoupl                  = no        ; no pressure coupling in NVT
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Velocity generation
  gen_vel                 = yes       ; assign velocities from Maxwell distribution
  gen_temp                = 300       ; temperature for Maxwell distribution
  gen_seed                = -1        ; generate a random seed """)
  close(file)
  
  
  
 
  # NPT equilibration
  file=open("npt.mdp","w")
  println(file,"""
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 2500000    ; 2 * 2500000 = 5000 ps
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 0       ; save coordinates every 1.0 ps
  nstvout                 = 0      ; save velocities every 1.0 ps
  nstenergy               = 50000       ; save energies every 1.0 ps
  nstlog                  = 50000       ; update log file every 1.0 ps
  ; Bond parameters
  continuation            = yes       ; Restarting after NVT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = all-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Nonbonded settings 
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = System 
  tau_t                   = 0.1    
  ref_t                   = 300    
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  refcoord_scaling        = com
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off """)
  close(file)
  
  # free simulation
  file=open("md.mdp","w")
  println(file,"""
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 500000    ; 2 * 500000 = 1000 ps (1 ns)
  dt                      = 0.002     ; 2 fs
  ; Output control
  nstxout                 = 0         ; suppress bulky .trr file by specifying 
  nstvout                 = 0         ; 0 for output frequency of nstxout,
  nstfout                 = 0         ; nstvout, and nstfout
  nstenergy               = 5000      ; save energies every 10.0 ps
  nstlog                  = 5000      ; update log file every 10.0 ps
  nstxout-compressed      = 5000      ; save compressed coordinates every 10.0 ps
  compressed-x-grps       = System    ; save the whole system
  ; Bond parameters
  continuation            = yes       ; Restarting after NPT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Neighborsearching
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = System 
  tau_t                   = 0.1     
  ref_t                   = 300     
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  ; Periodic boundary conditions
  pbc                     = xyz      ; 3-D PBC
  ; Dispersion correction
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off """)
  close(file)
  
  # production
  file=open("md_prod.mdp","w")
  println(file,"""
  ; Run parameters
  integrator              = md        ; leap-frog integrator
  nsteps                  = 5000000    ; 2 *5000000 =10000 ps (10 ns)
  dt                      = 0.002     ; 2 fs
  tinit                   = 1000      ; we have already simulated 1000 ps
  ; Output control
  nstxout                 = 0         ; suppress bulky .trr file by specifying 
  nstvout                 = 0         ; 0 for output frequency of nstxout,
  nstfout                 = 0         ; nstvout, and nstfout
  nstenergy               = 5000      ; save energies every 100.0 ps
  nstlog                  = 5000      ; update log file every 100.0 ps
  nstxout-compressed      = 5000      ; save compressed coordinates every 100.0 ps
  compressed-x-grps       = System    ; save the whole system
  ; Bond parameters
  continuation            = yes       ; Restarting after NPT 
  constraint_algorithm    = lincs     ; holonomic constraints 
  constraints             = h-bonds   ; bonds involving H are constrained
  lincs_iter              = 1         ; accuracy of LINCS
  lincs_order             = 4         ; also related to accuracy
  ; Neighborsearching
  cutoff-scheme           = Verlet    ; Buffered neighbor searching
  ns_type                 = grid      ; search neighboring grid cells
  nstlist                 = 10        ; 20 fs, largely irrelevant with Verlet scheme
  rcoulomb                = 1.0       ; short-range electrostatic cutoff (in nm)
  rvdw                    = 1.0       ; short-range van der Waals cutoff (in nm)
  ; Electrostatics
  coulombtype             = PME       ; Particle Mesh Ewald for long-range electrostatics
  pme_order               = 4         ; cubic interpolation
  fourierspacing          = 0.16      ; grid spacing for FFT
  ; Temperature coupling is on
  tcoupl                  = V-rescale             ; modified Berendsen thermostat
  tc-grps                 = System 
  tau_t                   = 0.1    
  ref_t                   = 300    
  ; Pressure coupling is on
  pcoupl                  = Parrinello-Rahman     ; Pressure coupling on in NPT
  pcoupltype              = isotropic             ; uniform scaling of box vectors
  tau_p                   = 2.0                   ; time constant, in ps
  ref_p                   = 1.0                   ; reference pressure, in bar
  compressibility         = 4.5e-5                ; isothermal compressibility of water, bar^-1
  ; Periodic boundary conditions
  pbc                     = xyz       ; 3-D PBC
  ; Dispersion correction
  DispCorr                = EnerPres  ; account for cut-off vdW scheme
  ; Velocity generation
  gen_vel                 = no        ; Velocity generation is off 
  ;energygrps = Protein SOL BMI BF4 NO3""")
  close(file)

end




