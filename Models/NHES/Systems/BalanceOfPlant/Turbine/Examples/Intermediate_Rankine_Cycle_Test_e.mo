within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model Intermediate_Rankine_Cycle_Test_e
  import NHES;

  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));

  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.Intermediate_Rankine_Cycle BOP(
  port_a_nominal(
      m_flow=493.7058,
      p=14000000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 591)),
    port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          318.95)))
    annotation (Placement(transformation(extent={{0,-30},{60,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Fluid.Sensors.stateSensor stateSensor(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-18,-22},{-38,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,2},{-18,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-52,-60},{-8,-30}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-52,30},{-6,60}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e8,
    startTime=350,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
                               nuScale_Tave_enthalpy(
    redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy
      CS(
      T_SG_exit=579.15,
      Q_nom(displayUnit="MW") = 160000000,
      demand=1.0),
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-122,-40},{-54,48}})));
equation

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-29,41.1},{-29,30},{-28,30},{-28,14},{-27.95,14},{-27.95,12.05}},
                                                                   color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor.statePort) annotation (Line(
        points={{-30,-48.9},{-30,-32},{-28,-32},{-28,-11.95},{-28.05,-11.95}},
                                                           color={0,0,0}));
  connect(stateSensor.port_a, BOP.port_b)
    annotation (Line(points={{-18,-12},{0,-12}},   color={0,127,255}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-18,12},{0,12}},   color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{60,0},{70,0}}, color={255,0,0}));
  connect(stateSensor.port_b, nuScale_Tave_enthalpy.port_a) annotation (Line(
        points={{-38,-12},{-42,-12},{-42,-1.41538},{-52.7636,-1.41538}}, color=
          {0,127,255}));
  connect(nuScale_Tave_enthalpy.port_b, stateSensor1.port_a) annotation (Line(
        points={{-52.7636,20.9231},{-42,20.9231},{-42,12},{-38,12}}, color={0,
          127,255}));
  annotation (experiment(StopTime=50000, __Dymola_Algorithm="Dassl"));
end Intermediate_Rankine_Cycle_Test_e;
