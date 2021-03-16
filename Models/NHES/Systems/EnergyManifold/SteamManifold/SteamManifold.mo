within NHES.Systems.EnergyManifold.SteamManifold;
model SteamManifold
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
    Q_balance(y=mixer.heatPort.Q_flow),
    port_a1_nominal(
      p=5.8e6,
      T=591,
      m_flow=502.8),
    port_b1_nominal(p=6.19e6, T=497),
    port_a2_nominal(
      p=6e6,
      T=318.95,
      m_flow=port_a1_nominal.m_flow - port_a3_nominal.m_flow),
    port_b2_nominal(p=port_a1_nominal.p - TDV_dp_nominal*TDV_opening_nominal),
    port_a3_nominal(
      p=6.19e6,
      T=488.3,
      m_flow=9.0942),
    port_b3_nominal(p=port_a1_nominal.p - IPDV_dp_nominal*IPDV_opening_nominal),
    port_b2_start(p=port_a1_start.p - TDV_dp_start),
    port_b3_start(p=port_a1_start.p - IPDV_dp_start),
    redeclare Data.SteamManifold data);

    /* Parameters */
  parameter SI.Length length_To_PHS=1 "Length of pipe to PHS"
    annotation (Dialog(group="Primary Heat System"));
  parameter SI.Diameter diameter_To_PHS=3.776 "Diameter of pipe to PHS"
    annotation (Dialog(group="Primary Heat System"));
  parameter SI.Length length_From_PHS=1 "Length of pipe from PHS"
    annotation (Dialog(group="Primary Heat System"));
  parameter SI.Diameter diameter_From_PHS=3.776 "Diameter of pipe from PHS"
    annotation (Dialog(group="Primary Heat System"));

  parameter SI.Length length_To_BOP=1 "Length of pipe to BOP"
    annotation (Dialog(group="Balance of Plant"));
  parameter SI.Diameter diameter_To_BOP=2.5 "Diameter of pipe to BOP"
    annotation (Dialog(group="Balance of Plant"));
  parameter SI.Length length_From_BOP=1 "Length of pipe from BOP"
    annotation (Dialog(group="Balance of Plant"));
  parameter SI.Diameter diameter_From_BOP=0.4 "Diameter of pipe from BOP"
    annotation (Dialog(group="Balance of Plant"));

  parameter SI.Length length_To_IP=1 "Length of pipe to IP"
    annotation (Dialog(group="Industrial Process"));
  parameter SI.Diameter diameter_To_IP=0.35 "Diameter of pipe to IP"
    annotation (Dialog(group="Industrial Process"));
  parameter SI.Length length_From_IP=1 "Length of pipe from IP"
    annotation (Dialog(group="Industrial Process"));
  parameter SI.Diameter diameter_From_IP=0.06 "Diameter of pipe from IP"
    annotation (Dialog(group="Industrial Process"));

  parameter SI.Volume V_splitter=10 "Volume of splitter (from PHS to BOP/IP)"
    annotation (Dialog(group="Mixing Volumes"));
  parameter SI.Volume V_mixer=10 "Volume of mixer (from BOP/IP to PHS)"
    annotation (Dialog(group="Mixing Volumes"));
  parameter SI.Height height_mixer=1 "Height of mixer (from BOP/IP to PHS)"
    annotation (Dialog(group="Mixing Volumes"));

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

  inner Fluid.System_TP system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  NHES.Fluid.Pipes.StraightPipe pipe_To_BOP(
    redeclare package Medium = Medium_1,
    length=length_To_BOP,
    diameter=diameter_To_BOP,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    nV=1,
    T_a_start=port_a1_start.T,
    m_flow_a_start=port_a2_start.m_flow,
    p_a_start=port_a1_start.p - TDV_dp_start)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  NHES.Fluid.Pipes.StraightPipe pipe_To_PHS(
    redeclare package Medium = Medium_1,
    length=length_To_PHS,
    diameter=diameter_To_PHS,
    nV=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    p_a_start=port_b1_start.p,
    T_a_start=port_b1_start.T,
    m_flow_a_start=port_a1_start.m_flow)
    annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
  Modelica.Fluid.Valves.ValveLinear TDV(
    redeclare package Medium = Medium_1,
    m_flow_start=port_a2_start.m_flow,
    dp_start=TDV_dp_start,
    m_flow_nominal=port_a2_nominal.m_flow/TDV_opening_nominal,
    dp_nominal=0.5*TDV_dp_nominal)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Fluid.Valves.ValveLinear IPDV(
    redeclare package Medium = Medium_1,
    m_flow_start=port_a3_start.m_flow,
    dp_start=IPDV_dp_start,
    m_flow_nominal=port_a3_nominal.m_flow/IPDV_opening_nominal,
    dp_nominal=0.5*IPDV_dp_nominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={48,-10})));
  NHES.Fluid.Pipes.StraightPipe pipe_To_IP(
    redeclare package Medium = Medium_1,
    length=length_To_IP,
    diameter=diameter_To_IP,
    nV=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    p_a_start=port_a1_start.p - IPDV_dp_start,
    T_a_start=port_a1_start.T,
    m_flow_a_start=port_a3_start.m_flow) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-54})));
  NHES.Fluid.Pipes.StraightPipe pipe_From_PHS(
    redeclare package Medium = Medium_1,
    nV=1,
    p_a_start(displayUnit="MPa") = port_a1_start.p,
    T_a_start=port_a1_start.T,
    m_flow_a_start=port_a1_start.m_flow,
    length=length_From_PHS,
    diameter=diameter_From_PHS,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  NHES.Fluid.Pipes.StraightPipe pipe_From_IP(
    redeclare package Medium = Medium_1,
    length=length_From_IP,
    diameter=diameter_From_IP,
    nV=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    p_a_start=port_a3_start.p,
    m_flow_a_start=port_a3_start.m_flow,
    T_a_start=port_a2_start.T) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,-70})));
  NHES.Fluid.Pipes.StraightPipe pipe_From_BOP(
    redeclare package Medium = Medium_1,
    length=length_From_BOP,
    diameter=diameter_From_BOP,
    nV=1,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
    p_a_start=port_a2_start.p,
    T_a_start=port_a2_start.T,
    m_flow_a_start=port_a2_start.m_flow)
    annotation (Placement(transformation(extent={{80,-50},{60,-30}})));
  Modelica.Fluid.Vessels.ClosedVolume splitter(
    use_portsData=false,
    redeclare package Medium = Medium_1,
    V=V_splitter,
    nPorts=3,
    p_start(displayUnit="MPa") = port_a1_start.p,
    T_start(displayUnit="K") = port_a1_start.T,
    m_flow_nominal=port_a1_nominal.m_flow)
    annotation (Placement(transformation(extent={{-49,50},{-29,70}})));
  Modelica.Fluid.Vessels.OpenTank mixer(
    redeclare package Medium = Medium_1,
    height=height_mixer,
    use_portsData=true,
    crossArea=V_mixer/height_mixer,
    T_start=port_a2_start.T,
    nPorts=4,
    p_ambient=port_a2_nominal.p - 1e5,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        diameter_To_PHS),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=diameter_From_IP, height=0.9*mixer.height),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        diameter_From_BOP, height=0.9*mixer.height),
        Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        diameter_From_BOP, height=0.9*mixer.height)},
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_HeatTransfer=true)
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));

  Modelica.Fluid.Sensors.MassFlowRate massFlowRate_From_BOP(redeclare package
      Medium = Medium_1) annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=90,
        origin={0,-34})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate_From_IP(redeclare package
      Medium = Medium_1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-10,-50})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package
      Medium = Medium_1)
    annotation (Placement(transformation(extent={{64,-74},{76,-62}})));
  Modelica.Fluid.Sensors.MassFlowRate state_toIP(redeclare package Medium =
        Medium_1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={40,-78})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium_1)
    annotation (Placement(transformation(extent={{64,-92},{76,-80}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow                   pump(
      redeclare package Medium = Medium_1,                            use_input=
       true)
    annotation (Placement(transformation(extent={{-30,-50},{-50,-30}})));
  Modelica.Blocks.Sources.RealExpression m_flow_SG(y=port_a1_nominal.m_flow)
    annotation (Placement(transformation(extent={{-70,-32},{-50,-12}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate_From_BOP1(redeclare package
      Medium = Medium_1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-18,-34})));
  Modelica.Fluid.Valves.ValveLinear BPDV(
    redeclare package Medium = Medium_1,
    m_flow_start=port_a3_start.m_flow,
    dp_start=2*TDV_dp_nominal,
    m_flow_nominal=port_a1_nominal.m_flow,
    dp_nominal=0.5*TDV_dp_nominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={18,0})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{22,24},{14,16}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        port_b1_nominal.T)
    annotation (Placement(transformation(extent={{-44,-10},{-34,0}})));
equation
  connect(pipe_To_BOP.port_b, port_b2)
    annotation (Line(points={{80,40},{100,40}}, color={0,127,255}));
  connect(TDV.port_b, pipe_To_BOP.port_a)
    annotation (Line(points={{40,40},{40,40},{60,40}}, color={0,127,255}));
  connect(IPDV.port_b, pipe_To_IP.port_a) annotation (Line(points={{48,-20},{48,
          -20},{48,-24},{48,-30},{40,-30},{40,-44}}, color={0,127,255}));
  connect(pipe_From_BOP.port_a, port_a2)
    annotation (Line(points={{80,-40},{100,-40}}, color={0,127,255}));
  connect(pipe_From_IP.port_a, port_a3)
    annotation (Line(points={{-40,-80},{-40,-100}}, color={0,127,255}));
  connect(pipe_From_PHS.port_a, port_a1)
    annotation (Line(points={{-80,40},{-90,40},{-100,40}}, color={0,127,255}));
  connect(pipe_From_PHS.port_b, splitter.ports[1]) annotation (Line(points={{-60,40},
          {-44,40},{-41.6667,40},{-41.6667,50}},         color={0,127,255}));

  connect(pipe_To_PHS.port_b, port_b1)
    annotation (Line(points={{-80,-40},{-100,-40}}, color={0,127,255}));
  connect(pipe_From_IP.port_b, massFlowRate_From_IP.port_a) annotation (Line(
        points={{-40,-60},{-40,-58},{-10,-58},{-10,-54}}, color={0,127,255}));
  connect(pipe_From_BOP.port_b, massFlowRate_From_BOP.port_a) annotation (Line(
        points={{60,-40},{32,-40},{-2.22045e-016,-40},{-2.22045e-016,-38}},
        color={0,127,255}));
  connect(pipe_To_IP.port_b, state_toIP.port_a)
    annotation (Line(points={{40,-64},{40,-64},{40,-72}}, color={0,127,255}));
  connect(state_toIP.port_b, port_b3)
    annotation (Line(points={{40,-84},{40,-100}}, color={0,127,255}));
  connect(specificEnthalpy.port, state_toIP.port_a) annotation (Line(points={{
          70,-74},{52,-74},{52,-68},{40,-68},{40,-72}}, color={0,127,255}));
  connect(pressure.port, state_toIP.port_a) annotation (Line(points={{70,-92},{
          52,-92},{52,-68},{40,-68},{40,-72}}, color={0,127,255}));
  connect(massFlowRate_From_BOP1.port_a, mixer.ports[1]) annotation (Line(
        points={{-18,-30},{-18,-26},{-13,-26},{-13,-20}}, color={0,127,255}));
  connect(massFlowRate_From_IP.port_b, mixer.ports[2]) annotation (Line(points=
          {{-10,-46},{-10,-20},{-11,-20}}, color={0,127,255}));
  connect(massFlowRate_From_BOP.port_b, mixer.ports[3]) annotation (Line(points=
         {{4.44089e-016,-30},{4.44089e-016,-26},{-9,-26},{-9,-20}}, color={0,
          127,255}));
  connect(BPDV.port_b, mixer.ports[4]) annotation (Line(points={{18,-10},{18,-10},
          {18,-24},{-7,-24},{-7,-20}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_2, splitter.ports[2])
    annotation (Line(points={{14,20},{-39,20},{-39,50}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_1, IPDV.port_a)
    annotation (Line(points={{22,20},{48,20},{48,0}}, color={0,127,255}));
  connect(teeJunctionIdeal.port_3, BPDV.port_a)
    annotation (Line(points={{18,16},{18,12},{18,10}}, color={0,127,255}));
  connect(TDV.port_a, splitter.ports[3]) annotation (Line(points={{20,40},{
          -36.3333,40},{-36.3333,50}}, color={0,127,255}));
  connect(fixedTemperature.port, mixer.heatPort) annotation (Line(points={{-34,
          -5},{-28,-5},{-28,-10},{-20,-10}}, color={191,0,0}));
  connect(sensorBus.p_toIP, pressure.p) annotation (
      Line(
      points={{-29.9,100.1},{0,100.1},{0,102},{102,102},{102,-86},{76.6,-86}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_toIP, state_toIP.m_flow)
    annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{0,100.1},{0,102},{102,102},{102,-78},
          {46.6,-78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.h_toIP, specificEnthalpy.h_out)
    annotation (Line(
      points={{-29.9,100.1},{-29.9,100.1},{0,100.1},{0,102},{102,102},{102,-68},
          {76.6,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TDV, TDV.opening)
    annotation (Line(
      points={{30.1,100.1},{30,100.1},{30,48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_IPDV, IPDV.opening)
    annotation (Line(
      points={{30.1,100.1},{100,100.1},{100,-10},{56,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BPDV, BPDV.opening)
    annotation (Line(
      points={{30.1,100.1},{30.1,100.1},{100,100.1},{100,10},{34,10},{34,0},{26,
          0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(pump.port_b, pipe_To_PHS.port_a)
    annotation (Line(points={{-50,-40},{-60,-40}}, color={0,127,255}));
  connect(massFlowRate_From_BOP1.port_b, pump.port_a) annotation (Line(points={{
          -18,-38},{-18,-40},{-30,-40}}, color={0,127,255}));
  connect(m_flow_SG.y, pump.in_m_flow) annotation (Line(points={{-49,-22},{-40,-22},
          {-40,-32.7}}, color={0,0,127}));
  annotation (
    defaultComponentName="EM",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,140}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-38,6},{19,-6}},
          lineColor={0,0,0},
          origin={-23,10},
          rotation=70,
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
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
        Ellipse(
          extent={{-36,10},{-18,-8}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-25,10},{-29,-8}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Rectangle(
          extent={{-26,10},{-28,22}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-36,24},{-18,22}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Steam Manifold")}));
end SteamManifold;
