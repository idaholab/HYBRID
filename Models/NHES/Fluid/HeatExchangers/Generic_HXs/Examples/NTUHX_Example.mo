within NHES.Fluid.HeatExchangers.Generic_HXs.Examples;
model NTUHX_Example

  extends TRANSFORM.Icons.Example;

  NTU_HX_SinglePhase HX(
    tube_av_b=true,
    shell_av_b=true,
    use_derQ=true,
    NTU=3.6,
    K_tube=17000,
    K_shell=5,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=4.,
    V_Shell=4,
    p_start_tube=2340000,
    h_start_tube_inlet=184e3,
    h_start_tube_outlet=184e3,
    p_start_shell=58000,
    h_start_shell_inlet=205.5e3,
    h_start_shell_outlet=205.5e3,
    Cr_init=0.8)
    annotation (Placement(transformation(extent={{-26,-20},{10,12}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Feed(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=66.3,
    h=184.3e3,
    nPorts=1) annotation (Placement(transformation(extent={{88,4},{68,24}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Shell_Feed(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    m_flow=13.3,
    h=1015.8e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-92,-32},{-72,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Tube_Downstream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2340000,
    h=364e3,
    nPorts=1) annotation (Placement(transformation(extent={{-92,6},{-72,26}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Shell_Downstream(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=58000,
    h=205e3,
    nPorts=1) annotation (Placement(transformation(extent={{84,-30},{64,-10}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-50,6},{-30,26}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h1(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,-32},{-36,-12}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h2(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h3(redeclare package
      Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{28,4},{48,24}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-72,16},{-36,38}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-74,-22},{-54,-2}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{40,14},{68,34}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{38,-20},{58,0}})));
equation
  connect(HX.Tube_out, sensor_h.port_b) annotation (Line(points={{-26,2.4},
          {-28,2.4},{-28,16},{-30,16}}, color={0,127,255}));
  connect(HX.Shell_in, sensor_h1.port_b) annotation (Line(points={{-26,-7.2},
          {-32,-7.2},{-32,-22},{-36,-22}}, color={0,127,255}));
  connect(HX.Shell_out, sensor_h2.port_a) annotation (Line(points={{10,-7.2},
          {16,-7.2},{16,-20},{22,-20}}, color={0,127,255}));
  connect(HX.Tube_in, sensor_h3.port_a) annotation (Line(points={{10,2.4},
          {20,2.4},{20,14},{28,14}}, color={0,127,255}));
  connect(sensor_h3.port_b, sensor_p2.port)
    annotation (Line(points={{48,14},{54,14}}, color={0,127,255}));
  connect(Tube_Feed.ports[1], sensor_p2.port)
    annotation (Line(points={{68,14},{54,14}},  color={0,127,255}));
  connect(Tube_Downstream.ports[1], sensor_p.port)
    annotation (Line(points={{-72,16},{-54,16}},  color={0,127,255}));
  connect(sensor_h.port_a, sensor_p.port)
    annotation (Line(points={{-50,16},{-54,16}}, color={0,127,255}));
  connect(Shell_Downstream.ports[1], sensor_p3.port)
    annotation (Line(points={{64,-20},{48,-20}},  color={0,127,255}));
  connect(sensor_h2.port_b, sensor_p3.port)
    annotation (Line(points={{42,-20},{48,-20}}, color={0,127,255}));
  connect(Shell_Feed.ports[1], sensor_p1.port)
    annotation (Line(points={{-72,-22},{-64,-22}},  color={0,127,255}));
  connect(sensor_h1.port_a, sensor_p1.port)
    annotation (Line(points={{-60,-22},{-64,-22}}, color={0,127,255}));
  annotation (
      experiment(
      StopTime=3000,
      Tolerance=1e-08,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p><span style=\"font-family: Courier New; color: #006400;\">&quot;This&nbsp;example&nbsp;is&nbsp;based&nbsp;on&nbsp;the&nbsp;low&nbsp;pressure&nbsp;feed&nbsp;water&nbsp;heater&nbsp;results&nbsp;from&nbsp;the&nbsp;NuScale&nbsp;design&nbsp;certification&nbsp;document&nbsp;found&nbsp;at&nbsp;https://www.nrc.gov/docs/ML1924/ML19241A418.pdf.&quot;</span></p>
</html>"));
end NTUHX_Example;
