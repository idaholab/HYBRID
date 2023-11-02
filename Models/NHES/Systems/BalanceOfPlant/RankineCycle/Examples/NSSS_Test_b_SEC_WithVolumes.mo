within NHES.Systems.BalanceOfPlant.RankineCycle.Examples;
model NSSS_Test_b_SEC_WithVolumes
  extends Modelica.Icons.Example;
//  parameter Real P_ext=3;
//  parameter Real P_demand=2.5;
//  parameter Modelica.Units.SI.Density d_ext=2.03641  "kg/m3";
//  parameter Modelica.Units.SI.MassFlowRate m_ext=40;

  parameter Real P_ext=1.6;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext=1.004547784   "kg/m3";

  parameter Modelica.Units.SI.MassFlowRate m_ext=0;

  Real breaker;
  parameter Real Boo=1;

//  Real eta_th "Thermal Cycle Efficiency";
//  Real eta_CHP "Thermal Cycle Efficiency";
  Real Q_util "Thermal Cycle Efficiency";

  NHES.Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,16},{-18,36}})));
  NHES.Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,0},{-38,-20}})));
  NHES.Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-48,34},{-8,64}})));
  NHES.Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-48,-16},{-8,-46}})));
  Models.SteamTurbine_L3_HPOFWHsimplified_sec_2 BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_L3_HTGR_extraction_logan_new
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
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
    LPT1_bypass_valve(dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*m_ext),
    moistureSeperator(p_start=150000, T_start=384.15),
    pump(use_input=false))
    annotation (Placement(transformation(extent={{10,-22},{70,38}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-42,-86},{-20,-66}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-18,76},{2,96}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{-5.5,-7.5},{5.5,7.5}},
        rotation=90,
        origin={88.5,11.5})));
  NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_4Turbines data(
    Power_nom=3.1e9,
    HPT_p_in=7340000,
    p_dump=15500000,
    p_i1=990000,
    p_i2=390000,
    Tin=562.15,
    Tfeed=429.85,
    d_HPT_in(displayUnit="kg/m3") = 37.8451727,
    d_LPT1_in(displayUnit="kg/m3") = 6.064249238,
    d_LPT2_in(displayUnit="kg/m3") = 2.111864686,
    mdot_total=1463.311565,
    mdot_fh=225.0848996,
    mdpt_HPFH=280,
    mdot_hpt=1238.226665,
    mdot_lpt1=1238.226665,
    mdot_lpt2=995.6849312,
    m_ext=m_ext,
    eta_t=0.93,
    eta_mech=1,
    eta_p=0.9)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=4,
    h=192e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={86,-38})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={2,-62})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=P_demand*100000)
    annotation (Placement(transformation(extent={{-98,-78},{-78,-58}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={88,76})));
  NHES.Electrical.PowerSensor sensorW
    annotation (Placement(transformation(extent={{80,42},{96,26}})));
  PrimaryHeatSystem.FourLoopPWR.Components.NSSS_SEC_LoadFollow PHS
    annotation (Placement(transformation(extent={{-144,-10},{-100,34}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=7340000,
    T_start=562.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    use_HeatPort=true,
    Q_gen(displayUnit="MW"))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,40})));
initial equation

equation
  breaker=1/Boo;
 assert(P_ext>bypassdump.medium.p_bar, "Extraction Pressure is below usage pressure",level = AssertionLevel.error);

//  eta_th=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W)/volume.heatPort.Q_flow;
//  eta_CHP=(-BOP.port_a_elec.W-BOP.pump.W-BOP.pump1.W-BOP.FWCP.W+Q_util)/volume.heatPort.Q_flow;
  Q_util = sensor_m_flow.m_flow * ( BOP.LPT1_bypass_valve.port_b.h_outflow-bypassdump1.h);

  connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
        points={{-28.945,26.05},{-28,26.05},{-28,45.1}},color={0,0,0}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{2,86},{6,86},{6,38},{10,38}},
                                               color={0,127,255}));
  connect(BOP.port_a_steam, stateSensor1.port_b) annotation (Line(points={{10,26},
          {-18,26}},                   color={0,127,255}));
  connect(stateSensor2.port_a, BOP.port_b_feed) annotation (Line(points={{-20,-10},
          {10,-10}},                 color={0,127,255}));
  connect(sensor_m_flow.port_a, BOP.port_b_bypass)
    annotation (Line(points={{2,-52},{2,8},{10,8}},     color={0,127,255}));
  connect(sensor_m_flow.port_b, bypassdump.ports[1])
    annotation (Line(points={{2,-72},{2,-76},{-20,-76}},
                                                 color={0,127,255}));
  connect(bypassdump1.ports[1], BOP.port_a_cond)
    annotation (Line(points={{86,-28},{86,0.8},{71.8,0.8}},
                                                 color={0,127,255}));
  connect(sensor_m_flow.m_flow, bypassdump1.m_flow_in) annotation (Line(points={{5.6,-62},
          {78,-62},{78,-48}},                     color={0,0,127}));
  connect(realExpression.y, bypassdump.p_in)
    annotation (Line(points={{-77,-68},{-44.2,-68}},
                                                   color={0,0,127}));
  connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{70,8},{76,
          8},{76,34},{80,34}},                      color={255,0,0}));
  connect(boundary.port, sensorW.port_b) annotation (Line(points={{88.5,17},{88,
          17},{88,22},{100,22},{100,34.16},{96,34.16}},
                             color={255,0,0}));
  connect(sensorW.W, integrator.u) annotation (Line(points={{88,41.52},{88,66.4}},
                                       color={0,0,127}));
  connect(stateDisplay1.statePort, stateSensor2.statePort) annotation (Line(
        points={{-28,-27.1},{-29.045,-27.1},{-29.045,-10.05}}, color={0,0,0}));
  connect(PHS.port_b, volume.port_a) annotation (Line(points={{-100,20.8},{-80,
          20.8},{-80,34}}, color={0,127,255}));
  connect(volume.port_b, stateSensor1.port_a) annotation (Line(points={{-80,46},
          {-80,54},{-54,54},{-54,26},{-40,26}}, color={0,127,255}));
  connect(stateSensor2.port_b, PHS.port_a) annotation (Line(points={{-38,-10},{
          -90,-10},{-90,3.2},{-100,3.2}}, color={0,127,255}));
  annotation (experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=50,
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
end NSSS_Test_b_SEC_WithVolumes;
