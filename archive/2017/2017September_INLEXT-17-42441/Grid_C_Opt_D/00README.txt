2. Grid parametric sweep on capacities | Dispatch optimiser (including Modelica)

 The report includes various sensitivities on H2 price and wind penetration.
 The driectory contains a "BASE" input file and a "Cases.py"
 ==> In Cases.py, one can define which sensitivites to run.
   The inputs are then created in separate subdirectories using
   > python generateGRIDinputs.py

   All of them can be run (in a pbs cluser queue) with
   > ./runall.sh

  A plotting tool is also provided that created the plots shown in the report: plots_out.py
