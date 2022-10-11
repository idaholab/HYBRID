within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model Diagram_ONLY_NuScale_Secondary_With_TES
  //
  //
  //
  // DO NOT USE THIS MODEL, IT IS CONSTRUCTED TO MAKE A BETTER IMAGE ONLY
  // THIS MODEL IS IDENTICAL TO NUSCALE_SBST_SECONDARY_WITH_CTES, USE THAT
  //
  //
  //
  extends TRANSFORM.Icons.ObsoleteModel;
  extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);
  parameter Integer TES_nPipes= 950;
  parameter Modelica.Units.SI.Length TES_Length=275
    "TES pipe length within concrete";
  parameter Modelica.Units.SI.Length TES_Thick=0.2
    "TES thickness to adiabatic boundary condition";
  parameter Modelica.Units.SI.Length TES_Width=0.8
    "Cross sectional area perpendicular to pipe length";
  parameter Real LP_NTU = 1.5;
  parameter Real IP_NTU = 20.0;
  parameter Real HP_NTU = 4.0;
  parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5;
  parameter Modelica.Units.SI.Time Ramp_Stor=500;
  parameter Modelica.Units.SI.Time Ramp_Dis=1500;
  parameter Real derspeed = 0.2;
  parameter Real frac = 2.0;
  constant Real pi = Modelica.Constants.pi;
  parameter Modelica.Units.SI.Power Q_nom;
  Modelica.Units.SI.Energy dEdCycle;
  Modelica.Units.SI.Time t_track;
 // Modelica.SIunits.Temperature T_ideal;
  parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;
  Modelica.Units.SI.Power Q_Cond_Feed;
  Modelica.Units.SI.MassFlowRate mflowcalc;
  Modelica.Units.SI.SpecificEnthalpy dhfd;
  Modelica.Units.SI.SpecificEnthalpy dhcn;
  Modelica.Units.SI.Power Q_RX_Internal;
  Real Demand_Internal;
  Real DFV_Anticipatory_Internal;

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
  parameter Modelica.Units.SI.Pressure pr8out=8100;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3;
  parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1};
  parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45};
  parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64};
  parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95};
  parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545};
  parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515};
  parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515};
  parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035};
  parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72};
  parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51};
  parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43};
  parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25};
  parameter Modelica.Units.SI.Area Ar2[3]={0.15,0.23,0.23};
  parameter Modelica.Units.SI.Area As2[3]={0.06,0.15,0.15};
  parameter Modelica.Units.SI.Area Ar1[3]={0.06,0.06,0.06};
  parameter Modelica.Units.SI.Area As1[3]={0.06,0.06,0.06};
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
  parameter Real[2] alphas1 = {pi/3.4,0};
  parameter Real[2] alphar1 = {-pi/3.45,0};
  parameter Real[2] alphas2 = {pi/2.185,0};
  parameter Real[2] alphar2 = {-pi/2.235,0};
  parameter Real[2] alphas3 = {pi/2.43,0};
  parameter Real[2] alphar3 = {-pi/2.41,0};
  parameter Real[2] alphas4 = {pi/2.6,0};
  parameter Real[2] alphar4 = {-pi/2.54,0};
  parameter Real[2] alphas5 = {pi/2.48,0};
  parameter Real[2] alphar5 = {-pi/2.42,0};
  parameter Real[2] alphas6 = {pi/3.33,0};
  parameter Real[2] alphar6 = {-pi/3.62,0};
  parameter Real[2] alphas7 = {pi/2.53,0};
  parameter Real[2] alphar7 = {-pi/2.6,0};
  parameter Real[2] alphas8 = {pi/2.41,0};
  parameter Real[2] alphar8 = {-pi/2.207,0};

