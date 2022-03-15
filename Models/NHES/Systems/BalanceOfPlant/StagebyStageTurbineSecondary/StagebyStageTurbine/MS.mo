within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine;
model MS
  "Fluid flow port compatible moisture separator. Liquid removal port is standard fluid port."
  replaceable package Medium = Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.Volume V_MS=0.05 "Moisture separator volume";
  parameter Real eta = 0.99 "Separation efficiency";
  parameter Modelica.Units.SI.Pressure p_start=200000 "Initial pressure";
  parameter Modelica.Units.SI.SpecificEnthalpy h_start=2000e3 "Initial steam mixture enthalpy";

  BaseClasses.TRANSFORMMoistureSeparator_MIKK separator(
    redeclare package Medium = Medium,
    p_start=p_start,
    use_T_start=false,
    h_start=h_start,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=V_MS),
    eta_sep=eta)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  BaseClasses.Turbine_Outlet turbine_Outlet(Vels_out=true)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  BaseClasses.Turbine_Inlet turbine_Inlet(Vels_in=true)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  BaseClasses.FluidFlow Turb_In(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  BaseClasses.FluidFlow Turb_Out(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Liquid(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}}),
        iconTransformation(extent={{-10,-42},{10,-22}})));
equation

  connect(turbine_Inlet.v_thein, turbine_Outlet.v_theout) annotation (Line(
        points={{35.6,4.6},{35.6,20},{-34.4,20},{-34.4,4.6}}, color={0,0,127}));
  connect(turbine_Outlet.v_rout, turbine_Inlet.v_rin) annotation (Line(points={{
          -34.2,-4.6},{-34.2,-22},{35.8,-22},{35.8,-4.6}}, color={0,0,127}));
  connect(separator.port_Liquid, Liquid)
    annotation (Line(points={{-2,-4},{-2,-32},{0,-32}},   color={0,127,255}));
  connect(separator.port_b, turbine_Inlet.Pipe_flow)
    annotation (Line(points={{8,0},{20,0}}, color={0,127,255}));
  connect(separator.port_a, turbine_Outlet.Pipe_flow)
    annotation (Line(points={{-4,0},{-30,0}}, color={0,127,255}));
  connect(turbine_Outlet.Turb_flow, Turb_In) annotation (Line(points={{-49.9,0.1},
          {-72.95,0.1},{-72.95,0},{-100,0}}, color={28,108,200}));
  connect(turbine_Inlet.Turb_flow, Turb_Out) annotation (Line(points={{39.9,-0.1},
          {69.95,-0.1},{69.95,0},{100,0}}, color={28,108,200}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,-12},{100,-34}},
          lineColor={28,108,200},
          fillColor={33,133,255},
          fillPattern=FillPattern.Solid),
          Rectangle(
          extent={{-100,26},{100,-12}},
          lineColor={28,108,200},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-48,-12},{48,-34}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-78,20},{70,20},{70,16},{-72,16},{-72,12},{70,12},{70,8},{
              -72,8},{-72,4},{70,4},{70,0},{-72,0},{-72,-4},{70,-4},{70,-8},{
              -72,-8}},
          color={175,175,175},
          thickness=1),
        Polygon(
          points={{-76,-8},{-70,-10},{-66,-12},{-66,-14},{-64,-12},{-60,-10},{
              -54,-10},{-52,-10},{-50,-8},{-76,-8}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-64,-16},{-66,-20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{24,16},{30,14},{34,12},{34,10},{36,12},{40,14},{46,14},{48,
              14},{50,16},{24,16}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,8},{34,4}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-18,4},{-12,2},{-8,0},{-8,-2},{-6,0},{-2,2},{4,2},{6,2},{8,4},
              {-18,4}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-4},{-8,-8}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This moisture separator portion was submitted to TRANSFORM. As of now, the author has not checked to make sure that the TRANSFORM moisture separator has been updated based on that submission (separation efficiency application was changed). The model accepts a fluid stream and diverts an assumed efficiency amount of liquid to a third port. Note: the liquid removal port&rsquo;s pressure is allowed to float due to modeling restrictions (cannot dictate m, h, and p). </p>
<p>The main function is: </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/4/msohtmlclip1/01/clip_image002.png\"/></span> </p>
</html>"));
end MS;
