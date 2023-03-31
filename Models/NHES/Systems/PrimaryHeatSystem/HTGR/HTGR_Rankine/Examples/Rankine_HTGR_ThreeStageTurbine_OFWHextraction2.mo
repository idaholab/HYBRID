within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_ThreeStageTurbine_OFWHextraction2
  extends Modelica.Icons.Example;
  parameter Real P_ext=32;
  parameter Real P_demand=31;
  parameter Modelica.Units.SI.Density d_ext=13.10995 "kg/m3";
  parameter Modelica.Units.SI.MassFlowRate m_ext=25.275;
  Real breaker;
  parameter Real Boo=1;

  Real eta_th "Thermal Cycle Efficiency";

  Components.HTGR_PebbleBed_Primary_Loop_STHX hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_Primary_SS
      CS) annotation (Placement(transformation(extent={{-100,-20},{-40,40}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,16},{-14,36}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-14,-10},{-30,10}})));
  Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-42,34},{-2,64}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-42,-10},{-2,-40}})));
  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_HTGR_extraction
      CS(
      data(
        Power_nom=data.Power_nom,
        HPT_p_in=data.HPT_p_in,
        p_dump=data.p_dump,
        p_i1=data.p_i1,
        p_i2=data.p_i2,
        cond_p=data.cond_p,
        Tin=data.Tin,
        Tfeed=data.Tfeed,
        d_HPT_in(displayUnit="kg/m3") = data.d_HPT_in,
        d_LPT1_in(displayUnit="g/cm3") = data.d_LPT1_in,
        d_LPT2_in(displayUnit="kg/m3") = data.d_LPT2_in,
        mdot_total=data.mdot_total,
        mdot_fh=data.mdot_fh,
        mdpt_HPFH=data.mdpt_HPFH,
        mdot_hpt=data.mdot_hpt,
        mdot_lpt1=data.mdot_lpt1,
        mdot_lpt2=data.mdot_lpt2,
        m_ext=data.m_ext,
        eta_t=data.eta_t,
        eta_mech=data.eta_mech,
        eta_p=data.eta_p),
      Steam_Extraction(y=data.m_ext),
      booleanStep2(startTime=4e5),
      LPT1_BV_PID(k=1e-5, Ti=100),
      ext_pos_start(height=1e-5/(P_ext - P_demand),
        duration=1e4,
        startTime=3e5),
      FeedPump_PID(k=-1e-4),
      ramp(startTime=0),
      T_in_set2(y=0),
      booleanStep1(startTime=1e5)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Data_L3 data(
      Power_nom=data.Power_nom,
      HPT_p_in=data.HPT_p_in,
      p_dump=data.p_dump,
      p_i1=data.p_i1,
      p_i2=data.p_i2,
      cond_p=data.cond_p,
      Tin=data.Tin,
      Tfeed=data.Tfeed,
      d_HPT_in(displayUnit="kg/m3") = data.d_HPT_in,
      d_LPT1_in(displayUnit="g/cm3") = data.d_LPT1_in,
      d_LPT2_in(displayUnit="kg/m3") = data.d_LPT2_in,
      mdot_total=data.mdot_total,
      mdot_fh=data.mdot_fh,
      mdpt_HPFH=data.mdpt_HPFH,
      mdot_hpt=data.mdot_hpt,
      mdot_lpt1=data.mdot_lpt1,
      mdot_lpt2=data.mdot_lpt2,
      m_ext=data.m_ext,
      eta_t=data.eta_t,
      eta_mech=data.eta_mech,
      eta_p=data.eta_p),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15),
    LPT1_bypass_valve(
      m_flow_start=m_ext,
                      dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*m_ext),
    LPT1(m_flow_start=data.d_LPT1_in - m_ext),
    LPT2(m_flow_start=data.mdot_lpt2 - m_ext),
    HPT_bypass_valve(m_flow_start=data.mdot_fh),
    TCV(m_flow_start=data.mdot_total))
    annotation (Placement(transformation(extent={{60,-20},{120,40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-24,-72},{-4,-52}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{180,28},{160,48}})));
  BalanceOfPlant.Turbine.Data.Data_L3_master data(
    Power_nom=80e6,
    HPT_p_in=14000000,
    p_dump=16000000,
    p_i1=P_ext*100000,
    Tin=788.15,
    Tfeed=481.15,
    d_HPT_in(displayUnit="kg/m3") = 43.049187,
    d_LPT1_in(displayUnit="g/cm3") = d_ext,
    d_LPT2_in(displayUnit="kg/m3"),
    mdot_total=50.55,
    mdot_fh=10.6,
    mdot_hpt=39.945,
    mdot_lpt1=39.945,
    mdot_lpt2=35.7553,
    m_ext=m_ext,
    p_use=P_demand*100000,
    eta_t=0.9,
    eta_mech=0.99,
    eta_p=0.8)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=4,
    h=192e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{180,-12},{160,8}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={40,-50})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=P_demand*100000)
    annotation (Placement(transformation(extent={{-80,-64},{-60,-44}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{124,74},{144,94}})));
  Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{132,50},{152,30}})));
