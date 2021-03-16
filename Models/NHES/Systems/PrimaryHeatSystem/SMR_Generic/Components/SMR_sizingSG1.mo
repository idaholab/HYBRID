within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components;
model SMR_sizingSG1

  Modelica.Fluid.Pipes.DynamicPipe Lower_Riser(
    crossArea=2.313,
    isCircular=true,
    diameter=1.716,
    p_a_start=system.p_ambient,
    allowFlowReversal=true,
    use_HeatTransfer=false,
    T_start=ramp.offset,
    p_b_start=system.p_ambient,
    length=2.865,
    height_ab=2.865,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow,
    redeclare package Medium = ThermoPower.Water.StandardWater)
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-26})));
  Modelica.Fluid.Pipes.DynamicPipe DownComer(
    crossArea=2.388,
    isCircular=true,
    diameter=1.744,
    p_a_start=system.p_ambient,
    p_b_start=system.p_ambient,
    length=8.521,
    height_ab=-8.521,
    T_start(displayUnit="K") = 558,
    redeclare package Medium = ThermoPower.Water.StandardWater)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={28,-24})));
  Modelica.Fluid.Pipes.DynamicPipe Upper_Riser(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=system.p_ambient,
    T_start=ramp.offset,
    length=7.925,
    height_ab=7.925,
    p_b_start=system.p_ambient,
    redeclare package Medium = ThermoPower.Water.StandardWater)
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,8})));
  inner Modelica.Fluid.System system(
      T_ambient(displayUnit="K") = 531.48,
    p_ambient(displayUnit="bar") = 12755300,
    m_flow_start=100)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        ThermoPower.Water.StandardWater, allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-12,-86},{-28,-70}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-82,58},{-70,70}})));
  Modelica.Fluid.Pipes.DynamicPipe Core(
    crossArea=2.388,
    isCircular=true,
    p_a_start=system.p_ambient,
    use_HeatTransfer=true,
    T_start=ramp.offset,
    length=2.408,
    height_ab=2.408,
    diameter=1.151,
    use_T_start=true,
    p_b_start=system.p_ambient,
    redeclare package Medium = ThermoPower.Water.StandardWater)
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-62})));
  Modelica.Fluid.Pipes.DynamicPipe PressurizerandTopper(
    crossArea=1.431,
    isCircular=true,
    diameter=1.35,
    p_a_start=system.p_ambient,
    T_start=ramp.offset,
    p_b_start=system.p_ambient,
    length=0.823,
    height_ab=0.823,
    redeclare package Medium = ThermoPower.Water.StandardWater)
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,42})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{14,-52},{28,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-110,-72},{-90,-52}})));
  Modelica.Blocks.Sources.Ramp ramp(
    startTime=600,
    offset=596,
    height=-10,
    duration=300)
    annotation (Placement(transformation(extent={{-150,-72},{-130,-52}})));
  TRANSFORM.Fluid.FittingsAndResistances.PipeLoss pipeLoss(
    allowFlowReversal=true,
    m_flow_start=100,
    redeclare package Medium = ThermoPower.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.PipeLossResistance.Circle
        (dimension_avg=0.4),
    K_ab=900.0) annotation (Placement(transformation(extent={{-8,54},{12,74}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(nPorts=1, redeclare package
      Medium = ThermoPower.Water.StandardWater,
    p=3447380,
    T(displayUnit="K") = 421.15)
    annotation (Placement(transformation(extent={{158,-54},{138,-34}})));
  Modelica.Fluid.Sources.Boundary_ph boundary3(          redeclare package
      Medium = ThermoPower.Water.StandardWater,
    nPorts=1,
    p=3447380)
    annotation (Placement(transformation(extent={{158,34},{138,54}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
    redeclare package Medium = ThermoPower.Water.StandardWater,
    use_input=false,
    m_flow_nominal=67)                                   annotation (
      Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=180,
        origin={119,-43})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
    p_a_start_shell=data.p,
    T_a_start_shell=data.T_hot,
    T_b_start_shell=data.T_cold,
    m_flow_a_start_shell=data.m_flow,
    p_a_start_tube=data.p_steam,
    use_Ts_start_tube=false,
    h_a_start_tube=data.h_steam_cold,
    h_b_start_tube=data.h_steam_hot,
    m_flow_a_start_tube=data.m_flow,
    ps_start_shell=dataInitial.p_start_STHX_shell,
    Ts_start_shell=dataInitial.T_start_STHX_shell,
    ps_start_tube=dataInitial.p_start_STHX_tube,
    hs_start_tube=dataInitial.h_start_STHX_tube,
    Ts_wall_start=dataInitial.T_start_STHX_tubeWall,
    redeclare package Medium_tube = ThermoPower.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
        (
        D_i_shell=data.d_steamGenerator_shell_inner,
        D_o_shell=data.d_steamGenerator_shell_outer,
        length_shell=data.length_steamGenerator,
        nTubes=data.nTubes_steamGenerator,
        nV=10,
        dimension_tube=data.d_steamGenerator_tube_inner,
        length_tube=data.length_steamGenerator_tube,
        th_wall=data.th_steamGenerator_tube,
        nR=2,
        angle_shell=-1.5707963267949),
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare package Medium_shell = ThermoPower.Water.StandardWater)
                                                                  annotation (Placement(transformation(
        extent={{-12,-11},{12,11}},
        rotation=90,
        origin={33,22})));

  GenericModular_PWR.Data.Data_GenericModule data(
      length_steamGenerator_tube=42)
    annotation (Placement(transformation(extent={{6,102},{22,118}})));
  GenericModular_PWR.Data.DataInitial dataInitial
    annotation (Placement(transformation(extent={{-158,58},{-138,78}})));
  Modelica.Fluid.Sensors.Temperature temperature2(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{46,-8},{60,-20}})));
  Modelica.Fluid.Sensors.Temperature temperature3(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{46,72},{62,58}})));
  TRANSFORM.Fluid.Volumes.ExpansionTank_1Port pressurizer(
    p_start=dataInitial.p_start_pressurizer,
    h_start=dataInitial.h_start_pressurizer,
    A=0.25*Modelica.Constants.pi*data.d_pressurizer^2,
    level_start=dataInitial.level_start_pressurizer,
    redeclare package Medium = ThermoPower.Water.StandardWater)
    "pressurizer.Medium.bubbleEnthalpy(Medium.setSat_p(pressurizer.p_start))"
    annotation (Placement(transformation(extent={{-48,98},{-28,118}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume pressurizer_tee(
    V=0.001,
    p_start=dataInitial.p_start_pressurizer_tee,
    T_start=dataInitial.T_start_pressurizer_tee,
    redeclare package Medium = ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-44,58},{-32,70}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance teeTopressurizer(R=1,
      redeclare package Medium = ThermoPower.Water.StandardWater)
                                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,84})));
