within NHES.Systems.PrimaryHeatSystem.SFR.Components;
model SFR_Intermediate_Loop
  "Intermediate loop that contains fluid interacting with both the IHX and the steam generator of an overall SFR plant. Could be replaced with a sensible heat storage loop."
  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable
      NHES.Systems.PrimaryHeatSystem.SFR.CS.CS_Dummy CS, redeclare
      Data.Data_Dummy data);
    replaceable package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT
    constrainedby Modelica.Media.Interfaces.PartialMedium              annotation(choicesAllMatching=true);
    replaceable package Medium_IHX_Loop =
      TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                                                  annotation(choicesAllMatching=true);
    replaceable package Medium_SG = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                                  annotation(choicesAllMatching=true);

  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase SG(
    tube_av_b=false,
    shell_av_b=false,
    NTU=4.8,
    K_tube=100,
    K_shell=100,
    redeclare package Tube_medium = Medium_SG,
    redeclare package Shell_medium = Medium_IHX_Loop,
    V_Tube=17.84,
    V_Shell=17.84,
    dh_Shell=0.0,
    p_start_tube=12500000,
    h_start_tube_inlet=1500e3,
    h_start_tube_outlet=3000e3,
    p_start_shell=100000,
    h_start_shell_inlet=800e3,
    h_start_shell_outlet=700e3,
    Q_init=100000000,
    m_start_tube=215) annotation (Placement(transformation(
        extent={{16,15},{-16,-15}},
        rotation=90,
        origin={71,8})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_SG_a(redeclare package Medium
      = Medium_SG) annotation (Placement(transformation(extent={{86,-48},{
            108,-26}}), iconTransformation(extent={{86,-48},{108,-26}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_SG_b(redeclare package Medium
      = Medium_SG) annotation (Placement(transformation(extent={{86,34},{108,
            56}}), iconTransformation(extent={{86,34},{108,56}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_IHX_b(redeclare package
      Medium = Medium_IHX_Loop) annotation (Placement(transformation(extent={{-108,
            -46},{-86,-24}}), iconTransformation(extent={{-108,-46},{-86,-24}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_IHX_a(redeclare package Medium
      = Medium_IHX_Loop) annotation (Placement(transformation(extent={{-110,48},
            {-88,70}}), iconTransformation(extent={{-108,34},{-86,56}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
    redeclare package Medium = Medium_IHX_Loop,
    p_a_start=100000,
    T_a_start=738.15,
    T_b_start=737.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=3, length=25),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple)
    annotation (Placement(transformation(extent={{-16,50},{4,70}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
    redeclare package Medium = Medium_IHX_Loop,
    p_a_start=100000,
    T_a_start=723.15,
    T_b_start=723.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=3, length=25),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple)
    annotation (Placement(transformation(extent={{-12,-46},{-32,-26}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Medium_IHX_Loop, m_flow_nominal=1500)
    annotation (Placement(transformation(extent={{44,-48},{24,-28}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port tank(
    redeclare package Medium = Medium_IHX_Loop,
    A=10,
    V0=0,
    p_surface=100000,
    p_start=100000,
    level_start=5,
    use_T_start=true,
    T_start=723.15)
    annotation (Placement(transformation(extent={{32,-20},{52,0}})));
  Modelica.Blocks.Sources.RealExpression Pump_speed(y=0)
    annotation (Placement(transformation(extent={{-108,104},{-88,124}})));
  Modelica.Blocks.Sources.RealExpression CR_Reactivity(y=0.0)
    annotation (Placement(transformation(extent={{-108,90},{-88,110}})));
  Modelica.Blocks.Sources.RealExpression Pump_speed1(y=0)
    annotation (Placement(transformation(extent={{-108,118},{-88,138}})));
equation

  connect(port_SG_a, SG.Tube_in) annotation (Line(points={{97,-37},{76,-37},{76,
          -12},{77,-12},{77,-8}}, color={0,127,255}));
  connect(SG.Tube_out, port_SG_b) annotation (Line(points={{77,24},{76,24},{76,
          34},{74,34},{74,46},{97,46},{97,45}}, color={0,127,255}));
  connect(SG.Shell_out, tank.port) annotation (Line(points={{68,-8},{68,-18.4},
          {42,-18.4}}, color={0,127,255}));
  connect(SG.Shell_out, pump.port_a)
    annotation (Line(points={{68,-8},{68,-38},{44,-38}}, color={0,127,255}));
  connect(pump.port_b, pipe1.port_a) annotation (Line(points={{24,-38},{-6,-38},
          {-6,-36},{-12,-36}}, color={0,127,255}));
  connect(pipe1.port_b, port_IHX_b) annotation (Line(points={{-32,-36},{-82,-36},
          {-82,-35},{-97,-35}}, color={0,127,255}));
  connect(port_IHX_a, pipe.port_a)
    annotation (Line(points={{-99,59},{-16,60}}, color={0,127,255}));
  connect(pipe.port_b, SG.Shell_in) annotation (Line(points={{4,60},{30,60},{30,
          58},{60,58},{60,24},{68,24}}, color={0,127,255}));
  connect(sensorBus.Core_Outlet_Temp, Pump_speed1.y) annotation (Line(
      points={{-30,100},{-60,100},{-60,128},{-87,128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.IHX_Outlet_Temp, Pump_speed.y) annotation (Line(
      points={{-30,100},{-60,100},{-60,114},{-87,114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.PrimaryMassFlow, CR_Reactivity.y) annotation (Line(
      points={{-30,100},{-87,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=3600,
      Interval=15,
      __Dymola_Algorithm="Esdirk45a"));
end SFR_Intermediate_Loop;
