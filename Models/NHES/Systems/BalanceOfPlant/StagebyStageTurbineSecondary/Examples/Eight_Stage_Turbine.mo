within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model Eight_Stage_Turbine
  "This model is based on NuScale design documentation, intending to match as closely as possible the 100% power rating found there."
  extends Modelica.Icons.Example;
  constant Real pi = Modelica.Constants.pi;
  parameter Modelica.Units.SI.Velocity vthes1=0;
  parameter Modelica.Units.SI.Velocity vther1=0;
  parameter Modelica.Units.SI.Velocity vthes2=0;
  parameter Modelica.Units.SI.Velocity vther2=0;
  parameter Modelica.Units.SI.Velocity vthes3=0;
  parameter Modelica.Units.SI.Velocity vther3=0;
  parameter Modelica.Units.SI.Velocity vthes4=0;
  parameter Modelica.Units.SI.Velocity vther4=0;
  parameter Modelica.Units.SI.Velocity vthes5=0;
  parameter Modelica.Units.SI.Velocity vther5=0;
  parameter Modelica.Units.SI.Velocity vthes6=0;
  parameter Modelica.Units.SI.Velocity vther6=0;
  parameter Modelica.Units.SI.Velocity vthes7=0;
  parameter Modelica.Units.SI.Velocity vther7=0;
  parameter Modelica.Units.SI.Velocity vthes8=0;
  parameter Modelica.Units.SI.Velocity vther8=0;
  parameter Modelica.Units.SI.Pressure ps1in=3170000;
  parameter Modelica.Units.SI.Pressure ps1out=2620000;
  parameter Modelica.Units.SI.Pressure pr1out=2610000;

  parameter Modelica.Units.SI.Pressure ps2out=1400000;
  parameter Modelica.Units.SI.Pressure pr2out=522600;
  parameter Modelica.Units.SI.Pressure ps3out=350000;
  parameter Modelica.Units.SI.Pressure pr3out=253000;
  parameter Modelica.Units.SI.Pressure ps4out=180000;
  parameter Modelica.Units.SI.Pressure pr4out=137800;
  parameter Modelica.Units.SI.Pressure ps5out=72000;
  parameter Modelica.Units.SI.Pressure pr5out=64200;
  parameter Modelica.Units.SI.Pressure ps6out=58000;
  parameter Modelica.Units.SI.Pressure pr6out=52800;
  parameter Modelica.Units.SI.Pressure ps7out=40000;
  parameter Modelica.Units.SI.Pressure pr7out=26400;
  parameter Modelica.Units.SI.Pressure ps8out=17500;
  parameter Modelica.Units.SI.Pressure pr8out=9000;

  parameter Modelica.Units.SI.Area Ar8[3]={2.9,6.3,6.3};
  parameter Modelica.Units.SI.Area As8[3]={2,2.9,2.9};
  parameter Modelica.Units.SI.Area Ar7[3]={1.4,2,2};
  parameter Modelica.Units.SI.Area As7[3]={1.11,1.4,1.4};
  parameter Modelica.Units.SI.Area Ar6[3]={1.11,1.11,1.11};
  parameter Modelica.Units.SI.Area As6[3]={1.11,1.11,1.11};
  parameter Modelica.Units.SI.Area Ar5[3]={0.72,1.10,1.11};
  parameter Modelica.Units.SI.Area As5[3]={0.62,0.72,0.72};
  parameter Modelica.Units.SI.Area Ar4[3]={0.42,0.62,0.62};
  parameter Modelica.Units.SI.Area As4[3]={0.355,0.41,0.42};
  parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.355,0.355};
  parameter Modelica.Units.SI.Area As3[3]={0.22,0.25,0.25};
  parameter Modelica.Units.SI.Area Ar2[3]={0.09,0.22,0.22};
  parameter Modelica.Units.SI.Area As2[3]={0.0657,0.09,0.09};
  parameter Modelica.Units.SI.Area Ar1[3]={0.0657,0.0657,0.0657};
  parameter Modelica.Units.SI.Area As1[3]={0.0657,0.0657,0.0657};
  parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1};
  parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22};
  parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245};
  parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265};
  parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295};
  parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315};
  parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335};
  parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38};
  parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42};
  parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47};
  parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53};
  parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59};
  parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64};
  parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69};
  parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75};
  parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82};
  parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89};
  parameter Modelica.Units.SI.MassFlowRate mflow=54.671;
  parameter Real[2] alphas1 = {pi/3.5,0};
  parameter Real[2] alphar1 = {-pi/3.44,0};
  parameter Real[2] alphas2 = {pi/2.2,0};
  parameter Real[2] alphar2 = {-pi/2.222,0};
  parameter Real[2] alphas3 = {pi/2.45,0};
  parameter Real[2] alphar3 = {-pi/2.7,0};
  parameter Real[2] alphas4 = {pi/2.5,0};
  parameter Real[2] alphar4 = {-pi/2.68,0};
  parameter Real[2] alphas5 = {pi/2.5,0};
  parameter Real[2] alphar5 = {-pi/2.674,0};
  parameter Real[2] alphas6 = {pi/3.4,0};
  parameter Real[2] alphar6 = {-pi/5.75,0};
  parameter Real[2] alphas7 = {pi/2.55,0};
  parameter Real[2] alphar7 = {-pi/3.55,0};
  parameter Real[2] alphas8 = {pi/2.48,0};
  parameter Real[2] alphar8 = {-pi/2.505,0};

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Boundary_Conditions.Boundary_ph
    boundary(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    use_p_in=false,
    p(displayUnit="Pa") = 8000,
    h=2383e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{158,-40},{138,-20}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
    MoistSep3(eta=0.2)
    annotation (Placement(transformation(extent={{116,2},{128,14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=pr7out,
    nPorts=1)
    annotation (Placement(transformation(extent={{-3,-4},{3,4}},
        rotation=90,
        origin={122,-1})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Turbine_Physical
    turbine_Editable(nSt=8)
    annotation (Placement(transformation(extent={{-22,52},{-2,72}})));
  StagebyStageTurbine.Generator_Basic                  generator(omega_nominal=50
        *3.14)
    annotation (Placement(transformation(extent={{26,58},{46,78}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor8(
    alpha=alphar8,
    A_flow=Ar8,
    ro=ror8,
    h_init=2260e3,
    m_init=52,
    p_in_init=ps8out,
    v_the_init=vther8,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{142,-2},{150,18}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator8(
    isenthalpic=true,
    alpha=alphas8,
    A_flow=As8,
    ro=ros8,
    h_init=2350e3,
    m_init=52,
    p_in_init=pr7out,
    p_out_init=ps8out,
    v_the_init=vthes8)
    annotation (Placement(transformation(extent={{132,-2},{138,18}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor7(
    alpha=alphar7,
    A_flow=Ar7,
    ro=ror7,
    h_init=2330e3,
    m_init=53,
    p_in_init=ps7out,
    v_the_init=vther7,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{100,-2},{108,18}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator7(
    isenthalpic=true,
    alpha=alphas7,
    A_flow=As7,
    ro=ros7,
    h_init=2383e3,
    m_init=53,
    p_in_init=pr6out,
    p_out_init=ps7out,
    v_the_init=vthes7)
    annotation (Placement(transformation(extent={{90,-2},{96,18}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
    MoistSep2(eta=0.165)
    annotation (Placement(transformation(extent={{72,2},{84,14}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor6(
    alpha=alphar6,
    A_flow=Ar6,
    ro=ror6,
    h_init=2336e3,
    m_init=56,
    p_in_init=ps6out,
    v_the_init=vther6,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{62,-2},{70,18}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator6(
    v_the_init=vthes6,
    isenthalpic=true,
    alpha=alphas6,
    A_flow=As6,
    ro=ros6,
    h_init=2417e3,
    m_init=56,
    p_in_init=pr5out,
    p_out_init=ps6out)
    annotation (Placement(transformation(extent={{48,-2},{54,18}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Boundary_Conditions.MassFlowSource_h
    boundary1(
    v_rotational=0,
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    use_m_flow_in=true,
    m_flow=68.404,
    h=2999e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-136,-4},{-116,16}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=pr6out,
    nPorts=1)
    annotation (Placement(transformation(extent={{-3,-4},{3,4}},
        rotation=90,
        origin={78,-1})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Turbine_Tap
    turbine_Tap2
    annotation (Placement(transformation(extent={{38,0},{44,16}})));
  Control_and_Distribution.ValveLineartanh                             valveLineartanh2(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40)
    annotation (Placement(transformation(extent={{58,-2},{64,-8}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{42,0},{50,-12}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=58000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=180,
        origin={71,-5})));
  TRANSFORM.Controls.PI_Control PI
    annotation (Placement(transformation(extent={{54,-20},{60,-14}})));
  Modelica.Blocks.Sources.Constant const(k=4.01)
    annotation (Placement(transformation(extent={{48,-20},{52,-16}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator5(
    v_the_init=vthes5,
    isenthalpic=true,
    alpha=alphas5,
    A_flow=As5,
    ro=ros5,
    h_init=2402e3,
    m_init=59,
    p_in_init=pr4out,
    p_out_init=ps5out)
    annotation (Placement(transformation(extent={{16,-2},{22,18}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor5(
    alpha=alphar5,
    A_flow=Ar5,
    ro=ror5,
    h_init=2379e3,
    m_init=59,
    p_in_init=ps5out,
    v_the_init=vther5,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{26,-2},{34,18}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
    MoistSep1(eta=0.155)
    annotation (Placement(transformation(extent={{0,2},{12,14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary4(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=pr4out,
    nPorts=1)
    annotation (Placement(transformation(extent={{-3,-4},{3,4}},
        rotation=90,
        origin={6,1})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor4(
    alpha=alphar4,
    A_flow=Ar4,
    ro=ror4,
    h_init=2402e3,
    m_init=60,
    p_in_init=ps4out,
    v_the_init=vther4,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-12,-2},{-4,18}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator4(
    v_the_init=vthes4,
    isenthalpic=true,
    alpha=alphas4,
    A_flow=As4,
    ro=ros4,
    h_init=2504e3,
    m_init=60,
    p_in_init=pr3out,
    p_out_init=ps4out)
    annotation (Placement(transformation(extent={{-22,-2},{-16,18}})));
  StagebyStageTurbine.Turbine_Tap                                                                                                          turbine_Tap1
    annotation (Placement(transformation(extent={{-32,0},{-26,14}})));
  Control_and_Distribution.ValveLineartanh                                                 valveLineartanh1(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=50)
    annotation (Placement(transformation(extent={{-10,0},{-4,-6}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-30,4},{-18,-10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary6(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=pr3out,
    nPorts=1) annotation (Placement(transformation(
        extent={{3,-4},{-3,4}},
        rotation=180,
        origin={-15,-34})));
  TRANSFORM.Controls.PI_Control PI2 annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=270,
        origin={-17,-13})));
  Modelica.Blocks.Sources.Constant const2(k=5.18) annotation (Placement(
        transformation(
        extent={{-3,-3},{3,3}},
        rotation=90,
        origin={-17,-25})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor3(
    alpha=alphar3,
    A_flow=Ar3,
    ro=ror3,
    h_init=2477e3,
    m_init=64,
    p_in_init=ps3out,
    v_the_init=vther3,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-46,-4},{-38,16}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator3(
    v_the_init=vthes3,
    isenthalpic=true,
    alpha=alphas3,
    A_flow=As3,
    ro=ros3,
    h_init=2563e3,
    m_init=64,
    p_in_init=pr2out,
    p_out_init=ps3out)
    annotation (Placement(transformation(extent={{-56,-4},{-50,16}})));
  StagebyStageTurbine.Turbine_Tap                                                                                                          turbine_Tap
    annotation (Placement(transformation(extent={{-66,-2},{-60,12}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor2(
    alpha=alphar2,
    A_flow=Ar2,
    ro=ror2,
    h_init=2674e3,
    m_init=68,
    p_in_init=ps2out,
    v_the_init=vther2,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-80,-4},{-72,16}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator2(
    v_the_init=vthes2,
    isenthalpic=true,
    alpha=alphas2,
    A_flow=As2,
    ro=ros2,
    h_init=2965e3,
    m_init=68,
    p_in_init=pr1out,
    p_out_init=ps2out)
    annotation (Placement(transformation(extent={{-88,-4},{-82,16}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
    Rotor1(
    alpha=alphar1,
    A_flow=Ar1,
    ro=ror1,
    h_init=2999e3,
    m_init=68,
    p_in_init=ps1out,
    v_the_init=vther1,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-100,-4},{-92,16}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
    Stator1(
    v_the_init=vthes1,
    isenthalpic=true,
    alpha=alphas1,
    A_flow=As1,
    ro=ros1,
    h_init=2999e3,
    m_init=68,
    p_in_init=ps1in,
    p_out_init=ps1out)
    annotation (Placement(transformation(extent={{-110,-4},{-104,16}})));
  TRANSFORM.Controls.PI_Control PI1
    annotation (Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-51,-5})));
  Modelica.Blocks.Sources.Constant const1(k=3.403)
    annotation (Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-49,3})));
  Control_and_Distribution.ValveLineartanh                             valveLineartanh(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-63,-23})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-64,-6})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p=498000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-5,-6},{5,6}},
        rotation=90,
        origin={-62,-39})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0,
    duration=200,
    offset=68.4,
    startTime=100)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-130,50})));
equation
  connect(generator.shaft, turbine_Editable.Generator_torque) annotation (Line(
        points={{25.9,67.9},{9.95,67.9},{9.95,67.8},{-2,67.8}},       color={0,0,
          0}));
  connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{142.08,
          7.8},{142.08,7.6},{138,7.6}},
                            color={28,108,200}));
  connect(Rotor8.Outlet, boundary.ports[1]) annotation (Line(points={{149.92,8},
          {156,8},{156,-14},{128,-14},{128,-30},{138,-30}},
                                color={28,108,200}));
  connect(Rotor8.torque, turbine_Editable.Fluidtorques[1]) annotation (Line(
        points={{144.64,12.6},{144.64,26},{144,26},{144,38},{-12.4,38},{
          -12.4,57.925}},                                        color={28,108,200}));
  connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{128,8},
          {128,7.8},{132.06,7.8}},   color={28,108,200}));
  connect(MoistSep3.Liquid, boundary2.ports[1]) annotation (Line(points={{122,
          6.08},{122,2}},     color={0,127,255}));
  connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{100.08,
          7.8},{100.08,8},{96,8},{96,7.6}},           color={28,108,200}));
  connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{107.92,
          8},{116,8}},                color={28,108,200}));
  connect(Rotor7.torque, turbine_Editable.Fluidtorques[2]) annotation (Line(
        points={{102.64,12.6},{102.64,26},{102,26},{102,38},{-12.4,38},{
          -12.4,58.175}},                                                color={
          28,108,200}));
  connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{84,8},{
          84,7.8},{90.06,7.8}},                  color={28,108,200}));
  connect(Rotor6.torque, turbine_Editable.Fluidtorques[3]) annotation (Line(
        points={{64.64,12.6},{64.64,24},{64,24},{64,38},{-12.4,38},{-12.4,
          58.425}},
        color={28,108,200}));
  connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{69.92,8},
          {72,8}},                           color={28,108,200}));
  connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{54,7.6},{
          54,7.8},{62.08,7.8}},                 color={28,108,200}));
  connect(boundary3.ports[1], MoistSep2.Liquid) annotation (Line(points={{78,2},{
          78,6.08}},                                                    color={0,
          127,255}));
  connect(turbine_Tap2.Tap_flow,sensor_m_flow2. port_a) annotation (Line(points={{41,5.44},
          {41,-6},{42,-6}},               color={0,127,255}));
  connect(sensor_m_flow2.port_b,valveLineartanh2. port_a) annotation (Line(
        points={{50,-6},{56,-6},{56,-5},{58,-5}},                         color=
         {0,127,255}));
  connect(valveLineartanh2.port_b,boundary7. ports[1]) annotation (Line(points={{64,-5},
          {68,-5}},   color={0,127,255}));
  connect(sensor_m_flow2.m_flow,PI. u_m)
    annotation (Line(points={{46,-8.16},{46,-20.6},{57,-20.6}},
                                                   color={0,0,127}));
  connect(const.y,PI. u_s)
    annotation (Line(points={{52.2,-18},{56,-18},{56,-17},{53.4,-17}},
                                                 color={0,0,127}));
  connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{44.06,8},
          {46,8},{46,7.8},{48.06,7.8}},           color={28,108,200}));
  connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{33.92,8},
          {38.03,8},{38.03,8.08}},                  color={28,108,200}));
  connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{26.08,7.8},
          {26.08,8},{24,8},{24,7.6},{22,7.6}},        color={28,108,200}));
  connect(Rotor5.torque, turbine_Editable.Fluidtorques[4]) annotation (Line(
        points={{28.64,12.6},{28,12.6},{28,38},{-12,38},{-12,60},{-12.4,60},
          {-12.4,58.675}},color={28,108,200}));
  connect(Stator5.Inlet, MoistSep1.Turb_Out) annotation (Line(points={{16.06,
          7.8},{12,7.8},{12,8}},            color={28,108,200}));
  connect(boundary4.ports[1], MoistSep1.Liquid)
    annotation (Line(points={{6,4},{6,6.08}},         color={0,127,255}));
  connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-11.92,
          7.8},{-16,7.8},{-16,7.6}},
                           color={28,108,200}));
  connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
    annotation (Line(points={{-21.94,7.8},{-21.94,8},{-25.94,8},{-25.94,7}},
                                                       color={28,108,200}));
  connect(sensor_m_flow1.port_b,valveLineartanh1. port_a)
    annotation (Line(points={{-18,-3},{-10,-3}}, color={0,127,255}));
  connect(sensor_m_flow1.m_flow,PI2. u_m) annotation (Line(points={{-24,
          -5.52},{-24,-13},{-20.6,-13}},
                                 color={0,0,127}));
  connect(PI2.y,valveLineartanh1. opening) annotation (Line(points={{-17,
          -9.7},{-17,-5.4},{-7,-5.4}},     color={0,0,127}));
  connect(const2.y,PI2. u_s) annotation (Line(points={{-17,-21.7},{-18,
          -21.7},{-18,-16.6},{-17,-16.6}},
                               color={0,0,127}));
  connect(turbine_Tap1.Tap_flow, sensor_m_flow1.port_a) annotation (Line(points={{-29,
          4.76},{-29,2},{-30,2},{-30,-3}},                       color={0,127,255}));
  connect(Rotor4.Outlet, MoistSep1.Turb_In) annotation (Line(points={{-4.08,8},
          {0,8}},                       color={28,108,200}));
  connect(Rotor4.torque, turbine_Editable.Fluidtorques[5]) annotation (Line(
        points={{-9.36,12.6},{-9.36,22},{-10,22},{-10,38},{-12,38},{-12,48},
          {-12.4,48},{-12.4,58.925}},
                    color={28,108,200}));
  connect(boundary6.ports[1], valveLineartanh1.port_b) annotation (Line(points={{-12,-34},
          {-12,-18},{-4,-18},{-4,-3}},                color={0,127,255}));
  connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-72.08,
          6},{-65.97,6},{-65.97,5.07}},         color={28,108,200}));
  connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-59.94,
          5},{-59.94,6},{-55.94,6},{-55.94,5.8}},                color={28,108,200}));
  connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-45.92,
          5.8},{-50,5.8},{-50,5.6}},                     color={28,108,200}));
  connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-79.92,
          5.8},{-80,5.8},{-80,6},{-82,6},{-82,5.6}},     color={28,108,200}));
  connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-87.94,
          5.8},{-88,5.8},{-88,6},{-92.08,6}},           color={28,108,200}));
  connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-99.92,
          5.8},{-102,5.8},{-102,6},{-104,6},{-104,5.6}}, color={28,108,200}));
  connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-38.08,
          6},{-36,6},{-36,7.07},{-31.97,7.07}},            color={28,108,200}));
  connect(turbine_Tap.Tap_flow, sensor_m_flow.port_a) annotation (Line(points={{-63,
          2.76},{-64,2.76},{-64,0}},              color={0,127,255}));
  connect(sensor_m_flow.port_b, valveLineartanh.port_a) annotation (Line(points={{-64,-12},
          {-64,-18},{-63,-18}},              color={0,127,255}));
  connect(valveLineartanh.port_b, boundary5.ports[1]) annotation (Line(points={{-63,-28},
          {-63,-34},{-62,-34}},             color={0,127,255}));
  connect(const1.y, PI1.u_s) annotation (Line(points={{-49,-0.3},{-50,-0.3},
          {-50,-1.4},{-51,-1.4}},     color={0,0,127}));
  connect(sensor_m_flow.m_flow, PI1.u_m) annotation (Line(points={{-61.84,
          -6},{-58,-6},{-58,-5},{-54.6,-5}},   color={0,0,127}));
  connect(PI1.y, valveLineartanh.opening) annotation (Line(points={{-51,
          -8.3},{-51,-17.15},{-59,-17.15},{-59,-23}},
                                                   color={0,0,127}));
  connect(boundary1.ports[1], Stator1.Inlet) annotation (Line(points={{-116,6},
          {-109.94,5.8}},
        color={28,108,200}));
  connect(Rotor3.torque, turbine_Editable.Fluidtorques[6]) annotation (Line(
        points={{-43.36,10.6},{-44,10.6},{-44,38},{-12.4,38},{-12.4,59.175}},
                               color={28,108,200}));
  connect(Rotor2.torque, turbine_Editable.Fluidtorques[7]) annotation (Line(
        points={{-77.36,10.6},{-77.36,24},{-78,24},{-78,38},{-12,38},{-12,
          59.425},{-12.4,59.425}},
        color={28,108,200}));
  connect(Rotor1.torque, turbine_Editable.Fluidtorques[8]) annotation (Line(
        points={{-97.36,10.6},{-97.36,38},{-12.4,38},{-12.4,59.675}},
                    color={28,108,200}));
  connect(boundary1.m_flow_in, ramp.y) annotation (Line(points={{-136,14},{-136,
          34},{-130,34},{-130,39}}, color={0,0,127}));
  connect(PI.y, valveLineartanh2.opening)
    annotation (Line(points={{60.3,-17},{61,-17},{61,-7.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{160,
            100}})),
    experiment(StopTime=40, __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>This example is a primary reference for anyone looking to use the individual stage turbine models. It shows taps, moisture separators, and many stages all linked to a physical turbine model and to the generator model. Special attention should be paid to the amount of initialization data required in the models. It is highly advised that someone trying to use a many-stage turbine should build their turbine stage-by-stage to establish appropriate design angles and initialization values. Further, it is recommended that a user builds from one end to the other. </p>
<p>Changing initialization values has a significant impact on the ability of these multi-stage turbine models to get to a regular shifting point. Once the ability to achieve a steady state has been possible, the models are generally capable of a great deal of dynamic behavior. However, they are fluid models and so the initialization process is complicated. </p>
</html>"));
end Eight_Stage_Turbine;
