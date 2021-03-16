within NHES.HydrogenTurbine.Examples;
model H2_powerCtrl_Test
  extends Modelica.Icons.Example;

  PowerPlant.H2_powerCtrl GTPP "Natural-gas fired gas turbine power plant"
    annotation (Placement(transformation(extent={{-30,-80},{30,-20}})));
    Sources.PrescribedFrequency prescribedFrequency(f=60)
    annotation (Placement(transformation(extent={{40,-62},{64,-38}})));
    Controllers.CS_GTPP_closed CS
    annotation (Placement(transformation(extent={{-30,20},{30,80}})));
equation
    connect(prescribedFrequency.portElec_a, GTPP.portElec_b) annotation (Line(
          points={{40,-50},{40,-50},{30,-50}}, color={255,0,0}));
    connect(GTPP.signalBus, CS.signalBus) annotation (Line(
        points={{0,-20},{0,0},{0,20}},
        color={255,204,51},
        thickness=0.5));
  annotation (
    experiment(StopTime=80, Interval=0.1),
    experimentSetupOutput,
    Documentation(info="<html>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end H2_powerCtrl_Test;
