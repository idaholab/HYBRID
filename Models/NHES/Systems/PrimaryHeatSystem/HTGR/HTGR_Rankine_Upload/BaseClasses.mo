within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload;
package BaseClasses
  extends TRANSFORM.Icons.BasesPackage;

  partial model Partial_SubSystem

    extends NHES.Systems.BaseClasses.Partial_SubSystem;

    extends Record_SubSystem;

    replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
        Placement(transformation(extent={{-18,122},{-2,138}})));
    replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
        Placement(transformation(extent={{2,122},{18,138}})));
    replaceable Record_Data data
      annotation (Placement(transformation(extent={{42,122},{58,138}})));

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,80},{50,120}}),
          iconTransformation(extent={{10,80},{50,120}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
          iconTransformation(extent={{-50,80},{-10,120}})));

  equation
    connect(sensorBus, ED.sensorBus) annotation (Line(
        points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus, CS.sensorBus) annotation (Line(
        points={{-30,100},{-12.4,100},{-12.4,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, CS.actuatorBus) annotation (Line(
        points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, ED.actuatorBus) annotation (Line(
        points={{30,100},{20,100},{12.4,100},{12.4,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    annotation (
      defaultComponentName="changeMe",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,140}})));
  end Partial_SubSystem;

  partial model Partial_SubSystem_A

    extends Partial_SubSystem;

    extends Record_SubSystem_A;

    annotation (
      defaultComponentName="changeMe",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})));
  end Partial_SubSystem_A;

  partial model Record_Data

    extends Modelica.Icons.Record;

    annotation (defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_Data;

  partial record Record_SubSystem

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem;

  partial record Record_SubSystem_A

    extends Record_SubSystem;

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem_A;

  partial model Partial_ControlSystem

    extends NHES.Systems.BaseClasses.Partial_ControlSystem;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="CS",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})));

  end Partial_ControlSystem;

  partial model Partial_EventDriver

    extends NHES.Systems.BaseClasses.Partial_EventDriver;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="ED",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));

  end Partial_EventDriver;
    constant Modelica.Media.IdealGases.Common.DataRecord He(
    name="He_HighTLimit",
    MM=0.004002602,
    Hf=0,
    H0=1548349.798456104,
    Tlimit=2000,
    alow={0,0,2.5,0,0,0,0},
    blow={-745.375,0.9287239740000001},
    ahigh={0,0,2.5,0,0,0,0},
    bhigh={-745.375,0.9287239740000001},
    R_s=2077.26673798694);

  expandable connector SignalSubBus_ActuatorInput

    extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

    annotation (defaultComponentName="actuatorBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_ActuatorInput;

  expandable connector SignalSubBus_SensorOutput

    extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

    annotation (defaultComponentName="sensorBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_SensorOutput;

  package He_HighT "Ideal gas \"He\" from NASA Glenn coefficients but Tmax higher"
    extends Modelica.Media.IdealGases.Common.SingleGasNasa(
       mediumName="Helium",
       data=He,
       fluidConstants={Modelica.Media.IdealGases.Common.FluidData.He});

    annotation (Documentation(info="<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/He.png\"></div></html>"));
  end He_HighT;

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

  model TRISO_Core_In_Progress
    replaceable package Coolant = Modelica.Media.Water.StandardWater;
    NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.TRISO fuelModel(
      nParallel=2.5e9,
      n_Power_Region=4,
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant const[fuelModel.n_Power_Region](k=150e6)
      annotation (Placement(transformation(extent={{-68,-8},{-48,12}})));
    NHES.Fluid.Pipes.StraightPipe    coolantSubchannel(
      use_HeatTransfer=true,
      isCircular=false,
      redeclare package Medium =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT,
      p_a_start=5100000,
      p_b_start=5000000,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      diameter=1,
      perimeter=0.001*1000000,
      roughness=1e-4,
      length=10,
      nParallel=1,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      allowFlowReversal=true,
      redeclare model FlowModel =
          NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
      redeclare model HeatTransfer =
          NHES.Fluid.Pipes.BaseClasses.HeatTransfer.DittusBoelter,
      modelStructure=Modelica.Fluid.Types.ModelStructure.av_b,
      nV=fuelModel.n_Power_Region,
      height_a=0,
      dheight=-6,
      useLumpedPressure=false,
      useInnerPortProperties=true,
      use_Ts_start=true,
      T_a_start=923.15,
      T_b_start=1123.15,
      m_flow_a_start=boundary.m_flow)
        annotation (Placement(transformation(
          extent={{-15,-13},{15,13}},
          rotation=0,
          origin={38,-38})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT,
      m_flow=305,
      T=923.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-50,-48},{-30,-28}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      redeclare package Medium =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT,
      p=5000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{108,-48},{88,-28}})));
  equation
    connect(fuelModel.Power_in, const.y)
      annotation (Line(points={{-11,0},{-30,0},{-30,2},{-47,2}},
                                                 color={0,0,127}));
    connect(coolantSubchannel.heatPorts, fuelModel.heatPorts_b) annotation (Line(
          points={{38.15,-32.28},{38.15,-16},{38,-16},{38,2},{10.2,2},{10.2,0.1}},
          color={127,0,0}));
    connect(coolantSubchannel.port_a, boundary.ports[1])
      annotation (Line(points={{23,-38},{-30,-38}}, color={0,127,255}));
    connect(coolantSubchannel.port_b, boundary1.ports[1])
      annotation (Line(points={{53,-38},{88,-38}}, color={0,127,255}));
    annotation ();
  end TRISO_Core_In_Progress;
end BaseClasses;
