within ModelicaPyUnitTest.Examples;
model EmptyTanks "Show the treatment of empty tanks"
  extends Modelica.Icons.Example;
  Modelica.Fluid.Vessels.OpenTank tank1(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=1,
    crossArea=1,
    level_start=1,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.1)},
    height=1.1)             annotation (Placement(transformation(extent={{-40,20},
            {0,60}},      rotation=0)));

  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    length=1,
    diameter=0.1,
    height_ab=-1)
                 annotation (Placement(transformation(
        origin={-20,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Fluid.Vessels.OpenTank tank2(
    crossArea=1,
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    nPorts=1,
    height=1.1,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter=
        0.1, height=0.5)},
    level_start=1.0e-10)
    annotation (Placement(transformation(extent={{0,-80},{40,-40}},
          rotation=0)));
  inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                   annotation (Placement(transformation(
          extent={{60,60},{80,80}}, rotation=0)));
equation
  connect(tank1.ports[1], pipe.port_a) annotation (Line(
      points={{-20,20},{-20,5},{-20,-10},{-20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_b, tank2.ports[1]) annotation (Line(
      points={{-20,-30},{-20,-60},{0,-60},{0,-80},{20,-80}},
      color={0,127,255},
      smooth=Smooth.None));

  annotation (
    experiment(StopTime=50),
    __Dymola_Commands(file="modelica://Modelica/Resources/Scripts/Dymola/Fluid/EmptyTanks/plot level and port.p.mos"
        "plot level and port.p"),
    Documentation(info="<html>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/EmptyTanks.png\" border=\"1\"
     alt=\"EmptyTanks.png\">
</html>"));
end EmptyTanks;
