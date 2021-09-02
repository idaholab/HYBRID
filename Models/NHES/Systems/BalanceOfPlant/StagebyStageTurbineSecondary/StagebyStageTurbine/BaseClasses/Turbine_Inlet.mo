within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
model Turbine_Inlet
  "Turbine inlet node that allows for a general fluid flow port to transition into the multi-velocity port useful for internal turbine modeling."
  replaceable package medium = Modelica.Media.Water.StandardWater;
  flow Modelica.Units.SI.MassFlowRate mdot;
  parameter Boolean Vels_in = false;
  FluidFlow Turb_flow(redeclare package Medium = medium) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={
            {84,-16},{114,14}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Pipe_flow(redeclare package
      Medium =                                                                   medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput v_rin if Vels_in annotation (Placement(transformation(
          extent={{-32,32},{8,72}}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={58,-46})));
  Modelica.Blocks.Interfaces.RealInput v_thein if Vels_in annotation (Placement(transformation(
          extent={{-32,32},{8,72}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={56,46})));
protected
  Modelica.Blocks.Interfaces.RealInput v_rinternal;
  Modelica.Blocks.Interfaces.RealInput v_theinternal;
equation
  Pipe_flow.m_flow + Turb_flow.m_flow = 0 "Mass conservation";
  mdot=Pipe_flow.m_flow;
  if not Vels_in then
    v_rinternal = 0;
    v_theinternal = 0;
  end if;
  if
    (Turb_flow.m_flow<0 and not Vels_in) then
  Turb_flow.v_r = 0 "Assumption of no radial velocity outside of the turbine";
  Turb_flow.v_theta = 0 "Assumption of no rotational velocity outside of the turbine";
  elseif
        (Turb_flow.m_flow>0) then
    Turb_flow.v_r = inStream(Turb_flow.v_r);
    Turb_flow.v_theta = inStream(Turb_flow.v_theta);
  else
    Turb_flow.v_r = v_rinternal;
    Turb_flow.v_theta=v_theinternal;
  end if;
  Turb_flow.p = Pipe_flow.p;
  Pipe_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
  Turb_flow.Xi_outflow = inStream(Pipe_flow.Xi_outflow);
  Pipe_flow.C_outflow = inStream(Turb_flow.C_outflow);
  Turb_flow.C_outflow = inStream(Pipe_flow.C_outflow);
  Turb_flow.h_outflow = inStream(Pipe_flow.h_outflow);
  Pipe_flow.h_outflow = inStream(Turb_flow.h_outflow);
  connect(v_rin,v_rinternal);
  connect(v_thein,v_theinternal);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,26},{0,-26}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{0,26},{100,-26}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Turbine_Inlet;
