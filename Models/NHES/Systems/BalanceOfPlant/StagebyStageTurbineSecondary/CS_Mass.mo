within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model CS_Mass

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.PI_Control PID(
    k=-1e-9,
    Ti=30,
    y_start=-1)                     annotation (Placement(transformation(
        extent={{3,3},{-3,-3}},
        rotation=180,
        origin={5,-55})));
  Modelica.Blocks.Sources.Constant TBV_Flow(k=52e6)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-16,-56})));
  Modelica.Blocks.Sources.Constant TCV_Ref(k=data.P_Turbine_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-14,-28})));
  TRANSFORM.Controls.PI_Control PI2(
    k=1e-6,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    directActing=false,
    x_start=1000,
    y_start=1)
    annotation (Placement(transformation(extent={{4,4},{-4,-4}},
        rotation=180,
        origin={0,-28})));
  Modelica.Blocks.Sources.Constant FCV_Ref(k=data.Feed_Flow_Nominal)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-14,-8})));
  TRANSFORM.Controls.PI_Control PI3(
    k=1/51.4,
    Ti=3,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    x_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{4,4},{-4,-4}},
        rotation=180,
        origin={2,-8})));
  Data.Data_Cycle data(P_Turbine_Reference=3720000)
    annotation (Placement(transformation(extent={{-80,56},{-60,76}})));
  Control_and_Distribution.Timer                   timer(Start_Time=10)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={22,8})));
  Control_and_Distribution.Timer                   timer1(Start_Time=15)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={26,-22})));
  Control_and_Distribution.Timer                   timer2(Start_Time=60)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={32,-46})));
  Modelica.Blocks.Sources.Constant FWCP_Ref1(k=data.dP_FCV_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-10,42})));
  TRANSFORM.Controls.LimPID     FWCP(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=15/55000,
    Ti=20,
    y_start=1220) annotation (Placement(transformation(
        extent={{-3,3},{3,-3}},
        rotation=0,
        origin={5,41})));
  Modelica.Blocks.Sources.Constant FWCP_Ref2(k=1250) annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={6,28})));
  Modelica.Blocks.Math.Add add3_1(k1=1)
    annotation (Placement(transformation(extent={{22,52},{42,72}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{90,-42},{94,-38}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{102,-46},{106,-42}})));
  Modelica.Blocks.Sources.Constant k1(k=1) annotation (Placement(transformation(
        extent={{-2,2},{2,-2}},
        rotation=0,
        origin={82,-42})));
  Modelica.Blocks.Sources.Constant k2(k=0.0) annotation (Placement(
        transformation(
        extent={{-2,2},{2,-2}},
        rotation=0,
        origin={98,-44})));
equation

  connect(PI2.u_s, TCV_Ref.y)
    annotation (Line(points={{-4.8,-28},{-9.6,-28}}, color={0,0,127}));
  connect(sensorBus.P_Turbine_Inlet, PI2.u_m) annotation (Line(
      points={{-30,-100},{-30,-38},{-2,-38},{-2,-32.8},{0,-32.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI3.u_s, FCV_Ref.y)
    annotation (Line(points={{-2.8,-8},{-9.6,-8}}, color={0,0,127}));
  connect(sensorBus.Feed_Flow_Rate, PI3.u_m) annotation (Line(
      points={{-30,-100},{-30,-20},{2,-20},{2,-12.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV_Opening, timer2.y) annotation (Line(
      points={{30,-100},{30,-74},{42,-74},{42,-46},{36.56,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Opening, timer1.y) annotation (Line(
      points={{30,-100},{32,-100},{32,-60},{48,-60},{48,-22},{30.56,-22}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FCV_Opening, timer.y) annotation (Line(
      points={{30,-100},{30,-56},{52,-56},{52,8},{26.56,8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI3.y, timer.u) annotation (Line(points={{6.4,-8},{12,-8},{12,4},{
          17.2,4},{17.2,8}}, color={0,0,127}));
  connect(timer1.u, PI2.y) annotation (Line(points={{21.2,-22},{16,-22},{16,-28},
          {4.4,-28}}, color={0,0,127}));
  connect(FWCP.u_s, FWCP_Ref1.y) annotation (Line(points={{1.4,41},{-2,41},{-2,
          42},{-5.6,42}}, color={0,0,127}));
  connect(sensorBus.dP_FCV,FWCP. u_m) annotation (Line(
      points={{-30,-100},{-30,50},{5,50},{5,44.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(FWCP_Ref2.y,add3_1. u2) annotation (Line(points={{10.4,28},{14,28},{
          14,56},{20,56}},   color={0,0,127}));
  connect(FWCP.y,add3_1. u1)
    annotation (Line(points={{8.3,41},{8.3,68},{20,68}},    color={0,0,127}));
  connect(actuatorBus.FWCP_Speed,add3_1. y) annotation (Line(
      points={{30,-100},{30,48},{60,48},{60,62},{43,62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Generator_Power, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-64},{5,-64},{5,-58.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TBV_Flow.y, PID.u_s) annotation (Line(points={{-11.6,-56},{-6,-56},{
          -6,-55},{1.4,-55}}, color={0,0,127}));
  connect(min1.y, max1.u1) annotation (Line(points={{94.2,-40},{96,-40},{96,-38},
          {101.6,-38},{101.6,-42.8}}, color={0,0,127}));
  connect(max1.u2, k2.y)
    annotation (Line(points={{101.6,-45.2},{100.2,-44}}, color={0,0,127}));
  connect(min1.u2, k1.y) annotation (Line(points={{89.6,-41.2},{84.2,-41.2},{
          84.2,-42}}, color={0,0,127}));
  connect(PID.y, min1.u1) annotation (Line(points={{8.3,-55},{74,-55},{74,-38.8},
          {89.6,-38.8}}, color={0,0,127}));
  connect(max1.y, timer2.u) annotation (Line(points={{106.2,-44},{118,-44},{118,
          -38},{20,-38},{20,-46},{27.2,-46}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-94,4},{-64,36}})),
           defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Mass;
