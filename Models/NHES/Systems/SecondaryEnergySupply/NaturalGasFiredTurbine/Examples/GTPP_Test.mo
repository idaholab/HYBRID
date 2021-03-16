within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples;
model GTPP_Test
  import NHES;
  extends Modelica.Icons.Example;

  GTPP_PowerCtrl SES(capacity=dataCapacity.SES_capacity, redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP_stepInput
      CS(capacityScaler=SES.capacityScaler))
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
        displayUnit="MW"), SES_capacity(displayUnit="MW") = 70000000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{30,0},{30,0},{48,0}},       color={255,0,0}));
  annotation (experiment(
      StopTime=60,
      __Dymola_NumberOfIntervals=600,
      __Dymola_Algorithm="Esdirk45a"));
end GTPP_Test;
