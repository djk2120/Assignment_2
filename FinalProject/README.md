# Final Project

## Brief Description
 - will be running an ensemble of climate model simulations
 - will be varying three parameters across simulations

## Workflow

### Create parameter files
 - each simulation needs a parameter file
 - need to take template .nc file and edit the parameter values
 - save file with name that will generate simulation name

### Submit simulations
 1) clone template simulation
 2) setup case
 3) edit env_build.xml
      - point to existing build (to avoid recompiling code)
      - set build status to true
 4) edit user_nl_clm
      - point to parameter file
 5) submit case

### Analyze output data
 1) totals
      - transpiration
      - photosynthesis
      - hydraulic redistribution
 2) seasonal cycles
      - transpiration
      - photosynthesis
      - hydraulic redistribution
      - soil profile?
 3) diurnal cycles
      - transpiration
      - photosynthesis

### Visualize results