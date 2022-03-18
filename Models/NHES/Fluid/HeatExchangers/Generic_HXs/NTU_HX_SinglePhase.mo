within NHES.Fluid.HeatExchangers.Generic_HXs;
model NTU_HX_SinglePhase
  "Calculates Q as an internal heat generation in a control volume, as a source on one side and a sink on the other. This model allows both for flow reversal and for single phase flow on either or both sides of the HX."
  import Modelica.Units.SI.*;
  import NHES;
  //user options
  parameter Boolean tube_av_b = true "Resistance connects between volume and port_b, false for between port_a and volume";
  parameter Boolean shell_av_b = true "Resistance connects between volume and port_b, false for between port_a and volume";
  parameter Boolean use_derQ = true "Calculates Q via exponential approach, for false calculates Q directly";
  parameter Modelica.Units.SI.Time tau = 1 "Time constant of exponential approach if use_derQ=true" annotation (Evaluate = true,
                Dialog(enable = use_derQ));
  Modelica.Units.SI.Power Q(start = Q_init)
    "Power source/sink in each of the heat transfer volumes";
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
  replaceable package Tube_medium = Modelica.Media.Interfaces.PartialMedium annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
  replaceable package Shell_medium =    Modelica.Media.Interfaces.PartialMedium
                                                                                    annotation(Dialog(tab = "General", group = "Mediums"),choicesAllMatching=true);
  parameter Modelica.Units.SI.Volume V_Tube=0.1 "Total tube-side volume"
    annotation (Dialog(tab="General", group="Sizing"));
  parameter Modelica.Units.SI.Volume V_Shell=0.1 "Total shell-side volume"
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
  parameter Modelica.Units.SI.Power Q_init=0 "Initial guess value for heat rate";
  parameter Real Cr_init = 0.0 "Initial guess value for heat capacity ratio" annotation(Dialog(tab = "Initialization", group = "Heat Transfer"));

  parameter Modelica.Units.SI.MassFlowRate m_start_tube=66.3 "Initial tube mass flow rate"
    annotation (Dialog(tab="Initialization", group="Tube"));
  parameter Modelica.Units.SI.MassFlowRate m_start_shell=10 "Initial shell mass flow rate"
    annotation (Dialog(tab="Initialization", group="Shell"));

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

//  Shell_medium.SaturationProperties sat_rec;

public
  TRANSFORM.Fluid.Volumes.MixingVolume Tube(
    redeclare package Medium = Tube_medium,
    p_start=p_start_tube - dp_general,
    use_T_start=false,
    h_start=0.5*h_start_tube_inlet + 0.5*h_start_tube_outlet,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (
        V=V_Tube,
        angle=0,
        dheight=dh_Tube),
    use_HeatPort=false,
    Q_gen=Q,
    nPorts_b=1,
    nPorts_a=1) annotation (Placement(transformation(extent={{-10,18},{10,38}})));
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
        V=V_Shell,
        angle=0,
        dheight=dh_Shell),
    use_HeatPort=false,
    Q_gen=-Q,
    nPorts_a=1,
    nPorts_b=1)
    annotation (Placement(transformation(extent={{-10,-56},{10,-36}})));

  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
    Tube_dp(
    redeclare package Medium = Tube_medium,
            K=K_tube, dp_init=dp_init_tube)
    annotation (Placement(transformation(extent={{10,48},{-10,68}})));
  NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
    Shell_dp(
    redeclare package Medium = Shell_medium,
             K=K_shell, dp_init=dp_init_shell)
    annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
initial equation

