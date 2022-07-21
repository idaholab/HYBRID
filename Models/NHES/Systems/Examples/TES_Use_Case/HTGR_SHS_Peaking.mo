within NHES.Systems.Examples.TES_Use_Case;
model HTGR_SHS_Peaking
  extends Modelica.Icons.Example;
  BalanceOfPlant.StagebyStageTurbineSecondary.NuScale_Modal_Secondary_Arbitrage_Ports
                                            nuScale_Modal_Secondary_Arbitrage_Ports
    annotation (Placement(transformation(extent={{-30,-22},{30,38}})));
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
    annotation (Placement(transformation(extent={{-114,-20},{-44,38}})));
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
    two_Tank_SHS_System_NTU
    annotation (Placement(transformation(extent={{52,-22},{110,36}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
    nuScale_Modal_Secondary_Arbitrage_Ports.sensor_p.p;
  connect(nuScale_Modal_Secondary_Arbitrage_Ports.SG_Return,
    hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(points={{-30.6,22.4},{
          -38.3,22.4},{-38.3,23.21},{-45.05,23.21}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a,
    nuScale_Modal_Secondary_Arbitrage_Ports.Feedwater) annotation (Line(points=
          {{-45.05,-0.57},{-36,-0.57},{-36,-8.2},{-30.6,-8.2}}, color={0,127,
          255}));
  connect(two_Tank_SHS_System_NTU.port_ch_a,
    nuScale_Modal_Secondary_Arbitrage_Ports.TBV_Send) annotation (Line(points={{52.58,
          -10.98},{38,-10.98},{38,25.4},{31.2,25.4}},      color={0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_ch_b,
    nuScale_Modal_Secondary_Arbitrage_Ports.TBV_Return) annotation (Line(points={{52.58,
          22.66},{38,22.66},{38,-8.8},{31.2,-8.8}},          color={0,127,255}));
  connect(nuScale_Modal_Secondary_Arbitrage_Ports.Arbitrage_Send,
    two_Tank_SHS_System_NTU.port_dch_a) annotation (Line(points={{-5.4,-22.6},{
          -4,-22.6},{-4,-40},{118,-40},{118,23.82},{109.42,23.82}},   color={0,
          127,255}));
  connect(two_Tank_SHS_System_NTU.port_dch_b,
    nuScale_Modal_Secondary_Arbitrage_Ports.Arbitrage_Return) annotation (Line(
        points={{110,-10.98},{116,-10.98},{116,-30},{14,-30},{14,-26},{15,-26},
          {15,-22}}, color={0,127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
end HTGR_SHS_Peaking;