equation
  connect(Lower_Riser.port_b, Upper_Riser.port_a)
    annotation (Line(points={{-70,-16},{-70,-2}},color={0,127,255}));
  connect(Core.port_b, Lower_Riser.port_a)
    annotation (Line(points={{-70,-52},{-70,-36}}, color={0,127,255}));
  connect(Upper_Riser.port_b, PressurizerandTopper.port_a)
    annotation (Line(points={{-70,18},{-70,32}}, color={0,127,255}));
  connect(DownComer.port_b, massFlowRate.port_a)
    annotation (Line(points={{28,-34},{28,-78},{-12,-78}},
                                                         color={0,127,255}));
  connect(PressurizerandTopper.port_b, temperature.port) annotation (Line(
        points={{-70,52},{-70,56},{-76,56},{-76,58}}, color={0,127,255}));
  connect(DownComer.port_b, temperature1.port) annotation (Line(points={{28,-34},
          {28,-52},{21,-52}},          color={0,127,255}));
  connect(prescribedTemperature.port, Core.heatPorts[1]) annotation (Line(
        points={{-90,-62},{-74,-62},{-74,-61.9},{-74.4,-61.9}}, color={191,0,0}));
  connect(ramp.y, prescribedTemperature.T)
    annotation (Line(points={{-129,-62},{-112,-62}}, color={0,0,127}));
  connect(massFlowRate.port_b, Core.port_a) annotation (Line(points={{-28,-78},
          {-70,-78},{-70,-72}},color={0,127,255}));
  connect(boundary2.ports[1], pump_SimpleMassFlow1.port_a) annotation (Line(
        points={{138,-44},{132,-44},{132,-43},{130,-43}}, color={0,127,255}));
  connect(DownComer.port_a, STHX.port_b_shell)
    annotation (Line(points={{28,-14},{28,10},{27.94,10}}, color={0,127,255}));
  connect(pipeLoss.port_b, STHX.port_a_shell) annotation (Line(points={{12,64},
          {27.94,64},{27.94,34}}, color={0,127,255}));
  connect(STHX.port_b_tube, boundary3.ports[1]) annotation (Line(points={{33,34},
          {34,34},{34,44},{138,44}}, color={0,127,255}));
  connect(pump_SimpleMassFlow1.port_b, STHX.port_a_tube)
    annotation (Line(points={{108,-43},{33,-43},{33,10}}, color={0,127,255}));
  connect(temperature2.port, STHX.port_a_tube) annotation (Line(points={{53,-8},
          {52,-8},{52,-2},{38,-2},{38,10},{33,10}}, color={0,127,255}));
  connect(temperature3.port, STHX.port_b_tube)
    annotation (Line(points={{54,72},{33,72},{33,34}}, color={0,127,255}));
  connect(PressurizerandTopper.port_b, pressurizer_tee.port_1)
    annotation (Line(points={{-70,52},{-70,64},{-44,64}}, color={0,127,255}));
  connect(pressurizer_tee.port_2, pipeLoss.port_a)
    annotation (Line(points={{-32,64},{-8,64}}, color={0,127,255}));
  connect(teeTopressurizer.port_b, pressurizer.port)
    annotation (Line(points={{-38,91},{-38,99.6}}, color={0,127,255}));
  connect(pressurizer_tee.port_3, teeTopressurizer.port_a)
    annotation (Line(points={{-38,70},{-38,77}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,120}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,
            120}})));
end SMR_sizingSG1;