equation

   //Find the inlet temperatures and enthalpies given the flow direction
   if
     (Tube_dp.m_flow > 0) then
     Tin_t = Tube_medium.temperature_phX(Tube_in.p, hin_t,Tube_medium.X_default);
    // Tin_t = Tube_medium.temperature_ph(Tube_in.p,hin_t);
     hin_t = actualStream(Tube_in.h_outflow);
   else
     Tin_t =Tube_medium.temperature_phX(Tube_out.p,hin_t,Tube_medium.X_default);
     hin_t =actualStream(Tube_out.h_outflow);
   end if;
   if
     (Shell_dp.m_flow > 0) then
     Tin_s = Shell_medium.temperature_phX(Shell_in.p,hin_s,Shell_medium.X_default);
     hin_s = actualStream(Shell_in.h_outflow);
   else
     Tin_s =Shell_medium.temperature_phX(Shell_out.p,hin_s,Shell_medium.X_default);
     hin_s =actualStream(Shell_out.h_outflow);
   end if;
 // "For sign consistency, Q>0 means that the shell side is heating the tube side, and Q<0 reverses the flow of heat. The clearest indicator of heat flow direction is temperature."
  Q_max_s =abs(Shell_dp.m_flow)*(-Shell_medium.specificEnthalpy_pTX(Shell.medium.p,Tin_t,Shell_medium.X_default) + hin_s);
  Q_max_t = abs(Tube_dp.m_flow)*(Tube_medium.specificEnthalpy_pTX(Tube_dp.port_a.p,Tin_s,Tube_medium.X_default) - hin_t);
  //By using absolute values, the lesser positive or negative Q becomes the more limiting side.
    if
      (abs(Q_max_s) < abs(Q_max_t)) then
    Q_max = Q_max_s;
    Q_min = Q_max_t;
  else
    Q_max = Q_max_t;
    Q_min = Q_max_s;
  end if;

  //Assume heat capacity ratio to be a specified, non-zero value. This may cause HX to operate a little differently than the method intends if there is phase change (as that would make Cr=0 identically by definition)
  //We ignore that for this model as neither side is specified to be single or two-phase here. Additionally, the heat capacity ratio is no longer defined by m_flow*Cp, but instead we can define it by the maximum power ratio
  //by assuming Q_sh/tub = m_flow*Cp*dT, and so the dT values should cancel numerator & denominator
  if
    (abs(Q_min) > 0) then

      Cr = abs(Q_max)/abs(Q_min);
  else
      Cr = 1;
  end if;
  //Calculate Q using Cr, Q_max, and NTU. Note that if Cr = 0, this simplifies to Q_max*(1-exp(-NTU)) just as the hex_ calculations used."
  //der(Q) = (((1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr))))-Q)/tau;
  if use_derQ then
  if
    (Cr>=1-1e-8) then
    tau*der(Q) = (NTU/(1+NTU))*Q_max-Q;
    else
  tau*der(Q) = (1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr)))-Q;
  end if;
  else
 if
   (Cr>=1-1e-8) then
    Q = (NTU/(1+NTU))*Q_max;
    else
  Q = (1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr)));
      end if;
  end if;

  if tube_av_b then
    connect(Tube_in, Tube.port_a[1]);
    connect(Tube.port_b[1], Tube_dp.port_a);
    connect(Tube_dp.port_b, Tube_out);
  else
    connect(Tube_in, Tube_dp.port_a);
    connect(Tube_dp.port_b, Tube.port_a[1]);
    connect(Tube.port_b[1], Tube_out);
  end if;
    if shell_av_b then
    connect(Shell_in, Shell.port_a[1]);
    connect(Shell.port_b[1], Shell_dp.port_a);
    connect(Shell_dp.port_b, Shell_out);
  else
    connect(Shell_in, Shell_dp.port_a);
    connect(Shell_dp.port_b, Shell.port_a[1]);
    connect(Shell.port_b[1], Shell_out);
  end if;


    //The values of hex_t, hex_s, Tex_t, and Tex_s are provided for ease of access purposes only. They are not required in the method.
  if
    (abs(Tube_dp.m_flow) <= 1e-8) then
    hex_t = hin_t;
    else
    hex_t = hin_t + Q_max*(1-exp(-NTU))/(abs(Tube_dp.m_flow));
  end if;
  Tex_t = Tube_medium.temperature_phX(Tube_out.p,hex_t,Tube_medium.X_default);
  Tex_s = Shell_medium.temperature_phX(Shell_out.p,hex_s,Shell_medium.X_default);
  if
    (abs(Shell_dp.m_flow) <= 1e-8) then
    hex_s = hin_s;
  else
  hex_s = hin_s - Q_max*(1-exp(-NTU))/(abs(Shell_dp.m_flow));
  end if;
  //Presentation values only

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
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-46,14},{54,-18}},
          textColor={28,108,200},
          textString="Connections are conditional, 
not shown

")}),
    Documentation(info="<html>
<p>The goal of this module is to provide a low-fidelity but still accurate model of a HX that uses the NTU method to calculate heat transfer. Main drivers of this desire include a simplified geometry calculation and a significant reduction in the number of variables introduced in order to simulate a system. </p>
<p>Preliminary versions of this model will be kept, but they use progressively less accurate and flexible calculations. Prior models used linear pressure drop terms rather than quadratic, and they also assumed the direction of mass flow. This up-to-date model can calculate the system power during flow reversal on either the shell or tube side, as well as flip which direction the power is transferred. If a user is not exercising a model that has any real potential for flow reversal (for example, a nuclear secondary system undergoing straightforward power level changes), then a more simplified model may be appropriate. </p>
<p>Note that this model does NOT calculate the heat flow based on some Q = h*A*dT. In fact, temperature is only used to calculate the heat transfer potential of the system as between the inlet enthalpy (based on the direction of mass flow through the pressure drop component) and the theoretical 100&percnt; heat transfer of exit enthalpy at the pressure of the fluid being calculated and the inlet temperature of the other fluid. That means that for non-steady state, it is conceivable that the system will have temperature crosses, although they should not occur during any steady-state calculations except perhaps if the pressure drop on one side is extremely large. Additionally, observations from examples have shown thus far that altering the volume of this model with steady or transient sources just alters the system time constant for its approach to steady state. </p>
<p>This model is developed to be used as a feedwater heat exchanger in the secondary side of a nuclear reactor. That means that the fluid properties used are all taken from the standard water library. While the fluids are allowed to be changed, and populate the shell and tube sides separately, it is possible that a fluid could be selected that does not have the same source property equations selected. That is a caution to the user. </p>
<p>A sample use of this HX is in an example named &quot;NTUHX_Example1_Transient_dp,&quot; whose subscripts in the name show the model development. The calculations there are for the intermediate feedwater heater of the NuScale certification design.</p>
<p>Model developed January 2020, by Daniel Mikkelson. Contact at dmmikkel@ncsu.edu, daniel.mikkelson@inl.gov, danielmmikkelson@gmail.com. </p>
</html>"));
end NTU_HX_SinglePhase;
