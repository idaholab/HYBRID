within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Test
  extends Modelica.Icons.Example;
  BalanceOfPlant.Turbine.HTGR_Rankine_Cycle hTGR_Rankine_Cycle
    annotation (Placement(transformation(extent={{-22,-10},{18,30}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{74,0},{54,20}})));
  Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
    annotation (Placement(transformation(extent={{-128,-18},{-58,40}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
  connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
    annotation (Line(points={{54,10},{18,10}}, color={255,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
    annotation (Line(points={{-59.05,25.21},{-59.05,18},{-22,18}}, color={0,127,
          255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, hTGR_Rankine_Cycle.port_b)
    annotation (Line(points={{-59.05,1.43},{-40.525,1.43},{-40.525,2},{-22,2}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Esdirk45a"));
end Rankine_HTGR_Test;
