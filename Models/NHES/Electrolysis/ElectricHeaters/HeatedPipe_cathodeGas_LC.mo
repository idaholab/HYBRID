within NHES.Electrolysis.ElectricHeaters;
model HeatedPipe_cathodeGas_LC "Pipe with heat exchange"

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
                                            "Working fluid model" annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));

  // ---------- Define parameters ----------------------------------------------
  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt=Electrolysis.Utilities.OptionsInit.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  parameter Boolean isCircular=true
    "= true if cross sectional area is circular"
   annotation (Evaluate, Dialog(tab="General", group="Geometry"));
  parameter SI.Length length "Length"
    annotation(Dialog(tab="General", group="Geometry"));
  parameter SI.Diameter diameter "Diameter of circular pipe"
    annotation(Dialog(tab="General", group="Geometry", enable=isCircular));
  parameter SI.Area crossArea=Modelica.Constants.pi*diameter*diameter/4
    "Inner cross section area"
    annotation(Dialog(tab="General", group="Geometry", enable=not isCircular));
//  parameter SI.Length perimeter=Modelica.Constants.pi*diameter
//    "Inner perimeter"
//    annotation(Dialog(tab="General", group="Geometry", enable=not isCircular));
  final parameter SI.Volume V=crossArea*length "Fluid internal volume";

  parameter SI.ThermalConductance Ah = 20470 "Thermal conductance [W/K]";

  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dp=
      4872.23324354983
    "Coefficient for the pressure drop across a pipe [Pa.s2/(kg2)]";
  parameter SI.Pressure p_in_start = 2.14299*1e6
    "Start value of inlet pressure [Pa]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure p_out_start = p_in_start - coeff_dp*w_start^2
    "Start value of outlet pressure [Pa]";
  final parameter SI.Pressure p_mean_start = (p_in_start + p_out_start)/2
    "Start value of average pressure [Pa]";

  parameter SI.Temperature T_in_start = 25 + 273.15
    "Start value of inlet temperature [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature T_out_start = 283.4 + 273.15
    "Start value of outlet temperature [K]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Temperature T_mean_start = (T_in_start + T_out_start)/2
    "Start value of average temperature in a pipe [K]";

  final parameter SI.SpecificEnthalpy h_in_start = Modelica.Media.Water.IF97_Utilities.h_pT(p_in_start, T_in_start)
    "Start value of inlet specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy h_out_start = Modelica.Media.Water.IF97_Utilities.h_pT(p_out_start, T_out_start)
    "Start value of outlet specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy h_mean_start = Modelica.Media.Water.IF97_Utilities.h_pT(p_mean_start, T_mean_start)
    "Start value of average specific enthalpy [J/kg]";

  parameter SI.MassFlowRate w_start= 4.484656329
    "Start value of mass flow rate [kg/s]" annotation (Dialog(tab="Initialisation"));

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a port_a(h_outflow(start=h_in_start),
  redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),  iconTransformation(
          extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(h_outflow(start=h_out_start),
  redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),  iconTransformation(extent={{90,-10},
            {110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
      Placement(transformation(extent={{-10,70},{10,90}}), iconTransformation(
          extent={{-10,70},{10,90}})));

  // ---------- Declare variables ----------------------------------------------
  SI.Mass M(min=0) "Fluid total mass [kg]";

  SI.Pressure p_in( min=0) "Inlet pressure [Pa]";
  SI.Pressure p_out( min=0) "Outlet pressure [Pa]";
  SI.Pressure p_mean( min=0) "Average pressure [Pa]";
  SI.Pressure dp "Pressure drop across a pipe [Pa]";

  SI.Temperature T_in(min=273.15,start=T_in_start) "Inlet temperature [K]";
  SI.Temperature T_out(min=273.15,start=T_out_start) "Outlet temperature [K]";
  SI.Temperature T_mean(min=273.15,start = T_mean_start)
    "Average temperature [K]";

  SI.SpecificEnthalpy h_in(min = 0, start=h_in_start)
    "Inlet specific enthalpy of [J/kg]";
  SI.SpecificEnthalpy h_out(min = 0, start=h_out_start)
    "Outlet specific enthalpy [J/kg]";
  SI.SpecificEnthalpy h_mean(min = 0, start=h_mean_start)
    "Average specific enthalpy [J/kg]";

  SI.MassFlowRate w_in(min=0) "Inlet mass flow rate [kg/s]";
  SI.MassFlowRate w_out(min=0) "Outlet mass flow rate [kg/s]";

  SI.Density rho_mean( min = 0, start= Medium.density(state_mean_start))
    "Average density of the medium [kg/m3]";
  SI.SpecificHeatCapacity cp_mean( min = 0)
    "Average specific heat capacity of the medium [J/(kg.K)]";
  SI.HeatFlowRate Q_flow "Heat gained/lost by the hot/cold medium [W]";

  // ----- Initial states -----
  final parameter Medium.ThermodynamicState state_in_start = Medium.setState_ph(p_in_start, h_in_start);
  final parameter Medium.ThermodynamicState state_out_start = Medium.setState_ph(p_out_start, h_out_start);
  final parameter Medium.ThermodynamicState state_mean_start = Medium.setState_pT(p_mean_start, T_mean_start);

  // ----- Current states -----
  Medium.ThermodynamicState state_in(p(start=p_in_start),T(start=T_in_start));
  Medium.ThermodynamicState state_out(p(start=p_out_start),T(start=T_out_start));
  Medium.ThermodynamicState state_mean(p(start=p_mean_start),T(start=T_mean_start));

equation
  // ----------- Fluid properties ----------------------------------------------
  state_in = Medium.setState_ph(port_a.p, inStream(port_a.h_outflow));
  state_out = Medium.setState_ph(port_b.p, port_b.h_outflow);
  state_mean = Medium.setState_pT(p_mean, T_mean);

  T_in = Medium.temperature(state_in);
  T_out = Medium.temperature(state_out);
  h_mean = Medium.specificEnthalpy(state_mean);
  rho_mean = Medium.density(state_mean);

  // ---------- Boundary conditions --------------------------------------------
  port_a.m_flow = w_in;
  assert(w_in >= 0, "Flow reversal is not supported");
  -port_b.m_flow = w_out;
  assert(w_out >= 0, "Flow reversal is not supported");

  p_in = port_a.p;
  p_out = port_b.p;

  h_in = inStream(port_a.h_outflow);
  h_out = port_b.h_outflow;

  // Equations for reverse flow (not used)
  port_a.h_outflow = inStream(port_b.h_outflow);

  Q_flow = heatPort.Q_flow;
  T_mean = heatPort.T;

  // Intermediate variables
  M = rho_mean*V;

  p_mean = (p_in + p_out)/2;
  T_mean = (T_in + T_out)/2;

  // Pressure drop across the heat exchanger
  dp = coeff_dp*w_in^2;
  p_out = p_in - dp;

  // ----- Mass balances ------
  //0 = w_in - w_out;
  der(M) = w_in - w_out;

  // ----- Energy balances ------
  //cp_mean = Modelica.Media.Water.IF97_Utilities.cp_pT(p_mean,T_mean);
  cp_mean = 4316.19;

  V*der(rho_mean*cp_mean*T_mean) = w_in*h_in - w_out*h_out + Q_flow;
  //0 = (w_in*h_in - w_out*h_out) + Q_flow;

initial equation

  if initOpt == Electrolysis.Utilities.OptionsInit.noInit then
    // do nothing
  elseif initOpt == Electrolysis.Utilities.OptionsInit.userSpecified then

    T_out = T_out_start;

  elseif initOpt == Electrolysis.Utilities.OptionsInit.steadyState then

    der(T_mean) = 0;

  else

    assert(false, "Unsupported initialisation option");

  end if;

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={
        Ellipse(
          extent={{90,24},{110,-26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_a_exposesState),
        Ellipse(
          extent={{-110,26},{-90,-24}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_a_exposesState),
        Polygon(
          points={{20,-66},{60,-81},{20,-96},{20,-66}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Text(
          extent={{-98,-103},{102,-133}},
          lineColor={0,0,255},
          textString="%name"),
          Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Polygon(
          points={{20,-71},{50,-81},{20,-91},{20,-71}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,-81},{-60,-81}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=showDesignFlowDirection),
        Line(points={{0,70},{0,44}},    color={191,0,0})}));
end HeatedPipe_cathodeGas_LC;
