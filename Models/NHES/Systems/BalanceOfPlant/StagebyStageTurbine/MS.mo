within NHES.Systems.BalanceOfPlant.StagebyStageTurbine;
model MS
  "Turbine outlet node that allows for transition back from multi-velocity port to a general fluid port. Essentially, the model kills the non-1-dimensional velocities."
  replaceable package Medium = Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.Volume V_MS=0.05;
  parameter Real eta = 0.99;
  parameter Modelica.Units.SI.Pressure p_start=200000;
  parameter Modelica.Units.SI.SpecificEnthalpy h_start=2000e3;

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
end MS;
