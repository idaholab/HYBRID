within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model CS_Modal
  import NHES;

  extends BaseClasses.Partial_ControlSystem;
  Real TBV_Lin;
  Real TBV_Quad;
  Real TBV_Sum;
  Data.Data_Modal data(
    P_Turbine_Reference=3720000,
    dP_FCV_Reference=200000,
    Q_RX_Nominal=160e6,
    Q_Turb_Nominal=52000000)
    annotation (Placement(transformation(extent={{-66,12},{-46,32}})));
  TRANSFORM.Controls.LimPID     FWCP(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=15/55000,
    Ti=20,
    y_start=1220) annotation (Placement(transformation(
        extent={{-3,3},{3,-3}},
        rotation=0,
        origin={3,-79})));
  Modelica.Blocks.Sources.Constant FWCP_Ref(k=data.dP_FCV_Reference)
    annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={-12,-78})));
  Modelica.Blocks.Sources.Constant FWCP_Ref1(k=1000) annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={4,-92})));
  Modelica.Blocks.Math.Add add3_1(k1=1)
    annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
  Modelica.Blocks.Math.Add add_DFV annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-7,-25})));
  Modelica.Blocks.Sources.Constant DFV_max(k=1)
    annotation (Placement(transformation(extent={{-12,-42},{-4,-34}})));
  Modelica.Blocks.Math.Min min_DFV_signal annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=180,
        origin={11,-29})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay_DFV(Ti=10) annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=180,
        origin={35,-27})));
  TRANSFORM.Controls.PI_Control PI_TCV_TurbP(
    k=-1e-6,
    Ti=10,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0)  annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={18,-4})));
  Modelica.Blocks.Sources.Constant TCV_Ref_P(k=3.72e6)
    annotation (Placement(transformation(extent={{0,0},{8,-8}}, rotation=0)));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.BaseClasses.Peaking_Operational_Logic
                                                                     demand_Shim_Logic_New_2_1(
    Q_nom=data.Q_Turb_Nominal,
    Ti_Charge=0.01,
    Ti_Discharge=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-2,50})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DCV(
    k=10,
    Ti=25,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{122,82},{142,102}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                   timer(Start_Time=60)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-134,42})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
                                                          minMaxFilter
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-134,8})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                   timer1(Start_Time=30)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={162,68})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
                                                          minMaxFilter1
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={170,-20})));
  TRANSFORM.Controls.LimPID     PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1E-9,
    Ti=30,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=1)
    annotation (Placement(transformation(extent={{-2,2},{2,-2}},
        rotation=90,
        origin={-86,-56})));
  Modelica.Blocks.Sources.Constant const7(k=data.Q_Rx_Nom)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-88,-76})));
  Modelica.Blocks.Math.Add add4(k1=0.0, k2=1)
    annotation (Placement(transformation(extent={{-60,-50},{-52,-42}})));
  TRANSFORM.Controls.LimPID     PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/700,
    Ti=5,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    y_start=0.93)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=90,
        origin={-100,-20})));
  Modelica.Blocks.Sources.Constant const3(k=68.4)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-101,5})));
  Modelica.Blocks.Math.Add add1(k1=1)
    annotation (Placement(transformation(extent={{70,-40},{78,-32}})));
  TRANSFORM.Controls.LimPID PI_TCV_TurbP_PID(
    k=-1e-6,
    Ti=10,
    yMax=1,
    yMin=-0.2,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.51) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={96,-2})));
  Modelica.Blocks.Sources.Constant TCV_Ref_P1(k=3.72e6)
    annotation (Placement(transformation(extent={{78,2},{86,-6}},
                                                                rotation=0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={208,40})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={221,79})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={201,71})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={170,16})));
  TRANSFORM.Controls.LimPID PI_TBV1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-6e-10,
    Ti=10,
    yMax=1,
    yMin=0.0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0.0) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-88,42})));
  Modelica.Blocks.Math.Min TBV_Elec_Demand annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-104,98})));
  Modelica.Blocks.Sources.Constant const4(k=100e6)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-119,129})));
  Modelica.Blocks.Math.Add TBV_Mass_Ref
    annotation (Placement(transformation(extent={{-172,-76},{-152,-56}})));
  Modelica.Blocks.Sources.Constant const5(k=-5.9436)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-193,-51})));
  Modelica.Blocks.Math.Gain gain(k=1.892e-6)
    annotation (Placement(transformation(extent={{-150,-110},{-170,-90}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                   timer2(Start_Time=25,
      init_mult=0.1)
    annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={52,-18})));
  Modelica.Blocks.Sources.Constant FWCP_Ref2(k=0.9)  annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=0,
        origin={72,-14})));
  Modelica.Blocks.Math.Min min2 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-118,-104})));
  Modelica.Blocks.Sources.Constant const6(k=data.Q_Turb_Nominal)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-81,-111})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
    delay_DFV1(Ti=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=180,
        origin={-137,-97})));
