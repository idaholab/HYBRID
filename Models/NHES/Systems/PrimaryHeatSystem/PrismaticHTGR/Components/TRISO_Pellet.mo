within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Components;
model TRISO_Pellet "TRISO model estimate"
  parameter Real packing_factor(max=1,min=0)= 0.6 "Percent of TRISO in the Pellet by volume";
  parameter Real nKernels = nAsm*nPins*packing_factor*H*r_pellet^2/((4/3)*r_OPyC^3);
  parameter Integer nPins=54
                            "Fuel pins per Asm";
  parameter Integer nAsm=30
                           "# of Asms";
  parameter Modelica.Units.SI.Radius r_pellet=0.0115;
  parameter Modelica.Units.SI.Length H= 4.2 "Core Height";
  parameter Real Fp=1.2 "Core Power Peaking Factor, F_radial*F_axial*F_";
  parameter Modelica.Units.SI.Length r_Fuel = 250e-6 "radius of U2O Fuel kernal";
  parameter Modelica.Units.SI.Length r_Buffer = r_Fuel + 100e-6;
  parameter Modelica.Units.SI.Length r_IPyC = r_Buffer+40e-6;
  parameter Modelica.Units.SI.Length r_SiC = r_IPyC+35e-6;
  parameter Modelica.Units.SI.Length r_OPyC = r_SiC+40e-6;
  parameter Modelica.Units.SI.ThermalConductivity k_Buffer= 2.25;
  parameter Modelica.Units.SI.ThermalConductivity k_IPyC = 8.0;
  parameter Modelica.Units.SI.ThermalConductivity k_SiC = 175;
  parameter Modelica.Units.SI.ThermalConductivity k_OPyC = 8.0;
  parameter Modelica.Units.SI.Temperature pellet_Surface_Init = 750+273.15 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature pellet_Center_Init = 1100+273.15 annotation(Dialog(tab = "Initialization"));

  Modelica.Units.SI.Temperature T_max;
  Modelica.Units.SI.Temperature T_avg;
  replaceable package Fuel_Kernel_Material =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Fission material"
  annotation (choicesAllMatching=true);
  replaceable package pellet_Material =
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                   "Bulk pellet material in which fuel is embedded" annotation (choicesAllMatching=true);

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Formulation of energy balances" annotation(Dialog(tab="Advanced",group="Dynamics"));

  Modelica.Blocks.Interfaces.RealInput  Power_in
    "Input Axial Power Distribution (volume approach)"
     annotation (
      Placement(transformation(extent={{-100,4},{-60,44}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel(
    redeclare package Material = Fuel_Kernel_Material,
    T_a1_start=2273.15,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=3, r_outer=r_Fuel),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=division_kernel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer(
    r_in=r_Fuel,
    r_out=r_Buffer,
    lambda=k_Buffer)
    annotation (Placement(transformation(extent={{-46,-40},{-26,-20}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC(
    r_in=r_Buffer,
    r_out=r_IPyC,
    lambda=k_IPyC)
    annotation (Placement(transformation(extent={{-26,-40},{-6,-20}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC(
    r_in=r_IPyC,
    r_out=r_SiC,
    lambda=k_SiC)
    annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC(
    r_in=r_SiC,
    r_out=r_OPyC,
    lambda=k_OPyC)
    annotation (Placement(transformation(extent={{14,-40},{34,-20}})));
  Modelica.Blocks.Math.Division division_kernel
    annotation (Placement(transformation(extent={{-20,40},{0,20}})));
  Modelica.Blocks.Sources.Constant const(k=nKernels)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(
      use_port=true)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D
    Fuel_kernel_center(
    redeclare package Material = Fuel_Kernel_Material,
    T_a1_start=2273.15,
    nParallel=1,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
        (nR=3, r_outer=r_Fuel),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
        (q_ppp=HotChannel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer_center_kernel(
    r_in=r_Fuel,
    r_out=r_Buffer,
    lambda=k_Buffer)
    annotation (Placement(transformation(extent={{-46,-100},{-26,-80}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC_center_kernel(
    r_in=r_Buffer,
    r_out=r_IPyC,
    lambda=k_IPyC)
    annotation (Placement(transformation(extent={{-26,-80},{-6,-100}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC_center_kernel(
    r_in=r_IPyC,
    r_out=r_SiC,
    lambda=k_SiC)
    annotation (Placement(transformation(extent={{-6,-100},{14,-80}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC_center_kernel(
    r_in=r_SiC,
    r_out=r_OPyC,
    lambda=k_OPyC)
    annotation (Placement(transformation(extent={{14,-80},{34,-100}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic4
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(
      use_port=true)
    annotation (Placement(transformation(extent={{60,-100},{40,-80}})));
  Modelica.Blocks.Interfaces.RealInput Tin_avg "SiC compact T" annotation (
      Placement(transformation(extent={{100,-40},{80,-20}}), iconTransformation(
          extent={{100,50},{80,70}})));
  Modelica.Blocks.Interfaces.RealInput Tin_max "SiC compact T" annotation (
      Placement(transformation(extent={{100,-100},{80,-80}}),
        iconTransformation(extent={{100,-70},{80,-50}})));
  Modelica.Blocks.Math.Product HotChannel
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Constant const1(k=Fp)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
equation
  T_avg = Fuel_kernel.port_external[2].T+273.15;
  T_max=Fuel_kernel_center.port_a1.T;

  connect(const.y, division_kernel.u2)
    annotation (Line(points={{-59,70},{-40,70},{-40,36},{-22,36}},
                                                  color={0,0,127}));
  connect(adiabatic.port, Fuel_kernel.port_a1)
    annotation (Line(points={{-80,-30},{-70,-30}},
                                                 color={191,0,0}));
  connect(Fuel_kernel.port_b1, Buffer.port_a)
    annotation (Line(points={{-50,-30},{-43,-30}},
                                                color={191,0,0}));
  connect(Buffer.port_b, IPyC.port_a)
    annotation (Line(points={{-29,-30},{-23,-30}},
                                               color={191,0,0}));
  connect(IPyC.port_b, SiC.port_a)
    annotation (Line(points={{-9,-30},{-3,-30}},
                                               color={191,0,0}));
  connect(SiC.port_b, OPyC.port_a)
    annotation (Line(points={{11,-30},{17,-30}},
                                               color={191,0,0}));
  connect(boundary.port, OPyC.port_b)
    annotation (Line(points={{40,-30},{31,-30}},        color={191,0,0}));
  connect(adiabatic4.port, Fuel_kernel_center.port_a1)
    annotation (Line(points={{-80,-90},{-70,-90}}, color={191,0,0}));
  connect(Fuel_kernel_center.port_b1, Buffer_center_kernel.port_a)
    annotation (Line(points={{-50,-90},{-43,-90}},color={191,0,0}));
  connect(Buffer_center_kernel.port_b, IPyC_center_kernel.port_a)
    annotation (Line(points={{-29,-90},{-23,-90}},
                                                 color={191,0,0}));
  connect(IPyC_center_kernel.port_b, SiC_center_kernel.port_a)
    annotation (Line(points={{-9,-90},{-3,-90}}, color={191,0,0}));
  connect(SiC_center_kernel.port_b, OPyC_center_kernel.port_a)
    annotation (Line(points={{11,-90},{17,-90}}, color={191,0,0}));
  connect(boundary1.port, OPyC_center_kernel.port_b)
    annotation (Line(points={{40,-90},{31,-90}},           color={191,0,0}));
  connect(Power_in, division_kernel.u1) annotation (Line(points={{-80,24},{-22,24}},
                                  color={0,0,127}));
  connect(Tin_max, boundary1.T_ext)
    annotation (Line(points={{90,-90},{54,-90}}, color={0,0,127}));
  connect(Tin_avg, boundary.T_ext)
    annotation (Line(points={{90,-30},{54,-30}}, color={0,0,127}));
  connect(division_kernel.y, HotChannel.u2) annotation (Line(points={{1,30},{12,
          30},{12,44},{18,44}}, color={0,0,127}));
  connect(const1.y, HotChannel.u1) annotation (Line(points={{1,70},{12,70},{12,56},
          {18,56}}, color={0,0,127}));
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
          pattern=LinePattern.None)}),
    Documentation(info="<html>
<p>TRISO pellet model for PHTGR models.</p>
<p>Power per pellet is calculated and used in a cylinder condcution model, use the SiC media package, to find the centerline and average pellet temperatures.  The average temperature is taken to be approximty equal to the temperature at r=.5R, and max is assumed to be the centerline temperature.  </p>
<p><br><br><br><br>With the average and max pellet temperatures, the average and max fuel temperatures are found using a sphere condction model, with the U2O media package, and concentric rings of thermal resistances for each of the TRISO layers.  he average temperature is taken to be approximty equal to the temperature at r=.5R, and max is assumed to be the centerline temperature.  </p><p><br><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end TRISO_Pellet;
