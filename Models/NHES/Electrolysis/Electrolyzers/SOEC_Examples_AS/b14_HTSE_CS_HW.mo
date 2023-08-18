within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS;
model b14_HTSE_CS_HW
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT H2ProductOut(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.H2,
    p(displayUnit="Pa") = 103299.8,
    T=313.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-16,6},{-36,26}},
        rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT CondensateSink(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = 3400000,
    T=421.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-128,60})));
  NHES.Fluid.Sensors.stateSensor stateSensor4(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-108,24},{-94,40}})));
  NHES.Fluid.Sensors.stateSensor stateSensor5(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-94,52},{-108,68}})));
  DoNotUse.HTSE_CS_HW HTSE(electric_demand_HTSE=MW_W_Gain_HTSE.y)
    annotation (Placement(transformation(extent={{-80,20},{-40,60}})));
  NHES.Systems.SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{40,18},{80,62}})));
  NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite EG(redeclare
      NHES.Systems.ElectricalGrid.InfiniteGrid.CS_Dummy CS, redeclare
      NHES.Systems.ElectricalGrid.InfiniteGrid.ED_Dummy ED)
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{84,34},{96,46}})));
  Modelica.Blocks.Math.Add add_HTSE
    annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
  Modelica.Blocks.Sources.Pulse pulse_HTSE(
    period=7200,
    offset=-1.2,
    startTime=5400,
    amplitude=0)
    annotation (Placement(transformation(extent={{-120,-20},{-108,-8}})));
  Modelica.Blocks.Math.Gain MW_W_Gain_HTSE(k=1e6)
    annotation (Placement(transformation(extent={{-72,-12},{-60,0}})));
  Modelica.Blocks.Interfaces.RealInput HTSE_Demand_MW annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-120,0}),   iconTransformation(extent={{-120,-12},{-96,12}})));
  Modelica.Fluid.Sources.Boundary_pT SteamSource(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p(displayUnit="bar") = 3406500,
    T(displayUnit="K") = 581.24)
    annotation (Placement(transformation(extent={{-136,40},{-120,24}})));
  Modelica.Blocks.Interfaces.RealOutput HTSE_Elec_Consumption annotation (
      Placement(transformation(extent={{64,-4},{80,12}}),    iconTransformation(
          extent={{116,-28},{140,-4}})));
  Modelica.Blocks.Interfaces.RealOutput HTSE_H2_Production_Rate annotation (
      Placement(transformation(extent={{64,-18},{80,-2}}),
        iconTransformation(extent={{128,-40},{152,-16}})));
equation

   HTSE_Elec_Consumption = HTSE.load_IP.W;
   HTSE_H2_Production_Rate = H2ProductOut.ports[1].m_flow;

  connect(CondensateSink.ports[1], stateSensor5.port_b)
    annotation (Line(points={{-120,60},{-108,60}},
                                                 color={0,127,255}));
  connect(HTSE.H2Port_Out, H2ProductOut.ports[1]) annotation (Line(points={{-60,20},
          {-60,16},{-36,16}},       color={0,127,255}));
  connect(stateSensor5.port_a, HTSE.WaterPort_Out) annotation (Line(points={{-94,60},
          {-86,60},{-86,48.1818},{-80,48.1818}},
                                         color={0,127,255}));
  connect(stateSensor4.port_b, HTSE.SteamIn_Port) annotation (Line(points={{-94,32},
          {-82,32},{-82,31.8182},{-80,31.8182}},
                                             color={0,127,255}));
  connect(SY.port_Grid,sensorW. port_a)
    annotation (Line(points={{80,40},{84,40}}, color={255,0,0}));
  connect(sensorW.port_b,EG. portElec_a)
    annotation (Line(points={{96,40},{100,40}},color={255,0,0}));
  connect(SY.port_a[1], HTSE.electricalLoad)
    annotation (Line(points={{40,40},{-40,40}},
                                            color={255,0,0}));
  connect(HTSE_Demand_MW, add_HTSE.u1)
    annotation (Line(points={{-120,0},{-102,0}},     color={0,0,127}));
  connect(pulse_HTSE.y, add_HTSE.u2) annotation (Line(points={{-107.4,-14},
          {-102,-14},{-102,-12}},
                            color={0,0,127}));
  connect(add_HTSE.y, MW_W_Gain_HTSE.u)
    annotation (Line(points={{-79,-6},{-73.2,-6}},   color={0,0,127}));
  connect(stateSensor4.port_a, SteamSource.ports[1])
    annotation (Line(points={{-108,32},{-120,32}}, color={0,127,255}));
  annotation (
  experiment(
      StopTime=43200,
      Interval=10,
      Tolerance=1e-06,
      __Dymola_fixedstepsize=1e-06,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentFlags(Advanced(
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=1e-06)),
    Diagram(coordinateSystem(extent={{-140,-60},{140,80}})),
    Icon(coordinateSystem(extent={{-140,-60},{140,80}})));
end b14_HTSE_CS_HW;
