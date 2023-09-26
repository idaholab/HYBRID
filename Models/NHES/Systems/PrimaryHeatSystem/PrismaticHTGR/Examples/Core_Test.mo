within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Examples;
model Core_Test
   extends Modelica.Icons.Example;
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.He,
    m_flow=8.75,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare package
              Medium =
               Modelica.Media.IdealGases.SingleGases.He,
    p=3000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Components.Core core(
    Fr=0.5,
    Q_nominal=1.5e7,
    rho_input=0.05,
    Fp=1.1,
    T_Fouter_start=1173.15,
    T_Finner_start=1273.15,
    T_Mod_start=1073.15,
    T_Cinlet_start=773.15,
    T_Coutlet_start=1073.15)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(core.port_b, boundary1.ports[1])
    annotation (Line(points={{20,0},{80,0}}, color={0,127,255}));
  connect(boundary.ports[1], core.port_a)
    annotation (Line(points={{-80,0},{-20,0}}, color={0,127,255}));
  annotation (experiment(
      StopTime=1000000,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"));
end Core_Test;
