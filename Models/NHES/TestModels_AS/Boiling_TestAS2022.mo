within NHES.TestModels_AS;
model Boiling_TestAS2022
    extends Modelica.Icons.Example;
    redeclare NHES.TestModels_AS.Data_GenericModule_AS2022 data;
    //replaceable package Medium = Modelica.Media.Water.StandardWater;

  //package Medium_PHTS = Modelica.Media.Water.StandardWater;

  parameter NHES.TestModels_AS.DataInitial_As2022 dataInitial;

  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
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
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX (
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
    ps_start_shell=dataInitial.p_start_STHX_shell,
    Ts_start_shell=dataInitial.T_start_STHX_shell,
    ps_start_tube=dataInitial.p_start_STHX_tube,
    hs_start_tube=dataInitial.h_start_STHX_tube,
    Ts_wall_start=dataInitial.T_start_STHX_tubeWall)              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={2,0})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T ShellIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=700,
    T=597.95,
    nPorts=2) annotation (Placement(transformation(extent={{-86,24},{-72,38}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ShellOut(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12860000,
    T=558.15,
    nPorts=1) annotation (Placement(transformation(extent={{-70,-42},{-56,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TubeIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=78,
    T=473.15,
    nPorts=2) annotation (Placement(transformation(extent={{82,-42},{68,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TubeOut(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3500000,
    T=573.55,
    nPorts=1) annotation (Placement(transformation(extent={{74,24},{60,38}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeInTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{40,-45},{20,-25}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellInTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-38,21},{-18,41}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOutTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-16,-45},{-36,-25}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOutTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{24,21},{44,41}})));
  TRANSFORM.Fluid.Sensors.Pressure ShellInPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-54,31},{-34,51}})));
  TRANSFORM.Fluid.Sensors.Pressure ShellOutPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-54,-35},{-34,-15}})));
  TRANSFORM.Fluid.Sensors.Pressure TubeOutPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{6,31},{26,51}})));
  TRANSFORM.Fluid.Sensors.Pressure TubeInPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{38,-35},{58,-15}})));
protected
  final parameter SI.Pressure p_units = 1;
equation

  connect(TubeIn.ports[1], TubeInTemp.port_a) annotation (Line(points={{68,-34.65},{54,-34.65},{54,-35},{40,-35}}, color={0,127,255}));
  connect(TubeInTemp.port_b, STHX.port_a_tube) annotation (Line(points={{20,-35},{2,-35},{2,-10}},                       color={0,127,255}));
  connect(TubeOut.ports[1], TubeOutTemp.port_b) annotation (Line(points={{60,31},{44,31}}, color={0,127,255}));
  connect(TubeOutTemp.port_a, STHX.port_b_tube) annotation (Line(points={{24,31},{2,31},{2,10}},                     color={0,127,255}));
  connect(ShellIn.ports[1], ShellInTemp.port_a) annotation (Line(points={{-72,31.35},{-56,31.35},{-56,31},{-38,31}}, color={0,127,255}));
  connect(ShellInTemp.port_b, STHX.port_a_shell) annotation (Line(points={{-18,31},{-2.6,31},{-2.6,10}}, color={0,127,255}));
  connect(STHX.port_b_shell, ShellOutTemp.port_a) annotation (Line(points={{-2.6,-10},{-2.6,-35},{-16,-35}}, color={0,127,255}));
  connect(ShellOutTemp.port_b, ShellOut.ports[1]) annotation (Line(points={{-36,-35},{-56,-35}}, color={0,127,255}));
  connect(ShellIn.ports[2], ShellInPress.port) annotation (Line(points={{-72,30.65},{-44,31}}, color={0,127,255}));
  connect(ShellOutTemp.port_b, ShellOutPress.port) annotation (Line(points={{-36,-35},{-44,-35}}, color={0,127,255}));
  connect(TubeOutTemp.port_a, TubeOutPress.port) annotation (Line(points={{24,31},{16,31}}, color={0,127,255}));
  connect(TubeIn.ports[2], TubeInPress.port) annotation (Line(points={{68,-35.35},{58,-35.35},{58,-35},{48,-35}}, color={0,127,255}));
  annotation (
    defaultComponentName="PHS",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"));
end Boiling_TestAS2022;
