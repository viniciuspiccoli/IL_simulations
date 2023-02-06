# script to calculate number of ions for a IL-bulk IL_simulations


## 1 - Find the volume of the box
## 2 - Convert the volume of the System in Angs*3 to liters
## 3 - Determine how many chloride ions are present in one liter of solution at a concentration of 150 mM.














All above answers assume that you have box of water and nothing else in it. If nothing was changed in recent versions of gromacs, genion calculates concentration in respect to the total volume, not the solvent. If you have protein or bilayer inside the system, you should take into account only water molecules. So you should calculate how many molecules should be added per one water molecule. For NaCl, using some approximations, in water it would go like this:
1 mol H2O - 18 g
1 dm3 H2O - 998 g in 25C
998/18 = 55.4 mol in one dm3 of water
Now, 1 mol of any substance is always the same number of molecules/atoms. We can safely assume that the mass of 0.15M NaCl is quite similar. If we have:
55.4 mol of water
0.15 mol of NaCl
We can say that there are 55.4 water molecules per 0.15 molecule of NaCl, so:
55.4/0.15 = 369 molecules of water/1 molecule of NaCl.
Also, since NaCl in water dissociates completely to Na and Cl, there is 1 Na and 1 Cl per every 369 molecules of water in 0.15M solution of NaCl. These rough approximations, but they are quite sufficient for MD.
Same way you can calculate number of any molecules per water.