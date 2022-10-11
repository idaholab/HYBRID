within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Test_2
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Time t_extend = 300;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test_2;