equation
  TBV_Mass_Ref.u2 = TBV_Sum;
algorithm
  if gain.u>data.Q_Turb_Nominal then
    TBV_Lin := gain.k*data.Q_Turb_Nominal;
    TBV_Quad := data.Q_Turb_Nominal*data.Q_Turb_Nominal*(-9.086e-15);
    else
  TBV_Lin := gain.y;
  TBV_Quad := gain.u*gain.u*(-9.086e-15);
  end if;
  TBV_Sum := TBV_Quad+TBV_Lin;
equation
  connect(sensorBus.dP_FCV, FWCP.u_m) annotation (Line(
      points={{-30,-100},{-30,-70},{3,-70},{3,-75.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(FWCP.u_s, FWCP_Ref.y) annotation (Line(points={{-0.6,-79},{-4,-79},{-4,
          -78},{-7.6,-78}}, color={0,0,127}));
  connect(FWCP.y, add3_1.u1)
    annotation (Line(points={{6.3,-79},{6.3,-52},{18,-52}}, color={0,0,127}));
  connect(FWCP_Ref1.y, add3_1.u2) annotation (Line(points={{8.4,-92},{12,-92},{
          12,-64},{18,-64}}, color={0,0,127}));
  connect(actuatorBus.FWCP_Speed, add3_1.y) annotation (Line(
      points={{30,-100},{30,-72},{58,-72},{58,-58},{41,-58}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(delay_DFV.u, min_DFV_signal.y) annotation (Line(points={{31.4,-27},{24,
          -27},{24,-29},{14.3,-29}}, color={0,0,127}));
  connect(add_DFV.y, min_DFV_signal.u2) annotation (Line(points={{-1.5,-25},{8,-25},
          {8,-24},{7.4,-24},{7.4,-27.2}}, color={0,0,127}));
  connect(min_DFV_signal.u1, DFV_max.y) annotation (Line(points={{7.4,-30.8},{8,
          -30.8},{8,-38},{-3.6,-38}}, color={0,0,127}));
  connect(sensorBus.DFV_Anticipatory, add_DFV.u1) annotation (Line(
      points={{-30,-100},{-30,-28},{-13,-28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Superheat_Sensor_Opening, add_DFV.u2) annotation (Line(
      points={{-30,-100},{-30,-22},{-13,-22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TCV_Ref_P.y, PI_TCV_TurbP.u_s)
    annotation (Line(points={{8.4,-4},{13.2,-4}}, color={0,0,127}));
  connect(sensorBus.P_Turbine_Inlet, PI_TCV_TurbP.u_m) annotation (Line(
      points={{-30,-100},{-26,-100},{-26,16},{18,16},{18,0.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(demand_Shim_Logic_New_2_1.DFV_Power, PI_DCV.u_m) annotation (Line(
        points={{9.9,49.9},{118,49.9},{118,80},{132,80}}, color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.DFV_Demand, PI_DCV.u_s) annotation (Line(
        points={{0.9,61.9},{0.9,66},{116,66},{116,92},{120,92}}, color={0,0,127}));
  connect(demand_Shim_Logic_New_2_1.Discharge, PI_DCV.k_in) annotation (Line(
        points={{4.7,61.9},{4.7,100},{120,100}}, color={255,0,255}));
  connect(timer.y,minMaxFilter. u) annotation (Line(points={{-134,37.44},{-120,
          37.44},{-120,12.8},{-134,12.8}},color={0,0,127}));
  connect(sensorBus.Demand, demand_Shim_Logic_New_2_1.Demand) annotation (Line(
      points={{-30,-100},{-30,26},{-2,26},{-2,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(timer1.u, PI_DCV.y)
    annotation (Line(points={{162,80},{162,92},{143,92}}, color={0,0,127}));
  connect(const3.y,PID1. u_s) annotation (Line(points={{-101,-0.5},{-100,-0.5},
          {-100,-12.8}},color={0,0,127}));
  connect(PID1.y,add4. u1) annotation (Line(points={{-100,-26.6},{-100,-42},{-64,
          -42},{-64,-38},{-60.8,-38},{-60.8,-43.6}},
                                       color={0,0,127}));
  connect(PID.y,add4. u2) annotation (Line(points={{-86,-53.8},{-86,-48.4},{-60.8,
          -48.4}},                     color={0,0,127}));
  connect(const7.y, PID.u_s) annotation (Line(points={{-88,-69.4},{-88,-62},{-86,
          -62},{-86,-58.4}}, color={0,0,127}));
  connect(sensorBus.Q_RX, PID.u_m) annotation (Line(
      points={{-30,-100},{-98,-100},{-98,-56},{-88.4,-56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feed_Flow_Rate, PID1.u_m) annotation (Line(
      points={{-30,-100},{-32,-100},{-32,-44},{-116,-44},{-116,-20},{-107.2,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(actuatorBus.FCV_Opening, add4.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-114},{-44,-114},{-44,-46},{-51.6,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Generator_Power, demand_Shim_Logic_New_2_1.Power)
    annotation (Line(
      points={{-30,-100},{-30,26},{2,26},{2,37.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Opening, add1.y) annotation (Line(
      points={{30,-100},{68,-100},{68,-98},{106,-98},{106,-38},{78.4,-38},{78.4,
          -36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV_Opening, minMaxFilter.y) annotation (Line(
      points={{30,-100},{30,-34},{24,-34},{24,-16},{-68,-16},{-68,3.44},{-134,
          3.44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DFV_Opening, delay_DFV.y) annotation (Line(
      points={{30,-100},{58,-100},{58,-90},{60,-90},{60,-27},{38.42,-27}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DCV_Opening, minMaxFilter1.y) annotation (Line(
      points={{30,-100},{30,-74},{118,-74},{118,-31.4},{170,-31.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(PI_TCV_TurbP_PID.u_s, TCV_Ref_P1.y) annotation (Line(points={{91.2,-2},
          {88,-2},{88,-2},{86.4,-2}}, color={0,0,127}));
  connect(sensorBus.P_Turbine_Inlet, PI_TCV_TurbP_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,14},{96,14},{96,2.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(demand_Shim_Logic_New_2_1.Discharge, switch1.u2) annotation (Line(
        points={{4.7,61.9},{4.7,108},{212,108},{212,52},{208,52}}, color={255,0,
          255}));
  connect(switch1.u1, const2.y) annotation (Line(points={{200,52},{200,54},{198,
          54},{198,65.5},{201,65.5}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{221,73.5},{221,66},{
          218,66},{218,58},{216,58},{216,52}}, color={0,0,127}));
  connect(switch1.y, min1.u2) annotation (Line(points={{208,29},{192,29},{192,
          28},{176,28}}, color={0,0,127}));
  connect(timer1.y, min1.u1) annotation (Line(points={{162,56.6},{164,56.6},{
          164,28}}, color={0,0,127}));
  connect(minMaxFilter1.u, min1.y)
    annotation (Line(points={{170,-8},{170,5}}, color={0,0,127}));
  connect(sensorBus.Generator_Power, PI_TBV1.u_m) annotation (Line(
      points={{-30,-100},{-30,34},{-24,34},{-24,44},{-83.2,44},{-83.2,42}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TBV_Elec_Demand.y, PI_TBV1.u_s) annotation (Line(points={{-104,87},{-106,
          87},{-106,78},{-86,78},{-86,46.8},{-88,46.8}}, color={0,0,127}));
  connect(sensorBus.Demand,TBV_Elec_Demand. u2) annotation (Line(
      points={{-30,-100},{-30,56},{-82,56},{-82,120},{-98,120},{-98,110}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(TBV_Elec_Demand.u1,const4. y) annotation (Line(points={{-110,110},{-110,
          123.5},{-119,123.5}},         color={0,0,127}));
  connect(PI_TBV1.y, timer.u) annotation (Line(points={{-88,37.6},{-88,34},{-116,
          34},{-116,52},{-134,52},{-134,46.8}}, color={0,0,127}));
  connect(const5.y, TBV_Mass_Ref.u1) annotation (Line(points={{-193,-56.5},{-193,
          -60},{-174,-60}}, color={0,0,127}));

  connect(PI_TCV_TurbP.y, timer2.u) annotation (Line(points={{22.4,-4},{36,-4},
          {36,-6},{52,-6},{52,-13.2}}, color={0,0,127}));
  connect(timer2.y, add1.u2) annotation (Line(points={{52,-22.56},{52,-38},{
          69.2,-38},{69.2,-38.4}}, color={0,0,127}));
  connect(FWCP_Ref2.y, add1.u1) annotation (Line(points={{76.4,-14},{82,-14},{
          82,-26},{64,-26},{64,-33.6},{69.2,-33.6}}, color={0,0,127}));
  connect(const6.y, min2.u2) annotation (Line(points={{-81,-116.5},{-81,-124},{
          -94,-124},{-94,-112},{-106,-112},{-106,-110}}, color={0,0,127}));
  connect(sensorBus.Demand, min2.u1) annotation (Line(
      points={{-30,-100},{-30,-76},{-76,-76},{-76,-102},{-100,-102},{-100,-98},
          {-106,-98}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(gain.u, delay_DFV1.y) annotation (Line(points={{-148,-100},{-144,-100},
          {-144,-97},{-140.42,-97}}, color={0,0,127}));
  connect(min2.y, delay_DFV1.u) annotation (Line(points={{-129,-104},{-132,-104},
          {-132,-97},{-133.4,-97}}, color={0,0,127}));
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
