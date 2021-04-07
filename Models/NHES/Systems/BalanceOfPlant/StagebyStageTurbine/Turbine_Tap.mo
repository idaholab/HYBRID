within NHES.Systems.BalanceOfPlant.StagebyStageTurbine;
model Turbine_Tap
  "Turbine outlet node that allows for transition back from multi-velocity port to a general fluid port. Essentially, the model kills the non-1-dimensional velocities."
  replaceable package medium = Modelica.Media.Water.StandardWater;
  BaseClasses.FluidFlow Turb_flow(redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-114,-14},{-84,16}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tap_flow(redeclare package Medium =  medium)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}}),
        iconTransformation(extent={{-10,-42},{10,-22}})));
  BaseClasses.FluidFlow Turb_flow2(redeclare package Medium = medium)
    annotation (Placement(transformation(extent={{92,-10},{112,10}}),
        iconTransformation(extent={{92,-10},{112,10}})));
equation
  Tap_flow.m_flow + Turb_flow.m_flow + Turb_flow2.m_flow= 0 "Mass conservation";
   Tap_flow.p = Turb_flow.p;
  Turb_flow2.p=Turb_flow.p;

  Turb_flow2.v_r = inStream(Turb_flow.v_r);
  Turb_flow.v_r = inStream(Turb_flow2.v_r);
  Turb_flow2.v_theta = inStream(Turb_flow.v_theta);
  Turb_flow.v_theta = inStream(Turb_flow2.v_theta);
  Turb_flow2.h_outflow = inStream(Turb_flow.h_outflow);
  Turb_flow2.Xi_outflow = inStream(Turb_flow.Xi_outflow);
  Turb_flow.Xi_outflow = inStream(Turb_flow2.Xi_outflow);
  Turb_flow2.C_outflow = inStream(Turb_flow.C_outflow);
  Turb_flow.C_outflow = inStream(Turb_flow2.C_outflow);
  Turb_flow.h_outflow = inStream(Turb_flow2.h_outflow);
  Tap_flow.h_outflow = inStream(Turb_flow.h_outflow);
  Tap_flow.C_outflow = inStream(Turb_flow.C_outflow);
  Tap_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,-12},{100,-34}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
          Rectangle(
          extent={{-100,26},{100,-12}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-48,-12},{48,-34}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Turbine_Tap;
