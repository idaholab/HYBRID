within NHES.Fluid.Machines.Examples.Verification;
model RankineCycle_Example8_1
  "Example 8.1 from Intro to Chemical Engineering"
  extends Modelica.Icons.Example;

  NHES.Utilities.ErrorAnalysis.Errors_AbsRelRMS summary_Error(
    n=1,
    x_1={error_abs},
    x_2={error_exp})
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  package Medium = Modelica.Media.Water.StandardWater "Working fluid";
  parameter SI.MassFlowRate m_flow = 59.02 "Flow rate in cycle";
  parameter SI.Pressure p_steam = 8.6e6 "Steam pressure";
  parameter SI.Temperature T_steam = Modelica.Units.Conversions.from_degC(
                                                              500) "Steam temperature";

  parameter SI.Pressure p_condenser = 1e4 "Condenser pressure";
  parameter SI.Efficiency eta = 0.75 "Overall turbine efficiency";
  parameter SI.Temperature T_condenser = Modelica.Units.Conversions.from_degC(
                                                                  45.8) "Condenser saturated liquid temperature";
  parameter SI.Efficiency eta_example = 0.2961 "Rankine cycle efficiency";

  parameter Real error_exp = -0.001139 "Expected error between example and model";

  Real error_abs = eta_overall - eta_example;

  inner NHES.Fluid.System_TP system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  SteamTurbineStodola steamTurbine(
    p_a_start(displayUnit="kPa") = p_steam,
    p_b_start(displayUnit="kPa") = p_condenser,
    T_a_start=T_steam,
    T_b_start=T_condenser,
    m_flow_start=m_flow,
    redeclare package Medium = Medium,
    redeclare model Eta_wetSteam =
        Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (eta_nominal=
           eta))
    annotation (Placement(transformation(extent={{-10,22},{10,42}})));

  NHES.Fluid.Vessels.IdealCondenser condenser(p(displayUnit="Pa")=
      p_condenser, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{26,-32},{46,-12}})));
  Modelica.Fluid.Vessels.ClosedVolume boiler(
    use_portsData=false,
    use_HeatTransfer=true,
    V=0.001,
    nPorts=3,
    p_start=p_steam,
    T_start=T_steam,
    redeclare package Medium = Medium)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Thot_setPoint(T=T_steam)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-60,-22})));
  ThermoPower.Water.Pump pump(
    redeclare function flowCharacteristic =
        ThermoPower.Functions.PumpCharacteristics.quadraticFlow (q_nom={0,0.1,2*
            0.1}, head_nom={1000,500,0}),
    n0=1500,
    hstart=191.8e3,
    w0=m_flow,
    redeclare package Medium = Medium,
    dp0=p_steam - p_condenser)
    annotation (Placement(transformation(extent={{10,-92},{-10,-72}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-58})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy_in(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-75},{-70,-55}})));
  Modelica.Fluid.Sensors.SpecificEnthalpy specificEnthalpy_out(redeclare
      package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,32},{-70,52}})));
  NHES.Electrical.Generator generator
    annotation (Placement(transformation(extent={{20,22},{40,42}})));
  NHES.Electrical.Sources.FrequencySource boundary(f=60)
    annotation (Placement(transformation(extent={{80,22},{60,42}})));

  SI.SpecificEnthalpy h_boiler = specificEnthalpy_out.h_out - specificEnthalpy_in.h_out "Total boiler enthalpy input";
  SI.Power Q_boiler "Total boiler thermal power input";

  SI.Efficiency eta_overall "Overall Rankine efficiency";

equation

  Q_boiler = massFlowRate.m_flow*h_boiler;
  eta_overall = boundary.portElec_b.W/Q_boiler;

  connect(massFlowRate.port_a, pump.outfl) annotation (Line(points={{-40,-68},{-40,
          -75},{-6,-75}}, color={0,127,255}));
  connect(specificEnthalpy_in.port, pump.outfl) annotation (Line(points={{-80,-75},
          {-60,-75},{-40,-75},{-6,-75}}, color={0,127,255}));
  connect(massFlowRate.port_b, boiler.ports[1]) annotation (Line(points={{-40,-48},
          {-42,-48},{-42,-4},{-42,-2.66667},{-50,-2.66667}}, color={0,127,255}));
  connect(Thot_setPoint.port, boiler.heatPort)
    annotation (Line(points={{-60,-16},{-60,-10}}, color={191,0,0}));
  connect(specificEnthalpy_out.port, boiler.ports[2]) annotation (Line(points={{
          -80,32},{-50,32},{-50,-4.44089e-016}}, color={0,127,255}));
  connect(steamTurbine.portHP, boiler.ports[3]) annotation (Line(points={{-10,38},
          {-42,38},{-42,2.66667},{-50,2.66667}}, color={0,127,255}));
  connect(steamTurbine.portLP, condenser.port_a) annotation (Line(points={{7,22},
          {6,22},{6,-4},{6,-6},{29,-6},{29,-12}}, color={0,127,255}));
  connect(condenser.port_b, pump.infl) annotation (Line(points={{36,-32},{36,-32},
          {36,-76},{36,-80},{8,-80}}, color={0,127,255}));
  connect(generator.portElec, boundary.portElec_b)
    annotation (Line(points={{40,32},{40,32},{60,32}}, color={255,0,0}));
  connect(steamTurbine.shaft_b, generator.shaft_a)
    annotation (Line(points={{10,32},{20,32}},         color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(__Dymola_NumberOfIntervals=10),
    Documentation(info="<html>
<p>The is a comparison of the steam turbine results using the conditions and comparing the results specified in Example 8.1 part b in the source.</p>
<p><br>References:</p>
<p>Smith, J.M., Vand Ness, H.C., Abbott, M.M.m &apos;Introduction to Chemical Engineering Thermodynamics 7E,&apos;</p>
<p>pg. 269-270, Example 8.1, 2005.</p>
</html>"));
end RankineCycle_Example8_1;
