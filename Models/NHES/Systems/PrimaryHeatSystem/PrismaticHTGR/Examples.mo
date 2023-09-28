within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model Subchannel_Test
     extends Modelica.Icons.Example;
    PrismaticHTGR.Components.Subchannel subchannel(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      m_flow=0.5,
      T=773.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare package
                Medium =
                 Modelica.Media.IdealGases.SingleGases.He, nPorts=1)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=10000)
      annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
  equation
    connect(boundary.ports[1], subchannel.port_a)
      annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
    connect(subchannel.port_b, boundary1.ports[1])
      annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
    connect(realExpression.y, subchannel.PowerIn)
      annotation (Line(points={{-49,28},{-28,28}},         color={0,0,127}));
    annotation (experiment(
        StopTime=10000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end Subchannel_Test;

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

  model Reactor_Test_posControl
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    Reactor_pos RX(redeclare replaceable CS.CS_Texit_posControl CS)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Test_posControl;

  model Reactor_Test_speedControl
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    Reactor_speed RX(redeclare replaceable CS.CS_Texit_speedControl CS,
        controlRod(Pos(start=0.75, fixed=true)))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Test_speedControl;
end Examples;
