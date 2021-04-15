within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.Examples.ReversingFlow.FMUTests;
model FlowReversalCS
  "Example model demonstrating correct functioning of fmu adaptors including at flow reversal"
  extends Modelica.Icons.Example;
  //Define medium with multiple substances and trace constituents so that X and C are retained on connector
  replaceable package Medium=Modelica.Media.Air.MoistAir(extraPropertiesNames={"CO2"},
                                             C_nominal={1.519E-3});

  Modelica.Fluid.Sources.Boundary_pT pressure_sink(
    redeclare package Medium = Medium,
    p=100000,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-8,-9},{8,9}},
        rotation=180,
        origin={92,-1})));
 MassFlowToPressure                                        massFlowToPressure(redeclare
      package Medium = Medium)                                     annotation (
      Placement(transformation(
        extent={{-10,-26},{10,26}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Sources.Sine p_source(
    amplitude=0.1e5,
    f=1,
    offset=1e5)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant T_source(k=293.15)
    annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  FlowReversal_CS_fmu
                  CS_fmu
    annotation (Placement(transformation(extent={{-32,6},{-8,30}})));
equation

  connect(massFlowToPressure.fluidPort, pressure_sink.ports[1])
    annotation (Line(points={{80,0},{80,-1},{84,-1}},        color={0,0,0}));
  connect(T_source.y, CS_fmu.T_source) annotation (Line(points={{-61,50},{-62,
          50},{-62,26.64},{-32.48,26.64}}, color={0,0,127}));
  connect(p_source.y, CS_fmu.p_source) annotation (Line(points={{-79,50},{-66,
          50},{-66,23.16},{-32.48,23.16}}, color={0,0,127}));
  connect(massFlowToPressure.C_out[1], CS_fmu.C_in_1_) annotation (Line(points=
          {{58,24},{18,24},{18,-4},{-36,-4},{-36,19.8},{-32.48,19.8}}, color={0,
          0,127}));
  connect(massFlowToPressure.X_out[1], CS_fmu.X_in_1_) annotation (Line(points=
          {{58,18},{22,18},{22,-8},{-42,-8},{-42,16.32},{-32.48,16.32}}, color=
          {0,0,127}));
  connect(massFlowToPressure.h_out, CS_fmu.h_in) annotation (Line(points={{58,
          12},{28,12},{28,-12},{-46,-12},{-46,12.96},{-32.48,12.96}}, color={0,
          0,127}));
  connect(massFlowToPressure.p_out, CS_fmu.p_in) annotation (Line(points={{58,6},
          {32,6},{32,-14},{-50,-14},{-50,9.48},{-32.48,9.48}}, color={0,0,127}));
  connect(CS_fmu.C_out_1_, massFlowToPressure.C_in[1]) annotation (Line(points={{-5.6,
          26.04},{12,26.04},{12,-16},{40,-16},{40,-6},{58,-6}},        color={0,
          0,127}));
  connect(CS_fmu.X_out_1_, massFlowToPressure.X_in[1]) annotation (Line(points={{-5.6,
          22.08},{8,22.08},{8,-22},{42,-22},{42,-12},{58,-12}},        color={0,
          0,127}));
  connect(CS_fmu.h_out, massFlowToPressure.h_in) annotation (Line(points={{-5.6,18},
          {4,18},{4,-26},{46,-26},{46,-18},{58,-18}},     color={0,0,127}));
  connect(CS_fmu.m_flow_out, massFlowToPressure.m_flow_in) annotation (Line(
        points={{-5.6,14.04},{-2,14.04},{-2,-30},{50,-30},{50,-24},{58,-24}},
                          color={0,0,127}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-05,
      __Dymola_Algorithm="Cvode"), Documentation(info="", revisions="<html>
<!--COPYRIGHT-->
</html>"),
    Diagram(coordinateSystem(extent={{-100,-40},{100,60}})),
    Icon(coordinateSystem(extent={{-100,-40},{100,60}})));
end FlowReversalCS;