public
  StagebyStageTurbine.MS         MoistSep3(V_MS=0.6, eta=0.227)
    annotation (Placement(transformation(extent={{76,6},{88,18}})));
  StagebyStageTurbine.Turbine_Physical       turbine_Physical(nSt=8)
    annotation (Placement(transformation(extent={{-78,36},{-58,56}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.Generator_Basic
                                                       generator(omega_nominal=50
        *3.14)
    annotation (Placement(transformation(extent={{-40,42},{-20,62}})));
  StagebyStageTurbine.Rotor_Stage                   Rotor8(
    m_flow_nom=54.86,
    alpha=alphar8,
    A_flow=Ar8,
    dz={0.4,1},
    ro=ror8,
    h_init=2260e3,
    m_init=52,
    p_in_init=ps8out,
    v_the_init=vther8,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{94,2},{102,22}})));

  StagebyStageTurbine.Rotor_Stage                   Rotor7(
    m_flow_nom=55.13,
    alpha=alphar7,
    A_flow=Ar7,
    ro=ror7,
    h_init=2330e3,
    m_init=53,
    p_in_init=ps7out,
    v_the_init=vther7,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{64,2},{72,22}})));

  StagebyStageTurbine.MS         MoistSep2(V_MS=0.25, eta=0.19)
    annotation (Placement(transformation(extent={{50,6},{62,18}})));
  StagebyStageTurbine.Rotor_Stage                   Rotor6(
    m_flow_nom=56.18,
    alpha=alphar6,
    A_flow=Ar6,
    ro=ror6,
    h_init=2336e3,
    m_init=56,
    p_in_init=ps6out,
    v_the_init=vther6,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{38,2},{46,22}})));

  StagebyStageTurbine.Turbine_Tap       turbine_Tap2
    annotation (Placement(transformation(extent={{28,4},{34,20}})));

  StagebyStageTurbine.Rotor_Stage                   Rotor5(
    m_flow_nom=59.78,
    alpha=alphar5,
    A_flow=Ar5,
    ro=ror5,
    h_init=2379e3,
    m_init=59,
    p_in_init=ps5out,
    v_the_init=vther5,
    v_r_init=0.1) annotation (Placement(transformation(extent={{14,2},{22,22}})));

  StagebyStageTurbine.MS         MoistSep1(V_MS=25, eta=0.17)
    annotation (Placement(transformation(extent={{0,6},{12,18}})));
  StagebyStageTurbine.Rotor_Stage                   Rotor4(
    m_flow_nom=60.76,
    alpha=alphar4,
    A_flow=Ar4,
    ro=ror4,
    h_init=2402e3,
    m_init=60,
    p_in_init=ps4out,
    v_the_init=vther4,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-22,2},{-12,22}})));

  StagebyStageTurbine.Turbine_Tap       turbine_Tap1
    annotation (Placement(transformation(extent={{-34,4},{-26,18}})));
  StagebyStageTurbine.Rotor_Stage                   Rotor3(
    m_flow_nom=64.31,
    alpha=alphar3,
    A_flow=Ar3,
    ro=ror3,
    h_init=2477e3,
    m_init=64,
    p_in_init=ps3out,
    v_the_init=vther3,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-48,2},{-38,22}})));

  StagebyStageTurbine.Turbine_Tap       turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
    annotation (Placement(transformation(extent={{-64,4},{-52,20}})));
  StagebyStageTurbine.Rotor_Stage                   Rotor2(
    m_flow_nom=68.22,
    alpha=alphar2,
    A_flow=Ar2,
    ro=ror2,
    h_init=2674e3,
    m_init=68,
    p_in_init=ps2out,
    v_the_init=vther2,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-78,2},{-70,22}})));

  StagebyStageTurbine.Rotor_Stage                   Rotor1(
    m_flow_nom=68.22,
    alpha=alphar1,
    A_flow=Ar1,
    ro=ror1,
    h_init=2999e3,
    m_init=68,
    p_in_init=ps1out,
    v_the_init=vther1,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-90,2},{-82,22}})));

  Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
    NTU=LP_NTU,
    K_tube=17000,
    K_shell=5,
    V_Tube=4.,
    V_Shell=4,
    p_start_tube=2340000,
    h_start_tube_inlet=184e3,
    h_start_tube_outlet=184e3,
    p_start_shell=58000,
    h_start_shell_inlet=405.5e3,
    h_start_shell_outlet=405.5e3,
    Cr_init=0.8,
    deltaX_t_init=0.0,
    deltaX_s_init=0.0,
    Shell(medium(h(start=100000))))
    annotation (Placement(transformation(extent={{20,-28},{44,-54}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
    NTU=IP_NTU,
    K_tube=17000,
    K_shell=500,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=3740000,
    h_start_tube_inlet=346.6e3,
    h_start_tube_outlet=346.6e3,
    p_start_shell=497000,
    h_start_shell_inlet=368.2e3,
    h_start_shell_outlet=368.2e3)
    annotation (Placement(transformation(extent={{-18,-28},{8,-54}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
    NTU=HP_NTU,
    K_tube=16500,
    K_shell=50,
    V_Tube=5,
    V_Shell=5,
    p_start_tube=3740000,
    h_start_tube_inlet=523.1e3,
    h_start_tube_outlet=523.1e3,
    p_start_shell=497000,
    h_start_shell_inlet=544.5e3,
    h_start_shell_outlet=544.5e3,
    Shell(medium(h(start=500e3))))
    annotation (Placement(transformation(extent={{-78,-30},{-54,-54}})));
  StagebyStageTurbine.BaseClasses.Turbine_Outlet                                                 turbine_Outlet
    annotation (Placement(transformation(extent={{106,2},{110,22}})));
  StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet annotation (
      Placement(transformation(
        extent={{3,-7},{-3,7}},
        rotation=180,
        origin={-97,11})));
  TRANSFORM.Fluid.Volumes.IdealCondenser Condenser(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 8000,
    V_liquid_start=2,
    set_m_flow=false,
    V_total=100)
    annotation (Placement(transformation(extent={{80,-40},{110,-14}})));
  Control_and_Distribution.SpringBallValve                   LPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr8out,
    K=500,
    opening_init=0.01,
    tau=0.1) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={25,-15})));
  Control_and_Distribution.SpringBallValve                   IPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr6out,
    K=4250,
    tau=0.1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-36,-16})));
  Control_and_Distribution.SpringBallValve                   HPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr5out,
    K=2300,
    tau=0.1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-68,-12})));
  Control_and_Distribution.ValveLineartanh                   TCV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=200000,
    m_flow_nominal=68.404,
    opening_actual(start=1)) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=0,
        origin={-114,10})));
  Control_and_Distribution.ValveLinearTotal TBV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=100000,
    m_flow_nominal=68.404,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=270,
        origin={-127,39})));
  Modelica.Fluid.Machines.PrescribedPump FWCP(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    allowFlowReversal=false,
    p_a_start=2200000,
    p_b_start=3700000,
    m_flow_start=66.3,
    nParallel=3,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
    N_nominal=1500,
    rho_nominal=945,
    use_powerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=0.8),
    V=1.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_T_start=false,
    h_start=500e3,
    use_N_in=true,
    N_const=890.3)
    annotation (Placement(transformation(extent={{-28,-44},{-44,-60}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-124,24})));
  Control_and_Distribution.ValveLinearTotal                  FCV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=200000,
    m_flow_nominal=68.4,
    opening_actual(start=1)) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={-102,-44})));
  Modelica.Fluid.Machines.PrescribedPump CDP(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    allowFlowReversal=false,
    p_a_start=8000,
    p_b_start=2220000,
    m_flow_start=68.4,
    nParallel=3,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
    N_nominal=1500,
    rho_nominal=945,
    use_powerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=0.8),
    V=1.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_T_start=false,
    h_start=300e3,
    N_const=1278.78)
    annotation (Placement(transformation(extent={{80,-54},{66,-40}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=180,
        origin={-130,-45})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={-86,-32})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=180,
        origin={-114,-28})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={-105,-21})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume5(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=ps1in,
    use_T_start=false,
    h_start=3000e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    nPorts_b=2,
    nPorts_a=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-138,10})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-118,58},{-110,66}})));
  EnergyStorage.Concrete_Solid_Media.Components.Dual_Pipe_Model TES(
    nPipes=TES_nPipes,
    dX=TES_Length,
    Pipe_to_Concrete_Length_Ratio=1,
    dY=TES_Width,
    Hot_Con_Start=483.15,
    Cold_Con_Start=473.15)
    annotation (Placement(transformation(extent={{116,46},{136,66}})));
  StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet1
    annotation (Placement(transformation(extent={{48,32},{28,52}})));
  StagebyStageTurbine.TeeJunctionIdeal_Cyl T(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,26},{2,18}})));
  Control_and_Distribution.ValveLinearTotal                   DCV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=250000,
    m_flow_nominal=20,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={148,-48})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-4,4},{4,-4}},
        rotation=90,
        origin={160,-22})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{-170,-54},{-150,-34}}),iconTransformation(
          extent={{-170,-54},{-150,-34}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{-170,0},{-150,20}}), iconTransformation(extent={{-170,0},
            {-150,20}})));
  Control_and_Distribution.ValveLinearTotal DFV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=250000,
    m_flow_nominal=20,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=180,
        origin={68,42})));
  Control_and_Distribution.TemperatureTwoPort_Superheat T_Super(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{104,32},{84,52}})));
  Modelica.Blocks.Sources.RealExpression DFV_Ancticipatory_Internal_Block(y=
        DFV_Anticipatory_Internal)
    annotation (Placement(transformation(extent={{-122,78},{-102,98}})));
  Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=
        Demand_Internal)
    annotation (Placement(transformation(extent={{-122,94},{-102,114}})));
  Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
    annotation (Placement(transformation(extent={{-122,110},{-102,130}})));
  Modelica.Fluid.Machines.PrescribedPump DFP(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    allowFlowReversal=false,
    p_a_start=8000,
    p_b_start=2220000,
    m_flow_start=68.4,
    nParallel=3,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
    N_nominal=1500,
    rho_nominal=945,
    use_powerCharacteristic=false,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=0.8),
    V=1.5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    use_T_start=false,
    h_start=300e3,
    N_const=1278.78)
    annotation (Placement(transformation(extent={{114,-54},{128,-40}})));
