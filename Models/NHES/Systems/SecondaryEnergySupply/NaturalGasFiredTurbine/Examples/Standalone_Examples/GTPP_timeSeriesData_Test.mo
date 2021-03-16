within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples;
model GTPP_timeSeriesData_Test
  import NHES;
  extends Modelica.Icons.Example;

  GTPP_PowerCtrl SES(capacity=dataCapacity.SES_capacity, redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP CS(
        capacityScaler=SES.capacity, W_totalSetpoint=SC_CS.W_totalSetpoint_SES))
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
  annotation (experiment(StopTime=360000, Interval=10));
end GTPP_timeSeriesData_Test;
