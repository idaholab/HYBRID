within NHES.Systems.Examples;
model SMR_Coupling_4_loop_control_FMUME
 parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
 parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
 Real demandChange=
 min(1.05,
 max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
     + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
     0.5));
  PrimaryHeatSystem.SMR_Generic.Components.SMR_Tave_enthalpy
    nuScale_Tave_enthalpy(
    port_a_nominal(
      m_flow=70,
      T(displayUnit="degC") = 421.15,
      p=3447380),
    port_b_nominal(
      T(displayUnit="degC") = 579.75,
      h=2997670,
      p=3447380),
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS(
      demand=demandChange,
      T_SG_exit=579.15,
      Q_nom=160e6))
    annotation (Placement(transformation(extent={{-102,-26},{-52,30}})));
  EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
      p=nuScale_Tave_enthalpy.port_b_nominal.p,
      h=nuScale_Tave_enthalpy.port_b_nominal.h,
      m_flow=-nuScale_Tave_enthalpy.port_b_nominal.m_flow), port_b1_nominal(p=
          nuScale_Tave_enthalpy.port_a_nominal.p, h=nuScale_Tave_enthalpy.port_a_nominal.h))
    annotation (Placement(transformation(extent={{-36,-20},{4,20}})));
  SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=1)
    annotation (Placement(transformation(extent={{104,-22},{144,22}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{160,-20},{200,20}})));
  BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
      53303300, BOP_capacity(displayUnit="MW") = 1165000000)
    annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
  Modelica.Blocks.Sources.Constant delayStart(k=0)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
    W_nominal_BOP(displayUnit="MW") = 50000000,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://NHES/Resources/Data/RAVEN/Test_timeSeries.txt"))
    annotation (Placement(transformation(extent={{160,60},{200,100}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.MassFlowToPressure
    massFlowToPressure
    annotation (Placement(transformation(extent={{14,14},{20,36}})));
  NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.PressureToMassFlow
    pressureToMassFlow
    annotation (Placement(transformation(extent={{20,-30},{14,-12}})));
  FMIs.BOP_ME_fmu
             bOP_ME_fmu(
    _BOP_Demand_start=50e6,
    _h_in_port_a_start=3e6,
    _p_in_port_a_start=5.6e6,
    _m_in_port_b_start=67,
    _h_in_port_b_start=9e5)
    annotation (Placement(transformation(extent={{38,-20},{74,16}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary(use_port=false)
    annotation (Placement(transformation(extent={{82,-60},{102,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=SC.W_totalSetpoint_BOP)
    annotation (Placement(transformation(extent={{-20,-64},{0,-44}})));
equation
  connect(nuScale_Tave_enthalpy.port_b, EM.port_a1) annotation (Line(points={{
          -51.0909,12.7692},{-46,12.7692},{-46,8},{-36,8}}, color={0,127,255}));
  connect(nuScale_Tave_enthalpy.port_a, EM.port_b1) annotation (Line(points={{
          -51.0909,-1.44615},{-46,-1.44615},{-46,-8},{-36,-8}},
                                                       color={0,127,255}));
  connect(SY.port_Grid, EG.portElec_a)
    annotation (Line(points={{144,0},{160,0}}, color={255,0,0}));
  connect(EM.port_b2, massFlowToPressure.fluidPort) annotation (Line(points={{4,
          8},{10,8},{10,25},{14,25}}, color={0,127,255}));
  connect(EM.port_a2, pressureToMassFlow.fluidPort) annotation (Line(points={{4,-8},{
          10,-8},{10,-20.9308},{13.94,-20.9308}},      color={0,127,255}));
  connect(boundary.port, SY.port_a[1]) annotation (Line(points={{102,-50},{112,
          -50},{112,-32},{98,-32},{98,0},{104,0}}, color={255,0,0}));
  connect(realExpression.y, bOP_ME_fmu.BOP_Demand) annotation (Line(points={{1,
          -54},{12,-54},{12,10.06},{37.28,10.06}}, color={0,0,127}));
  connect(massFlowToPressure.h_out, bOP_ME_fmu.h_in_port_a) annotation (Line(
        points={{20.6,19.9231},{30,19.9231},{30,4.12},{37.28,4.12}}, color={0,0,
          127}));
  connect(massFlowToPressure.p_out, bOP_ME_fmu.p_in_port_a) annotation (Line(
        points={{20.6,22.4615},{30,22.4615},{30,-2},{37.28,-2}}, color={0,0,127}));
  connect(pressureToMassFlow.m_flow_out, bOP_ME_fmu.m_in_port_b) annotation (
      Line(points={{20.6,-12.6923},{28.3,-12.6923},{28.3,-7.94},{37.28,-7.94}},
        color={0,0,127}));
  connect(pressureToMassFlow.h_out, bOP_ME_fmu.h_in_port_b) annotation (Line(
        points={{20.6,-14.7692},{28.3,-14.7692},{28.3,-13.88},{37.28,-13.88}},
        color={0,0,127}));
  connect(bOP_ME_fmu.h_out_port_b, pressureToMassFlow.h_in) annotation (Line(
        points={{75.8,-14.78},{80,-14.78},{80,-30},{26,-30},{26,-25.1538},{20.6,
          -25.1538}}, color={0,0,127}));
  connect(bOP_ME_fmu.p_out_port_b, pressureToMassFlow.p_in) annotation (Line(
        points={{75.8,-9.56},{82,-9.56},{82,-32},{26,-32},{26,-23.0769},{20.6,
          -23.0769}}, color={0,0,127}));
  connect(bOP_ME_fmu.m_flow_out_port_a, massFlowToPressure.m_flow_in)
    annotation (Line(points={{75.8,0.7},{84,0.7},{84,35.1538},{20.6,35.1538}},
        color={0,0,127}));
  connect(bOP_ME_fmu.h_out_port_a, massFlowToPressure.h_in) annotation (Line(
        points={{75.8,-4.52},{88,-4.52},{88,32.6154},{20.6,32.6154}}, color={0,
          0,127}));
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
      StopTime=18000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>NuScale style reactor system capable of load following with demand. System has a nominal thermal output of 160MWt rather than the updated 200MWt.</p>
<p>System is based upon report: <span style=\"font-family: monospace,monospace; background-color: #f9f9f9;\">Frick, Konor L.&nbsp;<i>Status Report on the NuScale Module Developed in the Modelica Framework</i>. United States: N. p., 2019. Web. doi:10.2172/1569288.</span></p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end SMR_Coupling_4_loop_control_FMUME;
