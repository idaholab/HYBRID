within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model CS_Modal
  import NHES;

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.PI_Control PI1(
    k=1500/550000,
    Ti=20,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1020)                   annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=0,
        origin={11,-79})));
  Modelica.Blocks.Sources.Constant FWCP_Ref(k=data.dP_FCV_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-12,-74})));
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
  Data.Data_Modal data
    annotation (Placement(transformation(extent={{-66,14},{-46,34}})));
  Modelica.Blocks.Math.Add     add1     annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-7,-53})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-10,-68},{-2,-60}})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=180,
        origin={5,-59})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay1(Ti=10) annotation (Placement(transformation(
        extent={{4,-5},{-4,5}},
        rotation=180,
        origin={18,-59})));
  BaseClasses.Peaking_Operational_Logic
    demand_Shim_Logic_New_2_1(
    Q_nom=data.Q_RX_Nominal,
    Ti_Charge=0.01,
    Ti_Discharge=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,110})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
    PI_DFV2(
    k=1,
    Ti=25,
    k_s=5e-8,
    k_m=5e-8)
    annotation (Placement(transformation(extent={{64,108},{84,128}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer1(Start_Time=30) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={104,102})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={104,68})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
    PI_TBV_Elec(
    k=1,
    Ti=100,
    k_s=1e-8,
    k_m=1e-8,
    directActing=false)
    annotation (Placement(transformation(extent={{-58,100},{-78,120}})));
  Modelica.Blocks.Math.Add add3
    annotation (Placement(transformation(extent={{-126,86},{-138,98}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
    timer(Start_Time=30) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-142,50})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
    minMaxFilter annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-172,-12})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay2(Ti=0.001)
    annotation (Placement(transformation(extent={{-16,52},{4,72}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
    PI_TBV_Rx(
    k=-1e-11,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0) annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-100,78})));
  Modelica.Blocks.Sources.Constant const1(k=162e6)
    annotation (Placement(transformation(extent={{-2,-2},{2,2}},
        rotation=90,
        origin={-88,70})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
    PI_FCV(
    k=1,
    Ti=30,
    k_s=1e-6,
    k_m=1e-6,
    directActing=true)
    annotation (Placement(transformation(extent={{-50,62},{-70,82}})));
  Modelica.Blocks.Sources.Constant const7(k=data.Q_RX_Nominal)
    annotation (Placement(transformation(extent={{-2,-2},{2,2}},
        rotation=90,
        origin={-6,0})));
  TRANSFORM.Controls.LimPID     PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1E-9,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{-2,2},{2,-2}},
        rotation=90,
        origin={-6,6})));
  Modelica.Blocks.Math.Add add4
    annotation (Placement(transformation(extent={{6,18},{14,10}})));
