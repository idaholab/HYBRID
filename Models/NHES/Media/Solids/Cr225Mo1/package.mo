within NHES.Media.Solids;
package Cr225Mo1 "Chrome-Moly Steel: 2-1/4 Cr - 1 Mo steel"
  extends NHES.Media.Interfaces.PartialAlloy(materialName="Cr225Mo1",
      materialDescription="2 1/4 Cr - 1Mo");

redeclare function extends density "Density as a function of temperature"
algorithm
  rho := 7990 "Constant density (kg/m3)";
end density;

redeclare function extends thermalConductivity
  "Thermal conductivity as a function of temperature"

protected
  SI.Temperature[30] TempTable = Modelica.Units.Conversions.from_degF(
                                                          {70,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1050,1100,1150,1200,1250,1300,1350,1400,1450,1500});
  SI.ThermalConductivity[30] lambdaTable = SIunits.Conversions.from_btuhrftf({20.9,21.0,21.2,21.3,21.4,21.5,21.5,21.5,21.5,21.4,21.3,21.1,20.9,20.7,20.5,20.2,20.0,19.7,19.4,19.1,18.8,18.5,18.3,18.0,17.7,17.2,16.4,15.6,15.4,15.3});

algorithm
  lambda :=Modelica.Math.Vectors.interpolate(
      TempTable,
      lambdaTable,
      T);
end thermalConductivity;

redeclare function extends specificHeatCapacity
  "Specific heat capacity as a function of temperature"
algorithm
  cp := 500;
end specificHeatCapacity;

  annotation (Documentation(info="<html>
<p>Source: http://www.osti.gov/scitech/servlets/purl/455553/</p>
<p><br>Metals design handbook.</p>
<p><br>Important density and specific heat capacity are taken from SS316 as no data was yet found.</p>
</html>"));
end Cr225Mo1;