initial equation
  dEdCycle=0;
  t_track = 0;
  Q_Cond_Feed = 0;
  mflowcalc = HP.Tube_in.m_flow;
//  T_ideal = T_feed_ref;
equation
  der(t_track)=1;
  der(dEdCycle) = generator.power-Q_nom;
  when t_track>=86400 then
    reinit(dEdCycle,0);
    reinit(t_track,0);
  end when;
  der(mflowcalc) = HP.Tube_in.m_flow - mflowcalc;
  dhfd = (Modelica.Media.Water.StandardWater.specificEnthalpy_pT(HP.Tube_out.p,T_feed_ref)-HP.hex_t);
  dhcn = Condensate_Res.port_a.h_outflow-Modelica.Media.Water.StandardWater.specificEnthalpy_pT(Condensate_Res.port_a.p,HP.Tin_t);
  if  Condensate_Res.m_flow>0 and HP.Tex_t<=T_feed_ref then
    10*der(Q_Cond_Feed) = min(0.5*(HP.Tube_in.m_flow + HP.Tube_out.m_flow) *dhfd,
    Condensate_Res.m_flow*(dhcn)) -Q_Cond_Feed;
  else
    10*der(Q_Cond_Feed) = 0-Q_Cond_Feed;
  end if;

  connect(generator.shaft,turbine_Physical. Generator_torque) annotation (Line(
        points={{-40.1,51.9},{-52,51.9},{-52,52},{-54,52},{-54,51.8},{-58,51.8}},
                                                                      color={0,0,
          0}));
  connect(Rotor8.torque,turbine_Physical. Fluidtorques[1]) annotation (Line(
        points={{96.64,16.6},{96.64,30},{-68.4,30},{-68.4,41.925}},
                                                                 color={175,175,
          175},
      thickness=1));
  connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{71.92,12},
          {76,12}},                   color={28,108,200},
      thickness=1));
  connect(Rotor7.torque,turbine_Physical. Fluidtorques[2]) annotation (Line(
        points={{66.64,16.6},{66.64,30},{-68.4,30},{-68.4,42.175}},      color={175,175,
          175},
      thickness=1));
  connect(Rotor6.torque,turbine_Physical. Fluidtorques[3]) annotation (Line(
        points={{40.64,16.6},{40.64,30},{-68.4,30},{-68.4,42.425}},
        color={175,175,175},
      thickness=1));
  connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{45.92,12},
          {50,12}},                          color={28,108,200},
      thickness=1));
  connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{21.92,
          12},{28.03,12.08}},                       color={28,108,200},
      thickness=1));
  connect(Rotor4.torque,turbine_Physical. Fluidtorques[5]) annotation (Line(
        points={{-18.7,16.6},{-18.7,30},{-68.4,30},{-68.4,42.925}},
                    color={175,175,175},
      thickness=1));
  connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-70.08,
          12},{-68,12},{-68,12.08},{-63.94,12.08}},
                                                color={28,108,200},
      thickness=1));
  connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-38.1,
          12},{-33.96,12},{-33.96,11.07}},                 color={28,108,200},
      thickness=1));
  connect(Rotor3.torque,turbine_Physical. Fluidtorques[6]) annotation (Line(
        points={{-44.7,16.6},{-44,16.6},{-44,30},{-68.4,30},{-68.4,43.175}},
                               color={175,175,175},
      thickness=1));
  connect(Rotor2.torque,turbine_Physical. Fluidtorques[7]) annotation (Line(
        points={{-75.36,16.6},{-75.36,30},{-68.4,30},{-68.4,43.425}},
        color={175,175,175},
      thickness=1));
  connect(Rotor1.torque,turbine_Physical. Fluidtorques[8]) annotation (Line(
        points={{-87.36,16.6},{-87.36,30},{-68.4,30},{-68.4,43.675}},
                    color={175,175,175},
      thickness=1));
  connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{20,-46.2},{8,-46.2}},
                            color={0,127,255},
      thickness=1));
  connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
        points={{101.92,12},{106.02,12.1}},                 color={28,108,200},
      thickness=1));

  connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-68,-20},{
          -68,-26},{-80,-26},{-80,-40},{-78,-40},{-78,-39.6}},
                                                      color={0,127,255},
      thickness=1));
  connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-68,-4},
          {-68,0},{-58,0},{-58,9.44}},          color={0,127,255},
      thickness=1));
  connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-36,-8},
          {-36,8.76},{-30,8.76}},                color={0,127,255},
      thickness=1));
  connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-106,10},
          {-103,10},{-103,11},{-100,11}},
                                       color={0,127,255},
      thickness=1));
  connect(IP.Tube_out, FWCP.port_a)
    annotation (Line(points={{-18,-46.2},{-22,-46.2},{-22,-46},{-24,-46},{-24,
          -52},{-28,-52}},                         color={0,127,255},
      thickness=1));
  connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-54,-46.8},{-54,
          -48},{-48,-48},{-48,-52},{-44,-52}},
                                           color={0,127,255},
      thickness=1));
  connect(FCV.port_a, HP.Tube_out) annotation (Line(points={{-94,-44},{-84,-44},
          {-84,-46.8},{-78,-46.8}},            color={0,127,255},
      thickness=1));
  connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{-110,-44},
          {-124,-44},{-124,-45}},                           color={0,127,255},
      thickness=1));
  connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-124,20},{-126,
          20},{-126,10},{-122,10}},                 color={0,127,255},
      thickness=1));
  connect(sensor_p2.p, add.u1)
    annotation (Line(points={{-88.4,-32},{-90,-32},{-90,-18},{-99,-18}},
                                                       color={0,0,127}));
  connect(sensor_p3.p, add.u2)
    annotation (Line(points={{-111.6,-28},{-96,-28},{-96,-24},{-99,-24}},
                                                     color={0,0,127}));
  connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,
          -32},{-114,-44},{-122,-44},{-122,-45},{-124,-45}},
                                                 color={0,127,255},
      thickness=1));
  connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-86,-36},{-84,
          -36},{-84,-46.8},{-78,-46.8}},        color={0,127,255},
      thickness=1));
  connect(volume5.port_b[1], TBV.port_a) annotation (Line(points={{-132,9.5},{
          -132,12},{-130,12},{-130,28},{-128,28},{-128,30},{-127,30}},
                                             color={102,44,145},
      thickness=1));
  connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-132,10.5},{
          -132,10},{-122,10}},                      color={0,127,255},
      thickness=1));
  connect(sensor_m_flow12.port_a, TBV.port_b) annotation (Line(points={{-118,62},
          {-126,62},{-126,48},{-127,48}},
                               color={102,44,145},
      thickness=1));
  connect(sensor_m_flow12.port_b, TES.Charge_Inlet) annotation (Line(
        points={{-110,62},{-50,62},{-50,42},{2,42},{2,58.2},{118.2,58.2}},
                                                               color={102,44,
          145},
      thickness=1));
  connect(T.port_2, turbine_Inlet1.Turb_flow) annotation (Line(
      points={{2,22},{6,22},{6,41.9},{28.1,41.9}},
      color={217,67,180},
      thickness=1));
  connect(T.port_1, Rotor4.Outlet) annotation (Line(
      points={{-6,22},{-8,22},{-8,12},{-12.1,12}},
      color={28,108,200},
      thickness=1));
  connect(port_a, volume5.port_a[1]) annotation (Line(points={{-160,10},{-144,
          10}},                   color={0,127,255},
      thickness=1));
  connect(DFV.port_b, turbine_Inlet1.Pipe_flow) annotation (Line(points={{60,42},
          {48,42}},                 color={217,67,180},
      thickness=1));
  connect(T_Super.port_b, DFV.port_a) annotation (Line(
      points={{84,42},{76,42}},
      color={217,67,180},
      thickness=1));
  connect(T_Super.port_a, TES.Discharge_Outlet) annotation (Line(
      points={{104,42},{124.4,42},{124.4,50.4}},
      color={217,67,180},
      thickness=1));
  connect(DCV.port_b, sensor_m_flow2.port_a) annotation (Line(points={{156,-48},
          {160,-48},{160,-26}},                     color={217,67,180},
      thickness=1));
  connect(sensor_m_flow2.port_b, TES.Discharge_Inlet) annotation (Line(points={{160,-18},
          {160,56},{133.8,56},{133.8,55.8}},          color={217,67,180},
      thickness=1));
  connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
      points={{-30,100},{-70,100},{-70,104},{-96,104},{-96,120},{-101,120}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
      points={{-30,100},{-70,100},{-70,104},{-101,104}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.DFV_Anticipatory, DFV_Ancticipatory_Internal_Block.y)
    annotation (Line(
      points={{-30,100},{-70,100},{-70,104},{-96,104},{-96,88},{-101,88}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
      points={{-30,100},{-70,100},{-70,74},{-108,74},{-108,24},{-121.6,24}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));

  connect(sensorBus.dP_FCV, add.y) annotation (Line(
      points={{-30,100},{-70,100},{-70,74},{-178,74},{-178,-21},{-110.5,-21}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.Superheat_Sensor_Opening, T_Super.dT) annotation (Line(
      points={{-30,100},{-30,70},{94,70},{94,45.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
      points={{-30,100},{-70,100},{-70,74},{-178,74},{-178,-56},{-130,-56},{
          -130,-47.52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(sensorBus.TBV_Mass_Flow, sensor_m_flow12.m_flow) annotation (Line(
      points={{-30,100},{-70,100},{-70,74},{-114,74},{-114,63.44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
      points={{30,100},{172,100},{172,-64},{-36,-64},{-36,-60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(actuatorBus.DFV_Opening, DFV.opening) annotation (Line(
      points={{30,100},{68,100},{68,48.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
      points={{30,100},{172,100},{172,-64},{-172,-64},{-172,-4},{-114,-4},{-114,
          3.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(actuatorBus.TBV_Opening, TBV.opening) annotation (Line(
      points={{30,100},{172,100},{172,-64},{-172,-64},{-172,39},{-134.2,39}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));

  connect(actuatorBus.DCV_Opening,DCV. opening) annotation (Line(
      points={{30,100},{172,100},{172,-64},{148,-64},{148,-54.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
      points={{30,100},{172,100},{172,-64},{-102,-64},{-102,-50.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(DFP.port_b, DCV.port_a) annotation (Line(
      points={{128,-47},{128,-48},{140,-48}},
      color={217,67,180},
      thickness=1));
  connect(Condenser.port_b, CDP.port_a) annotation (Line(
      points={{95,-37.4},{94,-37.4},{94,-48},{80,-48},{80,-47}},
      color={0,127,255},
      thickness=1));
  connect(Condenser.port_b, DFP.port_a) annotation (Line(
      points={{95,-37.4},{94,-37.4},{94,-47},{114,-47}},
      color={217,67,180},
      thickness=1));
  connect(Rotor5.Inlet, MoistSep1.Turb_Out) annotation (Line(
      points={{14.08,11.8},{14,11.8},{14,12},{12,12}},
      color={28,108,200},
      thickness=1));
  connect(T.port_3, MoistSep1.Turb_In) annotation (Line(
      points={{-2,18},{-2,12},{0,12}},
      color={28,108,200},
      thickness=1));
  connect(IP.Shell_out, LP.Shell_in) annotation (Line(
      points={{8,-38.4},{20,-38.4}},
      color={0,127,255},
      thickness=1));
  connect(IPTapValve.port_b, IP.Shell_in) annotation (Line(
      points={{-36,-24},{-36,-38.4},{-18,-38.4}},
      color={0,127,255},
      thickness=1));
  connect(HP.Shell_out, IP.Shell_in) annotation (Line(
      points={{-54,-39.6},{-36,-39.6},{-36,-38.4},{-18,-38.4}},
      color={0,127,255},
      thickness=1));
  connect(LP.Shell_out, Condenser.port_a) annotation (Line(
      points={{44,-38.4},{62,-38.4},{62,-8},{84.5,-8},{84.5,-17.9}},
      color={0,127,255},
      thickness=1));
  connect(TES.Charge_Outlet, Condenser.port_a) annotation (Line(
      points={{129,62.2},{128,62.2},{128,72},{108,72},{108,26},{114,26},{114,-8},
          {84.5,-8},{84.5,-17.9}},
      color={102,44,145},
      thickness=1));
  connect(turbine_Outlet.Pipe_flow, Condenser.port_a) annotation (Line(
      points={{110,12},{114,12},{114,-8},{84.5,-8},{84.5,-17.9}},
      color={0,127,255},
      thickness=1));
  connect(MoistSep2.Liquid, Condenser.port_a) annotation (Line(
      points={{56,10.08},{56,-8},{84.5,-8},{84.5,-17.9}},
      color={0,127,255},
      thickness=1));
  connect(MoistSep3.Liquid, Condenser.port_a) annotation (Line(
      points={{82,10.08},{82,-8},{84.5,-8},{84.5,-17.9}},
      color={0,127,255},
      thickness=1));
  connect(Rotor8.Inlet, MoistSep3.Turb_Out) annotation (Line(
      points={{94.08,11.8},{94.08,12},{88,12}},
      color={28,108,200},
      thickness=1));
  connect(Rotor7.Inlet, MoistSep2.Turb_Out) annotation (Line(
      points={{64.08,11.8},{62,12}},
      color={28,108,200},
      thickness=1));
  connect(Rotor6.Inlet, turbine_Tap2.Turb_flow2) annotation (Line(
      points={{38.08,11.8},{38.08,12},{34.06,12}},
      color={28,108,200},
      thickness=1));
  connect(port_b, port_b)
    annotation (Line(points={{-160,-44},{-160,-44}}, color={0,127,255}));
  connect(turbine_Tap2.Tap_flow, LPTapValve.port_a) annotation (Line(
      points={{31,9.44},{32,9.44},{32,-4},{26,-4},{26,-8},{25,-8}},
      color={0,127,255},
      thickness=1));
  connect(LPTapValve.port_b, LP.Shell_in) annotation (Line(
      points={{25,-22},{24,-22},{24,-26},{16,-26},{16,-38.4},{20,-38.4}},
      color={0,127,255},
      thickness=1));
  connect(Rotor5.torque, turbine_Physical.Fluidtorques[5]) annotation (Line(
      points={{16.64,16.6},{16.64,30},{-68.4,30},{-68.4,42.925}},
      color={175,175,175},
      thickness=1));
  connect(MoistSep1.Liquid, LP.Shell_in) annotation (Line(
      points={{6,10.08},{6,-28},{16,-28},{16,-38.4},{20,-38.4}},
      color={0,127,255},
      thickness=1));
  connect(CDP.port_b, LP.Tube_in) annotation (Line(
      points={{66,-47},{56,-47},{56,-46},{52,-46},{52,-46.2},{44,-46.2}},
      color={0,127,255},
      thickness=1));
  connect(turbine_Tap1.Turb_flow2, Rotor4.Inlet) annotation (Line(
      points={{-25.92,11},{-24,11},{-24,12},{-21.9,12},{-21.9,11.8}},
      color={28,108,200},
      thickness=1));
  connect(turbine_Tap.Turb_flow2, Rotor3.Inlet) annotation (Line(
      points={{-51.88,12},{-47.9,11.8}},
      color={28,108,200},
      thickness=1));
  connect(sensorBus.Generator_Power, generator.Power) annotation (Line(
      points={{-30,100},{-30,62.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=1));
  connect(Rotor1.Outlet, Rotor2.Inlet) annotation (Line(
      points={{-82.08,12},{-77.92,12},{-77.92,11.8}},
      color={28,108,200},
      thickness=1));
  connect(turbine_Inlet.Turb_flow, Rotor1.Inlet) annotation (Line(
      points={{-94.03,11.07},{-92,11.07},{-92,11.8},{-89.92,11.8}},
      color={28,108,200},
      thickness=1));
  connect(port_a, port_a)
    annotation (Line(points={{-160,10},{-160,10}}, color={0,127,255}));
  connect(sensor_m_flow1.port_b, port_b) annotation (Line(
      points={{-136,-45},{-140,-45},{-140,-44},{-160,-44}},
      color={0,127,255},
      thickness=1));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                 Bitmap(
          extent={{-102,-78},{92,84}},
          imageSource=
              "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",
          fileName="modelica://MikkelsonModeling/../../../Downloads/stmtur.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{
              -89.92,11.8},{-84,11.8},{-84,10}},    color={28,108,200})}),
    experiment(
      StopTime=30,
      __Dymola_NumberOfIntervals=531,
      Tolerance=0.0005,
      __Dymola_Algorithm="Esdirk45a"));
end Diagram_ONLY_NuScale_Secondary_With_TES;
