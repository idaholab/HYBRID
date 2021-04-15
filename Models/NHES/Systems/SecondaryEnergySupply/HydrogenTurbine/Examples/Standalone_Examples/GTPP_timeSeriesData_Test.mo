within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.Examples.Standalone_Examples;
model GTPP_timeSeriesData_Test
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.Hydrogen_PowerCtrl SES(
      capacity=dataCapacity.SES_capacity, redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacityScaler, delayStart=delayStart.k))
    annotation (Placement(transformation(extent={{-30,-70},{30,-10}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
  NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(
        displayUnit="MW"), SES_capacity(displayUnit="MW") = 70000000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  NHES.Systems.SupervisoryControl.InputSetpointData
                                       SC_CS(delayStart=delayStart.k)
    annotation (Placement(transformation(extent={{-30,10},{30,70}})));
  Modelica.Blocks.Sources.Constant delayStart(k=7200)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{30,-40},{30,-40},{48,-40}}, color={255,0,0}));
  connect(SES.sensorBus, SC_CS.sensorBus) annotation (Line(
      points={{-9,-10},{-9,-10},{-9,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(SES.actuatorBus, SC_CS.actuatorBus) annotation (Line(
      points={{9,-10},{9,-10},{9,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (experiment(StopTime=360000, Interval=10));
end GTPP_timeSeriesData_Test;
