within NHES.GasTurbine.PowerPlant;
model GasTurbineUnit
  extends GasTurbine.Icons.GasTurbineUnit;

  replaceable package Air = Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium "O2, H2O, Ar, N2" annotation (Dialog(group="Working fluids (Medium)"));
  replaceable package Fuel = Media.NaturalGas constrainedby
    Modelica.Media.Interfaces.PartialMedium "N2, CO2, CH4" annotation (Dialog(group="Working fluids (Medium)"));
  replaceable package Exhaust = Media.FlueGas constrainedby
    Modelica.Media.Interfaces.PartialMedium "O2, Ar, H2O, CO2, N2" annotation (Dialog(group="Working fluids (Medium)"));

  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (air_in -> exhaust_out)" annotation(Dialog(tab="Assumptions"), Evaluate=true);
  outer Modelica.Fluid.System system "System wide properties";
  parameter Real PR0 = 15.4 "Nominal compression ratio";
  parameter Real eta_mech = 0.98 "Mechanical efficiency";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nrpm0=3600
    "Rated rotational speed of the shaft in rpm";
  final parameter Modelica.Units.SI.AngularVelocity N0=
      Modelica.Units.Conversions.from_rpm(Nrpm0)
    "Rated rotational speed of the shaft in rad/s";
  parameter Modelica.Units.SI.MomentOfInertia J=1892*1.4 "Rotor inertia";

  parameter Boolean explicitIsentropicEnthalpy_comp = true
    "IsentropicEnthalpy function used" annotation (Dialog(tab="General", group="Compressor"));
  parameter Real eta0_comp=0.86
    "Isentropic efficiency at nominal operating conditions" annotation (Dialog(tab="General", group="Compressor"));
  parameter Modelica.Units.SI.MassFlowRate w0_comp "Nominal gas flow rate"
    annotation (Dialog(tab="General", group="Compressor"));

  parameter Modelica.Units.SI.Volume V "Inner volume"
    annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Modelica.Units.SI.SpecificEnthalpy LHV=43094*1e3
    "Lower heating value of fuel"
    annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Real eta0_comb=0.99 "Constant combustion efficiency" annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Modelica.Units.SI.MassFlowRate w0_comb=w0_turb - w0_comp
    "Nominal fuel flow rate"
    annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Modelica.Units.SI.MassFlowRate w_noLoad=0.240858
    "Fuel flow rate at W=0 (no-load condition)"
    annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Modelica.Units.SI.MassFlowRate w_min=0.139247100000001
    "Minimum fuel flow rate to maintain the flame"
    annotation (Dialog(tab="General", group="Combustion chamber"));
  parameter Modelica.Units.SI.Temperature Tf0=1067.23 + 273.15
    "Rated firing temperataure"
    annotation (Dialog(tab="General", group="Combustion chamber"));

  parameter Boolean explicitIsentropicEnthalpy_turb = true
    "IsentropicEnthalpy function used" annotation (Dialog(tab="General", group="Turbine"));
  parameter Real eta0_turb=0.89
    "Isentropic efficiency at nominal operating conditions" annotation (Dialog(tab="General", group="Turbine"));
  parameter Modelica.Units.SI.MassFlowRate w0_turb "Nominal gas flow rate"
    annotation (Dialog(tab="General", group="Turbine"));
  parameter Modelica.Units.SI.Temperature Te0=549.0003132 + 273.15
    "Rated exhuast gas temperature"
    annotation (Dialog(tab="General", group="Turbine"));

  parameter Modelica.Units.SI.Pressure pstart_comp_in=1.01325*1e5
    "Inlet start pressure"
    annotation (Dialog(tab="Initialisation", group="Compressor"));
  parameter Modelica.Units.SI.Temperature Tstart_comp_in=15 + 273.15
    "Inlet start temperature"
    annotation (Dialog(tab="Initialisation", group="Compressor"));
  parameter Modelica.Units.SI.Temperature Tstart_comp_out
    "Outlet start temperature"
    annotation (Dialog(tab="Initialisation", group="Compressor"));

