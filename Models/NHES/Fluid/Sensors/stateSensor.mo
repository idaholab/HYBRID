within NHES.Fluid.Sensors;
model stateSensor
  "fluid data sensor - should be connected to MultiDisplayPanel to visualization of fluid state parameters"

  extends Modelica.Fluid.Interfaces.PartialTwoPort(final showDesignFlowDirection=false);

  parameter Boolean use_Display = true "true to enable display panel";

  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{10,9},{30,29}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{10,-31},{30,-11}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-29,-30},{-9,-10}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-30,9},{-10,29}})));

  NHES.Fluid.Sensors.BaseClasses.statePort statePort annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}),
        iconTransformation(extent={{-5,-5},{6,6}})));

equation
connect(pressure.port,port_a);
connect(temperature.port,port_a);
connect(port_a,massFlowRate.port_a);
connect(massFlowRate.port_b,port_b);
connect(specificEnthalpy.port,port_a);

// connect(statePort.p,pressure.p);
// connect(statePort.T,temperature.T);
// connect(statePort.m_flow,massFlowRate.m_flow);
// connect(statePort.h_out,specificEnthalpy.h_out);

statePort.p=pressure.p;
statePort.T=temperature.T;
statePort.m_flow=massFlowRate.m_flow;
statePort.h_out=specificEnthalpy.h_out;

  annotation (
        Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Polygon(points={{-70,0},{-70,0}}, lineColor={28,108,200}),
        Line(
          points={{-100,0},{100,0}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{40,0},{-40,30},{-40,-30},{40,0}},
          fillPattern=FillPattern.Sphere,
          fillColor={28,108,200},
          pattern=LinePattern.None)}),      Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1})));
end stateSensor;
