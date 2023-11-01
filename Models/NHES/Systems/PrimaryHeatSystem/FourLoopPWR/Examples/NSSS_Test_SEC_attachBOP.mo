within NHES.Systems.PrimaryHeatSystem.FourLoopPWR.Examples;
model NSSS_Test_SEC_attachBOP
  import TRANSFORM;
  extends TRANSFORM.Icons.Example;

  BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HPOFWHsimplified_sec
    steamTurbine_L3_HPOFWHsimplified_sec
    annotation (Placement(transformation(extent={{48,-10},{94,40}})));
  parameter Real P_ext=1.6;
  parameter Real P_demand=1;
  parameter Modelica.Units.SI.Density d_ext=1.004547784   "kg/m3";

  parameter Modelica.Units.SI.MassFlowRate m_ext=0;
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{-5.5,-7.5},{5.5,7.5}},
        rotation=90,
        origin={196.5,-4.5})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                 bypassdump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=4,
    h=192e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={194,-54})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={196,60})));
  Electrical.PowerSensor      sensorW
    annotation (Placement(transformation(extent={{188,26},{204,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-18,-76},{4,-56}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={26,-52})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=P_demand*100000)
    annotation (Placement(transformation(extent={{-74,-68},{-54,-48}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=1000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{8,66},{28,86}})));
  Fluid.Sensors.stateSensor      stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-40,20},{-18,40}})));
  Fluid.Sensors.stateSensor      stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-20,4},{-38,-16}})));
  Fluid.Sensors.stateDisplay      stateDisplay2
    annotation (Placement(transformation(extent={{-48,38},{-8,68}})));
  Fluid.Sensors.stateDisplay      stateDisplay1
    annotation (Placement(transformation(extent={{-48,-12},{-8,-42}})));
  BalanceOfPlant.RankineCycle.Data.Data_4Turbines              data(
    Power_nom=3.1e9,
    HPT_p_in=7340000,
    p_dump=15500000,
    p_i1=990000,
    p_i2=390000,
    Tin=565.15,
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
    p_use=P_demand*100000,
    eta_t=0.93,
    eta_mech=1,
    eta_p=0.9)
    annotation (Placement(transformation(extent={{-100,84},{-80,104}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=7340000,
    T_start=565.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    use_HeatPort=true,
    Q_gen(displayUnit="MW"))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-56,18})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(dp0=310)
    annotation (Placement(transformation(
        extent={{-5,-8},{5,8}},
        rotation=90,
        origin={-56,3})));
  Modelica.Blocks.Sources.Constant T_steam(k=data.Tin)
    annotation (Placement(transformation(extent={{-98,12},{-86,24}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow
    boundary1(Q_flow=3.1e9)
    annotation (Placement(transformation(extent={{-80,12},{-68,24}})));
equation
  connect(sensor_m_flow.m_flow,bypassdump1. m_flow_in) annotation (Line(points={{29.6,
          -52},{178,-52},{178,-64},{186,-64}},    color={0,0,127}));
  connect(boundary.port,sensorW. port_b) annotation (Line(points={{196.5,1},{196,
          1},{196,6},{208,6},{208,18.16},{204,18.16}},
                             color={255,0,0}));
  connect(sensorW.W,integrator. u) annotation (Line(points={{196,25.52},{196,50.4}},
                                       color={0,0,127}));
  connect(sensorW.port_a, steamTurbine_L3_HPOFWHsimplified_sec.port_a_elec)
    annotation (Line(points={{188,18},{102,18},{102,15},{94,15}}, color={255,0,0}));
  connect(bypassdump1.ports[1], steamTurbine_L3_HPOFWHsimplified_sec.port_a_cond)
    annotation (Line(points={{194,-44},{194,-14},{104,-14},{104,9},{95.38,9}},
        color={0,127,255}));
  connect(sensor_m_flow.port_b,bypassdump. ports[1])
    annotation (Line(points={{26,-62},{26,-66},{4,-66}},
                                                 color={0,127,255}));
  connect(sensor_m_flow.m_flow, bypassdump1.m_flow_in) annotation (Line(points={{29.6,
          -52},{178,-52},{178,-64},{186,-64}},    color={0,0,127}));
  connect(realExpression.y,bypassdump. p_in)
    annotation (Line(points={{-53,-58},{-20.2,-58}},
                                                   color={0,0,127}));
  connect(sensor_m_flow.port_a, steamTurbine_L3_HPOFWHsimplified_sec.port_b_bypass)
    annotation (Line(points={{26,-42},{26,15},{48,15}}, color={0,127,255}));
  connect(steamdump.ports[1], steamTurbine_L3_HPOFWHsimplified_sec.prt_b_steamdump)
    annotation (Line(points={{28,76},{40,76},{40,40},{48,40}}, color={0,127,255}));
  connect(stateSensor1.statePort,stateDisplay2. statePort) annotation (Line(
        points={{-28.945,30.05},{-28.945,39.575},{-28,39.575},{-28,49.1}},
                                                        color={0,0,0}));
  connect(stateSensor2.port_b,resistance. port_a) annotation (Line(points={{-38,-6},
          {-56,-6},{-56,-0.5}},                      color={0,127,255}));
  connect(resistance.port_b,volume. port_a)
    annotation (Line(points={{-56,6.5},{-56,12}},
                                                color={0,127,255}));
  connect(volume.port_b,stateSensor1. port_a)
    annotation (Line(points={{-56,24},{-56,30},{-40,30}}, color={0,127,255}));
  connect(boundary1.port,volume. heatPort)
    annotation (Line(points={{-68,18},{-62,18}}, color={191,0,0}));
  connect(stateDisplay1.statePort,stateSensor2. statePort) annotation (Line(
        points={{-28,-23.1},{-29.045,-23.1},{-29.045,-6.05}},  color={0,0,0}));
  connect(stateSensor2.port_a, steamTurbine_L3_HPOFWHsimplified_sec.port_b_feed)
    annotation (Line(points={{-20,-6},{38,-6},{38,0},{48,0}}, color={0,127,255}));
  connect(stateSensor1.port_b, steamTurbine_L3_HPOFWHsimplified_sec.port_a_steam)
    annotation (Line(points={{-18,30},{48,30}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=250,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p>This example is showing the initialization of the 4 loop PWR reactor. Nominal Power is </p>
</html>"));
end NSSS_Test_SEC_attachBOP;
