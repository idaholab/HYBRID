within NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples;
model GTPP_fixedCapacity_timeSeriesData_Test
  import NHES;
  extends Modelica.Icons.Example;

  GTPP_PowerCtrl_fixedCapacity SES(redeclare
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity
      CS(W_totalSetpoint=SC_CS.W_totalSetpoint_SES))
    annotation (Placement(transformation(extent={{-30,-70},{30,-10}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{48,-50},{68,-30}})));
  SupervisoryControl.InputSetpointData SC_CS
    annotation (Placement(transformation(extent={{-30,10},{30,70}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{30,-40},{30,-40},{48,-40}}, color={255,0,0}));
  annotation (experiment(StopTime=80, Interval=0.1));
end GTPP_fixedCapacity_timeSeriesData_Test;
