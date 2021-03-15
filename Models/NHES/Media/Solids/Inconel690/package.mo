within NHES.Media.Solids;
package Inconel690 "IN690: Inconel 690"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="IN690",
      materialDescription="Inconel 690");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 8190 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"
protected
  SI.Temperature[12] TempTable = Modelica.Units.Conversions.from_degC(  {25,100,200,300,400,500,600,700,800,900,1000,1100});
  SI.ThermalConductivity[12] lambdaTable = {13.5,13.5,15.4,17.3,19.1,21.0,22.9,24.8,26.6,28.5,30.1,30.1};

algorithm
  lambda :=Modelica.Math.Vectors.interpolate(
      TempTable,
      lambdaTable,
      T);
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
protected
  SI.Temperature[12] TempTable = Modelica.Units.Conversions.from_degC(  {25,100,200,300,400,500,600,700,800,900,1000,1100});
  SI.SpecificHeatCapacity[12] cpTable = {450,471,497,525,551,578,604,631,658,684,711,738};
algorithm
  cp :=Modelica.Math.Vectors.interpolate(
      TempTable,
      cpTable,
      T);
end specificHeatCapacity;

  annotation (Documentation(info="<html>
<p>Source: http://www.specialmetals.com/assets/documents/alloys/inconel/inconel-alloy-690.pdf</p>
</html>"));
end Inconel690;
