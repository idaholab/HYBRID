within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model Load_Definer

parameter Real Turbine_Nominal=1e9  "Nominal main system turbine output (W)";

  Modelica.Blocks.Interfaces.RealInput Load
    annotation (Placement(transformation(extent={{-128,-4},{-100,24}})));
  Modelica.Blocks.Interfaces.RealOutput Turbine_Demand
    annotation (Placement(transformation(extent={{100,12},{120,32}})));
  Modelica.Blocks.Interfaces.RealOutput TES_Demand
    annotation (Placement(transformation(extent={{100,-42},{120,-22}})));

algorithm
  Turbine_Demand:=Load;
  TES_Demand:=Turbine_Demand - Turbine_Nominal;
  if Load>=Turbine_Nominal then
  Turbine_Demand:=Turbine_Nominal;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Load_Definer;
