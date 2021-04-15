within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
model Ksolver "Determines the K-value"

  Modelica.Blocks.Interfaces.RealInput Valve_Position
    annotation (Placement(transformation(extent={{-142,-12},{-102,28}})));
  Modelica.Blocks.Interfaces.RealOutput KACV
    annotation (Placement(transformation(extent={{100,0},{126,26}})));

parameter Real Kvalve;
parameter Real Avalve;
parameter Real tau;
parameter Real deadband;
parameter Real b;
Real TauV;
algorithm
  TauV:=Valve_Position*(1 - b*(1 - Valve_Position));
                                                //if b=0 then the valve acts as a linear valve
  if TauV^2 < 1e-14 then
    KACV:=Kvalve/1e-14;
  else
    KACV:=Kvalve/(TauV^2);
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Ksolver;
