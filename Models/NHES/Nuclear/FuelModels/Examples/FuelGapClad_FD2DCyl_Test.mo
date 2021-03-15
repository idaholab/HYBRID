within NHES.Nuclear.FuelModels.Examples;
model FuelGapClad_FD2DCyl_Test
  import TRANSFORM = NHES;
  extends Modelica.Icons.Example;

  FuelGapClad_FD2DCyl fuelModel(
    nRadial_fuel=5,
    nAxial=10,
    redeclare package fuelType = TRANSFORM.Media.Solids.UO2,
    redeclare package gapType = TRANSFORM.Media.Solids.Helium,
    redeclare package cladType = TRANSFORM.Media.Solids.ZrNb_E125,
    energyDynamics=system.energyDynamics,
    r_outer_fuel=0.005,
    r_outer_gap=0.0055,
    r_outer_clad=0.007,
    length=1,
    T_start_clad=[{fuelModel.T_start_gap[end, :]}; fill(
        fuelModel.Tref_clad,
        fuelModel.nRadial_clad - 2,
        fuelModel.nAxial); {fixedTemperature.T}],
    Tref_fuel=773.15,
    Tref_gap=673.15,
    Tref_clad=573.15)
    annotation (Placement(transformation(extent={{-12,-32},{52,32}})));
  Modelica.Blocks.Sources.Constant const(k=10e3)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  inner TRANSFORM.Fluid.System_TP system(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.Nuclear.PowerProfiles.GenericPowerProfile powerProfile(nNodes=
        fuelModel.nAxial)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  TRANSFORM.Thermal.Conduction.FiniteDifference.BoundaryConditions.FixedTemperature_FD
    fixedTemperature(nNodes=fuelModel.nAxial, T=300*ones(fuelModel.nAxial))
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation
  connect(powerProfile.Q_totalshaped, fuelModel.Power_in)
    annotation (Line(points={{-39,0},{-20,0},{-15.2,0}},
                                                color={0,0,127}));
  connect(const.y, powerProfile.Q_total)
    annotation (Line(points={{-79,0},{-62,0}},           color={0,0,127}));
  connect(fixedTemperature.port, fuelModel.heatPorts_b)
    annotation (Line(points={{80,0},{52.64,0},{52.64,0.32}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end FuelGapClad_FD2DCyl_Test;
