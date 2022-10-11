within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.BaseClasses;
model TRISO "TRISO model estimate"
  parameter Real nParallel=1 "# of fuel components per number of power regions, nominally equal to # of fuel pebbles * number of pellets per pebble";
  parameter Integer nR_Fuel = 1;
  parameter Integer n_Power_Region =  1;
  parameter Modelica.Units.SI.Length r_Fuel = 200e-6;
  parameter Modelica.Units.SI.Length r_Buffer = r_Fuel + 100e-6;
  parameter Modelica.Units.SI.Length r_IPyC = r_Buffer+40e-6;
  parameter Modelica.Units.SI.Length r_SiC = r_IPyC+35e-6;
  parameter Modelica.Units.SI.Length r_OPyC = r_SiC+40e-6;
  parameter Modelica.Units.SI.ThermalConductivity k_Buffer= 2.25;
  parameter Modelica.Units.SI.ThermalConductivity k_IPyC = 8.0;
  parameter Modelica.Units.SI.ThermalConductivity k_SiC = 175;
  parameter Modelica.Units.SI.ThermalConductivity k_OPyC = 8.0;
  parameter Modelica.Units.SI.Temperature Fuel_Center_Init = 850 annotation(dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature Fuel_Edge_Init = 850 annotation(dialog(tab = "Initialization"));
  replaceable package Fuel_Kernel_Material =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Region 1 material"
  annotation (choicesAllMatching=true);

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balances" annotation(Dialog(tab="Advanced",group="Dynamics"));

  Modelica.Blocks.Interfaces.RealInput           Power_in[n_Power_Region] "Input Axial Power Distribution (volume approach)" annotation (
      Placement(transformation(extent={{-166,-4},{-126,36}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel[
    n_Power_Region](
    redeclare package Material = Fuel_Kernel_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=Fuel_Center_Init,
    T_b1_start=Fuel_Edge_Init,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=nR_Fuel, r_outer=r_Fuel),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.TotalHeatGeneration)
    annotation (Placement(transformation(extent={{-46,-14},{-26,6}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer[n_Power_Region](
    r_in=r_Fuel,
    r_out=r_Buffer,
    lambda=k_Buffer)
    annotation (Placement(transformation(extent={{-6,-14},{14,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC[n_Power_Region](
    r_in=r_Buffer,
    r_out=r_IPyC,
    lambda=k_IPyC)
    annotation (Placement(transformation(extent={{20,-14},{40,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC[n_Power_Region](
    r_in=r_IPyC,
    r_out=r_SiC,
    lambda=k_SiC)
    annotation (Placement(transformation(extent={{48,-14},{68,6}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC[n_Power_Region](
    r_in=r_SiC,
    r_out=r_OPyC,
    lambda=k_OPyC)
    annotation (Placement(transformation(extent={{74,-14},{94,6}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic[
    n_Power_Region]
    annotation (Placement(transformation(extent={{-92,-14},{-72,6}})));
  Modelica.Blocks.Math.Division division[n_Power_Region]
    annotation (Placement(transformation(extent={{-106,-34},{-86,-14}})));
  Modelica.Blocks.Sources.Constant const[n_Power_Region](k=nParallel*Fuel_kernel.geometry.nR)
    annotation (Placement(transformation(extent={{-158,-40},{-138,-20}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[
    n_Power_Region](use_port=true)
    annotation (Placement(transformation(extent={{-82,-34},{-62,-14}})));
  Modelica.Fluid.Interfaces.HeatPorts_b heatPorts_b[n_Power_Region] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={134,-2}), iconTransformation(
        extent={{-35,-10},{35,10}},
        rotation=-90,
        origin={102,1})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.Interfaces.ScalePower
    scalePower(nNodes=n_Power_Region, nParallel=nParallel)
    annotation (Placement(transformation(extent={{100,-11},{120,3}})));
equation
  connect(const.y, division.u2)
    annotation (Line(points={{-137,-30},{-108,-30}},
                                                  color={0,0,127}));
  connect(Power_in, division.u1) annotation (Line(points={{-146,16},{-126,16},{
          -126,12},{-110,12},{-110,-18},{-108,-18}},
                                           color={0,0,127}));
  connect(boundary.port, Fuel_kernel.port_external[1]) annotation (Line(points={{-62,-24},
          {-46,-24},{-46,-12},{-44,-12}},                                color={
          191,0,0}));
  connect(adiabatic.port, Fuel_kernel.port_a1)
    annotation (Line(points={{-72,-4},{-46,-4}}, color={191,0,0}));
  connect(Fuel_kernel.port_b1, Buffer.port_a)
    annotation (Line(points={{-26,-4},{-3,-4}}, color={191,0,0}));
  connect(division.y, boundary.Q_flow_ext) annotation (Line(points={{-85,-24},{
          -76,-24}},              color={0,0,127}));
  connect(Buffer.port_b, IPyC.port_a)
    annotation (Line(points={{11,-4},{23,-4}}, color={191,0,0}));
  connect(IPyC.port_b, SiC.port_a)
    annotation (Line(points={{37,-4},{51,-4}}, color={191,0,0}));
  connect(SiC.port_b, OPyC.port_a)
    annotation (Line(points={{65,-4},{77,-4}}, color={191,0,0}));
  connect(scalePower.heatPorts_b, heatPorts_b) annotation (Line(points={{120,-4},
          {122,-4},{122,-2},{134,-2}},                        color={127,0,0}));
  connect(OPyC.port_b, scalePower.heatPorts_a) annotation (Line(points={{91,-4},
          {90,-4},{90,10},{100,10},{100,-4}},                color={191,0,0}));
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
end TRISO;
