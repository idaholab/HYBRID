within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_OneStageTurbine_Transient
  import NHES;
  extends Modelica.Icons.Example;
  NHES.Systems.BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
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
      W_totalSetpoint=ElectricPowerDemand.y),
    reservoir(level_start=10))
    annotation (Placement(transformation(extent={{14,-30},{74,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{96,-8},{84,8}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-26,-22},{-46,-2}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,2},{-10,22}})));
  Fluid.Sensors.stateDisplay stateDisplay
    annotation (Placement(transformation(extent={{-58,-70},{-14,-40}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-42,20},{2,50}})));
  Modelica.Fluid.Sources.MassFlowSource_h source1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=10,
    h=3e6)
    annotation (Placement(transformation(extent={{56,-56},{36,-36}})));
  NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop_STHX
                                              hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_Primary_SS
      CS) annotation (Placement(transformation(extent={{-112,-30},{-54,26}})));
  Modelica.Blocks.Sources.Constant ElectricPowerDemand(k=4.4e7)
    annotation (Placement(transformation(extent={{-98,76},{-78,96}})));
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
    annotation (Placement(transformation(extent={{2,-2},{-18,-22}})));

  Modelica.Blocks.Sources.Constant const2(k=-1e-1)
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=90,
        origin={21,-65})));
  Modelica.Blocks.Sources.Constant const10(k=5000)
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=90,
        origin={37,-65})));
  Modelica.Blocks.Sources.Constant const1(k=-150)
    annotation (Placement(transformation(extent={{3,-3},{-3,3}},
        rotation=90,
        origin={29,-65})));
  Modelica.Blocks.Sources.Constant setpoint_SteamTemperature(k=540)
    annotation (Placement(transformation(extent={{52,-88},{46,-82}})));
  NHES.Systems.PrimaryHeatSystem.HTGR.VarLimVarK_PID
                                        PID(
    use_k_in=true,
    use_lowlim_in=true,
    use_uplim_in=true,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=true,
    k=-5e-1,
    Ti=30) annotation (Placement(transformation(extent={{34,-86},{24,-76}})));
  Modelica.Blocks.Math.Add         add
    annotation (Placement(transformation(extent={{8,-78},{-4,-66}})));
  Modelica.Blocks.Sources.Constant RPM_basis(k=1000)
    annotation (Placement(transformation(extent={{24,-60},{18,-54}})));
  Modelica.Blocks.Sources.RealExpression SteamTemperature(y=stateDisplay1.T)
    annotation (Placement(transformation(extent={{-8,-98},{18,-82}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{52,-76},{46,-70}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
    BOP.pressure.p;

  connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
        points={{-20,31.1},{-20,12.05},{-19.95,12.05}},            color={0,0,0}));
  connect(stateDisplay.statePort, stateSensor2.statePort) annotation (Line(
        points={{-36,-58.9},{-36,-11.95},{-36.05,-11.95}}, color={0,0,0}));
  connect(stateSensor1.port_b, BOP.port_a)
    annotation (Line(points={{-10,12},{14,12}},  color={0,127,255}));
  connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{36,-46},{
          32,-46},{32,-30}},    color={0,127,255}));
  connect(BOP.portElec_b, sinkElec.port)
    annotation (Line(points={{74,0},{84,0}}, color={255,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
      Line(points={{-54.87,11.72},{-54.87,12},{-30,12}}, color={0,127,255}));
  connect(stateSensor2.port_b, hTGR_PebbleBed_Primary_Loop.port_a) annotation (
      Line(points={{-46,-12},{-54.87,-12},{-54.87,-11.24}}, color={0,127,255}));
  connect(stateSensor2.port_a, feedWaterpump.port_b)
    annotation (Line(points={{-26,-12},{-18,-12}}, color={0,127,255}));
  connect(feedWaterpump.port_a, BOP.port_b)
    annotation (Line(points={{2,-12},{14,-12}},    color={0,127,255}));
  connect(const10.y,PID. upperlim)
    annotation (Line(points={{37,-68.3},{32,-68.3},{32,-75.5}},
                                                             color={0,0,127}));
  connect(const1.y,PID. lowerlim) annotation (Line(points={{29,-68.3},{29,-75.5}},
                      color={0,0,127}));
  connect(PID.y,add. u2) annotation (Line(points={{23.5,-81},{20,-81},{20,-75.6},
          {9.2,-75.6}},
                      color={0,0,127}));
  connect(add.y, feedWaterpump.inputSignal) annotation (Line(points={{-4.6,-72},
          {-8,-72},{-8,-19}},                        color={0,0,127}));
  connect(SteamTemperature.y, PID.u_m)
    annotation (Line(points={{19.3,-90},{29,-90},{29,-87}}, color={0,0,127}));
  connect(setpoint_SteamTemperature.y, PID.u_s) annotation (Line(points={{45.7,
          -85},{40,-85},{40,-81},{35,-81}}, color={0,0,127}));
  connect(PID.u_ff, const6.y) annotation (Line(points={{35,-77},{40,-77},{40,
          -73},{45.7,-73}}, color={0,0,127}));
  connect(const2.y, PID.prop_k) annotation (Line(points={{21,-68.3},{25.3,-68.3},
          {25.3,-75.3}}, color={0,0,127}));
  connect(add.u1, RPM_basis.y) annotation (Line(points={{9.2,-68.4},{10,-68.4},
          {10,-68},{12,-68},{12,-57},{17.7,-57}}, color={0,0,127}));
  annotation (experiment(
      StopTime=60000,
      __Dymola_NumberOfIntervals=200,
      __Dymola_Algorithm="Esdirk34a"), __Dymola_experimentSetupOutput(events=
          false),
    Documentation(info="<html>
<p>Test of Pebble_Bed_One-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>If one would like to test transient scenario where electric power demand changes, one needs to change ElectricPowerDemand block in the model. </p>
<p>This transient model is designed to benchmark system variables with Pebble_Bed_Three-Stage_Rankine Model (See Rankine_HTGR_ThreeStageTurbine_Transient model).</p>
</html>"));
end Rankine_HTGR_OneStageTurbine_Transient;
