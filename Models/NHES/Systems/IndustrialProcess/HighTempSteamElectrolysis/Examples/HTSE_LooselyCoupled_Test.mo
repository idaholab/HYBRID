within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples;
model HTSE_LooselyCoupled_Test
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.LooselyCoupled IP(
                                         redeclare
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_LooselyCoupled_stepInput
      CS(capacityScaler=IP.capacityScaler), capacity=100000000)
    annotation (Placement(transformation(extent={{-32,-34},{32,34}})));

  NHES.Electrical.Grid        grid(
                     n=1,
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5)
             annotation (Placement(transformation(extent={{48,-10},{68,10}})));
equation
  connect(IP.portElec_a, grid.ports[1])
    annotation (Line(points={{32,0},{48,0}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=4000,
      __Dymola_NumberOfIntervals=4000,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_LooselyCoupled_Test;
