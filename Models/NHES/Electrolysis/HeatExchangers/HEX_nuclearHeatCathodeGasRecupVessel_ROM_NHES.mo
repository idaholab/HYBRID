within NHES.Electrolysis.HeatExchangers;
model HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES
  "Reduced order model (ROM) for nuclear heat recuperation with cathode gas"

  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium_tube = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Working fluid model in tube side of a heat exchanger" annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));
  replaceable package Medium_shell = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialPureSubstance
    "Working fluid model in shell side of a heat exchanger" annotation (choicesAllMatching = true,Dialog(group="Working fluids (Medium)"));

  // ---------- Define parameters ----------------------------------------------
  parameter Electrolysis.Utilities.OptionsInit.Temp initOpt=
      Electrolysis.Utilities.OptionsInit.noInit "Initialisation option"
    annotation (Dialog(tab="Initialisation"));

  final parameter SI.Volume Vf = 0.5 "Fluid internal volume [m3]";
  parameter SI.Volume Vm = 0.35 + 1.7 + 0.55
    "Volume of the metal parts in a heat exchanger [m3]";
  parameter SI.Density rhom = 7753 "Metal density [kg/m3]";
  parameter SI.SpecificHeatCapacity cpm = 486
    "Specific heat capacity of the metal [J/(kg.K)]";
  parameter SI.ThermalConductance AhTube = 226653
    "Thermal conductance in tube side [W/K]";
  parameter SI.ThermalConductance AhShell = 226653
    "Thermal conductance in shell side [W/K]";

  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpTube=
      4872.23324354983
    "Coefficient for the pressure drop in tube side [Pa.s2/(kg2)]";
  parameter Electrolysis.Types.HydraulicConductanceSquared coeff_dpShell=
      2146.02917037094
    "Coefficient for the pressure drop in shell side [Pa.s2/(kg2)]";
  parameter SI.Pressure pTube_in_start = 2.37021305331862*1e6
    "Start value of inlet pressure in tube side [Pa]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Pressure pShell_in_start = 5.22*1e6
    "Start value of inlet pressure in shell side [Pa]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Pressure pTube_out_start = pTube_in_start - coeff_dpTube*wTube_start^2
    "Start value of outlet pressure in tube side [Pa]";
  final parameter SI.Pressure pShell_out_start = pShell_in_start - coeff_dpShell*wShell_start^2
    "Start value of outlet pressure in shell side [Pa]";

  parameter SI.Temperature TTube_in_start = 25.1971 + 273.15
    "Start value of inlet temperature in tube side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TShell_in_start = 311.629 + 273.15
    "Start value of inlet temperature in shell side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TTube_out_start = 283.4 + 273.15
    "Start value of outlet temperature in tube side [K]" annotation (Dialog(tab="Initialisation"));
  parameter SI.Temperature TShell_out_start = 224 + 273.15
    "Start value of outlet temperature in shell side [K]" annotation (Dialog(tab="Initialisation"));
  final parameter SI.Temperature TTube_mean_start = (TTube_in_start + TTube_out_start)/2
    "Start value of average temperature in tube side [K]";
  final parameter SI.Temperature TShell_mean_start = (TShell_in_start + TShell_out_start)/2
    "Start value of average temperature in shell side [K]";
  final parameter SI.Temperature Tm_start = (TTube_mean_start + TShell_mean_start)/2
    "Start value of metal temperature [K]";

  final parameter SI.SpecificEnthalpy hTube_in_start = Modelica.Media.Water.IF97_Utilities.h_pT(pTube_in_start, TTube_in_start)
    "Start value of inlet specific enthalpy in tube side [J/kg]";
  final parameter SI.SpecificEnthalpy hShell_in_start = Modelica.Media.Water.IF97_Utilities.h_pT(pShell_in_start, TShell_in_start)
    "Start value of inlet specific enthalpy in shell side [J/kg]";
  final parameter SI.SpecificEnthalpy hTube_out_start = Modelica.Media.Water.IF97_Utilities.h_pT(pTube_out_start, TTube_out_start)
    "Start value of outlet specific enthalpy in tube side [J/kg]";
  final parameter SI.SpecificEnthalpy hShell_out_start = Modelica.Media.Water.IF97_Utilities.h_pT(pShell_out_start, TShell_out_start)
    "Start value of outlet specific enthalpy in shell side [J/kg]";

  parameter SI.MassFlowRate wTube_start = 4.4846564335925
    "Start value of mass flow rate of the medium in tube side [kg/s]"
    annotation (Dialog(tab="Initialisation"));
  parameter SI.MassFlowRate wShell_start = 6.46077
    "Start value of mass flow rate of the medium in shell side [kg/s]"
    annotation (Dialog(tab="Initialisation"));

  // ---------- Connectors -----------------------------------------------------
  Modelica.Fluid.Interfaces.FluidPort_a tube_in(h_outflow(start=hTube_in_start),
  redeclare package Medium = Medium_tube) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),  iconTransformation(
          extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b tube_out(h_outflow(start=hTube_out_start),
  redeclare package Medium = Medium_tube) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),  iconTransformation(extent={{90,-10},
            {110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a shell_in(h_outflow(start=hShell_in_start),
  redeclare package Medium = Medium_shell) annotation (Placement(
        transformation(extent={{-10,90},{10,110}}),  iconTransformation(extent={{-10,90},
            {10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b shell_out(h_outflow(start=hShell_out_start),
  redeclare package Medium = Medium_shell) annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}),  iconTransformation(
          extent={{-10,-110},{10,-90}})));

  // ---------- Declare variables ----------------------------------------------
  SI.Mass MTube(min=0) "Fluid mass in tube side [kg]";
  SI.Mass MShell(min=0) "Fluid mass in shell side [kg]";
  SI.Energy UTube(min=0) "Fulid specific internal energy in tube side [J]";
  SI.Energy UShell(min=0)
    "Fulid specific internal energy in shell side [J]";
  SI.Power QTube_gained "Energy gained by the cold fluid [W]";
  SI.Power QShell_lost "Energy lost by the hot fluid [W]";

  SI.Pressure pTube_in( min=0)
    "Inlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_in( min=0)
    "Inlet pressure of the medium in shell side [Pa]";
  SI.Pressure pTube_out( min=0)
    "Outlet pressure of the medium in tube side [Pa]";
  SI.Pressure pShell_out( min=0)
    "Outlet pressure of the medium in shell side [Pa]";
  SI.Pressure dpTube( min=0) "Pressure drop in tube side [Pa]";
  SI.Pressure dpShell( min=0) "Pressure drop in shell side [Pa]";

  SI.SpecificEnthalpy hTube_in(min = 0, start=hTube_in_start)
    "Inlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_in(min = 0, start=hShell_in_start)
    "Inlet specific enthalpy of the medium in shell side [J/kg]";
  SI.SpecificEnthalpy hTube_out(min = 0, start=hTube_out_start)
    "Outlet specific enthalpy of the medium in tube side [J/kg]";
  SI.SpecificEnthalpy hShell_out(min = 0, start=hShell_out_start)
    "Outlet specific enthalpy of the medium in shell side [J/kg]";

  SI.Temperature Tm(min = 273.15,start=Tm_start) "Metal temperature [K]";
  SI.Temperature TTube_in(min=273.15,nominal=298.3471,start=TTube_in_start)
    "Inlet temperature in tube side [K]";
  SI.Temperature TTube_out(min=273.15,nominal=556.55,start=TTube_out_start)
    "Outlet temperature in tube side [K]";
  SI.Temperature TShell_in(min=273.15+283.4,nominal=584.779,start=TShell_in_start)
    "Inlet temperature in shell side [K]";
  SI.Temperature TShell_out(min=273.15,nominal=497.15,start=TShell_out_start)
    "Outlet temperature in shell side [K]";
  SI.Temperature TTube_mean(min=273.15,nominal=427.45,start = TTube_mean_start)
    "Average temperature in tube side [K]";
  SI.Temperature TShell_mean(min=273.15,nominal=540.9645,start = TShell_mean_start)
    "Average temperature in shell side [K]";

  SI.MassFlowRate wTube_in(min=0)
    "Inlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wTube_out(min=0)
    "Outlet mass flow rate of the medium in tube side [kg/s]";
  SI.MassFlowRate wShell_in(min=0)
    "Inlet mass flow rate of the medium in shell side [kg/s]";
  SI.MassFlowRate wShell_out(min=0)
    "Outlet mass flow rate of the medium in shell side [kg/s]";

  // ----- Initial states -----
  final parameter Medium_tube.ThermodynamicState tubeState_in_start = Medium_tube.setState_ph(pTube_in_start, hTube_in_start);
  final parameter Medium_shell.ThermodynamicState shellState_in_start = Medium_shell.setState_ph(pShell_in_start, hShell_in_start);
  final parameter Medium_tube.ThermodynamicState tubeState_out_start = Medium_tube.setState_ph(pTube_out_start, hTube_out_start);
  final parameter Medium_shell.ThermodynamicState shellState_out_start = Medium_shell.setState_ph(pShell_out_start, hShell_out_start);

  // ----- Current states -----
  Medium_tube.ThermodynamicState tubeState_in(p(start=pTube_in_start),T(start=TTube_in_start));
  Medium_tube.ThermodynamicState tubeState_out(p(start=pTube_out_start),T(start=TTube_out_start));
  Medium_shell.ThermodynamicState shellState_in(p(start=pShell_in_start),T(start=TShell_in_start));
  Medium_shell.ThermodynamicState shellState_out(p(start=pShell_out_start),T(start=TShell_out_start));

equation
  // ----------- Fluid properties ----------------------------------------------
  tubeState_in = Medium_tube.setState_ph(pTube_in, inStream(tube_in.h_outflow));
  tubeState_out = Medium_tube.setState_ph(pTube_out, tube_out.h_outflow);
  shellState_in = Medium_shell.setState_ph(pShell_in, inStream(shell_in.h_outflow));
  shellState_out = Medium_shell.setState_ph(pShell_out, shell_out.h_outflow);

  TTube_in = Medium_tube.temperature(tubeState_in);
  TTube_out = Medium_tube.temperature(tubeState_out);
  TShell_in = Medium_shell.temperature(shellState_in);
  TShell_out = Medium_shell.temperature(shellState_out);

  // ---------- Boundary conditions --------------------------------------------
  tube_in.m_flow = wTube_in "[kg/s]";
  assert(wTube_in >= 0, "Flow reversal is not supported");
  shell_in.m_flow = wShell_in "[kg/s]";
  assert(wShell_in >= 0, "Flow reversal is not supported");
  -tube_out.m_flow = wTube_out "[kg/s]";
  assert(wTube_out >= 0, "Flow reversal is not supported");
  -shell_out.m_flow = wShell_out "[kg/s]";
  assert(wShell_out >= 0, "Flow reversal is not supported");

  pTube_in = tube_in.p;
  pTube_out = tube_out.p;
  pShell_in = shell_in.p;
  pShell_out = shell_out.p;

  hTube_in = inStream(tube_in.h_outflow);
  hTube_out = tube_out.h_outflow;
  hShell_in = inStream(shell_in.h_outflow);
  hShell_out = shell_out.h_outflow;

  // Equations for reverse flow (not used)
  tube_in.h_outflow = inStream(tube_out.h_outflow);
  shell_in.h_outflow = inStream(shell_out.h_outflow);

  // Intermediate variables
  MTube = Medium_tube.density(tubeState_in)*Vf;
  MShell = Medium_shell.density(shellState_in)*Vf;
  UTube = Medium_tube.specificInternalEnergy(tubeState_in)*MTube;
  UShell = Medium_shell.specificInternalEnergy(shellState_in)*MShell;

  QTube_gained = -(wTube_in*hTube_in - wTube_out*hTube_out);
  QShell_lost = (wShell_in*hShell_in - wShell_out*hShell_out);

  TTube_mean = (TTube_in + TTube_out)/2;
  TShell_mean = (TShell_in + TShell_out)/2;

  // Pressure drop across the heat exchanger
  dpTube = coeff_dpTube*wTube_in^2;
  dpShell = coeff_dpShell*wShell_in^2;
  pTube_out = pTube_in - dpTube;
  pShell_out = pShell_in - dpShell;

  // ----- Mass balances ------
  //der(MTube) = wTube_in - wTube_out;
  //der(MShell) = wShell_in - wShell_out;
  0 = wTube_in - wTube_out;
  0 = wShell_in - wShell_out;

  // ----- Energy balances ------
  //der(UTube) = (wTube_in*hTube_in - wTube_out*hTube_out) + AhTube*(Tm - TTube_mean);
  //der(UShell) = (wShell_in*hShell_in - wShell_out*hShell_out) + AhShell*(Tm - TShell_mean);
  0 = (wTube_in*hTube_in - wTube_out*hTube_out) + AhTube*(Tm - TTube_mean);
  0 = (wShell_in*hShell_in - wShell_out*hShell_out) + AhShell*(Tm - TShell_mean);

  Vm*rhom*cpm*der(Tm) = -AhTube*(Tm - TTube_mean) - AhShell*(Tm - TShell_mean);

  //Vm*rhom*cpm*der(Tm) = (wTube_in*hTube_in - wTube_out*hTube_out) + (wShell_in*hShell_in - wShell_out*hShell_out);

initial equation
  //der(MTube) = 0;
  //der(MShell) = 0;
  //der(UTube) = 0;
  //der(UShell) = 0;

  if initOpt == Electrolysis.Utilities.OptionsInit.noInit then
    // do nothing
  elseif initOpt == Electrolysis.Utilities.OptionsInit.userSpecified then

    //wShell_in = wShell_start;
    //wTube_in = wTube_start;
    //tube_out.m_flow = wTube_start;
    //tube_out.h_outflow = hTube_in_start;
    //pTube_in = pTube_in_start;

    //Tm = Tm_start;

  elseif initOpt == Electrolysis.Utilities.OptionsInit.steadyState then

    der(Tm) = 0;

  else

    assert(false, "Unsupported initialisation option");

  end if;

    annotation (
     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
         graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          fillPattern=FillPattern.Sphere,
          fillColor={238,46,47},
          pattern=LinePattern.None,
          lineColor={238,46,47}),
        Text(
          extent={{-100,-123},{100,-153}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-6.12323e-015,100},{0,40},{40,20},{-40,-20},{0,-40},{6.12323e-015,
              -100}},
          color={0,0,255},
          thickness=0.5,
          origin={0,0},
          rotation=90)}),
    experiment,
    __Dymola_experimentSetupOutput);
end HEX_nuclearHeatCathodeGasRecupVessel_ROM_NHES;
