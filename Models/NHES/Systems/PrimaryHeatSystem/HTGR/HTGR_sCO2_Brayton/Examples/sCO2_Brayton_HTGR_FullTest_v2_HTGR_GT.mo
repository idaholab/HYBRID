within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_sCO2_Brayton.Examples;
model sCO2_Brayton_HTGR_FullTest_v2_HTGR_GT
  extends Modelica.Icons.Example;
  Components.sCO2_PrimaryLoop_Pressurized_v2
                                          PrimaryLoop annotation (Placement(transformation(extent={{-80,-12},{-36,26}})));
  BalanceOfPlant.sCO2_BraytonCycle.Brayton_Cycle_sCO2_ElecPort BOP annotation (Placement(transformation(extent={{-14,-12},{24,28}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{74,-3},{51,20}})));
  Real efficiency;
equation
  efficiency = (BOP.Turbine.Wt - BOP.Comp1.Wc - BOP.Comp2.Wc)/PrimaryLoop.core.Q_total.y;

  connect(PrimaryLoop.port_b, BOP.BoundaryIn) annotation (Line(points={{-36.66,16.31},{-22,16.31},{-22,14.4},{-17.8,14.4}}, color={0,127,255}));
  connect(PrimaryLoop.port_a, BOP.BoundaryOut) annotation (Line(points={{-36.66,0.73},{-22,0.73},{-22,4.4},{-17.8,4.4}}, color={0,127,255}));
  connect(BOP.port_elec, sinkElec.port) annotation (Line(points={{23.43,8.2},{50,8.2},{50,8.5},{51,8.5}}, color={255,0,0}));
  annotation (experiment(
      StopTime=1e6,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Simple_Rankine. The simulation should be moving towards steady state operation using the control system to meet exit core temperature of 850C. </p>
<p><br>The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"));
end sCO2_Brayton_HTGR_FullTest_v2_HTGR_GT;
