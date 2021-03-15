within NHES.Utilities.FMI_Templates.Adaptors.MSLFluidAdaptors.Examples.ReversingFlow.FMUTests;
model FlowReversalME
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
  FlowReversal_ME_fmu
                  ME_fmu
    annotation (Placement(transformation(extent={{-36,2},{-16,22}})));
equation

  connect(massFlowToPressure.fluidPort, pressure_sink.ports[1])
    annotation (Line(points={{80,0},{80,-1},{84,-1}},        color={0,0,0}));
  connect(T_source.y, ME_fmu.T_source) annotation (Line(points={{-61,50},{-62,
          50},{-62,19.2},{-36.4,19.2}}, color={0,0,127}));
  connect(p_source.y, ME_fmu.p_source) annotation (Line(points={{-79,50},{-70,
          50},{-70,16.3},{-36.4,16.3}}, color={0,0,127}));
  connect(ME_fmu.C_in_1_, massFlowToPressure.C_out[1]) annotation (Line(points=
          {{-36.4,13.5},{-40,13.5},{-40,-6},{-2,-6},{-2,24},{58,24}}, color={0,
          0,127}));
  connect(massFlowToPressure.X_out[1], ME_fmu.X_in_1_) annotation (Line(points=
          {{58,18},{4,18},{4,-10},{-48,-10},{-48,10.6},{-36.4,10.6}}, color={0,
          0,127}));
  connect(massFlowToPressure.h_out, ME_fmu.h_in) annotation (Line(points={{58,
          12},{10,12},{10,-16},{-54,-16},{-54,7.8},{-36.4,7.8}}, color={0,0,127}));
  connect(massFlowToPressure.p_out, ME_fmu.p_in) annotation (Line(points={{58,6},
          {16,6},{16,-22},{-58,-22},{-58,4.9},{-36.4,4.9}}, color={0,0,127}));
  connect(ME_fmu.C_out_1_, massFlowToPressure.C_in[1]) annotation (Line(points={{-14,
          18.7},{-10,18.7},{-10,18},{-4,18},{-4,-24},{38,-24},{38,-6},{58,-6}},
                color={0,0,127}));
  connect(ME_fmu.X_out_1_, massFlowToPressure.X_in[1]) annotation (Line(points={{-14,
          15.4},{-6,15.4},{-6,-26},{42,-26},{42,-12},{58,-12}},       color={0,
          0,127}));
  connect(ME_fmu.h_out, massFlowToPressure.h_in) annotation (Line(points={{-14,12},
          {-8,12},{-8,-32},{46,-32},{46,-18},{58,-18}},     color={0,0,127}));
  connect(ME_fmu.m_flow_out, massFlowToPressure.m_flow_in) annotation (Line(
        points={{-14,8.7},{-10,8.7},{-10,-36},{50,-36},{50,-24},{58,-24}},
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
end FlowReversalME;
