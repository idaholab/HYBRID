within NHES.Systems.Examples;
model SMR_IES_CTES

  EnergyStorage.Concrete_Solid_Media.Dual_Pipe_CTES_Controlled
    dual_Pipe_CTES_Controlled(redeclare
      NHES.Systems.EnergyStorage.Concrete_Solid_Media.CS_DFV CS)
    annotation (Placement(transformation(extent={{110,-42},{204,26}})));
  PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump            Reactor(
    Q_total_th=160e6,
    Q_total_el=52e6,
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
      SG_exit_enthalpy=3000e3,
      m_setpoint=675,
      Q_nom=1,
      demand=1),
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-130,-54},{-24,42}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.NuScale_Modal_Secondary_Arbitrage_Ports
    SecSide(redeclare BalanceOfPlant.StagebyStageTurbineSecondary.CS_Modal CS,
      Q_nom=52e6)
    annotation (Placement(transformation(extent={{12,-46},{84,24}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Components.Economic_Sim_IPCO_July
                            ES
    annotation (Placement(transformation(extent={{-4,44},{42,90}})));
equation
  dual_Pipe_CTES_Controlled.External_Demand = SecSide.Demand_Internal;
  dual_Pipe_CTES_Controlled.External_Power = SecSide.generator.power;
    Reactor.Q_total.y = SecSide.Q_RX_Internal;
  SecSide.DFV_Ancticipatory_Internal = ES.Anticipatory_Signals.y;
  SecSide.Demand_Internal = ES.Net_Demand.y;

  connect(dual_Pipe_CTES_Controlled.port_charge_a, SecSide.TBV_Send)
    annotation (Line(points={{116.043,6.28},{94,6.28},{94,9.3},{85.44,9.3}},
        color={0,127,255}));
  connect(SecSide.TBV_Return, dual_Pipe_CTES_Controlled.port_charge_b)
    annotation (Line(points={{85.44,-30.6},{100,-30.6},{100,-30},{102,-30},{102,
          30},{192,30},{192,7.64},{185.2,7.64}}, color={0,127,255}));
  connect(SecSide.Arbitrage_Return, dual_Pipe_CTES_Controlled.port_discharge_b)
    annotation (Line(points={{66,-46},{66,-56},{108,-56},{108,-48},{112,-48},{
          112,-27.04},{116.043,-27.04}},
                                     color={0,127,255}));
  connect(SecSide.Arbitrage_Send, dual_Pipe_CTES_Controlled.port_discharge_a)
    annotation (Line(points={{41.52,-46.7},{41.52,-72},{220,-72},{220,-36},{
          183.186,-36},{183.186,-25.68}},
                                  color={0,127,255}));
  connect(Reactor.port_b, SecSide.SG_Return) annotation (Line(points={{-22.3692,
          7.71429},{-6.1846,7.71429},{-6.1846,5.8},{11.28,5.8}}, color={0,127,255}));
  connect(Reactor.port_a, SecSide.Feedwater) annotation (Line(points={{-22.3692,
          -14.9143},{0,-14.9143},{0,-29.9},{11.28,-29.9}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{200,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-54,-102},{146,98}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{8,60},{108,0},{8,-60},{8,60}})}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{200,100}})),
    experiment(
      StartTime=120,
      StopTime=3600,
      __Dymola_NumberOfIntervals=279,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SMR_IES_CTES;
