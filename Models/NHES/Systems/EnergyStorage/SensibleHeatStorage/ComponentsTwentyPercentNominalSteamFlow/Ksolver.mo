within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model Ksolver "Determines the K-value"

  Modelica.Blocks.Interfaces.RealInput Valve_Position
    annotation (Placement(transformation(extent={{-142,-12},{-102,28}})));
  Modelica.Blocks.Interfaces.RealOutput KACV
    annotation (Placement(transformation(extent={{100,0},{126,26}})));

parameter Real Kvalve          "Loss Coefficient of Valve when full Open";
parameter Real Avalve          "Area of Valve (ft^2)";
parameter Real tau;
parameter Real deadband;
parameter Real b               "b=0 means valve acts as linear valve, b=1 then it acts as an equal percentage valve";
//Real TauV;

equation
  KACV=Kvalve/((Valve_Position*(1 - b*(1 - Valve_Position)))^2);

//algorithm

//Calculation of Effective Loss Value through the valve**************************************************************
//   TauV:=Valve_Position*(1 - b*(1 - Valve_Position));
//
//   if TauV^2 < 1e-14 then
//     KACV:=Kvalve/1e-14;
//   else
//     KACV:=Kvalve/(TauV^2);
//   end if;

  //End of Calculation***********************************************************************************************
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Ksolver;
