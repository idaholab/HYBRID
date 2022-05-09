within NHES.Systems.BalanceOfPlant.BraytonCycle;
model Brayton_Cycle
  extends BalanceOfPlant.BraytonCycle.BaseClasses.Partial_SubSystem_A(
    redeclare replaceable BalanceOfPlant.BraytonCycle.CS_Dummy CS,
    redeclare replaceable BalanceOfPlant.BraytonCycle.ED_Dummy ED,
    redeclare replaceable Data.Data_BC_Test data(
      K_P_Release=10000,
      HX_Reheat_Tube_Vol=0.1,
      HX_Reheat_Shell_Vol=0.1));


  //Modelica.Units.SI.Power Q_Recup;
    replaceable package Medium =
      Modelica.Media.IdealGases.SingleGases.He constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                          annotation(choicesAllMatching=true);
    Modelica.Units.SI.Power Q_gen;


  GasTurbine.Turbine.Turbine      turbine(
    redeclare package Medium =
        Medium,
    pstart_out=dataInitial.P_Turbine_Ref,
    Tstart_in=dataInitial.TStart_In_Turbine,
    Tstart_out=dataInitial.TStart_Out_Turbine,
    eta0=data.Turbine_Efficiency,
    PR0=data.Turbine_Pressure_Ratio,
    w0=data.Turbine_Nominal_MassFlowRate)
            annotation (Placement(transformation(extent={{-80,46},{-16,0}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
    NTU=data.HX_Reheat_NTU,
    K_tube=data.HX_Reheat_K_tube,
    K_shell=data.HX_Reheat_K_shell,
    redeclare package Tube_medium =
        Medium,
    redeclare package Shell_medium =
        Medium,
    V_Tube=data.HX_Reheat_Tube_Vol,
    V_Shell=data.HX_Reheat_Shell_Vol,
    p_start_tube=dataInitial.Recuperator_P_Tube,
    h_start_tube_inlet=dataInitial.Recuperator_h_Tube_Inlet,
    h_start_tube_outlet=dataInitial.Recuperator_h_Tube_Outlet,
    p_start_shell=dataInitial.Recuperator_P_Tube,
    h_start_shell_inlet=dataInitial.Recuperator_h_Shell_Inlet,
    h_start_shell_outlet=dataInitial.HX_Aux_h_tube_out,
    dp_init_tube=dataInitial.Recuperator_dp_Tube,
    dp_init_shell=dataInitial.Recuperator_dp_Shell,
    Q_init=-100000000,
    Cr_init=0.8,
    m_start_tube=dataInitial.Recuperator_m_Tube,
    m_start_shell=dataInitial.Recuperator_m_Shell)
    annotation (Placement(transformation(extent={{18,-18},{-2,2}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,10})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
    redeclare package Medium =
        Medium,
    p_start=dataInitial.P_HP_Comp_Ref,
    T_start=data.T_Precooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0),
    use_HeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={38,38})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
        false, T=data.T_Precooler)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={2,36})));
  GasTurbine.Compressor.Compressor      compressor(
    redeclare package Medium =
        Medium,
    pstart_in=dataInitial.P_LP_Comp_Ref,
    Tstart_in=dataInitial.TStart_LP_Comp_In,
    Tstart_out=dataInitial.TStart_LP_Comp_Out,
    eta0=data.LP_Comp_Efficiency,
    PR0=data.LP_Comp_P_Ratio,
    w0=data.LP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{54,18},{98,50}})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe(
    redeclare package Medium =
        Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={100,28})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
    redeclare package Medium =
        Medium,
    p_start=dataInitial.P_LP_Comp_Ref,
    T_start=data.T_Intercooler,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.0),
    use_HeatPort=true)    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,-54})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
        false, T=data.T_Intercooler)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={78,-54})));
  GasTurbine.Compressor.Compressor      compressor1(
    redeclare package Medium =
        Medium,
    allowFlowReversal=false,
    pstart_in=dataInitial.P_HP_Comp_Ref,
    Tstart_in=dataInitial.TStart_HP_Comp_In,
    Tstart_out=dataInitial.TStart_HP_Comp_Out,
    eta0=data.HP_Comp_Efficiency,
    PR0=data.HP_Comp_P_Ratio,
    w0=data.HP_Comp_MassFlowRate)
            annotation (Placement(transformation(extent={{25,-18},{-25,18}},
        rotation=0,
        origin={73,-92})));
  TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                       transportDelayPipe1(
    redeclare package Medium =
        Medium,
    crossArea=data.A_HPDelay,
    length=data.L_HPDelay)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={56,-38})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
    springBallValve(
    redeclare package Medium = Medium,
    p_spring=data.P_Release,
    K=data.K_P_Release,
    opening_init=0.)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,58})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Medium,
    p=data.P_Release,
    nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={4,86})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Feed_Temp(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-6,-40})));



  NHES.Systems.BalanceOfPlant.BraytonCycle.Data.DataInitial_BC_Test dataInitial
    annotation (Placement(transformation(extent={{80,124},{100,144}})));

  TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
      package Medium = Medium)               annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={100,-22})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-108,32},{-86,54}}), iconTransformation(extent={
            {-108,32},{-86,54}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium = Medium) annotation (Placement(
        transformation(extent={{-108,-46},{-86,-24}}), iconTransformation(
          extent={{-108,-46},{-86,-24}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a1 annotation (
      Placement(transformation(extent={{86,-10},{108,12}}), iconTransformation(
          extent={{86,-10},{108,12}})));
initial equation

equation
 // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
 Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
  port_a1.W = Q_gen;


  connect(Precooler.heatPort, boundary3.port)
    annotation (Line(points={{32,38},{32,36},{12,36}},
                                              color={191,0,0}));
  connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{38,44},{
          26,44},{26,56},{62.8,56},{62.8,46.8}},
                                        color={0,127,255}));
  connect(Intercooler.heatPort, boundary4.port)
    annotation (Line(points={{94,-54},{88,-54}},       color={191,0,0}));
  connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
        points={{58,-77.6},{58,-52},{56,-52},{56,-48}},              color={0,
          127,255}));
  connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{100,-60},
          {100,-70},{88,-70},{88,-77.6}},
                                        color={0,127,255}));
  connect(springBallValve.port_b,boundary5. ports[1])
    annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
  connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
          4,44},{38,44}},                         color={0,127,255}));
  connect(Reheater.Shell_in, transportDelayPipe1.port_b)
    annotation (Line(points={{18,-10},{56,-10},{56,-28}},
                                                      color={0,127,255}));
  connect(Reheater.Shell_out, Feed_Temp.port_a)
    annotation (Line(points={{-2,-10},{-6,-10},{-6,-30}}, color={0,127,255}));
  connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-28.8,4.6},
          {-28.8,-12},{-10,-12},{-10,-4},{-2,-4}},
                                              color={0,127,255}));
  connect(Reheater.Tube_out, sensor_T.port_a)
    annotation (Line(points={{18,-4},{38,-4},{38,0}},  color={0,127,255}));
  connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{89.2,
          46.8},{90,46.8},{90,46},{100,46},{100,38}},
                                            color={0,127,255}));
  connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
      Line(points={{100,18},{100,-12}},                  color={0,127,255}));
  connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
    annotation (Line(points={{100,-48},{100,-32}},
                                                 color={0,127,255}));
  connect(sensor_T.port_b, Precooler.port_a)
    annotation (Line(points={{38,20},{38,32}}, color={0,127,255}));
  connect(Feed_Temp.port_b, port_b) annotation (Line(points={{-6,-50},{-6,-62},{
          -46,-62},{-46,-38},{-97,-38},{-97,-35}}, color={0,127,255}));
  connect(turbine.inlet, port_a) annotation (Line(points={{-67.2,4.6},{-84,4.6},
          {-84,43},{-97,43}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-62,38},{66,-26}},
          textColor={28,108,200},
          textString="Brayton_Cycle")}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      __Dymola_NumberOfIntervals=591,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>An example Brayton Cycle that produces power via gas turbine. This model requires a heat source to be connected via the fluid ports on the left hand side of the default model orientation. </p>
</html>"));
end Brayton_Cycle;
