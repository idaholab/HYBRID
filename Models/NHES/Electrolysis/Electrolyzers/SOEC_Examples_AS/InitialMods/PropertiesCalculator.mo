within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model PropertiesCalculator
  extends TRANSFORM.Icons.Example;
  package Medium = Modelica.Media.IdealGases.SingleGases.H2O;
  //package Medium = Modelica.Media.IdealGases.SingleGases.He;
  //package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium;
  Medium.BaseProperties mediums[4](h(start=Medium.specificEnthalpy_pT(ps.k,Ts.k)));
  SI.DynamicViscosity etas[4] = Medium.dynamicViscosity(mediums.state);
  SI.ThermalConductivity lambdas[4] = Medium.thermalConductivity(mediums.state);
  SI.SpecificHeatCapacity cps[4]=Medium.specificHeatCapacityCp(mediums.state);
  SI.Density rhos[4] = Medium.density(mediums.state);
  Modelica.Blocks.Sources.Constant ps[4](k={10000,10000,10000,10000})
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modelica.Blocks.Sources.Constant
                               Ts[4](k={773.15,873.15,973.15,1073.15})
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
equation
  mediums.p =ps.y;
  mediums.T =Ts.y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PropertiesCalculator;
