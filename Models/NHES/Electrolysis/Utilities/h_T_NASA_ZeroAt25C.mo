within NHES.Electrolysis.Utilities;
function h_T_NASA_ZeroAt25C
  "Compute specific enthalpy from temperature and gas data"

extends Modelica.Icons.Function;
input Modelica.Media.IdealGases.Common.DataRecord data "Ideal gas data";
  input Modelica.Units.SI.Temperature T "Temperature [K]";
input Boolean exclEnthForm
    "If true, enthalpy of formation Hf is not included in specific enthalpy h";

  output Modelica.Units.SI.SpecificEnthalpy h
    "Specific enthalpy at temperature T";

algorithm
h :=smooth(0, (if T < data.Tlimit then data.R_s*((-data.alow[1] + T*(data.blow[
    1] + data.alow[2]*Modelica.Math.log(T) + T*(1.*data.alow[3] + T*(0.5*data.alow[
    4] + T*(1/3*data.alow[5] + T*(0.25*data.alow[6] + 0.2*data.alow[7]*T))))))/
    T) else data.R_s*((-data.ahigh[1] + T*(data.bhigh[1] + data.ahigh[2]*
    Modelica.Math.log(T) + T*(1.*data.ahigh[3] + T*(0.5*data.ahigh[4] + T*(1/3*
    data.ahigh[5] + T*(0.25*data.ahigh[6] + 0.2*data.ahigh[7]*T))))))/T)) + (
    if exclEnthForm then -data.Hf else 0.0));
annotation (Inline=false,smoothOrder=2);
end h_T_NASA_ZeroAt25C;
