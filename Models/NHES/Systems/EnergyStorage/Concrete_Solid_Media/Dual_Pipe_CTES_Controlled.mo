within NHES.Systems.EnergyStorage.Concrete_Solid_Media;
model Dual_Pipe_CTES_Controlled
   extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);
  input Real External_Power;
  input Real External_Demand;
  replaceable package HTF = Modelica.Media.Water.StandardWater annotation(allMatchingChoices = true);
  parameter Modelica.Units.SI.Pressure P_Rise_DFV = 6e5;
  Components.Dual_Pipe_Model CTES(
    nY=7,
    nX=9,
    tau=0.05,
    nPipes=250,
    dX=150,
    dY=0.3,
    redeclare package TES_Med = BaseClasses.HeatCrete,
    redeclare package HTF = HTF,
    Hot_Con_Start=443.15,
    Cold_Con_Start=363.15)
    annotation (Placement(transformation(extent={{-34,-28},{36,42}})));

  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance12(dp0=-
        P_Rise_DFV)
    annotation (Placement(transformation(extent={{34,-54},{54,-34}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
    DFV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=250000,
    m_flow_nominal=20,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{5,5},{-5,-5}},
        rotation=180,
        origin={73,-43})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-4,4},{4,-4}},
        rotation=90,
        origin={100,-36})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss Condensate_Res(dp0=2200000)
                 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={72,32})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_charge_a(redeclare package
      Medium = HTF) annotation (Placement(
        transformation(extent={{-112,32},{-92,52}}), iconTransformation(extent={
            {-112,32},{-92,52}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_discharge_b(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{-112,-66},{-92,
            -46}}), iconTransformation(extent={{-112,-66},{-92,-46}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_discharge_a(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{88,-62},{108,-42}}),
        iconTransformation(extent={{88,-62},{108,-42}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_charge_b(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{94,36},{114,56}}),
        iconTransformation(extent={{94,36},{114,56}})));
  Modelica.Blocks.Sources.RealExpression ConcreteTemp(y=CTES.T_Ave_Conc)
    annotation (Placement(transformation(extent={{-124,88},{-104,108}})));
  Modelica.Blocks.Sources.RealExpression Demand(y=External_Demand)
    annotation (Placement(transformation(extent={{-124,70},{-104,90}})));
  Modelica.Blocks.Sources.RealExpression Power(y=External_Power)
    annotation (Placement(transformation(extent={{-124,56},{-104,76}})));
equation

  connect(resistance12.port_b,DFV. port_a) annotation (Line(points={{51,-44},{68,
          -44},{68,-43}},  color={0,127,255}));
  connect(DFV.port_b,sensor_m_flow2. port_a) annotation (Line(points={{78,-43},{
          90,-43},{90,-46},{100,-46},{100,-40}},    color={0,127,255}));
  connect(CTES.Charge_Inlet, port_charge_a) annotation (Line(points={{-26.3,14.7},
          {-58,14.7},{-58,42},{-102,42}}, color={0,127,255}));
  connect(CTES.Charge_Outlet, Condensate_Res.port_a) annotation (Line(points={{11.5,
          28.7},{10,28.7},{10,52},{72,52},{72,39}}, color={0,127,255}));
  connect(Condensate_Res.port_b, port_charge_b) annotation (Line(points={{72,25},
          {82,25},{82,26},{92,26},{92,46},{104,46}}, color={0,127,255}));
  connect(port_discharge_a, resistance12.port_a) annotation (Line(points={{98,-52},
          {58,-52},{58,-54},{20,-54},{20,-44},{37,-44}}, color={0,127,255}));
  connect(sensor_m_flow2.port_b, CTES.Discharge_Inlet) annotation (Line(points={
          {100,-32},{100,8},{98,8},{98,6.3},{28.3,6.3}}, color={0,127,255}));
  connect(CTES.Discharge_Outlet, port_discharge_b) annotation (Line(points={{-4.6,
          -12.6},{-4.6,-56},{-102,-56}}, color={0,127,255}));
  connect(actuatorBus.DFV_Opening, DFV.opening) annotation (Line(
      points={{30,100},{32,100},{32,76},{150,76},{150,-24},{73,-24},{73,-39}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_dis, sensor_m_flow2.m_flow) annotation (Line(
      points={{-30,100},{-30,84},{188,84},{188,-36},{101.44,-36}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.T_Ave_Conc, ConcreteTemp.y) annotation (Line(
      points={{-30,100},{-30,84},{-96,84},{-96,98},{-103,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.External_Demand, Demand.y) annotation (Line(
      points={{-30,100},{-30,84},{-96,84},{-96,80},{-103,80}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.External_Power, Power.y) annotation (Line(
      points={{-30,100},{-30,84},{-98,84},{-98,66},{-103,66}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (experiment(
      StopTime=864000,
      __Dymola_NumberOfIntervals=1957,
      __Dymola_Algorithm="Esdirk45a"),
    Diagram(coordinateSystem(extent={{-120,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}}), graphics={
                             Bitmap(extent={{-92,-72},{92,76}},   fileName="modelica://NHES/Icons/EnergyStoragePackage/Concreteimg.jpg")}),
    Documentation(info="<html>
<p>This particular controlled CTES model is for use with the Nuscale stage-by-stage turbine model. The DCV is within the model itself, allowing the CTES to control its own pressure rise (surrogate for a pump) and flow characteristic. </p>
<p>That does mean that the demand and power levels need to be piped into the model, and a control system for the DCV needs to be put in place. </p>
</html>"));
end Dual_Pipe_CTES_Controlled;
