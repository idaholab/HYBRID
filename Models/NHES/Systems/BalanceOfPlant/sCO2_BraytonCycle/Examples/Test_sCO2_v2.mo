within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle.Examples;
model Test_sCO2_v2
  extends Modelica.Icons.Example;
  package Medium = ExternalMedia.Examples.CO2CoolProp;

  Brayton_Cycle_sCO2_Simple brayton_Cycle_sCO2(redeclare CS_Dummy CS, redeclare EnergyStorage.CompressedAirEnergyStorage.ED_Dummy ED)
    annotation (Placement(transformation(extent={{-32,-30},{26,28}})));
  ElectricalGrid.InfiniteGrid.Infinite EG annotation (Placement(transformation(extent={{48,-32},{92,30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=19590000,
    T=1023.15,
    nPorts=1) annotation (Placement(transformation(extent={{-82,10},{-62,30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
    p=19860000,
    T=813.05,
    nPorts=1) annotation (Placement(transformation(extent={{-82,-28},{-62,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(transformation(extent={{20,54},{40,74}})));
equation
  connect(boundary.ports[1], brayton_Cycle_sCO2.BoundaryIn) annotation (Line(points={{-62,20},{-38,20},{-38,8.28},{-32,8.28}}, color={0,127,255}));
  connect(boundary1.ports[1], brayton_Cycle_sCO2.BoundaryOut)
    annotation (Line(points={{-62,-18},{-38,-18},{-38,-6.22},{-32,-6.22}}, color={0,127,255}));
  connect(brayton_Cycle_sCO2.port_elec, EG.portElec_a) annotation (Line(points={{25.13,-0.71},{48,-1}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=1000000,
      __Dymola_NumberOfIntervals=100,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(Advanced(
        InlineMethod=0,
        InlineOrder=2,
        InlineFixedStep=0.001)));
end Test_sCO2_v2;
