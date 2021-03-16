within NHES.Nuclear.FuelModels;
model FuelGapClad_FD2DCyl
  "2D Cylindrical Finite Difference model of a fuel element with three sections: Fuel, gap, and cladding"

  /* General */
  replaceable model SolutionMethod_FD =
      NHES.Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.AxVolCentered_2O
    constrainedby
    NHES.Thermal.Conduction.FiniteDifference.Cylindrical.BaseClasses.Partial_FDCond_Cylinder
    annotation (choicesAllMatching=true);
  parameter SI.Length length "Height of fueled region"
    annotation (Dialog(group="Geometry"));
  parameter SI.Length r_inner_fuel=0 "Outer radius of fuel"
    annotation (Dialog(group="Geometry"));
  parameter SI.Length r_outer_fuel "Outer radius of fuel"
    annotation (Dialog(group="Geometry"));
  parameter SI.Length r_outer_gap "Outer radius of gap"
    annotation (Dialog(group="Geometry"));
  parameter SI.Length r_outer_clad "Outer radius of cladding"
    annotation (Dialog(group="Geometry"));
  parameter Integer nFuelPins=1 "# of fuel pins"
  annotation(Dialog(group="Power Scaling"));
  replaceable package fuelType =
      NHES.Media.Interfaces.PartialAlloy
  annotation (choicesAllMatching=true,Dialog(group="Materials"));
  replaceable package gapType = NHES.Media.Interfaces.PartialAlloy
  annotation (choicesAllMatching=true,Dialog(group="Materials"));
  replaceable package cladType =
      NHES.Media.Interfaces.PartialAlloy
  annotation (choicesAllMatching=true,Dialog(group="Materials"));

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balances" annotation(Dialog(tab="Assumptions",group="Dynamics"));

  /* Advanced */
  parameter Integer nAxial=4 "# of discrete axial volumes"
    annotation (Dialog(tab="Advanced",group="Nodalization"));
  parameter Integer nRadial_fuel=3 "# nodes in fuel radial direction"
    annotation (Dialog(tab="Advanced",group="Nodalization"));
  parameter Integer nRadial_gap=3 "# of nodes in gap radial direction"
    annotation (Dialog(tab="Advanced",group="Nodalization"));
  parameter Integer nRadial_clad=3 "# of nodes in cladding radial direction"
    annotation (Dialog(tab="Advanced",group="Nodalization"));
  parameter SI.Length r_fuel[nRadial_fuel]=linspace(r_inner_fuel,r_outer_fuel,nRadial_fuel)
    "Fuel radial spacing"
    annotation (Dialog(tab="Advanced",group="Custom Node Locations"));
  parameter SI.Length r_gap[nRadial_gap]=linspace(r_outer_fuel,r_outer_gap,nRadial_gap)
    "Gap radial spacing"
    annotation (Dialog(tab="Advanced",group="Custom Node Locations"));
  parameter SI.Length r_clad[nRadial_clad]=linspace(r_outer_gap,r_outer_clad,nRadial_clad)
    "Cladding radial spacing"
    annotation (Dialog(tab="Advanced",group="Custom Node Locations"));
  parameter SI.Length z[nAxial]=linspace(0.5*length/nAxial,length*(1 - 0.5/nAxial), nAxial)
    "Axial spacing"
    annotation (Dialog(tab="Advanced",group="Custom Node Locations"));

  /* Initialization */
  parameter SI.Temperature Tref_fuel "Initial fuel temperature"
                                annotation (Dialog(tab="Initialization"));
  parameter SI.Temperature Tref_gap "Initial gap temperature"
    annotation (Dialog(tab="Initialization"));
  parameter SI.Temperature Tref_clad "Initial cladding temperature"
                                   annotation (Dialog(tab="Initialization"));

  NHES.Thermal.Conduction.FiniteDifference.Cylinder_FD Fuel(
    use_q_ppp=true,
    Tref(displayUnit="K") = Tref_fuel,
    length=length,
    nRadial=nRadial_fuel,
    nAxial=nAxial,
    redeclare package material = fuelType,
    energyDynamics=energyDynamics,
    redeclare model SolutionMethod_FD = SolutionMethod_FD,
    r_outer=r_outer_fuel,
    r=r_fuel,
    z=z,
    T_start=T_start_fuel)
    annotation (Placement(transformation(extent={{-53,-17},{-21,17}})));

  NHES.Thermal.Conduction.FiniteDifference.Cylinder_FD Gap(
    r_inner=Fuel.r_outer,
    nAxial=Fuel.nAxial,
    length=Fuel.length,
    Tref(displayUnit="K") = Tref_gap,
    nRadial=nRadial_gap,
    redeclare package material = gapType,
    energyDynamics=energyDynamics,
    redeclare model SolutionMethod_FD = SolutionMethod_FD,
    r_outer=r_outer_gap,
    r=r_gap,
    z=z,
    T_start=T_start_gap)
    annotation (Placement(transformation(extent={{-18,-19},{16,19}})));

  NHES.Thermal.Conduction.FiniteDifference.Cylinder_FD Cladding(
    r_inner=Gap.r_outer,
    nAxial=Fuel.nAxial,
    length=Fuel.length,
    Tref(displayUnit="K") = Tref_clad,
    nRadial=nRadial_clad,
    redeclare package material = cladType,
    energyDynamics=energyDynamics,
    redeclare model SolutionMethod_FD = SolutionMethod_FD,
    r_outer=r_outer_clad,
    r=r_clad,
    z=z,
    T_start=T_start_clad)
    annotation (Placement(transformation(extent={{18,-18},{48,18}})));

  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD(nNodes=Fuel.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-4},{5,4}},
        rotation=-90,
        origin={-37,22})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD1(nNodes=Fuel.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-4},{5,4}},
        rotation=90,
        origin={-37,-22})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD2(nNodes=Gap.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-4},{5,4}},
        rotation=-90,
        origin={-1,22})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD3(nNodes=Gap.nRadial) annotation (Placement(
        transformation(
        extent={{-6,-4},{6,4}},
        rotation=90,
        origin={-1,-23})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD4(nNodes=Cladding.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-4},{5,4}},
        rotation=-90,
        origin={33,22})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD5(nNodes=Cladding.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-4},{5,4}},
        rotation=90,
        origin={33,-22})));
  NHES.Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD6(nNodes=Fuel.nAxial)
    annotation (Placement(transformation(extent={{-62,-4},{-52,4}})));
  NHES.Thermal.Conduction.FiniteDifference.Interfaces.AxPowTOAxVolHeat PtoQConv(
    r_inner=Fuel.r_inner,
    r_outer=Fuel.r_outer,
    length=Fuel.length,
    nRadial=Fuel.nRadial,
    nAxial=Fuel.nAxial,
    nElem=nFuelPins) annotation (Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={-73,30})));
  NHES.Thermal.Conduction.FiniteDifference.Interfaces.ScalePower scalePower(nNodes=
        Fuel.nAxial, nElem=nFuelPins)
    annotation (Placement(transformation(extent={{60,-7},{80,7}})));
  Modelica.Blocks.Interfaces.RealInput           Power_in[size(PtoQConv.Power_in,
    1)] "Input Axial Power Distribution (volume approach)" annotation (
      Placement(transformation(extent={{-140,10},{-100,50}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Fluid.Interfaces.HeatPorts_b heatPorts_b[Fuel.nAxial] annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={100,0}), iconTransformation(
        extent={{-35,-10},{35,10}},
        rotation=-90,
        origin={102,1})));
  parameter SI.Temperature T_start_fuel[nRadial_fuel,nAxial]=fill(
      Tref_fuel,
      nRadial_fuel,
      nAxial) annotation (Dialog(tab="Initialization"));
  parameter SI.Temperature T_start_gap[nRadial_gap,nAxial]=[{T_start_fuel[end, :]};
      fill(
      Tref_gap,
      nRadial_gap - 1,
      nAxial)] annotation (Dialog(tab="Initialization"));
  parameter SI.Temperature T_start_clad[nRadial_clad,nAxial]=[{T_start_gap[end, :]};
      fill(
      Tref_clad,
      nRadial_clad - 1,
      nAxial)] annotation (Dialog(tab="Initialization"));
equation
  connect(Fuel.heatPorts_outer,Gap. heatPorts_inner) annotation (Line(points={{-27.56,
          0},{-29.56,0},{-11.03,0}},           color={127,0,0}));
  connect(Gap.heatPorts_outer,Cladding. heatPorts_inner) annotation (Line(
        points={{9.03,0},{7.03,0},{24.15,0}},      color={127,0,0}));
  connect(adiabatic_FD6.port,Fuel. heatPorts_inner) annotation (Line(points={{-52,0},
          {-46.44,0}},                    color={191,0,0}));
  connect(adiabatic_FD.port,Fuel. heatPorts_top)
    annotation (Line(points={{-37,17},{-37,10.37}}, color={191,0,0}));
  connect(adiabatic_FD1.port,Fuel. heatPorts_bottom)
    annotation (Line(points={{-37,-17},{-37,-10.03}}, color={191,0,0}));
  connect(PtoQConv.q_ppp,Fuel. q_ppp_input) annotation (Line(points={{-56.5,30},
          {-43.4,6.8}},              color={0,0,127}));
  connect(adiabatic_FD2.port,Gap. heatPorts_top) annotation (Line(points={{-1,17},
          {-1,13.5},{-1,11.59}},   color={191,0,0}));
  connect(adiabatic_FD4.port,Cladding. heatPorts_top) annotation (Line(points={{33,17},
          {33,13.5},{33,10.98}},                  color={191,0,0}));
  connect(adiabatic_FD5.port,Cladding. heatPorts_bottom) annotation (Line(
        points={{33,-17},{33,-14.5},{33,-10.62}},            color={191,0,0}));
  connect(adiabatic_FD3.port,Gap. heatPorts_bottom) annotation (Line(points={{-1,-17},
          {-1,-14.5},{-1,-11.21}},        color={191,0,0}));
  connect(Cladding.heatPorts_outer,scalePower. heatPorts_a)
    annotation (Line(points={{41.85,0},{54,0},{54,8.88178e-016},{60,
          8.88178e-016}},                           color={127,0,0}));
  connect(Power_in, PtoQConv.Power_in)
    annotation (Line(points={{-120,30},{-91,30}}, color={0,0,127}));
  connect(scalePower.heatPorts_b, heatPorts_b)
    annotation (Line(points={{80,8.88178e-016},{90,8.88178e-016},{90,0},{100,0}},
                                              color={127,0,0}));
  annotation (defaultComponentName="fuelModel",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-149,142},{151,102}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-100,100},{100,-100}},
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135},
          pattern=LinePattern.None),
        Ellipse(
          extent={{-90,90},{90,-90}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-81,80},{81,-80}},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}));
end FuelGapClad_FD2DCyl;
