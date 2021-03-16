within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
model ChargingMode2

  input Real port_a_h_outflow annotation(Dialog(group="Inputs"));
  Real port_b_h_outflow = iHXShellconnector.IHX.port_b_h_outflow;
  Real port_a_m_flow = iHXShellconnector.IHX.port_a_m_flow;
  Real port_b_m_flow = iHXShellconnector.IHX.port_b_m_flow;
  input Real port_a_p annotation(Dialog(group="Inputs"));
  input Real port_b_p annotation(Dialog(group="Inputs"));

  IHXShellConnection iHXShellconnector(
    port_a_h_outflow=port_a_h_outflow,
    port_a_p=port_a_p,
    port_b_p=port_b_p)
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
  TubeandValveconnector2 tubeandValveconnector
    annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
  Modelica.Blocks.Interfaces.RealInput T_CT
    annotation (Placement(transformation(extent={{-122,44},{-100,66}})));
  Modelica.Blocks.Interfaces.RealInput Demand
    annotation (Placement(transformation(extent={{-122,72},{-100,94}})));
  Modelica.Blocks.Interfaces.RealInput m_tes2
    annotation (Placement(transformation(extent={{-122,14},{-100,36}})));
  Modelica.Blocks.Interfaces.RealOutput H_CT
    annotation (Placement(transformation(extent={{100,68},{120,88}})));
  Modelica.Blocks.Interfaces.RealOutput T_HT
    annotation (Placement(transformation(extent={{100,48},{120,68}})));
equation
  connect(iHXShellconnector.P_IHX, tubeandValveconnector.P_IHX) annotation (
      Line(points={{-44.8,4.6},{-40,4.6},{-40,9.1},{-10.9,9.1}}, color={0,0,
          127}));
  connect(tubeandValveconnector.Q_IHX, iHXShellconnector.Q_IHX) annotation (
      Line(points={{11,5},{16,5},{16,22},{-76,22},{-76,0},{-68,0}}, color={0,
          0,127}));
  connect(iHXShellconnector.mbypass, tubeandValveconnector.mbypass)
    annotation (Line(points={{-44.8,6.8},{-42,6.8},{-42,10.9},{-10.9,10.9}},
        color={0,0,127}));
  connect(tubeandValveconnector.H_CT, H_CT) annotation (Line(points={{11,16.8},
          {22,16.8},{22,78},{110,78}}, color={0,0,127}));
  connect(tubeandValveconnector.T_HT, T_HT) annotation (Line(points={{11,14},
          {26,14},{26,58},{110,58}}, color={0,0,127}));
  connect(Demand, iHXShellconnector.Reactor_Demand) annotation (Line(points={
          {-111,83},{-92,83},{-92,17.4},{-68,17.4}}, color={0,0,127}));
  connect(T_CT, tubeandValveconnector.T_CT) annotation (Line(points={{-111,55},
          {-34,55},{-34,13.7},{-10.9,13.7}}, color={0,0,127}));
  connect(m_tes2, tubeandValveconnector.m_tes2) annotation (Line(points={{
          -111,25},{-20,25},{-20,16.3},{-10.9,16.3}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ChargingMode2;
