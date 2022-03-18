within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary;
model NuScale_Modal_Secondary_Arbitrage_Ports
  import NHES;
    extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable CS_Dummy CS,
    redeclare replaceable ED_Dummy ED,
    redeclare Data.Data_Dummy data);
    input Modelica.Units.SI.Power Q_RX_Internal;
    input Modelica.Units.SI.Power Demand_Internal;
    input Real DFV_Ancticipatory_Internal;
  parameter Integer TES_nPipes= 950;
  parameter Modelica.Units.SI.Length TES_Length=275
    "TES pipe length within concrete";
    parameter Real PipConcLRat = 3 "Pipe:Conc. ratio";
  parameter Modelica.Units.SI.Length TES_Thick=0.2
    "TES thickness to adiabatic boundary condition";
  parameter Modelica.Units.SI.Length TES_Width=0.8
    "Cross sectional area perpendicular to pipe length";
  parameter Real LP_NTU = 1.5 "Low pressure NTUHX NTU";
  parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
  parameter Real HP_NTU = 4.0 "High pressure NTUHX NTU";
  parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5 "Discharge source pump replacement dp";
  constant Real pi = Modelica.Constants.pi;
  parameter Modelica.Units.SI.Power Q_nom;
  Modelica.Units.SI.Energy dEdCycle;
  Modelica.Units.SI.Time t_track;
 // Modelica.SIunits.Temperature T_ideal;
  parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;

    parameter Modelica.Units.SI.Velocity vthes1=0 "Initial rotational velocity. 's/r' indicates stator/rotor, # is stage #" annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther1=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vthes8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Velocity vther8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
  parameter Modelica.Units.SI.Pressure ps1in=3170000 "Same indication system as rotational velocity" annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps1out=2620000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr1out=2610000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps2out=1400000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr2out=522600 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps3out=350000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps4out=180000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr4out=137800 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps5out=72000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr5out=64200 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps6out=58000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr6out=52800 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps7out=40000 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr7out=26400 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure ps8out=17500 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.Pressure pr8out=8100 annotation(dialog(tab = "Initialization", group = "Pressure"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
  parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar2[3]={0.1,0.23,0.23} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As2[3]={0.0645,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area Ar1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Area As1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
  parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82} annotation(dialog(tab = "Geometry", group = "Radii"));
  parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89} annotation(dialog(tab = "Geometry", group = "Radii"));
 parameter Real[2] alphas1 = {pi/3.4,0} "Ideal deflection angle in each stage. 0 indicates no change, not a 0 angle" annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar1 = {-pi/3.48,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas2 = {pi/2.185,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar2 = {-pi/2.2,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas3 = {pi/2.43,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar3 = {-pi/2.4,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas4 = {pi/2.6,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar4 = {-pi/2.56,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas5 = {pi/2.52,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar5 = {-pi/2.42,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas6 = {pi/3.33,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar6 = {-pi/3.62,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas7 = {pi/2.53,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar7 = {-pi/2.55,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphas8 = {pi/2.41,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  parameter Real[2] alphar8 = {-pi/2.21,0} annotation(dialog(tab = "Deflection", group = "Angles"));

public
  StagebyStageTurbine.MS MoistSep3(V_MS=0.6, eta=0.227)
    annotation (Placement(transformation(extent={{90,18},{102,30}})));
  StagebyStageTurbine.Turbine_Physical turbine_Editable(nSt=8)
    annotation (Placement(transformation(extent={{-94,44},{-74,64}})));
  StagebyStageTurbine.Generator_Basic                  generator(omega_nominal=50
        *3.14)
    annotation (Placement(transformation(extent={{-66,50},{-46,70}})));
  StagebyStageTurbine.Rotor_Stage Rotor8(
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
    annotation (Placement(transformation(extent={{114,14},{122,34}})));

  StagebyStageTurbine.Stator_Stage Stator8(
    isenthalpic=true,
    alpha=alphas8,
    A_flow=As8,
    ro=ros8,
    h_init=2350e3,
    m_init=52,
    p_in_init=pr7out,
    p_out_init=ps8out,
    v_the_init=vthes8)
    annotation (Placement(transformation(extent={{106,14},{112,34}})));
  StagebyStageTurbine.Rotor_Stage Rotor7(
    m_flow_nom=55.13,
    alpha=alphar7,
    A_flow=Ar7,
    ro=ror7,
    h_init=2330e3,
    m_init=53,
    p_in_init=ps7out,
    v_the_init=vther7,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{72,14},{80,34}})));

  StagebyStageTurbine.Stator_Stage Stator7(
    isenthalpic=true,
    alpha=alphas7,
    A_flow=As7,
    ro=ros7,
    h_init=2383e3,
    m_init=53,
    p_in_init=pr6out,
    p_out_init=ps7out,
    v_the_init=vthes7)
    annotation (Placement(transformation(extent={{64,14},{70,34}})));

  StagebyStageTurbine.MS MoistSep2(V_MS=0.25, eta=0.19)
    annotation (Placement(transformation(extent={{46,18},{58,30}})));
  StagebyStageTurbine.Rotor_Stage Rotor6(
    m_flow_nom=56.18,
    alpha=alphar6,
    A_flow=Ar6,
    ro=ror6,
    h_init=2336e3,
    m_init=56,
    p_in_init=ps6out,
    v_the_init=vther6,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{34,14},{42,34}})));

  StagebyStageTurbine.Stator_Stage Stator6(
    v_the_init=vthes6,
    isenthalpic=true,
    alpha=alphas6,
    A_flow=As6,
    ro=ros6,
    h_init=2417e3,
    m_init=56,
    p_in_init=pr5out,
    p_out_init=ps6out)
    annotation (Placement(transformation(extent={{22,14},{28,34}})));

  StagebyStageTurbine.Turbine_Tap turbine_Tap2
    annotation (Placement(transformation(extent={{12,16},{18,32}})));
  StagebyStageTurbine.Stator_Stage Stator5(
    dz={1.0,0.3},
    v_the_init=vthes5,
    alpha=alphas5,
    A_flow=As5,
    ro=ros5,
    h_init=2402e3,
    m_init=59,
    p_in_init=pr4out,
    p_out_init=ps5out)
    annotation (Placement(transformation(extent={{-8,14},{-2,34}})));

  StagebyStageTurbine.Rotor_Stage Rotor5(
    m_flow_nom=59.78,
    alpha=alphar5,
    A_flow=Ar5,
    ro=ror5,
    h_init=2379e3,
    m_init=59,
    p_in_init=ps5out,
    v_the_init=vther5,
    v_r_init=0.1) annotation (Placement(transformation(extent={{0,14},{8,34}})));

  StagebyStageTurbine.MS MoistSep1(V_MS=25, eta=0.17)
    annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
  StagebyStageTurbine.Rotor_Stage Rotor4(
    m_flow_nom=60.76,
    alpha=alphar4,
    A_flow=Ar4,
    ro=ror4,
    h_init=2402e3,
    m_init=60,
    p_in_init=ps4out,
    v_the_init=vther4,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-38,14},{-30,34}})));

  StagebyStageTurbine.Stator_Stage Stator4(
    v_the_init=vthes4,
    isenthalpic=true,
    alpha=alphas4,
    A_flow=As4,
    ro=ros4,
    h_init=2504e3,
    m_init=60,
    p_in_init=pr3out,
    p_out_init=ps4out)
    annotation (Placement(transformation(extent={{-48,14},{-42,34}})));

  StagebyStageTurbine.Turbine_Tap turbine_Tap1
    annotation (Placement(transformation(extent={{-58,16},{-52,30}})));
  StagebyStageTurbine.Rotor_Stage Rotor3(
    m_flow_nom=64.31,
    alpha=alphar3,
    A_flow=Ar3,
    ro=ror3,
    h_init=2477e3,
    m_init=64,
    p_in_init=ps3out,
    v_the_init=vther3,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-74,12},{-66,32}})));

  StagebyStageTurbine.Stator_Stage Stator3(
    v_the_init=vthes3,
    isenthalpic=true,
    alpha=alphas3,
    A_flow=As3,
    ro=ros3,
    h_init=2563e3,
    m_init=64,
    p_in_init=pr2out,
    p_out_init=ps3out)
    annotation (Placement(transformation(extent={{-82,12},{-76,32}})));
  StagebyStageTurbine.Turbine_Tap turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
    annotation (Placement(transformation(extent={{-92,16},{-86,30}})));
  StagebyStageTurbine.Rotor_Stage Rotor2(
    m_flow_nom=68.22,
    alpha=alphar2,
    A_flow=Ar2,
    ro=ror2,
    h_init=2674e3,
    m_init=68,
    p_in_init=ps2out,
    v_the_init=vther2,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-104,12},{-96,32}})));

  StagebyStageTurbine.Stator_Stage Stator2(
    v_the_init=vthes2,
    isenthalpic=true,
    alpha=alphas2,
    A_flow=As2,
    ro=ros2,
    h_init=2965e3,
    m_init=68,
    p_in_init=pr1out,
    p_out_init=ps2out)
    annotation (Placement(transformation(extent={{-114,12},{-108,32}})));
  StagebyStageTurbine.Rotor_Stage Rotor1(
    m_flow_nom=68.22,
    alpha=alphar1,
    A_flow=Ar1,
    ro=ror1,
    h_init=2999e3,
    m_init=68,
    p_in_init=ps1out,
    v_the_init=vther1,
    v_r_init=0.1)
    annotation (Placement(transformation(extent={{-128,12},{-120,32}})));

  StagebyStageTurbine.Stator_Stage Stator1(
    v_the_init=vthes1,
    isenthalpic=true,
    alpha=alphas1,
    A_flow=As1,
    ro=ros1,
    h_init=2999e3,
    m_init=68,
    p_in_init=ps1in,
    p_out_init=ps1out)
    annotation (Placement(transformation(extent={{-136,12},{-130,32}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
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
    annotation (Placement(transformation(extent={{4,-20},{16,-42}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
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
    annotation (Placement(transformation(extent={{-36,-20},{-16,-40}})));
  NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
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
    annotation (Placement(transformation(extent={{-96,-18},{-76,-40}})));
  StagebyStageTurbine.BaseClasses.Turbine_Outlet turbine_Outlet
    annotation (Placement(transformation(extent={{130,14},{134,34}})));
  StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet annotation (
      Placement(transformation(
        extent={{-4,-8},{4,8}},
        rotation=90,
        origin={-142,16})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr3out,
    use_T_start=false,
    h_start=1200e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.2),
    nPorts_a=2,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-54,-22},{-34,-2}})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume1(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr5out,
    use_T_start=false,
    h_start=1200e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.2),
    nPorts_a=3,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,-14})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                         condenser2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 8000,
    V_liquid_start=2,
    set_m_flow=false)
    annotation (Placement(transformation(extent={{-4,-5},{4,5}},
        rotation=90,
        origin={69,14})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume3(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr8out,
    use_T_start=false,
    h_start=150e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5),
    nPorts_b=4,
    nPorts_a=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={92,-36})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=90000)
    annotation (Placement(transformation(extent={{-70,-20},{-62,-8}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=8500)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-12,-21})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=3500)
    annotation (Placement(transformation(extent={{22,-26},{30,-14}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{34,-12},{46,-26}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                         condenser1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 8000,
    V_liquid_start=2,
    set_m_flow=false)
    annotation (Placement(transformation(extent={{-2,-4},{2,4}},
        rotation=90,
        origin={54,-8})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                         condenser3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 8000,
    V_liquid_start=2,
    set_m_flow=false)
    annotation (Placement(transformation(extent={{114,-2},{124,8}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser
                         condenser4(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="Pa") = 8000,
    V_liquid_start=2,
    set_m_flow=false,V_total=100)
    annotation (Placement(transformation(extent={{138,-4},{148,6}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{54,16},{60,6}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{6,7},{-6,-7}},
        rotation=180,
        origin={110,9})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{6,7},{-6,-7}},
        rotation=90,
        origin={144,15})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow7(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{78,18},{86,10}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow8(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{6,7},{-6,-7}},
        rotation=90,
        origin={120,-11})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow9(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=270,
        origin={146,-19})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow10(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,7},{6,-7}},
        rotation=0,
        origin={72,-7})));
  TRANSFORM.Controls.PI_Control PI4
    annotation (Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=270,
        origin={151,-9})));
  TRANSFORM.Controls.PI_Control PI5
    annotation (Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=270,
        origin={129,-11})));
  TRANSFORM.Controls.PI_Control PI6
    annotation (Placement(transformation(extent={{-3,3},{3,-3}},
        rotation=270,
        origin={67,5})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    valveLineartanh3(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40)
    annotation (Placement(transformation(extent={{88,10},{94,4}})));
  TRANSFORM.Controls.PI_Control PI7 annotation (Placement(transformation(
        extent={{3,-3},{-3,3}},
        rotation=180,
        origin={61,-19})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    valveLineartanh4(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40)
    annotation (Placement(transformation(extent={{80,-6},{86,-12}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    valveLineartanh5(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={121,-25})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    valveLineartanh6(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=10,
    m_flow_nominal=40) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={143,-31})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume2(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr5out,
    use_T_start=false,
    h_start=1200e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2.5),
    nPorts_b=1,
    nPorts_a=1)
    annotation (Placement(transformation(extent={{-4,-5},{4,5}},
        rotation=0,
        origin={102,15})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume4(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=pr5out,
    use_T_start=false,
    h_start=1200e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.8),
    nPorts_b=1,
    nPorts_a=1)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={52,6})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    LPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr8out,
    K=500,
    opening_init=0.01,
    tau=0.1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={21,3})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    IPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr6out,
    K=4250,
    tau=0.1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-53,5})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    HPTapValve(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_spring=pr5out,
    K=2300,
    tau=0.1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-88,-2})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance6(R=15000)
    annotation (Placement(transformation(extent={{92,10},{100,22}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=65000)
    annotation (Placement(transformation(extent={{-10,0},{-2,12}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance5(R=50000)
    annotation (Placement(transformation(extent={{-4,-6},{4,6}},
        rotation=270,
        origin={52,16})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    TCV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=450000,
    m_flow_nominal=68.404,
    opening_actual(start=1)) annotation (Placement(transformation(
        extent={{5,5},{-5,-5}},
        rotation=270,
        origin={-143,3})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance7(dp0=-2000)
                annotation (Placement(transformation(
        extent={{3,-2},{-3,2}},
        rotation=180,
        origin={63,-12})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance8(dp0=2000)
                annotation (Placement(transformation(
        extent={{-3,-2},{3,2}},
        rotation=180,
        origin={77,12})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance9(dp0=-2000)
                annotation (Placement(transformation(
        extent={{3,-2},{-3,2}},
        rotation=180,
        origin={107,-16})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance10(dp0=-2000)
                annotation (Placement(transformation(
        extent={{-3,-2},{3,2}},
        rotation=180,
        origin={141,-8})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
    TBV2(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=400000,
    m_flow_nominal=68.404,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{5,5},{-5,-5}},
        rotation=270,
        origin={-189,1})));
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
    annotation (Placement(transformation(extent={{-54,-28},{-66,-40}})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={-178,14})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
    FCV(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=200000,
    m_flow_nominal=63.5,
    opening_actual(start=1)) annotation (Placement(transformation(
        extent={{5,5},{-5,-5}},
        rotation=270,
        origin={-115,-9})));
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
    annotation (Placement(transformation(extent={{50,-42},{36,-28}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{6,7},{-6,-7}},
        rotation=90,
        origin={-130,3})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=90,
        origin={-104,-26})));
  TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(
        extent={{4,4},{-4,-4}},
        rotation=90,
        origin={-110,6})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-107,-45})));
  TRANSFORM.Fluid.Volumes.MixingVolume volume5(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    p_start=ps1in,
    use_T_start=false,
    h_start=3000e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    nPorts_b=2,
    nPorts_a=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-188,-18})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package Medium =
               Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-152,58},{-144,66}})));

  StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet1
    annotation (Placement(transformation(extent={{32,48},{12,68}})));
  StagebyStageTurbine.TeeJunctionIdeal_Cyl teeJunctionIdeal_Cyl(redeclare
      package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-18,68},{2,48}})));
  StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet2
    annotation (Placement(transformation(extent={{24,36},{4,56}})));
  StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet3
    annotation (Placement(transformation(extent={{-4,24},{-24,44}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    crossArea=As5[1],
    length=1.5,
    K_ab=1,
    K_ba=1)
    annotation (Placement(transformation(extent={{24,24},{4,44}})));

  Modelica.Fluid.Interfaces.FluidPort_b Feedwater(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{-112,-64},{-92,-44}}), iconTransformation(
          extent={{-112,-64},{-92,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_a SG_Return(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{-112,38},{-92,58}}), iconTransformation(extent={
            {-112,38},{-92,58}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
    DFV1(
    redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
    dp_nominal=250000,
    m_flow_nominal=20,
    opening_actual(start=0)) annotation (Placement(transformation(
        extent={{-5,5},{5,-5}},
        rotation=180,
        origin={85,61})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.TemperatureTwoPort_Superheat
    sensor_T(redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{126,50},{106,70}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                       sensor_T1(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater)
    annotation (Placement(transformation(extent={{-6,7},{6,-7}},
        rotation=90,
        origin={-118,-25})));
  Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
    annotation (Placement(transformation(extent={{-288,106},{-268,126}})));
  Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=Demand_Internal)
    annotation (Placement(transformation(extent={{-288,90},{-268,110}})));
  Modelica.Blocks.Sources.RealExpression DFV_Ancticipatory_Internal_Block(y=
        DFV_Ancticipatory_Internal)
    annotation (Placement(transformation(extent={{-288,74},{-268,94}})));
  Modelica.Fluid.Interfaces.FluidPort_b TBV_Send(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{100,74},{120,94}}), iconTransformation(extent={{94,48},
            {114,68}})));
  Modelica.Fluid.Interfaces.FluidPort_a TBV_Return(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{100,-66},{120,-46}}),iconTransformation(extent={{94,-66},
            {114,-46}})));
  Modelica.Fluid.Interfaces.FluidPort_a Arbitrage_Return(redeclare package
      Medium = Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{48,-100},{68,-80}}), iconTransformation(extent={{40,-110},
            {60,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Arbitrage_Send(redeclare package Medium =
        Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
        transformation(extent={{-54,-100},{-34,-80}}), iconTransformation(
          extent={{-28,-112},{-8,-92}})));
initial equation
  dEdCycle=0;
  t_track = 0;

//  T_ideal = T_feed_ref;
equation
  der(t_track)=1;
  der(dEdCycle) = generator.power-Q_nom;
  when t_track>=86400 then
    reinit(dEdCycle,0);
    reinit(t_track,0);
  end when;


  connect(generator.shaft, turbine_Editable.Generator_torque) annotation (Line(
        points={{-66.1,59.9},{-70,59.9},{-70,60},{-72,60},{-72,59.8},{-74,
          59.8}},                                                     color={0,0,
          0}));
  connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{114.08,23.8},{
          114.08,23.6},{112,23.6}},
                            color={28,108,200}));
  connect(Rotor8.torque, turbine_Editable.Fluidtorques[1]) annotation (Line(
        points={{116.64,28.6},{116.64,42},{-84.4,42},{-84.4,49.925}},
                                                                 color={28,108,200}));
  connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{102,24},
          {102,23.8},{106.06,23.8}}, color={28,108,200}));
  connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{72.08,23.8},{72.08,
          24},{70,24},{70,23.6}},                     color={28,108,200}));
  connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{79.92,24},
          {90,24}},                   color={28,108,200}));
  connect(Rotor7.torque, turbine_Editable.Fluidtorques[2]) annotation (Line(
        points={{74.64,28.6},{74.64,36},{76,36},{76,42},{-84.4,42},{-84.4,50.175}},
                                                                         color={
          28,108,200}));
  connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{58,24},
          {58,23.8},{64.06,23.8}},               color={28,108,200}));
  connect(Rotor6.torque, turbine_Editable.Fluidtorques[3]) annotation (Line(
        points={{36.64,28.6},{36.64,42},{-84.4,42},{-84.4,50.425}},
        color={28,108,200}));
  connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{41.92,24},
          {46,24}},                          color={28,108,200}));
  connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{28,23.6},{28,23.8},
          {34.08,23.8}},                        color={28,108,200}));
  connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{18.06,
          24},{20,24},{20,23.8},{22.06,23.8}},    color={28,108,200}));
  connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{7.92,24},
          {12.03,24},{12.03,24.08}},                color={28,108,200}));
  connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{0.08,23.8},{0.08,
          24},{-2,24},{-2,23.6}},                     color={28,108,200}));
  connect(Rotor5.torque, turbine_Editable.Fluidtorques[4]) annotation (Line(
        points={{2.64,28.6},{0,28.6},{0,42},{-84.4,42},{-84.4,50.675}},
                          color={28,108,200}));
  connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-37.92,
          23.8},{-42,23.8},{-42,23.6}},
                           color={28,108,200}));
  connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
    annotation (Line(points={{-47.94,23.8},{-47.94,24},{-51.94,24},{
          -51.94,23}},                                 color={28,108,200}));
  connect(Rotor4.torque, turbine_Editable.Fluidtorques[5]) annotation (Line(
        points={{-35.36,28.6},{-35.36,42},{-84.4,42},{-84.4,50.925}},
                    color={28,108,200}));
  connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-96.08,
          22},{-91.97,22},{-91.97,23.07}},      color={28,108,200}));
  connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-85.94,
          23},{-85.94,22},{-81.94,22},{-81.94,21.8}},            color={28,108,200}));
  connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-73.92,21.8},{
          -76,21.8},{-76,21.6}},                         color={28,108,200}));
  connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-103.92,21.8},
          {-106,21.8},{-106,22},{-108,22},{-108,21.6}},  color={28,108,200}));
  connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-113.94,21.8},
          {-114,21.8},{-114,22},{-120.08,22}},          color={28,108,200}));
  connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-127.92,21.8},
          {-128,21.8},{-128,22},{-130,22},{-130,21.6}},  color={28,108,200}));
  connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-66.08,
          22},{-62,22},{-62,23.07},{-57.97,23.07}},        color={28,108,200}));
  connect(Rotor3.torque, turbine_Editable.Fluidtorques[6]) annotation (Line(
        points={{-71.36,26.6},{-70,26.6},{-70,42},{-84.4,42},{-84.4,51.175}},
                               color={28,108,200}));
  connect(Rotor2.torque, turbine_Editable.Fluidtorques[7]) annotation (Line(
        points={{-101.36,26.6},{-101.36,40},{-106,40},{-106,42},{-84.4,42},{-84.4,
          51.425}},
        color={28,108,200}));
  connect(Rotor1.torque, turbine_Editable.Fluidtorques[8]) annotation (Line(
        points={{-125.36,26.6},{-125.36,34},{-124,34},{-124,42},{-84.4,42},{-84.4,
          51.675}}, color={28,108,200}));
  connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{4,-35.4},{4,
          -34},{-16,-34}},  color={0,127,255}));
  connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
        points={{121.92,24},{130,24},{130,24.1},{130.02,24.1}},
                                                            color={28,108,
          200}));
  connect(Stator1.Inlet, turbine_Inlet.Turb_flow) annotation (Line(points={{-135.94,
          21.8},{-142,21.8},{-142,19.96},{-141.92,19.96}},   color={28,
          108,200}));
  connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{-38,-12},{-38,
          -28},{-36,-28}},           color={0,127,255}));
  connect(volume1.port_b[1], LP.Shell_in) annotation (Line(points={{6,-20},
          {6,-22},{-4,-22},{-4,-28.8},{4,-28.8}},                 color={
          0,127,255}));
  connect(IP.Shell_out, resistance1.port_a) annotation (Line(points={{-16,-28},
          {-12,-28},{-12,-25.2}},   color={0,127,255}));
  connect(resistance1.port_b, volume1.port_a[1]) annotation (Line(points={{-12,
          -16.8},{-12,-2},{5.33333,-2},{5.33333,-8}},          color={0,127,255}));
  connect(volume.port_a[1], resistance.port_b) annotation (Line(points={{-50,-12.5},
          {-56,-12.5},{-56,-14},{-63.2,-14}}, color={0,127,255}));
  connect(HP.Shell_out, resistance.port_a) annotation (Line(points={{-76,
          -26.8},{-74,-26.8},{-74,-14},{-68.8,-14}},
                                              color={0,127,255}));
  connect(resistance2.port_b, sensor_m_flow3.port_a) annotation (Line(
        points={{28.8,-20},{34,-20},{34,-19}}, color={0,127,255}));
  connect(sensor_m_flow3.port_b, condenser1.port_a) annotation (Line(
        points={{46,-19},{46,-10},{51.2,-10},{51.2,-9.4}},
                                                         color={0,127,255}));
  connect(sensor_m_flow4.port_b, condenser2.port_a) annotation (Line(
        points={{60,11},{62,11},{62,12},{64,12},{64,11.2},{65.5,11.2}},
        color={0,127,255}));
  connect(sensor_m_flow6.port_b, condenser4.port_a) annotation (Line(
        points={{144,9},{144,4.5},{139.5,4.5}},  color={0,127,255}));
  connect(sensor_m_flow7.m_flow, PI6.u_m) annotation (Line(points={{82,
          12.56},{82,5},{70.6,5}}, color={0,0,127}));
  connect(PI6.u_s, sensor_m_flow4.m_flow) annotation (Line(points={{67,8.6},
          {57,8.6},{57,9.2}},         color={0,0,127}));
  connect(PI6.y, valveLineartanh3.opening) annotation (Line(points={{67,1.7},
          {66,1.7},{66,0},{92,0},{92,4.6},{91,4.6}},      color={0,0,127}));
  connect(valveLineartanh3.port_a, sensor_m_flow7.port_b) annotation (
      Line(points={{88,7},{88,6},{86,6},{86,14}}, color={0,127,255}));
  connect(valveLineartanh3.port_b, volume3.port_b[1]) annotation (Line(
        points={{94,7},{94,6},{98,6},{98,-36.75}},
                    color={0,127,255}));
  connect(PI7.u_s, sensor_m_flow3.m_flow) annotation (Line(points={{57.4,
          -19},{57.4,-20},{52,-20},{52,-26},{40,-26},{40,-21.52}}, color=
          {0,0,127}));
  connect(PI7.u_m, sensor_m_flow10.m_flow) annotation (Line(points={{61,
          -15.4},{60,-15.4},{60,-14},{72,-14},{72,-9.52}}, color={0,0,127}));
  connect(valveLineartanh4.port_a, sensor_m_flow10.port_b) annotation (
      Line(points={{80,-9},{80,-8},{78,-8},{78,-7}}, color={0,127,255}));
  connect(valveLineartanh4.port_b, volume3.port_b[2]) annotation (Line(
        points={{86,-9},{90,-9},{90,-10},{98,-10},{98,-36.25}},
        color={0,127,255}));
  connect(PI5.u_s, sensor_m_flow5.m_flow) annotation (Line(points={{129,
          -7.4},{129,11.52},{110,11.52}}, color={0,0,127}));
  connect(PI5.u_m, sensor_m_flow8.m_flow)
    annotation (Line(points={{125.4,-11},{122.52,-11}},
                                                      color={0,0,127}));
  connect(PI4.u_m, sensor_m_flow9.m_flow) annotation (Line(points={{147.4,
          -9},{147.4,-10},{148.52,-10},{148.52,-19}},
                                                    color={0,0,127}));
  connect(valveLineartanh6.port_b, volume3.port_b[3]) annotation (Line(
        points={{143,-34},{142,-34},{142,-36},{98,-36},{98,-35.75}},
        color={0,127,255}));
  connect(valveLineartanh5.port_b, volume3.port_b[4]) annotation (Line(
        points={{121,-28},{122,-28},{122,-36},{98,-36},{98,-35.25}},
        color={0,127,255}));
  connect(valveLineartanh5.port_a, sensor_m_flow8.port_b) annotation (
      Line(points={{121,-22},{120,-22},{120,-17}}, color={0,127,255}));
  connect(PI5.y, valveLineartanh5.opening) annotation (Line(points={{129,
          -14.3},{130,-14.3},{130,-26},{123.4,-26},{123.4,-25}}, color={0,
          0,127}));
  connect(sensor_m_flow9.port_b, valveLineartanh6.port_a) annotation (
      Line(points={{146,-25},{146,-28},{143,-28}}, color={0,127,255}));
  connect(valveLineartanh6.opening, PI4.y) annotation (Line(points={{145.4,
          -31},{145.4,-30},{152,-30},{152,-12.3},{151,-12.3}},
        color={0,0,127}));
  connect(volume2.port_b[1], sensor_m_flow5.port_a) annotation (Line(
        points={{104.4,15},{104.4,12},{104,12},{104,9}},
                                                      color={0,127,255}));
  connect(sensor_m_flow5.port_b, condenser3.port_a) annotation (Line(
        points={{116,9},{116,8},{115.5,8},{115.5,6.5}},    color={0,127,
          255}));
  connect(volume4.port_b[1], sensor_m_flow4.port_a) annotation (Line(
        points={{52,2.4},{56,2.4},{56,11},{54,11}},
                                            color={0,127,255}));
  connect(resistance2.port_a, LP.Shell_out) annotation (Line(points={{23.2,
          -20},{20,-20},{20,-28.8},{16,-28.8}},     color={0,127,255}));
  connect(PI7.y, valveLineartanh4.opening) annotation (Line(points={{64.3,
          -19},{70,-19},{70,-18},{84,-18},{84,-14},{83,-14},{83,-11.4}},
        color={0,0,127}));
  connect(LPTapValve.port_b, volume1.port_a[2]) annotation (Line(points={{21,0},{
          14,0},{14,-8},{6,-8}},       color={0,127,255}));
  connect(LPTapValve.port_a, turbine_Tap2.Tap_flow) annotation (Line(points={{21,6},{
          22,6},{22,10},{16,10},{16,21.44},{15,21.44}},
                                         color={0,127,255}));
  connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-88,-6},
          {-88,-16},{-100,-16},{-100,-26.8},{-96,-26.8}},
                                                      color={0,127,255}));
  connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-88,2},
          {-88,20.76},{-89,20.76}},             color={0,127,255}));
  connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-53,10},
          {-54,10},{-54,20.76},{-55,20.76}},     color={0,127,255}));
  connect(IPTapValve.port_b, volume.port_a[2]) annotation (Line(points={{-53,0},
          {-54,0},{-54,-11.5},{-50,-11.5}}, color={0,127,255}));
  connect(MoistSep3.Liquid, resistance6.port_a) annotation (Line(points={{96,
          22.08},{94,22.08},{94,16},{93.2,16}},
                                         color={0,127,255}));
  connect(volume2.port_a[1], resistance6.port_b) annotation (Line(points={{99.6,15},
          {99.6,15.5},{98.8,15.5},{98.8,16}},     color={0,127,255}));
  connect(resistance4.port_b, volume1.port_a[3]) annotation (Line(points={{-3.2,6},
          {2,6},{2,-8},{6.66667,-8}},       color={0,127,255}));
  connect(resistance4.port_a, MoistSep1.Liquid) annotation (Line(points={{-8.8,6},
          {-18,6},{-18,22.08}},                color={0,127,255}));
  connect(MoistSep2.Liquid, resistance5.port_a)
    annotation (Line(points={{52,22.08},{52,18.8}}, color={0,127,255}));
  connect(volume4.port_a[1], resistance5.port_b)
    annotation (Line(points={{52,9.6},{52,13.2}},  color={0,127,255}));
  connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-143,8},
          {-142,8},{-142,12}},         color={0,127,255}));
  connect(condenser1.port_b, resistance7.port_a) annotation (Line(points=
          {{57.2,-8},{60,-8},{60,-12},{60.9,-12}}, color={0,127,255}));
  connect(sensor_m_flow10.port_a, resistance7.port_b) annotation (Line(
        points={{66,-7},{63.5,-7},{63.5,-12},{65.1,-12}}, color={0,127,
          255}));
  connect(sensor_m_flow7.port_a, resistance8.port_a) annotation (Line(
        points={{78,14},{78,12},{79.1,12}}, color={0,127,255}));
  connect(condenser2.port_b, resistance8.port_b) annotation (Line(points=
          {{73,14},{74,14},{74,12},{74.9,12}}, color={0,127,255}));
  connect(resistance10.port_a, condenser4.port_b) annotation (Line(points=
         {{143.1,-8},{143,-8},{143,-3}}, color={0,127,255}));
  connect(resistance10.port_b, sensor_m_flow9.port_a) annotation (Line(
        points={{138.9,-8},{142,-8},{142,-13},{146,-13}}, color={0,127,
          255}));
  connect(resistance9.port_a, condenser3.port_b) annotation (Line(points=
          {{104.9,-16},{104,-16},{104,-1},{119,-1}}, color={0,127,255}));
  connect(sensor_m_flow8.port_a, resistance9.port_b) annotation (Line(
        points={{120,-5},{116,-5},{116,-4},{109.1,-4},{109.1,-16}}, color=
         {0,127,255}));
  connect(IP.Tube_out, FWCP.port_a)
    annotation (Line(points={{-36,-34},{-54,-34}}, color={0,127,255}));
  connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-76,-33.4},{
          -72,-33.4},{-72,-34},{-66,-34}}, color={0,127,255}));
  connect(LP.Tube_in, CDP.port_b) annotation (Line(points={{16,-35.4},{26,
          -35.4},{26,-35},{36,-35}}, color={0,127,255}));
  connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{
          -115,-4},{-116,-4},{-116,14},{-130,14},{-130,9}}, color={0,127,
          255}));
  connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-174,14},
          {-168,14},{-168,-4},{-143,-4},{-143,-2}}, color={0,127,255}));
  connect(sensor_p2.p, add.u1)
    annotation (Line(points={{-104,-28.4},{-104,-39}}, color={0,0,127}));
  connect(sensor_p3.p, add.u2)
    annotation (Line(points={{-110,3.6},{-110,-39}}, color={0,0,127}));
  connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,6},
          {-122,6},{-122,9},{-130,9}},           color={0,127,255}));
  connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-108,-26},
          {-102,-26},{-102,-33.4},{-96,-33.4}}, color={0,127,255}));
  connect(volume5.port_b[1], TBV2.port_a) annotation (Line(points={{-182,-18.5},
          {-186,-18.5},{-186,-4},{-189,-4}}, color={0,127,255}));
  connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-182,
          -17.5},{-162,-17.5},{-162,-2},{-143,-2}}, color={0,127,255}));
  connect(sensor_m_flow12.port_a, TBV2.port_b) annotation (Line(points={{-152,62},
          {-170,62},{-170,60},{-188,60},{-188,6},{-189,6}},
                               color={0,127,255}));
  connect(volume3.port_a[1], CDP.port_a) annotation (Line(points={{86,-36.5},{
          68,-36.5},{68,-35},{50,-35}},color={0,127,255}));
  connect(PI4.u_s, sensor_m_flow6.m_flow) annotation (Line(points={{151,-5.4},{151,
          5.3},{146.52,5.3},{146.52,15}},            color={0,0,127}));
  connect(sensor_m_flow6.port_a, turbine_Outlet.Pipe_flow) annotation (Line(
        points={{144,21},{136,21},{136,24},{134,24}}, color={0,127,255}));
  connect(teeJunctionIdeal_Cyl.port_2, turbine_Inlet1.Turb_flow)
    annotation (Line(points={{2,58},{2,57.9},{12.1,57.9}},color={28,108,200}));
  connect(MoistSep1.Turb_Out, Stator5.Inlet) annotation (Line(points={{
          -12,24},{-10,24},{-10,23.8},{-7.94,23.8}}, color={28,108,200}));
  connect(teeJunctionIdeal_Cyl.port_1, Rotor4.Outlet) annotation (Line(
        points={{-18,58},{-28,58},{-28,24},{-30.08,24}}, color={28,108,
          200}));
  connect(turbine_Inlet3.Turb_flow, MoistSep1.Turb_In) annotation (Line(
        points={{-23.9,33.9},{-26,33.9},{-26,24},{-24,24}}, color={28,108,
          200}));
  connect(turbine_Inlet2.Turb_flow, teeJunctionIdeal_Cyl.port_3)
    annotation (Line(points={{4.1,45.9},{4.1,46},{-8,46},{-8,48}},
        color={28,108,200}));
  connect(transportDelayPipe.port_a, turbine_Inlet2.Pipe_flow)
    annotation (Line(points={{24,34},{30,34},{30,46},{24,46}}, color={0,
          127,255}));
  connect(transportDelayPipe.port_b, turbine_Inlet3.Pipe_flow)
    annotation (Line(points={{4,34},{-4,34}},                  color={0,
          127,255}));
  connect(sensor_m_flow1.port_b, Feedwater) annotation (Line(points={{-130,-3},{
          -138,-3},{-138,-54},{-102,-54}}, color={0,127,255}));
  connect(SG_Return, volume5.port_a[1]) annotation (Line(points={{-102,48},{-102,
          48},{-194,48},{-194,-18}}, color={0,127,255}));
  connect(DFV1.port_b, turbine_Inlet1.Pipe_flow) annotation (Line(points={{80,61},
          {72,61},{72,58},{32,58}},                 color={0,127,255}));
  connect(sensor_T.port_b, DFV1.port_a) annotation (Line(points={{106,60},{106,61},
          {90,61}},          color={0,127,255}));
  connect(HP.Tube_out, sensor_T1.port_a) annotation (Line(points={{-96,-33.4},{-106,
          -33.4},{-106,-34},{-118,-34},{-118,-31}}, color={0,127,255}));
  connect(sensor_T1.port_b, FCV.port_a) annotation (Line(points={{-118,-19},{-118,
          -18},{-115,-18},{-115,-14}}, color={0,127,255}));
  connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
      points={{30,100},{144,100},{144,98},{256,98},{256,-58},{-60,-58},{-60,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorBus.dP_FCV, add.y) annotation (Line(
      points={{-30,100},{-236,100},{-236,-58},{-107,-58},{-107,-50.5}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
      points={{-30,100},{-236,100},{-236,116},{-267,116}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
      points={{-30,100},{-267,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.DFV_Anticipatory, DFV_Ancticipatory_Internal_Block.y)
    annotation (Line(
      points={{-30,100},{-236,100},{-236,84},{-267,84}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DFV_Opening, DFV1.opening) annotation (Line(
      points={{30,100},{85,100},{85,65}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Superheat_Sensor_Opening, sensor_T.dT) annotation (Line(
      points={{-30,100},{-32,100},{-32,86},{116,86},{116,63.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Generator_Power, generator.Power) annotation (Line(
      points={{-30,100},{-46,100},{-46,98},{-56,98},{-56,70.8},{-56,70.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
      points={{-30,100},{-236,100},{-236,-26},{-130,-26},{-130,-8},{-122,-8},{
          -122,3},{-127.48,3}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
      points={{30,100},{30,88},{-214,88},{-214,-40},{-136,-40},{-136,-9},{-119,
          -9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TBV_Opening, TBV2.opening) annotation (Line(
      points={{30,100},{30,88},{-214,88},{-214,1},{-193,1}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
      points={{-30,100},{-236,100},{-236,-26},{-178,-26},{-178,11.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
      points={{30,100},{30,88},{-214,88},{-214,-38},{-154,-38},{-154,3},{-147,3}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(TBV_Send, sensor_m_flow12.port_b) annotation (Line(points={{110,84},{
          108,84},{108,72},{104,72},{104,62},{-144,62}}, color={0,127,255}));
  connect(TBV_Return, sensor_m_flow6.port_a) annotation (Line(points={{110,-56},
          {154,-56},{154,-52},{196,-52},{196,42},{146,42},{146,21},{144,21}},
        color={0,127,255}));
  connect(Arbitrage_Return, sensor_T.port_a) annotation (Line(points={{58,-90},
          {118,-90},{118,-86},{228,-86},{228,76},{126,76},{126,60}}, color={0,
          127,255}));
  connect(Arbitrage_Send, volume3.port_a[2]) annotation (Line(points={{-44,-90},
          {18,-90},{18,-70},{86,-70},{86,-35.5}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{24,22},{24,-8},{32,-22},{32,36},{24,22}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,22},{40,-8},{48,-24},{48,38},{40,22}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,22},{-12,-8},{-2,-22},{-2,38},{-12,22}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{8,22},{8,-8},{16,-24},{16,36},{8,22}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2.55993,3},{93.4405,-3}},
          lineColor={0,0,0},
          origin={-31.44,-1},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{60,14},{88,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{69,-6},{79,8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Rectangle(
          extent={{-1.06666,3.0002},{38.9329,-3.0002}},
          lineColor={0,0,0},
          origin={61,-50.933},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.4,3},{15.5,-3}},
          lineColor={0,0,0},
          origin={48.427,-15},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.341457,2},{13.6584,-2}},
          lineColor={0,0,0},
          origin={8,-48.342},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.12002,2},{40.8804,-2}},
          lineColor={0,0,0},
          origin={11.12,-60},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.578156,2.1722},{23.1262,-2.1722}},
          lineColor={0,0,0},
          origin={5.422,-49.828},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-26,-46},{-14,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-19,-49},{-19,-55},{-24,-52},{-19,-49}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Rectangle(
          extent={{-1.81329,5},{66.1867,-5}},
          lineColor={0,0,0},
          origin={-92.1867,-53},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.341463,3},{13.6586,-3}},
          lineColor={0,0,0},
          origin={72.3414,-67},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-16,3},{16,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={-12,38},
          rotation=-90),
        Rectangle(
          extent={{-38,54},{-12,42}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-94,54},{-46,42}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-48,57},{-30,39}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{-37,57},{-41,39}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Rectangle(
          extent={{-38,55},{-40,67}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-48,69},{-30,67}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-24,-56},{-28,-60},{-12,-60},{-16,-56},{-24,-56}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-0.244084,1},{9.76422,-1}},
          lineColor={0,0,0},
          origin={-1.764,19},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.195303,1},{7.8128,-1}},
          lineColor={0,0,0},
          origin={16.187,19},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.195308,1},{7.813,-1}},
          lineColor={0,0,0},
          origin={32.187,19},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{46,-50},{74,-76}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{55,-70},{65,-56}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Rectangle(
          extent={{-1.06666,3.0002},{38.9329,-3.0002}},
          lineColor={0,0,0},
          origin={-53,-70.933},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2.61619,3},{101.384,-3}},
          lineColor={0,0,0},
          origin={-53.384,-31},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.37333,1.00001},{13.6262,-1}},
          lineColor={0,0,0},
          origin={29,-29.626},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.37333,1.00001},{13.6262,-1}},
          lineColor={0,0,0},
          origin={13,-29.626},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.37333,1.00001},{13.6262,-1}},
          lineColor={0,0,0},
          origin={-5,-29.626},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.37333,1.00001},{13.6262,-1}},
          lineColor={0,0,0},
          origin={45,-29.626},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-2.61619,3},{101.384,-3}},
          lineColor={0,0,0},
          origin={-53.384,-69},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-10,54},{48,48}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.634164,0.999955},{25.3659,-1.0001}},
          lineColor={0,0,0},
          origin={22.634,41.0001},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.586685,0.999995},{21.4135,-1}},
          lineColor={0,0,0},
          origin={21,20.5865},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          extent={{45,52},{54,64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1"),
        Text(
          extent={{109,62},{119,76}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="1"),
        Text(
          extent={{113,-54},{123,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="2"),
        Text(
          extent={{63,-22},{72,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="2"),
        Text(
          extent={{77,-66},{86,-56}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="3"),
        Text(
          extent={{-37,-112},{-27,-98}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="3"),
        Text(
          extent={{59,-114},{69,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="4"),
        Text(
          extent={{47,36},{56,48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="4")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=30,
      __Dymola_NumberOfIntervals=531,
      Tolerance=0.0005,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>This is an integrable NuScale secondary model with 6 fluid ports. The left-side icon ports are intended to be connected to the steam generator of the SMR. Ports labelled 1 and 2 on the right hand side of the icon are designed as the <b>charging</b> ports, connected to the TBV for sourcing and returning just upstream of the condensers. Ports labelled 3 and 4 on the bottom side of the icon are designed as the <b>discharging</b> ports, which sources from the condensers and returns steam to peak the turbine. </p>
<p>For other notes, see the NuScale_Secondary model. </p>
</html>"));
end NuScale_Modal_Secondary_Arbitrage_Ports;
