within NHES.Electrolysis.Turbine;
model TurbineShaft_PowerOut_NPT_HTSE "Turbine"
  extends BaseClasses.TurbineBase_HTSE(pstart_in=pstart_out*PR0, w(start=w0));
  parameter Real eta_mech0 = 0.98 "Mechanical efficiency" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Real eta0 = 0.89 "Isentropic efficiency" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Real PR0 "Compression ratio" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter SI.MassFlowRate w0 "Gas flow rate" annotation(Dialog(tab="General", group="Nominal conditions"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nrpm0=3600
    "Rated rotational speed of the shaft in rpm"
    annotation (Dialog(tab="General", group="Nominal conditions"));
  final parameter SI.AngularVelocity N0 = Modelica.Units.Conversions.from_rpm(  Nrpm0)
    "Rated rotational speed of the shaft in rad/s";
  //parameter SI.MomentOfInertia J = 1892/6 "Moment of inertia" annotation (Dialog(tab="General", group="Mechanical propperties"));
  parameter SI.Angle phi_start = 0 "Shaft rotation angle start value in radian" annotation (Dialog(tab="Initialisation", group="Shaft"));

  parameter SI.Pressure pin0 = 17.307*1e5 "Nominal inlet pressure" annotation(Dialog(tab="Air flow dynamics"));
  parameter SI.Temperature Tin0 = 332.691 + 273.15 "Nominal inlet temperature" annotation(Dialog(tab="Air flow dynamics"));

  // Air flow dynamics parameters
  parameter Real A0(final unit="1") = 0.945 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A1(final unit="1") = -7.8 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));
  parameter Real A2(final unit="1") = 39 "Air flow speed factor" annotation (Dialog(tab="Air flow dynamics"));

  SI.Angle phi(start=0) "Shaft rotation angle";
  SI.Torque tau "Net torque acting on the turbine";
  SI.AngularVelocity N( start=N0) "Shaft angular velocity";

  Real p_in_reduced(min=0, start=1, unit="1") "Reduced inlet pressure";
  Real T_in_reduced(min=0, start=1, unit="1") "Reduced inlet temperature";

  Real N_pu(min=0, start=1, unit="1")
     "Per unit value (normalized) of the angular velocity of the shaft";
  Real N_T_pu( start=1, unit="1") "Temperature dependency of N_pu";
  Real deltaN_T_pu( start=1, unit="1") "Frequency dependency of N_T_pu";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a annotation (
      Placement(transformation(extent={{-70,-10},{-50,10}}),
        iconTransformation(extent={{-70,-10},{-50,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  Modelica.Blocks.Interfaces.RealOutput W_GT( final unit="W", displayUnit="MW") annotation (Placement(transformation(
          extent={{32,20},{52,40}}), iconTransformation(extent={{28,40},{44,
            56}})));
  Modelica.Blocks.Sources.RealExpression powerGeneration(y=Wt) annotation (
      Placement(transformation(
        extent={{-10,-12},{10,12}},
        rotation=0,
        origin={0,30})));
equation
  eta_mech = eta_mech0;
  eta = eta0;
  //PR = PR0*(w/w0);
  Wt = tau*N;

  p_in_reduced = pin/pin0;
  T_in_reduced = sqrt(Tin0/Tf);
  N_pu = N/N0;
  N_T_pu = N_pu*T_in_reduced-1;
  deltaN_T_pu = 1 + A0*N_T_pu + A1*N_T_pu^2 + A2*N_T_pu^3;
  w = (PR*w0/PR0)*deltaN_T_pu*p_in_reduced*T_in_reduced;

  // ----- Mechanical boundary conditions -----
  shaft_a.phi = phi;
  shaft_b.phi = phi;
  shaft_a.tau + shaft_b.tau = tau;
  der(phi) = N;

  connect(powerGeneration.y, W_GT)
    annotation (Line(points={{11,30},{42,30}}, color={0,0,127}));
  annotation (Documentation(info="<html>
</html>"));
end TurbineShaft_PowerOut_NPT_HTSE;
