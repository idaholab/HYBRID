within NHES.Thermal.Conduction.FiniteDifference.Cylindrical.BaseClasses;
partial model Partial_BaseFDCond_Cylinder
  import      Modelica.Units.SI;

  /* General */
  replaceable package material = NHES.Media.Solids.SS316
    constrainedby NHES.Media.Interfaces.PartialAlloy
    "Specify material type"
    annotation(choicesAllMatching=true,Dialog(group="Material"));
  parameter Boolean use_q_ppp = false
    "Toggle volumetric heat generation interface"
   annotation(Evaluate=true,choices(checkBox=true));

  parameter SI.Length r_inner(min=0) = 0 "Centerline/Inner radius of cylinder"
  annotation(Dialog(group="Geomety"));
  parameter SI.Length r_outer "Outer radius of cylinder"
  annotation(Dialog(group="Geomety"));
  parameter SI.Length[nRadial] r = linspace(r_inner, r_outer, nRadial)
    "Define radial spacing"
  annotation(Dialog(group="Geomety"));
  parameter SI.Length[nAxial] z = linspace(0, length, nAxial)
    "Define axial spacing"
  annotation(Dialog(group="Geomety"));

  parameter SI.Length length "Length of cylinder"
  annotation(Dialog(group="Geomety"));
  parameter Integer nRadial(min=3) = 3 "Nodes in radial direction"
  annotation(Dialog(group="Nodalization"));
  parameter Integer nAxial(min=3) = 3 "Nodes in axial direction"
  annotation(Dialog(group="Nodalization"));

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics = Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balances" annotation(Dialog(tab="Assumptions",group="Dynamics"));

  /* Initialization */
  parameter SI.Temperature Tref = 273.15 "Center nodes initial temperature"
   annotation(Dialog(tab="Initialization"));
  parameter SI.Temperature[nRadial,nAxial] T_start = fill(Tref,nRadial,nAxial)
  annotation(Dialog(tab="Initialization"));

  Modelica.Blocks.Interfaces.RealInput[nRadial,nAxial] q_ppp_input(unit="W/m3") if use_q_ppp
    "Volumetric heat generation"
    annotation (Placement(transformation(extent={{-130,45},{-100,75}}),
        iconTransformation(extent={{-6,-6},{6,6}},    rotate,
        rotation=-45,
        origin={-40,40})));
  Modelica.Fluid.Interfaces.HeatPorts_a[nAxial] heatPorts_inner(T(start=T_start[1,:]))
    "Heat interface on inner boundary"
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0}),iconTransformation(
        extent={{-20,-5},{20,5}},
        rotation=-90,
        origin={-59,0})));
  Modelica.Fluid.Interfaces.HeatPorts_a[nAxial] heatPorts_outer(T(start=T_start[end,:]))
    "Heat interface on outer boundary"
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,0}),iconTransformation(
        extent={{-20,-5},{20,5}},
        rotation=-90,
        origin={59,0})));
  Modelica.Fluid.Interfaces.HeatPorts_a[nRadial] heatPorts_bottom(T(start=T_start[:,1]))
    "Heat interface on bottom boundary"
    annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
          extent={{-20,-64},{20,-54}})));
  Modelica.Fluid.Interfaces.HeatPorts_a[nRadial] heatPorts_top(T(start=T_start[:,end]))
    "Heat interface on top boundary"
    annotation (
      Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(
          extent={{-20,56},{20,66}})));

equation
  assert(r_outer > r_inner, "r_inner must be greater than r_outer");
  assert(r[1] == r_inner, "r_inner and r[1] must be equal");
  assert(r[end] == r_outer, "r_outer and r[end] must be equal");
  assert(size(r,1) == nRadial, "r and nRadial must have equal sizes");
  assert(size(z,1) == nAxial, "z and nAxial must have equal sizes");
  assert(length > 0, "length of cylinder must be greater than zero");
  assert(z[1] >= 0, "cylinder length z[1] must be >= 0");
  assert(z[end] <= length, "cylinder length z[1] must be >= 0");
  //assert((length-abs(z[end]-z[1]))/length < 1e-3, "length of cylinder must be equal to length of z");

end Partial_BaseFDCond_Cylinder;