equation

  connect(FWCP_Ref.y, PI1.u_s) annotation (Line(points={{-7.6,-74},{0,-74},{0,
          -79},{7.4,-79}}, color={0,0,127}));
  connect(sensorBus.dP_FCV, PI1.u_m) annotation (Line(
      points={{-30,-100},{-30,-86},{11,-86},{11,-82.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FWCP_Speed, PI1.y) annotation (Line(
      points={{30,-100},{30,-79},{14.3,-79}},
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
  connect(sensorBus.Feed_Flow_Rate, PI3.u_m) annotation (Line(
      points={{-30,-100},{-30,-20},{2,-20},{2,-12.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(add1.y,min1. u2) annotation (Line(points={{-1.5,-53},{1.4,-53},{1.4,
          -57.2}},      color={0,0,127}));
  connect(min1.u1,const. y) annotation (Line(points={{1.4,-60.8},{1.4,-64},{
          -1.6,-64}},
                    color={0,0,127}));
  connect(delay1.u,min1. y) annotation (Line(points={{13.2,-59},{8.3,-59}},
                      color={0,0,127}));
  connect(sensorBus.DFV_Anticipatory, add1.u1) annotation (Line(
      points={{-30,-100},{-30,-56},{-13,-56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Superheat_Sensor_Opening, add1.u2) annotation (Line(
      points={{-30,-100},{-30,-50},{-13,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DFV_Opening, delay1.y) annotation (Line(
      points={{30,-100},{30,-59},{22.56,-59}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(demand_Shim_Logic_New_2_1.Discharge,PI_DFV2. k_in) annotation (Line(
        points={{-1.3,121.9},{-1.3,126},{78,126},{78,126},{62,126}},   color={255,
          0,255}));
  connect(demand_Shim_Logic_New_2_1.DFV_Demand,PI_DFV2. u_s) annotation (Line(
        points={{-5.1,121.9},{-5.1,130},{52,130},{52,118},{62,118}},   color={0,
          0,127}));
  connect(demand_Shim_Logic_New_2_1.DFV_Power,PI_DFV2. u_m) annotation (Line(
        points={{3.9,109.9},{60,109.9},{60,100},{74,100},{74,106}},
                                                               color={0,0,127}));
  connect(PI_DFV2.y,timer1. u)
    annotation (Line(points={{85,118},{104,118},{104,114}},color={0,0,127}));
  connect(timer1.y,minMaxFilter1. u) annotation (Line(points={{104,90.6},{104,
          80}},                                            color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.Charge,PI_TBV_Elec. k_in) annotation (Line(
        points={{-8.7,121.9},{-8.7,132},{-42,132},{-42,118},{-56,118}},
        color={255,0,255}));
  connect(demand_Shim_Logic_New_2_1.Charge, PI_TBV_Rx.k_in) annotation (Line(
        points={{-8.7,121.9},{-8.7,140},{-92,140},{-92,81.2},{-95.2,81.2}},
        color={255,0,255}));
  connect(demand_Shim_Logic_New_2_1.TBV_Demand,PI_TBV_Elec. u_s) annotation (
      Line(points={{-12.5,121.9},{-12.5,124},{-32,124},{-32,110},{-56,110}},
        color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.TBV_Power,PI_TBV_Elec. u_m) annotation (
      Line(points={{-19.9,109.9},{-28,109.9},{-28,88},{-68,88},{-68,98}},
        color={0,0,127}));
  connect(PI_TBV_Elec.y,add3. u1) annotation (Line(points={{-79,110},{-88,110},
          {-88,96},{-114,96},{-114,95.6},{-124.8,95.6}},      color={0,0,127}));
  connect(PI_TBV_Rx.y,add3. u2) annotation (Line(points={{-104.4,78},{-112,78},
          {-112,88},{-118,88},{-118,88.4},{-124.8,88.4}},
                                        color={0,0,127}));
  connect(add3.y,timer. u) annotation (Line(points={{-138.6,92},{-144,92},{-144,
          70},{-142,70},{-142,62}},         color={0,0,127}));
  connect(timer.y,minMaxFilter. u) annotation (Line(points={{-142,38.6},{-142,
          30},{-174,30},{-174,0},{-172,0}},
                                          color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.FCV_Demand, PI_FCV.u_s) annotation (Line(
        points={{-19.9,101.9},{-26,101.9},{-26,78},{-40,78},{-40,72},{-48,72}},
                                                                color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.Nominal, PI_FCV.k_in) annotation (Line(
        points={{-16.5,98.1},{-16.5,86},{-48,86},{-48,80}},
                                                      color={255,0,255}));
  connect(demand_Shim_Logic_New_2_1.FCV_Power, PI_FCV.u_m) annotation (Line(
        points={{-12.7,98.1},{-12.7,76},{-36,76},{-36,54},{-60,54},{-60,60}},
        color={0,0,127}));
  connect(delay2.y,demand_Shim_Logic_New_2_1. Power) annotation (Line(points={{5.4,62},
          {16,62},{16,86},{-4,86},{-4,97.8}},              color={0,0,127}));
  connect(actuatorBus.DCV_Opening, minMaxFilter1.y) annotation (Line(
      points={{30,-100},{30,12},{104,12},{104,56.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Demand, demand_Shim_Logic_New_2_1.Demand) annotation (Line(
      points={{-30,-100},{-30,36},{-28,36},{-28,38},{-8,38},{-8,98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Generator_Power, delay2.u) annotation (Line(
      points={{-30,-100},{-30,64},{-18,64},{-18,62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_TBV_Rx.u_s,const1. y) annotation (Line(points={{-95.2,78},{-88,78},
          {-88,72.2}},        color={0,0,127}));
  connect(actuatorBus.TBV_Opening, minMaxFilter.y) annotation (Line(
      points={{30,-100},{18,-100},{18,-98},{-24,-98},{-24,-76},{-174,-76},{-174,
          -23.4},{-172,-23.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PID.u_s,const7. y) annotation (Line(points={{-6,3.6},{-6,2.2}},
                   color={0,0,127}));
  connect(PID.y,add4. u2) annotation (Line(points={{-6,8.2},{-6,10},{0,10},{0,
          16.4},{5.2,16.4}},           color={0,0,127}));
  connect(sensorBus.Q_RX, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,6},{-8.4,6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI3.y, add4.u1) annotation (Line(points={{6.4,-8},{14,-8},{14,4},{2,4},
          {2,11.6},{5.2,11.6}}, color={0,0,127}));
  connect(actuatorBus.FCV_Opening, add4.y) annotation (Line(
      points={{30,-100},{30,14},{14.4,14}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_RX, PI_TBV_Rx.u_m) annotation (Line(
      points={{-30,-100},{-30,40},{-100,40},{-100,73.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
    annotation (Placement(transformation(extent={{-94,4},{-64,36}})),
           defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Modal;
