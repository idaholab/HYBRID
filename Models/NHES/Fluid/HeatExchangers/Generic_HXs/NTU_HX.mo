within NHES.Fluid.HeatExchangers.Generic_HXs;
model NTU_HX
  "Calculates Q as an internal heat generation in a control volume, as a source on one side and a sink on the other. This model allows both for flow reversal and for single phase flow on either or both sides of the HX."
  import Modelica.Units.SI.*;
  import NHES;

  Modelica.Units.SI.Power Q
    "Power source/sink in each of the heat transfer volumes";
  Modelica.Units.SI.Power Q_total "Total actual HX power";
  Modelica.Units.SI.Power Q_max "Minimum of Q_max_s and Q_max_t";
  Modelica.Units.SI.Power Q_max_s
    "Max Q of shell side assuming reaches inlet tube temperature";
  Modelica.Units.SI.Power Q_max_t
    "Max Q of tube side assuming reaches inlet shell temperature";
  Modelica.Units.SI.Power Q_min "This value is used in Cr calculations";
  Real Cr(start = Cr_init) "Mass*heatcapacity ratio of the HX, minimum divided by maximum. In this model, it's calculated using massflow*deltaEnthalpy";
  parameter Real NTU = 4 "Characteristic NTU of HX" annotation(Dialog(tab="General", group="Sizing"));
  parameter Real K_tube(unit = "1/m4") "Pressure loss coefficient. Units make this value equal to a typical local loss coefficient divided by the flow area squared.";
  parameter Real K_shell(unit = "1/m4") "Same as K_tube but for the shell side.";
  replaceable package Tube_medium = Modelica.Media.Water.StandardWater annotation(Dialog(tab="General", group="Mediums", allMatchingChoices=true));
  replaceable package Shell_medium = Modelica.Media.Water.StandardWater annotation(Dialog(tab="General", group="Mediums", allMatchingChoices=true));
  parameter Modelica.Units.SI.Volume V_Tube=0.1 "Total tube-side volume"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Volume V_Shell=0.1 "Total shell-side volume"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Volume V_buffers=0.1 "Volume of buffers"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Length dh_Tube=0.0
    "Total tube-side change in height"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Length dh_Shell=0.0
    "Total shell-side change in height"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Pressure p_start_tube=101325 "Initial tube pressure"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_inlet=200e3 "Initial tube inlet enthalpy"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_outlet=500e3 "initial tube outlet enthalpy"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.Pressure p_start_shell=1013250 "Initial shell pressure"
    annotation (Dialog(tab="Initialization", group="Shell"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_inlet=1600e3  "Initial shell inlet enthalpy"
    annotation (Dialog(tab="Initialization", group="Shell"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_outlet=600e3 "Initial shell outlet enthalpy"
    annotation (Dialog(tab="Initialization", group="Shell"));
  parameter Modelica.Units.SI.Pressure dp_init_tube=500000 "Initial pressure drop tube side"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.Pressure dp_init_shell=10000 "Initial pressure drop shell side"
    annotation (Dialog(tab="Initialization", group="Shell"));
  parameter Modelica.Units.SI.Pressure dp_general=100 "Initialization pressure drop calculation"
    annotation (Dialog(tab="Initialization", group="Both"));
  parameter Modelica.Units.SI.Power Q_init=0 "Initial heat rate";
  parameter Real Cr_init = 0.0 "Initial heat capacity ratio" annotation(Dialog(tab = "Initialization", group = "Heat Transfer"));
  parameter Real deltaX_t_init = 0.0 "Initial quality change on tube side" annotation(Dialog(tab = "Initialization", group = "Heat Transfer"));
  parameter Real deltaX_s_init = 0.5 "Initial quality change on shell side" annotation(Dialog(tab = "Initialization", group = "Heat Transfer"));
  parameter Modelica.Units.SI.Time tau=1 "Power time constant, used to make the matrix easier to solve.";

  parameter Modelica.Units.SI.MassFlowRate m_start_tube=66.3 "Initial tube mass flow rate"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.MassFlowRate m_start_shell=10 "Initial shell mass flow rate"
    annotation (Dialog(tab="Initialization", group="Shell"));
  Real xchange_t(start = deltaX_t_init) "Change in quality on the tube side";
  Real xchange_s(start = deltaX_s_init) "Change in quality on the shell side";

  Modelica.Units.SI.Temperature Tin_t
    "Inlet temperature based on mass flow direction at midpoint of NTUHX";
  Modelica.Units.SI.Temperature Tin_s
    "Inlet shell temp based on mass flow direction at midpoint of NTUHX";
  Modelica.Units.SI.Temperature Tex_t;
  Modelica.Units.SI.Temperature Tex_s;
  Modelica.Units.SI.SpecificEnthalpy hin_t;
  Modelica.Units.SI.SpecificEnthalpy hin_s;
  Modelica.Units.SI.SpecificEnthalpy hex_t;
  Modelica.Units.SI.SpecificEnthalpy hex_s;
  Modelica.Units.SI.SpecificEnthalpy hf_t;
  Modelica.Units.SI.SpecificEnthalpy hf_s;
  Modelica.Units.SI.SpecificEnthalpy hg_t;
  Modelica.Units.SI.SpecificEnthalpy hg_s;
public
  TRANSFORM.Fluid.Volumes.MixingVolume Tube(
    redeclare package Medium = Tube_medium,
    p_start=p_start_tube - dp_general,
    use_T_start=false,
    h_start=0.5*h_start_tube_inlet + 0.5*h_start_tube_outlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (
        V=V_Tube/2,
        angle=0,
        dheight=dh_Tube/2),
    use_HeatPort=false,
    Q_gen=Q,
    nPorts_b=1,
    nPorts_a=1) annotation (Placement(transformation(extent={{28,30},{48,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_out(redeclare package Medium =
        Tube_medium)
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow  Tube_in(redeclare package Medium =
        Tube_medium)
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow  Shell_in(redeclare package Medium =
        Shell_medium)
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Shell_out(redeclare package Medium =
        Shell_medium)
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  TRANSFORM.Fluid.Volumes.MixingVolume Shell(
    redeclare package Medium = Shell_medium,
    p_start=p_start_shell - dp_general,
    use_T_start=false,
    h_start=0.5*h_start_shell_outlet + 0.5*h_start_shell_inlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (
        V=V_Shell/2,
        angle=0,
        dheight=dh_Shell/2),
    use_HeatPort=false,
    Q_gen=-Q,
    nPorts_a=1,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{28,-28},{48,-8}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
    Tube_dp(K=K_tube, dp_init=dp_init_tube)
    annotation (Placement(transformation(extent={{-16,30},{-36,50}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
    Shell_dp(K=K_shell, dp_init=dp_init_shell)
    annotation (Placement(transformation(extent={{-28,-30},{-8,-10}})));
initial equation
  Q=Q_init;
equation
  hf_s = Shell_medium.bubbleEnthalpy(Shell.medium.sat);
  hf_t = Tube_medium.bubbleEnthalpy(Tube.medium.sat);
  hg_s = Shell_medium.dewEnthalpy(Shell.medium.sat);
  hg_t = Tube_medium.dewEnthalpy(Tube.medium.sat);

   //Find the inlet temperatures and enthalpies given the flow direction
   if
     (Tube_dp.m_flow > 0) then
     Tin_t = Tube_medium.temperature_ph(Tube_in.p,hin_t);
     hin_t = actualStream(Tube_in.h_outflow);
   else
     Tin_t =Tube_medium.temperature_ph(Tube_out.p,hin_t);
     hin_t =actualStream(Tube_out.h_outflow);
   end if;
   if
     (Shell_dp.m_flow > 0) then
     Tin_s = Shell_medium.temperature_ph(Shell_in.p,hin_s);
     hin_s = actualStream(Shell_in.h_outflow);
   else
     Tin_s =Shell_medium.temperature_ph(Shell_out.p,hin_s);
     hin_s =actualStream(Shell_out.h_outflow);
   end if;
 // "For sign consistency, Q>0 means that the shell side is heating the tube side, and Q<0 reverses the flow of heat. The clearest indicator of heat flow direction is temperature."
  Q_max_s =abs(Shell_dp.m_flow)*(-Shell_medium.specificEnthalpy_pT(Shell.medium.state.p,Tin_t) + hin_s);
  Q_max_t = abs(Tube_dp.m_flow)*(Tube_medium.specificEnthalpy_pT(Tube_dp.state.p,Tin_s) - hin_t);
  //By using absolute values, the lesser positive or negative Q becomes the more limiting side.
    if
      (abs(Q_max_s) < abs(Q_max_t)) then
    Q_max = Q_max_s;
    Q_min = Q_max_t;
  else
    Q_max = Q_max_t;
    Q_min = Q_max_s;
  end if;
 // "Calculate the theoretical exit enthalpy assuming that there is some form of boiling or condensation occurring."
  //Including this in an algorithm appears to allow for more of the model to be differentiable based on the translation warnings.
  //However, it does still indicate that this section is not differentiable for some reason.
  hex_t = hin_t + Q_max*(1-exp(-NTU))/(abs(Tube_dp.m_flow));
  Tex_t = Tube_medium.temperature_ph(Tube_out.p,hex_t);
  Tex_s = Shell_medium.temperature_ph(Shell_out.p,hex_s);
  hex_s = hin_s - Q_max*(1-exp(-NTU))/(abs(Shell_dp.m_flow));
  xchange_t = NHES.Fluid.HeatExchangers.Utilities.Functions.quality(
    hin_t,
    hf_t,
    hg_t) - NHES.Fluid.HeatExchangers.Utilities.Functions.quality(
    hex_t,
    hf_t,
    hg_t);
  xchange_s = NHES.Fluid.HeatExchangers.Utilities.Functions.quality(
    hin_s,
    hf_s,
    hg_s) - NHES.Fluid.HeatExchangers.Utilities.Functions.quality(
    hex_s,
    hf_s,
    hg_s);

  //Check for phase change by determining if a change in quality occurs.
  if
    ((xchange_t > 0.0 or xchange_t < 0.0 or xchange_s > 0.0 or xchange_s < 0.0)) then
    Cr = 0.0;
  else
    Cr = abs(Q_max)/abs(Q_min);
  end if;
  //Calculate Q using Cr, Q_max, and NTU. Note that if Cr = 0, this simplifies to Q_max*(1-exp(-NTU)) just as the hex_ calculations used."
  der(Q) = (((1-exp(-NTU*(1+Cr)))*Q_max/(1+Cr))-Q)/tau;
  //Q = (1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr));
  Q_total = Q;

  connect(Tube_in, Tube.port_b[1])
    annotation (Line(points={{100,40},{44,40}}, color={0,127,255}));
  connect(Tube.port_a[1], Tube_dp.port_a)
    annotation (Line(points={{32,40},{-19,40}}, color={0,127,255}));
  connect(Tube_dp.port_b, Tube_out) annotation (Line(points={{-33,40},{-68,
          40},{-68,40},{-100,40}}, color={0,127,255}));
  connect(Shell_dp.port_b, Shell.port_a[1]) annotation (Line(points={{-11,-20},
          {12,-20},{12,-18},{32,-18}},
                                   color={0,127,255}));
  connect(Shell_dp.port_a, Shell_in)
    annotation (Line(points={{-25,-20},{-100,-20}}, color={0,127,255}));
  connect(Shell.port_b[1], Shell_out) annotation (Line(points={{44,-18},{72,-18},
          {72,-20},{100,-20}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,58},{100,20}},
          lineColor={28,108,200},
          fillColor={33,132,244},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,8},{100,-54}},
          lineColor={28,108,200},
          fillColor={23,92,170},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,20},{100,8}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-82,48},{80,28}},
          lineColor={0,0,0},
          textString="Tube"),
        Text(
          extent={{-88,-14},{90,-54}},
          lineColor={0,0,0},
          textString="Shell
")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The goal of this module is to provide a low-fidelity but still accurate model of a HX that uses the NTU method to calculate heat transfer. Main drivers of this desire include a simplified geometry calculation and a significant reduction in the number of variables introduced in order to simulate a system. </p>
<p>Preliminary versions of this model will be kept, but they use progressively less accurate and flexible calculations. Prior models used linear pressure drop terms rather than quadratic, and they also assumed the direction of mass flow. This up-to-date model can calculate the system power during flow reversal on either the shell or tube side, as well as flip which direction the power is transferred. If a user is not exercising a model that has any real potential for flow reversal (for example, a nuclear secondary system undergoing straightforward power level changes), then a more simplified model may be appropriate. </p>
<p>Note that this model does NOT calculate the heat flow based on some Q = h*A*dT. In fact, temperature is only used to calculate the heat transfer potential of the system as between the inlet enthalpy (based on the direction of mass flow through the pressure drop component) and the theoretical 100&percnt; heat transfer of exit enthalpy at the pressure of the fluid being calculated and the inlet temperature of the other fluid. That means that for non-steady state, it is conceivable that the system will have temperature crosses, although they should not occur during any steady-state calculations except perhaps if the pressure drop on one side is extremely large. Additionally, observations from examples have shown thus far that altering the volume of this model with steady or transient sources just alters the system time constant for its approach to steady state. </p>
<p>This model is developed to be used as a feedwater heat exchanger in the secondary side of a nuclear reactor. That means that the fluid properties used are all taken from the standard water library. While the fluids are allowed to be changed, and populate the shell and tube sides separately, it is possible that a fluid could be selected that does not have the same source property equations selected. That is a caution to the user. </p>
<p>A sample use of this HX is in an example named &quot;NTUHX_Example1_Transient_dp,&quot; whose subscripts in the name show the model development. The calculations there are for the intermediate feedwater heater of the NuScale certification design.</p>
<p>Model developed January 2020, by Daniel Mikkelson. Contact at dmmikkel@ncsu.edu, daniel.mikkelson@inl.gov, danielmmikkelson@gmail.com. </p>
</html>"));
end NTU_HX;
