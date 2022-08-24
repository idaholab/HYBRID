within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Test
  extends Modelica.Icons.Example;
  BalanceOfPlant.Turbine.HTGR_Rankine_Cycle hTGR_Rankine_Cycle(redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_Rankine_Xe100_Based_Secondary_AR
      CS)
    annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{78,2},{58,22}})));
  Components.HTGR_PebbleBed_Primary_Loop_STHX hTGR_PebbleBed_Primary_Loop(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
    annotation (Placement(transformation(extent={{-110,-18},{-40,40}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
  connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
    annotation (Line(points={{58,12},{32,12}}, color={255,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
    annotation (Line(points={{-41.05,25.21},{-42,25.21},{-42,24},{-28,24}},
                                                                   color={0,127,
          255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, hTGR_Rankine_Cycle.port_b)
    annotation (Line(points={{-41.05,1.43},{-28,0}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
end Rankine_HTGR_Test;
