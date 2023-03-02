within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L2_test
  extends Modelica.Icons.Example;
  SteamTurbine_L2_OFWH                                       pHTGR_BOPinit2_1(
      redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L2 CS(redeclare
        NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L2 data(
        Power_nom=40e6,
        HPT_p_in=12500000,
        p_dump=16000000,
        p_i=2500000,
        Tin=637.15,
        Tfeed=483.15,
        d_HPT_in(displayUnit="kg/m3") = 57.494,
        d_LPT_in(displayUnit="kg/m3") = 12.508,
        mdot_total=50.1358,
        mdot_fh=12.15,
        mdot_hpt=37.9858,
        mdot_lpt=34.168,
        eta_t=0.9,
        eta_mech=0.95)), redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L2 data(
      Power_nom=40e6,
      HPT_p_in=12500000,
      p_dump=16000000,
      p_i=2500000,
      Tin=637.15,
      Tfeed=483.15,
      d_HPT_in(displayUnit="kg/m3") = 57.494,
      d_LPT_in(displayUnit="kg/m3") = 12.508,
      mdot_total=50.1358,
      mdot_fh=12.15,
      mdot_hpt=37.9858,
      mdot_lpt=34.168,
      eta_t=0.9,
      eta_mech=0.95))
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
    p_a_start=3700000,
    p_b_start=3705000,
    T_a_start=573.15,
    m_flow_a_start=5.5,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (dimension=6.5),
    use_HeatTransfer=true,
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gen=100e6))
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-92,0})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(pHTGR_BOPinit2_1.port_b_feed, pipe.port_a) annotation (Line(points={{
          -40,-24},{-92,-24},{-92,-10}}, color={0,127,255}));
  connect(pipe.port_b, pHTGR_BOPinit2_1.port_a_steam)
    annotation (Line(points={{-92,10},{-92,24},{-40,24}}, color={0,127,255}));
  connect(steamdump.ports[1], pHTGR_BOPinit2_1.prt_b_steamdump)
    annotation (Line(points={{-60,40},{-40,40}}, color={0,127,255}));
  connect(boundary.port, pHTGR_BOPinit2_1.port_a_elec)
    annotation (Line(points={{60,0},{40,0}}, color={255,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"));
end L2_test;