initial equation

equation
  breaker=1/Boo;
 assert(P_ext>bypassdump.medium.p_bar, "Extraction Pressure is below usage pressure",level = AssertionLevel.error);

  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.TCV.port_a.p;

  eta_th=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W)/hTGR_PebbleBed_Primary_Loop.core.Q_total.y;
  connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
      Line(points={{-40.9,24.7},{-40.9,26},{-30,26}},    color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, stateSensor2.port_b) annotation (
      Line(points={{-40.9,0.1},{-40.9,0},{-30,0}},    color={0,127,255}));
  connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
        points={{-21.96,26.05},{-22,26.05},{-22,45.1}}, color={0,0,0}));
  connect(stateSensor2.statePort, stateDisplay1.statePort)
    annotation (Line(points={{-22.04,0.05},{-22,-21.1}}, color={0,0,0}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{20,84},{52,84},{52,40},{60,40}},
                                               color={0,127,255}));
  connect(BOP.port_a_steam, stateSensor1.port_b) annotation (Line(points={{60,28},
          {58,28},{58,26},{-14,26}},   color={0,127,255}));
  connect(stateSensor2.port_a, BOP.port_b_feed) annotation (Line(points={{-14,0},
          {50,0},{50,-8},{60,-8}},   color={0,127,255}));
  connect(sensor_m_flow.port_a, BOP.port_b_bypass)
    annotation (Line(points={{40,-40},{40,10},{60,10}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, bypassdump.ports[1])
    annotation (Line(points={{40,-60},{40,-62},{-4,-62}},
                                                 color={0,127,255}));
  connect(bypassdump1.ports[1], BOP.port_a_cond)
    annotation (Line(points={{160,-2},{120,-2}}, color={0,127,255}));
  connect(sensor_m_flow.m_flow, bypassdump1.m_flow_in) annotation (Line(points=
          {{43.6,-50},{184,-50},{184,6},{180,6}}, color={0,0,127}));
  connect(realExpression.y, bypassdump.p_in)
    annotation (Line(points={{-59,-54},{-26,-54}}, color={0,0,127}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{120,10},{130,
          10},{130,26},{128,26},{128,40},{132,40}}, color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{160,38},{160,
          40.2},{152,40.2}}, color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{142,49.4},{142,70},
          {112,70},{112,84},{122,84}}, color={0,0,127}));
  annotation (experiment(
      StopTime=300000,
      Interval=50,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Three-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>The ThreeStaged Turbine BOP model contains four control elements: </p>
<p>1. maintaining steam (steam generator outlet) pressure by using TCV</p>
<p>2. controling amount of electricity generated by using LPTBV1</p>
<p>3. maintaining feedwater temperature by using LPTBV2</p>
<p>4. maintaining steam (steam generator outlet) temperature by controlling feedwater pump RPM</p>
</html>"),
    __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
          Design.Internal.Records.ModelDependencySetup(
          Model=
            "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
          dependencyParameters={Design.Internal.Records.DependencyParameter(
            name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
            1e-05,
            1e-06,
            6))},
          VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
          integrator=Design.Internal.Records.Integrator(
            startTime=0,
            stopTime=1004200,
            numberOfIntervals=0,
            outputInterval=10,
            method="Esdirk45a",
            tolerance=0.0001,
            fixedStepSize=0)))),
    __Dymola_experimentSetupOutput(events=false));
end Rankine_HTGR_ThreeStageTurbine_OFWHextraction2;
