within NHES.Media.Solids;
package SiliconCarbide "Sintered Silicon Carbide"
  extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy_TableBased(
    mediumName="SiC",
    T_min=Modelica.Units.Conversions.from_degC(0),
    T_max=Modelica.Units.Conversions.from_degC(2500),
    tableDensity=[293.15,3160; 773.15,3140; 1273.15,3110; 1473.15,3100;
        1673.15,3090; 1773.15,3080],
    tableHeatCapacity=[293.15,715; 773.15,1086; 1273.15,1240; 1473.15,1282;
        1673.15,1318; 1773.15,1336],
    tableConductivity=[293.15,114; 773.15,55.1; 1273.15,35.7; 1473.15,31.3;
        1673.15,27.8; 1773.15,26.3]);

  annotation (Documentation(info="<html>
<p>Source: http://www.specialmetals.com/assets/documents/alloys/inconel/inconel-alloy-690.pdf</p>
</html>"));
end SiliconCarbide;
