within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples.Standalone_TightlyCoupled_Examples;
model HTSE_TightlyCoupled_SteamFlowCtrl_Test
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples.Standalone_TightlyCoupled_Examples.TightlyCoupled_SteamFlowCtrl_Standalone
    IP(
    capacityScaler=1.5,
    port_a_nominal(m_flow=IP.capacityScaler*9.0942),
    port_b_nominal(p=6270000, T=488.896))
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    nPorts=1,
    p=5800000,
    T=591.15)
    annotation (Placement(transformation(extent={{-80,6},{-62,24}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=6270000,
    T=488.896) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-71,-16})));
  Modelica.Blocks.Sources.Ramp We_set(
    duration=0,
    startTime=100,
    height=IP.capacityScaler*(-1.929*1e6*5*1 + 310530*0 + 454300*1 + 108120*0
         - 1254074*0),
    offset=IP.capacityScaler*(9.10627*1e6*5 + 5613820))
    annotation (Placement(transformation(extent={{100,30},{80,50}})));
  NHES.Electrolysis.Sources.PrescribedPowerFlow prescribedPowerFlow
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,20})));
  Electrical.parallelElecPower nElecFlow(nParallel=IP.capacityScaler)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,0})));
equation
  connect(heatingMedium_in.ports[1], IP.port_a) annotation (Line(points={{-62,
          15},{-62,16},{-40,16}}, color={0,127,255}));
  connect(We_set.y, prescribedPowerFlow.P_flow)
    annotation (Line(points={{79,40},{70,40},{70,28}},   color={0,0,127}));
  connect(heatingMedium_out.ports[1], IP.port_b) annotation (Line(points={{-62,
          -16},{-62,-16},{-40,-16}}, color={0,127,255}));
  connect(nElecFlow.singleFlow, prescribedPowerFlow.port_b)
    annotation (Line(points={{70,0},{70,10}},    color={255,0,0}));
  connect(nElecFlow.parallelFlow, IP.portElec_a)
    annotation (Line(points={{50,0},{45,0},{40,0}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=6100, Interval=1),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_TightlyCoupled_SteamFlowCtrl_Test;
