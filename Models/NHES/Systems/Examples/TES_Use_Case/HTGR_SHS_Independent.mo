within NHES.Systems.Examples.TES_Use_Case;
model HTGR_SHS_Independent
  extends Modelica.Icons.Example;
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries
                                            BOP(nPorts_a3=1)
    annotation (Placement(transformation(extent={{56,-18},{116,42}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{168,-28},{148,-8}})));
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
    annotation (Placement(transformation(extent={{-114,-20},{-44,38}})));
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
    two_Tank_SHS_System_NTU
    annotation (Placement(transformation(extent={{-24,-90},{32,-32}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
    port_a1_nominal(
      p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
      h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
      m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
    port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p, h=
          nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h),
    nPorts_b3=1)
    annotation (Placement(transformation(extent={{-26,-20},{36,42}})));
  BalanceOfPlant.Turbine.HTGR_Rankine_Cycle hTGR_Rankine_Cycle1
    annotation (Placement(transformation(extent={{62,-90},{122,-30}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.sensor_p.p;
  connect(EM.port_a1, hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(
        points={{-26,23.4},{-34,23.4},{-34,23.21},{-45.05,23.21}}, color={0,127,
          255}));
  connect(EM.port_b1, hTGR_PebbleBed_Primary_Loop.port_a) annotation (Line(
        points={{-26,-1.4},{-26,-0.57},{-45.05,-0.57}}, color={0,127,255}));
  connect(EM.port_a2, BOP.port_b)
    annotation (Line(points={{36,-1.4},{36,0},{56,0}}, color={0,127,255}));
  connect(EM.port_b2, BOP.port_a)
    annotation (Line(points={{36,23.4},{56,24}}, color={0,127,255}));
  connect(sinkElec.port, hTGR_Rankine_Cycle1.port_e) annotation (Line(points={{
          148,-18},{136,-18},{136,-60},{122,-60}}, color={255,0,0}));
  connect(two_Tank_SHS_System_NTU.port_dch_b, hTGR_Rankine_Cycle1.port_a)
    annotation (Line(points={{32,-78.98},{52,-78.98},{52,-48},{62,-48}},
        color={0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_dch_a, hTGR_Rankine_Cycle1.port_b)
    annotation (Line(points={{31.44,-44.18},{52,-44.18},{52,-72},{62,-72}},
        color={0,127,255}));
  connect(BOP.portElec_b, hTGR_Rankine_Cycle1.port_e) annotation (Line(points={
          {116,12},{136,12},{136,-60},{122,-60}}, color={255,0,0}));
  connect(EM.port_b3[1], two_Tank_SHS_System_NTU.port_ch_a) annotation (Line(
        points={{17.4,-20},{17.4,-28},{-36,-28},{-36,-78.98},{-23.44,-78.98}},
        color={0,127,255}));
  connect(two_Tank_SHS_System_NTU.port_ch_b, BOP.port_a3[1]) annotation (Line(
        points={{-23.44,-45.34},{-52,-45.34},{-52,-102},{128,-102},{128,-26},{
          124,-26},{124,-22},{74,-22},{74,-18}}, color={0,127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
end HTGR_SHS_Independent;
