within NHES.TestModels_AS;
model Condensation_TestAS2022
   extends Modelica.Icons.Example;
   redeclare NHES.TestModels_AS.Data_Condensation_AS2022 data;
   parameter NHES.TestModels_AS.DataInitial_Condensation_AS2022_nV5 dataInitial;

  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    p_b_start_shell=12500000,
    p_b_start_tube=3400000,
    T_a_start_tube=473.15,
    T_b_start_tube=333.15,
    exposeState_b_shell=true,
    exposeState_b_tube=true,
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region_Chato_Condensation_AS2022,
    p_a_start_shell=12800000,
    T_a_start_shell=293.15,
    T_b_start_shell=333.15,
    m_flow_a_start_shell=100,
    p_a_start_tube=3500000,
    m_flow_a_start_tube=6.5,
    redeclare package Medium_shell = Modelica.Media.Water.StandardWater,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX (
        D_i_shell=data.d_steamGenerator_shell_inner,
        D_o_shell=data.d_steamGenerator_shell_outer,
        length_shell=data.length_steamGenerator,
        nTubes=data.nTubes_steamGenerator,
        nV=5,
        dimension_tube=data.d_steamGenerator_tube_inner,
        length_tube=data.length_steamGenerator_tube,
        th_wall=data.th_steamGenerator_tube,
        nR=2))                                                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,0})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T ShellIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=100,
    T=293.15,
    nPorts=2) annotation (Placement(transformation(extent={{-94,-28},{-80,-14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ShellOut(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12860000,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(extent={{88,-28},{74,-14}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TubeIn(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=4,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{96,13},{82,27}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TubeOut(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=118000,
    T=332.15,
    nPorts=1) annotation (Placement(transformation(extent={{-94,14},{-80,28}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeInTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{54,10},{34,30}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellInTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-46,-31},{-26,-11}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort ShellOutTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{24,-31},{44,-11}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeOutTemp(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
  TRANSFORM.Fluid.Sensors.Pressure ShellInPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-62,-21},{-42,-1}})));
  TRANSFORM.Fluid.Sensors.Pressure ShellOutPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{68,-21},{48,-1}})));
  TRANSFORM.Fluid.Sensors.Pressure TubeOutPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-74,21},{-54,41}})));
  TRANSFORM.Fluid.Sensors.Pressure TubeInPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
protected
  final parameter SI.Pressure p_units = 1;
equation

  connect(TubeInTemp.port_b, STHX.port_a_tube) annotation (Line(points={{34,20},{26,20},{26,0},{12,0},{12,-1.72085e-15}},color={0,127,255}));
  connect(ShellIn.ports[1], ShellInTemp.port_a) annotation (Line(points={{-80,-20.65},{-76,-20.65},{-76,-21},{-46,-21}},
                                                                                                                     color={0,127,255}));
  connect(ShellIn.ports[2], ShellInPress.port) annotation (Line(points={{-80,-21.35},{-52,-21}},
                                                                                               color={0,127,255}));
  connect(STHX.port_b_tube, TubeOutTemp.port_a) annotation (Line(points={{-8,8.88178e-16},{-18,8.88178e-16},{-18,21},{-26,21}}, color={0,127,255}));
  connect(TubeOutTemp.port_b, TubeOutPress.port) annotation (Line(points={{-46,21},{-64,21}}, color={0,127,255}));
  connect(TubeOutPress.port, TubeOut.ports[1]) annotation (Line(points={{-64,21},{-80,21}}, color={0,127,255}));
  connect(TubeInTemp.port_a, TubeInPress.port) annotation (Line(points={{54,20},{70,20}}, color={0,127,255}));
  connect(TubeInPress.port, TubeIn.ports[1]) annotation (Line(points={{70,20},{82,20}}, color={0,127,255}));
  connect(STHX.port_b_shell, ShellOutTemp.port_a) annotation (Line(points={{12,-4.6},{16,-4.6},{16,-20},{24,-20},{24,-21}}, color={0,127,255}));
  connect(ShellOutTemp.port_b, ShellOutPress.port) annotation (Line(points={{44,-21},{58,-21}}, color={0,127,255}));
  connect(ShellOutPress.port, ShellOut.ports[1]) annotation (Line(points={{58,-21},{74,-21}}, color={0,127,255}));
  connect(ShellInTemp.port_b, STHX.port_a_shell) annotation (Line(points={{-26,-21},{-14,-21},{-14,-4.6},{-8,-4.6}}, color={0,127,255}));
  annotation (
    defaultComponentName="PHS",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    experiment(
      StopTime=1000,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Esdirk45a"));
end Condensation_TestAS2022;
