within NHES.Media.Common;
record SingleSpeciesData "chem, r, n, MW, h_f @ 298.15, as, bs, T_lims[n,2]"
  extends Modelica.Icons.Record;
  String chem;
  Density rho;
  ThermalConductivity k;
  Integer r;
  Integer n;
  MolarHeatCapacity R_U;
  MolarMass MW;
  SpecificHeatCapacity R_m;
  MolarEnthalpy h_f_298_15;
  Real a[4,7];
  Real b[4,2];
  Temperature T_lims[4,2];
end SingleSpeciesData;