//   parameter ThermoPower.Choices.Init.Options initOpt=ThermoPower.Choices.Init.Options.noInit
//     "Initialisation option"
  parameter Modelica.Units.SI.Pressure pstart_turb_out=1.01325*1e5
    "Outlet start pressure"
    annotation (Dialog(tab="Initialisation", group="Turbine"));

  parameter Modelica.Units.SI.Temperature Tstart_turb_out
    "Outlet start temperature"
    annotation (Dialog(tab="Initialisation", group="Turbine"));
  parameter Modelica.Units.SI.Temperature Tstart_comb "Temperature start value"
    annotation (Dialog(tab="Initialisation", group="Combustion chamber"));
  parameter Modelica.Units.SI.Angle phi_start=0
    "Shaft rotation angle start value"
    annotation (Dialog(tab="Initialisation", group="Shaft"));

  Modelica.Units.SI.Power W(displayUnit="MW")
    "Net power output from a gas turbine unit";
  Modelica.Units.SI.Angle phi "Shaft rotation angle";
  Modelica.Units.SI.Torque tau "Net torque acting on the turbine";
  Modelica.Units.SI.AngularVelocity omega "Shaft angular velocity";

  CombustionChamber.CombustionChamber combChamber(
    allowFlowReversal=allowFlowReversal,
    V=V,
    LHV=LHV,
    eta0_comb=eta0_comb,
    Tm_start=combChamber.Tstart,
    pstart=compressor.pstart_out,
    Tstart=Tstart_comb)
    annotation (Placement(transformation(extent={{-10,2},{10,22}})));
  Compressor.Compressor compressor(
    redeclare package Medium = Air,
    allowFlowReversal=allowFlowReversal,
    explicitIsentropicEnthalpy=explicitIsentropicEnthalpy_comp,
    eta0=eta0_comp,
    PR0=PR0,
    w0=w0_comp,
    pstart_in=pstart_comp_in,
    Tstart_in=Tstart_comp_in,
    Tstart_out=Tstart_comp_out)
    annotation (Placement(transformation(extent={{-28,-12},{-6,10}})));
  Turbine.Turbine turbine(
    PR0=PR0,
    redeclare package Medium = Exhaust,
    allowFlowReversal=allowFlowReversal,
    explicitIsentropicEnthalpy=explicitIsentropicEnthalpy_turb,
    eta0=eta0_turb,
    w0=w0_turb,
    pstart_out=pstart_turb_out,
    Tstart_in=combChamber.Tstart,
    Tstart_out=Tstart_turb_out)
    annotation (Placement(transformation(extent={{6,-12},{28,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a air_in(redeclare package Medium = Air, m_flow(min=if
          allowFlowReversal then -Modelica.Constants.inf else 0))
                                               annotation (Placement(
        transformation(extent={{-100,20},{-80,40}}), iconTransformation(extent={
            {-100,20},{-80,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a fuel_in(redeclare package Medium = Fuel, m_flow(min=if
          allowFlowReversal then -Modelica.Constants.inf else 0))
                                                annotation (Placement(
        transformation(extent={{-10,60},{10,80}}), iconTransformation(extent={{-10,
            60},{10,80}})));
  Modelica.Fluid.Interfaces.FluidPort_b exhaust_out(redeclare package Medium =
        Exhaust, m_flow(max=if
          allowFlowReversal then +Modelica.Constants.inf else 0)) annotation (Placement(
        transformation(extent={{80,20},{100,40}}), iconTransformation(extent={{80,
            20},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput Te( final unit="K", min = 0, displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Turbine exhaust gas temperature" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,-70}),              iconTransformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={28,-34})));
  Modelica.Blocks.Interfaces.RealOutput Tf( final quantity="ThermodynamicTemperature", final unit="K", min = 0, displayUnit="degC")
    "Turbine firing temperature" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
        rotation=90,
        origin={60,-70}),              iconTransformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={72,-58})));
   Modelica.Fluid.Sensors.Temperature Te_mes(redeclare package Medium =
        Exhaust)
    annotation (Placement(transformation(extent={{14,-32},{34,-52}})));
   Modelica.Fluid.Sensors.Temperature Tf_mes(redeclare package Medium =
        Exhaust)
    annotation (Placement(transformation(extent={{38,-32},{58,-52}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{
            90,-10},{110,10}})));

equation
  W = eta_mech*(turbine.Wt - compressor.Wc);
  W = tau*omega;

  // ----- Mechanical boundaries -----
  shaft.phi = phi;
  shaft.tau = -tau;
  der(phi) = omega;

  connect(compressor.outlet, combChamber.ina) annotation (Line(points={{-10.4,7.8},
          {-10.4,12},{-4,12}}, color={0,127,255}));
  connect(combChamber.out, turbine.inlet)
    annotation (Line(points={{4,12},{10.4,12},{10.4,7.8}}, color={0,127,255}));
  connect(air_in, compressor.inlet) annotation (Line(points={{-90,30},{-23.6,30},
          {-23.6,7.8}}, color={0,127,255}));
  connect(fuel_in, combChamber.inf)
    annotation (Line(points={{0,70},{0,16}},        color={0,127,255}));
  connect(exhaust_out, turbine.outlet) annotation (Line(points={{90,30},{23.6,30},
          {23.6,7.8}}, color={0,127,255}));
  connect(Te, Te) annotation (Line(points={{40,-70},{40,-70}},
                                                             color={0,0,127}));
  connect(Te_mes.T, Te)
    annotation (Line(points={{31,-42},{40,-42},{40,-70}},
                                                       color={0,0,127}));
  connect(Te_mes.port, turbine.outlet) annotation (Line(points={{24,-32},{24,7.8},
          {23.6,7.8}},      color={0,127,255}));
  connect(Tf_mes.T, Tf)
    annotation (Line(points={{55,-42},{60,-42},{60,-70}},
                                                       color={0,0,127}));
  connect(Tf_mes.port, combChamber.out) annotation (Line(points={{48,-32},{48,-20},
          {4,-20},{4,12}},       color={0,127,255}));

initial equation
  phi = phi_start;
    annotation (Dialog(tab="Initialisation", group="Combustion chamber"),
    experiment(StopTime=100, Interval=1),
    experimentSetupOutput,
    Documentation(info="<html>

</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
        graphics={ Text(
          extent={{-128,-48},{128,-88}},
          lineColor={0,0,255},
          textString="%name")}));
end GasTurbineUnit;
