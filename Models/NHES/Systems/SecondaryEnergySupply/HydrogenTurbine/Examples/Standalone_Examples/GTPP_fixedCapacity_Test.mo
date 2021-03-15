within NHES.Systems.SecondaryEnergySupply.HydrogenTurbine.Examples.Standalone_Examples;
model GTPP_fixedCapacity_Test
  extends Modelica.Icons.Example;

  GTPP_PowerCtrl_fixedCapacity SES(redeclare
      CS_GTPP_fixedCapacity_stepInput CS)
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  GasTurbine.Sources.PrescribedFrequency
                         elecLoad(f=60)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
equation

  connect(SES.portElec_b, elecLoad.portElec_a)
    annotation (Line(points={{30,0},{30,0},{48,0}},       color={255,0,0}));
  annotation (experiment(StopTime=80, Interval=0.1));
end GTPP_fixedCapacity_Test;
