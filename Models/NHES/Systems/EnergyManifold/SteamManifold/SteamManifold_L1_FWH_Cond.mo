within NHES.Systems.EnergyManifold.SteamManifold;
model SteamManifold_L1_FWH_Cond
  import NHES;
  extends BaseClasses.Partial_SubSystem_B(
    redeclare replaceable CS_Dummy CS(nPorts_a3=nPorts_a3, nPorts_b3=nPorts_b3),
    redeclare replaceable ED_Dummy ED,
    redeclare Data.SteamManifold data,
    redeclare final package Medium_1=Medium,
    redeclare final package Medium_2=Medium,
    redeclare final package Medium_3=Medium);

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    annotation(choicesAllMatching=true);

  /* Nominal Operating Conditions */
  parameter Real TDV_opening_nominal=0.8
    "Nominal valve position (fraction open)"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter Real IPDV_opening_nominal=0.5
    "Nominal valve position (fraction open)"
    annotation (Dialog(tab="Nominal Conditions"));

  parameter SI.PressureDifference TDV_dp_nominal=5e5
    "Nominal pressure drop at full opening"
    annotation (Dialog(tab="Nominal Conditions"));
  parameter SI.PressureDifference IPDV_dp_nominal=0.1e5
    "Nominal pressure drop at full opening"
    annotation (Dialog(tab="Nominal Conditions"));

  /* Initialization */
  parameter SI.PressureDifference TDV_dp_start=TDV_dp_nominal*TDV_opening_nominal
    "Nominal pressure drop at full opening"
    annotation (Dialog(tab="Initialization"));
  parameter SI.PressureDifference IPDV_dp_start=IPDV_dp_nominal*IPDV_opening_nominal
    "Nominal pressure drop at full opening"
    annotation (Dialog(tab="Initialization"));

   TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
                                            R=1, redeclare package Medium =
        Medium)
     annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
   TRANSFORM.Fluid.Volumes.MixingVolume steamHeader(
    p_start=port_a1_nominal.p,
    use_T_start=false,
    h_start=port_a1_nominal.h,
    nPorts_a=1,
    nPorts_b=1 + nPorts_b3,
    redeclare package Medium = Medium,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=20))
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
   TRANSFORM.Fluid.Valves.ValveIncompressible valve_toBOP(
    rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
    redeclare package Medium = Medium,
    dp_nominal=100000,
    m_flow_nominal=-port_b2_nominal.m_flow)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
   TRANSFORM.Fluid.Valves.ValveIncompressible valve_toOther[nPorts_b3](
    redeclare each package Medium = Medium,
    each rho_nominal=Medium_1.density_ph(port_a1_nominal.p, port_a1_nominal.h),
    each dp_nominal=100000,
    m_flow_nominal={max(-port_b3_nominal_m_flow[i], 0.001) for i in 1:nPorts_b3}) if
                               nPorts_b3 > 0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,10})));

  TRANSFORM.Fluid.Volumes.Separator moistureSeperator(
    redeclare package Medium = Medium,
    nPorts_a=1+nPorts_a3,
    use_T_start=false,
    h_start=(port_a2_start.h*port_a2_start.m_flow + sum(port_a3_start_h .*
        port_a3_start_m_flow))/(port_a2_start.m_flow + sum(port_a3_start_m_flow)),
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    p_start=p_condenser + 100,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{50,-50},{30,-30}})));

  TRANSFORM.Fluid.Volumes.IdealCondenser condenserSmall(
    set_m_flow=true,
    redeclare package Medium = Medium,
    p=p_condenser)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
   TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(R=1,
      redeclare package Medium = Medium)
     annotation (Placement(transformation(extent={{72,-50},{52,-30}})));
   TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance res_a3[nPorts_a3](each R=1,
      redeclare each package Medium = Medium) if nPorts_a3>0
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-80})));
  TRANSFORM.Fluid.Volumes.DumpTank reservoir(
    redeclare package Medium = Medium,
    A=10,
    level_start=1,
    p_start=p_reservoir)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Fluid.Fittings.MultiPort multiPort(nPorts_b=2, redeclare package
      Medium = Medium) annotation (Placement(transformation(
        extent={{-4,-10},{4,10}},
        rotation=90,
        origin={-30,-20})));
  parameter SI.Pressure p_condenser=port_b1_nominal.p "Condenser operating pressure";
  parameter SI.Pressure p_reservoir=port_b1_nominal.p "Reservoir operating pressure";
  TRANSFORM.Fluid.Valves.StopValve checkValve(redeclare package Medium = Medium,
      checkValve=true)
    annotation (Placement(transformation(extent={{28,-26},{8,-6}})));
   TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_feedWater(redeclare
      package Medium = Medium, m_flow_nominal=-port_b1_nominal.m_flow)
    annotation (Placement(transformation(extent={{-34,-66},{-54,-46}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume feedWaterHeater(
    use_HeatPort=true,
    redeclare package Medium = Medium,
    p_start=port_b1_start.p,
    T_start=port_b1_start.T,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5))
    annotation (Placement(transformation(extent={{-56,-66},{-76,-46}})));
  TRANSFORM.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-82,-62},{-90,-70}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yb=1e8,
    k=1e8,
    k_s=1/port_b1_nominal.T,
    k_m=1/port_b1_nominal.T)
    annotation (Placement(transformation(extent={{-94,-76},{-86,-84}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=port_b1_nominal.T)
    annotation (Placement(transformation(extent={{-110,-86},{-100,-74}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow    boundary(use_port=
        true)
    annotation (Placement(transformation(extent={{-88,-90},{-68,-70}})));
equation

for i in 1:nPorts_b3 loop
    connect(valve_toOther[i].port_a, steamHeader.port_b[i + 1]);
    connect(valve_toOther[i].port_b, port_b3[i]);
end for;

for i in 1:nPorts_a3 loop
    connect(res_a3[i].port_b, moistureSeperator.port_a[i + 1]);
    connect(port_a3[i], res_a3[i].port_a);
end for;

  connect(port_a1, resistance.port_a)
     annotation (Line(points={{-100,40},{-77,40}}, color={0,127,255}));
  connect(valve_toBOP.port_b, port_b2)
    annotation (Line(points={{50,40},{100,40}}, color={0,127,255}));

  connect(resistance.port_b, steamHeader.port_a[1])
    annotation (Line(points={{-63,40},{-46,40}}, color={0,127,255}));
  connect(steamHeader.port_b[1], valve_toBOP.port_a)
    annotation (Line(points={{-34,40},{30,40}}, color={0,127,255}));
  connect(actuatorBus.opening_valve_toBOP, valve_toBOP.opening)
    annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,60},{40,60},{40,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.opening_valve_toOther,
    valve_toOther.opening) annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,10},{48,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_a2, resistance3.port_a)
    annotation (Line(points={{100,-40},{69,-40}}, color={0,127,255}));
  connect(resistance3.port_b, moistureSeperator.port_a[1])
    annotation (Line(points={{55,-40},{46,-40}}, color={0,127,255}));
  connect(multiPort.port_a, reservoir.port_a)
    annotation (Line(points={{-30,-24},{-30,-31.6}}, color={0,127,255}));
  connect(condenserSmall.port_b, multiPort.ports_b[1]) annotation (Line(points={{0,-48},
          {0,-54},{-12,-54},{-12,-8},{-32,-8},{-32,-16}},              color={0,
          127,255}));
  connect(moistureSeperator.port_Liquid, multiPort.ports_b[2]) annotation (Line(
        points={{44,-44},{44,-56},{-16,-56},{-16,-12},{-28,-12},{-28,-16}},
        color={0,127,255}));
  connect(checkValve.port_a, moistureSeperator.port_b[1])
    annotation (Line(points={{28,-16},{28,-40},{34,-40}}, color={0,127,255}));
  connect(checkValve.port_b, condenserSmall.port_a)
    annotation (Line(points={{8,-16},{7,-16},{7,-33}}, color={0,127,255}));
  connect(reservoir.port_b, pump_feedWater.port_a) annotation (Line(points={{
          -30,-48.4},{-30,-56},{-34,-56}}, color={0,127,255}));
  connect(pump_feedWater.port_b, feedWaterHeater.port_a)
    annotation (Line(points={{-54,-56},{-60,-56}}, color={0,127,255}));
  connect(boundary.port, feedWaterHeater.heatPort)
    annotation (Line(points={{-68,-80},{-66,-80},{-66,-62}}, color={191,0,0}));
  connect(feedWaterHeater.port_b, port_b1) annotation (Line(points={{-72,-56},{
          -80,-56},{-80,-40},{-100,-40}}, color={0,127,255}));
  connect(temperature.port, port_b1) annotation (Line(points={{-86,-62},{-86,
          -56},{-80,-56},{-80,-40},{-100,-40}}, color={0,127,255}));
  connect(temperature.T, PID.u_m) annotation (Line(points={{-88.4,-66},{-90,-66},
          {-90,-75.2}}, color={0,0,127}));
  connect(realExpression.y, PID.u_s)
    annotation (Line(points={{-99.5,-80},{-94.8,-80}}, color={0,0,127}));
  connect(PID.y, boundary.Q_flow_ext)
    annotation (Line(points={{-85.6,-80},{-82,-80}}, color={0,0,127}));
  annotation (
    defaultComponentName="EM",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}}), graphics={Text(
          extent={{26,-4},{56,-10}},
          lineColor={0,0,0},
          textString="Conditionally connected
based on exterior connections"),  Text(
          extent={{-12,-86},{18,-92}},
          lineColor={0,0,0},
          textString="Conditionally connected
based on exterior connections")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{0,6},{19,-6}},
          lineColor={0,0,0},
          origin={-41,-68},
          rotation=90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2.66663,6},{97.3335,-6}},
          lineColor={0,0,0},
          origin={-25.3334,-40},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-68,-34},{-56,-46}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-68,46},{-20,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-19,6},{19,-6}},
          lineColor={0,0,0},
          origin={13,40},
          rotation=0,
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-38,6},{19,-6}},
          lineColor={0,0,0},
          origin={23,2},
          rotation=-45,
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{34,46},{72,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-26,6},{26,-6}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={39,-42},
          rotation=90),
        Ellipse(
          extent={{24,50},{42,32}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{30,-4},{48,-22}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{34,50},{32,62}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{40,-4},{38,8}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{30,10},{48,8}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{24,64},{42,62}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{6,57},{-28,23}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175}),
        Ellipse(
          extent={{35,50},{31,32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Ellipse(
          extent={{41,-4},{37,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Ellipse(
          extent={{-24,-23},{-58,-57}},
          lineColor={95,95,95},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175}),
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Steam Manifold")}),
    experiment(StopTime=20));
end SteamManifold_L1_FWH_Cond;
