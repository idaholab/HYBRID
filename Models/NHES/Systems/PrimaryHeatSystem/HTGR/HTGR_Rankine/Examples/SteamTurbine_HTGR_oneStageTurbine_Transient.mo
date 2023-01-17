within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model SteamTurbine_HTGR_oneStageTurbine_Transient
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries       BOP(
    nPorts_a3=1,
    port_a3_nominal_m_flow={0},
    port_a_nominal(
      m_flow=45.7058,
      p=14000000,
      h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 813)),
    port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
          481)),
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
      CS(
      delayStartTCV=0,
      delayStartBV=0,
      p_nominal=14000000,
      W_totalSetpoint=const.y),
    reservoir(level_start=10))
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-22},{-90,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-90,2},{-70,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-102,-70},{-58,-40}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-102,20},{-58,50}})));
  Modelica.Fluid.Sources.MassFlowSource_h source1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=10,
    h=3e6)
    annotation (Placement(transformation(extent={{12,-56},{-8,-36}})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/200,
    offset=4e7,
    startTime=1500,
    amplitude=2e8)
    annotation (Placement(transformation(extent={{-96,76},{-76,96}})));
  NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop_STHX
                                              hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_Primary_SS
      CS) annotation (Placement(transformation(extent={{-156,-30},{-98,26}})));
  Modelica.Blocks.Sources.Constant
                               const(k=4.4e7)
    annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
  TRANSFORM.Fluid.Machines.Pump_Controlled feedWaterpump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model EfficiencyChar =
        TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant,
    N_nominal=1200,
    dp_nominal=15000000,
    m_flow_nominal=50,
    d_nominal=1000,
    controlType="RPM",
    use_port=true)
    annotation (Placement(transformation(extent={{-42,-2},{-62,-22}})));

  Modelica.Blocks.Sources.Constant const2(k=-1e-1)
    annotation (Placement(transformation(extent={{112,-24},{128,-8}})));
  Modelica.Blocks.Sources.Constant const10(k=5000)
    annotation (Placement(transformation(extent={{112,-50},{128,-34}})));
  Modelica.Blocks.Sources.Constant const1(k=-150)
    annotation (Placement(transformation(extent={{112,-78},{128,-62}})));
  Modelica.Blocks.Sources.Constant const3(k=540)
    annotation (Placement(transformation(extent={{90,-120},{106,-104}})));
  NHES.Systems.PrimaryHeatSystem.HTGR.VarLimVarK_PID
                                        PID(
    use_k_in=true,
    use_lowlim_in=true,
    use_uplim_in=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=true,
    k=-5e-1,
    Ti=30) annotation (Placement(transformation(extent={{134,-112},{154,-92}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{188,-98},{208,-78}})));
  Modelica.Blocks.Sources.Constant const5(k=1000)
    annotation (Placement(transformation(extent={{156,-80},{172,-64}})));
  Modelica.Blocks.Sources.RealExpression Q_balance1(y=stateDisplay1.T)
    "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
    annotation (Placement(transformation(extent={{108,-138},{134,-122}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{90,-92},{106,-76}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
    BOP.pressure.p;

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-80,31.1},{-80,12.05},{-79.95,12.05}},            color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor2.statePort) annotation (Line(
        points={{-80,-58.9},{-80,-11.95},{-80.05,-11.95}}, color={0,0,0}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-70,12},{-30,12}}, color={0,127,255}));
  connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{-8,-46},{
          -12,-46},{-12,-30}},  color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{30,0},{70,0}}, color={255,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
      Line(points={{-98.87,11.72},{-98.87,12},{-90,12}}, color={0,127,255}));
  connect(stateSensor2.port_b, hTGR_PebbleBed_Primary_Loop.port_a) annotation (
      Line(points={{-90,-12},{-98.87,-12},{-98.87,-11.24}}, color={0,127,255}));
  connect(stateSensor2.port_a, feedWaterpump.port_b)
    annotation (Line(points={{-70,-12},{-62,-12}}, color={0,127,255}));
  connect(feedWaterpump.port_a, BOP.port_b)
    annotation (Line(points={{-42,-12},{-30,-12}}, color={0,127,255}));
  connect(const2.y,PID. prop_k) annotation (Line(points={{128.8,-16},{150,-16},
          {150,-90.6},{151.4,-90.6}},
                                 color={0,0,127}));
  connect(const10.y,PID. upperlim)
    annotation (Line(points={{128.8,-42},{138,-42},{138,-91}},
                                                             color={0,0,127}));
  connect(const1.y,PID. lowerlim) annotation (Line(points={{128.8,-70},{144,-70},
          {144,-91}}, color={0,0,127}));
  connect(const5.y,add. u1) annotation (Line(points={{172.8,-72},{178,-72},{178,
          -82},{186,-82}}, color={0,0,127}));
  connect(PID.y,add. u2) annotation (Line(points={{155,-102},{178,-102},{178,
          -94},{186,-94}},
                      color={0,0,127}));
  connect(add.y, feedWaterpump.inputSignal) annotation (Line(points={{209,-88},
          {218,-88},{218,-152},{-52,-152},{-52,-19}},color={0,0,127}));
  connect(Q_balance1.y, PID.u_m) annotation (Line(points={{135.3,-130},{144,
          -130},{144,-114}}, color={0,0,127}));
  connect(const3.y,PID. u_s)
    annotation (Line(points={{106.8,-112},{120,-112},{120,-102},{132,-102}},
                                                     color={0,0,127}));
  connect(const6.y, PID.u_ff) annotation (Line(points={{106.8,-84},{122,-84},{
          122,-94},{132,-94}}, color={0,0,127}));
  annotation (experiment(
      StopTime=100000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Esdirk34a"));
end SteamTurbine_HTGR_oneStageTurbine_Transient;
