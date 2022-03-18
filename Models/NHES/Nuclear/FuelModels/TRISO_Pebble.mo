within NHES.Nuclear.FuelModels;
model TRISO_Pebble "TRISO model estimate"
  parameter Real nKernel_per_Pebble = 15000;
  parameter Real nPebble = 55000;
  parameter Integer nR_Fuel = 1;
  parameter Integer n_Power_Region =  1;
  parameter Modelica.Units.SI.Length r_Pebble = 0.03;
  parameter Modelica.Units.SI.Length r_Fuel = 200e-6;
  parameter Modelica.Units.SI.Length r_Buffer = r_Fuel + 100e-6;
  parameter Modelica.Units.SI.Length r_IPyC = r_Buffer+40e-6;
  parameter Modelica.Units.SI.Length r_SiC = r_IPyC+35e-6;
  parameter Modelica.Units.SI.Length r_OPyC = r_SiC+40e-6;
  parameter Modelica.Units.SI.ThermalConductivity k_Buffer= 2.25;
  parameter Modelica.Units.SI.ThermalConductivity k_IPyC = 8.0;
  parameter Modelica.Units.SI.ThermalConductivity k_SiC = 175;
  parameter Modelica.Units.SI.ThermalConductivity k_OPyC = 8.0;
  parameter Modelica.Units.SI.Temperature Pebble_Surface_Init = 750+273.15 annotation(dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature Pebble_Center_Init = 1100+273.15 annotation(dialog(tab = "Initialization"));

  Modelica.Units.SI.Temperature T_Fuel;
  Modelica.Units.SI.Temperature T_Kernel_outer;
  Modelica.Units.SI.Temperature T_Kernel_outer_centerline;
  replaceable package Fuel_Kernel_Material =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Fission material"
  annotation (choicesAllMatching=true);
  replaceable package Pebble_Material =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                   "Bulk pebble material in which fuel is embedded" annotation (choicesAllMatching=true);

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balances" annotation(Dialog(tab="Advanced",group="Dynamics"));

  Modelica.Blocks.Interfaces.RealInput           Power_in "Input Axial Power Distribution (volume approach)" annotation (
      Placement(transformation(extent={{-166,-4},{-126,36}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel(
    redeclare package Material = Fuel_Kernel_Material,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=nR_Fuel, r_outer=r_Fuel),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=division_kernel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
    annotation (Placement(transformation(extent={{-46,-14},{-26,6}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer(
    r_in=r_Fuel,
    r_out=r_Buffer,
    lambda=k_Buffer)
    annotation (Placement(transformation(extent={{-6,-14},{14,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC(
    r_in=r_Buffer,
    r_out=r_IPyC,
    lambda=k_IPyC)
    annotation (Placement(transformation(extent={{20,-14},{40,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC(
    r_in=r_IPyC,
    r_out=r_SiC,
    lambda=k_SiC)
    annotation (Placement(transformation(extent={{48,-14},{68,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC(
    r_in=r_SiC,
    r_out=r_OPyC,
    lambda=k_OPyC)
    annotation (Placement(transformation(extent={{74,-14},{94,6}})));
  Modelica.Blocks.Math.Division division_kernel
    annotation (Placement(transformation(extent={{-74,40},{-54,20}})));
  Modelica.Blocks.Sources.Constant const(k=nKernel_per_Pebble*
        Fuel_kernel.geometry.nR)
    annotation (Placement(transformation(extent={{-112,38},{-92,58}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic
    annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic1
    annotation (Placement(transformation(extent={{-66,-46},{-46,-26}})));

  Modelica.Blocks.Math.Division division_pebble
    annotation (Placement(transformation(extent={{-112,34},{-92,14}})));
  Modelica.Blocks.Sources.Constant const1(k=nPebble)
    annotation (Placement(transformation(extent={{-148,38},{-128,58}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Pebble(
    redeclare package Material = Pebble_Material,
    T_a1_start=Pebble_Surface_Init,
    T_b1_start=Pebble_Center_Init,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=4, r_outer=r_Pebble),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=division_pebble.y*3/(4*Modelica.Constants.pi*r_Pebble^3)))
    annotation (Placement(transformation(extent={{-12,24},{8,44}})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(use_port=
        true) annotation (Placement(transformation(extent={{126,-12},{106,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=T_Kernel_outer)
    annotation (Placement(transformation(extent={{100,24},{120,44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic2
    annotation (Placement(transformation(extent={{-48,34},{-28,54}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic3
    annotation (Placement(transformation(extent={{-48,16},{-28,36}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.Interfaces.ScalePower
    scalePower(nNodes=1, nParallel=nPebble)
    annotation (Placement(transformation(extent={{28,45},{48,59}})));
  Modelica.Fluid.Interfaces.HeatPorts_b heatPorts_b annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={78,52}),  iconTransformation(
        extent={{-35,-10},{35,10}},
        rotation=-90,
        origin={102,1})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel_center(
    redeclare package Material = Fuel_Kernel_Material,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=nR_Fuel, r_outer=r_Fuel),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=division_kernel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
    annotation (Placement(transformation(extent={{-44,-72},{-24,-52}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer_center_kernel(
    r_in=r_Fuel,
    r_out=r_Buffer,
    lambda=k_Buffer)
    annotation (Placement(transformation(extent={{-4,-72},{16,-52}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC_center_kernel(
    r_in=r_Buffer,
    r_out=r_IPyC,
    lambda=k_IPyC)
    annotation (Placement(transformation(extent={{22,-72},{42,-52}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC_center_kernel(
    r_in=r_IPyC,
    r_out=r_SiC,
    lambda=k_SiC)
    annotation (Placement(transformation(extent={{50,-72},{70,-52}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC_center_kernel(
    r_in=r_SiC,
    r_out=r_OPyC,
    lambda=k_OPyC)
    annotation (Placement(transformation(extent={{76,-72},{96,-52}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic4
    annotation (Placement(transformation(extent={{-78,-72},{-58,-52}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic5
    annotation (Placement(transformation(extent={{-64,-104},{-44,-84}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(use_port=
        true)
    annotation (Placement(transformation(extent={{128,-70},{108,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=
        T_Kernel_outer_centerline)
    annotation (Placement(transformation(extent={{102,-34},{122,-14}})));
equation
  T_Fuel = Fuel_kernel.port_a1.T;
  T_Kernel_outer_centerline = Pebble.port_a1.T;
  T_Kernel_outer = Pebble.materials[3].T;

  connect(const.y, division_kernel.u2)
    annotation (Line(points={{-91,48},{-76,48},{-76,36}},
                                                  color={0,0,127}));
  connect(adiabatic1.port, Fuel_kernel.port_external[1]) annotation (Line(
        points={{-46,-36},{-28,-36},{-28,-20},{-42,-20},{-42,-12},{-44,-12}},
        color={191,0,0}));
  connect(adiabatic.port, Fuel_kernel.port_a1)
    annotation (Line(points={{-60,-4},{-46,-4}}, color={191,0,0}));
  connect(Fuel_kernel.port_b1, Buffer.port_a)
    annotation (Line(points={{-26,-4},{-3,-4}}, color={191,0,0}));
  connect(Buffer.port_b, IPyC.port_a)
    annotation (Line(points={{11,-4},{23,-4}}, color={191,0,0}));
  connect(IPyC.port_b, SiC.port_a)
    annotation (Line(points={{37,-4},{51,-4}}, color={191,0,0}));
  connect(SiC.port_b, OPyC.port_a)
    annotation (Line(points={{65,-4},{77,-4}}, color={191,0,0}));
  connect(Power_in, division_pebble.u1) annotation (Line(points={{-146,16},{-120,
          16},{-120,18},{-114,18}}, color={0,0,127}));
  connect(division_pebble.u2, const1.y) annotation (Line(points={{-114,30},{-120,
          30},{-120,48},{-127,48}}, color={0,0,127}));
  connect(division_pebble.y, division_kernel.u1) annotation (Line(points={{-91,24},
          {-76,24}},                                     color={0,0,127}));
  connect(realExpression.y, boundary.T_ext) annotation (Line(points={{121,34},{140,
          34},{140,30},{160,30},{160,0},{150,0},{150,-2},{120,-2}}, color={0,0,127}));
  connect(boundary.port, OPyC.port_b)
    annotation (Line(points={{106,-2},{91,-2},{91,-4}}, color={191,0,0}));
  connect(adiabatic3.port, Pebble.port_external[1]) annotation (Line(points={{-28,26},
          {-10,26}},                     color={191,0,0}));
  connect(adiabatic2.port, Pebble.port_a1) annotation (Line(points={{-28,44},{-20,
          44},{-20,34},{-12,34}}, color={191,0,0}));
  connect(scalePower.heatPorts_b[1],heatPorts_b)
    annotation (Line(points={{48,52},{78,52}},   color={127,0,0}));
  connect(Pebble.port_b1, scalePower.heatPorts_a[1]) annotation (Line(points={{8,34},{
          18,34},{18,52},{28,52}},                      color={191,0,0}));
  connect(adiabatic5.port, Fuel_kernel_center.port_external[1]) annotation (
      Line(points={{-44,-94},{-26,-94},{-26,-78},{-40,-78},{-40,-70},{-42,-70}},
        color={191,0,0}));
  connect(adiabatic4.port, Fuel_kernel_center.port_a1)
    annotation (Line(points={{-58,-62},{-44,-62}}, color={191,0,0}));
  connect(Fuel_kernel_center.port_b1, Buffer_center_kernel.port_a)
    annotation (Line(points={{-24,-62},{-1,-62}}, color={191,0,0}));
  connect(Buffer_center_kernel.port_b, IPyC_center_kernel.port_a)
    annotation (Line(points={{13,-62},{25,-62}}, color={191,0,0}));
  connect(IPyC_center_kernel.port_b, SiC_center_kernel.port_a)
    annotation (Line(points={{39,-62},{53,-62}}, color={191,0,0}));
  connect(SiC_center_kernel.port_b, OPyC_center_kernel.port_a)
    annotation (Line(points={{67,-62},{79,-62}}, color={191,0,0}));
  connect(realExpression1.y, boundary1.T_ext) annotation (Line(points={{123,-24},
          {142,-24},{142,-28},{162,-28},{162,-58},{152,-58},{152,-60},{122,-60}},
        color={0,0,127}));
  connect(boundary1.port, OPyC_center_kernel.port_b)
    annotation (Line(points={{108,-60},{93,-60},{93,-62}}, color={191,0,0}));
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
end TRISO_Pebble;
