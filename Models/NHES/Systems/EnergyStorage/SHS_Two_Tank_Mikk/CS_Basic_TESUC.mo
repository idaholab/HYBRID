within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk;
model CS_Basic_TESUC

  extends BaseClasses.Partial_ControlSystem;
  parameter Modelica.Units.SI.Temperature steam_ref;
  input Modelica.Units.SI.MassFlowRate Ref_Charge_Flow "TES should supply expected charging mass flow rate given demand" annotation(Dialog(tab = "General"));
  replaceable Data.Data_CS data
    annotation (Placement(transformation(extent={{-92,18},{-72,38}})), Dialog(tab = "General", choicesAllMatching=true));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    Charging_Valve_Position_MinMax(min=2e-4)
    annotation (Placement(transformation(extent={{2,-32},{22,-12}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-18,-18},{-12,-24}})));
  TRANSFORM.Controls.LimPID PID5(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2.5e-3,
    Ti=3,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-44,-14},{-38,-20}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-56,-26},{-50,-20}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{-80,-32},{-72,-24}})));
  Modelica.Blocks.Sources.Constant one4(k=1.25)
    annotation (Placement(transformation(extent={{-94,-32},{-90,-28}})));
  Modelica.Blocks.Sources.Constant one5(k=-0.25)
    annotation (Placement(transformation(extent={{-68,-24},{-62,-18}})));
  TRANSFORM.Controls.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01*data.discharge_control_ref_value,
    Ti=10,
    yMax=1.0,
    yMin=0.0,
    y_start=0.0)
    annotation (Placement(transformation(extent={{-36,54},{-28,62}})));
end CS_Basic_TESUC;
