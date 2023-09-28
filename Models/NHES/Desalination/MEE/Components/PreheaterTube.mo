within NHES.Desalination.MEE.Components;
model PreheaterTube
  "Tube side of a single effect, assume the water leaves fully condensed"
  import Modelica.Fluid.Types.Dynamics;
  replaceable package Medium = Modelica.Media.Water.StandardWater;
  Medium.SaturationProperties  sat;
  Modelica.Units.SI.AbsolutePressure p;
  Modelica.Units.SI.SpecificEnthalpy h_g;
  Modelica.Units.SI.SpecificEnthalpy h_f;
  Modelica.Units.SI.SpecificEnthalpy h_in;
  Modelica.Units.SI.SpecificEnthalpy h_out;
  Modelica.Units.SI.MassFlowRate mdot;
  Modelica.Units.SI.HeatFlowRate Qhx;

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
    annotation (Placement(transformation(extent={{-10,40},{10,60}}),
        iconTransformation(extent={{-10,40},{10,60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
  redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
  redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation

  sat.psat = p;
  sat.Tsat = Medium.saturationTemperature(p);
  h_f = Medium.bubbleEnthalpy(sat);
  h_g = Medium.dewEnthalpy(sat);

  h_out=h_f;

  Liquid_Outlet_Port.p = p;
  Liquid_Outlet_Port.h_outflow=h_out;
 - mdot=Liquid_Outlet_Port.m_flow;

  Steam_Inlet_Port.p = p;
  mdot=Steam_Inlet_Port.m_flow;
  Steam_Inlet_Port.h_outflow = h_g;
  h_in =inStream(Steam_Inlet_Port.h_outflow);

  Qhx=(h_in-h_f)*mdot;
  Qhx =Heat_Port.Q_flow;

 annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,127,255}, if showColors then dynColor else {0,127,255})),
        Polygon(
          points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{
              -26,0},{-16,4},{0,20},{68,40}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,42},{90,34}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,-32},{90,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward)}),                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Heat exchanger that assumes full condensing in the tubes.  Used for preheater model</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
end PreheaterTube;
