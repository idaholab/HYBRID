within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model CS_Nominal_New

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.PI_Control PI9(
    k=5e-2,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=-1)                     annotation (Placement(transformation(
        extent={{3,3},{-3,-3}},
        rotation=180,
        origin={21,-73})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{4,-76},{10,-70}})));
  Modelica.Blocks.Sources.Constant TBV_Flow(k=data.Cycle_Bypass_Mflow_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-12,-74})));
  TRANSFORM.Controls.PI_Control PI1(
    k=1500/550000,
    Ti=20,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1020)                   annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={11,-53})));
  Modelica.Blocks.Sources.Constant FWCP_Ref(k=data.dP_FCV_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-12,-48})));
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
  Data.Data_Cycle data
    annotation (Placement(transformation(extent={{-66,14},{-46,34}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{6,46},{26,26}})));
  Modelica.Blocks.Sources.Constant FCV_Ref1(k=1)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={-6,56})));
protected
  Modelica.Blocks.Sources.Trapezoid Charge_Frac(
    amplitude=1,
    rising=500,
    width=17000,
    falling=500,
    period=86400,
    startTime=9600)
                  annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={-3,-67})));
  Modelica.Blocks.Sources.Trapezoid DCV_Opening(
    amplitude=1,
    rising=data.Discharge_Ramp,
    width=data.Discharge_Length - data.Discharge_Ramp,
    falling=data.Discharge_Ramp,
    period=data.Cycle_Period,
    offset=0,
    startTime=data.Discharge_Delay) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-9,5})));
  Modelica.Blocks.Sources.Trapezoid DCV_Opening1(
    amplitude=1,
    rising=data.Discharge_Ramp,
    width=3*data.Discharge_Ramp,
    falling=data.Discharge_Ramp,
    period=data.Cycle_Period,
    offset=0,
    startTime=data.Discharge_Delay - data.Discharge_Ramp)
                                    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={-19,55})));
equation

  connect(product4.y,PI9. u_s) annotation (Line(points={{10.3,-73},{10.3,-68},{17.4,
          -68},{17.4,-73}},                        color={0,0,127}));
  connect(Charge_Frac.y,product4. u1) annotation (Line(points={{0.3,-67},{2,-67},
          {2,-68},{3.4,-68},{3.4,-71.2}},
                                color={0,0,127}));
  connect(actuatorBus.TBV_Opening, PI9.y) annotation (Line(
      points={{30,-100},{30,-73},{24.3,-73}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.TBV_Mass_Flow, PI9.u_m) annotation (Line(
      points={{-30,-100},{-30,-82},{20,-82},{20,-76.6},{21,-76.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TBV_Flow.y, product4.u2) annotation (Line(points={{-7.6,-74},{-2,-74},
          {-2,-74.8},{3.4,-74.8}}, color={0,0,127}));
  connect(FWCP_Ref.y, PI1.u_s) annotation (Line(points={{-7.6,-48},{0,-48},{0,-53},
          {7.4,-53}}, color={0,0,127}));
  connect(sensorBus.dP_FCV, PI1.u_m) annotation (Line(
      points={{-30,-100},{-30,-60},{11,-60},{11,-56.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FWCP_Speed, PI1.y) annotation (Line(
      points={{30,-100},{30,-53},{14.3,-53}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI2.u_s, TCV_Ref.y)
    annotation (Line(points={{-4.8,-28},{-9.6,-28}}, color={0,0,127}));
  connect(actuatorBus.TCV_Opening, PI2.y) annotation (Line(
      points={{30,-100},{30,-28},{4.4,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.P_Turbine_Inlet, PI2.u_m) annotation (Line(
      points={{-30,-100},{-30,-38},{-2,-38},{-2,-32.8},{0,-32.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI3.u_s, FCV_Ref.y)
    annotation (Line(points={{-2.8,-8},{-9.6,-8}}, color={0,0,127}));
  connect(actuatorBus.FCV_Opening, PI3.y) annotation (Line(
      points={{30,-100},{30,-8},{6.4,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feed_Flow_Rate, PI3.u_m) annotation (Line(
      points={{-30,-100},{-30,-20},{2,-20},{2,-12.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DCV_Opening, DCV_Opening.y) annotation (Line(
      points={{30,-100},{30,2},{0,2},{0,5},{-3.5,5}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(DCV_Opening1.y, add.u1) annotation (Line(points={{-24.5,55},{-26,55},
          {-26,54},{-28,54},{-28,40},{-26,40}}, color={0,0,127}));
  connect(sensorBus.Superheat_Sensor_Opening, add.u2) annotation (Line(
      points={{-30,-100},{-30,28},{-26,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.y, min1.u1)
    annotation (Line(points={{-3,34},{4,34},{4,30}}, color={0,0,127}));
  connect(min1.u2, FCV_Ref1.y)
    annotation (Line(points={{4,42},{4,56},{-1.6,56}}, color={0,0,127}));
  connect(actuatorBus.DFV_Opening, min1.y) annotation (Line(
      points={{30,-100},{30,34},{28,34},{28,36},{27,36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
    annotation (Placement(transformation(extent={{-94,4},{-64,36}})),
           defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Nominal_New;
