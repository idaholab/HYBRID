within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR;
model Reactor_speed

  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable PrismaticHTGR.CS.CS_Texit_speedControl CS,
    redeclare replaceable PrismaticHTGR.CS.ED_Dummy ED,
    redeclare Data.Data_1 data);

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    use_input=true,
    m_flow_nominal=8.75)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,10})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_inlet(
    nParallel=data.nAsm*data.nSCs,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_a_start=3400000,
    T_a_start=573.15,
    m_flow_a_start=8.75,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=data.r_coolant,
        length=data.l_ci,
        angle=-1.5707963267949,
        nV=2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,40})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_oulet(
    nParallel=data.nAsm*data.nSCs,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_a_start=3100000,
    T_a_start=1173.15,
    m_flow_a_start=8.75,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=data.r_coolant,
        length=data.l_co,
        angle=-1.5707963267949,
        nV=2)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-40})));
  TRANSFORM.Fluid.Volumes.SimpleVolume UP(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_start=3400000,
    T_start=573.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_up, dheight=-3)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,82})));
  TRANSFORM.Fluid.Volumes.SimpleVolume LP(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_start=3000000,
    T_start=1173.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=data.V_lp, dheight=-3)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,-70})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fRX(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_a_start=3000000,
    T_a_start=1173.15,
    m_flow_a_start=8.75,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension=data.r_fRX,
        length=data.l_fRX,
        nV=3))
    annotation (Placement(transformation(extent={{-10,-102},{10,-82}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface tRX(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_a_start=3500000,
    T_a_start=573.15,
    m_flow_a_start=8.75,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
        (
        rs_inner=data.r_i_tRX*ones(3),
        rs_outer=data.r_o_tRX*ones(3),
        nV=3,
        dlengths=(data.l_tRX/3)*ones(3)))
    annotation (Placement(transformation(extent={{10,-82},{-10,-62}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_Outer(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p_a_start=3450000,
    T_a_start=573.15,
    m_flow_a_start=8.75,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
        (
        rs_inner=data.r_i_CO*ones(3),
        rs_outer=data.r_o_CO*ones(3),
        nV=3,
        dlengths=(data.l_CO/3)*ones(3),
        dheights=(data.l_CO/3)*ones(3))) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-40,0})));
  TRANSFORM.Fluid.Sensors.Temperature Core_inlet_T(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,62})));
  TRANSFORM.Fluid.Sensors.Temperature Core_outlet_T(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-90,-20},{-110,0}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Sources.RealExpression RX_Power(y=core.Total_Power.y)
    annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
  Components.Core core(
    Q_nominal=15e6,
    rho_input=controlRod.y + 0.3,
    Teffref_fuel(displayUnit="K") = 273.15,
    Teffref_mod(displayUnit="K") = 273.15,
    T_Fouter_start=1073.15,
    T_Finner_start=1123.15)                        annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-70,6})));
  Components.ControlRod controlRod(Worth_total=-500e-3)
    annotation (Placement(transformation(extent={{58,90},{78,110}})));
equation

  connect(Core_oulet.port_b,LP. port_a)
    annotation (Line(points={{-70,-50},{-70,-64}}, color={0,127,255}));
  connect(LP.port_b,fRX. port_a) annotation (Line(points={{-70,-76},{-70,-92},{-10,
          -92}},      color={0,127,255}));
  connect(pump.port_b,tRX. port_a) annotation (Line(points={{70,0},{70,-72},{
          10,-72}},              color={0,127,255}));
  connect(tRX.port_b,Core_Outer. port_a) annotation (Line(points={{-10,-72},{-40,
          -72},{-40,-10}},     color={0,127,255}));
  connect(Core_Outer.port_b,UP. port_a) annotation (Line(points={{-40,10},{-40,92},
          {-70,92},{-70,88}},         color={0,127,255}));
  connect(sensor_m_flow.port_a,Core_inlet. port_a)
    annotation (Line(points={{-70,52},{-70,50}}, color={0,127,255}));
  connect(sensor_m_flow.port_b,UP. port_b)
    annotation (Line(points={{-70,72},{-70,76}}, color={0,127,255}));
  connect(Core_outlet_T.port,Core_oulet. port_a) annotation (Line(points={{-100,
          -20},{-100,-30},{-70,-30}},      color={0,127,255}));
  connect(Core_inlet_T.port,Core_inlet. port_b) annotation (Line(points={{-100,40},
          {-100,30},{-70,30}},          color={0,127,255}));
  connect(sensorBus.T_in,Core_inlet_T. T) annotation (Line(
      points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,50},{-106,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.T_out,Core_outlet_T. T) annotation (Line(
      points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,-10},{-106,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.m_RX,sensor_m_flow. m_flow) annotation (Line(
      points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,62},{-73.6,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fRX.port_b,port_b)  annotation (Line(points={{10,-92},{86,-92},{86,
          -60},{100,-60}},    color={0,127,255}));
  connect(port_a,pump. port_a) annotation (Line(points={{100,60},{70,60},{70,
          20}},      color={0,127,255}));
  connect(sensorBus.Q_RX,RX_Power. y) annotation (Line(
      points={{-30,100},{-79,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Core_inlet.port_b, core.port_a)
    annotation (Line(points={{-70,30},{-70,26}}, color={0,127,255}));
  connect(core.port_b, Core_oulet.port_a)
    annotation (Line(points={{-70,-14},{-70,-30}}, color={0,127,255}));
  connect(actuatorBus.Pump_flow, pump.in_m_flow) annotation (Line(
      points={{30,100},{30,10},{62.7,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.CR_speed, controlRod.u) annotation (Line(
      points={{30,100},{58,100}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    defaultComponentName="changeMe",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
<p>Prismatic High Temperature Gas-cooled Reactor.</p>
<p>This verson uses control rods with a speed controller.</p>
<p><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end Reactor_speed;
