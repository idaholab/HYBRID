within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples;
model GTPPGE_Test "gas exit test"
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                 SES(capacity=35000000, redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
      delayStart=1,
      W_SES_nom=30000000,
      W_totalSetpoint(displayUnit="MW") = 30000000))
    annotation (Placement(transformation(extent={{-170,-62},{-110,-2}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{-90,-44},{-70,-24}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
        NHES.Media.FlueGas)
    annotation (Placement(transformation(extent={{-100,2},{-80,22}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{-110,-32},{-108,-32},{-108,-34},{-90,-34}},
                                                          color={255,0,0}));
  connect(sensor_T.port, SES.FlueGas_b) annotation (Line(points={{-90,2},{-90,
          -14},{-110,-14}}, color={0,127,255}));
  annotation (experiment(
      StopTime=60,
      __Dymola_NumberOfIntervals=600,
      __Dymola_Algorithm="Esdirk45a"));
end GTPPGE_Test;
