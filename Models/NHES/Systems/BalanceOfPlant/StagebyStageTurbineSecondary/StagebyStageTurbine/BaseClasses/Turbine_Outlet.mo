within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
model Turbine_Outlet
  "Turbine outlet node that allows for transition back from multi-velocity port to a general fluid port. Essentially, the model kills the non-1-dimensional velocities."
  replaceable package medium = Modelica.Media.Water.StandardWater;
  parameter Boolean Vels_out = false;
  FluidFlow Turb_flow(redeclare package Medium = medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-114,-14},{-84,16}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Pipe_flow(redeclare package
      Medium =                                                                   medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput v_rout
                                                  if Vels_out annotation (Placement(transformation(
          extent={{-32,32},{8,72}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={58,-46})));
  Modelica.Blocks.Interfaces.RealOutput v_theout
                                                if Vels_out annotation (Placement(transformation(
          extent={{-32,32},{8,72}}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={56,46})));
protected
  Modelica.Blocks.Interfaces.RealInput v_rinternal;
  Modelica.Blocks.Interfaces.RealInput v_theinternal;
equation
  Pipe_flow.m_flow + Turb_flow.m_flow = 0 "Mass conservation";
  Pipe_flow.p = Turb_flow.p;
  v_rinternal = Turb_flow.v_r;
  v_theinternal = Turb_flow.v_theta;
  if
    (Turb_flow.m_flow<0) then
  Turb_flow.v_r = 0 "Assumption of no radial velocity outside of the turbine";
  Turb_flow.v_theta = 0 "Assumption of no rotational velocity outside of the turbine";
  else
    Turb_flow.v_r = inStream(Turb_flow.v_r);
    Turb_flow.v_theta = inStream(Turb_flow.v_theta);
  end if;
  Pipe_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
  Turb_flow.Xi_outflow = inStream(Pipe_flow.Xi_outflow);
  Pipe_flow.C_outflow = inStream(Turb_flow.C_outflow);
  Turb_flow.C_outflow = inStream(Pipe_flow.C_outflow);
  Turb_flow.h_outflow = inStream(Pipe_flow.h_outflow);
  Pipe_flow.h_outflow = inStream(Turb_flow.h_outflow);
  connect(v_theout, v_theinternal);
  connect(v_rout, v_rinternal);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,26},{0,-26}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{0,26},{100,-26}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Turbine_Outlet;
