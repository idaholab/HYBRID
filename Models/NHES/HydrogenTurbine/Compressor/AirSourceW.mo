within NHES.HydrogenTurbine.Compressor;
model AirSourceW "Air mass flow source"
  extends HydrogenTurbine.Icons.AirSourceW;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation(choicesAllMatching = true);
  Medium.BaseProperties gas(
    p(start=p0),
    T(start=T0),
    Xi(start=X0[1:Medium.nXi]));
  parameter Modelica.Units.SI.Pressure p0=1.01325*1e5 "Nominal pressure";
  parameter Modelica.Units.SI.Temperature T0=15 + 273.15 "Nominal temperature";
  parameter Modelica.Units.SI.MassFraction X0[Medium.nX]=Medium.reference_X
    "Nominal gas composition";
  parameter Modelica.Units.SI.MassFlowRate w0=108.408 "Nominal mass flow rate";
  parameter HydrogenTurbine.Types.ThetaIGV thetaIGV0=85 "Nominal IGV angle";
  parameter Modelica.Units.SI.AngularVelocity N0=3600*Modelica.Constants.pi*2/
      60 "Nominal angular velocity of the shaft";

  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction" annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Boolean use_in_thetaIGV = false
    "Use connector input for the nominal IGV angle" annotation(Dialog(group="External inputs"), choices(checkBox=true));
  parameter Boolean use_in_N = false
    "Use connector input for the nominal frequency of the shaft" annotation(Dialog(group="External inputs"), choices(checkBox=true));
  parameter Boolean use_in_T = false "Use connector input for the temperature" annotation(Dialog(group="External inputs"), choices(checkBox=true));
  parameter Boolean use_in_X = false "Use connector input for the composition" annotation(Dialog(group="External inputs"), choices(checkBox=true));
  outer Modelica.Fluid.System system "System wide properties";

  // Air flow dynamics parameters
  final parameter HydrogenTurbine.Types.ThetaIGV thetaIGV_start=thetaIGV0
    "IGV angle start value";
  parameter HydrogenTurbine.Types.ThetaIGV thetaIGVmin=11.6 "Minimum IGV angle"
    annotation (Dialog(tab="Air flow dynamics"));
  parameter HydrogenTurbine.Types.ThetaIGV thetaIGVmax=85 "Maximum IGV angle"
    annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A0(final unit="1") = 0.945 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A1(final unit="1") = -7.8 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A2(final unit="1") = 39 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));

  Modelica.Units.SI.MassFlowRate w(start=w0) "Mass flow rate";
  Modelica.Units.SI.Pressure p_in "Inlet pressure";
  Real p_in_reduced(min=0, start=1, unit="1") "Reduced inlet pressure";
  Real T_in_reduced(min=0, start=1, unit="1") "Reduced inlet temperature";
  Modelica.Units.SI.AngularVelocity N(min=0, start=N0)
    "Angular velocity (frequency) of the shaft";
  Real N_pu(min=0, start=1, unit="1")
    "Per unit value (normalized) of the angular velocity of the shaft";
  Real N_T_pu( start=1, unit="1") "Temperature dependency of N_pu";
  Real deltaN_T_pu( start=1, unit="1") "Frequency dependency of N_T_pu";

  HydrogenTurbine.Types.ThetaIGV thetaIGV(start=thetaIGV_start);

  Modelica.Blocks.Interfaces.RealInput in_thetaIGV if use_in_thetaIGV annotation (Placement(
        transformation(
        origin={-80,70},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-74,70})));
  Modelica.Blocks.Interfaces.RealInput in_N if use_in_N annotation (Placement(
        transformation(
        origin={40,70},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={34,70})));
  Modelica.Blocks.Interfaces.RealInput in_T if use_in_T annotation (Placement(
        transformation(
        origin={-20,90},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,90})));
  Modelica.Blocks.Interfaces.RealInput in_X[Medium.nX] if use_in_X annotation (Placement(
        transformation(
        origin={-100,30},
        extent={{-10,-10},{10,10}},
        rotation=0),   iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-104,32})));
  Modelica.Fluid.Interfaces.FluidPort_b flange(redeclare package Medium =
        Medium, m_flow(max=if allowFlowReversal then +Modelica.Constants.inf
           else 0)) annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0), iconTransformation(extent={{90,-10},{110,10}})));

protected
  Modelica.Blocks.Interfaces.RealInput in_thetaIGV_internal;
  Modelica.Blocks.Interfaces.RealInput in_N_internal;
  Modelica.Blocks.Interfaces.RealInput in_T_internal;
  Modelica.Blocks.Interfaces.RealInput in_X_internal[Medium.nX];

equation
  p_in_reduced = p_in/p0;
  T_in_reduced = sqrt(T0/in_T_internal);
  N_pu = N/N0;
  N_T_pu = N_pu*T_in_reduced-1;
  deltaN_T_pu = 1 + A0*N_T_pu + A1*N_T_pu^2 + A2*N_T_pu^3;
  w =w0*deltaN_T_pu*p_in_reduced*T_in_reduced*(sin(
    Modelica.Units.Conversions.from_deg(thetaIGV - thetaIGVmin))/sin(
    Modelica.Units.Conversions.from_deg(thetaIGVmax - thetaIGVmin)));
  flange.m_flow = -w;

  thetaIGV = in_thetaIGV_internal;
  if not use_in_thetaIGV then
    in_thetaIGV_internal = thetaIGV0 "IGV angle set by parameter";
  end if;

  N = in_N_internal;
  if not use_in_N then
    in_N_internal = N0 "Frequency of the shaft set by parameter";
  end if;

  gas.T = in_T_internal;
  if not use_in_T then
    in_T_internal = T0 "Temperature set by parameter";
  end if;

  gas.Xi = in_X_internal[1:Medium.nXi];
  if not use_in_X then
    in_X_internal = X0 "Composition set by parameter";
  end if;

  gas.p = p_in;
  flange.p = gas.p;
  flange.h_outflow = gas.h;
  flange.Xi_outflow = gas.Xi;

  // Connect protected connectors to public conditional connectors
  connect(in_thetaIGV, in_thetaIGV_internal);
  connect(in_N, in_N_internal);
  connect(in_T, in_T_internal);
  connect(in_X, in_X_internal);

  annotation (Documentation(info="<html>
<p>The actual gas used in the component is determined by the replaceable <tt>Medium</tt> package. In the case of multiple component, variable composition gases, the nominal gas composition is given by <tt>X0</tt>,whose default value is <tt>Medium.reference_X</tt> .
<p>If the <tt>in_thetaIGV</tt> connector is wired, then the source inlet guide vane angle is given by the corresponding signal, otherwise it is fixed to <tt>thetaIGV0</tt>.</p>
<p>If the <tt>in_N</tt> connector is wired, then the source angular velocity of the shaft is given by the corresponding signal, otherwise it is fixed to <tt>N0</tt>.</p>
<p>If the <tt>in_T</tt> connector is wired, then the source temperature is given by the corresponding signal, otherwise it is fixed to <tt>T0</tt>.</p>
<p>If the <tt>in_X</tt> connector is wired, then the source massfraction is given by the corresponding signal, otherwise it is fixed to <tt>X0</tt>.</p>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
             100,100}}),
        graphics={ Text(
          extent={{-128,-92},{128,-132}},
          lineColor={0,0,255},
          textString="%name")}));
end AirSourceW;
