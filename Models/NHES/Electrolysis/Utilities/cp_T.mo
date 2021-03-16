within NHES.Electrolysis.Utilities;
function cp_T
  "Compute specific heat capacity at constant pressure from temperature and gas data"
  extends Modelica.Icons.Function;
  input Modelica.Media.IdealGases.Common.DataRecord data "Ideal gas data";
  input Modelica.Units.SI.Temperature T "Temperature [K]";
  output Modelica.Units.SI.SpecificHeatCapacity cp
    "Specific heat capacity at temperature T";
algorithm
  cp :=smooth(0, if T < data.Tlimit then data.R_s*(1/(T*T)*(data.alow[1] + T*(
    data.alow[2] + T*(1.*data.alow[3] + T*(data.alow[4] + T*(data.alow[5] + T*(
    data.alow[6] + data.alow[7]*T))))))) else data.R_s*(1/(T*T)*(data.ahigh[1]
     + T*(data.ahigh[2] + T*(1.*data.ahigh[3] + T*(data.ahigh[4] + T*(data.ahigh[
    5] + T*(data.ahigh[6] + data.ahigh[7]*T))))))));
  annotation (Inline=true,smoothOrder=2);
end cp_T;
