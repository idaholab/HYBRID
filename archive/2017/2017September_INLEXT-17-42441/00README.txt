*************
* ATTENTION *
*************

THIS TESTS FOR SURE WORK WITH RAVEN TILL COMMIT: 2235c9bd40ad318fc5eb0f43807ad2750941c138

***************
* DESCRIPTION *
***************

This forlder contains the RAVEN inputs used to generate the plots in the September 2017 INL Milestone INL/EXT-17-42441
"Status Report on Modeling and Simulation Capabilities for Nuclear-Renewable Hybrid Energy Systems"

In particular, the inputs to compute the cases discussed in Chapter 7

Four inputs are provided that allow to easily reconstruct all the cases run in the report.
All inputs are for 1 day of simulation lenght, but can easily be extendet to the 1 wek or 1 year presented in the report.

The four cases are:

1. Grid parametric sweep on capacities | Marginal cost dispatch  |  No Modelica         | RAVEN runs RAVEN as external code (discontinued*) | TEST provided      => Grid_C_NoModelica_D   *One should use the code interface
2. Grid parametric sweep on capacities | Dispatch optimiser      |  including Modelica  | RAVEN runs RAVEN through code interface           | TEST provided      => Grid_C_Opt_D
3. Capacity optimiser                  | Marginal cost dispatch  |  No Modelica         | RAVEN runs RAVEN through code interface           | TEST provided      => Opt_C_NoModelica_D
4. Capacity optimiser                  | Dispatch optimiser      |  including Modelica  | RAVEN runs RAVEN through code interface           | No TEST provided   => Opt_C_Opt_D

The report also presents cases where the dispatch is optimised, but no Modelica is run. These cases are to demonstrate that
the marginal dispatch is the optimal dispatch if no dynamic effects (Modelica) are considered.
Such inputs can easily be reconstructed from the 4 inputs probvided.

Input 1, correponds to CASE 1 and CASE 2 presented in the report.
Input 2, correponds to CASE 4 presented in the report.
Input 3, correponds to CASE 5 presented in the report. 
Input 4, correponds to CASE 6 presented in the report. 


The input in Grid_C_NoModelica_D, runs the 'inner' RAVEN as an external code with an interface that is part of the input.
   - The version that runs the 'inner' RAVEN as external code is available in the original revision, where this has 
     been commited for the first time. In the meantime, this input has been discontinued and is not available in the repository anymore. 

All other cases, run the 'inner' RAVEN using the RAVEN code interface.

