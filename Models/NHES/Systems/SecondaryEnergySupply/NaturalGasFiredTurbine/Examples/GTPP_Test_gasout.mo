within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples;
model GTPP_Test_gasout
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                 SES(capacity=dataCapacity.SES_capacity, redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity CS(W_totalSetpoint(displayUnit
          ="MW") = 35000000))
    annotation (Placement(transformation(extent={{-30,-32},{30,28}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(redeclare package Medium = NHES.Media.FlueGas, nPorts=1)
    annotation (Placement(transformation(extent={{94,16},{74,36}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium = NHES.Media.FlueGas)
    annotation (Placement(transformation(extent={{34,32},{54,52}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{30,-2},{30,0},{48,0}},      color={255,0,0}));
  connect(SES.FlueGas_b, boundary.ports[1]) annotation (Line(points={{30,16},{68,16},{68,26},{74,26}}, color={0,127,255}));
  connect(sensor_T.port, SES.FlueGas_b) annotation (Line(points={{44,32},{44,16},{30,16}}, color={0,127,255}));
  annotation (experiment(
      StopTime=60,
      __Dymola_NumberOfIntervals=600,
      __Dymola_Algorithm="Esdirk45a"));
end GTPP_Test_gasout;
