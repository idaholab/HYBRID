within NHES.Systems.IndustrialProcess.ReverseOsmosisDesalination.Intermediate_RO;
model RO_Desal_LumpedCTRL
  extends Modelica.Icons.Example;

  NHES.Electrical.Grid        grid(
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5,
    n=1)     annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  ROplant_LumpedCTRL IP(capacity=49.8*1.5e6)
    annotation (Placement(transformation(extent={{-32,-34},{32,34}})));
equation
  connect(grid.ports[1], IP.portElec_a)
    annotation (Line(points={{48,0},{42,0},{32,0}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=400,
      __Dymola_NumberOfIntervals=400,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end RO_Desal_LumpedCTRL;
