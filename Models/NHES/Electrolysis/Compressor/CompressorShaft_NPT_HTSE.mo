within NHES.Electrolysis.Compressor;
model CompressorShaft_NPT_HTSE "Gas compressor"
  extends BaseClasses.CompressorBase_HTSE(pstart_out=pstart_in*PR0);

  parameter Real eta_mech0 = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Real eta0 = 0.86
     "Isentropic efficiency" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Real PR0 "Compression ratio" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter SI.MassFlowRate w0 "Nominal gas flow rate" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nrpm0=3600
    "Rated rotational speed of the shaft in rpm"
    annotation (Dialog(tab="General", group="Nominal conditions"));
  final parameter SI.AngularVelocity N0 = Modelica.Units.Conversions.from_rpm(  Nrpm0)
    "Rated rotational speed of the shaft in rad/s";
  //parameter SI.MomentOfInertia J = 1892/6 "Moment of inertia" annotation (Dialog(tab="General", group="Nominal conditions"));
  parameter SI.Angle phi_start = 0 "Shaft rotation angle start value in radian" annotation (Dialog(tab="Initialisation", group="Shaft"));

  parameter Electrolysis.Types.ThetaIGV thetaIGV0=85 "Nominal IGV angle"
    annotation (Dialog(tab="General", group="Nominal conditions"));
  parameter SI.Pressure pin0 = 1.01325*1e5 "Nominal inlet pressure" annotation(Dialog(tab="Air flow dynamics"));
  parameter SI.Temperature Tin0 = 15 + 273.15 "Nominal inlet temperature" annotation(Dialog(tab="Air flow dynamics"));

  parameter Boolean use_in_thetaIGV = false
     "Use connector input for the nominal IGV angle"
                                                    annotation(Dialog(group="External inputs"), choices(checkBox=true));

  // Air flow dynamics parameters
  final parameter Electrolysis.Types.ThetaIGV thetaIGV_start=thetaIGV0
    "IGV angle start value";
  parameter Electrolysis.Types.ThetaIGV thetaIGVmin=11.6 "Minimum IGV angle"
                        annotation (Dialog(tab="Air flow dynamics"));
  parameter Electrolysis.Types.ThetaIGV thetaIGVmax=85 "Maximum IGV angle"
                        annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A0(final unit="1") = 0.945 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A1(final unit="1") = -7.8 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A2(final unit="1") = 39 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));

  SI.Angle phi(start=0) "Shaft rotation angle";
  SI.Torque tau "Net torque acting on the turbine";
  SI.AngularVelocity N(min=0, start=N0) "Shaft angular velocity (frequency)";

  Real p_in_reduced(min=0, start=1, unit="1") "Reduced inlet pressure";
  Real T_in_reduced(min=0, start=1, unit="1") "Reduced inlet temperature";

  Real N_pu(min=0, start=1, unit="1")
     "Per unit value (normalized) of the angular velocity of the shaft";
  Real N_T_pu( start=1, unit="1") "Temperature dependency of N_pu";
  Real deltaN_T_pu( start=1, unit="1") "Frequency dependency of N_T_pu";
  Real w_IGV(start=1,unit="1") "IGV angle dependent mass flow rate";

  Electrolysis.Types.ThetaIGV thetaIGV(
    min=thetaIGVmin,
    max=thetaIGVmax,
    start=thetaIGV_start);

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-70,-10},{-50,10}}),
        iconTransformation(extent={{-70,-10},{-50,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Interfaces.RealInput in_thetaIGV if use_in_thetaIGV annotation (Placement(
        transformation(
        origin={-44,-40},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,-40})));

protected
  Modelica.Blocks.Interfaces.RealInput in_thetaIGV_internal;

equation
  eta_mech = eta_mech0;
  eta = eta0;
  //PR = PR0*(w0/w);
  Wc = tau*N;

  p_in_reduced = pin/pin0;
  T_in_reduced = sqrt(Tin0/Ti);
  N_pu = N/N0;
  N_T_pu = N_pu*T_in_reduced-1;
  deltaN_T_pu = 1 + A0*N_T_pu + A1*N_T_pu^2 + A2*N_T_pu^3;
  w_IGV =(sin(Modelica.Units.Conversions.from_deg(thetaIGV - thetaIGVmin))/sin(
    Modelica.Units.Conversions.from_deg(thetaIGVmax - thetaIGVmin)));
  //w = (PR0*w0/PR)*deltaN_T_pu*p_in_reduced*T_in_reduced*(sin(Modelica.SIunits.Conversions.from_deg(thetaIGV-thetaIGVmin))/sin(Modelica.SIunits.Conversions.from_deg(thetaIGVmax-thetaIGVmin)));
  w = (PR0*w0/PR)*deltaN_T_pu*p_in_reduced*T_in_reduced*w_IGV;

  thetaIGV = in_thetaIGV_internal;
  if not use_in_thetaIGV then
    in_thetaIGV_internal = thetaIGV0 "IGV angle set by parameter";
  end if;

  // ----- Mechanical boundary conditions -----
  shaft_a.phi = phi;
  shaft_b.phi = phi;
  shaft_a.tau + shaft_b.tau = tau;
  der(phi) = N;

  // Connect protected connectors to public conditional connectors
  connect(in_thetaIGV, in_thetaIGV_internal);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end CompressorShaft_NPT_HTSE;
