within NHES.Systems.BalanceOfPlant;
package HRSG "Heat Recovery Steam Generators"
  model HRSG "Single pressure heat recovery steam generator"

   parameter Boolean use_nat_circ = false
      "Make unit free convection"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
   parameter Boolean use_booster_pump = false
      "Add pump to boost feed to a higher pressure HRSG"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
   parameter Boolean use_Econimizer = false
      "Add econimizer to heat inlet feed water"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_Superheater = false
      "Add superheater to heat exit steam"
      annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

      parameter Modelica.Units.SI.MassFlowRate Recirculation_Rate= 175.5;

   parameter Modelica.Units.SI.Pressure P_sys "System Pressure";
   parameter Modelica.Units.SI.Pressure Nominal_dp=(P_sys/1000) "Nominal Pressure drop";
   parameter Modelica.Units.SI.MassFlowRate Nominal_Flow=(Recirculation_Rate.*0.1);
   parameter Real PCV_opening_start=0.5
                                       "PCV start postion";
   parameter Real YMAX= (if use_booster_pump then 100 else 1) "Three Element Controler max output (0-1 for valve positon, or max booster pump flow rate)";

  parameter Real n_tubes_EVAP=20 "Number of Tubes in Evaporator"
    annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Tubes"));
  parameter Modelica.Units.SI.Length EVAP_L=10 "Height of Evaporator"
    annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Tubes"));
          parameter Modelica.Units.SI.Length EVAP_tube_Dia=50e-3  "Hydraulic Diameter of Tubes"
    annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Tubes"));
  parameter Modelica.Units.SI.Length EVAP_shell_Dia=300e-3  "Hydraulic Diameter of Shell"
    annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Shell"));
  parameter Real n_tubes_EVAP_DC=1 "Number of Downcomers in Evaporator"
  annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Downcomer"));
  parameter Modelica.Units.SI.Length EVAP_DC_Dia=0.75  "Diameter of Downcomer"
    annotation (Dialog(tab="Evaporator Dimensions",
          group="Evaporator Downcomer"));

  parameter Real n_tubes_ECON=20 "Number of Tubes in Econimizer"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Tubes"));
          parameter Modelica.Units.SI.Length ECON_L=10  "Height of Econimizer"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Tubes"));
          parameter Modelica.Units.SI.Length ECON_tube_Dia=50e-3 "Hydraulic Diameter of Tubes"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Tubes"));
          parameter Modelica.Units.SI.Length ECON_shell_Dia=300e-3  "Hydraulic Diameter of Shell"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Shell"));
          parameter Real n_tubes_ECON_DC=1  "Number of Downcomers in Econimizer"
  annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Downcomer"));
  parameter Modelica.Units.SI.Length ECON_DC_Dia=0.75 "Diameter of Downcomer"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Downcomer"));

  parameter Real n_tubes_SH=20 "Number of Tubes in Superheater"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_L=10  "Height of Superheater"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_tube_Dia=50e-3  "Hydraulic Diameter of Tubes"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_shell_Dia=300e-3  "Hydraulic Diameter of Shell"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Shell"));
          parameter Real n_tubes_SH_DC=1  "Number of Downcomers in Superheater"
  annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Downcomer"));
          parameter Modelica.Units.SI.Length SH_DC_Dia=0.75 "Diameter of Downcomer"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Downcomer"));

    Modelica.Fluid.Interfaces.FluidPort_a Feed_port(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-10,-170},{10,-150}}),  iconTransformation(extent={{-10,-170},{10,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_a Gas_Inlet_Port(redeclare package Medium =
          NHES.Media.FlueGas)
      annotation (Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(extent={{150,-10},{170,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b Gas_Outlet_Port(redeclare package Medium =
          NHES.Media.FlueGas)
      annotation (Placement(transformation(extent={{-170,-10},{-150,10}}), iconTransformation(extent={{-170,-10},{-150,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b Steam_Outlet_port(redeclare package Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(transformation(extent={{-10,150},{10,170}}), iconTransformation(extent={{-10,150},
              {10,170}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-104,28},{-84,48}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,                                                                        allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={82,70})));
    Modelica.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      allowFlowReversal=true,
      m_flow_start=1,
      dp_nominal=50000,
      m_flow_nominal=50) if not use_booster_pump
      annotation (Placement(transformation(extent={{-110,68},{-90,88}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Downcomer(
      nParallel=n_tubes_EVAP_DC,
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      ps_start=TRANSFORM.Math.linspace_1D(
          Downcomer.p_a_start,
          Downcomer.p_b_start,
          Downcomer.nV),
      use_Ts_start=false,
      p_a_start(displayUnit="bar") = P_sys*1.2,
      p_b_start(displayUnit="bar") = P_sys*1.2,
      T_a_start=548.15,
      h_a_start=1400e3,
      h_b_start=1400e3,
      m_flow_a_start=Recirculation_Rate,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe (
          dimension(displayUnit="mm") = EVAP_DC_Dia,
          length=EVAP_L,
          angle=-1.5707963267949,
          nV=3,
          height_a=10),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-14,-42})));
    ThreeElementContoller                    threeElementContoller(
      FlowErrorGain=0.01,
      k=100,
      yMax=YMAX,
      yMin=0,
      kp=250,
      LevelSet=0.5,
      xi_start=0,
      Ti=1)
      annotation (Placement(transformation(extent={{8,80},{-16,102}})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Evaporator(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX (
          nV=5,
          nTubes=n_tubes_EVAP,
          nR=3,
          height_a_tube=0,
          dimension_shell(displayUnit="mm") = EVAP_shell_Dia,
          length_shell=EVAP_L,
          dimension_tube(displayUnit="mm") = EVAP_tube_Dia,
          length_tube=EVAP_L,
          angle_tube=1.5707963267949),
      redeclare package Medium_shell = NHES.Media.FlueGas,
      redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
      p_a_start_shell=200000,
      p_b_start_shell=120000,
      T_a_start_shell=773.15,
      m_flow_a_start_shell=200,
      p_a_start_tube=P_sys*1.2,
      p_b_start_tube=P_sys*1.2,
      use_Ts_start_tube=false,
      T_a_start_tube=548.15,
      h_a_start_tube=1400e3,
      h_b_start_tube=1550e3,
      m_flow_a_start_tube=Recirculation_Rate)
                               annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={26,-44})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance EvaporatorResistance(redeclare package Medium =
          Modelica.Media.Water.StandardWater, R=0.1)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,-2})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance DowncomerResistance(redeclare package Medium =
          Modelica.Media.Water.StandardWater, R=0.1)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-14,-14})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Feed_Resistance(redeclare package Medium =
          Modelica.Media.Water.StandardWater, R=0.1) if                                                                                               not use_Econimizer
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-58,38})));
    Fluid.Vessels.Steam_Drum steam_Drum(
      p_start=P_sys,
      alphag_start=0.5,
      V_drum=10)
      annotation (Placement(transformation(extent={{16,30},{36,50}})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Economizer(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX (
          nV=5,
          nTubes=n_tubes_ECON,
          nR=3,
          dimension_shell(displayUnit="mm") = ECON_shell_Dia,
          length_shell=ECON_L,
          dimension_tube(displayUnit="mm") = ECON_tube_Dia,
          length_tube=ECON_L),
      redeclare package Medium_shell = NHES.Media.FlueGas,
      redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,
      p_a_start_shell=200000,
      p_b_start_shell=120000,
      T_a_start_shell=673.15,
      m_flow_a_start_shell=200,
      p_a_start_tube=P_sys*1.2,
      p_b_start_tube=P_sys*1.2,
      use_Ts_start_tube=false,
      T_a_start_tube=548.15,
      h_a_start_tube=400e3,
      h_b_start_tube=400e3,
      m_flow_a_start_tube=0) if  use_Econimizer  annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-56,-36})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Gas_Resistance(redeclare package Medium =
          NHES.Media.FlueGas,                                                                                                R=5) if not use_Econimizer
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-76,-110})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface ECON_Downcomer(
      nParallel=n_tubes_ECON_DC,
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      ps_start=TRANSFORM.Math.linspace_1D(
          Downcomer.p_a_start,
          Downcomer.p_b_start,
          Downcomer.nV),
      use_Ts_start=false,
      p_a_start(displayUnit="bar") = P_sys*1.2,
      p_b_start(displayUnit="bar") = P_sys*1.2,
      T_a_start=548.15,
      h_a_start=400e3,
      h_b_start=400e3,
      m_flow_a_start=0,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe (
          dimension(displayUnit="mm") = ECON_DC_Dia,
          length=ECON_L,
          nV=3),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable) if                         use_Econimizer
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-74,-42})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Superheater(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX (
          nV=5,
          nTubes=n_tubes_SH,
          nR=3,
          dimension_shell(displayUnit="mm") = SH_shell_Dia,
          length_shell=SH_L,
          dimension_tube(displayUnit="mm") = SH_tube_Dia,
          length_tube=SH_L),
      redeclare package Medium_shell = NHES.Media.FlueGas,
      redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Turbulent_MSL,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region_modelBased,
      p_a_start_shell=200000,
      p_b_start_shell=120000,
      T_a_start_shell=773.15,
      m_flow_a_start_shell=200,
      p_a_start_tube=P_sys*1.2,
      p_b_start_tube=P_sys*1.2,
      use_Ts_start_tube=false,
      T_a_start_tube=548.15,
      h_a_start_tube=2724e3,
      h_b_start_tube=2724e3,
      m_flow_a_start_tube=Nominal_Flow) if
                                 use_Superheater  annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={82,-36})));

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface SH_Downcomer(
      nParallel=n_tubes_SH_DC,
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      ps_start=TRANSFORM.Math.linspace_1D(
          Downcomer.p_a_start,
          Downcomer.p_b_start,
          Downcomer.nV),
      use_Ts_start=false,
      p_a_start(displayUnit="bar") = P_sys*1.2,
      p_b_start(displayUnit="bar") = P_sys*1.2,
      T_a_start=548.15,
      h_a_start=2724e3,
      h_b_start=2724e3,
      m_flow_a_start=50,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe (
          dimension(displayUnit="mm") = SH_DC_Dia,
          length=SH_L,
          nV=3),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable) if                         use_Superheater
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={54,-38})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Gas_Resistance_2(redeclare package Medium =
          NHES.Media.FlueGas,                                                                                                  R=5) if not use_Superheater
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={126,-112})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow Booster_Pump(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=true,                                                                                                        m_flow_nominal=20) if
                                                                                                                                            use_booster_pump
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-124,50})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Steam_Resistance(redeclare package Medium =
          Modelica.Media.Water.StandardWater, R=0.1) if                                                                                 not use_Superheater
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={64,48})));
    Fluid.Valves.Pressure_Control_Valve_Simple
                                             pressure_Control_Valve_Simple(
      P_sys=P_sys,
      Nominal_dp=P_sys ./ 1.5,
      Nominal_Flow=Recirculation_Rate*0.1,
      Ti=5)
      annotation (Placement(transformation(extent={{48,118},{28,138}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow RecircPump(redeclare package Medium =
          Modelica.Media.Water.StandardWater,                                                                              m_flow_nominal=
          Recirculation_Rate) if not use_nat_circ annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={4,-84})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance NatCirc(redeclare package Medium =
          Modelica.Media.Water.StandardWater, R=0.1) if                                                                                       use_nat_circ
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={6,-66})));
  equation

    connect(massFlowRate.m_flow,threeElementContoller. FeedFlow) annotation (Line(
          points={{-94,49},{-94,58},{2,58},{2,77.8}},   color={0,0,127}));
    connect(threeElementContoller.SteamFlow,massFlowRate1. m_flow) annotation (Line(
          points={{-10,77.8},{-10,70},{71,70}},                       color={0,0,127}));
    connect(threeElementContoller.y,valveLinear. opening)
      annotation (Line(points={{-17.2,91},{-100,91},{-100,86}},
                                                              color={0,0,127}));
    connect(Evaporator.port_b_tube,EvaporatorResistance. port_a)
      annotation (Line(points={{26,-34},{26,-16},{30,-16},{30,-9}},
                                                   color={244,125,35}));
    connect(Downcomer.port_a,DowncomerResistance. port_a)
      annotation (Line(points={{-14,-32},{-14,-21}}, color={244,125,35}));
    connect(Feed_Resistance.port_a, steam_Drum.feed_port) annotation (Line(
          points={{-51,38},{-18,38},{-18,40},{16,40}}, color={0,127,255}));
    connect(EvaporatorResistance.port_b, steam_Drum.riser_port)
      annotation (Line(points={{30,5},{30,30}}, color={244,125,35}));
    connect(steam_Drum.RelLevel, threeElementContoller.Level) annotation (Line(
          points={{36.2,40},{38,40},{38,91},{10.4,91}}, color={0,0,127}));
    connect(Evaporator.port_b_shell,Gas_Resistance. port_a)
      annotation (Line(points={{30.6,-54},{30.6,-96},{-60,-96},{-60,-110},{-69,-110}},
                                                                 color={0,140,72}));
    connect(valveLinear.port_b,massFlowRate. port_a)
      annotation (Line(points={{-90,78},{-84,78},{-84,62},{-108,62},{-108,38},{-104,38}},
                                                     color={0,127,255}));
    connect(ECON_Downcomer.port_b,Economizer. port_a_tube)
      annotation (Line(points={{-74,-52},{-74,-58},{-56,-58},{-56,-46}},     color={0,127,255}));
    connect(SH_Downcomer.port_b,Superheater. port_a_tube)
      annotation (Line(points={{54,-48},{54,-52},{82,-52},{82,-46}}, color={238,46,47}));
    connect(Evaporator.port_a_shell,Gas_Resistance_2. port_b)
      annotation (Line(points={{30.6,-34},{30.6,-24},{40,-24},{40,-82},{60,-82},{60,-112},{119,-112}},
                                                                                  color={0,140,72}));
    connect(Gas_Inlet_Port, Superheater.port_a_shell) annotation (Line(points={{160,0},{154,0},{154,-20},{86.6,-20},{86.6,-26}},
                                                                                                                   color={0,140,72}));
    connect(Gas_Outlet_Port, Economizer.port_b_shell)
      annotation (Line(points={{-160,0},{-118,0},{-118,-72},{-51.4,-72},{-51.4,
            -46}},                                                                      color={0,140,72}));
    connect(Feed_port, Booster_Pump.port_a) annotation (Line(points={{0,-160},{0,-148},{-148,-148},{-148,50},{-134,50}},
                                                                                                     color={0,127,255}));
    connect(Booster_Pump.in_m_flow, threeElementContoller.y)
      annotation (Line(points={{-124,57.3},{-124,91},{-17.2,91}},                                         color={0,0,127}));
    connect(Feed_port, valveLinear.port_a) annotation (Line(points={{0,-160},{0,-148},{-148,-148},{-148,78},{-110,78}}, color={0,127,255}));
    connect(Booster_Pump.port_b, massFlowRate.port_a) annotation (Line(points={{-114,50},{-108,50},{-108,38},{-104,38}}, color={0,127,255}));
    connect(SH_Downcomer.port_a, steam_Drum.steam_port)
      annotation (Line(points={{54,-28},{54,50},{26,50}}, color={238,46,47}));
    connect(massFlowRate.port_b, ECON_Downcomer.port_a) annotation (Line(points={{-84,38},{-74,38},{-74,-32}}, color={0,127,255}));
    connect(Superheater.port_b_tube, massFlowRate1.port_a) annotation (Line(points={{82,-26},{82,60}},            color={238,46,47}));
    connect(massFlowRate.port_b, Feed_Resistance.port_b) annotation (Line(points={{-84,38},{-65,38}}, color={0,127,255}));
    connect(steam_Drum.steam_port, Steam_Resistance.port_b) annotation (Line(
          points={{26,50},{42,50},{42,48},{57,48}}, color={238,46,47}));
    connect(Steam_Resistance.port_a, massFlowRate1.port_a) annotation (Line(points={{71,48},{82,48},{82,60}},
                                                                                                        color={238,46,47}));
    connect(Economizer.port_b_tube, steam_Drum.feed_port) annotation (Line(
          points={{-56,-26},{-56,40},{16,40}}, color={0,127,255}));
    connect(Gas_Resistance.port_b, Gas_Outlet_Port) annotation (Line(points={{-83,-110},{-118,-110},{-118,0},{-160,0}},     color={0,140,72}));
    connect(Superheater.port_b_shell, Evaporator.port_a_shell)
      annotation (Line(points={{86.6,-46},{86.6,-54},{40,-54},{40,-24},{30.6,-24},{30.6,-34}},   color={0,140,72}));
    connect(Gas_Resistance_2.port_a, Gas_Inlet_Port) annotation (Line(points={{133,-112},{154,-112},{154,0},{160,0}},     color={0,140,72}));
    connect(massFlowRate1.port_b, pressure_Control_Valve_Simple.port_a)
      annotation (Line(points={{82,80},{82,128},{48,128}}, color={238,46,47}));
    connect(pressure_Control_Valve_Simple.port_b, Steam_Outlet_port)
      annotation (Line(points={{28,128},{0,128},{0,160}}, color={238,46,47}));
    connect(steam_Drum.downcomer_port, DowncomerResistance.port_b) annotation (
        Line(points={{22,30},{22,4},{-14,4},{-14,-7}}, color={244,125,35}));
    connect(Economizer.port_a_shell, Evaporator.port_b_shell)
      annotation (Line(points={{-51.4,-26},{-52,-26},{-52,-24},{-44,-24},{-44,
            -96},{30.6,-96},{30.6,-54}},                                                                   color={0,140,72}));
    connect(Downcomer.port_b, RecircPump.port_a) annotation (Line(points={{-14,-52},{-14,-84},{-6,-84}}, color={0,127,255}));
    connect(RecircPump.port_b, Evaporator.port_a_tube) annotation (Line(points={{14,-84},{26,-84},{26,-54}}, color={0,127,255}));
    connect(Downcomer.port_b, NatCirc.port_b) annotation (Line(points={{-14,-52},{-14,-66},{-1,-66}}, color={0,127,255}));
    connect(NatCirc.port_a, Evaporator.port_a_tube) annotation (Line(points={{13,-66},{26,-66},{26,-54}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}}), graphics={
          Rectangle(
            extent={{-160,60},{160,-60}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-23,3},{23,-3}},
            lineColor={0,0,0},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5,
            origin={-1,-103},
            rotation=180),
          Rectangle(
            extent={{-99,4},{99,-4}},
            lineColor={0,0,0},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5,
            origin={-20,-7},
            rotation=90),
          Rectangle(
            extent={{-99,4},{99,-4}},
            lineColor={0,0,0},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5,
            origin={20,-7},
            rotation=90),
          Ellipse(
            extent={{-40,80},{40,160}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40,80},{40,160}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-40,80},{40,160}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            closure=EllipseClosure.Chord,
            startAngle=10,
            endAngle=170),
          Text(
            extent={{-100,-120},{100,-140}},
            textColor={28,108,200},
            textString="%name")}),                                 Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
      experiment(
        StopTime=100000,
        Interval=0.1,
        __Dymola_Algorithm="Esdirk45a"));
  end HRSG;

  package Examples

    model Gas_Turbine_HRSG_Test
      "Test with HRSG connected to the exaust of a gas trubine was a load change at 500s"
      NHES.GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{28,-70},{48,-50}})));
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.CS_GTPP_stepInput CS(capacityScaler=1, W_SES_nom=70000000,
        loadSignal1(startTime=510),
        loadSignal2(startTime=540))
        annotation (Placement(transformation(extent={{-80,20},{0,100}})));
      NHES.Systems.SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
        SES(capacity=70000000)
        annotation (Placement(transformation(extent={{-80,-100},{0,-20}})));
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        p=80000,
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{74,42},
                {90,58}},
                      rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT FeedSource(
        p=4000000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        T=313.15,
        nPorts=1) annotation (Placement(transformation(extent={{98,-72},{82,-56}},   rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT SteamSink(
        p=3000000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{94,78},{78,94}},   rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_booster_pump=true,
        Recirculation_Rate=67.5,
        P_sys=3800000,
        YMAX=100,
        n_tubes_EVAP=100,
        EVAP_tube_Dia(displayUnit="mm") = 0.03,
        EVAP_shell_Dia(displayUnit="mm") = 0.75,
        EVAP_DC_Dia=0.3)
        annotation (Placement(transformation(extent={{92,-40},{12,40}})));
    equation
      connect(SES.portElec_b, elecLoad.portElec_a) annotation (Line(points={{0,-60},{28,-60}}, color={255,0,0}));
      connect(SES.actuatorBus, CS.actuatorBus)
        annotation (Line(
          points={{-28,-20},{-28,20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(CS.sensorBus, SES.sensorBus)
        annotation (Line(
          points={{-52,20},{-52,-20}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, SteamSink.ports[1])
        annotation (Line(points={{52,40},{52,86},{78,86}},  color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Inlet_Port, SES.FlueGas_b)
        annotation (Line(points={{12,0},{2,0},{2,-16},{8,-16},{8,-36},{0,-36}},
                                                                    color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{92,0},{
              98,0},{98,50},{90,50}},                                                                                           color={0,127,255}));
      connect(heatRecoverySteamGenerator.Feed_port, FeedSource.ports[1])
        annotation (Line(points={{52,-40},{52,-64},{82,-64}},         color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                120,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=1000,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end Gas_Turbine_HRSG_Test;

    model HRSG_Test "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        p=10000,
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{74,42},
                {90,58}},
                      rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT FeedSource(
        p=500000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        T=313.15,
        nPorts=1) annotation (Placement(transformation(extent={{78,-72},{62,-56}},   rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT SteamSink(
        p=100000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{94,78},{78,94}},   rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=false,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=10,
        P_sys=862000,
        Nominal_Flow=5.5,
        YMAX=5,
        n_tubes_EVAP=500,
        EVAP_tube_Dia(displayUnit="mm") = 0.03,
        EVAP_shell_Dia(displayUnit="mm") = 0.15,
        EVAP_DC_Dia=0.3,
        n_tubes_ECON=10,
        ECON_L=6,
        ECON_tube_Dia(displayUnit="mm") = 0.05,
        ECON_shell_Dia(displayUnit="mm") = 0.75,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(k=-0.0003))
        annotation (Placement(transformation(extent={{58,-40},{-22,40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = NHES.Media.FlueGas,
        m_flow=10,
        T=973.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
    equation
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, SteamSink.ports[1])
        annotation (Line(points={{18,40},{18,86},{78,86}},  color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{58,0},{
              96,0},{96,50},{90,50}},                                                                                           color={0,127,255}));
      connect(heatRecoverySteamGenerator.Feed_port, FeedSource.ports[1])
        annotation (Line(points={{18,-40},{18,-64},{62,-64}},         color={0,127,255}));
      connect(boundary.ports[1], heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-52,0},{-22,0}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                120,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end HRSG_Test;

    model HRSG_MEE_Test "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        p=10000,
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{-28,-10},
                {-44,6}},
                      rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=false,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=10,
        P_sys=862000,
        Nominal_Flow=5.5,
        YMAX=5,
        n_tubes_EVAP=500,
        EVAP_tube_Dia(displayUnit="mm") = 0.03,
        EVAP_shell_Dia(displayUnit="mm") = 0.15,
        EVAP_DC_Dia=0.3,
        n_tubes_ECON=10,
        ECON_L=6,
        ECON_tube_Dia(displayUnit="mm") = 0.05,
        ECON_shell_Dia(displayUnit="mm") = 0.75,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(k=-0.0003))
        annotation (Placement(transformation(extent={{-64,-42},{-144,38}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = NHES.Media.FlueGas,
        m_flow=9,
        T=973.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-196,-12},{-176,8}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-14,-88},{8,-68}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet10(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{282,-16},{260,4}})));

      Desalination.MEE.Multiple_Effect.MEE_PF8_FC
                              mEE_PF8_FC(redeclare
          Desalination.MEE.ControlSystems.CS_PressureControlSystem CS)
        annotation (Placement(transformation(extent={{88,-40},{196,68}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=false,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{252,30},{230,50}})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{40,38},{60,58}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{42,-84},{62,-64}})));
    equation
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{-64,-2},
              {-44,-2}},                                                                                                        color={0,127,255}));
      connect(boundary.ports[1], heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-176,-2},{-144,-2}},
                                                   color={0,127,255}));
      connect(Brine_Oulet10.ports[1],mEE_PF8_FC. Saltwater_Reject_Oulet)
        annotation (Line(points={{260,-6},{228,-6},{228,-7.6},{196,-7.6}},
            color={0,127,255}));
      connect(Brine_Source.ports[1],mEE_PF8_FC. Saltwater_Input) annotation (
          Line(points={{230,40},{213,40},{213,35.6},{196,35.6}},
                                                             color={0,127,255}));
      connect(sensor_m_flow1.port_b,mEE_PF8_FC. Condensate_Oulet) annotation (
          Line(points={{62,-74},{142,-74},{142,-38.92}},color={0,127,255}));
      connect(sensor_m_flow1.port_a,Condensate_Out. ports[1]) annotation (Line(
            points={{42,-74},{16,-74},{16,-78},{8,-78}},          color={0,127,255}));
      connect(sensor_m_flow.port_b,mEE_PF8_FC. Steam_Input) annotation (Line(
            points={{60,48},{78,48},{78,35.6},{88,35.6}},     color={0,127,255}));
      connect(mEE_PF8_FC.Water_Outlet, heatRecoverySteamGenerator.Feed_port)
        annotation (Line(points={{88,-7.6},{88,-6},{-22,-6},{-22,-48},{-104,-48},
              {-104,-42}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, sensor_m_flow.port_a)
        annotation (Line(points={{-104,38},{-104,48},{40,48}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                120,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end HRSG_MEE_Test;

    model HRSG_Test_Cogen "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        p=10000,
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{84,-8},{64,12}},
                      rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT FeedSource(
        use_T_in=false,
        p=861800,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        T=382.53,
        nPorts=1) annotation (Placement(transformation(extent={{60,-80},{40,-60}},   rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT SteamSink(
        p=100000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{40,70},{20,90}},   rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        Nominal_Flow=5.5,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=100000,
                                      k=-0.0003))
        annotation (Placement(transformation(extent={{36,-38},{-44,42}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = NHES.Media.FlueGas,
        use_m_flow_in=false,
        m_flow=60,
        T=683.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Sources.TimeTable timeTable(table=[0,58; 3000,58; 3030,58.60919695; 3060,59.51243334; 3090,60.05519056; 3120,59.72885456;
            3150,58.45979004; 3180,58.00114861; 3210,58.71637745; 3240,59.45408936; 3270,59.45408936; 3300,58.06633101; 3330,57.4396265; 3360,
            57.4396265; 3390,58.3776475; 3420,58.3776475; 3450,56.21324501; 3480,55.22105484; 3510,55.22105484; 3540,56.07552538; 3570,
            56.07552538; 3600,55.25518713; 3630,55.25518713; 3660,56.54456034; 3690,58.2554203; 3720,58.91052761; 3750,58.91052761; 3780,
            58.91052761; 3810,58.91052761; 3840,60.49706755; 3870,61.21559057; 3900,60.8899395; 3930,60.38030348; 3960,60.38030348; 3990,
            62.55451784; 4020,63.40779791; 4050,63.40779791; 4080,63.40779791; 4110,63.80034914; 4140,66.15006294; 4170,66.7596714; 4200,
            66.7596714; 4230,65.49031334; 4260,65.49031334; 4290,65.49031334; 4320,65.97667809; 4350,64.61677351; 4380,62.76791668; 4410,
            62.76791668; 4440,62.76791668; 4470,62.76791668; 4500,62.11279306; 4530,60.98372583; 4560,60.41784954; 4590,61.38512678; 4620,
            61.38512678; 4650,61.38512678; 4680,60.51043997; 4710,60.12748318; 4740,60.62745953; 4770,61.0522296; 4800,60.39226255; 4830,
            59.09382763; 4860,58.4663784; 4890,59.59784288; 4920,60.65329113; 4950,60.65329113; 4980,60.17054672; 5010,60.17054672; 5040,
            61.1638567; 5070,62.16676111; 5100,62.16676111; 5130,60.7354228; 5160,60.7354228; 5190,61.1955102; 5220,61.86407146; 5250,61.86407146;
            5280,60.50067158; 5310,59.94611835; 5340,61.01184053; 5370,61.7419095; 5400,62.22499094; 5430,62.22499094; 5460,61.67486801; 5490,
            62.89897728; 5520,64.83929386; 5550,65.38057795; 5580,65.38057795; 5610,66.01708889; 5640,67.61545744; 5670,69.3701746; 5700,
            69.3701746; 5730,68.37602749; 5760,67.2783637; 5790,67.2783637; 5820,68.01544504; 5850,68.01544504; 5880,68.01544504; 5910,
            67.63642931; 5940,68.411584; 5970,70.34751921; 6000,71.20659399; 6030,71.20659399; 6060,71.20659399; 6090,72.71766672; 6120,
            74.72588911; 6150,75.44203119; 6180,74.65377588; 6210,73.3486928; 6240,73.3486928; 6270,73.3486928; 6300,73.3486928; 6330,71.86744165;
            6360,70.58086252; 6390,70.58086252; 6420,71.49887924; 6450,72.26715202; 6480,71.75222139; 6510,71.17880545; 6540,71.57356367; 6570,
            73.08964291; 6600,73.83376379; 6630,73.13659315; 6660,71.99076147; 6690,70.84565821; 6720,70.10821266; 6750,68.84244232; 6780,
            66.03810425; 6810,63.91719475; 6840,63.29423018; 6870,63.29423018; 6900,63.29423018; 6930,62.92680931; 6960,62.4203207; 6990,
            62.4203207; 7020,63.44589844; 7050,65.48608961; 7080,65.95867424; 7110,65.95867424; 7140,67.84317455; 7170,71.00348539; 7200,
            73.98289347; 7230,74.43041296; 7260,74.43041296; 7290,75.10344257; 7320,76.74115105; 7350,78.66614914; 7380,78.66614914; 7410,
            78.14747858; 7440,77.18289757; 7470,77.6478447; 7500,78.64147539; 7530,79.12964487; 7560,79.12964487; 7590,79.55226231; 7620,
            81.7511178; 7650,84.69997587; 7680,85.75320625; 7710,86.40573692; 7740,86.40573692; 7770,86.88109932; 7800,87.5420557; 7830,
            87.5420557; 7860,86.61530342; 7890,83.93338823; 7920,83.93338823; 7950,83.93338823; 7980,83.93338823; 8010,83.36077137; 8040,
            81.94957323; 8070,81.94957323; 8100,81.94957323; 8130,83.11251726; 8160,83.11251726; 8190,83.11251726; 8220,83.11251726; 8250,
            83.11251726; 8280,84.45592918; 8310,84.45592918; 8340,84.45592918; 8370,83.98043089; 8400,85.4068388; 8430,87.12019386; 8460,
            87.12019386; 8490,87.80688944; 8520,87.80688944; 8550,89.44651136; 8580,91.5840929; 8610,92.51884689; 8640,91.78436394; 8670,
            91.78436394; 8700,91.78436394; 8730,92.75373402; 8760,92.75373402; 8790,92.75373402; 8820,92.75373402; 8850,92.75373402; 8880,
            93.82892017; 8910,93.82892017; 8940,93.82892017; 8970,93.82892017; 9000,93.82892017; 9030,93.84077053; 9060,93.84077053; 9090,
            93.19716568; 9120,92.17975273; 9150,92.17975273; 9180,93.09082775; 9210,93.71864662; 9240,93.71864662; 9270,93.71864662; 9300,
            94.80378056; 9330,95.84390488; 9360,95.84390488; 9390,95.84390488; 9420,95.24128704; 9450,95.24128704; 9480,94.4146431; 9510,
            94.4146431; 9540,93.38389034; 9570,90.87154398; 9600,89.85638151; 9630,89.85638151; 9660,90.36195688; 9690,90.36195688; 9720,
            90.36195688; 9750,90.36195688; 9780,91.20097847; 9810,92.86381187; 9840,93.3563736; 9870,92.77745647; 9900,91.73065681; 9930,
            91.24124794; 9960,91.24124794; 9990,91.24124794; 10020,89.67314672; 10050,88.16205225; 10080,87.62821541; 10110,88.34711895; 10140,
            89.30800896; 10170,89.30800896; 10200,89.30800896; 10230,90.12386255; 10260,90.78045931; 10290,92.51556358; 10320,92.51556358; 10350,
            93.03061924; 10380,93.03061924; 10410,93.84224911; 10440,94.77094746; 10470,94.77094746; 10500,93.18030338; 10530,91.94869251; 10560,
            91.94869251; 10590,91.94869251; 10620,90.52781296; 10650,87.1621376; 10680,85.71405115; 10710,85.09681606; 10740,85.7267767; 10770,
            85.7267767; 10800,85.7267767; 10830,85.27247314; 10860,85.27247314; 10890,88.46436138; 10920,88.46436138; 10950,88.46436138; 10980,
            88.46436138; 11010,88.46436138; 11040,89.18945103; 11070,89.71571016; 11100,88.52192259; 11130,87.03964949; 11160,86.02975445; 11190,
            86.02975445; 11220,86.02975445; 11250,86.02975445; 11280,86.02975445; 11310,85.52043371; 11340,85.9909853; 11370,86.4404726; 11400,
            86.4404726; 11430,84.3112298; 11460,83.87955065; 11490,83.87955065; 11520,84.76950703; 11550,84.76950703; 11580,83.45884123; 11610,
            83.45884123; 11640,83.45884123; 11670,84.63956623; 11700,85.07457218; 11730,84.41259928; 11760,83.55161648; 11790,83.55161648; 11820,
            83.55161648; 11850,83.55161648; 11880,82.3597043; 11910,80.50722713; 11940,78.91925755; 11970,78.91925755; 12000,78.05439348; 12030,
            76.74517365; 12060,75.3288331; 12090,74.84012547; 12120,76.65355625; 12150,78.67343874; 12180,80.64257126; 12210,80.64257126; 12240,
            83.35015497; 12270,85.30230017; 12300,87.47292137; 12330,88.43974743; 12360,88.43974743; 12390,88.43974743; 12420,88.43974743; 12450,
            89.51980963; 12480,89.51980963; 12510,88.8751339; 12540,88.8751339; 12570,88.8751339; 12600,89.8738472; 12630,91.39008408; 12660,
            91.39008408; 12690,91.39008408; 12720,91.39008408; 12750,91.39008408; 12780,92.03800507; 12810,92.03800507; 12840,90.58045464; 12870,
            89.5166894; 12900,88.8226553; 12930,88.8226553; 12960,88.05029469; 12990,86.70635548; 13020,85.50517502; 13050,85.50517502; 13080,
            87.28864832; 13110,88.26910229; 13140,88.26910229; 13170,87.59429512; 13200,87.59429512; 13230,88.18183908; 13260,89.00857; 13290,
            89.00857; 13320,87.57299709; 13350,87.57299709; 13380,87.57299709; 13410,87.57299709; 13440,86.93482819; 13470,86.07374754; 13500,
            85.59768391; 13530,85.59768391; 13560,86.90258217; 13590,86.90258217; 13620,86.17486153; 13650,85.12546349; 13680,85.12546349; 13710,
            85.12546349; 13740,85.12546349; 13770,84.69109898; 13800,84.69109898; 13830,86.79968519; 13860,89.77017832; 13890,91.03381233; 13920,
            91.51187096; 13950,92.45918198; 13980,94.65636864; 14010,96.98474636; 14040,96.98474636; 14070,96.98474636; 14100,96.98474636; 14130,
            96.37941055; 14160,96.37941055; 14190,96.37941055; 14220,95.30238705; 14250,93.15822258; 14280,93.15822258; 14310,92.59405861; 14340,
            93.33016148; 14370,93.33016148; 14400,92.36020432; 14430,92.84760189; 14460,94.32433033; 14490,95.29471149; 14520,95.29471149; 14550,
            95.29471149; 14580,94.23710518; 14610,94.23710518; 14640,94.98898315; 14670,94.98898315; 14700,94.03913898; 14730,94.03913898; 14760,
            94.87981853; 14790,96.83330097; 14820,97.39924793; 14850,97.39924793; 14880,97.39924793; 14910,97.39924793; 14940,97.39924793; 14970,
            97.85276871; 15000,97.85276871; 15030,97.85276871; 15060,97.85276871; 15090,97.85276871; 15120,97.82742634; 15150,97.82742634; 15180,
            97.82742634; 15210,97.82742634; 15240,97.82742634; 15270,97.94380989; 15300,97.94380989; 15330,97.94380989; 15360,97.94380989; 15390,
            97.94380989; 15420,97.79311466; 15450,97.79311466; 15480,97.79311466; 15510,97.79311466; 15540,97.79311466; 15570,97.62053432; 15600,
            97.62053432; 15630,97.62053432; 15660,96.3418808; 15690,95.79330711; 15720,95.79330711; 15750,93.08922958; 15780,89.92416773; 15810,
            88.90429773; 15840,88.90429773; 15870,88.90429773; 15900,88.17245121; 15930,87.58414621; 15960,87.58414621; 15990,88.6184432; 16020,
            91.0147213; 16050,91.96440239; 16080,91.96440239; 16110,91.96440239; 16140,94.28103848; 16170,96.44310894; 16200,96.44310894; 16230,
            96.44310894; 16260,97.03646393; 16290,97.03646393; 16320,97.03646393; 16350,97.03646393; 16380,97.03646393; 16410,97.1272768; 16440,
            97.1272768; 16470,97.1272768; 16500,97.1272768; 16530,97.1272768; 16560,95.96116905; 16590,95.96116905; 16620,95.96116905; 16650,
            96.73757401; 16680,96.73757401; 16710,96.73757401; 16740,96.73757401; 16770,96.73757401; 16800,96.62887688; 16830,96.62887688; 16860,
            96.62887688; 16890,96.62887688; 16920,96.62887688; 16950,96.74157486; 16980,96.74157486; 17010,96.74157486; 17040,96.74157486; 17070,
            96.74157486; 17100,96.9238203; 17130,96.9238203; 17160,96.9238203; 17190,96.9238203; 17220,96.9238203; 17250,96.67107067; 17280,
            96.67107067; 17310,96.67107067; 17340,96.67107067; 17370,96.67107067; 17400,97.16654606; 17430,97.16654606; 17460,97.16654606; 17490,
            97.16654606; 17520,97.16654606; 17550,96.87985439; 17580,96.87985439; 17610,96.87985439; 17640,96.87985439; 17670,96.87985439; 17700,
            97.04056263; 17730,97.04056263; 17760,97.04056263; 17790,97.04056263; 17820,97.04056263; 17850,97.15780506; 17880,97.15780506; 17910,
            97.15780506; 17940,97.15780506; 17970,97.10132561; 18000,97.10132561; 18030,97.10132561; 18060,97.10132561; 18090,97.10132561; 18120,
            97.10132561; 18150,96.97984314; 18180,96.97984314; 18210,96.97984314; 18240,96.97984314; 18270,96.97984314; 18300,97.20978355; 18330,
            97.20978355; 18360,97.20978355; 18390,97.20978355; 18420,97.20978355; 18450,96.87995224; 18480,96.87995224; 18510,96.87995224; 18540,
            96.87995224; 18570,96.87995224; 18600,97.10142345; 18630,98.31977062; 18660,135.7417414; 18690,141.4950027; 18720,141.4950027; 18750,
            141.4950027; 18780,138.3526794; 18810,133.7771152; 18840,129.1616077; 18870,122.7757765; 18900,114.2397795; 18930,106.6630199; 18960,
            100.6198162; 18990,97.46893673; 19020,95.19717979; 19050,91.69256172; 19080,90.38953342; 19110,90.38953342; 19140,92.55935555; 19170,
            95.41054058; 19200,97.14911842; 19230,98.39016609; 19260,98.99299049; 19290,100.8703262; 19320,102.2186686; 19350,102.7721889; 19380,
            102.0769318; 19410,100.8557253; 19440,100.2109354; 19470,100.2109354; 19500,100.2109354; 19530,99.66780853; 19560,97.81971817; 19590,
            97.81971817; 19620,97.81971817; 19650,100.7846123; 19680,101.6402842; 19710,101.6402842; 19740,101.6402842; 19770,102.9293421; 19800,
            104.3197477; 19830,104.3197477; 19860,104.3197477; 19890,102.7812235; 19920,102.2286489; 19950,102.2286489; 19980,102.2286489; 20010,
            102.2286489; 20040,100.5705339; 20070,99.69776058; 20100,99.69776058; 20130,101.5910236; 20160,101.5910236; 20190,101.5910236; 20220,
            100.7709137; 20250,100.7709137; 20280,100.7709137; 20310,101.7968285; 20340,101.7968285; 20370,101.7968285; 20400,101.7968285; 20430,
            102.6955856; 20460,103.3175337; 20490,103.3175337; 20520,103.3175337; 20550,103.3175337; 20580,103.8448093; 20610,103.8448093; 20640,
            103.8448093; 20670,102.8813427; 20700,101.8849451; 20730,101.8849451; 20760,101.8849451; 20790,101.8849451; 20820,100.6994419; 20850,
            99.12928047; 20880,99.12928047; 20910,100.0781788; 20940,101.0970594; 20970,101.0970594; 21000,101.0970594; 21030,101.8518728; 21060,
            103.6277412; 21090,104.6556129; 21120,104.6556129; 21150,104.6556129; 21180,103.6084328; 21210,103.6084328; 21240,103.6084328; 21270,
            103.6084328; 21300,102.3835081; 21330,101.8633535; 21360,101.8633535; 21390,102.6389431; 21420,102.6389431; 21450,102.0932178; 21480,
            102.0932178; 21510,102.0932178; 21540,102.9867348; 21570,104.5804121; 21600,104.5804121; 21630,105.2639277; 21660,105.2639277; 21690,
            106.8058983; 21720,107.7409784; 21750,107.7409784; 21780,106.9917532; 21810,106.9917532; 21840,106.9917532; 21870,108.0234192; 21900,
            108.0234192; 21930,108.0234192; 21960,107.1881865; 21990,107.1881865; 22020,107.1881865; 22050,106.1790035; 22080,103.8195105; 22110,
            101.2276308; 22140,99.65137024; 22170,99.65137024; 22200,99.65137024; 22230,98.86195164; 22260,97.65122566; 22290,97.0652092; 22320,
            97.0652092; 22350,97.0652092; 22380,97.0652092; 22410,95.81247425; 22440,95.81247425; 22470,95.31661835; 22500,95.31661835; 22530,
            96.01387596; 22560,94.89997501; 22590,93.25236225; 22620,92.13649349; 22650,91.53860493; 22680,92.02545891; 22710,91.13832378; 22740,
            89.6159008; 22770,88.14779377; 22800,88.14779377; 22830,89.49296694; 22860,90.02974463; 22890,90.02974463; 22920,90.02974463; 22950,
            90.02974463; 22980,90.60085573; 23010,92.09814835; 23040,91.12514706; 23070,90.28893585; 23100,90.28893585; 23130,90.28893585; 23160,
            90.28893585; 23190,89.44305954; 23220,87.43805523; 23250,85.33397541; 23280,85.33397541; 23310,84.70921154; 23340,84.70921154; 23370,
            83.09650841; 23400,82.21325455; 23430,82.21325455; 23460,83.80903015; 23490,85.93801203; 23520,86.52482214; 23550,86.52482214; 23580,
            86.52482214; 23610,87.41534929; 23640,88.12720242; 23670,88.12720242; 23700,86.51115618; 23730,85.56031179; 23760,85.06451025; 23790,
            85.06451025; 23820,84.4087615; 23850,82.23516684; 23880,80.54505043; 23910,79.97752705; 23940,80.86698332; 23970,80.86698332; 24000,
            81.48258762; 24030,81.48258762; 24060,82.14326677; 24090,83.72786064; 24120,84.92567625; 24150,85.53746452; 24180,85.53746452; 24210,
            85.53746452; 24240,85.05126829; 24270,85.05126829; 24300,85.05126829; 24330,82.94669924; 24360,82.94669924; 24390,82.15523129; 24420,
            82.60315847; 24450,84.26929693; 24480,84.26929693; 24510,84.26929693; 24540,84.26929693; 24570,84.85652018; 24600,85.90988646; 24630,
            86.73354063; 24660,85.82430296; 24690,84.8736434; 24720,84.8736434; 24750,84.8736434; 24780,84.8736434; 24810,84.8736434; 24840,
            84.07692432; 24870,84.07692432; 24900,84.97190351; 24930,86.78966675; 24960,86.78966675; 24990,87.54209375; 25020,88.91206026; 25050,
            90.1147954; 25080,91.86809921; 25110,91.86809921; 25140,90.17926025; 25170,89.47597961; 25200,88.85820637; 25230,89.8426775; 25260,
            89.8426775; 25290,89.8426775; 25320,89.8426775; 25350,89.8426775; 25380,91.45718536; 25410,92.98628368; 25440,92.98628368; 25470,
            92.98628368; 25500,94.26603527; 25530,95.33282833; 25560,96.89395523; 25590,98.23955784; 25620,98.23955784; 25650,98.23955784; 25680,
            98.80773354; 25710,100.2905828; 25740,101.9991652; 25770,101.9991652; 25800,101.9991652; 25830,101.9991652; 25860,103.0382784; 25890,
            103.0382784; 25920,102.2905535; 25950,98.1628458; 25980,95.182057; 26010,92.90696239; 26040,91.72651463; 26070,89.57568569; 26100,
            86.11120119; 26130,84.71233177; 26160,84.71233177; 26190,85.47261915; 26220,87.31726856; 26250,87.31726856; 26280,88.59754744; 26310,
            90.30599928; 26340,92.64787445; 26370,95.44580898; 26400,96.14737186; 26430,96.14737186; 26460,96.14737186; 26490,96.14737186; 26520,
            97.5360815; 26550,97.5360815; 26580,97.5360815; 26610,95.49563484; 26640,96.00392818; 26670,97.19679165; 26700,97.72595901; 26730,
            97.72595901; 26760,97.72595901; 26790,97.72595901; 26820,97.72595901; 26850,98.22239113; 26880,98.22239113; 26910,98.22239113; 26940,
            98.22239113; 26970,98.22239113; 27000,100.6299814; 27030,101.6219759; 27060,101.6219759; 27090,101.6219759; 27120,101.6219759; 27150,
            101.6219759; 27180,101.9400764; 27210,100.8270561; 27240,99.15106773; 27270,99.15106773; 27300,99.15106773; 27330,99.15106773; 27360,
            97.22982044; 27390,95.20525761; 27420,94.63879967; 27450,94.63879967; 27480,94.63879967; 27510,94.63879967; 27540,94.63879967; 27570,
            94.45957661; 27600,94.45957661; 27630,96.02180157; 27660,96.02180157; 27690,96.02180157; 27720,96.02180157; 27750,96.02180157; 27780,
            96.93714924; 27810,97.47704716; 27840,97.47704716; 27870,96.76861324; 27900,95.58493652; 27930,95.58493652; 27960,95.58493652; 27990,
            94.4600441; 28020,92.79622135; 28050,91.94521351; 28080,91.94521351; 28110,93.6103735; 28140,95.36121483; 28170,95.85552692; 28200,
            95.85552692; 28230,96.44931679; 28260,97.41633854; 28290,98.95855923; 28320,98.95855923; 28350,97.04444389; 28380,96.41287422; 28410,
            96.41287422; 28440,96.41287422; 28470,95.0009531; 28500,92.76413841; 28530,90.36374531; 28560,89.35199118; 28590,89.35199118; 28620,
            89.35199118; 28650,88.15185986; 28680,86.66157417; 28710,86.16877327; 28740,86.96090984; 28770,88.08472052; 28800,88.08472052; 28830,
            86.85453386; 28860,85.91586056; 28890,85.91586056; 28920,85.91586056; 28950,85.91586056; 28980,85.1729845; 29010,84.67663937; 29040,
            84.67663937; 29070,86.75586605; 29100,88.2687109; 29130,89.03485823; 29160,89.03485823; 29190,89.03485823; 29220,89.63906879; 29250,
            90.1990797; 29280,90.1990797; 29310,89.6138895; 29340,87.35990267; 29370,86.67221231; 29400,86.67221231; 29430,86.67221231; 29460,
            86.67221231; 29490,86.17948208; 29520,87.08160954; 29550,88.78592463; 29580,91.12810965; 29610,91.12810965; 29640,91.68751717; 29670,
            91.68751717; 29700,92.67524986; 29730,94.49688892; 29760,94.49688892; 29790,94.0025877; 29820,94.0025877; 29850,93.45456848; 29880,
            94.21405678; 29910,94.76999073; 29940,94.76999073; 29970,94.76999073; 30000,93.74559803; 30030,93.74559803; 30060,94.34179058; 30090,
            94.34179058; 30120,92.73078346; 30150,92.73078346; 30180,92.1889286; 30210,92.1889286; 30240,92.86170273; 30270,91.76774082; 30300,
            91.76774082; 30330,91.76774082; 30360,92.24399471; 30390,92.24399471; 30420,92.24399471; 30450,92.24399471; 30480,92.24399471; 30510,
            93.63652039; 30540,94.48933296; 30570,94.48933296; 30600,94.48933296; 30630,93.85857868; 30660,93.85857868; 30690,95.09409256; 30720,
            96.20313377; 30750,96.20313377; 30780,96.20313377; 30810,96.20313377; 30840,96.84191151; 30870,98.14813614; 30900,98.14813614; 30930,
            98.14813614; 30960,98.14813614; 30990,98.14813614; 31020,98.24417839; 31050,97.6683054; 31080,95.82324829; 31110,94.94694157; 31140,
            94.94694157; 31170,96.89393349; 31200,97.8206749; 31230,97.8206749; 31260,96.82602768; 31290,96.82602768; 31320,97.60637913; 31350,
            98.93914204; 31380,98.93914204; 31410,97.80261669; 31440,97.17065563; 31470,97.17065563; 31500,97.80095329; 31530,97.80095329; 31560,
            96.68511715; 31590,95.29371128; 31620,94.72329597; 31650,94.72329597; 31680,94.04751034; 31710,94.04751034; 31740,94.04751034; 31770,
            94.04751034; 31800,95.36597672; 31830,96.13531494; 31860,96.13531494; 31890,96.13531494; 31920,96.13531494; 31950,96.13531494; 31980,
            96.84598846; 32010,96.84598846; 32040,96.84598846; 32070,96.84598846; 32100,97.50345497; 32130,99.65494709; 32160,100.8220768; 32190,
            100.8220768; 32220,100.8220768; 32250,101.6055159; 32280,103.2723936; 32310,104.7963387; 32340,104.7963387; 32370,103.9468964; 32400,
            102.9063698; 32430,102.9063698; 32460,103.8052357; 32490,103.8052357; 32520,103.8052357; 32550,103.8052357; 32580,103.8052357; 32610,
            104.8547533; 32640,106.095714; 32670,106.095714; 32700,105.5605562; 32730,104.9400867; 32760,104.9400867; 32790,104.9400867; 32820,
            102.9108816; 32850,100.7627489; 32880,99.66158981; 32910,99.66158981; 32940,99.66158981; 32970,100.6133039; 33000,100.6133039; 33030,
            100.6133039; 33060,102.0863577; 33090,103.8963203; 33120,105.4127747; 33150,106.4629555; 33180,105.6885183; 33210,105.6885183; 33240,
            105.0693426; 33270,105.0693426; 33300,105.0693426; 33330,102.3533821; 33360,101.4381323; 33390,101.4381323; 33420,100.7473761; 33450,
            101.9756601; 33480,101.9756601; 33510,101.3417639; 33540,101.3417639; 33570,102.1202671; 33600,103.2855703; 33630,103.2855703; 33660,
            102.3846823; 33690,101.5061251; 33720,101.5061251; 33750,101.5061251; 33780,100.4466488; 33810,98.64663391; 33840,96.4031765; 33870,
            96.4031765; 33900,96.4031765; 33930,98.25012531; 33960,98.80760307; 33990,98.80760307; 34020,98.80760307; 34050,98.80760307; 34080,
            99.73725815; 34110,100.5321236; 34140,99.94841194; 34170,99.94841194; 34200,99.94841194; 34230,100.4758833; 34260,101.2034843; 34290,
            100.5110756; 34320,99.18637962; 34350,99.18637962; 34380,99.18637962; 34410,99.93645287; 34440,99.93645287; 34470,99.93645287; 34500,
            99.93645287; 34530,99.93645287; 34560,99.90602245; 34590,99.90602245; 34620,98.65940838; 34650,97.31270771; 34680,97.31270771; 34710,
            97.31270771; 34740,97.31270771; 34770,96.30977612; 34800,95.21894531; 34830,94.62146988; 34860,94.62146988; 34890,96.46944065; 34920,
            96.46944065; 34950,96.46944065; 34980,94.73642921; 35010,94.73642921; 35040,94.73642921; 35070,94.73642921; 35100,93.51914749; 35130,
            91.45335846; 35160,91.45335846; 35190,91.45335846; 35220,91.45335846; 35250,90.67574673; 35280,88.7658062; 35310,88.10529013; 35340,
            88.10529013; 35370,88.82095385; 35400,89.41317816; 35430,89.41317816; 35460,89.41317816; 35490,88.86110916; 35520,88.86110916; 35550,
            90.06450748; 35580,90.06450748; 35610,90.06450748; 35640,90.92858334; 35670,93.59055405; 35700,96.19800224; 35730,96.71189461; 35760,
            96.71189461; 35790,96.71189461; 35820,98.15102806; 35850,98.94164257; 35880,100.2568583; 35910,99.10282917; 35940,97.51721878; 35970,
            96.83809547; 36000,96.83809547; 36030,96.83809547; 36060,95.94956875; 36090,93.78633499; 36120,93.78633499; 36150,94.54434471; 36180,
            96.60269737; 36210,97.41260948; 36240,97.41260948; 36270,96.40476379; 36300,96.40476379; 36330,95.89598122; 36360,95.89598122; 36390,
            95.13647118; 36420,93.80015316; 36450,93.80015316; 36480,93.80015316; 36510,94.99975719; 36540,95.70850639; 36570,95.70850639; 36600,
            95.70850639; 36630,96.23779335; 36660,96.9199934; 36690,97.86024857; 36720,96.37393112; 36750,94.42189465; 36780,93.55120869; 36810,
            93.55120869; 36840,93.55120869; 36870,92.50662689; 36900,90.38919096; 36930,89.91698141; 36960,89.91698141; 36990,92.27375107; 37020,
            93.93168125; 37050,94.43365803; 37080,94.43365803; 37110,94.43365803; 37140,95.49463463; 37170,96.39342442; 37200,96.39342442; 37230,
            96.39342442; 37260,95.19519024; 37290,95.19519024; 37320,96.71615639; 37350,97.45974998; 37380,97.45974998; 37410,97.45974998; 37440,
            98.43935051; 37470,99.86977558; 37500,100.560858; 37530,100.560858; 37560,100.560858; 37590,100.560858; 37620,101.7650064; 37650,
            101.7650064; 37680,101.7650064; 37710,101.1416233; 37740,99.64979382; 37770,99.64979382; 37800,99.64979382; 37830,100.2715353; 37860,
            100.2715353; 37890,99.19383774; 37920,99.19383774; 37950,99.71551437; 37980,101.34396; 38010,102.1106998; 38040,101.5929914; 38070,
            101.5929914; 38100,101.5929914; 38130,103.1857664; 38160,104.0332083; 38190,104.0332083; 38220,104.0332083; 38250,104.0332083; 38280,
            105.5241028; 38310,105.5241028; 38340,104.9893364; 38370,102.8971613; 38400,101.2090834; 38430,101.2090834; 38460,101.8738667; 38490,
            101.8738667; 38520,99.42527847; 38550,97.86278172; 38580,97.86278172; 38610,97.86278172; 38640,99.36190624; 38670,99.36190624; 38700,
            99.36190624; 38730,99.36190624; 38760,100.7561932; 38790,101.8542973; 38820,101.0616062; 38850,99.48631325; 38880,98.93414097; 38910,
            98.93414097; 38940,98.93414097; 38970,98.93414097; 39000,97.55175877; 39030,97.55175877; 39060,97.55175877; 39090,97.55175877; 39120,
            97.55175877; 39150,96.75718689; 39180,96.24132671; 39210,95.29286327; 39240,95.29286327; 39270,95.29286327; 39300,93.87509308; 39330,
            91.95341091; 39360,91.43981209; 39390,92.07207756; 39420,93.54624023; 39450,94.11301346; 39480,94.11301346; 39510,94.11301346; 39540,
            95.47767448; 39570,97.23921375; 39600,97.23921375; 39630,98.01013927; 39660,96.63836803; 39690,95.97273674; 39720,95.97273674; 39750,
            95.97273674; 39780,95.97273674; 39810,94.4144474; 39840,93.31151619; 39870,93.31151619; 39900,93.31151619; 39930,93.31151619; 39960,
            93.31151619; 39990,92.65782223; 40020,92.65782223; 40050,92.65782223; 40080,92.65782223; 40110,91.49013805; 40140,89.77509785; 40170,
            88.73272848; 40200,88.73272848; 40230,88.73272848; 40260,88.73272848; 40290,87.40208559; 40320,87.40208559; 40350,87.40208559; 40380,
            88.22113552; 40410,89.31200981; 40440,89.31200981; 40470,89.31200981; 40500,88.21159; 40530,88.21159; 40560,88.21159; 40590,
            88.88184729; 40620,88.88184729; 40650,88.88184729; 40680,88.88184729; 40710,90.25856524; 40740,91.78342896; 40770,91.78342896; 40800,
            92.49859257; 40830,92.49859257; 40860,92.99213276; 40890,92.99213276; 40920,93.60286102; 40950,92.74371014; 40980,91.60233593; 41010,
            91.60233593; 41040,91.60233593; 41070,91.60233593; 41100,91.60233593; 41130,90.40910282; 41160,90.40910282; 41190,90.40910282; 41220,
            91.56531715; 41250,92.45400696; 41280,91.28864937; 41310,91.28864937; 41340,89.91098557; 41370,89.91098557; 41400,89.91098557; 41430,
            89.91098557; 41460,89.91098557; 41490,89.42000027; 41520,89.42000027; 41550,90.62994347; 41580,90.62994347; 41610,90.62994347; 41640,
            90.62994347; 41670,91.58282089; 41700,93.1274334; 41730,93.1274334; 41760,93.73858566; 41790,93.07946663; 41820,93.07946663; 41850,
            93.07946663; 41880,93.07946663; 41910,90.68189478; 41940,89.43479691; 41970,88.20976896; 42000,88.20976896; 42030,88.20976896; 42060,
            88.20976896; 42090,87.56833849; 42120,87.56833849; 42150,87.56833849; 42180,88.40351143; 42210,88.40351143; 42240,88.40351143; 42270,
            88.40351143; 42300,90.00244532; 42330,91.52513466; 42360,92.18680859; 42390,92.18680859; 42420,92.18680859; 42450,92.18680859; 42480,
            92.18680859; 42510,92.15723705; 42540,90.64469118; 42570,89.25467691; 42600,88.71849174; 42630,88.71849174; 42660,88.71849174; 42690,
            88.71849174; 42720,88.71849174; 42750,90.08703947; 42780,91.9063139; 42810,92.85161362; 42840,93.46760387; 42870,93.46760387; 42900,
            93.46760387; 42930,94.45146618; 42960,94.45146618; 42990,94.97830696; 43020,94.97830696; 43050,94.40821781; 43080,94.40821781; 43110,
            94.40821781; 43140,93.59024963; 43170,92.53351307; 43200,91.98702679; 43230,91.98702679; 43260,91.98702679; 43290,91.98702679; 43320,
            91.98702679; 43350,91.63935471; 43380,91.63935471; 43410,92.25519276; 43440,92.25519276; 43470,92.25519276; 43500,91.03719893; 43530,
            90.27619944; 43560,90.27619944; 43590,90.93593817; 43620,90.93593817; 43650,91.41955776; 43680,91.41955776; 43710,92.6524189; 43740,
            94.07806034; 43770,95.52522812; 43800,95.52522812; 43830,95.52522812; 43860,95.52522812; 43890,95.52522812; 43920,95.78645782; 43950,
            94.41806774; 43980,93.43883686; 44010,92.92751026; 44040,92.92751026; 44070,93.6425869; 44100,93.6425869; 44130,93.6425869; 44160,
            93.6425869; 44190,93.6425869; 44220,93.4037859; 44250,93.4037859; 44280,93.4037859; 44310,93.4037859; 44340,93.4037859; 44370,
            93.28260784; 44400,93.7929451; 44430,93.7929451; 44460,93.07921658; 44490,93.07921658; 44520,92.60955105; 44550,93.41457081; 44580,
            94.62006741; 44610,94.62006741; 44640,94.62006741; 44670,94.03377914; 44700,94.03377914; 44730,93.52325706; 44760,93.02961903; 44790,
            91.34193249; 44820,90.58628197; 44850,90.58628197; 44880,90.58628197; 44910,89.80906706; 44940,89.80906706; 44970,88.10733948; 45000,
            88.10733948; 45030,87.31010942; 45060,87.31010942; 45090,87.87408314; 45120,86.85023403; 45150,86.85023403; 45180,86.85023403; 45210,
            88.21365566; 45240,88.81201715; 45270,88.81201715; 45300,88.81201715; 45330,89.30175762; 45360,90.33461952; 45390,90.90208311; 45420,
            90.90208311; 45450,89.92245541; 45480,88.93846807; 45510,88.93846807; 45540,88.93846807; 45570,88.93846807; 45600,86.70914412; 45630,
            84.97195787; 45660,84.97195787; 45690,84.97195787; 45720,84.97195787; 45750,84.97195787; 45780,84.63348885; 45810,84.63348885; 45840,
            84.63348885; 45870,85.83168497; 45900,86.71615648; 45930,85.55026617; 45960,84.66998577; 45990,84.66998577; 46020,84.66998577; 46050,
            84.66998577; 46080,84.66998577; 46110,84.81501131; 46140,84.81501131; 46170,85.28958006; 46200,86.98216982; 46230,86.98216982; 46260,
            86.98216982; 46290,86.98216982; 46320,86.98216982; 46350,88.29404783; 46380,88.29404783; 46410,88.29404783; 46440,87.80058918; 46470,
            87.80058918; 46500,87.80058918; 46530,88.86383257; 46560,88.86383257; 46590,88.86383257; 46620,88.86383257; 46650,89.18362913; 46680,
            90.27391634; 46710,90.27391634; 46740,90.27391634; 46770,89.75445757; 46800,89.1126955; 46830,89.1126955; 46860,89.1126955; 46890,
            89.1126955; 46920,88.09072723; 46950,87.37368822; 46980,87.37368822; 47010,87.37368822; 47040,87.37368822; 47070,87.37368822; 47100,
            87.24267111; 47130,87.90433416; 47160,89.04415913; 47190,89.04415913; 47220,89.04415913; 47250,89.04415913; 47280,89.04415913; 47310,
            89.23685789; 47340,90.27188873; 47370,91.92219772; 47400,94.0964447; 47430,96.18706512; 47460,99.60577354; 47490,96.32886715; 47520,
            96.32886715; 47550,96.32886715; 47580,96.32886715; 47610,96.32886715; 47640,96.03058605; 47670,96.03058605; 47700,96.03058605; 47730,
            96.03058605; 47760,96.03058605; 47790,96.0659523; 47820,96.0659523; 47850,96.0659523; 47880,96.68560638; 47910,96.68560638; 47940,
            96.68560638; 47970,96.68560638; 48000,96.68560638; 48030,96.25676479; 48060,96.25676479; 48090,96.25676479; 48120,96.25676479; 48150,
            96.25676479; 48180,96.30049152; 48210,96.30049152; 48240,96.30049152; 48270,96.30049152; 48300,96.30049152; 48330,96.07810707; 48360,
            96.07810707; 48390,96.07810707; 48420,96.07810707; 48450,96.07810707; 48480,96.48659649; 48510,96.48659649; 48540,96.48659649; 48570,
            96.48659649; 48600,96.48659649; 48630,96.2683651; 48660,96.2683651; 48690,96.2683651; 48720,96.2683651; 48750,96.2683651; 48780,
            96.13184681; 48810,96.13184681; 48840,96.13184681; 48870,96.13184681; 48900,96.13184681; 48930,96.4676033; 48960,96.4676033; 48990,
            96.4676033; 49020,96.4676033; 49050,96.4676033; 49080,96.2515028; 49110,96.2515028; 49140,96.2515028; 49170,96.2515028; 49200,
            96.2515028; 49230,96.20651493; 49260,96.20651493; 49290,96.20651493; 49320,96.20651493; 49350,96.20651493; 49380,95.62032452; 49410,
            94.44127922; 49440,92.70377769; 49470,90.98138809; 49500,89.1230401; 49530,86.89499903; 49560,85.23659592; 49590,83.07656393; 49620,
            81.5191824; 49650,79.68204002; 49680,78.2706027; 49710,77.86422243; 49740,77.86422243; 49770,77.22367258; 49800,77.22367258; 49830,
            77.77894335; 49860,79.30551939; 49890,81.10058212; 49920,82.30718765; 49950,83.84736986; 49980,85.34496145; 50010,86.45448647; 50040,
            87.54457254; 50070,88.3249403; 50100,88.3249403; 50130,88.94749174; 50160,88.09119473; 50190,88.09119473; 50220,86.99753723; 50250,
            86.99753723; 50280,86.99753723; 50310,86.52971992; 50340,86.52971992; 50370,86.52971992; 50400,87.8492898; 50430,88.77006798; 50460,
            90.21717052; 50490,91.42847271; 50520,92.82680397; 50550,93.6369009; 50580,94.12243938; 50610,94.6534441; 50640,94.6534441; 50670,
            94.6534441; 50700,95.32247829; 50730,95.32247829; 50760,95.32247829; 50790,95.32247829; 50820,95.32247829; 50850,95.08020916; 50880,
            95.08020916; 50910,95.08020916; 50940,95.08020916; 50970,95.67740192; 51000,95.67740192; 51030,95.67740192; 51060,95.67740192; 51090,
            95.67740192; 51120,95.75102634; 51150,95.75102634; 51180,95.75102634; 51210,95.75102634; 51240,95.75102634; 51270,95.66799774; 51300,
            95.66799774; 51330,95.66799774; 51360,95.66799774; 51390,95.66799774; 51420,95.85741863; 51450,95.85741863; 51480,95.85741863; 51510,
            95.85741863; 51540,95.85741863; 51570,95.9541132; 51600,95.9541132; 51630,95.9541132; 51660,95.9541132; 51690,95.9541132; 51720,
            96.15623245; 51750,96.15623245; 51780,96.15623245; 51810,96.15623245; 51840,96.15623245; 51870,96.06519127; 51900,96.06519127; 51930,
            96.06519127; 51960,96.06519127; 51990,96.06519127; 52020,95.89349155; 52050,95.89349155; 52080,95.89349155; 52110,95.89349155; 52140,
            95.89349155; 52170,96.05822239; 52200,96.05822239; 52230,96.05822239; 52260,96.05822239; 52290,96.05822239; 52320,96.08356476; 52350,
            96.08356476; 52380,96.08356476; 52410,96.08356476; 52440,96.08356476; 52470,96.11931152; 52500,96.11931152; 52530,96.11931152; 52560,
            96.11931152; 52590,96.11931152; 52620,96.04632854; 52650,96.04632854; 52680,96.04632854; 52710,96.04632854; 52740,96.04632854; 52770,
            96.15036163; 52800,96.15036163; 52830,96.15036163; 52860,96.15036163; 52890,96.15036163; 52920,96.22780209; 52950,96.22780209; 52980,
            96.22780209; 53010,96.22780209; 53040,96.22780209; 53070,96.23669529; 53100,96.23669529; 53130,96.23669529; 53160,96.23669529; 53190,
            96.23669529; 53220,96.51966877; 53250,96.51966877; 53280,96.51966877; 53310,96.51966877; 53340,96.03654385; 53370,96.03654385; 53400,
            96.03654385; 53430,96.03654385; 53460,96.64901161; 53490,96.64901161; 53520,96.64901161; 53550,96.64901161; 53580,95.96131039; 53610,
            96.50603542; 53640,96.50603542; 53670,95.70820198; 53700,95.70820198; 53730,95.70820198; 53760,95.1177063; 53790,95.1177063; 53820,
            95.1177063; 53850,95.1177063; 53880,95.92191067; 53910,95.92191067; 53940,95.92191067; 53970,95.92191067; 54000,95.92191067; 54030,
            96.22642136; 54060,96.22642136; 54090,96.22642136; 54120,96.22642136; 54150,96.22642136; 54180,96.57450657; 54210,96.57450657; 54240,
            96.57450657; 54270,96.57450657; 54300,96.57450657; 54330,96.38671646; 54360,96.38671646; 54390,96.38671646; 54420,96.38671646; 54450,
            95.34423294; 54480,95.34423294; 54510,95.34423294; 54540,95.34423294; 54570,94.60075893; 54600,94.60075893; 54630,95.71955223; 54660,
            96.30117645; 54690,96.30117645; 54720,96.30117645; 54750,96.30117645; 54780,96.30117645; 54810,95.95149307; 54840,95.95149307; 54870,
            95.95149307; 54900,95.95149307; 54930,95.95149307; 54960,95.68605595; 54990,95.68605595; 55020,96.32698631; 55050,96.32698631; 55080,
            95.66470356; 55110,95.66470356; 55140,95.66470356; 55170,96.19754562; 55200,96.19754562; 55230,96.19754562; 55260,96.19754562; 55290,
            96.19754562; 55320,96.15700436; 55350,96.15700436; 55380,96.15700436; 55410,96.15700436; 55440,96.15700436; 55470,96.02074699; 55500,
            96.02074699; 55530,96.02074699; 55560,96.02074699; 55590,96.02074699; 55620,96.01072311; 55650,96.01072311; 55680,96.01072311; 55710,
            96.01072311; 55740,96.01072311; 55770,96.06705036; 55800,96.06705036; 55830,96.06705036; 55860,96.67408218; 55890,96.67408218; 55920,
            96.67408218; 55950,96.67408218; 55980,96.04166451; 56010,96.04166451; 56040,96.04166451; 56070,96.04166451; 56100,96.04166451; 56130,
            95.74605789; 56160,95.74605789; 56190,95.74605789; 56220,95.74605789; 56250,95.74605789; 56280,95.93076038; 56310,95.93076038; 56340,
            95.93076038; 56370,95.93076038; 56400,95.93076038; 56430,96.00565681; 56460,96.00565681; 56490,96.00565681; 56520,96.00565681; 56550,
            96.00565681; 56580,95.94787273; 56610,95.94787273; 56640,95.94787273; 56670,95.94787273; 56700,95.94787273; 56730,96.08228188; 56760,
            96.08228188; 56790,96.08228188; 56820,96.08228188; 56850,96.08228188; 56880,96.01859436; 56910,96.01859436; 56940,96.01859436; 56970,
            96.01859436; 57000,96.01859436; 57030,95.96465893; 57060,95.96465893; 57090,95.96465893; 57120,95.96465893; 57150,95.96465893; 57180,
            96.04465427; 57210,96.04465427; 57240,96.04465427; 57270,96.04465427; 57300,96.04465427; 57330,95.79547062; 57360,95.79547062; 57390,
            95.79547062; 57420,95.79547062; 57450,96.36933231; 57480,96.36933231; 57510,96.36933231; 57540,96.36933231; 57570,96.20378609; 57600,
            96.20378609; 57630,96.20378609; 57660,96.20378609; 57690,96.20378609; 57720,96.4780077; 57750,96.4780077; 57780,96.4780077; 57810,
            95.96409359; 57840,95.96409359; 57870,95.96409359; 57900,95.96409359; 57930,95.96409359; 57960,95.66960678; 57990,95.10724754; 58020,
            94.34641113; 58050,93.52070217; 58080,92.03741798; 58110,90.9910532; 58140,90.36387033; 58170,88.85436859; 58200,88.85436859; 58230,
            88.85436859; 58260,87.52195358; 58290,86.60920429; 58320,86.60920429; 58350,87.54022379; 58380,88.62038927; 58410,89.28678703; 58440,
            89.28678703; 58470,88.83718557; 58500,88.83718557; 58530,88.83718557; 58560,88.83718557; 58590,87.88672171; 58620,87.13743668; 58650,
            87.13743668; 58680,87.85986814; 58710,88.55541344; 58740,88.55541344; 58770,88.55541344; 58800,88.55541344; 58830,90.03182116; 58860,
            90.90245819; 58890,90.90245819; 58920,90.90245819; 58950,90.90245819; 58980,92.02813339; 59010,93.29530621; 59040,93.29530621; 59070,
            93.29530621; 59100,93.29530621; 59130,93.29530621; 59160,93.00529861; 59190,91.66534939; 59220,89.92718468; 59250,88.92072515; 59280,
            88.46782408; 59310,88.46782408; 59340,87.67724218; 59370,86.57017422; 59400,85.70889788; 59430,85.70889788; 59460,86.55951977; 59490,
            87.39214869; 59520,87.39214869; 59550,87.39214869; 59580,88.16266108; 59610,89.01476698; 59640,89.59966908; 59670,89.59966908; 59700,
            91.16883574; 59730,93.97626686; 59760,95.76469231; 59790,95.76469231; 59820,95.76469231; 59850,96.42070198; 59880,96.42070198; 59910,
            96.42070198; 59940,96.42070198; 59970,96.42070198; 60000,96.2860754; 60030,96.2860754; 60060,96.2860754; 60090,95.67252045; 60120,
            95.67252045; 60150,95.67252045; 60180,95.67252045; 60210,95.67252045; 60240,95.60338612; 60270,95.60338612; 60300,95.60338612; 60330,
            96.09716549; 60360,96.09716549; 60390,96.09716549; 60420,96.09716549; 60450,96.09716549; 60480,95.78296795; 60510,95.78296795; 60540,
            95.78296795; 60570,95.78296795; 60600,95.78296795; 60630,95.96924686; 60660,95.96924686; 60690,95.96924686; 60720,95.96924686; 60750,
            95.96924686; 60780,96.13268394; 60810,96.13268394; 60840,96.13268394; 60870,96.13268394; 60900,96.13268394; 60930,96.12775898; 60960,
            96.12775898; 60990,96.12775898; 61020,96.12775898; 61050,96.20163345; 61080,96.20163345; 61110,96.20163345; 61140,96.20163345; 61170,
            96.20163345; 61200,96.55089283; 61230,96.55089283; 61260,96.55089283; 61290,96.55089283; 61320,96.55089283; 61350,95.89082794; 61380,
            95.89082794; 61410,95.89082794; 61440,95.89082794; 61470,95.89082794; 61500,95.94450245; 61530,95.94450245; 61560,96.44606609; 61590,
            96.44606609; 61620,96.44606609; 61650,96.44606609; 61680,96.44606609; 61710,96.27582321; 61740,96.27582321; 61770,96.27582321; 61800,
            96.27582321; 61830,96.27582321; 61860,96.0358263; 61890,96.0358263; 61920,96.0358263; 61950,96.0358263; 61980,96.0358263; 62010,
            95.97999916; 62040,95.97999916; 62070,95.97999916; 62100,95.97999916; 62130,95.97999916; 62160,95.52898979; 62190,95.52898979; 62220,
            95.52898979; 62250,95.52898979; 62280,95.52898979; 62310,95.47718525; 62340,95.47718525; 62370,95.47718525; 62400,95.47718525; 62430,
            95.47718525; 62460,95.4429388; 62490,95.4429388; 62520,95.4429388; 62550,95.4429388; 62580,95.4429388; 62610,95.87245445; 62640,
            95.87245445; 62670,95.87245445; 62700,95.87245445; 62730,95.87245445; 62760,96.2077652; 62790,96.2077652; 62820,96.2077652; 62850,
            96.2077652; 62880,96.2077652; 62910,96.47193031; 62940,96.47193031; 62970,95.85767956; 63000,95.85767956; 63030,96.4234417; 63060,
            96.4234417; 63090,96.4234417; 63120,96.4234417; 63150,96.4234417; 63180,96.53708553; 63210,96.53708553; 63240,96.53708553; 63270,
            95.97990131; 63300,95.97990131; 63330,95.97990131; 63360,96.56885319; 63390,96.56885319; 63420,96.56885319; 63450,96.56885319; 63480,
            96.56885319; 63510,96.45440483; 63540,96.45440483; 63570,96.45440483; 63600,96.45440483; 63630,96.45440483; 63660,95.81251774; 63690,
            96.87975655; 63720,96.26673431; 63750,96.26673431; 63780,96.26673431; 63810,96.26673431; 63840,96.26673431; 63870,96.75418625; 63900,
            96.75418625; 63930,96.75418625; 63960,96.75418625; 63990,96.75418625; 64020,96.33124809; 64050,96.33124809; 64080,96.33124809; 64110,
            96.33124809; 64140,96.33124809; 64170,94.85112762; 64200,93.4039381; 64230,92.69007912; 64260,92.69007912; 64290,92.69007912; 64320,
            92.0794487; 64350,90.65823212; 64380,90.65823212; 64410,90.65823212; 64440,91.30446796; 64470,91.30446796; 64500,90.42830801; 64530,
            90.42830801; 64560,89.77347794; 64590,89.77347794; 64620,89.77347794; 64650,87.5210186; 64680,85.37543535; 64710,84.1626709; 64740,
            83.28809824; 64770,82.2728651; 64800,79.22878017; 64830,77.31445284; 64860,76.64177113; 64890,76.10153074; 64920,76.10153074; 64950,
            75.44680395; 64980,74.49232292; 65010,73.98127356; 65040,75.00425835; 65070,75.93748484; 65100,75.93748484; 65130,75.93748484; 65160,
            75.93748484; 65190,75.93748484; 65220,75.709659; 65250,75.709659; 65280,74.70699921; 65310,74.2411932; 65340,73.66855459; 65370,
            73.66855459; 65400,73.66855459; 65430,72.44524441; 65460,71.65190105; 65490,71.65190105; 65520,71.65190105; 65550,72.786551; 65580,
            72.786551; 65610,72.786551; 65640,72.29506559; 65670,72.70078812; 65700,73.37560616; 65730,73.37560616; 65760,73.96313925; 65790,
            73.96313925; 65820,74.43716984; 65850,76.8034687; 65880,77.5544878; 65910,77.5544878; 65940,77.5544878; 65970,78.66097956; 66000,
            79.39130402; 66030,80.23348932; 66060,80.23348932; 66090,78.66101217; 66120,77.78660803; 66150,77.78660803; 66180,77.78660803; 66210,
            76.60369778; 66240,75.25953026; 66270,75.25953026; 66300,77.41723566; 66330,77.41723566; 66360,77.41723566; 66390,77.41723566; 66420,
            77.41723566; 66450,77.41723566; 66480,77.41723566; 66510,76.01457739; 66540,76.01457739; 66570,74.00381641; 66600,73.03797426; 66630,
            72.63617649; 66660,72.63617649; 66690,71.95662374; 66720,69.84208517; 66750,69.84208517; 66780,69.84208517; 66810,70.5203496; 66840,
            70.5203496; 66870,69.58148603; 66900,69.16313038; 66930,69.64089003; 66960,70.61740294; 66990,70.61740294; 67020,69.67314692; 67050,
            69.67314692; 67080,69.26120567; 67110,69.73978071; 67140,69.73978071; 67170,67.76533728; 67200,67.27669487; 67230,66.85493088; 67260,
            66.85493088; 67290,65.30022383; 67320,62.88650723; 67350,61.89761667; 67380,61.35481596; 67410,61.35481596; 67440,59.91040964; 67470,
            57.41564856; 67500,56.79463005; 67530,56.23316231; 67560,56.75382242; 67590,57.22336292; 67620,56.57420797; 67650,55.76692686; 67680,
            55.76692686; 67710,56.07625923; 67740,56.88760099; 67770,55.54465656; 67800,54.64053411; 67830,54.64053411; 67860,55.13110628; 67890,
            55.56467171; 67920,54.443155; 67950,53.48968506; 67980,53.11069107; 68010,53.11069107; 68040,53.40803719; 68070,52.32809458; 68100,
            51.16868935; 68130,50.76912031; 68160,51.3247879; 68190,52.17930193; 68220,51.88572836; 68250,51.12508221; 68280,50.81469526; 68310,
            51.69981909; 68340,52.86166506; 68370,52.86166506; 68400,52.28755875; 68430,51.74333925; 68460,52.8372468; 68490,54.43083172; 68520,
            54.43083172; 68550,53.41079865; 68580,52.40301819; 68610,52.40301819; 68640,52.40301819; 68670,51.04757652; 68700,49.0617013; 68730,
            47.47755318; 68760,47.47755318; 68790,47.47755318; 68820,47.08905172; 68850,46.06250095; 68880,45.37722144; 68910,46.12065468; 68940,
            47.4625989; 68970,47.4625989; 69000,47.08183823; 69030,46.61430359; 69060,47.24700937; 69090,48.64980898; 69120,48.98536434; 69150,
            48.98536434; 69180,47.8900815; 69210,48.91226177; 69240,50.06006126; 69270,50.63023739; 69300,49.84845629; 69330,48.97018719; 69360,
            49.6776372; 69390,50.65039387; 69420,50.65039387; 69450,49.20450897; 69480,48.62358055; 69510,48.90562449; 69540,50.04933071; 69570,
            50.40485229; 69600,49.59914217; 69630,48.772645; 69660,49.2577486; 69690,50.65841188; 69720,51.87295389; 69750,51.87295389; 69780,
            51.32773418; 69810,52.31922855; 69840,53.69945269; 69870,55.18962421; 69900,54.52520514; 69930,54.10506649; 69960,54.10506649; 69990,
            54.9843956; 70020,56.28661394; 70050,55.72049847; 70080,54.91105928; 70110,54.91105928; 70140,56.06395226; 70170,57.1924161; 70200,
            57.1924161; 70230,56.54273386; 70260,56.14468145; 70290,56.53619442; 70320,57.59975853; 70350,57.59975853; 70380,57.0650465; 70410,
            57.0650465; 70440,59.03162956; 70470,61.11512346; 70500,61.82837362; 70530,62.88030481; 70560,64.02020044; 70590,66.54458199; 70620,
            68.70389643; 70650,68.70389643; 70680,68.70389643; 70710,68.13183403; 70740,68.13183403; 70770,68.93782139; 70800,68.93782139; 70830,
            67.19391088; 70860,66.24032679; 70890,66.24032679; 70920,67.00460958; 70950,67.00460958; 70980,66.56478739; 71010,66.15272655; 71040,
            66.57125072; 71070,67.58290701; 71100,68.00046902; 71130,68.00046902; 71160,67.65469952; 71190,68.1845355; 71220,69.4123847; 71250,
            70.30006886; 71280,69.30276346; 71310,67.97381115; 71340,67.97381115; 71370,69.28548803; 71400,69.28548803; 71430,68.32517967; 71460,
            67.3482482; 71490,67.3482482; 71520,67.88173714; 71550,68.37114601; 71580,67.29187202; 71610,65.56722651; 71640,64.91284218; 71670,
            64.91284218; 71700,64.91284218; 71730,63.54490328; 71760,61.92518234; 71790,61.41489944; 71820,61.41489944; 71850,61.41489944; 71880,
            60.68984785; 71910,60.68984785; 71940,60.68984785; 71970,61.59954214; 72000,62.89126911; 72030,62.89126911; 72060,61.14531469; 72090,
            60.32054615; 72120,60.32054615; 72150,60.84226084; 72180,60.39948692; 72210,58.6223628; 72240,57.5842824; 72270,58.30432749; 72300,
            59.1577054; 72330,59.1577054; 72360,57.83732557; 72390,56.08292913; 72420,56.50878639; 72450,57.56006527; 72480,57.56006527; 72510,
            56.89360771; 72540,55.59877138; 72570,55.59877138; 72600,55.98542461; 72630,55.98542461; 72660,54.69175158; 72690,53.0159317; 72720,
            53.0159317; 72750,54.20331573; 72780,54.50442352; 72810,53.19056139; 72840,51.95067701; 72870,51.95067701; 72900,53.32348108; 72930,
            45.29904985; 72960,41.99735012; 72990,40.48362193; 73020,41.00060463; 73050,43.8005559; 73080,45.70728378; 73110,46.65857391; 73140,
            48.16467276; 73170,49.72854481; 73200,52.2048563; 73230,53.51516333; 73260,53.21080484; 73290,51.89734497; 73320,50.99396181; 73350,
            50.59122906; 73380,51.23199091; 73410,49.40332317; 73440,47.80383482; 73470,46.56284695; 73500,46.30574856; 73530,47.75516682; 73560,
            47.75516682; 73590,47.23961105; 73620,46.70437717; 73650,47.95599232; 73680,49.48031788; 73710,49.48031788; 73740,50.08610487; 73770,
            50.08610487; 73800,51.13543224; 73830,53.41726742; 73860,53.7510561; 73890,53.7510561; 73920,53.7510561; 73950,54.87269239; 73980,
            56.689575; 74010,57.60005207; 74040,57.60005207; 74070,55.60610447; 74100,55.08329172; 74130,55.61149149; 74160,55.61149149; 74190,
            55.61149149; 74220,53.77207146; 74250,53.77207146; 74280,54.58088551; 74310,55.46338377; 74340,55.46338377; 74370,55.46338377; 74400,
            55.46338377; 74430,57.36764374; 74460,59.80711584; 74490,60.16846476; 74520,58.86322947; 74550,57.84472933; 74580,57.84472933; 74610,
            57.84472933; 74640,57.84472933; 74670,56.58152475; 74700,55.33232317; 74730,54.74595337; 74760,55.2081336; 74790,55.63772535; 74820,
            55.305861; 74850,54.32200956; 74880,53.98244247; 74910,54.9086566; 74940,55.30064249; 74970,55.30064249; 75000,55.30064249; 75030,
            54.73167315; 75060,55.55150585; 75090,56.25993977; 75120,56.25993977; 75150,56.25993977; 75180,56.25993977; 75210,57.04153605; 75240,
            57.85547619; 75270,57.85547619; 75300,56.48739052; 75330,54.48583803; 75360,53.27960215; 75390,52.82069435; 75420,51.21494923; 75450,
            48.66336622; 75480,46.92568531; 75510,46.54140215; 75540,47.59289303; 75570,48.29121609; 75600,48.29121609; 75630,48.29121609; 75660,
            48.99075136; 75690,50.71177654; 75720,52.08210726; 75750,52.08210726; 75780,52.08210726; 75810,52.08210726; 75840,52.96111021; 75870,
            53.39058781; 75900,52.62854462; 75930,51.66153374; 75960,49.95576181; 75990,49.95576181; 76020,49.6252347; 76050,48.98672876; 76080,
            47.72857962; 76110,46.50002375; 76140,46.50002375; 76170,47.24598742; 76200,47.24598742; 76230,47.24598742; 76260,46.59293489; 76290,
            46.59293489; 76320,47.77940569; 76350,47.77940569; 76380,47.47641706; 76410,45.93169584; 76440,45.53641577; 76470,45.53641577; 76500,
            45.53641577; 76530,44.67682185; 76560,43.3057138; 76590,42.59405093; 76620,42.59405093; 76650,42.59405093; 76680,40.79292712; 76710,
            39.25498452; 76740,38.14697886; 76770,37.75362039; 76800,38.08647408; 76830,37.54728556; 76860,36.27030358; 76890,35.28769426; 76920,
            35.28769426; 76950,35.28769426; 76980,35.09748244; 77010,34.19350677; 77040,32.9727406; 77070,32.43120375; 77100,32.43120375; 77130,
            32.17283335; 77160,31.63088608; 77190,29.95238085; 77220,29.47437387; 77250,30.3412003; 77280,30.56646581; 77310,30.56646581; 77340,
            29.87263284; 77370,29.61010394; 77400,30.02729359; 77430,30.93957267; 77460,31.2134192; 77490,30.07673893; 77520,29.67254663; 77550,
            30.24966989; 77580,31.58210392; 77610,31.86067972; 77640,31.18890038; 77670,31.18890038; 77700,32.0578115; 77730,33.57110481; 77760,
            34.57432723; 77790,34.57432723; 77820,34.98436861; 77850,35.75830564; 77880,37.78371105; 77910,38.21747217; 77940,37.59948964; 77970,
            36.52654581; 78000,36.28468981; 78030,36.76484942; 78060,37.47471571; 78090,36.26299496; 78120,35.20934873; 78150,34.68648705; 78180,
            35.16654611; 78210,36.23744602; 78240,36.04960699; 78270,34.66277819; 78300,33.67522216; 78330,34.43404727; 78360,35.36753197; 78390,
            35.36753197; 78420,35.36753197; 78450,34.83521719; 78480,35.62022181; 78510,37.15555787; 78540,38.31691461; 78570,37.756178; 78600,
            36.8320703; 78630,36.8320703; 78660,37.58894391; 78690,38.70974035; 78720,38.92372899; 78750,38.48004456; 78780,38.48004456; 78810,
            38.75940042; 78840,40.17740436; 78870,40.17740436; 78900,38.65585928; 78930,38.45384059; 78960,38.45384059; 78990,39.63792229; 79020,
            39.85705061; 79050,39.53793626; 79080,39.17761202; 79110,39.77758799; 79140,41.79645667; 79170,42.22269444; 79200,42.22269444; 79230,
            40.85667443; 79260,40.43919396; 79290,42.73326273; 79320,42.73326273; 79350,41.92311416; 79380,40.31540666; 79410,39.97400765; 79440,
            39.97400765; 79470,39.97400765; 79500,39.97400765; 79530,38.57495613; 79560,38.00620694; 79590,38.32393241; 79620,39.76411228; 79650,
            39.76411228; 79680,38.96064992; 79710,38.96064992; 79740,39.74695101; 79770,41.2720376; 79800,41.80803523; 79830,40.7319603; 79860,
            40.15869384; 79890,40.15869384; 79920,42.47220969; 79950,43.18088279; 79980,41.99757571; 80010,41.46288271; 80040,41.46288271; 80070,
            41.92264123; 80100,42.72604923; 80130,42.47343822; 80160,41.38296347; 80190,40.5548192; 80220,40.5548192; 80250,41.11849937; 80280,
            40.36160674; 80310,39.24028029; 80340,38.71956582; 80370,39.02651453; 80400,40.26672778; 80430,40.26672778; 80460,39.82410336; 80490,
            38.49560494; 80520,38.90587192; 80550,40.21103382; 80580,40.21103382; 80610,38.89993315; 80640,37.1401062; 80670,36.85420275; 80700,
            36.85420275; 80730,36.09418445; 80760,34.10597448; 80790,32.09054132; 80820,31.47531481; 80850,31.47531481; 80880,31.47531481; 80910,
            30.68727694; 80940,29.63161941; 80970,29.63161941; 81000,29.9785522; 81030,31.35503097; 81060,31.35503097; 81090,31.13745189; 81120,
            30.62808223; 81150,30.62808223; 81180,31.89877481; 81210,31.89877481; 81240,30.87420816; 81270,30.35498314; 81300,30.0296093; 81330,
            30.74845033; 81360,31.05530119; 81390,31.05530119; 81420,30.58507304; 81450,30.58507304; 81480,32.4227726; 81510,33.40388703; 81540,
            33.80921273; 81570,33.80921273; 81600,35.34170852; 81630,37.60337634; 81660,39.48148398; 81690,39.81124735; 81720,39.81124735; 81750,
            39.81124735; 81780,41.47517338; 81810,42.93885012; 81840,43.18648453; 81870,41.65751667; 81900,40.10068688; 81930,40.10068688; 81960,
            40.10068688; 81990,40.10068688; 82020,39.06178293; 82050,37.36513252; 82080,36.56355915; 82110,36.56355915; 82140,37.91309738; 82170,
            37.91309738; 82200,37.39904194; 82230,37.11047215; 82260,37.5650013; 82290,38.94098268; 82320,38.94098268; 82350,38.94098268; 82380,
            38.28245072; 82410,38.28245072; 82440,39.89706731; 82470,39.89706731; 82500,39.08803582; 82530,38.58950272; 82560,38.58950272; 82590,
            40.27569165; 82620,40.60162268; 82650,40.60162268; 82680,40.60162268; 82710,41.0624249; 82740,42.26270299; 82770,42.76938729; 82800,
            41.69867492; 82830,40.41900759; 82860,39.46411343; 82890,39.46411343; 82920,39.88576055; 82950,39.56234908; 82980,38.47453794; 83010,
            37.96512208; 83040,39.46138186; 83070,40.72831278; 83100,41.28319488; 83130,41.28319488; 83160,41.84405379; 83190,43.60976787; 83220,
            44.99972506; 83250,45.3671432; 83280,44.67734914; 83310,43.51355166; 83340,43.05458951; 83370,43.28043938; 83400,43.50153279; 83430,
            41.97273073; 83460,40.10473394; 83490,39.88966355; 83520,39.88966355; 83550,39.88966355; 83580,38.80915289; 83610,37.12769051; 83640,
            36.85656195; 83670,36.85656195; 83700,37.76378832; 83730,37.76378832; 83760,37.76378832; 83790,37.76378832; 83820,38.86901622; 83850,
            39.95429964; 83880,40.25841079; 83910,39.2611815; 83940,38.7105041; 83970,38.7105041; 84000,40.39006391; 84030,40.74037786; 84060,
            39.39166045; 84090,38.50177474; 84120,38.50177474; 84150,39.59315457; 84180,40.45864649; 84210,40.45864649; 84240,40.45864649; 84270,
            40.91749449; 84300,42.66686268; 84330,44.2564549; 84360,44.2564549; 84390,43.79575596; 84420,43.28215985; 84450,44.13821225; 84480,
            44.68004537; 84510,44.68004537; 84540,44.15528111; 84570,43.7347538; 84600,44.79230847; 84630,46.07937412; 84660,46.07937412; 84690,
            45.75425577; 84720,44.76306853; 84750,44.51958175; 84780,45.03136225; 84810,45.03136225; 84840,44.2425416; 84870,42.84047041; 84900,
            42.58643246; 84930,43.4123208; 84960,43.95237093; 84990,43.95237093; 85020,42.31179771; 85050,42.31179771; 85080,43.42477455; 85110,
            44.06893659; 85140,44.06893659; 85170,43.81756496; 85200,43.81756496; 85230,44.67037482; 85260,45.50581412; 85290,45.80011883; 85320,
            45.23019547; 85350,45.23019547; 85380,46.86540613; 85410,48.04516354; 85440,48.32296743; 85470,47.54648638; 85500,46.26490288; 85530,
            46.26490288; 85560,46.26490288; 85590,46.26490288; 85620,44.14521918; 85650,43.28379064; 85680,42.79515367; 85710,42.79515367; 85740,
            43.17243805; 85770,42.348773; 85800,41.78349466; 85830,41.09069452; 85860,42.05586534; 85890,43.30917377; 85920,43.00719352; 85950,
            43.00719352; 85980,42.72119222; 86010,44.64907408; 86040,46.54596834; 86070,46.54596834; 86100,46.94846191; 86130,46.70325737; 86160,
            46.94327602; 86190,48.72751579; 86220,48.72751579; 86250,48.72751579; 86280,47.73531475; 86310,47.73531475; 86340,48.82256327; 86370,
            48.82256327; 86400,48.20220251; 86430,46.72663736; 86460,46.24312105; 86490,47.47978735; 86520,47.77940569; 86550,47.77940569; 86580,
            47.1414814; 86610,46.8296648; 86640,48.86743155; 86670,49.79615707; 86700,50.59220753; 86730,50.59220753; 86760,50.28699017; 86790,
            51.08101845; 86820,52.05702038; 86850,52.7322298; 86880,52.35762262; 86910,51.81048403; 86940,52.27964945; 86970,53.7883358; 87000,
            55.13379164; 87030,55.13379164; 87060,55.4170804; 87090,56.53555298; 87120,59.14128885; 87150,60.57567673; 87180,60.57567673; 87210,
            60.57567673; 87240,59.65960064; 87270,59.65960064; 87300,59.65960064; 87330,58.76072388; 87360,57.28436508; 87390,55.97272625; 87420,
            55.45906219; 87450,56.79421692; 87480,56.79421692; 87510,56.79421692; 87540,56.79421692; 87570,56.79421692; 87600,58.24578238; 87630,
            58.6899642; 87660,58.6899642; 87690,58.6899642; 87720,58.6899642; 87750,59.59723949; 87780,59.94538994; 87810,59.94538994; 87840,
            58.53723593; 87870,58.53723593; 87900,59.18544502; 87930,59.9232276; 87960,59.9232276; 87990,59.9232276; 88020,59.4467454; 88050,
            60.19288301; 88080,60.68962498; 88110,60.68962498; 88140,59.77689743; 88170,59.25762348; 88200,59.91412239; 88230,60.9311059; 88260,
            61.42863607; 88290,60.50734148; 88320,59.39939833; 88350,59.39939833; 88380,59.05840158; 88410,58.36314983; 88440,56.1852499; 88470,
            55.08424301; 88500,55.08424301; 88530,55.08424301; 88560,55.63494759; 88590,54.78078146; 88620,54.01353607; 88650,54.01353607; 88680,
            54.3531249; 88710,55.8244174; 88740,55.8244174; 88770,55.8244174; 88800,55.8244174; 88830,56.34991007; 88860,57.48246174; 88890,
            57.86650572; 88920,56.60182257; 88950,55.48426323; 88980,54.70707006; 89010,55.09899073; 89040,54.71127205; 89070,52.86905251; 89100,
            50.52206755; 89130,50.19623165; 89160,51.12838726; 89190,51.12838726; 89220,50.403901; 89250,49.23565149; 89280,49.23565149; 89310,
            50.42156782; 89340,50.88694983; 89370,50.88694983; 89400,49.80525141; 89430,49.274475; 89460,49.274475; 89490,49.65201216; 89520,
            48.76065874; 89550,46.78899851; 89580,45.34687529; 89610,45.34687529; 89640,45.34687529; 89670,44.5289968; 89700,42.62450581; 89730,
            41.7410943; 89760,41.52728505; 89790,43.41859932; 89820,43.41859932; 89850,43.19098277; 89880,42.59962006; 89910,42.59962006; 89940,
            44.59267073; 89970,45.68796988; 90000,46.02002449; 90030,46.02002449; 90060,46.02002449; 90090,46.44465866; 90120,46.93036566; 90150,
            45.9048749; 90180,44.87335024; 90210,44.40105371; 90240,44.76500101; 90270,45.70259256; 90300,45.70259256; 90330,45.42832203; 90360,
            45.42832203; 90390,46.94079723; 90420,48.89677477; 90450,49.67475071; 90480,49.67475071; 90510,49.67475071; 90540,50.35144958; 90570,
            50.91331415; 90600,51.31442156; 90630,50.42090464; 90660,48.70558176; 90690,48.70558176; 90720,49.54557638; 90750,50.34827499; 90780,
            50.34827499; 90810,49.98208265; 90840,50.46086426; 90870,52.75932255; 90900,54.70609159; 90930,54.70609159; 90960,54.24510727; 90990,
            53.63992367; 91020,53.63992367; 91050,54.52871132; 91080,54.14076977; 91110,53.38926687; 91140,53.38926687; 91170,53.38926687; 91200,
            54.9655057; 91230,55.45824137; 91260,55.45824137; 91290,55.45824137; 91320,57.03495312; 91350,59.7489295; 91380,60.78678703; 91410,
            60.78678703; 91440,59.92533674; 91470,59.92533674; 91500,60.45018797; 91530,61.15885563; 91560,61.15885563; 91590,60.72751894; 91620,
            60.10009146; 91650,60.71790819; 91680,62.18256884; 91710,62.80066824; 91740,62.80066824; 91770,64.03828039; 91800,66.73460083; 91830,
            68.58259878; 91860,68.58259878; 91890,67.91592379; 91920,66.6415864; 91950,66.6415864; 91980,66.6415864; 92010,65.54784737; 92040,
            63.56947918; 92070,61.51438808; 92100,61.51438808; 92130,61.51438808; 92160,62.01749554; 92190,62.01749554; 92220,61.57088928; 92250,
            61.57088928; 92280,62.6586216; 92310,63.56768532; 92340,63.24891071; 92370,61.98725538; 92400,60.85332842; 92430,60.85332842; 92460,
            60.85332842; 92490,60.19062166; 92520,59.27808981; 92550,58.36114397; 92580,58.36114397; 92610,59.05109024; 92640,59.05109024; 92670,
            59.05109024; 92700,58.51367111; 92730,59.17148008; 92760,61.09495068; 92790,61.09495068; 92820,60.57772064; 92850,59.31457586; 92880,
            58.6262332; 92910,58.6262332; 92940,58.6262332; 92970,57.64244699; 93000,55.49310751; 93030,55.10330687; 93060,55.10330687; 93090,
            55.73461561; 93120,55.33410072; 93150,53.67526817; 93180,53.04924316; 93210,53.04924316; 93240,54.49780798; 93270,54.49780798; 93300,
            53.79966974; 93330,53.79966974; 93360,54.07131472; 93390,55.8468461; 93420,56.33436327; 93450,55.03815165; 93480,54.04331417; 93510,
            53.22504702; 93540,53.22504702; 93570,52.60642033; 93600,49.75428944; 93630,47.66184797; 93660,46.02061701; 93690,45.60136986; 93720,
            45.14393792; 93750,44.09002805; 93780,42.53451376; 93810,42.18076973; 93840,43.24388809; 93870,44.14251752; 93900,44.14251752; 93930,
            44.14251752; 93960,44.14251752; 93990,45.55673532; 94020,47.30675583; 94050,47.58939772; 94080,47.58939772; 94110,46.82363634; 94140,
            47.56795292; 94170,48.64250307; 94200,48.64250307; 94230,48.39181366; 94260,47.20585384; 94290,47.20585384; 94320,48.40218544; 94350,
            48.40218544; 94380,48.40218544; 94410,48.69026871; 94440,50.11986752; 94470,52.725212; 94500,54.38313131; 94530,54.38313131; 94560,
            53.9039257; 94590,53.40113897; 94620,53.40113897; 94650,53.68861885; 94680,53.35369406; 94710,50.7177289; 94740,49.76357946; 94770,
            49.45589418; 94800,50.21533356; 94830,50.21533356; 94860,49.14544744; 94890,48.76275702; 94920,48.76275702; 94950,49.99095955; 94980,
            49.99095955; 95010,48.98794641; 95040,47.67697077; 95070,47.31121874; 95100,47.73447762; 95130,47.73447762; 95160,46.78899851; 95190,
            46.30341654; 95220,46.30341654; 95250,47.56970329; 95280,48.8716444; 95310,49.11897984; 95340,49.39611511; 95370,50.13956194; 95400,
            52.77162952; 95430,54.42996197; 95460,54.7151968; 95490,54.31693239; 95520,52.92093315; 95550,52.60069084; 95580,52.60069084; 95610,
            52.109624; 95640,50.46856155; 95670,49.11464739; 95700,49.11464739; 95730,50.62453508; 95760,51.10442562; 95790,51.10442562; 95820,
            51.10442562; 95850,51.74221945; 95880,52.58789463; 95910,53.15463524; 95940,52.44841919; 95970,50.59266958; 96000,50.59266958; 96030,
            50.24826994; 96060,50.57649765; 96090,50.22637396; 96120,49.6825078; 96150,49.6825078; 96180,50.52417126; 96210,52.51049223; 96240,
            52.51049223; 96270,52.77323313; 96300,52.77323313; 96330,53.2759655; 96360,55.56855841; 96390,56.22539978; 96420,56.22539978; 96450,
            56.22539978; 96480,56.62370768; 96510,58.30067453; 96540,59.05318851; 96570,58.64579172; 96600,56.71694498; 96630,55.97198696; 96660,
            55.97198696; 96690,56.77658272; 96720,56.24804049; 96750,54.57927103; 96780,54.22346678; 96810,55.33355169; 96840,56.86575394; 96870,
            56.86575394; 96900,57.29485645; 96930,57.29485645; 96960,58.43789406; 96990,59.30419321; 97020,59.30419321; 97050,58.36097546; 97080,
            57.03656759; 97110,57.03656759; 97140,57.03656759; 97170,57.03656759; 97200,55.59111214; 97230,54.1308383; 97260,53.6599823; 97290,
            53.6599823; 97320,53.6599823; 97350,53.6599823; 97380,53.0525156; 97410,53.0525156; 97440,53.73312836; 97470,55.31201992; 97500,
            55.31201992; 97530,55.31201992; 97560,55.78692026; 97590,57.56665907; 97620,59.36925602; 97650,59.36925602; 97680,58.4982439; 97710,
            56.97342367; 97740,56.97342367; 97770,56.97342367; 97800,56.97342367; 97830,55.03740692; 97860,52.86261091; 97890,52.27574644; 97920,
            52.27574644; 97950,52.27574644; 97980,51.49974375; 98010,49.80906744; 98040,49.80906744; 98070,50.43685913; 98100,51.03159485; 98130,
            51.03159485; 98160,50.47036085; 98190,50.47036085; 98220,50.47036085; 98250,51.62096529; 98280,51.62096529; 98310,50.63806515; 98340,
            50.63806515; 98370,51.0142705; 98400,52.25136623; 98430,52.25136623; 98460,51.69529638; 98490,51.10289812; 98520,51.40205441; 98550,
            51.73024406; 98580,51.09863091; 98610,50.04016571; 98640,50.04016571; 98670,50.04016571; 98700,50.59082136; 98730,49.92344513; 98760,
            48.84518223; 98790,46.89709225; 98820,46.54618034; 98850,48.57490168; 98880,48.57490168; 98910,48.96726809; 98940,48.96726809; 98970,
            48.96726809; 99000,50.69389772; 99030,51.72548761; 99060,52.20564451; 99090,51.02036963; 99120,50.43102093; 99150,50.43102093; 99180,
            50.43102093; 99210,50.43102093; 99240,50.14456844; 99270,49.60256681; 99300,50.08613205; 99330,51.61694269; 99360,51.61694269; 99390,
            51.13720436; 99420,50.47665567; 99450,50.22032375; 99480,50.22032375; 99510,49.45938406; 99540,47.39386683; 99570,45.96251764; 99600,
            45.39997087; 99630,45.39997087; 99660,45.73256092; 99690,44.67406311; 99720,43.69655271; 99750,43.30384655; 99780,45.56038013; 99810,
            45.56038013; 99840,44.7233644; 99870,42.65705624; 99900,41.64428015; 99930,42.24147019; 99960,43.17873287; 99990,43.17873287; 100020,
            41.90859747; 100050,41.06218572; 100080,41.64467425; 100110,42.9536386; 100140,43.36418281; 100170,43.36418281; 100200,42.47515054;
            100230,43.29194183; 100260,45.16967168; 100290,46.16848555; 100320,46.16848555; 100350,46.16848555; 100380,47.0467927; 100410,
            48.62896214; 100440,49.39091835; 100470,49.39091835; 100500,49.39091835; 100530,49.39091835; 100560,50.94858255; 100590,51.97510614;
            100620,51.97510614; 100650,51.97510614; 100680,51.23228989; 100710,51.70355358; 100740,52.08214531; 100770,50.89227705; 100800,
            49.14159336; 100830,47.78800535; 100860,48.45132637; 100890,49.16365242; 100920,49.16365242; 100950,48.63727913; 100980,47.83930435;
            101010,49.5568614; 101040,51.86950207; 101070,52.26625528; 101100,52.26625528; 101130,51.17159214; 101160,51.4477272; 101190,
            52.85878401; 101220,53.71648893; 101250,53.71648893; 101280,52.46450958; 101310,52.46450958; 101340,52.46450958; 101370,52.99082851;
            101400,52.99082851; 101430,51.91425619; 101460,51.91425619; 101490,52.52096729; 101520,54.23197947; 101550,54.23197947; 101580,
            54.23197947; 101610,55.05120335; 101640,56.32121372; 101670,58.35975237; 101700,58.35975237; 101730,57.22112875; 101760,57.22112875;
            101790,57.22112875; 101820,58.31311197; 101850,58.31311197; 101880,57.4696003; 101910,56.80886135; 101940,57.35463009; 101970,
            59.91889515; 102000,60.93282366; 102030,60.93282366; 102060,60.93282366; 102090,61.32320595; 102120,62.48327436; 102150,63.36887655;
            102180,63.36887655; 102210,61.28953571; 102240,61.28953571; 102270,61.28953571; 102300,61.95886345; 102330,61.95886345; 102360,
            60.31534939; 102390,59.59388552; 102420,60.1954977; 102450,61.83905525; 102480,61.83905525; 102510,61.83905525; 102540,61.08711748;
            102570,61.08711748; 102600,61.43545818; 102630,61.43545818; 102660,60.80318184; 102690,60.06671476; 102720,60.06671476; 102750,
            60.06671476; 102780,60.06671476; 102810,58.55947981; 102840,57.42637367; 102870,57.13550177; 102900,58.38124065; 102930,59.03989763;
            102960,58.68315296; 102990,57.38644667; 103020,56.85091925; 103050,57.84136992; 103080,58.35985565; 103110,57.87685575; 103140,
            56.40531321; 103170,55.35519218; 103200,55.35519218; 103230,55.99155636; 103260,55.99155636; 103290,54.38870859; 103320,53.10683155;
            103350,52.81838951; 103380,53.55220385; 103410,53.96858082; 103440,53.96858082; 103470,53.27522078; 103500,53.86559143; 103530,
            55.59093275; 103560,56.79457026; 103590,56.79457026; 103620,56.47688828; 103650,56.47688828; 103680,57.08165331; 103710,57.71649542;
            103740,57.23891516; 103770,55.82169943; 103800,55.82169943; 103830,55.82169943; 103860,56.80674677; 103890,56.80674677; 103920,
            56.80674677; 103950,56.80674677; 103980,58.77627068; 104010,59.94195986; 104040,59.51371078; 104070,57.91890821; 104100,57.45184107;
            104130,57.45184107; 104160,58.27797403; 104190,57.82663307; 104220,57.35389624; 104250,56.47933445; 104280,58.346418; 104310,
            61.50729418; 104340,62.38736258; 104370,63.24873676; 104400,64.21880264; 104430,66.76413975; 104460,69.50533934; 104490,70.6572484;
            104520,69.8444335; 104550,67.50722237; 104580,66.15556412; 104610,66.15556412; 104640,65.04911585; 104670,63.72176714; 104700,
            61.37566824; 104730,61.02267437; 104760,61.60739164; 104790,62.13216677; 104820,62.65016327; 104850,62.65016327; 104880,63.2276453;
            104910,65.08872757; 104940,66.11765385; 104970,66.11765385; 105000,64.57536793; 105030,63.9814476; 105060,63.9814476; 105090,
            64.7468339; 105120,64.7468339; 105150,63.02945623; 105180,61.9396637; 105210,61.9396637; 105240,63.44957857; 105270,63.44957857;
            105300,62.56772718; 105330,61.59592724; 105360,61.59592724; 105390,61.59592724; 105420,61.98867416; 105450,61.53179398; 105480,
            60.35581455; 105510,59.86472054; 105540,60.17039995; 105570,60.17039995; 105600,59.70557241; 105630,58.03691711; 105660,57.73724442;
            105690,57.73724442; 105720,58.58419161; 105750,58.21956482; 105780,57.16656818; 105810,57.16656818; 105840,58.46076851; 105870,
            59.6275938; 105900,59.98970919; 105930,59.20980349; 105960,59.20980349; 105990,60.89526129; 106020,63.1272706; 106050,63.1272706;
            106080,63.1272706; 106110,63.1272706; 106140,63.9615901; 106170,66.39477825; 106200,66.39477825; 106230,65.42743034; 106260,
            64.76809387; 106290,64.76809387; 106320,66.36839762; 106350,66.36839762; 106380,66.36839762; 106410,65.02636099; 106440,65.02636099;
            106470,66.40204611; 106500,66.40204611; 106530,65.51013823; 106560,64.46658382; 106590,63.78849335; 106620,64.51385479; 106650,
            64.51385479; 106680,64.84868174; 106710,64.2023263; 106740,64.2023263; 106770,65.45830107; 106800,66.12855291; 106830,66.12855291;
            106860,65.08112812; 106890,64.54412212; 106920,64.54412212; 106950,65.61768837; 106980,65.61768837; 107010,64.18755684; 107040,
            63.70146389; 107070,64.43806686; 107100,65.79985228; 107130,66.1753727; 107160,65.03755903; 107190,65.03755903; 107220,65.03755903;
            107250,66.81529741; 107280,67.33633804; 107310,66.86069841; 107340,66.38685265; 107370,66.38685265; 107400,67.64118576; 107430,
            68.03147564; 107460,68.03147564; 107490,68.03147564; 107520,68.50731096; 107550,69.45300207; 107580,70.49648581; 107610,69.48253555;
            107640,68.16319399; 107670,68.16319399; 107700,68.16319399; 107730,68.97052946; 107760,68.31379137; 107790,66.76141634; 107820,
            66.15024776; 107850,66.83444281; 107880,67.37670536; 107910,67.37670536; 107940,66.65974245; 107970,66.65974245; 108000,67.99906111;
            108030,69.15114956; 108060,69.15114956; 108090,69.15114956; 108120,68.75074883; 108150,69.10042677; 108180,70.37740059; 108210,
            70.37740059; 108240,69.44382076; 108270,68.66051216; 108300,70.07684727; 108330,71.5866643; 108360,72.30435019; 108390,72.30435019;
            108420,72.30435019; 108450,73.44445782; 108480,75.14037437; 108510,76.33167229; 108540,76.33167229; 108570,75.91412659; 108600,
            75.91412659; 108630,77.23000546; 108660,77.23000546; 108690,76.29879026; 108720,75.22311487; 108750,75.22311487; 108780,76.2076458;
            108810,77.13581686; 108840,77.13581686; 108870,76.42884521; 108900,76.42884521; 108930,78.0858676; 108960,79.14059286; 108990,
            79.14059286; 109020,79.14059286; 109050,79.14059286; 109080,79.14059286; 109110,80.603514; 109140,80.603514; 109170,79.6492341;
            109200,79.6492341; 109230,79.6492341; 109260,80.56517973; 109290,79.95197268; 109320,78.68171225; 109350,78.68171225; 109380,
            79.12785101; 109410,80.17143259; 109440,80.17143259; 109470,79.07719345; 109500,78.57959805; 109530,78.57959805; 109560,79.37917643;
            109590,79.37917643; 109620,78.09486952; 109650,77.32376461; 109680,77.32376461; 109710,78.06941843; 109740,78.06941843; 109770,
            76.76637926; 109800,75.9367238; 109830,75.35789909; 109860,75.78371286; 109890,75.78371286; 109920,73.10658131; 109950,71.39487333;
            109980,70.67050123; 110010,70.67050123; 110040,70.67050123; 110070,68.43763847; 110100,67.25517941; 110130,66.70387688; 110160,
            67.15251074; 110190,67.15251074; 110220,66.42461615; 110250,64.24130201; 110280,62.9786356; 110310,63.5747303; 110340,63.9309803;
            110370,63.17584076; 110400,61.66851339; 110430,61.25143518; 110460,61.89166431; 110490,62.55216951; 110520,62.10617208; 110550,
            60.63337383; 110580,59.92076511; 110610,60.66220064; 110640,61.26747665; 110670,61.26747665; 110700,60.7503336; 110730,60.7503336;
            110760,61.68522892; 110790,63.94147167; 110820,64.51233816; 110850,64.51233816; 110880,65.87204161; 110910,67.92353954; 110940,
            68.97657423; 110970,68.97657423; 111000,67.93664017; 111030,67.05794163; 111060,67.05794163; 111090,67.71703348; 111120,67.71703348;
            111150,66.5392765; 111180,65.80584269; 111210,65.80584269; 111240,67.45541782; 111270,68.17637615; 111300,68.17637615; 111330,
            67.54202871; 111360,68.36720495; 111390,70.2317771; 111420,71.45738668; 111450,71.45738668; 111480,71.45738668; 111510,71.45738668;
            111540,72.31709204; 111570,73.40136166; 111600,73.40136166; 111630,72.91475773; 111660,72.91475773; 111690,74.70950518; 111720,
            76.59282589; 111750,76.19736099; 111780,75.07357206; 111810,75.07357206; 111840,75.07357206; 111870,77.13179426; 111900,77.56163607;
            111930,77.56163607; 111960,78.26031246; 111990,79.46010132; 112020,80.84663115; 112050,80.84663115; 112080,79.48698206; 112110,
            78.5030056; 112140,78.5030056; 112170,78.5030056; 112200,78.5030056; 112230,76.16031504; 112260,74.8172945; 112290,74.8172945; 112320,
            74.8172945; 112350,75.72122669; 112380,75.00682955; 112410,73.48874989; 112440,73.48874989; 112470,73.48874989; 112500,74.36701899;
            112530,73.45646038; 112560,72.7434494; 112590,72.7434494; 112620,73.45548191; 112650,74.19118252; 112680,74.19118252; 112710,
            73.45102444; 112740,72.69953785; 112770,73.90377874; 112800,74.86628323; 112830,74.86628323; 112860,74.45020523; 112890,73.5713273;
            112920,73.5713273; 112950,74.16516609; 112980,74.58343477; 113010,74.12237434; 113040,73.68943949; 113070,73.68943949; 113100,
            75.13497105; 113130,75.13497105; 113160,74.49044752; 113190,74.49044752; 113220,74.49044752; 113250,75.40351753; 113280,75.40351753;
            113310,74.61441965; 113340,74.04879341; 113370,74.04879341; 113400,74.70262327; 113430,75.15899792; 113460,75.15899792; 113490,
            74.77808504; 113520,75.38806314; 113550,77.59673595; 113580,78.87923269; 113610,78.28612232; 113640,76.63277464; 113670,76.63277464;
            113700,76.63277464; 113730,76.63277464; 113760,76.04080582; 113790,76.54254885; 113820,75.80485325; 113850,76.60623093; 113880,
            78.13411703; 113910,78.13411703; 113940,78.13411703; 113970,78.13411703; 114000,80.68796682; 114030,82.39108601; 114060,82.39108601;
            114090,82.39108601; 114120,82.39108601; 114150,83.60372; 114180,84.49091492; 114210,83.99966326; 114240,82.30370865; 114270,
            82.30370865; 114300,82.30370865; 114330,84.21298599; 114360,84.21298599; 114390,83.59763718; 114420,82.59592323; 114450,82.59592323;
            114480,83.5183485; 114510,83.5183485; 114540,81.97153444; 114570,80.86664085; 114600,80.86664085; 114630,81.50752773; 114660,
            81.50752773; 114690,80.17539539; 114720,79.58198605; 114750,79.58198605; 114780,79.58198605; 114810,79.58198605; 114840,78.59363909;
            114870,77.57461166; 114900,77.57461166; 114930,78.86514816; 114960,79.88477354; 114990,79.3394125; 115020,78.69241562; 115050,
            78.27678881; 115080,78.27678881; 115110,79.10709658; 115140,78.50390797; 115170,77.74691477; 115200,77.74691477; 115230,77.74691477;
            115260,79.13397188; 115290,79.13397188; 115320,79.13397188; 115350,79.62499523; 115380,81.62031813; 115410,83.43249321; 115440,
            83.88240452; 115470,83.88240452; 115500,82.87477627; 115530,84.48964834; 115560,86.17791109; 115590,86.17791109; 115620,83.90605631;
            115650,83.1050374; 115680,83.1050374; 115710,83.1050374; 115740,81.89444189; 115770,79.0371686; 115800,77.46891518; 115830,
            77.46891518; 115860,78.71064234; 115890,78.71064234; 115920,76.91166029; 115950,75.6799407; 115980,75.29310265; 116010,76.44908323;
            116040,77.06709566; 116070,76.07337255; 116100,75.59391689; 116130,75.59391689; 116160,76.70203943; 116190,76.70203943; 116220,
            75.82004128; 116250,74.91222239; 116280,74.91222239; 116310,76.60508938; 116340,76.60508938; 116370,75.46179085; 116400,74.49421463;
            116430,74.49421463; 116460,75.52865295; 116490,76.57608318; 116520,76.05135155; 116550,74.96949549; 116580,74.96949549; 116610,
            74.96949549; 116640,76.03697891; 116670,75.64216633; 116700,74.56335983; 116730,74.56335983; 116760,75.16299334; 116790,76.98155565;
            116820,77.40210199; 116850,77.98324242; 116880,77.98324242; 116910,80.31936636; 116940,81.91230984; 116970,81.91230984; 117000,
            80.18202181; 117030,79.29080429; 117060,79.29080429; 117090,79.29080429; 117120,79.29080429; 117150,78.06100903; 117180,76.88140926;
            117210,76.88140926; 117240,77.60318298; 117270,78.00789442; 117300,77.08293056; 117330,75.74511766; 117360,75.74511766; 117390,
            76.82869692; 117420,76.82869692; 117450,76.82869692; 117480,75.85081415; 117510,75.20059376; 117540,75.82770052; 117570,76.61286278;
            117600,76.61286278; 117630,76.61286278; 117660,76.61286278; 117690,77.88737411; 117720,79.93309364; 117750,80.75551386; 117780,
            80.02608089; 117810,78.99549122; 117840,78.99549122; 117870,79.47739849; 117900,79.91670971; 117930,78.52679329; 117960,77.75176907;
            117990,77.75176907; 118020,78.69334517; 118050,79.73755188; 118080,79.28085108; 118110,78.81831207; 118140,78.81831207; 118170,
            79.73051777; 118200,80.87545252; 118230,80.18202181; 118260,79.69417305; 118290,79.69417305; 118320,79.69417305; 118350,80.57828035;
            118380,80.57828035; 118410,79.32433863; 118440,78.77141075; 118470,78.77141075; 118500,79.46466751; 118530,79.90014095; 118560,
            79.05492783; 118590,79.05492783; 118620,79.4998435; 118650,80.76208591; 118680,80.76208591; 118710,80.76208591; 118740,80.76208591;
            118770,81.57995081; 118800,83.62407217; 118830,84.38060331; 118860,84.38060331; 118890,85.09367409; 118920,86.16606073; 118950,
            88.26805315; 118980,88.79679651; 119010,88.18787298; 119040,86.8559907; 119070,86.8559907; 119100,86.8559907; 119130,86.8559907;
            119160,86.8559907; 119190,85.54719486; 119220,84.89569159; 119250,84.89569159; 119280,84.89569159; 119310,84.89569159; 119340,
            84.15272312; 119370,84.15272312; 119400,84.88187342; 119430,86.2530467; 119460,86.83043633; 119490,85.55459318; 119520,85.55459318;
            119550,85.55459318; 119580,87.13958931; 119610,87.13958931; 119640,86.09447479; 119670,85.07665415; 119700,85.07665415; 119730,
            85.95025377; 119760,86.56851082; 119790,86.56851082; 119820,86.56851082; 119850,86.56851082; 119880,88.19423304; 119910,89.34110842;
            119940,88.2069912; 119970,86.48279686; 120000,86.48279686; 120030,87.29535084; 120060,88.20271854; 120090,87.34867201; 120120,
            85.90495062; 120150,85.07540932; 120180,85.07540932; 120210,85.07540932; 120240,83.88205662; 120270,82.64207983; 120300,81.98827715;
            120330,81.98827715; 120360,83.33912544; 120390,83.33912544; 120420,81.88956041; 120450,81.88956041; 120480,83.00647831; 120510,
            84.53053751; 120540,84.53053751; 120570,84.04391184; 120600,84.04391184; 120630,84.04391184; 120660,84.91803331; 120690,84.34091549;
            120720,82.96745911; 120750,82.11400509; 120780,82.11400509; 120810,83.48784199; 120840,83.48784199; 120870,83.48784199; 120900,
            82.67878332; 120930,82.67878332; 120960,83.34622478; 120990,83.34622478; 121020,81.08822079; 121050,80.03012524; 121080,79.58561726;
            121110,80.1590169; 121140,80.1590169; 121170,79.62484303; 121200,78.79828062; 121230,78.79828062; 121260,81.45305958; 121290,
            82.48899822; 121320,82.48899822; 121350,82.48899822; 121380,82.48899822; 121410,84.52834139; 121440,85.46478052; 121470,85.46478052;
            121500,84.7132885; 121530,83.98976984; 121560,84.90190487; 121590,85.45456095; 121620,85.45456095; 121650,83.59763718; 121680,
            83.59763718; 121710,84.13688822; 121740,85.86543674; 121770,85.86543674; 121800,86.31817474; 121830,86.31817474; 121860,86.86200285;
            121890,88.53697472; 121920,88.53697472; 121950,87.27345486; 121980,86.20026913; 122010,86.20026913; 122040,86.20026913; 122070,
            86.67462044; 122100,85.9474597; 122130,85.29786987; 122160,85.29786987; 122190,86.79305334; 122220,87.58409185; 122250,87.58409185;
            122280,86.57000027; 122310,86.57000027; 122340,87.21688843; 122370,87.74430542; 122400,87.74430542; 122430,86.53367186; 122460,
            85.71687241; 122490,85.71687241; 122520,85.71687241; 122550,84.61400642; 122580,82.56303577; 122610,81.83172197; 122640,81.83172197;
            122670,83.56535854; 122700,84.1328167; 122730,83.36491899; 122760,82.29871302; 122790,82.29871302; 122820,83.19499683; 122850,
            83.87257633; 122880,83.2873807; 122910,82.32078295; 122940,82.32078295; 122970,83.724648; 123000,84.92548056; 123030,84.92548056;
            123060,83.44830637; 123090,82.81256189; 123120,82.81256189; 123150,82.81256189; 123180,83.74078732; 123210,83.74078732; 123240,
            83.31371241; 123270,84.08963356; 123300,85.50202761; 123330,87.44817696; 123360,87.44817696; 123390,87.44817696; 123420,88.28983498;
            123450,89.92402096; 123480,91.69045258; 123510,92.46492233; 123540,91.85371571; 123570,91.85371571; 123600,91.85371571; 123630,
            93.84092274; 123660,94.37578697; 123690,94.37578697; 123720,94.37578697; 123750,95.1364603; 123780,97.64100609; 123810,98.8221714;
            123840,98.8221714; 123870,98.8221714; 123900,99.34471779; 123930,99.34471779; 123960,99.34471779; 123990,98.1631937; 124020,
            96.34604473; 124050,95.53911152; 124080,95.53911152; 124110,96.8464016; 124140,96.8464016; 124170,96.8464016; 124200,96.22750854;
            124230,96.22750854; 124260,97.47214394; 124290,97.96088963; 124320,97.38273354; 124350,96.51530914; 124380,96.51530914; 124410,
            95.98949032; 124440,95.98949032; 124470,95.98949032; 124500,93.91236191; 124530,92.56361732; 124560,92.56361732; 124590,92.56361732;
            124620,92.56361732; 124650,91.99943161; 124680,91.99943161; 124710,91.99943161; 124740,93.49119587; 124770,94.35782661; 124800,
            93.84830475; 124830,92.90656013; 124860,92.37557716; 124890,92.37557716; 124920,92.37557716; 124950,91.60634766; 124980,90.07755919;
            125010,90.07755919; 125040,90.90186024; 125070,93.01366997; 125100,93.48007393; 125130,93.48007393; 125160,93.48007393; 125190,
            94.2328434; 125220,95.49304733; 125250,95.49304733; 125280,95.49304733; 125310,93.16874657; 125340,92.62845726; 125370,92.62845726;
            125400,92.62845726; 125430,93.11546345; 125460,92.20189877; 125490,92.20189877; 125520,92.20189877; 125550,93.7578289; 125580,
            94.40268402; 125610,94.40268402; 125640,94.40268402; 125670,95.01330357; 125700,95.88028221; 125730,95.88028221; 125760,95.10231171;
            125790,93.92803917; 125820,93.92803917; 125850,93.92803917; 125880,93.92803917; 125910,93.92803917; 125940,92.12598038; 125970,
            91.09279232; 126000,91.09279232; 126030,92.61711788; 126060,92.61711788; 126090,92.03905964; 126120,91.57213383; 126150,91.57213383;
            126180,91.57213383; 126210,91.57213383; 126240,90.56067324; 126270,88.46087694; 126300,87.94574518; 126330,87.94574518; 126360,
            87.94574518; 126390,86.88195276; 126420,84.76233702; 126450,84.00958929; 126480,84.00958929; 126510,85.12422409; 126540,85.12422409;
            126570,85.12422409; 126600,85.12422409; 126630,85.12422409; 126660,86.71369944; 126690,87.36876326; 126720,87.36876326; 126750,
            86.3832593; 126780,86.3832593; 126810,87.41926317; 126840,88.62404766; 126870,89.11208668; 126900,88.40924635; 126930,87.79768639;
            126960,87.79768639; 126990,87.79768639; 127020,87.35270004; 127050,84.95282335; 127080,83.94148779; 127110,83.94148779; 127140,
            83.52071314; 127170,84.24471016; 127200,83.81666765; 127230,83.81666765; 127260,84.30769644; 127290,86.25157356; 127320,87.40570049;
            127350,87.40570049; 127380,87.40570049; 127410,87.40570049; 127440,88.44450388; 127470,88.9430397; 127500,89.42890978; 127530,
            89.42890978; 127560,89.42890978; 127590,89.42890978; 127620,90.21783915; 127650,90.68116093; 127680,90.68116093; 127710,90.21295767;
            127740,90.21295767; 127770,90.21295767; 127800,91.10901318; 127830,90.33982172; 127860,89.3395483; 127890,89.3395483; 127920,
            90.20376549; 127950,91.18187113; 127980,91.18187113; 128010,91.18187113; 128040,91.18187113; 128070,90.61383677; 128100,90.61383677;
            128130,90.61383677; 128160,88.11118269; 128190,87.29856892; 128220,87.29856892; 128250,88.51717701; 128280,88.51717701; 128310,
            87.33377752; 128340,86.73678589; 128370,86.26517429; 128400,87.54026184; 128430,87.54026184; 128460,87.54026184; 128490,86.75102806;
            128520,86.75102806; 128550,86.75102806; 128580,87.9887435; 128610,87.9887435; 128640,87.9887435; 128670,87.9887435; 128700,
            88.98857117; 128730,90.90023489; 128760,91.5284832; 128790,91.5284832; 128820,92.2024641; 128850,92.84116573; 128880,93.92192917;
            128910,93.92192917; 128940,91.21746025; 128970,90.01105042; 129000,89.43982515; 129030,89.43982515; 129060,89.43982515; 129090,
            89.43982515; 129120,88.96422358; 129150,88.96422358; 129180,90.24802494; 129210,92.23641701; 129240,92.94947147; 129270,92.94947147;
            129300,92.94947147; 129330,93.77291908; 129360,95.37718563; 129390,96.26450558; 129420,95.62616272; 129450,93.86979847; 129480,
            93.86979847; 129510,93.86979847; 129540,93.86979847; 129570,93.0800211; 129600,91.80631428; 129630,91.80631428; 129660,91.33442001;
            129690,92.27589283; 129720,92.27589283; 129750,92.27589283; 129780,91.46237125; 129810,91.46237125; 129840,91.46237125; 129870,
            92.26170502; 129900,92.26170502; 129930,92.26170502; 129960,93.48840179; 129990,94.87872047; 130020,96.47382202; 130050,96.47382202;
            130080,95.15624714; 130110,95.15624714; 130140,95.15624714; 130170,96.06326694; 130200,96.06326694; 130230,94.77164326; 130260,
            93.95537109; 130290,93.95537109; 130320,93.95537109; 130350,93.95537109; 130380,93.95537109; 130410,92.60340843; 130440,92.60340843;
            130470,93.94621696; 130500,94.91269512; 130530,94.91269512; 130560,94.91269512; 130590,95.88526154; 130620,97.28134232; 130650,
            98.93293419; 130680,98.93293419; 130710,97.38304882; 130740,96.39126091; 130770,96.39126091; 130800,96.39126091; 130830,96.39126091;
            130860,93.19806805; 130890,92.54540691; 130920,92.54540691; 130950,93.26987686; 130980,93.81717854; 131010,94.30550022; 131040,
            94.30550022; 131070,94.30550022; 131100,95.26954308; 131130,95.26954308; 131160,95.26954308; 131190,93.86159019; 131220,93.86159019;
            131250,93.86159019; 131280,95.05258369; 131310,95.05258369; 131340,95.05258369; 131370,93.96831951; 131400,93.96831951; 131430,
            93.96831951; 131460,94.83527641; 131490,94.83527641; 131520,94.83527641; 131550,94.83527641; 131580,94.83527641; 131610,95.87544422;
            131640,95.87544422; 131670,95.87544422; 131700,95.37273903; 131730,95.37273903; 131760,96.22420349; 131790,96.96752529; 131820,
            96.96752529; 131850,96.96752529; 131880,96.96752529; 131910,98.08352451; 131940,98.99118576; 131970,98.99118576; 132000,97.80665016;
            132030,97.07911434; 132060,97.07911434; 132090,96.57601776; 132120,95.95690727; 132150,93.66050377; 132180,92.62641335; 132210,
            92.62641335; 132240,94.03967171; 132270,94.54518185; 132300,94.54518185; 132330,94.54518185; 132360,94.54518185; 132390,95.63801308;
            132420,96.69036827; 132450,96.69036827; 132480,96.69036827; 132510,95.89093666; 132540,95.89093666; 132570,95.89093666; 132600,
            95.89093666; 132630,94.24020367; 132660,93.53350925; 132690,93.53350925; 132720,95.36268253; 132750,96.58583508; 132780,96.58583508;
            132810,96.58583508; 132840,98.14212399; 132870,99.34194546; 132900,100.9421568; 132930,99.78947582; 132960,97.78858109; 132990,
            97.78858109; 133020,97.17935314; 133050,97.17935314; 133080,96.17885685; 133110,94.65918446; 133140,94.65918446; 133170,94.65918446;
            133200,96.54241276; 133230,97.84959412; 133260,97.84959412; 133290,97.84959412; 133320,97.84959412; 133350,97.84959412; 133380,
            97.74476738; 133410,96.72969189; 133440,94.3814621; 133470,93.11261501; 133500,93.11261501; 133530,93.11261501; 133560,93.95307713;
            133590,94.80709648; 133620,96.4035244; 133650,100.1035538; 133680,103.8135092; 133710,106.201367; 133740,106.201367; 133770,
            107.5158978; 133800,108.9006283; 133830,110.6437614; 133860,111.9535194; 133890,111.9535194; 133920,111.9535194; 133950,111.9535194;
            133980,111.9535194; 134010,113.4361078; 134040,113.4361078; 134070,113.4361078; 134100,113.4361078; 134130,113.4361078; 134160,
            113.9385086; 134190,113.9385086; 134220,114.7223173; 134250,114.7223173; 134280,114.7223173; 134310,113.9957273; 134340,113.9957273;
            134370,113.9957273; 134400,112.4160095; 134430,111.6486826; 134460,111.6486826; 134490,111.6486826; 134520,111.6486826; 134550,
            111.6486826; 134580,111.8768835; 134610,113.3360212; 134640,115.166597; 134670,116.5010668; 134700,116.5010668; 134730,116.5010668;
            134760,116.5010668; 134790,116.5010668; 134820,116.1491764; 134850,116.1491764; 134880,113.7556435; 134910,111.8054443; 134940,
            111.2415848; 134970,111.2415848; 135000,109.4019419; 135030,108.2500763; 135060,108.2500763; 135090,108.2500763; 135120,108.2500763;
            135150,109.2723272; 135180,109.2723272; 135210,108.4831804; 135240,107.5110271; 135270,107.5110271; 135300,107.5110271; 135330,
            106.2795794; 135360,103.6865038; 135390,101.9386087; 135420,101.1104101; 135450,101.1104101; 135480,101.1104101; 135510,99.45196896;
            135540,98.64775372; 135570,98.64775372; 135600,98.64775372; 135630,99.25413322; 135660,99.25413322; 135690,98.62408562; 135720,
            97.54749699; 135750,97.54749699; 135780,97.54749699; 135810,96.9578928; 135840,95.93239117; 135870,94.57878685; 135900,95.26459637;
            135930,97.49024563; 135960,99.62656059; 135990,100.5166855; 136020,101.0894491; 136050,102.6480864; 136080,104.5243132; 136110,
            106.4945492; 136140,106.4945492; 136170,106.4945492; 136200,106.4945492; 136230,105.837985; 136260,105.837985; 136290,106.6928741;
            136320,106.6928741; 136350,106.1331024; 136380,106.1331024; 136410,106.1331024; 136440,106.7678576; 136470,106.7678576; 136500,
            105.5417479; 136530,105.5417479; 136560,105.5417479; 136590,105.5417479; 136620,105.3887913; 136650,104.055463; 136680,104.055463;
            136710,103.3918648; 136740,103.3918648; 136770,103.3918648; 136800,102.7208736; 136830,101.1007015; 136860,101.1007015; 136890,
            100.5935171; 136920,100.5935171; 136950,99.46996193; 136980,98.8062767; 137010,98.8062767; 137040,98.8062767; 137070,98.8062767;
            137100,98.8062767; 137130,98.41811771; 137160,98.41811771; 137190,98.41811771; 137220,98.41811771; 137250,99.22535534; 137280,
            98.64910183; 137310,97.96680393; 137340,97.96680393; 137370,97.26171856; 137400,97.26171856; 137430,97.26171856; 137460,94.67959099;
            137490,94.67959099; 137520,94.67959099; 137550,96.03951187; 137580,96.03951187; 137610,96.03951187; 137640,95.55215778; 137670,
            95.55215778; 137700,95.55215778; 137730,95.55215778; 137760,94.52112236; 137790,93.8725708; 137820,93.8725708; 137850,93.8725708;
            137880,94.5318203; 137910,94.5318203; 137940,94.5318203; 137970,94.5318203; 138000,95.31212826; 138030,96.64227104; 138060,
            96.64227104; 138090,96.64227104; 138120,95.68225079; 138150,95.68225079; 138180,95.68225079; 138210,95.68225079; 138240,95.00512791;
            138270,95.00512791; 138300,94.0022398; 138330,94.0022398; 138360,94.74820347; 138390,95.35371323; 138420,95.35371323; 138450,
            96.46465702; 138480,98.09133053; 138510,99.4978157; 138540,99.4978157; 138570,99.4978157; 138600,97.89513645; 138630,97.20559788;
            138660,97.20559788; 138690,97.20559788; 138720,96.12189903; 138750,95.10637779; 138780,95.10637779; 138810,95.10637779; 138840,
            96.33790169; 138870,96.33790169; 138900,96.33790169; 138930,95.70832157; 138960,95.70832157; 138990,95.70832157; 139020,94.32009029;
            139050,91.36627464; 139080,90.584412; 139110,90.584412; 139140,90.584412; 139170,90.584412; 139200,89.72272253; 139230,88.31216583;
            139260,87.61949615; 139290,87.61949615; 139320,88.52413502; 139350,88.52413502; 139380,88.52413502; 139410,88.52413502; 139440,
            88.52413502; 139470,89.86125212; 139500,90.31862698; 139530,89.27696972; 139560,88.25901861; 139590,88.25901861; 139620,88.25901861;
            139650,89.68381205; 139680,89.68381205; 139710,90.51560383; 139740,91.36720963; 139770,92.75314693; 139800,94.07196121; 139830,
            94.07196121; 139860,92.92001953; 139890,91.78916931; 139920,91.18859539; 139950,90.62625246; 139980,90.62625246; 140010,88.62288437;
            140040,87.6747797; 140070,87.6747797; 140100,87.6747797; 140130,89.27175121; 140160,89.27175121; 140190,89.27175121; 140220,
            89.27175121; 140250,89.29467459; 140280,89.77746792; 140310,89.77746792; 140340,89.77746792; 140370,89.77746792; 140400,89.77746792;
            140430,91.35067348; 140460,92.41440067; 140490,92.41440067; 140520,93.05899487; 140550,94.35153179; 140580,96.47355022; 140610,
            96.47355022; 140640,95.44239521; 140670,91.56070747; 140700,87.88475389; 140730,81.28400717; 140760,71.43129416; 140790,62.59934807;
            140820,52.5024579; 140850,44.38120165; 140880,38.90113993], shiftTime=140000)
        annotation (Placement(transformation(extent={{-128,16},{-108,36}})));
      Modelica.Blocks.Continuous.SecondOrder secondOrder(D=150) annotation (Placement(transformation(extent={{-86,34},{-66,54}})));
    equation
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, SteamSink.ports[1])
        annotation (Line(points={{-4,42},{-4,80},{20,80}},  color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{36,2},{64,2}},     color={0,127,255}));
      connect(heatRecoverySteamGenerator.Feed_port, FeedSource.ports[1])
        annotation (Line(points={{-4,-38},{-4,-70},{40,-70}},         color={0,127,255}));
      connect(boundary.ports[1], heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-60,0},{-52,0},{-52,2},{-44,2}},
                                                   color={0,127,255}));
      connect(timeTable.y, secondOrder.u) annotation (Line(points={{-107,26},{-94,26},{-94,44},{-88,44}}, color={0,0,127}));
      connect(secondOrder.y, boundary.m_flow_in) annotation (Line(points={{-65,44},{-60,44},{-60,14},{-80,14},{-80,8}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                120,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=140000,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"));
    end HRSG_Test_Cogen;

    model CogenData
      Modelica.Blocks.Sources.TimeTable timeTable(table=[0,58; 3000,58; 3030,58.60919695; 3060,59.51243334; 3090,60.05519056; 3120,59.72885456;
            3150,58.45979004; 3180,58.00114861; 3210,58.71637745; 3240,59.45408936; 3270,59.45408936; 3300,58.06633101; 3330,57.4396265; 3360,
            57.4396265; 3390,58.3776475; 3420,58.3776475; 3450,56.21324501; 3480,55.22105484; 3510,55.22105484; 3540,56.07552538; 3570,
            56.07552538; 3600,55.25518713; 3630,55.25518713; 3660,56.54456034; 3690,58.2554203; 3720,58.91052761; 3750,58.91052761; 3780,
            58.91052761; 3810,58.91052761; 3840,60.49706755; 3870,61.21559057; 3900,60.8899395; 3930,60.38030348; 3960,60.38030348; 3990,
            62.55451784; 4020,63.40779791; 4050,63.40779791; 4080,63.40779791; 4110,63.80034914; 4140,66.15006294; 4170,66.7596714; 4200,
            66.7596714; 4230,65.49031334; 4260,65.49031334; 4290,65.49031334; 4320,65.97667809; 4350,64.61677351; 4380,62.76791668; 4410,
            62.76791668; 4440,62.76791668; 4470,62.76791668; 4500,62.11279306; 4530,60.98372583; 4560,60.41784954; 4590,61.38512678; 4620,
            61.38512678; 4650,61.38512678; 4680,60.51043997; 4710,60.12748318; 4740,60.62745953; 4770,61.0522296; 4800,60.39226255; 4830,
            59.09382763; 4860,58.4663784; 4890,59.59784288; 4920,60.65329113; 4950,60.65329113; 4980,60.17054672; 5010,60.17054672; 5040,
            61.1638567; 5070,62.16676111; 5100,62.16676111; 5130,60.7354228; 5160,60.7354228; 5190,61.1955102; 5220,61.86407146; 5250,61.86407146;
            5280,60.50067158; 5310,59.94611835; 5340,61.01184053; 5370,61.7419095; 5400,62.22499094; 5430,62.22499094; 5460,61.67486801; 5490,
            62.89897728; 5520,64.83929386; 5550,65.38057795; 5580,65.38057795; 5610,66.01708889; 5640,67.61545744; 5670,69.3701746; 5700,
            69.3701746; 5730,68.37602749; 5760,67.2783637; 5790,67.2783637; 5820,68.01544504; 5850,68.01544504; 5880,68.01544504; 5910,
            67.63642931; 5940,68.411584; 5970,70.34751921; 6000,71.20659399; 6030,71.20659399; 6060,71.20659399; 6090,72.71766672; 6120,
            74.72588911; 6150,75.44203119; 6180,74.65377588; 6210,73.3486928; 6240,73.3486928; 6270,73.3486928; 6300,73.3486928; 6330,71.86744165;
            6360,70.58086252; 6390,70.58086252; 6420,71.49887924; 6450,72.26715202; 6480,71.75222139; 6510,71.17880545; 6540,71.57356367; 6570,
            73.08964291; 6600,73.83376379; 6630,73.13659315; 6660,71.99076147; 6690,70.84565821; 6720,70.10821266; 6750,68.84244232; 6780,
            66.03810425; 6810,63.91719475; 6840,63.29423018; 6870,63.29423018; 6900,63.29423018; 6930,62.92680931; 6960,62.4203207; 6990,
            62.4203207; 7020,63.44589844; 7050,65.48608961; 7080,65.95867424; 7110,65.95867424; 7140,67.84317455; 7170,71.00348539; 7200,
            73.98289347; 7230,74.43041296; 7260,74.43041296; 7290,75.10344257; 7320,76.74115105; 7350,78.66614914; 7380,78.66614914; 7410,
            78.14747858; 7440,77.18289757; 7470,77.6478447; 7500,78.64147539; 7530,79.12964487; 7560,79.12964487; 7590,79.55226231; 7620,
            81.7511178; 7650,84.69997587; 7680,85.75320625; 7710,86.40573692; 7740,86.40573692; 7770,86.88109932; 7800,87.5420557; 7830,
            87.5420557; 7860,86.61530342; 7890,83.93338823; 7920,83.93338823; 7950,83.93338823; 7980,83.93338823; 8010,83.36077137; 8040,
            81.94957323; 8070,81.94957323; 8100,81.94957323; 8130,83.11251726; 8160,83.11251726; 8190,83.11251726; 8220,83.11251726; 8250,
            83.11251726; 8280,84.45592918; 8310,84.45592918; 8340,84.45592918; 8370,83.98043089; 8400,85.4068388; 8430,87.12019386; 8460,
            87.12019386; 8490,87.80688944; 8520,87.80688944; 8550,89.44651136; 8580,91.5840929; 8610,92.51884689; 8640,91.78436394; 8670,
            91.78436394; 8700,91.78436394; 8730,92.75373402; 8760,92.75373402; 8790,92.75373402; 8820,92.75373402; 8850,92.75373402; 8880,
            93.82892017; 8910,93.82892017; 8940,93.82892017; 8970,93.82892017; 9000,93.82892017; 9030,93.84077053; 9060,93.84077053; 9090,
            93.19716568; 9120,92.17975273; 9150,92.17975273; 9180,93.09082775; 9210,93.71864662; 9240,93.71864662; 9270,93.71864662; 9300,
            94.80378056; 9330,95.84390488; 9360,95.84390488; 9390,95.84390488; 9420,95.24128704; 9450,95.24128704; 9480,94.4146431; 9510,
            94.4146431; 9540,93.38389034; 9570,90.87154398; 9600,89.85638151; 9630,89.85638151; 9660,90.36195688; 9690,90.36195688; 9720,
            90.36195688; 9750,90.36195688; 9780,91.20097847; 9810,92.86381187; 9840,93.3563736; 9870,92.77745647; 9900,91.73065681; 9930,
            91.24124794; 9960,91.24124794; 9990,91.24124794; 10020,89.67314672; 10050,88.16205225; 10080,87.62821541; 10110,88.34711895; 10140,
            89.30800896; 10170,89.30800896; 10200,89.30800896; 10230,90.12386255; 10260,90.78045931; 10290,92.51556358; 10320,92.51556358; 10350,
            93.03061924; 10380,93.03061924; 10410,93.84224911; 10440,94.77094746; 10470,94.77094746; 10500,93.18030338; 10530,91.94869251; 10560,
            91.94869251; 10590,91.94869251; 10620,90.52781296; 10650,87.1621376; 10680,85.71405115; 10710,85.09681606; 10740,85.7267767; 10770,
            85.7267767; 10800,85.7267767; 10830,85.27247314; 10860,85.27247314; 10890,88.46436138; 10920,88.46436138; 10950,88.46436138; 10980,
            88.46436138; 11010,88.46436138; 11040,89.18945103; 11070,89.71571016; 11100,88.52192259; 11130,87.03964949; 11160,86.02975445; 11190,
            86.02975445; 11220,86.02975445; 11250,86.02975445; 11280,86.02975445; 11310,85.52043371; 11340,85.9909853; 11370,86.4404726; 11400,
            86.4404726; 11430,84.3112298; 11460,83.87955065; 11490,83.87955065; 11520,84.76950703; 11550,84.76950703; 11580,83.45884123; 11610,
            83.45884123; 11640,83.45884123; 11670,84.63956623; 11700,85.07457218; 11730,84.41259928; 11760,83.55161648; 11790,83.55161648; 11820,
            83.55161648; 11850,83.55161648; 11880,82.3597043; 11910,80.50722713; 11940,78.91925755; 11970,78.91925755; 12000,78.05439348; 12030,
            76.74517365; 12060,75.3288331; 12090,74.84012547; 12120,76.65355625; 12150,78.67343874; 12180,80.64257126; 12210,80.64257126; 12240,
            83.35015497; 12270,85.30230017; 12300,87.47292137; 12330,88.43974743; 12360,88.43974743; 12390,88.43974743; 12420,88.43974743; 12450,
            89.51980963; 12480,89.51980963; 12510,88.8751339; 12540,88.8751339; 12570,88.8751339; 12600,89.8738472; 12630,91.39008408; 12660,
            91.39008408; 12690,91.39008408; 12720,91.39008408; 12750,91.39008408; 12780,92.03800507; 12810,92.03800507; 12840,90.58045464; 12870,
            89.5166894; 12900,88.8226553; 12930,88.8226553; 12960,88.05029469; 12990,86.70635548; 13020,85.50517502; 13050,85.50517502; 13080,
            87.28864832; 13110,88.26910229; 13140,88.26910229; 13170,87.59429512; 13200,87.59429512; 13230,88.18183908; 13260,89.00857; 13290,
            89.00857; 13320,87.57299709; 13350,87.57299709; 13380,87.57299709; 13410,87.57299709; 13440,86.93482819; 13470,86.07374754; 13500,
            85.59768391; 13530,85.59768391; 13560,86.90258217; 13590,86.90258217; 13620,86.17486153; 13650,85.12546349; 13680,85.12546349; 13710,
            85.12546349; 13740,85.12546349; 13770,84.69109898; 13800,84.69109898; 13830,86.79968519; 13860,89.77017832; 13890,91.03381233; 13920,
            91.51187096; 13950,92.45918198; 13980,94.65636864; 14010,96.98474636; 14040,96.98474636; 14070,96.98474636; 14100,96.98474636; 14130,
            96.37941055; 14160,96.37941055; 14190,96.37941055; 14220,95.30238705; 14250,93.15822258; 14280,93.15822258; 14310,92.59405861; 14340,
            93.33016148; 14370,93.33016148; 14400,92.36020432; 14430,92.84760189; 14460,94.32433033; 14490,95.29471149; 14520,95.29471149; 14550,
            95.29471149; 14580,94.23710518; 14610,94.23710518; 14640,94.98898315; 14670,94.98898315; 14700,94.03913898; 14730,94.03913898; 14760,
            94.87981853; 14790,96.83330097; 14820,97.39924793; 14850,97.39924793; 14880,97.39924793; 14910,97.39924793; 14940,97.39924793; 14970,
            97.85276871; 15000,97.85276871; 15030,97.85276871; 15060,97.85276871; 15090,97.85276871; 15120,97.82742634; 15150,97.82742634; 15180,
            97.82742634; 15210,97.82742634; 15240,97.82742634; 15270,97.94380989; 15300,97.94380989; 15330,97.94380989; 15360,97.94380989; 15390,
            97.94380989; 15420,97.79311466; 15450,97.79311466; 15480,97.79311466; 15510,97.79311466; 15540,97.79311466; 15570,97.62053432; 15600,
            97.62053432; 15630,97.62053432; 15660,96.3418808; 15690,95.79330711; 15720,95.79330711; 15750,93.08922958; 15780,89.92416773; 15810,
            88.90429773; 15840,88.90429773; 15870,88.90429773; 15900,88.17245121; 15930,87.58414621; 15960,87.58414621; 15990,88.6184432; 16020,
            91.0147213; 16050,91.96440239; 16080,91.96440239; 16110,91.96440239; 16140,94.28103848; 16170,96.44310894; 16200,96.44310894; 16230,
            96.44310894; 16260,97.03646393; 16290,97.03646393; 16320,97.03646393; 16350,97.03646393; 16380,97.03646393; 16410,97.1272768; 16440,
            97.1272768; 16470,97.1272768; 16500,97.1272768; 16530,97.1272768; 16560,95.96116905; 16590,95.96116905; 16620,95.96116905; 16650,
            96.73757401; 16680,96.73757401; 16710,96.73757401; 16740,96.73757401; 16770,96.73757401; 16800,96.62887688; 16830,96.62887688; 16860,
            96.62887688; 16890,96.62887688; 16920,96.62887688; 16950,96.74157486; 16980,96.74157486; 17010,96.74157486; 17040,96.74157486; 17070,
            96.74157486; 17100,96.9238203; 17130,96.9238203; 17160,96.9238203; 17190,96.9238203; 17220,96.9238203; 17250,96.67107067; 17280,
            96.67107067; 17310,96.67107067; 17340,96.67107067; 17370,96.67107067; 17400,97.16654606; 17430,97.16654606; 17460,97.16654606; 17490,
            97.16654606; 17520,97.16654606; 17550,96.87985439; 17580,96.87985439; 17610,96.87985439; 17640,96.87985439; 17670,96.87985439; 17700,
            97.04056263; 17730,97.04056263; 17760,97.04056263; 17790,97.04056263; 17820,97.04056263; 17850,97.15780506; 17880,97.15780506; 17910,
            97.15780506; 17940,97.15780506; 17970,97.10132561; 18000,97.10132561; 18030,97.10132561; 18060,97.10132561; 18090,97.10132561; 18120,
            97.10132561; 18150,96.97984314; 18180,96.97984314; 18210,96.97984314; 18240,96.97984314; 18270,96.97984314; 18300,97.20978355; 18330,
            97.20978355; 18360,97.20978355; 18390,97.20978355; 18420,97.20978355; 18450,96.87995224; 18480,96.87995224; 18510,96.87995224; 18540,
            96.87995224; 18570,96.87995224; 18600,97.10142345; 18630,98.31977062; 18660,135.7417414; 18690,141.4950027; 18720,141.4950027; 18750,
            141.4950027; 18780,138.3526794; 18810,133.7771152; 18840,129.1616077; 18870,122.7757765; 18900,114.2397795; 18930,106.6630199; 18960,
            100.6198162; 18990,97.46893673; 19020,95.19717979; 19050,91.69256172; 19080,90.38953342; 19110,90.38953342; 19140,92.55935555; 19170,
            95.41054058; 19200,97.14911842; 19230,98.39016609; 19260,98.99299049; 19290,100.8703262; 19320,102.2186686; 19350,102.7721889; 19380,
            102.0769318; 19410,100.8557253; 19440,100.2109354; 19470,100.2109354; 19500,100.2109354; 19530,99.66780853; 19560,97.81971817; 19590,
            97.81971817; 19620,97.81971817; 19650,100.7846123; 19680,101.6402842; 19710,101.6402842; 19740,101.6402842; 19770,102.9293421; 19800,
            104.3197477; 19830,104.3197477; 19860,104.3197477; 19890,102.7812235; 19920,102.2286489; 19950,102.2286489; 19980,102.2286489; 20010,
            102.2286489; 20040,100.5705339; 20070,99.69776058; 20100,99.69776058; 20130,101.5910236; 20160,101.5910236; 20190,101.5910236; 20220,
            100.7709137; 20250,100.7709137; 20280,100.7709137; 20310,101.7968285; 20340,101.7968285; 20370,101.7968285; 20400,101.7968285; 20430,
            102.6955856; 20460,103.3175337; 20490,103.3175337; 20520,103.3175337; 20550,103.3175337; 20580,103.8448093; 20610,103.8448093; 20640,
            103.8448093; 20670,102.8813427; 20700,101.8849451; 20730,101.8849451; 20760,101.8849451; 20790,101.8849451; 20820,100.6994419; 20850,
            99.12928047; 20880,99.12928047; 20910,100.0781788; 20940,101.0970594; 20970,101.0970594; 21000,101.0970594; 21030,101.8518728; 21060,
            103.6277412; 21090,104.6556129; 21120,104.6556129; 21150,104.6556129; 21180,103.6084328; 21210,103.6084328; 21240,103.6084328; 21270,
            103.6084328; 21300,102.3835081; 21330,101.8633535; 21360,101.8633535; 21390,102.6389431; 21420,102.6389431; 21450,102.0932178; 21480,
            102.0932178; 21510,102.0932178; 21540,102.9867348; 21570,104.5804121; 21600,104.5804121; 21630,105.2639277; 21660,105.2639277; 21690,
            106.8058983; 21720,107.7409784; 21750,107.7409784; 21780,106.9917532; 21810,106.9917532; 21840,106.9917532; 21870,108.0234192; 21900,
            108.0234192; 21930,108.0234192; 21960,107.1881865; 21990,107.1881865; 22020,107.1881865; 22050,106.1790035; 22080,103.8195105; 22110,
            101.2276308; 22140,99.65137024; 22170,99.65137024; 22200,99.65137024; 22230,98.86195164; 22260,97.65122566; 22290,97.0652092; 22320,
            97.0652092; 22350,97.0652092; 22380,97.0652092; 22410,95.81247425; 22440,95.81247425; 22470,95.31661835; 22500,95.31661835; 22530,
            96.01387596; 22560,94.89997501; 22590,93.25236225; 22620,92.13649349; 22650,91.53860493; 22680,92.02545891; 22710,91.13832378; 22740,
            89.6159008; 22770,88.14779377; 22800,88.14779377; 22830,89.49296694; 22860,90.02974463; 22890,90.02974463; 22920,90.02974463; 22950,
            90.02974463; 22980,90.60085573; 23010,92.09814835; 23040,91.12514706; 23070,90.28893585; 23100,90.28893585; 23130,90.28893585; 23160,
            90.28893585; 23190,89.44305954; 23220,87.43805523; 23250,85.33397541; 23280,85.33397541; 23310,84.70921154; 23340,84.70921154; 23370,
            83.09650841; 23400,82.21325455; 23430,82.21325455; 23460,83.80903015; 23490,85.93801203; 23520,86.52482214; 23550,86.52482214; 23580,
            86.52482214; 23610,87.41534929; 23640,88.12720242; 23670,88.12720242; 23700,86.51115618; 23730,85.56031179; 23760,85.06451025; 23790,
            85.06451025; 23820,84.4087615; 23850,82.23516684; 23880,80.54505043; 23910,79.97752705; 23940,80.86698332; 23970,80.86698332; 24000,
            81.48258762; 24030,81.48258762; 24060,82.14326677; 24090,83.72786064; 24120,84.92567625; 24150,85.53746452; 24180,85.53746452; 24210,
            85.53746452; 24240,85.05126829; 24270,85.05126829; 24300,85.05126829; 24330,82.94669924; 24360,82.94669924; 24390,82.15523129; 24420,
            82.60315847; 24450,84.26929693; 24480,84.26929693; 24510,84.26929693; 24540,84.26929693; 24570,84.85652018; 24600,85.90988646; 24630,
            86.73354063; 24660,85.82430296; 24690,84.8736434; 24720,84.8736434; 24750,84.8736434; 24780,84.8736434; 24810,84.8736434; 24840,
            84.07692432; 24870,84.07692432; 24900,84.97190351; 24930,86.78966675; 24960,86.78966675; 24990,87.54209375; 25020,88.91206026; 25050,
            90.1147954; 25080,91.86809921; 25110,91.86809921; 25140,90.17926025; 25170,89.47597961; 25200,88.85820637; 25230,89.8426775; 25260,
            89.8426775; 25290,89.8426775; 25320,89.8426775; 25350,89.8426775; 25380,91.45718536; 25410,92.98628368; 25440,92.98628368; 25470,
            92.98628368; 25500,94.26603527; 25530,95.33282833; 25560,96.89395523; 25590,98.23955784; 25620,98.23955784; 25650,98.23955784; 25680,
            98.80773354; 25710,100.2905828; 25740,101.9991652; 25770,101.9991652; 25800,101.9991652; 25830,101.9991652; 25860,103.0382784; 25890,
            103.0382784; 25920,102.2905535; 25950,98.1628458; 25980,95.182057; 26010,92.90696239; 26040,91.72651463; 26070,89.57568569; 26100,
            86.11120119; 26130,84.71233177; 26160,84.71233177; 26190,85.47261915; 26220,87.31726856; 26250,87.31726856; 26280,88.59754744; 26310,
            90.30599928; 26340,92.64787445; 26370,95.44580898; 26400,96.14737186; 26430,96.14737186; 26460,96.14737186; 26490,96.14737186; 26520,
            97.5360815; 26550,97.5360815; 26580,97.5360815; 26610,95.49563484; 26640,96.00392818; 26670,97.19679165; 26700,97.72595901; 26730,
            97.72595901; 26760,97.72595901; 26790,97.72595901; 26820,97.72595901; 26850,98.22239113; 26880,98.22239113; 26910,98.22239113; 26940,
            98.22239113; 26970,98.22239113; 27000,100.6299814; 27030,101.6219759; 27060,101.6219759; 27090,101.6219759; 27120,101.6219759; 27150,
            101.6219759; 27180,101.9400764; 27210,100.8270561; 27240,99.15106773; 27270,99.15106773; 27300,99.15106773; 27330,99.15106773; 27360,
            97.22982044; 27390,95.20525761; 27420,94.63879967; 27450,94.63879967; 27480,94.63879967; 27510,94.63879967; 27540,94.63879967; 27570,
            94.45957661; 27600,94.45957661; 27630,96.02180157; 27660,96.02180157; 27690,96.02180157; 27720,96.02180157; 27750,96.02180157; 27780,
            96.93714924; 27810,97.47704716; 27840,97.47704716; 27870,96.76861324; 27900,95.58493652; 27930,95.58493652; 27960,95.58493652; 27990,
            94.4600441; 28020,92.79622135; 28050,91.94521351; 28080,91.94521351; 28110,93.6103735; 28140,95.36121483; 28170,95.85552692; 28200,
            95.85552692; 28230,96.44931679; 28260,97.41633854; 28290,98.95855923; 28320,98.95855923; 28350,97.04444389; 28380,96.41287422; 28410,
            96.41287422; 28440,96.41287422; 28470,95.0009531; 28500,92.76413841; 28530,90.36374531; 28560,89.35199118; 28590,89.35199118; 28620,
            89.35199118; 28650,88.15185986; 28680,86.66157417; 28710,86.16877327; 28740,86.96090984; 28770,88.08472052; 28800,88.08472052; 28830,
            86.85453386; 28860,85.91586056; 28890,85.91586056; 28920,85.91586056; 28950,85.91586056; 28980,85.1729845; 29010,84.67663937; 29040,
            84.67663937; 29070,86.75586605; 29100,88.2687109; 29130,89.03485823; 29160,89.03485823; 29190,89.03485823; 29220,89.63906879; 29250,
            90.1990797; 29280,90.1990797; 29310,89.6138895; 29340,87.35990267; 29370,86.67221231; 29400,86.67221231; 29430,86.67221231; 29460,
            86.67221231; 29490,86.17948208; 29520,87.08160954; 29550,88.78592463; 29580,91.12810965; 29610,91.12810965; 29640,91.68751717; 29670,
            91.68751717; 29700,92.67524986; 29730,94.49688892; 29760,94.49688892; 29790,94.0025877; 29820,94.0025877; 29850,93.45456848; 29880,
            94.21405678; 29910,94.76999073; 29940,94.76999073; 29970,94.76999073; 30000,93.74559803; 30030,93.74559803; 30060,94.34179058; 30090,
            94.34179058; 30120,92.73078346; 30150,92.73078346; 30180,92.1889286; 30210,92.1889286; 30240,92.86170273; 30270,91.76774082; 30300,
            91.76774082; 30330,91.76774082; 30360,92.24399471; 30390,92.24399471; 30420,92.24399471; 30450,92.24399471; 30480,92.24399471; 30510,
            93.63652039; 30540,94.48933296; 30570,94.48933296; 30600,94.48933296; 30630,93.85857868; 30660,93.85857868; 30690,95.09409256; 30720,
            96.20313377; 30750,96.20313377; 30780,96.20313377; 30810,96.20313377; 30840,96.84191151; 30870,98.14813614; 30900,98.14813614; 30930,
            98.14813614; 30960,98.14813614; 30990,98.14813614; 31020,98.24417839; 31050,97.6683054; 31080,95.82324829; 31110,94.94694157; 31140,
            94.94694157; 31170,96.89393349; 31200,97.8206749; 31230,97.8206749; 31260,96.82602768; 31290,96.82602768; 31320,97.60637913; 31350,
            98.93914204; 31380,98.93914204; 31410,97.80261669; 31440,97.17065563; 31470,97.17065563; 31500,97.80095329; 31530,97.80095329; 31560,
            96.68511715; 31590,95.29371128; 31620,94.72329597; 31650,94.72329597; 31680,94.04751034; 31710,94.04751034; 31740,94.04751034; 31770,
            94.04751034; 31800,95.36597672; 31830,96.13531494; 31860,96.13531494; 31890,96.13531494; 31920,96.13531494; 31950,96.13531494; 31980,
            96.84598846; 32010,96.84598846; 32040,96.84598846; 32070,96.84598846; 32100,97.50345497; 32130,99.65494709; 32160,100.8220768; 32190,
            100.8220768; 32220,100.8220768; 32250,101.6055159; 32280,103.2723936; 32310,104.7963387; 32340,104.7963387; 32370,103.9468964; 32400,
            102.9063698; 32430,102.9063698; 32460,103.8052357; 32490,103.8052357; 32520,103.8052357; 32550,103.8052357; 32580,103.8052357; 32610,
            104.8547533; 32640,106.095714; 32670,106.095714; 32700,105.5605562; 32730,104.9400867; 32760,104.9400867; 32790,104.9400867; 32820,
            102.9108816; 32850,100.7627489; 32880,99.66158981; 32910,99.66158981; 32940,99.66158981; 32970,100.6133039; 33000,100.6133039; 33030,
            100.6133039; 33060,102.0863577; 33090,103.8963203; 33120,105.4127747; 33150,106.4629555; 33180,105.6885183; 33210,105.6885183; 33240,
            105.0693426; 33270,105.0693426; 33300,105.0693426; 33330,102.3533821; 33360,101.4381323; 33390,101.4381323; 33420,100.7473761; 33450,
            101.9756601; 33480,101.9756601; 33510,101.3417639; 33540,101.3417639; 33570,102.1202671; 33600,103.2855703; 33630,103.2855703; 33660,
            102.3846823; 33690,101.5061251; 33720,101.5061251; 33750,101.5061251; 33780,100.4466488; 33810,98.64663391; 33840,96.4031765; 33870,
            96.4031765; 33900,96.4031765; 33930,98.25012531; 33960,98.80760307; 33990,98.80760307; 34020,98.80760307; 34050,98.80760307; 34080,
            99.73725815; 34110,100.5321236; 34140,99.94841194; 34170,99.94841194; 34200,99.94841194; 34230,100.4758833; 34260,101.2034843; 34290,
            100.5110756; 34320,99.18637962; 34350,99.18637962; 34380,99.18637962; 34410,99.93645287; 34440,99.93645287; 34470,99.93645287; 34500,
            99.93645287; 34530,99.93645287; 34560,99.90602245; 34590,99.90602245; 34620,98.65940838; 34650,97.31270771; 34680,97.31270771; 34710,
            97.31270771; 34740,97.31270771; 34770,96.30977612; 34800,95.21894531; 34830,94.62146988; 34860,94.62146988; 34890,96.46944065; 34920,
            96.46944065; 34950,96.46944065; 34980,94.73642921; 35010,94.73642921; 35040,94.73642921; 35070,94.73642921; 35100,93.51914749; 35130,
            91.45335846; 35160,91.45335846; 35190,91.45335846; 35220,91.45335846; 35250,90.67574673; 35280,88.7658062; 35310,88.10529013; 35340,
            88.10529013; 35370,88.82095385; 35400,89.41317816; 35430,89.41317816; 35460,89.41317816; 35490,88.86110916; 35520,88.86110916; 35550,
            90.06450748; 35580,90.06450748; 35610,90.06450748; 35640,90.92858334; 35670,93.59055405; 35700,96.19800224; 35730,96.71189461; 35760,
            96.71189461; 35790,96.71189461; 35820,98.15102806; 35850,98.94164257; 35880,100.2568583; 35910,99.10282917; 35940,97.51721878; 35970,
            96.83809547; 36000,96.83809547; 36030,96.83809547; 36060,95.94956875; 36090,93.78633499; 36120,93.78633499; 36150,94.54434471; 36180,
            96.60269737; 36210,97.41260948; 36240,97.41260948; 36270,96.40476379; 36300,96.40476379; 36330,95.89598122; 36360,95.89598122; 36390,
            95.13647118; 36420,93.80015316; 36450,93.80015316; 36480,93.80015316; 36510,94.99975719; 36540,95.70850639; 36570,95.70850639; 36600,
            95.70850639; 36630,96.23779335; 36660,96.9199934; 36690,97.86024857; 36720,96.37393112; 36750,94.42189465; 36780,93.55120869; 36810,
            93.55120869; 36840,93.55120869; 36870,92.50662689; 36900,90.38919096; 36930,89.91698141; 36960,89.91698141; 36990,92.27375107; 37020,
            93.93168125; 37050,94.43365803; 37080,94.43365803; 37110,94.43365803; 37140,95.49463463; 37170,96.39342442; 37200,96.39342442; 37230,
            96.39342442; 37260,95.19519024; 37290,95.19519024; 37320,96.71615639; 37350,97.45974998; 37380,97.45974998; 37410,97.45974998; 37440,
            98.43935051; 37470,99.86977558; 37500,100.560858; 37530,100.560858; 37560,100.560858; 37590,100.560858; 37620,101.7650064; 37650,
            101.7650064; 37680,101.7650064; 37710,101.1416233; 37740,99.64979382; 37770,99.64979382; 37800,99.64979382; 37830,100.2715353; 37860,
            100.2715353; 37890,99.19383774; 37920,99.19383774; 37950,99.71551437; 37980,101.34396; 38010,102.1106998; 38040,101.5929914; 38070,
            101.5929914; 38100,101.5929914; 38130,103.1857664; 38160,104.0332083; 38190,104.0332083; 38220,104.0332083; 38250,104.0332083; 38280,
            105.5241028; 38310,105.5241028; 38340,104.9893364; 38370,102.8971613; 38400,101.2090834; 38430,101.2090834; 38460,101.8738667; 38490,
            101.8738667; 38520,99.42527847; 38550,97.86278172; 38580,97.86278172; 38610,97.86278172; 38640,99.36190624; 38670,99.36190624; 38700,
            99.36190624; 38730,99.36190624; 38760,100.7561932; 38790,101.8542973; 38820,101.0616062; 38850,99.48631325; 38880,98.93414097; 38910,
            98.93414097; 38940,98.93414097; 38970,98.93414097; 39000,97.55175877; 39030,97.55175877; 39060,97.55175877; 39090,97.55175877; 39120,
            97.55175877; 39150,96.75718689; 39180,96.24132671; 39210,95.29286327; 39240,95.29286327; 39270,95.29286327; 39300,93.87509308; 39330,
            91.95341091; 39360,91.43981209; 39390,92.07207756; 39420,93.54624023; 39450,94.11301346; 39480,94.11301346; 39510,94.11301346; 39540,
            95.47767448; 39570,97.23921375; 39600,97.23921375; 39630,98.01013927; 39660,96.63836803; 39690,95.97273674; 39720,95.97273674; 39750,
            95.97273674; 39780,95.97273674; 39810,94.4144474; 39840,93.31151619; 39870,93.31151619; 39900,93.31151619; 39930,93.31151619; 39960,
            93.31151619; 39990,92.65782223; 40020,92.65782223; 40050,92.65782223; 40080,92.65782223; 40110,91.49013805; 40140,89.77509785; 40170,
            88.73272848; 40200,88.73272848; 40230,88.73272848; 40260,88.73272848; 40290,87.40208559; 40320,87.40208559; 40350,87.40208559; 40380,
            88.22113552; 40410,89.31200981; 40440,89.31200981; 40470,89.31200981; 40500,88.21159; 40530,88.21159; 40560,88.21159; 40590,
            88.88184729; 40620,88.88184729; 40650,88.88184729; 40680,88.88184729; 40710,90.25856524; 40740,91.78342896; 40770,91.78342896; 40800,
            92.49859257; 40830,92.49859257; 40860,92.99213276; 40890,92.99213276; 40920,93.60286102; 40950,92.74371014; 40980,91.60233593; 41010,
            91.60233593; 41040,91.60233593; 41070,91.60233593; 41100,91.60233593; 41130,90.40910282; 41160,90.40910282; 41190,90.40910282; 41220,
            91.56531715; 41250,92.45400696; 41280,91.28864937; 41310,91.28864937; 41340,89.91098557; 41370,89.91098557; 41400,89.91098557; 41430,
            89.91098557; 41460,89.91098557; 41490,89.42000027; 41520,89.42000027; 41550,90.62994347; 41580,90.62994347; 41610,90.62994347; 41640,
            90.62994347; 41670,91.58282089; 41700,93.1274334; 41730,93.1274334; 41760,93.73858566; 41790,93.07946663; 41820,93.07946663; 41850,
            93.07946663; 41880,93.07946663; 41910,90.68189478; 41940,89.43479691; 41970,88.20976896; 42000,88.20976896; 42030,88.20976896; 42060,
            88.20976896; 42090,87.56833849; 42120,87.56833849; 42150,87.56833849; 42180,88.40351143; 42210,88.40351143; 42240,88.40351143; 42270,
            88.40351143; 42300,90.00244532; 42330,91.52513466; 42360,92.18680859; 42390,92.18680859; 42420,92.18680859; 42450,92.18680859; 42480,
            92.18680859; 42510,92.15723705; 42540,90.64469118; 42570,89.25467691; 42600,88.71849174; 42630,88.71849174; 42660,88.71849174; 42690,
            88.71849174; 42720,88.71849174; 42750,90.08703947; 42780,91.9063139; 42810,92.85161362; 42840,93.46760387; 42870,93.46760387; 42900,
            93.46760387; 42930,94.45146618; 42960,94.45146618; 42990,94.97830696; 43020,94.97830696; 43050,94.40821781; 43080,94.40821781; 43110,
            94.40821781; 43140,93.59024963; 43170,92.53351307; 43200,91.98702679; 43230,91.98702679; 43260,91.98702679; 43290,91.98702679; 43320,
            91.98702679; 43350,91.63935471; 43380,91.63935471; 43410,92.25519276; 43440,92.25519276; 43470,92.25519276; 43500,91.03719893; 43530,
            90.27619944; 43560,90.27619944; 43590,90.93593817; 43620,90.93593817; 43650,91.41955776; 43680,91.41955776; 43710,92.6524189; 43740,
            94.07806034; 43770,95.52522812; 43800,95.52522812; 43830,95.52522812; 43860,95.52522812; 43890,95.52522812; 43920,95.78645782; 43950,
            94.41806774; 43980,93.43883686; 44010,92.92751026; 44040,92.92751026; 44070,93.6425869; 44100,93.6425869; 44130,93.6425869; 44160,
            93.6425869; 44190,93.6425869; 44220,93.4037859; 44250,93.4037859; 44280,93.4037859; 44310,93.4037859; 44340,93.4037859; 44370,
            93.28260784; 44400,93.7929451; 44430,93.7929451; 44460,93.07921658; 44490,93.07921658; 44520,92.60955105; 44550,93.41457081; 44580,
            94.62006741; 44610,94.62006741; 44640,94.62006741; 44670,94.03377914; 44700,94.03377914; 44730,93.52325706; 44760,93.02961903; 44790,
            91.34193249; 44820,90.58628197; 44850,90.58628197; 44880,90.58628197; 44910,89.80906706; 44940,89.80906706; 44970,88.10733948; 45000,
            88.10733948; 45030,87.31010942; 45060,87.31010942; 45090,87.87408314; 45120,86.85023403; 45150,86.85023403; 45180,86.85023403; 45210,
            88.21365566; 45240,88.81201715; 45270,88.81201715; 45300,88.81201715; 45330,89.30175762; 45360,90.33461952; 45390,90.90208311; 45420,
            90.90208311; 45450,89.92245541; 45480,88.93846807; 45510,88.93846807; 45540,88.93846807; 45570,88.93846807; 45600,86.70914412; 45630,
            84.97195787; 45660,84.97195787; 45690,84.97195787; 45720,84.97195787; 45750,84.97195787; 45780,84.63348885; 45810,84.63348885; 45840,
            84.63348885; 45870,85.83168497; 45900,86.71615648; 45930,85.55026617; 45960,84.66998577; 45990,84.66998577; 46020,84.66998577; 46050,
            84.66998577; 46080,84.66998577; 46110,84.81501131; 46140,84.81501131; 46170,85.28958006; 46200,86.98216982; 46230,86.98216982; 46260,
            86.98216982; 46290,86.98216982; 46320,86.98216982; 46350,88.29404783; 46380,88.29404783; 46410,88.29404783; 46440,87.80058918; 46470,
            87.80058918; 46500,87.80058918; 46530,88.86383257; 46560,88.86383257; 46590,88.86383257; 46620,88.86383257; 46650,89.18362913; 46680,
            90.27391634; 46710,90.27391634; 46740,90.27391634; 46770,89.75445757; 46800,89.1126955; 46830,89.1126955; 46860,89.1126955; 46890,
            89.1126955; 46920,88.09072723; 46950,87.37368822; 46980,87.37368822; 47010,87.37368822; 47040,87.37368822; 47070,87.37368822; 47100,
            87.24267111; 47130,87.90433416; 47160,89.04415913; 47190,89.04415913; 47220,89.04415913; 47250,89.04415913; 47280,89.04415913; 47310,
            89.23685789; 47340,90.27188873; 47370,91.92219772; 47400,94.0964447; 47430,96.18706512; 47460,99.60577354; 47490,96.32886715; 47520,
            96.32886715; 47550,96.32886715; 47580,96.32886715; 47610,96.32886715; 47640,96.03058605; 47670,96.03058605; 47700,96.03058605; 47730,
            96.03058605; 47760,96.03058605; 47790,96.0659523; 47820,96.0659523; 47850,96.0659523; 47880,96.68560638; 47910,96.68560638; 47940,
            96.68560638; 47970,96.68560638; 48000,96.68560638; 48030,96.25676479; 48060,96.25676479; 48090,96.25676479; 48120,96.25676479; 48150,
            96.25676479; 48180,96.30049152; 48210,96.30049152; 48240,96.30049152; 48270,96.30049152; 48300,96.30049152; 48330,96.07810707; 48360,
            96.07810707; 48390,96.07810707; 48420,96.07810707; 48450,96.07810707; 48480,96.48659649; 48510,96.48659649; 48540,96.48659649; 48570,
            96.48659649; 48600,96.48659649; 48630,96.2683651; 48660,96.2683651; 48690,96.2683651; 48720,96.2683651; 48750,96.2683651; 48780,
            96.13184681; 48810,96.13184681; 48840,96.13184681; 48870,96.13184681; 48900,96.13184681; 48930,96.4676033; 48960,96.4676033; 48990,
            96.4676033; 49020,96.4676033; 49050,96.4676033; 49080,96.2515028; 49110,96.2515028; 49140,96.2515028; 49170,96.2515028; 49200,
            96.2515028; 49230,96.20651493; 49260,96.20651493; 49290,96.20651493; 49320,96.20651493; 49350,96.20651493; 49380,95.62032452; 49410,
            94.44127922; 49440,92.70377769; 49470,90.98138809; 49500,89.1230401; 49530,86.89499903; 49560,85.23659592; 49590,83.07656393; 49620,
            81.5191824; 49650,79.68204002; 49680,78.2706027; 49710,77.86422243; 49740,77.86422243; 49770,77.22367258; 49800,77.22367258; 49830,
            77.77894335; 49860,79.30551939; 49890,81.10058212; 49920,82.30718765; 49950,83.84736986; 49980,85.34496145; 50010,86.45448647; 50040,
            87.54457254; 50070,88.3249403; 50100,88.3249403; 50130,88.94749174; 50160,88.09119473; 50190,88.09119473; 50220,86.99753723; 50250,
            86.99753723; 50280,86.99753723; 50310,86.52971992; 50340,86.52971992; 50370,86.52971992; 50400,87.8492898; 50430,88.77006798; 50460,
            90.21717052; 50490,91.42847271; 50520,92.82680397; 50550,93.6369009; 50580,94.12243938; 50610,94.6534441; 50640,94.6534441; 50670,
            94.6534441; 50700,95.32247829; 50730,95.32247829; 50760,95.32247829; 50790,95.32247829; 50820,95.32247829; 50850,95.08020916; 50880,
            95.08020916; 50910,95.08020916; 50940,95.08020916; 50970,95.67740192; 51000,95.67740192; 51030,95.67740192; 51060,95.67740192; 51090,
            95.67740192; 51120,95.75102634; 51150,95.75102634; 51180,95.75102634; 51210,95.75102634; 51240,95.75102634; 51270,95.66799774; 51300,
            95.66799774; 51330,95.66799774; 51360,95.66799774; 51390,95.66799774; 51420,95.85741863; 51450,95.85741863; 51480,95.85741863; 51510,
            95.85741863; 51540,95.85741863; 51570,95.9541132; 51600,95.9541132; 51630,95.9541132; 51660,95.9541132; 51690,95.9541132; 51720,
            96.15623245; 51750,96.15623245; 51780,96.15623245; 51810,96.15623245; 51840,96.15623245; 51870,96.06519127; 51900,96.06519127; 51930,
            96.06519127; 51960,96.06519127; 51990,96.06519127; 52020,95.89349155; 52050,95.89349155; 52080,95.89349155; 52110,95.89349155; 52140,
            95.89349155; 52170,96.05822239; 52200,96.05822239; 52230,96.05822239; 52260,96.05822239; 52290,96.05822239; 52320,96.08356476; 52350,
            96.08356476; 52380,96.08356476; 52410,96.08356476; 52440,96.08356476; 52470,96.11931152; 52500,96.11931152; 52530,96.11931152; 52560,
            96.11931152; 52590,96.11931152; 52620,96.04632854; 52650,96.04632854; 52680,96.04632854; 52710,96.04632854; 52740,96.04632854; 52770,
            96.15036163; 52800,96.15036163; 52830,96.15036163; 52860,96.15036163; 52890,96.15036163; 52920,96.22780209; 52950,96.22780209; 52980,
            96.22780209; 53010,96.22780209; 53040,96.22780209; 53070,96.23669529; 53100,96.23669529; 53130,96.23669529; 53160,96.23669529; 53190,
            96.23669529; 53220,96.51966877; 53250,96.51966877; 53280,96.51966877; 53310,96.51966877; 53340,96.03654385; 53370,96.03654385; 53400,
            96.03654385; 53430,96.03654385; 53460,96.64901161; 53490,96.64901161; 53520,96.64901161; 53550,96.64901161; 53580,95.96131039; 53610,
            96.50603542; 53640,96.50603542; 53670,95.70820198; 53700,95.70820198; 53730,95.70820198; 53760,95.1177063; 53790,95.1177063; 53820,
            95.1177063; 53850,95.1177063; 53880,95.92191067; 53910,95.92191067; 53940,95.92191067; 53970,95.92191067; 54000,95.92191067; 54030,
            96.22642136; 54060,96.22642136; 54090,96.22642136; 54120,96.22642136; 54150,96.22642136; 54180,96.57450657; 54210,96.57450657; 54240,
            96.57450657; 54270,96.57450657; 54300,96.57450657; 54330,96.38671646; 54360,96.38671646; 54390,96.38671646; 54420,96.38671646; 54450,
            95.34423294; 54480,95.34423294; 54510,95.34423294; 54540,95.34423294; 54570,94.60075893; 54600,94.60075893; 54630,95.71955223; 54660,
            96.30117645; 54690,96.30117645; 54720,96.30117645; 54750,96.30117645; 54780,96.30117645; 54810,95.95149307; 54840,95.95149307; 54870,
            95.95149307; 54900,95.95149307; 54930,95.95149307; 54960,95.68605595; 54990,95.68605595; 55020,96.32698631; 55050,96.32698631; 55080,
            95.66470356; 55110,95.66470356; 55140,95.66470356; 55170,96.19754562; 55200,96.19754562; 55230,96.19754562; 55260,96.19754562; 55290,
            96.19754562; 55320,96.15700436; 55350,96.15700436; 55380,96.15700436; 55410,96.15700436; 55440,96.15700436; 55470,96.02074699; 55500,
            96.02074699; 55530,96.02074699; 55560,96.02074699; 55590,96.02074699; 55620,96.01072311; 55650,96.01072311; 55680,96.01072311; 55710,
            96.01072311; 55740,96.01072311; 55770,96.06705036; 55800,96.06705036; 55830,96.06705036; 55860,96.67408218; 55890,96.67408218; 55920,
            96.67408218; 55950,96.67408218; 55980,96.04166451; 56010,96.04166451; 56040,96.04166451; 56070,96.04166451; 56100,96.04166451; 56130,
            95.74605789; 56160,95.74605789; 56190,95.74605789; 56220,95.74605789; 56250,95.74605789; 56280,95.93076038; 56310,95.93076038; 56340,
            95.93076038; 56370,95.93076038; 56400,95.93076038; 56430,96.00565681; 56460,96.00565681; 56490,96.00565681; 56520,96.00565681; 56550,
            96.00565681; 56580,95.94787273; 56610,95.94787273; 56640,95.94787273; 56670,95.94787273; 56700,95.94787273; 56730,96.08228188; 56760,
            96.08228188; 56790,96.08228188; 56820,96.08228188; 56850,96.08228188; 56880,96.01859436; 56910,96.01859436; 56940,96.01859436; 56970,
            96.01859436; 57000,96.01859436; 57030,95.96465893; 57060,95.96465893; 57090,95.96465893; 57120,95.96465893; 57150,95.96465893; 57180,
            96.04465427; 57210,96.04465427; 57240,96.04465427; 57270,96.04465427; 57300,96.04465427; 57330,95.79547062; 57360,95.79547062; 57390,
            95.79547062; 57420,95.79547062; 57450,96.36933231; 57480,96.36933231; 57510,96.36933231; 57540,96.36933231; 57570,96.20378609; 57600,
            96.20378609; 57630,96.20378609; 57660,96.20378609; 57690,96.20378609; 57720,96.4780077; 57750,96.4780077; 57780,96.4780077; 57810,
            95.96409359; 57840,95.96409359; 57870,95.96409359; 57900,95.96409359; 57930,95.96409359; 57960,95.66960678; 57990,95.10724754; 58020,
            94.34641113; 58050,93.52070217; 58080,92.03741798; 58110,90.9910532; 58140,90.36387033; 58170,88.85436859; 58200,88.85436859; 58230,
            88.85436859; 58260,87.52195358; 58290,86.60920429; 58320,86.60920429; 58350,87.54022379; 58380,88.62038927; 58410,89.28678703; 58440,
            89.28678703; 58470,88.83718557; 58500,88.83718557; 58530,88.83718557; 58560,88.83718557; 58590,87.88672171; 58620,87.13743668; 58650,
            87.13743668; 58680,87.85986814; 58710,88.55541344; 58740,88.55541344; 58770,88.55541344; 58800,88.55541344; 58830,90.03182116; 58860,
            90.90245819; 58890,90.90245819; 58920,90.90245819; 58950,90.90245819; 58980,92.02813339; 59010,93.29530621; 59040,93.29530621; 59070,
            93.29530621; 59100,93.29530621; 59130,93.29530621; 59160,93.00529861; 59190,91.66534939; 59220,89.92718468; 59250,88.92072515; 59280,
            88.46782408; 59310,88.46782408; 59340,87.67724218; 59370,86.57017422; 59400,85.70889788; 59430,85.70889788; 59460,86.55951977; 59490,
            87.39214869; 59520,87.39214869; 59550,87.39214869; 59580,88.16266108; 59610,89.01476698; 59640,89.59966908; 59670,89.59966908; 59700,
            91.16883574; 59730,93.97626686; 59760,95.76469231; 59790,95.76469231; 59820,95.76469231; 59850,96.42070198; 59880,96.42070198; 59910,
            96.42070198; 59940,96.42070198; 59970,96.42070198; 60000,96.2860754; 60030,96.2860754; 60060,96.2860754; 60090,95.67252045; 60120,
            95.67252045; 60150,95.67252045; 60180,95.67252045; 60210,95.67252045; 60240,95.60338612; 60270,95.60338612; 60300,95.60338612; 60330,
            96.09716549; 60360,96.09716549; 60390,96.09716549; 60420,96.09716549; 60450,96.09716549; 60480,95.78296795; 60510,95.78296795; 60540,
            95.78296795; 60570,95.78296795; 60600,95.78296795; 60630,95.96924686; 60660,95.96924686; 60690,95.96924686; 60720,95.96924686; 60750,
            95.96924686; 60780,96.13268394; 60810,96.13268394; 60840,96.13268394; 60870,96.13268394; 60900,96.13268394; 60930,96.12775898; 60960,
            96.12775898; 60990,96.12775898; 61020,96.12775898; 61050,96.20163345; 61080,96.20163345; 61110,96.20163345; 61140,96.20163345; 61170,
            96.20163345; 61200,96.55089283; 61230,96.55089283; 61260,96.55089283; 61290,96.55089283; 61320,96.55089283; 61350,95.89082794; 61380,
            95.89082794; 61410,95.89082794; 61440,95.89082794; 61470,95.89082794; 61500,95.94450245; 61530,95.94450245; 61560,96.44606609; 61590,
            96.44606609; 61620,96.44606609; 61650,96.44606609; 61680,96.44606609; 61710,96.27582321; 61740,96.27582321; 61770,96.27582321; 61800,
            96.27582321; 61830,96.27582321; 61860,96.0358263; 61890,96.0358263; 61920,96.0358263; 61950,96.0358263; 61980,96.0358263; 62010,
            95.97999916; 62040,95.97999916; 62070,95.97999916; 62100,95.97999916; 62130,95.97999916; 62160,95.52898979; 62190,95.52898979; 62220,
            95.52898979; 62250,95.52898979; 62280,95.52898979; 62310,95.47718525; 62340,95.47718525; 62370,95.47718525; 62400,95.47718525; 62430,
            95.47718525; 62460,95.4429388; 62490,95.4429388; 62520,95.4429388; 62550,95.4429388; 62580,95.4429388; 62610,95.87245445; 62640,
            95.87245445; 62670,95.87245445; 62700,95.87245445; 62730,95.87245445; 62760,96.2077652; 62790,96.2077652; 62820,96.2077652; 62850,
            96.2077652; 62880,96.2077652; 62910,96.47193031; 62940,96.47193031; 62970,95.85767956; 63000,95.85767956; 63030,96.4234417; 63060,
            96.4234417; 63090,96.4234417; 63120,96.4234417; 63150,96.4234417; 63180,96.53708553; 63210,96.53708553; 63240,96.53708553; 63270,
            95.97990131; 63300,95.97990131; 63330,95.97990131; 63360,96.56885319; 63390,96.56885319; 63420,96.56885319; 63450,96.56885319; 63480,
            96.56885319; 63510,96.45440483; 63540,96.45440483; 63570,96.45440483; 63600,96.45440483; 63630,96.45440483; 63660,95.81251774; 63690,
            96.87975655; 63720,96.26673431; 63750,96.26673431; 63780,96.26673431; 63810,96.26673431; 63840,96.26673431; 63870,96.75418625; 63900,
            96.75418625; 63930,96.75418625; 63960,96.75418625; 63990,96.75418625; 64020,96.33124809; 64050,96.33124809; 64080,96.33124809; 64110,
            96.33124809; 64140,96.33124809; 64170,94.85112762; 64200,93.4039381; 64230,92.69007912; 64260,92.69007912; 64290,92.69007912; 64320,
            92.0794487; 64350,90.65823212; 64380,90.65823212; 64410,90.65823212; 64440,91.30446796; 64470,91.30446796; 64500,90.42830801; 64530,
            90.42830801; 64560,89.77347794; 64590,89.77347794; 64620,89.77347794; 64650,87.5210186; 64680,85.37543535; 64710,84.1626709; 64740,
            83.28809824; 64770,82.2728651; 64800,79.22878017; 64830,77.31445284; 64860,76.64177113; 64890,76.10153074; 64920,76.10153074; 64950,
            75.44680395; 64980,74.49232292; 65010,73.98127356; 65040,75.00425835; 65070,75.93748484; 65100,75.93748484; 65130,75.93748484; 65160,
            75.93748484; 65190,75.93748484; 65220,75.709659; 65250,75.709659; 65280,74.70699921; 65310,74.2411932; 65340,73.66855459; 65370,
            73.66855459; 65400,73.66855459; 65430,72.44524441; 65460,71.65190105; 65490,71.65190105; 65520,71.65190105; 65550,72.786551; 65580,
            72.786551; 65610,72.786551; 65640,72.29506559; 65670,72.70078812; 65700,73.37560616; 65730,73.37560616; 65760,73.96313925; 65790,
            73.96313925; 65820,74.43716984; 65850,76.8034687; 65880,77.5544878; 65910,77.5544878; 65940,77.5544878; 65970,78.66097956; 66000,
            79.39130402; 66030,80.23348932; 66060,80.23348932; 66090,78.66101217; 66120,77.78660803; 66150,77.78660803; 66180,77.78660803; 66210,
            76.60369778; 66240,75.25953026; 66270,75.25953026; 66300,77.41723566; 66330,77.41723566; 66360,77.41723566; 66390,77.41723566; 66420,
            77.41723566; 66450,77.41723566; 66480,77.41723566; 66510,76.01457739; 66540,76.01457739; 66570,74.00381641; 66600,73.03797426; 66630,
            72.63617649; 66660,72.63617649; 66690,71.95662374; 66720,69.84208517; 66750,69.84208517; 66780,69.84208517; 66810,70.5203496; 66840,
            70.5203496; 66870,69.58148603; 66900,69.16313038; 66930,69.64089003; 66960,70.61740294; 66990,70.61740294; 67020,69.67314692; 67050,
            69.67314692; 67080,69.26120567; 67110,69.73978071; 67140,69.73978071; 67170,67.76533728; 67200,67.27669487; 67230,66.85493088; 67260,
            66.85493088; 67290,65.30022383; 67320,62.88650723; 67350,61.89761667; 67380,61.35481596; 67410,61.35481596; 67440,59.91040964; 67470,
            57.41564856; 67500,56.79463005; 67530,56.23316231; 67560,56.75382242; 67590,57.22336292; 67620,56.57420797; 67650,55.76692686; 67680,
            55.76692686; 67710,56.07625923; 67740,56.88760099; 67770,55.54465656; 67800,54.64053411; 67830,54.64053411; 67860,55.13110628; 67890,
            55.56467171; 67920,54.443155; 67950,53.48968506; 67980,53.11069107; 68010,53.11069107; 68040,53.40803719; 68070,52.32809458; 68100,
            51.16868935; 68130,50.76912031; 68160,51.3247879; 68190,52.17930193; 68220,51.88572836; 68250,51.12508221; 68280,50.81469526; 68310,
            51.69981909; 68340,52.86166506; 68370,52.86166506; 68400,52.28755875; 68430,51.74333925; 68460,52.8372468; 68490,54.43083172; 68520,
            54.43083172; 68550,53.41079865; 68580,52.40301819; 68610,52.40301819; 68640,52.40301819; 68670,51.04757652; 68700,49.0617013; 68730,
            47.47755318; 68760,47.47755318; 68790,47.47755318; 68820,47.08905172; 68850,46.06250095; 68880,45.37722144; 68910,46.12065468; 68940,
            47.4625989; 68970,47.4625989; 69000,47.08183823; 69030,46.61430359; 69060,47.24700937; 69090,48.64980898; 69120,48.98536434; 69150,
            48.98536434; 69180,47.8900815; 69210,48.91226177; 69240,50.06006126; 69270,50.63023739; 69300,49.84845629; 69330,48.97018719; 69360,
            49.6776372; 69390,50.65039387; 69420,50.65039387; 69450,49.20450897; 69480,48.62358055; 69510,48.90562449; 69540,50.04933071; 69570,
            50.40485229; 69600,49.59914217; 69630,48.772645; 69660,49.2577486; 69690,50.65841188; 69720,51.87295389; 69750,51.87295389; 69780,
            51.32773418; 69810,52.31922855; 69840,53.69945269; 69870,55.18962421; 69900,54.52520514; 69930,54.10506649; 69960,54.10506649; 69990,
            54.9843956; 70020,56.28661394; 70050,55.72049847; 70080,54.91105928; 70110,54.91105928; 70140,56.06395226; 70170,57.1924161; 70200,
            57.1924161; 70230,56.54273386; 70260,56.14468145; 70290,56.53619442; 70320,57.59975853; 70350,57.59975853; 70380,57.0650465; 70410,
            57.0650465; 70440,59.03162956; 70470,61.11512346; 70500,61.82837362; 70530,62.88030481; 70560,64.02020044; 70590,66.54458199; 70620,
            68.70389643; 70650,68.70389643; 70680,68.70389643; 70710,68.13183403; 70740,68.13183403; 70770,68.93782139; 70800,68.93782139; 70830,
            67.19391088; 70860,66.24032679; 70890,66.24032679; 70920,67.00460958; 70950,67.00460958; 70980,66.56478739; 71010,66.15272655; 71040,
            66.57125072; 71070,67.58290701; 71100,68.00046902; 71130,68.00046902; 71160,67.65469952; 71190,68.1845355; 71220,69.4123847; 71250,
            70.30006886; 71280,69.30276346; 71310,67.97381115; 71340,67.97381115; 71370,69.28548803; 71400,69.28548803; 71430,68.32517967; 71460,
            67.3482482; 71490,67.3482482; 71520,67.88173714; 71550,68.37114601; 71580,67.29187202; 71610,65.56722651; 71640,64.91284218; 71670,
            64.91284218; 71700,64.91284218; 71730,63.54490328; 71760,61.92518234; 71790,61.41489944; 71820,61.41489944; 71850,61.41489944; 71880,
            60.68984785; 71910,60.68984785; 71940,60.68984785; 71970,61.59954214; 72000,62.89126911; 72030,62.89126911; 72060,61.14531469; 72090,
            60.32054615; 72120,60.32054615; 72150,60.84226084; 72180,60.39948692; 72210,58.6223628; 72240,57.5842824; 72270,58.30432749; 72300,
            59.1577054; 72330,59.1577054; 72360,57.83732557; 72390,56.08292913; 72420,56.50878639; 72450,57.56006527; 72480,57.56006527; 72510,
            56.89360771; 72540,55.59877138; 72570,55.59877138; 72600,55.98542461; 72630,55.98542461; 72660,54.69175158; 72690,53.0159317; 72720,
            53.0159317; 72750,54.20331573; 72780,54.50442352; 72810,53.19056139; 72840,51.95067701; 72870,51.95067701; 72900,53.32348108; 72930,
            45.29904985; 72960,41.99735012; 72990,40.48362193; 73020,41.00060463; 73050,43.8005559; 73080,45.70728378; 73110,46.65857391; 73140,
            48.16467276; 73170,49.72854481; 73200,52.2048563; 73230,53.51516333; 73260,53.21080484; 73290,51.89734497; 73320,50.99396181; 73350,
            50.59122906; 73380,51.23199091; 73410,49.40332317; 73440,47.80383482; 73470,46.56284695; 73500,46.30574856; 73530,47.75516682; 73560,
            47.75516682; 73590,47.23961105; 73620,46.70437717; 73650,47.95599232; 73680,49.48031788; 73710,49.48031788; 73740,50.08610487; 73770,
            50.08610487; 73800,51.13543224; 73830,53.41726742; 73860,53.7510561; 73890,53.7510561; 73920,53.7510561; 73950,54.87269239; 73980,
            56.689575; 74010,57.60005207; 74040,57.60005207; 74070,55.60610447; 74100,55.08329172; 74130,55.61149149; 74160,55.61149149; 74190,
            55.61149149; 74220,53.77207146; 74250,53.77207146; 74280,54.58088551; 74310,55.46338377; 74340,55.46338377; 74370,55.46338377; 74400,
            55.46338377; 74430,57.36764374; 74460,59.80711584; 74490,60.16846476; 74520,58.86322947; 74550,57.84472933; 74580,57.84472933; 74610,
            57.84472933; 74640,57.84472933; 74670,56.58152475; 74700,55.33232317; 74730,54.74595337; 74760,55.2081336; 74790,55.63772535; 74820,
            55.305861; 74850,54.32200956; 74880,53.98244247; 74910,54.9086566; 74940,55.30064249; 74970,55.30064249; 75000,55.30064249; 75030,
            54.73167315; 75060,55.55150585; 75090,56.25993977; 75120,56.25993977; 75150,56.25993977; 75180,56.25993977; 75210,57.04153605; 75240,
            57.85547619; 75270,57.85547619; 75300,56.48739052; 75330,54.48583803; 75360,53.27960215; 75390,52.82069435; 75420,51.21494923; 75450,
            48.66336622; 75480,46.92568531; 75510,46.54140215; 75540,47.59289303; 75570,48.29121609; 75600,48.29121609; 75630,48.29121609; 75660,
            48.99075136; 75690,50.71177654; 75720,52.08210726; 75750,52.08210726; 75780,52.08210726; 75810,52.08210726; 75840,52.96111021; 75870,
            53.39058781; 75900,52.62854462; 75930,51.66153374; 75960,49.95576181; 75990,49.95576181; 76020,49.6252347; 76050,48.98672876; 76080,
            47.72857962; 76110,46.50002375; 76140,46.50002375; 76170,47.24598742; 76200,47.24598742; 76230,47.24598742; 76260,46.59293489; 76290,
            46.59293489; 76320,47.77940569; 76350,47.77940569; 76380,47.47641706; 76410,45.93169584; 76440,45.53641577; 76470,45.53641577; 76500,
            45.53641577; 76530,44.67682185; 76560,43.3057138; 76590,42.59405093; 76620,42.59405093; 76650,42.59405093; 76680,40.79292712; 76710,
            39.25498452; 76740,38.14697886; 76770,37.75362039; 76800,38.08647408; 76830,37.54728556; 76860,36.27030358; 76890,35.28769426; 76920,
            35.28769426; 76950,35.28769426; 76980,35.09748244; 77010,34.19350677; 77040,32.9727406; 77070,32.43120375; 77100,32.43120375; 77130,
            32.17283335; 77160,31.63088608; 77190,29.95238085; 77220,29.47437387; 77250,30.3412003; 77280,30.56646581; 77310,30.56646581; 77340,
            29.87263284; 77370,29.61010394; 77400,30.02729359; 77430,30.93957267; 77460,31.2134192; 77490,30.07673893; 77520,29.67254663; 77550,
            30.24966989; 77580,31.58210392; 77610,31.86067972; 77640,31.18890038; 77670,31.18890038; 77700,32.0578115; 77730,33.57110481; 77760,
            34.57432723; 77790,34.57432723; 77820,34.98436861; 77850,35.75830564; 77880,37.78371105; 77910,38.21747217; 77940,37.59948964; 77970,
            36.52654581; 78000,36.28468981; 78030,36.76484942; 78060,37.47471571; 78090,36.26299496; 78120,35.20934873; 78150,34.68648705; 78180,
            35.16654611; 78210,36.23744602; 78240,36.04960699; 78270,34.66277819; 78300,33.67522216; 78330,34.43404727; 78360,35.36753197; 78390,
            35.36753197; 78420,35.36753197; 78450,34.83521719; 78480,35.62022181; 78510,37.15555787; 78540,38.31691461; 78570,37.756178; 78600,
            36.8320703; 78630,36.8320703; 78660,37.58894391; 78690,38.70974035; 78720,38.92372899; 78750,38.48004456; 78780,38.48004456; 78810,
            38.75940042; 78840,40.17740436; 78870,40.17740436; 78900,38.65585928; 78930,38.45384059; 78960,38.45384059; 78990,39.63792229; 79020,
            39.85705061; 79050,39.53793626; 79080,39.17761202; 79110,39.77758799; 79140,41.79645667; 79170,42.22269444; 79200,42.22269444; 79230,
            40.85667443; 79260,40.43919396; 79290,42.73326273; 79320,42.73326273; 79350,41.92311416; 79380,40.31540666; 79410,39.97400765; 79440,
            39.97400765; 79470,39.97400765; 79500,39.97400765; 79530,38.57495613; 79560,38.00620694; 79590,38.32393241; 79620,39.76411228; 79650,
            39.76411228; 79680,38.96064992; 79710,38.96064992; 79740,39.74695101; 79770,41.2720376; 79800,41.80803523; 79830,40.7319603; 79860,
            40.15869384; 79890,40.15869384; 79920,42.47220969; 79950,43.18088279; 79980,41.99757571; 80010,41.46288271; 80040,41.46288271; 80070,
            41.92264123; 80100,42.72604923; 80130,42.47343822; 80160,41.38296347; 80190,40.5548192; 80220,40.5548192; 80250,41.11849937; 80280,
            40.36160674; 80310,39.24028029; 80340,38.71956582; 80370,39.02651453; 80400,40.26672778; 80430,40.26672778; 80460,39.82410336; 80490,
            38.49560494; 80520,38.90587192; 80550,40.21103382; 80580,40.21103382; 80610,38.89993315; 80640,37.1401062; 80670,36.85420275; 80700,
            36.85420275; 80730,36.09418445; 80760,34.10597448; 80790,32.09054132; 80820,31.47531481; 80850,31.47531481; 80880,31.47531481; 80910,
            30.68727694; 80940,29.63161941; 80970,29.63161941; 81000,29.9785522; 81030,31.35503097; 81060,31.35503097; 81090,31.13745189; 81120,
            30.62808223; 81150,30.62808223; 81180,31.89877481; 81210,31.89877481; 81240,30.87420816; 81270,30.35498314; 81300,30.0296093; 81330,
            30.74845033; 81360,31.05530119; 81390,31.05530119; 81420,30.58507304; 81450,30.58507304; 81480,32.4227726; 81510,33.40388703; 81540,
            33.80921273; 81570,33.80921273; 81600,35.34170852; 81630,37.60337634; 81660,39.48148398; 81690,39.81124735; 81720,39.81124735; 81750,
            39.81124735; 81780,41.47517338; 81810,42.93885012; 81840,43.18648453; 81870,41.65751667; 81900,40.10068688; 81930,40.10068688; 81960,
            40.10068688; 81990,40.10068688; 82020,39.06178293; 82050,37.36513252; 82080,36.56355915; 82110,36.56355915; 82140,37.91309738; 82170,
            37.91309738; 82200,37.39904194; 82230,37.11047215; 82260,37.5650013; 82290,38.94098268; 82320,38.94098268; 82350,38.94098268; 82380,
            38.28245072; 82410,38.28245072; 82440,39.89706731; 82470,39.89706731; 82500,39.08803582; 82530,38.58950272; 82560,38.58950272; 82590,
            40.27569165; 82620,40.60162268; 82650,40.60162268; 82680,40.60162268; 82710,41.0624249; 82740,42.26270299; 82770,42.76938729; 82800,
            41.69867492; 82830,40.41900759; 82860,39.46411343; 82890,39.46411343; 82920,39.88576055; 82950,39.56234908; 82980,38.47453794; 83010,
            37.96512208; 83040,39.46138186; 83070,40.72831278; 83100,41.28319488; 83130,41.28319488; 83160,41.84405379; 83190,43.60976787; 83220,
            44.99972506; 83250,45.3671432; 83280,44.67734914; 83310,43.51355166; 83340,43.05458951; 83370,43.28043938; 83400,43.50153279; 83430,
            41.97273073; 83460,40.10473394; 83490,39.88966355; 83520,39.88966355; 83550,39.88966355; 83580,38.80915289; 83610,37.12769051; 83640,
            36.85656195; 83670,36.85656195; 83700,37.76378832; 83730,37.76378832; 83760,37.76378832; 83790,37.76378832; 83820,38.86901622; 83850,
            39.95429964; 83880,40.25841079; 83910,39.2611815; 83940,38.7105041; 83970,38.7105041; 84000,40.39006391; 84030,40.74037786; 84060,
            39.39166045; 84090,38.50177474; 84120,38.50177474; 84150,39.59315457; 84180,40.45864649; 84210,40.45864649; 84240,40.45864649; 84270,
            40.91749449; 84300,42.66686268; 84330,44.2564549; 84360,44.2564549; 84390,43.79575596; 84420,43.28215985; 84450,44.13821225; 84480,
            44.68004537; 84510,44.68004537; 84540,44.15528111; 84570,43.7347538; 84600,44.79230847; 84630,46.07937412; 84660,46.07937412; 84690,
            45.75425577; 84720,44.76306853; 84750,44.51958175; 84780,45.03136225; 84810,45.03136225; 84840,44.2425416; 84870,42.84047041; 84900,
            42.58643246; 84930,43.4123208; 84960,43.95237093; 84990,43.95237093; 85020,42.31179771; 85050,42.31179771; 85080,43.42477455; 85110,
            44.06893659; 85140,44.06893659; 85170,43.81756496; 85200,43.81756496; 85230,44.67037482; 85260,45.50581412; 85290,45.80011883; 85320,
            45.23019547; 85350,45.23019547; 85380,46.86540613; 85410,48.04516354; 85440,48.32296743; 85470,47.54648638; 85500,46.26490288; 85530,
            46.26490288; 85560,46.26490288; 85590,46.26490288; 85620,44.14521918; 85650,43.28379064; 85680,42.79515367; 85710,42.79515367; 85740,
            43.17243805; 85770,42.348773; 85800,41.78349466; 85830,41.09069452; 85860,42.05586534; 85890,43.30917377; 85920,43.00719352; 85950,
            43.00719352; 85980,42.72119222; 86010,44.64907408; 86040,46.54596834; 86070,46.54596834; 86100,46.94846191; 86130,46.70325737; 86160,
            46.94327602; 86190,48.72751579; 86220,48.72751579; 86250,48.72751579; 86280,47.73531475; 86310,47.73531475; 86340,48.82256327; 86370,
            48.82256327; 86400,48.20220251; 86430,46.72663736; 86460,46.24312105; 86490,47.47978735; 86520,47.77940569; 86550,47.77940569; 86580,
            47.1414814; 86610,46.8296648; 86640,48.86743155; 86670,49.79615707; 86700,50.59220753; 86730,50.59220753; 86760,50.28699017; 86790,
            51.08101845; 86820,52.05702038; 86850,52.7322298; 86880,52.35762262; 86910,51.81048403; 86940,52.27964945; 86970,53.7883358; 87000,
            55.13379164; 87030,55.13379164; 87060,55.4170804; 87090,56.53555298; 87120,59.14128885; 87150,60.57567673; 87180,60.57567673; 87210,
            60.57567673; 87240,59.65960064; 87270,59.65960064; 87300,59.65960064; 87330,58.76072388; 87360,57.28436508; 87390,55.97272625; 87420,
            55.45906219; 87450,56.79421692; 87480,56.79421692; 87510,56.79421692; 87540,56.79421692; 87570,56.79421692; 87600,58.24578238; 87630,
            58.6899642; 87660,58.6899642; 87690,58.6899642; 87720,58.6899642; 87750,59.59723949; 87780,59.94538994; 87810,59.94538994; 87840,
            58.53723593; 87870,58.53723593; 87900,59.18544502; 87930,59.9232276; 87960,59.9232276; 87990,59.9232276; 88020,59.4467454; 88050,
            60.19288301; 88080,60.68962498; 88110,60.68962498; 88140,59.77689743; 88170,59.25762348; 88200,59.91412239; 88230,60.9311059; 88260,
            61.42863607; 88290,60.50734148; 88320,59.39939833; 88350,59.39939833; 88380,59.05840158; 88410,58.36314983; 88440,56.1852499; 88470,
            55.08424301; 88500,55.08424301; 88530,55.08424301; 88560,55.63494759; 88590,54.78078146; 88620,54.01353607; 88650,54.01353607; 88680,
            54.3531249; 88710,55.8244174; 88740,55.8244174; 88770,55.8244174; 88800,55.8244174; 88830,56.34991007; 88860,57.48246174; 88890,
            57.86650572; 88920,56.60182257; 88950,55.48426323; 88980,54.70707006; 89010,55.09899073; 89040,54.71127205; 89070,52.86905251; 89100,
            50.52206755; 89130,50.19623165; 89160,51.12838726; 89190,51.12838726; 89220,50.403901; 89250,49.23565149; 89280,49.23565149; 89310,
            50.42156782; 89340,50.88694983; 89370,50.88694983; 89400,49.80525141; 89430,49.274475; 89460,49.274475; 89490,49.65201216; 89520,
            48.76065874; 89550,46.78899851; 89580,45.34687529; 89610,45.34687529; 89640,45.34687529; 89670,44.5289968; 89700,42.62450581; 89730,
            41.7410943; 89760,41.52728505; 89790,43.41859932; 89820,43.41859932; 89850,43.19098277; 89880,42.59962006; 89910,42.59962006; 89940,
            44.59267073; 89970,45.68796988; 90000,46.02002449; 90030,46.02002449; 90060,46.02002449; 90090,46.44465866; 90120,46.93036566; 90150,
            45.9048749; 90180,44.87335024; 90210,44.40105371; 90240,44.76500101; 90270,45.70259256; 90300,45.70259256; 90330,45.42832203; 90360,
            45.42832203; 90390,46.94079723; 90420,48.89677477; 90450,49.67475071; 90480,49.67475071; 90510,49.67475071; 90540,50.35144958; 90570,
            50.91331415; 90600,51.31442156; 90630,50.42090464; 90660,48.70558176; 90690,48.70558176; 90720,49.54557638; 90750,50.34827499; 90780,
            50.34827499; 90810,49.98208265; 90840,50.46086426; 90870,52.75932255; 90900,54.70609159; 90930,54.70609159; 90960,54.24510727; 90990,
            53.63992367; 91020,53.63992367; 91050,54.52871132; 91080,54.14076977; 91110,53.38926687; 91140,53.38926687; 91170,53.38926687; 91200,
            54.9655057; 91230,55.45824137; 91260,55.45824137; 91290,55.45824137; 91320,57.03495312; 91350,59.7489295; 91380,60.78678703; 91410,
            60.78678703; 91440,59.92533674; 91470,59.92533674; 91500,60.45018797; 91530,61.15885563; 91560,61.15885563; 91590,60.72751894; 91620,
            60.10009146; 91650,60.71790819; 91680,62.18256884; 91710,62.80066824; 91740,62.80066824; 91770,64.03828039; 91800,66.73460083; 91830,
            68.58259878; 91860,68.58259878; 91890,67.91592379; 91920,66.6415864; 91950,66.6415864; 91980,66.6415864; 92010,65.54784737; 92040,
            63.56947918; 92070,61.51438808; 92100,61.51438808; 92130,61.51438808; 92160,62.01749554; 92190,62.01749554; 92220,61.57088928; 92250,
            61.57088928; 92280,62.6586216; 92310,63.56768532; 92340,63.24891071; 92370,61.98725538; 92400,60.85332842; 92430,60.85332842; 92460,
            60.85332842; 92490,60.19062166; 92520,59.27808981; 92550,58.36114397; 92580,58.36114397; 92610,59.05109024; 92640,59.05109024; 92670,
            59.05109024; 92700,58.51367111; 92730,59.17148008; 92760,61.09495068; 92790,61.09495068; 92820,60.57772064; 92850,59.31457586; 92880,
            58.6262332; 92910,58.6262332; 92940,58.6262332; 92970,57.64244699; 93000,55.49310751; 93030,55.10330687; 93060,55.10330687; 93090,
            55.73461561; 93120,55.33410072; 93150,53.67526817; 93180,53.04924316; 93210,53.04924316; 93240,54.49780798; 93270,54.49780798; 93300,
            53.79966974; 93330,53.79966974; 93360,54.07131472; 93390,55.8468461; 93420,56.33436327; 93450,55.03815165; 93480,54.04331417; 93510,
            53.22504702; 93540,53.22504702; 93570,52.60642033; 93600,49.75428944; 93630,47.66184797; 93660,46.02061701; 93690,45.60136986; 93720,
            45.14393792; 93750,44.09002805; 93780,42.53451376; 93810,42.18076973; 93840,43.24388809; 93870,44.14251752; 93900,44.14251752; 93930,
            44.14251752; 93960,44.14251752; 93990,45.55673532; 94020,47.30675583; 94050,47.58939772; 94080,47.58939772; 94110,46.82363634; 94140,
            47.56795292; 94170,48.64250307; 94200,48.64250307; 94230,48.39181366; 94260,47.20585384; 94290,47.20585384; 94320,48.40218544; 94350,
            48.40218544; 94380,48.40218544; 94410,48.69026871; 94440,50.11986752; 94470,52.725212; 94500,54.38313131; 94530,54.38313131; 94560,
            53.9039257; 94590,53.40113897; 94620,53.40113897; 94650,53.68861885; 94680,53.35369406; 94710,50.7177289; 94740,49.76357946; 94770,
            49.45589418; 94800,50.21533356; 94830,50.21533356; 94860,49.14544744; 94890,48.76275702; 94920,48.76275702; 94950,49.99095955; 94980,
            49.99095955; 95010,48.98794641; 95040,47.67697077; 95070,47.31121874; 95100,47.73447762; 95130,47.73447762; 95160,46.78899851; 95190,
            46.30341654; 95220,46.30341654; 95250,47.56970329; 95280,48.8716444; 95310,49.11897984; 95340,49.39611511; 95370,50.13956194; 95400,
            52.77162952; 95430,54.42996197; 95460,54.7151968; 95490,54.31693239; 95520,52.92093315; 95550,52.60069084; 95580,52.60069084; 95610,
            52.109624; 95640,50.46856155; 95670,49.11464739; 95700,49.11464739; 95730,50.62453508; 95760,51.10442562; 95790,51.10442562; 95820,
            51.10442562; 95850,51.74221945; 95880,52.58789463; 95910,53.15463524; 95940,52.44841919; 95970,50.59266958; 96000,50.59266958; 96030,
            50.24826994; 96060,50.57649765; 96090,50.22637396; 96120,49.6825078; 96150,49.6825078; 96180,50.52417126; 96210,52.51049223; 96240,
            52.51049223; 96270,52.77323313; 96300,52.77323313; 96330,53.2759655; 96360,55.56855841; 96390,56.22539978; 96420,56.22539978; 96450,
            56.22539978; 96480,56.62370768; 96510,58.30067453; 96540,59.05318851; 96570,58.64579172; 96600,56.71694498; 96630,55.97198696; 96660,
            55.97198696; 96690,56.77658272; 96720,56.24804049; 96750,54.57927103; 96780,54.22346678; 96810,55.33355169; 96840,56.86575394; 96870,
            56.86575394; 96900,57.29485645; 96930,57.29485645; 96960,58.43789406; 96990,59.30419321; 97020,59.30419321; 97050,58.36097546; 97080,
            57.03656759; 97110,57.03656759; 97140,57.03656759; 97170,57.03656759; 97200,55.59111214; 97230,54.1308383; 97260,53.6599823; 97290,
            53.6599823; 97320,53.6599823; 97350,53.6599823; 97380,53.0525156; 97410,53.0525156; 97440,53.73312836; 97470,55.31201992; 97500,
            55.31201992; 97530,55.31201992; 97560,55.78692026; 97590,57.56665907; 97620,59.36925602; 97650,59.36925602; 97680,58.4982439; 97710,
            56.97342367; 97740,56.97342367; 97770,56.97342367; 97800,56.97342367; 97830,55.03740692; 97860,52.86261091; 97890,52.27574644; 97920,
            52.27574644; 97950,52.27574644; 97980,51.49974375; 98010,49.80906744; 98040,49.80906744; 98070,50.43685913; 98100,51.03159485; 98130,
            51.03159485; 98160,50.47036085; 98190,50.47036085; 98220,50.47036085; 98250,51.62096529; 98280,51.62096529; 98310,50.63806515; 98340,
            50.63806515; 98370,51.0142705; 98400,52.25136623; 98430,52.25136623; 98460,51.69529638; 98490,51.10289812; 98520,51.40205441; 98550,
            51.73024406; 98580,51.09863091; 98610,50.04016571; 98640,50.04016571; 98670,50.04016571; 98700,50.59082136; 98730,49.92344513; 98760,
            48.84518223; 98790,46.89709225; 98820,46.54618034; 98850,48.57490168; 98880,48.57490168; 98910,48.96726809; 98940,48.96726809; 98970,
            48.96726809; 99000,50.69389772; 99030,51.72548761; 99060,52.20564451; 99090,51.02036963; 99120,50.43102093; 99150,50.43102093; 99180,
            50.43102093; 99210,50.43102093; 99240,50.14456844; 99270,49.60256681; 99300,50.08613205; 99330,51.61694269; 99360,51.61694269; 99390,
            51.13720436; 99420,50.47665567; 99450,50.22032375; 99480,50.22032375; 99510,49.45938406; 99540,47.39386683; 99570,45.96251764; 99600,
            45.39997087; 99630,45.39997087; 99660,45.73256092; 99690,44.67406311; 99720,43.69655271; 99750,43.30384655; 99780,45.56038013; 99810,
            45.56038013; 99840,44.7233644; 99870,42.65705624; 99900,41.64428015; 99930,42.24147019; 99960,43.17873287; 99990,43.17873287; 100020,
            41.90859747; 100050,41.06218572; 100080,41.64467425; 100110,42.9536386; 100140,43.36418281; 100170,43.36418281; 100200,42.47515054;
            100230,43.29194183; 100260,45.16967168; 100290,46.16848555; 100320,46.16848555; 100350,46.16848555; 100380,47.0467927; 100410,
            48.62896214; 100440,49.39091835; 100470,49.39091835; 100500,49.39091835; 100530,49.39091835; 100560,50.94858255; 100590,51.97510614;
            100620,51.97510614; 100650,51.97510614; 100680,51.23228989; 100710,51.70355358; 100740,52.08214531; 100770,50.89227705; 100800,
            49.14159336; 100830,47.78800535; 100860,48.45132637; 100890,49.16365242; 100920,49.16365242; 100950,48.63727913; 100980,47.83930435;
            101010,49.5568614; 101040,51.86950207; 101070,52.26625528; 101100,52.26625528; 101130,51.17159214; 101160,51.4477272; 101190,
            52.85878401; 101220,53.71648893; 101250,53.71648893; 101280,52.46450958; 101310,52.46450958; 101340,52.46450958; 101370,52.99082851;
            101400,52.99082851; 101430,51.91425619; 101460,51.91425619; 101490,52.52096729; 101520,54.23197947; 101550,54.23197947; 101580,
            54.23197947; 101610,55.05120335; 101640,56.32121372; 101670,58.35975237; 101700,58.35975237; 101730,57.22112875; 101760,57.22112875;
            101790,57.22112875; 101820,58.31311197; 101850,58.31311197; 101880,57.4696003; 101910,56.80886135; 101940,57.35463009; 101970,
            59.91889515; 102000,60.93282366; 102030,60.93282366; 102060,60.93282366; 102090,61.32320595; 102120,62.48327436; 102150,63.36887655;
            102180,63.36887655; 102210,61.28953571; 102240,61.28953571; 102270,61.28953571; 102300,61.95886345; 102330,61.95886345; 102360,
            60.31534939; 102390,59.59388552; 102420,60.1954977; 102450,61.83905525; 102480,61.83905525; 102510,61.83905525; 102540,61.08711748;
            102570,61.08711748; 102600,61.43545818; 102630,61.43545818; 102660,60.80318184; 102690,60.06671476; 102720,60.06671476; 102750,
            60.06671476; 102780,60.06671476; 102810,58.55947981; 102840,57.42637367; 102870,57.13550177; 102900,58.38124065; 102930,59.03989763;
            102960,58.68315296; 102990,57.38644667; 103020,56.85091925; 103050,57.84136992; 103080,58.35985565; 103110,57.87685575; 103140,
            56.40531321; 103170,55.35519218; 103200,55.35519218; 103230,55.99155636; 103260,55.99155636; 103290,54.38870859; 103320,53.10683155;
            103350,52.81838951; 103380,53.55220385; 103410,53.96858082; 103440,53.96858082; 103470,53.27522078; 103500,53.86559143; 103530,
            55.59093275; 103560,56.79457026; 103590,56.79457026; 103620,56.47688828; 103650,56.47688828; 103680,57.08165331; 103710,57.71649542;
            103740,57.23891516; 103770,55.82169943; 103800,55.82169943; 103830,55.82169943; 103860,56.80674677; 103890,56.80674677; 103920,
            56.80674677; 103950,56.80674677; 103980,58.77627068; 104010,59.94195986; 104040,59.51371078; 104070,57.91890821; 104100,57.45184107;
            104130,57.45184107; 104160,58.27797403; 104190,57.82663307; 104220,57.35389624; 104250,56.47933445; 104280,58.346418; 104310,
            61.50729418; 104340,62.38736258; 104370,63.24873676; 104400,64.21880264; 104430,66.76413975; 104460,69.50533934; 104490,70.6572484;
            104520,69.8444335; 104550,67.50722237; 104580,66.15556412; 104610,66.15556412; 104640,65.04911585; 104670,63.72176714; 104700,
            61.37566824; 104730,61.02267437; 104760,61.60739164; 104790,62.13216677; 104820,62.65016327; 104850,62.65016327; 104880,63.2276453;
            104910,65.08872757; 104940,66.11765385; 104970,66.11765385; 105000,64.57536793; 105030,63.9814476; 105060,63.9814476; 105090,
            64.7468339; 105120,64.7468339; 105150,63.02945623; 105180,61.9396637; 105210,61.9396637; 105240,63.44957857; 105270,63.44957857;
            105300,62.56772718; 105330,61.59592724; 105360,61.59592724; 105390,61.59592724; 105420,61.98867416; 105450,61.53179398; 105480,
            60.35581455; 105510,59.86472054; 105540,60.17039995; 105570,60.17039995; 105600,59.70557241; 105630,58.03691711; 105660,57.73724442;
            105690,57.73724442; 105720,58.58419161; 105750,58.21956482; 105780,57.16656818; 105810,57.16656818; 105840,58.46076851; 105870,
            59.6275938; 105900,59.98970919; 105930,59.20980349; 105960,59.20980349; 105990,60.89526129; 106020,63.1272706; 106050,63.1272706;
            106080,63.1272706; 106110,63.1272706; 106140,63.9615901; 106170,66.39477825; 106200,66.39477825; 106230,65.42743034; 106260,
            64.76809387; 106290,64.76809387; 106320,66.36839762; 106350,66.36839762; 106380,66.36839762; 106410,65.02636099; 106440,65.02636099;
            106470,66.40204611; 106500,66.40204611; 106530,65.51013823; 106560,64.46658382; 106590,63.78849335; 106620,64.51385479; 106650,
            64.51385479; 106680,64.84868174; 106710,64.2023263; 106740,64.2023263; 106770,65.45830107; 106800,66.12855291; 106830,66.12855291;
            106860,65.08112812; 106890,64.54412212; 106920,64.54412212; 106950,65.61768837; 106980,65.61768837; 107010,64.18755684; 107040,
            63.70146389; 107070,64.43806686; 107100,65.79985228; 107130,66.1753727; 107160,65.03755903; 107190,65.03755903; 107220,65.03755903;
            107250,66.81529741; 107280,67.33633804; 107310,66.86069841; 107340,66.38685265; 107370,66.38685265; 107400,67.64118576; 107430,
            68.03147564; 107460,68.03147564; 107490,68.03147564; 107520,68.50731096; 107550,69.45300207; 107580,70.49648581; 107610,69.48253555;
            107640,68.16319399; 107670,68.16319399; 107700,68.16319399; 107730,68.97052946; 107760,68.31379137; 107790,66.76141634; 107820,
            66.15024776; 107850,66.83444281; 107880,67.37670536; 107910,67.37670536; 107940,66.65974245; 107970,66.65974245; 108000,67.99906111;
            108030,69.15114956; 108060,69.15114956; 108090,69.15114956; 108120,68.75074883; 108150,69.10042677; 108180,70.37740059; 108210,
            70.37740059; 108240,69.44382076; 108270,68.66051216; 108300,70.07684727; 108330,71.5866643; 108360,72.30435019; 108390,72.30435019;
            108420,72.30435019; 108450,73.44445782; 108480,75.14037437; 108510,76.33167229; 108540,76.33167229; 108570,75.91412659; 108600,
            75.91412659; 108630,77.23000546; 108660,77.23000546; 108690,76.29879026; 108720,75.22311487; 108750,75.22311487; 108780,76.2076458;
            108810,77.13581686; 108840,77.13581686; 108870,76.42884521; 108900,76.42884521; 108930,78.0858676; 108960,79.14059286; 108990,
            79.14059286; 109020,79.14059286; 109050,79.14059286; 109080,79.14059286; 109110,80.603514; 109140,80.603514; 109170,79.6492341;
            109200,79.6492341; 109230,79.6492341; 109260,80.56517973; 109290,79.95197268; 109320,78.68171225; 109350,78.68171225; 109380,
            79.12785101; 109410,80.17143259; 109440,80.17143259; 109470,79.07719345; 109500,78.57959805; 109530,78.57959805; 109560,79.37917643;
            109590,79.37917643; 109620,78.09486952; 109650,77.32376461; 109680,77.32376461; 109710,78.06941843; 109740,78.06941843; 109770,
            76.76637926; 109800,75.9367238; 109830,75.35789909; 109860,75.78371286; 109890,75.78371286; 109920,73.10658131; 109950,71.39487333;
            109980,70.67050123; 110010,70.67050123; 110040,70.67050123; 110070,68.43763847; 110100,67.25517941; 110130,66.70387688; 110160,
            67.15251074; 110190,67.15251074; 110220,66.42461615; 110250,64.24130201; 110280,62.9786356; 110310,63.5747303; 110340,63.9309803;
            110370,63.17584076; 110400,61.66851339; 110430,61.25143518; 110460,61.89166431; 110490,62.55216951; 110520,62.10617208; 110550,
            60.63337383; 110580,59.92076511; 110610,60.66220064; 110640,61.26747665; 110670,61.26747665; 110700,60.7503336; 110730,60.7503336;
            110760,61.68522892; 110790,63.94147167; 110820,64.51233816; 110850,64.51233816; 110880,65.87204161; 110910,67.92353954; 110940,
            68.97657423; 110970,68.97657423; 111000,67.93664017; 111030,67.05794163; 111060,67.05794163; 111090,67.71703348; 111120,67.71703348;
            111150,66.5392765; 111180,65.80584269; 111210,65.80584269; 111240,67.45541782; 111270,68.17637615; 111300,68.17637615; 111330,
            67.54202871; 111360,68.36720495; 111390,70.2317771; 111420,71.45738668; 111450,71.45738668; 111480,71.45738668; 111510,71.45738668;
            111540,72.31709204; 111570,73.40136166; 111600,73.40136166; 111630,72.91475773; 111660,72.91475773; 111690,74.70950518; 111720,
            76.59282589; 111750,76.19736099; 111780,75.07357206; 111810,75.07357206; 111840,75.07357206; 111870,77.13179426; 111900,77.56163607;
            111930,77.56163607; 111960,78.26031246; 111990,79.46010132; 112020,80.84663115; 112050,80.84663115; 112080,79.48698206; 112110,
            78.5030056; 112140,78.5030056; 112170,78.5030056; 112200,78.5030056; 112230,76.16031504; 112260,74.8172945; 112290,74.8172945; 112320,
            74.8172945; 112350,75.72122669; 112380,75.00682955; 112410,73.48874989; 112440,73.48874989; 112470,73.48874989; 112500,74.36701899;
            112530,73.45646038; 112560,72.7434494; 112590,72.7434494; 112620,73.45548191; 112650,74.19118252; 112680,74.19118252; 112710,
            73.45102444; 112740,72.69953785; 112770,73.90377874; 112800,74.86628323; 112830,74.86628323; 112860,74.45020523; 112890,73.5713273;
            112920,73.5713273; 112950,74.16516609; 112980,74.58343477; 113010,74.12237434; 113040,73.68943949; 113070,73.68943949; 113100,
            75.13497105; 113130,75.13497105; 113160,74.49044752; 113190,74.49044752; 113220,74.49044752; 113250,75.40351753; 113280,75.40351753;
            113310,74.61441965; 113340,74.04879341; 113370,74.04879341; 113400,74.70262327; 113430,75.15899792; 113460,75.15899792; 113490,
            74.77808504; 113520,75.38806314; 113550,77.59673595; 113580,78.87923269; 113610,78.28612232; 113640,76.63277464; 113670,76.63277464;
            113700,76.63277464; 113730,76.63277464; 113760,76.04080582; 113790,76.54254885; 113820,75.80485325; 113850,76.60623093; 113880,
            78.13411703; 113910,78.13411703; 113940,78.13411703; 113970,78.13411703; 114000,80.68796682; 114030,82.39108601; 114060,82.39108601;
            114090,82.39108601; 114120,82.39108601; 114150,83.60372; 114180,84.49091492; 114210,83.99966326; 114240,82.30370865; 114270,
            82.30370865; 114300,82.30370865; 114330,84.21298599; 114360,84.21298599; 114390,83.59763718; 114420,82.59592323; 114450,82.59592323;
            114480,83.5183485; 114510,83.5183485; 114540,81.97153444; 114570,80.86664085; 114600,80.86664085; 114630,81.50752773; 114660,
            81.50752773; 114690,80.17539539; 114720,79.58198605; 114750,79.58198605; 114780,79.58198605; 114810,79.58198605; 114840,78.59363909;
            114870,77.57461166; 114900,77.57461166; 114930,78.86514816; 114960,79.88477354; 114990,79.3394125; 115020,78.69241562; 115050,
            78.27678881; 115080,78.27678881; 115110,79.10709658; 115140,78.50390797; 115170,77.74691477; 115200,77.74691477; 115230,77.74691477;
            115260,79.13397188; 115290,79.13397188; 115320,79.13397188; 115350,79.62499523; 115380,81.62031813; 115410,83.43249321; 115440,
            83.88240452; 115470,83.88240452; 115500,82.87477627; 115530,84.48964834; 115560,86.17791109; 115590,86.17791109; 115620,83.90605631;
            115650,83.1050374; 115680,83.1050374; 115710,83.1050374; 115740,81.89444189; 115770,79.0371686; 115800,77.46891518; 115830,
            77.46891518; 115860,78.71064234; 115890,78.71064234; 115920,76.91166029; 115950,75.6799407; 115980,75.29310265; 116010,76.44908323;
            116040,77.06709566; 116070,76.07337255; 116100,75.59391689; 116130,75.59391689; 116160,76.70203943; 116190,76.70203943; 116220,
            75.82004128; 116250,74.91222239; 116280,74.91222239; 116310,76.60508938; 116340,76.60508938; 116370,75.46179085; 116400,74.49421463;
            116430,74.49421463; 116460,75.52865295; 116490,76.57608318; 116520,76.05135155; 116550,74.96949549; 116580,74.96949549; 116610,
            74.96949549; 116640,76.03697891; 116670,75.64216633; 116700,74.56335983; 116730,74.56335983; 116760,75.16299334; 116790,76.98155565;
            116820,77.40210199; 116850,77.98324242; 116880,77.98324242; 116910,80.31936636; 116940,81.91230984; 116970,81.91230984; 117000,
            80.18202181; 117030,79.29080429; 117060,79.29080429; 117090,79.29080429; 117120,79.29080429; 117150,78.06100903; 117180,76.88140926;
            117210,76.88140926; 117240,77.60318298; 117270,78.00789442; 117300,77.08293056; 117330,75.74511766; 117360,75.74511766; 117390,
            76.82869692; 117420,76.82869692; 117450,76.82869692; 117480,75.85081415; 117510,75.20059376; 117540,75.82770052; 117570,76.61286278;
            117600,76.61286278; 117630,76.61286278; 117660,76.61286278; 117690,77.88737411; 117720,79.93309364; 117750,80.75551386; 117780,
            80.02608089; 117810,78.99549122; 117840,78.99549122; 117870,79.47739849; 117900,79.91670971; 117930,78.52679329; 117960,77.75176907;
            117990,77.75176907; 118020,78.69334517; 118050,79.73755188; 118080,79.28085108; 118110,78.81831207; 118140,78.81831207; 118170,
            79.73051777; 118200,80.87545252; 118230,80.18202181; 118260,79.69417305; 118290,79.69417305; 118320,79.69417305; 118350,80.57828035;
            118380,80.57828035; 118410,79.32433863; 118440,78.77141075; 118470,78.77141075; 118500,79.46466751; 118530,79.90014095; 118560,
            79.05492783; 118590,79.05492783; 118620,79.4998435; 118650,80.76208591; 118680,80.76208591; 118710,80.76208591; 118740,80.76208591;
            118770,81.57995081; 118800,83.62407217; 118830,84.38060331; 118860,84.38060331; 118890,85.09367409; 118920,86.16606073; 118950,
            88.26805315; 118980,88.79679651; 119010,88.18787298; 119040,86.8559907; 119070,86.8559907; 119100,86.8559907; 119130,86.8559907;
            119160,86.8559907; 119190,85.54719486; 119220,84.89569159; 119250,84.89569159; 119280,84.89569159; 119310,84.89569159; 119340,
            84.15272312; 119370,84.15272312; 119400,84.88187342; 119430,86.2530467; 119460,86.83043633; 119490,85.55459318; 119520,85.55459318;
            119550,85.55459318; 119580,87.13958931; 119610,87.13958931; 119640,86.09447479; 119670,85.07665415; 119700,85.07665415; 119730,
            85.95025377; 119760,86.56851082; 119790,86.56851082; 119820,86.56851082; 119850,86.56851082; 119880,88.19423304; 119910,89.34110842;
            119940,88.2069912; 119970,86.48279686; 120000,86.48279686; 120030,87.29535084; 120060,88.20271854; 120090,87.34867201; 120120,
            85.90495062; 120150,85.07540932; 120180,85.07540932; 120210,85.07540932; 120240,83.88205662; 120270,82.64207983; 120300,81.98827715;
            120330,81.98827715; 120360,83.33912544; 120390,83.33912544; 120420,81.88956041; 120450,81.88956041; 120480,83.00647831; 120510,
            84.53053751; 120540,84.53053751; 120570,84.04391184; 120600,84.04391184; 120630,84.04391184; 120660,84.91803331; 120690,84.34091549;
            120720,82.96745911; 120750,82.11400509; 120780,82.11400509; 120810,83.48784199; 120840,83.48784199; 120870,83.48784199; 120900,
            82.67878332; 120930,82.67878332; 120960,83.34622478; 120990,83.34622478; 121020,81.08822079; 121050,80.03012524; 121080,79.58561726;
            121110,80.1590169; 121140,80.1590169; 121170,79.62484303; 121200,78.79828062; 121230,78.79828062; 121260,81.45305958; 121290,
            82.48899822; 121320,82.48899822; 121350,82.48899822; 121380,82.48899822; 121410,84.52834139; 121440,85.46478052; 121470,85.46478052;
            121500,84.7132885; 121530,83.98976984; 121560,84.90190487; 121590,85.45456095; 121620,85.45456095; 121650,83.59763718; 121680,
            83.59763718; 121710,84.13688822; 121740,85.86543674; 121770,85.86543674; 121800,86.31817474; 121830,86.31817474; 121860,86.86200285;
            121890,88.53697472; 121920,88.53697472; 121950,87.27345486; 121980,86.20026913; 122010,86.20026913; 122040,86.20026913; 122070,
            86.67462044; 122100,85.9474597; 122130,85.29786987; 122160,85.29786987; 122190,86.79305334; 122220,87.58409185; 122250,87.58409185;
            122280,86.57000027; 122310,86.57000027; 122340,87.21688843; 122370,87.74430542; 122400,87.74430542; 122430,86.53367186; 122460,
            85.71687241; 122490,85.71687241; 122520,85.71687241; 122550,84.61400642; 122580,82.56303577; 122610,81.83172197; 122640,81.83172197;
            122670,83.56535854; 122700,84.1328167; 122730,83.36491899; 122760,82.29871302; 122790,82.29871302; 122820,83.19499683; 122850,
            83.87257633; 122880,83.2873807; 122910,82.32078295; 122940,82.32078295; 122970,83.724648; 123000,84.92548056; 123030,84.92548056;
            123060,83.44830637; 123090,82.81256189; 123120,82.81256189; 123150,82.81256189; 123180,83.74078732; 123210,83.74078732; 123240,
            83.31371241; 123270,84.08963356; 123300,85.50202761; 123330,87.44817696; 123360,87.44817696; 123390,87.44817696; 123420,88.28983498;
            123450,89.92402096; 123480,91.69045258; 123510,92.46492233; 123540,91.85371571; 123570,91.85371571; 123600,91.85371571; 123630,
            93.84092274; 123660,94.37578697; 123690,94.37578697; 123720,94.37578697; 123750,95.1364603; 123780,97.64100609; 123810,98.8221714;
            123840,98.8221714; 123870,98.8221714; 123900,99.34471779; 123930,99.34471779; 123960,99.34471779; 123990,98.1631937; 124020,
            96.34604473; 124050,95.53911152; 124080,95.53911152; 124110,96.8464016; 124140,96.8464016; 124170,96.8464016; 124200,96.22750854;
            124230,96.22750854; 124260,97.47214394; 124290,97.96088963; 124320,97.38273354; 124350,96.51530914; 124380,96.51530914; 124410,
            95.98949032; 124440,95.98949032; 124470,95.98949032; 124500,93.91236191; 124530,92.56361732; 124560,92.56361732; 124590,92.56361732;
            124620,92.56361732; 124650,91.99943161; 124680,91.99943161; 124710,91.99943161; 124740,93.49119587; 124770,94.35782661; 124800,
            93.84830475; 124830,92.90656013; 124860,92.37557716; 124890,92.37557716; 124920,92.37557716; 124950,91.60634766; 124980,90.07755919;
            125010,90.07755919; 125040,90.90186024; 125070,93.01366997; 125100,93.48007393; 125130,93.48007393; 125160,93.48007393; 125190,
            94.2328434; 125220,95.49304733; 125250,95.49304733; 125280,95.49304733; 125310,93.16874657; 125340,92.62845726; 125370,92.62845726;
            125400,92.62845726; 125430,93.11546345; 125460,92.20189877; 125490,92.20189877; 125520,92.20189877; 125550,93.7578289; 125580,
            94.40268402; 125610,94.40268402; 125640,94.40268402; 125670,95.01330357; 125700,95.88028221; 125730,95.88028221; 125760,95.10231171;
            125790,93.92803917; 125820,93.92803917; 125850,93.92803917; 125880,93.92803917; 125910,93.92803917; 125940,92.12598038; 125970,
            91.09279232; 126000,91.09279232; 126030,92.61711788; 126060,92.61711788; 126090,92.03905964; 126120,91.57213383; 126150,91.57213383;
            126180,91.57213383; 126210,91.57213383; 126240,90.56067324; 126270,88.46087694; 126300,87.94574518; 126330,87.94574518; 126360,
            87.94574518; 126390,86.88195276; 126420,84.76233702; 126450,84.00958929; 126480,84.00958929; 126510,85.12422409; 126540,85.12422409;
            126570,85.12422409; 126600,85.12422409; 126630,85.12422409; 126660,86.71369944; 126690,87.36876326; 126720,87.36876326; 126750,
            86.3832593; 126780,86.3832593; 126810,87.41926317; 126840,88.62404766; 126870,89.11208668; 126900,88.40924635; 126930,87.79768639;
            126960,87.79768639; 126990,87.79768639; 127020,87.35270004; 127050,84.95282335; 127080,83.94148779; 127110,83.94148779; 127140,
            83.52071314; 127170,84.24471016; 127200,83.81666765; 127230,83.81666765; 127260,84.30769644; 127290,86.25157356; 127320,87.40570049;
            127350,87.40570049; 127380,87.40570049; 127410,87.40570049; 127440,88.44450388; 127470,88.9430397; 127500,89.42890978; 127530,
            89.42890978; 127560,89.42890978; 127590,89.42890978; 127620,90.21783915; 127650,90.68116093; 127680,90.68116093; 127710,90.21295767;
            127740,90.21295767; 127770,90.21295767; 127800,91.10901318; 127830,90.33982172; 127860,89.3395483; 127890,89.3395483; 127920,
            90.20376549; 127950,91.18187113; 127980,91.18187113; 128010,91.18187113; 128040,91.18187113; 128070,90.61383677; 128100,90.61383677;
            128130,90.61383677; 128160,88.11118269; 128190,87.29856892; 128220,87.29856892; 128250,88.51717701; 128280,88.51717701; 128310,
            87.33377752; 128340,86.73678589; 128370,86.26517429; 128400,87.54026184; 128430,87.54026184; 128460,87.54026184; 128490,86.75102806;
            128520,86.75102806; 128550,86.75102806; 128580,87.9887435; 128610,87.9887435; 128640,87.9887435; 128670,87.9887435; 128700,
            88.98857117; 128730,90.90023489; 128760,91.5284832; 128790,91.5284832; 128820,92.2024641; 128850,92.84116573; 128880,93.92192917;
            128910,93.92192917; 128940,91.21746025; 128970,90.01105042; 129000,89.43982515; 129030,89.43982515; 129060,89.43982515; 129090,
            89.43982515; 129120,88.96422358; 129150,88.96422358; 129180,90.24802494; 129210,92.23641701; 129240,92.94947147; 129270,92.94947147;
            129300,92.94947147; 129330,93.77291908; 129360,95.37718563; 129390,96.26450558; 129420,95.62616272; 129450,93.86979847; 129480,
            93.86979847; 129510,93.86979847; 129540,93.86979847; 129570,93.0800211; 129600,91.80631428; 129630,91.80631428; 129660,91.33442001;
            129690,92.27589283; 129720,92.27589283; 129750,92.27589283; 129780,91.46237125; 129810,91.46237125; 129840,91.46237125; 129870,
            92.26170502; 129900,92.26170502; 129930,92.26170502; 129960,93.48840179; 129990,94.87872047; 130020,96.47382202; 130050,96.47382202;
            130080,95.15624714; 130110,95.15624714; 130140,95.15624714; 130170,96.06326694; 130200,96.06326694; 130230,94.77164326; 130260,
            93.95537109; 130290,93.95537109; 130320,93.95537109; 130350,93.95537109; 130380,93.95537109; 130410,92.60340843; 130440,92.60340843;
            130470,93.94621696; 130500,94.91269512; 130530,94.91269512; 130560,94.91269512; 130590,95.88526154; 130620,97.28134232; 130650,
            98.93293419; 130680,98.93293419; 130710,97.38304882; 130740,96.39126091; 130770,96.39126091; 130800,96.39126091; 130830,96.39126091;
            130860,93.19806805; 130890,92.54540691; 130920,92.54540691; 130950,93.26987686; 130980,93.81717854; 131010,94.30550022; 131040,
            94.30550022; 131070,94.30550022; 131100,95.26954308; 131130,95.26954308; 131160,95.26954308; 131190,93.86159019; 131220,93.86159019;
            131250,93.86159019; 131280,95.05258369; 131310,95.05258369; 131340,95.05258369; 131370,93.96831951; 131400,93.96831951; 131430,
            93.96831951; 131460,94.83527641; 131490,94.83527641; 131520,94.83527641; 131550,94.83527641; 131580,94.83527641; 131610,95.87544422;
            131640,95.87544422; 131670,95.87544422; 131700,95.37273903; 131730,95.37273903; 131760,96.22420349; 131790,96.96752529; 131820,
            96.96752529; 131850,96.96752529; 131880,96.96752529; 131910,98.08352451; 131940,98.99118576; 131970,98.99118576; 132000,97.80665016;
            132030,97.07911434; 132060,97.07911434; 132090,96.57601776; 132120,95.95690727; 132150,93.66050377; 132180,92.62641335; 132210,
            92.62641335; 132240,94.03967171; 132270,94.54518185; 132300,94.54518185; 132330,94.54518185; 132360,94.54518185; 132390,95.63801308;
            132420,96.69036827; 132450,96.69036827; 132480,96.69036827; 132510,95.89093666; 132540,95.89093666; 132570,95.89093666; 132600,
            95.89093666; 132630,94.24020367; 132660,93.53350925; 132690,93.53350925; 132720,95.36268253; 132750,96.58583508; 132780,96.58583508;
            132810,96.58583508; 132840,98.14212399; 132870,99.34194546; 132900,100.9421568; 132930,99.78947582; 132960,97.78858109; 132990,
            97.78858109; 133020,97.17935314; 133050,97.17935314; 133080,96.17885685; 133110,94.65918446; 133140,94.65918446; 133170,94.65918446;
            133200,96.54241276; 133230,97.84959412; 133260,97.84959412; 133290,97.84959412; 133320,97.84959412; 133350,97.84959412; 133380,
            97.74476738; 133410,96.72969189; 133440,94.3814621; 133470,93.11261501; 133500,93.11261501; 133530,93.11261501; 133560,93.95307713;
            133590,94.80709648; 133620,96.4035244; 133650,100.1035538; 133680,103.8135092; 133710,106.201367; 133740,106.201367; 133770,
            107.5158978; 133800,108.9006283; 133830,110.6437614; 133860,111.9535194; 133890,111.9535194; 133920,111.9535194; 133950,111.9535194;
            133980,111.9535194; 134010,113.4361078; 134040,113.4361078; 134070,113.4361078; 134100,113.4361078; 134130,113.4361078; 134160,
            113.9385086; 134190,113.9385086; 134220,114.7223173; 134250,114.7223173; 134280,114.7223173; 134310,113.9957273; 134340,113.9957273;
            134370,113.9957273; 134400,112.4160095; 134430,111.6486826; 134460,111.6486826; 134490,111.6486826; 134520,111.6486826; 134550,
            111.6486826; 134580,111.8768835; 134610,113.3360212; 134640,115.166597; 134670,116.5010668; 134700,116.5010668; 134730,116.5010668;
            134760,116.5010668; 134790,116.5010668; 134820,116.1491764; 134850,116.1491764; 134880,113.7556435; 134910,111.8054443; 134940,
            111.2415848; 134970,111.2415848; 135000,109.4019419; 135030,108.2500763; 135060,108.2500763; 135090,108.2500763; 135120,108.2500763;
            135150,109.2723272; 135180,109.2723272; 135210,108.4831804; 135240,107.5110271; 135270,107.5110271; 135300,107.5110271; 135330,
            106.2795794; 135360,103.6865038; 135390,101.9386087; 135420,101.1104101; 135450,101.1104101; 135480,101.1104101; 135510,99.45196896;
            135540,98.64775372; 135570,98.64775372; 135600,98.64775372; 135630,99.25413322; 135660,99.25413322; 135690,98.62408562; 135720,
            97.54749699; 135750,97.54749699; 135780,97.54749699; 135810,96.9578928; 135840,95.93239117; 135870,94.57878685; 135900,95.26459637;
            135930,97.49024563; 135960,99.62656059; 135990,100.5166855; 136020,101.0894491; 136050,102.6480864; 136080,104.5243132; 136110,
            106.4945492; 136140,106.4945492; 136170,106.4945492; 136200,106.4945492; 136230,105.837985; 136260,105.837985; 136290,106.6928741;
            136320,106.6928741; 136350,106.1331024; 136380,106.1331024; 136410,106.1331024; 136440,106.7678576; 136470,106.7678576; 136500,
            105.5417479; 136530,105.5417479; 136560,105.5417479; 136590,105.5417479; 136620,105.3887913; 136650,104.055463; 136680,104.055463;
            136710,103.3918648; 136740,103.3918648; 136770,103.3918648; 136800,102.7208736; 136830,101.1007015; 136860,101.1007015; 136890,
            100.5935171; 136920,100.5935171; 136950,99.46996193; 136980,98.8062767; 137010,98.8062767; 137040,98.8062767; 137070,98.8062767;
            137100,98.8062767; 137130,98.41811771; 137160,98.41811771; 137190,98.41811771; 137220,98.41811771; 137250,99.22535534; 137280,
            98.64910183; 137310,97.96680393; 137340,97.96680393; 137370,97.26171856; 137400,97.26171856; 137430,97.26171856; 137460,94.67959099;
            137490,94.67959099; 137520,94.67959099; 137550,96.03951187; 137580,96.03951187; 137610,96.03951187; 137640,95.55215778; 137670,
            95.55215778; 137700,95.55215778; 137730,95.55215778; 137760,94.52112236; 137790,93.8725708; 137820,93.8725708; 137850,93.8725708;
            137880,94.5318203; 137910,94.5318203; 137940,94.5318203; 137970,94.5318203; 138000,95.31212826; 138030,96.64227104; 138060,
            96.64227104; 138090,96.64227104; 138120,95.68225079; 138150,95.68225079; 138180,95.68225079; 138210,95.68225079; 138240,95.00512791;
            138270,95.00512791; 138300,94.0022398; 138330,94.0022398; 138360,94.74820347; 138390,95.35371323; 138420,95.35371323; 138450,
            96.46465702; 138480,98.09133053; 138510,99.4978157; 138540,99.4978157; 138570,99.4978157; 138600,97.89513645; 138630,97.20559788;
            138660,97.20559788; 138690,97.20559788; 138720,96.12189903; 138750,95.10637779; 138780,95.10637779; 138810,95.10637779; 138840,
            96.33790169; 138870,96.33790169; 138900,96.33790169; 138930,95.70832157; 138960,95.70832157; 138990,95.70832157; 139020,94.32009029;
            139050,91.36627464; 139080,90.584412; 139110,90.584412; 139140,90.584412; 139170,90.584412; 139200,89.72272253; 139230,88.31216583;
            139260,87.61949615; 139290,87.61949615; 139320,88.52413502; 139350,88.52413502; 139380,88.52413502; 139410,88.52413502; 139440,
            88.52413502; 139470,89.86125212; 139500,90.31862698; 139530,89.27696972; 139560,88.25901861; 139590,88.25901861; 139620,88.25901861;
            139650,89.68381205; 139680,89.68381205; 139710,90.51560383; 139740,91.36720963; 139770,92.75314693; 139800,94.07196121; 139830,
            94.07196121; 139860,92.92001953; 139890,91.78916931; 139920,91.18859539; 139950,90.62625246; 139980,90.62625246; 140010,88.62288437;
            140040,87.6747797; 140070,87.6747797; 140100,87.6747797; 140130,89.27175121; 140160,89.27175121; 140190,89.27175121; 140220,
            89.27175121; 140250,89.29467459; 140280,89.77746792; 140310,89.77746792; 140340,89.77746792; 140370,89.77746792; 140400,89.77746792;
            140430,91.35067348; 140460,92.41440067; 140490,92.41440067; 140520,93.05899487; 140550,94.35153179; 140580,96.47355022; 140610,
            96.47355022; 140640,95.44239521; 140670,91.56070747; 140700,87.88475389; 140730,81.28400717; 140760,71.43129416; 140790,62.59934807;
            140820,52.5024579; 140850,44.38120165; 140880,38.90113993]) annotation (Placement(transformation(extent={{-92,2},{-72,22}})));
      Modelica.Blocks.Continuous.SecondOrder secondOrder(D=130) annotation (Placement(transformation(extent={{-56,2},{-36,22}})));
    equation
      connect(timeTable.y, secondOrder.u) annotation (Line(points={{-71,12},{-58,12}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end CogenData;

    model GT_HRSG_ST_MEE "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{164,-12},{144,8}},
                      rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT FeedSource(
        use_T_in=false,
        p=861800,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        T=382.53,
        nPorts=1) annotation (Placement(transformation(extent={{140,-84},{120,-64}}, rotation=0)));
      Modelica.Fluid.Sources.Boundary_pT SteamSink(
        p=100000,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{120,66},{100,86}}, rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        Nominal_Flow=5.5,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=100000,
                                      k=-0.0003))
        annotation (Placement(transformation(extent={{116,-42},{36,38}})));
      GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{-38,-86},{-18,-66}})));
      SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                     SES(capacity=dataCapacity.SES_capacity, redeclare
          SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity CS(W_totalSetpoint(displayUnit="MW")=
            35000000))
        annotation (Placement(transformation(extent={{-82,-40},{-22,20}})));
      NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    equation
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, SteamSink.ports[1])
        annotation (Line(points={{76,38},{76,76},{100,76}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{116,-2},{144,-2}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Feed_port, FeedSource.ports[1])
        annotation (Line(points={{76,-42},{76,-74},{120,-74}},        color={0,127,255}));
      connect(elecLoad.portElec_a, SES.portElec_b)
        annotation (Line(points={{-38,-76},{-42,-76},{-42,-44},{-14,-44},{-14,-10},{-22,-10}}, color={0,127,255}));
      connect(SES.FlueGas_b, heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-22,8},{26,8},{26,-2},{36,-2}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                120,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE;

    model GT_HRSG_ST_MEE_up "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{30,-2},{10,18}},
                      rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        Nominal_Flow=5.5,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=100000,
                                      k=-0.0003))
        annotation (Placement(transformation(extent={{0,-32},{-80,48}})));
      GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                     SES(capacity=dataCapacity.SES_capacity, redeclare
          SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity CS(W_totalSetpoint(displayUnit="MW")=
            35000000))
        annotation (Placement(transformation(extent={{-172,-40},{-112,20}})));
      NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      TRANSFORM.Fluid.Machines.Turbine_SinglePhase_Stodola    turbine(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow_start=3,
        eta_mech=0.98,
        p_a_start=800000,
        p_b_start=400000,
        T_a_start=453.15,
        T_b_start=393.15,
        m_flow_nominal=3,
        p_inlet_nominal=700000,
        T_nominal=453.15) annotation (Placement(transformation(extent={{80,72},{100,52}})));
      Desalination.MEE.Multiple_Effect.MEE_PF8_FC
                              mEE_PF8_FC(
        redeclare Desalination.MEE.ControlSystems.CS_TemperatureControlSystem CS,
        data(
          m1=10,
          m2=10,
          m3=10,
          m4=10,
          m5=8,
          m6=8,
          m7=8,
          m8=8),
        effect8(Mm_start=25, sEE_Tube_Side(mstart=10)),
        effect7(Mm_start=25, sEE_Tube_Side(mstart=10)),
        effect6(Mm_start=25, sEE_Tube_Side(mstart=10)),
        effect5(sEE_Tube_Side(mstart=10)),
        effect4(sEE_Tube_Side(mstart=10)),
        effect3(sEE_Tube_Side(mstart=10)),
        CV6(dp_nominal(displayUnit="Pa")))
        annotation (Placement(transformation(extent={{140,-14},{180,26}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=false,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,26}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{168,-54},{188,-34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{218,-54},{198,-34}})));
      TRANSFORM.Fluid.Volumes.IdealCondenser condenser(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        V_liquid_start=2) annotation (Placement(transformation(extent={{118,-34},{98,-14}})));
      Electrical.Generator      generator1(J=1e4)
        annotation (Placement(transformation(extent={{148,52},{168,72}})));
      TRANSFORM.Electrical.Sensors.PowerSensor sensorW
        annotation (Placement(transformation(extent={{178,52},{198,72}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{118,72},{138,52}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{232,52},{212,72}})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(redeclare package Medium = Modelica.Media.Water.StandardWater, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10))
        annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=10) annotation (Placement(transformation(extent={{-16,46},{4,66}})));
    equation
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{0,8},{10,8}},      color={0,127,255}));
      connect(elecLoad.portElec_a, SES.portElec_b)
        annotation (Line(points={{-80,-90},{-90,-90},{-90,-10},{-112,-10}},                    color={238,46,47}));
      connect(SES.FlueGas_b, heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-112,8},{-80,8}},               color={0,127,255}));
      connect(Brine_Oulet.ports[1],mEE_PF8_FC. Saltwater_Reject_Oulet)
        annotation (Line(points={{198,-4},{184,-4},{184,-2},{180,-2}},   color={0,127,255}));
      connect(Brine_Source.ports[1],mEE_PF8_FC. Saltwater_Input) annotation (Line(points={{198,16},{184,16},{184,14},{180,14}},
                                                                                                                              color={0,127,255}));
      connect(mEE_PF8_FC.Condensate_Oulet,sensor_m_flow1. port_a) annotation (Line(points={{160,-13.6},{160,-44},{168,-44}},
                                                                                                                          color={0,127,255}));
      connect(sensor_m_flow1.port_b,Condensate_Out. ports[1]) annotation (Line(points={{188,-44},{198,-44}}, color={0,127,255}));
      connect(generator1.portElec,sensorW. port_a)
        annotation (Line(points={{168,62},{178,62}},
                                                   color={255,0,0}));
      connect(powerSensor.flange_b,generator1. shaft_a)
        annotation (Line(points={{138,62},{148,62}},
                                                  color={0,0,0}));
      connect(powerSensor.flange_a,turbine. shaft_b) annotation (Line(points={{118,62},{100,62}},
                                                                                                color={0,0,0}));
      connect(sinkElec.port,sensorW. port_b) annotation (Line(points={{212,62},{198,62}}, color={255,0,0}));
      connect(volume.port_b, condenser.port_b) annotation (Line(points={{36,-42},{108,-42},{108,-32}}, color={0,127,255}));
      connect(volume.port_a, heatRecoverySteamGenerator.Feed_port) annotation (Line(points={{24,-42},{-40,-42},{-40,-32}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, resistance.port_a)
        annotation (Line(points={{-40,48},{-40,56},{-13,56}}, color={0,127,255}));
      connect(resistance.port_b, turbine.port_a) annotation (Line(points={{1,56},{80,56}}, color={0,127,255}));
      connect(turbine.port_b, mEE_PF8_FC.Steam_Input) annotation (Line(points={{100,56},{118,56},{118,16},{140,16},{140,14}}, color={0,127,255}));
      connect(mEE_PF8_FC.Water_Outlet, condenser.port_a)
        annotation (Line(points={{140,-2},{114,-2},{114,-12},{115,-12},{115,-17}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE_up;

    model GT_HRSG_ST_MEE_upwomee "Test of HRSG"
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        redeclare package Medium = NHES.Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{30,-2},{10,18}},
                      rotation=0)));
      NHES.Systems.BalanceOfPlant.HRSG.HRSG heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=100, k=-0.0003))
        annotation (Placement(transformation(extent={{-2,-34},{-82,46}})));
      GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                     SES(capacity=dataCapacity.SES_capacity, redeclare
          SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity_stepInput30to40 CS)
        annotation (Placement(transformation(extent={{-172,-40},{-112,20}})));
      NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      TRANSFORM.Fluid.Machines.Turbine_SinglePhase_Stodola    turbine(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        h_a_start=3E6,
        h_b_start=2.4E6,
        m_flow_start=0,
        eta_mech=0.98,
        p_a_start=800000,
        p_b_start=200000,
        T_a_start=453.15,
        T_b_start=393.15,
        m_flow_nominal=7,
        p_inlet_nominal=900000,
        T_nominal=453.15) annotation (Placement(transformation(extent={{78,72},{98,52}})));
      TRANSFORM.Fluid.Volumes.IdealCondenser condenser(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        V_liquid_start=2) annotation (Placement(transformation(extent={{118,-34},{98,-14}})));
      Electrical.Generator      generator1(J=1e4)
        annotation (Placement(transformation(extent={{148,52},{168,72}})));
      TRANSFORM.Electrical.Sensors.PowerSensor sensorW
        annotation (Placement(transformation(extent={{178,52},{198,72}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{118,72},{138,52}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{232,52},{212,72}})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=200000,                                                                                          redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10))
        annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=5)  annotation (Placement(transformation(extent={{-16,46},{4,66}})));
    equation
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port, SinkExhaustGas.ports[1]) annotation (Line(points={{-2,6},{4,6},{4,8},{10,8}},
                                                                                                                                color={0,127,255}));
      connect(elecLoad.portElec_a, SES.portElec_b)
        annotation (Line(points={{-80,-90},{-90,-90},{-90,-10},{-112,-10}},                    color={238,46,47}));
      connect(SES.FlueGas_b, heatRecoverySteamGenerator.Gas_Inlet_Port)
        annotation (Line(points={{-112,8},{-98,8},{-98,6},{-82,6}},
                                                                  color={0,127,255}));
      connect(generator1.portElec,sensorW. port_a)
        annotation (Line(points={{168,62},{178,62}},
                                                   color={255,0,0}));
      connect(powerSensor.flange_b,generator1. shaft_a)
        annotation (Line(points={{138,62},{148,62}},
                                                  color={0,0,0}));
      connect(powerSensor.flange_a,turbine. shaft_b) annotation (Line(points={{118,62},{98,62}},color={0,0,0}));
      connect(sinkElec.port,sensorW. port_b) annotation (Line(points={{212,62},{198,62}}, color={255,0,0}));
      connect(volume.port_b, condenser.port_b) annotation (Line(points={{36,-42},{108,-42},{108,-32}}, color={0,127,255}));
      connect(volume.port_a, heatRecoverySteamGenerator.Feed_port) annotation (Line(points={{24,-42},{-42,-42},{-42,-34}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port, resistance.port_a)
        annotation (Line(points={{-42,46},{-42,56},{-13,56}}, color={0,127,255}));
      connect(resistance.port_b, turbine.port_a) annotation (Line(points={{1,56},{78,56}}, color={0,127,255}));
      connect(turbine.port_b, condenser.port_a)
        annotation (Line(points={{98,56},{110,56},{110,-8},{114,-8},{114,-12},{115,-12},{115,-17}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
        experiment(
          StopTime=2000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE_upwomee;

    model GT_HRSG_ST_MEE_upwoSEEHRSG "Test of HRSG"
      Desalination.MEE.Multiple_Effect.MEE_FC3
                              mEE_FC3_1(
        redeclare Desalination.MEE.ControlSystems.CS_TemperatureControlSystem3 CS,
        data(
          m1=15,
          m2=14,
          m3=13),
        CV2(dp_nominal=1000))
        annotation (Placement(transformation(extent={{140,-14},{180,26}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=false,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,26}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{168,-54},{188,-34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{218,-54},{198,-34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph condens(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1) annotation (Placement(transformation(extent={{84,-44},{104,-24}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h condens1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=9,
        h=2.47E6,
        nPorts=1) annotation (Placement(transformation(extent={{52,4},{72,24}})));
      Modelica.Blocks.Sources.TimeTable timeTable(
        table=[0,-8.604973855; 1,-8.604933317; 2,-8.604892811; 3,-8.604852337; 4,-8.604811894; 5,-8.604771483; 6,-8.604731103; 7,-8.604690755; 8,
            -8.604650438; 9,-8.604610154; 10,-8.604569901; 11,-8.604529679; 12,-8.60448949; 13,-8.604449331; 14,-8.604409205; 15,-8.60436911; 16,
            -8.604329046; 17,-8.604289015; 18,-8.604249014; 19,-8.604209045; 20,-8.604169108; 21,-8.604129202; 22,-8.604089328; 23,-8.604049485;
            24,-8.604009673; 25,-8.603969893; 26,-8.603930144; 27,-8.603890427; 28,-8.603850741; 29,-8.603811087; 30,-8.603771463; 31,-8.603731872;
            32,-8.603692311; 33,-8.603652782; 34,-8.603613284; 35,-8.603573818; 36,-8.603534383; 37,-8.603494979; 38,-8.603455606; 39,-8.603416264;
            40,-8.603376954; 41,-8.603337675; 42,-8.603298427; 43,-8.603259211; 44,-8.603220025; 45,-8.603180871; 46,-8.603141748; 47,-8.603102655;
            48,-8.603063594; 49,-8.603024568; 50,-8.6029856; 51,-8.602946661; 52,-8.602907751; 53,-8.602868869; 54,-8.602830015; 55,-8.60279119;
            56,-8.602752393; 57,-8.602713625; 58,-8.602674885; 59,-8.602636173; 60,-8.602597488; 61,-8.602558832; 62,-8.602520203; 63,-8.602481602;
            64,-8.602443027; 65,-8.602404481; 66,-8.602365961; 67,-8.602327469; 68,-8.602289005; 69,-8.602250568; 70,-8.602212159; 71,-8.602173778;
            72,-8.602135424; 73,-8.602097096; 74,-8.602058797; 75,-8.602020527; 76,-8.601982284; 77,-8.60194407; 78,-8.601905884; 79,-8.601867726;
            80,-8.601829597; 81,-8.601791496; 82,-8.601753423; 83,-8.601715379; 84,-8.601677364; 85,-8.601639377; 86,-8.601601418; 87,-8.601563488;
            88,-8.601525586; 89,-8.601487713; 90,-8.601449869; 91,-8.601412053; 92,-8.601374266; 93,-8.601336507; 94,-8.601298777; 95,-8.601261077;
            96,-8.601223405; 97,-8.601185763; 98,-8.601148149; 99,-8.601110565; 100,-8.601073009; 101,-8.601210925; 102,-8.602402196; 103,-8.605286484;
            104,-8.609956272; 105,-8.616222534; 106,-8.623861718; 107,-8.632637968; 108,-8.642362174; 109,-8.652877183; 110,-8.664043718; 111,-8.675759969;
            112,-8.687927967; 113,-8.700472095; 114,-8.713328567; 115,-8.726443409; 116,-8.739773788; 117,-8.753281505; 118,-8.766936239; 119,-8.780712486;
            120,-8.794589053; 121,-8.808548269; 122,-8.822574843; 123,-8.836657511; 124,-8.850786255; 125,-8.864949441; 126,-8.879142557; 127,-8.893361093;
            128,-8.907598916; 129,-8.921850761; 130,-8.936114304; 131,-8.950386402; 132,-8.964665004; 133,-8.978948006; 134,-8.993233346; 135,-9.007520148;
            136,-9.021807532; 137,-9.036094287; 138,-9.05037944; 139,-9.064662533; 140,-9.078942979; 141,-9.093220427; 142,-9.107494506; 143,-9.121764826;
            144,-9.136031126; 145,-9.15029323; 146,-9.164550957; 147,-9.17880416; 148,-9.193052707; 149,-9.207296565; 150,-9.221535663; 151,-9.235682456;
            152,-9.249019174; 153,-9.260787022; 154,-9.270781487; 155,-9.279135651; 156,-9.286085797; 157,-9.291860684; 158,-9.296656162; 159,-9.300635676;
            160,-9.30393527; 161,-9.306668224; 162,-9.308928876; 163,-9.310795925; 164,-9.312334981; 165,-9.313600699; 166,-9.314638711; 167,-9.315486984;
            168,-9.316177153; 169,-9.316735288; 170,-9.317184397; 171,-9.317539646; 172,-9.317820069; 173,-9.318038084; 174,-9.318201347; 175,-9.318317514;
            176,-9.318391334; 177,-9.318441506; 178,-9.318470193; 179,-9.318479139; 180,-9.318470089; 181,-9.318444788; 182,-9.318404979; 183,-9.318352409;
            184,-9.318288788; 185,-9.318217765; 186,-9.318144181; 187,-9.318068163; 188,-9.317989836; 189,-9.317909325; 190,-9.317826758; 191,-9.317742259;
            192,-9.317655954; 193,-9.31756797; 194,-9.317478431; 195,-9.317387465; 196,-9.317295196; 197,-9.31720175; 198,-9.317107254; 199,-9.317011833;
            200,-9.316915613; 201,-9.316820954; 202,-9.316726357; 203,-9.316631864; 204,-9.316537511; 205,-9.316443322; 206,-9.316349333; 207,-9.316255557;
            208,-9.316162009; 209,-9.316068696; 210,-9.315975638; 211,-9.315882855; 212,-9.315790349; 213,-9.315698122; 214,-9.315606177; 215,-9.315514515;
            216,-9.315423139; 217,-9.315332051; 218,-9.315241253; 219,-9.315150755; 220,-9.31506056; 221,-9.314970666; 222,-9.314881072; 223,-9.314791779;
            224,-9.314702784; 225,-9.314614086; 226,-9.314525685; 227,-9.31443758; 228,-9.31434977; 229,-9.314262253; 230,-9.314175029; 231,-9.314088097;
            232,-9.314001455; 233,-9.313915104; 234,-9.313829041; 235,-9.313743268; 236,-9.313657792; 237,-9.313572603; 238,-9.313487698; 239,-9.313403077;
            240,-9.313318738; 241,-9.313234681; 242,-9.313150904; 243,-9.313067406; 244,-9.312984185; 245,-9.312901241; 246,-9.312818572; 247,-9.312736177;
            248,-9.312654055; 249,-9.312572205; 250,-9.312490626; 251,-9.312409316; 252,-9.312328274; 253,-9.312247499; 254,-9.31216699; 255,-9.312086745;
            256,-9.312006764; 257,-9.311927045; 258,-9.311847587; 259,-9.311768389; 260,-9.311689449; 261,-9.311610767; 262,-9.311532342; 263,-9.311454171;
            264,-9.311376254; 265,-9.31129859; 266,-9.311221178; 267,-9.311144015; 268,-9.311067102; 269,-9.310990437; 270,-9.310914043; 271,-9.31083793;
            272,-9.310762053; 273,-9.310686413; 274,-9.310611009; 275,-9.310535838; 276,-9.310460901; 277,-9.310386196; 278,-9.310311723; 279,-9.310237481;
            280,-9.310163469; 281,-9.310089685; 282,-9.31001613; 283,-9.309942801; 284,-9.309869699; 285,-9.309796822; 286,-9.30972417; 287,-9.309651741;
            288,-9.309579535; 289,-9.30950755; 290,-9.309435786; 291,-9.309364242; 292,-9.309292917; 293,-9.309221811; 294,-9.309150921; 295,-9.309080248;
            296,-9.30900979; 297,-9.308939547; 298,-9.308869517; 299,-9.3087997; 300,-9.308730095; 301,-9.308660701; 302,-9.308591517; 303,-9.308522541;
            304,-9.308453775; 305,-9.308385215; 306,-9.308316862; 307,-9.308248714; 308,-9.308180771; 309,-9.308113031; 310,-9.308045495; 311,-9.30797816;
            312,-9.307911026; 313,-9.307844093; 314,-9.307777358; 315,-9.307710822; 316,-9.307644484; 317,-9.307578341; 318,-9.307512395; 319,-9.307446643;
            320,-9.307381085; 321,-9.30731572; 322,-9.307250546; 323,-9.307185564; 324,-9.307120772; 325,-9.30705617; 326,-9.306991755; 327,-9.306927529;
            328,-9.306863489; 329,-9.306799634; 330,-9.306735964; 331,-9.306672479; 332,-9.306609176; 333,-9.306546055; 334,-9.306483116; 335,-9.306420356;
            336,-9.306357777; 337,-9.306295375; 338,-9.306233152; 339,-9.306171104; 340,-9.306109242; 341,-9.306047549; 342,-9.305986022; 343,-9.30592466;
            344,-9.305863462; 345,-9.305802428; 346,-9.305741558; 347,-9.30568085; 348,-9.305620303; 349,-9.305559918; 350,-9.305499694; 351,-9.30543963;
            352,-9.305379725; 353,-9.305319979; 354,-9.305260391; 355,-9.305200961; 356,-9.305141687; 357,-9.30508257; 358,-9.305023608; 359,-9.304964802;
            360,-9.30490615; 361,-9.304847651; 362,-9.304789306; 363,-9.304731114; 364,-9.304673073; 365,-9.304615183; 366,-9.304557444; 367,-9.304499856;
            368,-9.304442416; 369,-9.304385126; 370,-9.304327983; 371,-9.304270988; 372,-9.30421414; 373,-9.304157438; 374,-9.304100882; 375,-9.304044471;
            376,-9.303988205; 377,-9.303932082; 378,-9.303876102; 379,-9.303820265; 380,-9.303764569; 381,-9.303709015; 382,-9.303653602; 383,-9.303598328;
            384,-9.303543194; 385,-9.303488199; 386,-9.303433342; 387,-9.303378622; 388,-9.303324039; 389,-9.303269593; 390,-9.303215282; 391,-9.303161106;
            392,-9.303107065; 393,-9.303053157; 394,-9.302999383; 395,-9.302945741; 396,-9.30289223; 397,-9.302838852; 398,-9.302785603; 399,-9.302732485;
            400,-9.302679496; 401,-9.302626636; 402,-9.302573904; 403,-9.3025213; 404,-9.302468822; 405,-9.302416471; 406,-9.302364245; 407,-9.302312145;
            408,-9.302260169; 409,-9.302208317; 410,-9.30215659; 411,-9.302104979; 412,-9.302053484; 413,-9.302002104; 414,-9.301950839; 415,-9.301899688;
            416,-9.301848652; 417,-9.301797729; 418,-9.301746919; 419,-9.301696222; 420,-9.301645638; 421,-9.301595165; 422,-9.301544804; 423,-9.301494555;
            424,-9.301444415; 425,-9.301394387; 426,-9.301344468; 427,-9.301294659; 428,-9.301244958; 429,-9.301195367; 430,-9.301145884; 431,-9.301096508;
            432,-9.30104724; 433,-9.300998079; 434,-9.300949024; 435,-9.300900076; 436,-9.300851234; 437,-9.300802496; 438,-9.300753864; 439,-9.300705336;
            440,-9.300656913; 441,-9.300608593; 442,-9.300560376; 443,-9.300512262; 444,-9.300464251; 445,-9.300416342; 446,-9.300368534; 447,-9.300320827;
            448,-9.300273221; 449,-9.300225716; 450,-9.300178311; 451,-9.300131005; 452,-9.300083798; 453,-9.30003669; 454,-9.29998968; 455,-9.299942768;
            456,-9.299895954; 457,-9.299849236; 458,-9.299802615; 459,-9.299756091; 460,-9.299709662; 461,-9.299663329; 462,-9.299617091; 463,-9.299570947;
            464,-9.299524897; 465,-9.299478941; 466,-9.299433079; 467,-9.299387309; 468,-9.299341632; 469,-9.299296046; 470,-9.299250553; 471,-9.299205151;
            472,-9.299159839; 473,-9.299114618; 474,-9.299069487; 475,-9.299024446; 476,-9.298979494; 477,-9.29893463; 478,-9.298889855; 479,-9.298845238;
            480,-9.298800767; 481,-9.298756373; 482,-9.298712055; 483,-9.298667814; 484,-9.29862365; 485,-9.298579561; 486,-9.298535548; 487,-9.298491612;
            488,-9.29844775; 489,-9.298403965; 490,-9.298360254; 491,-9.298316619; 492,-9.298273058; 493,-9.298229572; 494,-9.29818616; 495,-9.298142823;
            496,-9.29809956; 497,-9.298056371; 498,-9.298013256; 499,-9.297970214; 500,-9.297927246; 501,-9.29788435; 502,-9.297841528; 503,-9.297798779;
            504,-9.297756102; 505,-9.297713498; 506,-9.297670966; 507,-9.297628506; 508,-9.297586118; 509,-9.297543802; 510,-9.297501557; 511,-9.297459384;
            512,-9.297417282; 513,-9.297375251; 514,-9.29733329; 515,-9.297291401; 516,-9.297249581; 517,-9.297207832; 518,-9.297166153; 519,-9.297124544;
            520,-9.297083005; 521,-9.297041535; 522,-9.297000134; 523,-9.296958803; 524,-9.29691754; 525,-9.296876347; 526,-9.296835222; 527,-9.296794165;
            528,-9.296753176; 529,-9.296712256; 530,-9.296671403; 531,-9.296630618; 532,-9.296589901; 533,-9.296549251; 534,-9.296508667; 535,-9.296468151;
            536,-9.296427702; 537,-9.296387319; 538,-9.296347003; 539,-9.296306752; 540,-9.296266568; 541,-9.29622645; 542,-9.296186397; 543,-9.296146409;
            544,-9.296106487; 545,-9.29606663; 546,-9.296026838; 547,-9.295987111; 548,-9.295947448; 549,-9.295907849; 550,-9.295868315; 551,-9.295828844;
            552,-9.295789438; 553,-9.295750095; 554,-9.295710815; 555,-9.295671599; 556,-9.295632445; 557,-9.295593355; 558,-9.295554327; 559,-9.295515362;
            560,-9.295476459; 561,-9.295437618; 562,-9.295398839; 563,-9.295360122; 564,-9.295321466; 565,-9.295282872; 566,-9.295244339; 567,-9.295205867;
            568,-9.295167456; 569,-9.295129106; 570,-9.295090816; 571,-9.295052586; 572,-9.295014416; 573,-9.294976307; 574,-9.294938257; 575,-9.294900266;
            576,-9.294862335; 577,-9.294824463; 578,-9.29478665; 579,-9.294748896; 580,-9.294711201; 581,-9.294673564; 582,-9.294635985; 583,-9.294598464;
            584,-9.294561001; 585,-9.294523596; 586,-9.294486249; 587,-9.294448958; 588,-9.294411725; 589,-9.294374549; 590,-9.294337429; 591,-9.294300367;
            592,-9.29426336; 593,-9.29422641; 594,-9.294189516; 595,-9.294152677; 596,-9.294115895; 597,-9.294079168; 598,-9.294042496; 599,-9.294005879;
            600,-9.293969317; 601,-9.29393281; 602,-9.293896357; 603,-9.293859959; 604,-9.293823615; 605,-9.293787325; 606,-9.293751089; 607,-9.293714907;
            608,-9.293678778; 609,-9.293642702; 610,-9.293606679; 611,-9.293570709; 612,-9.293534792; 613,-9.293498928; 614,-9.293463116; 615,-9.293427356;
            616,-9.293391647; 617,-9.293355991; 618,-9.293320378; 619,-9.293284789; 620,-9.293249245; 621,-9.293213746; 622,-9.293178293; 623,-9.293142885;
            624,-9.293107521; 625,-9.293072203; 626,-9.293036929; 627,-9.2930017; 628,-9.292966516; 629,-9.292931376; 630,-9.292896281; 631,-9.29286123;
            632,-9.292826223; 633,-9.292791261; 634,-9.292756343; 635,-9.292721469; 636,-9.292686639; 637,-9.292651852; 638,-9.29261711; 639,-9.292582412;
            640,-9.292547757; 641,-9.292513146; 642,-9.292478578; 643,-9.292444054; 644,-9.292409573; 645,-9.292375136; 646,-9.292340741; 647,-9.29230639;
            648,-9.292272082; 649,-9.292237817; 650,-9.292203595; 651,-9.292169415; 652,-9.292135279; 653,-9.292101185; 654,-9.292067133; 655,-9.292033124;
            656,-9.291999158; 657,-9.291965234; 658,-9.291931352; 659,-9.291897512; 660,-9.291863715; 661,-9.291829959; 662,-9.291796246; 663,-9.291762574;
            664,-9.291728944; 665,-9.291695356; 666,-9.291661809; 667,-9.291628304; 668,-9.291594841; 669,-9.291561418; 670,-9.291528038; 671,-9.291494698;
            672,-9.2914614; 673,-9.291428142; 674,-9.291394926; 675,-9.29136175; 676,-9.291328616; 677,-9.291295522; 678,-9.291262469; 679,-9.291229456;
            680,-9.291196484; 681,-9.291163553; 682,-9.291130661; 683,-9.29109781; 684,-9.291065; 685,-9.291032229; 686,-9.290999499; 687,-9.290966808;
            688,-9.290934157; 689,-9.290901546; 690,-9.290868975; 691,-9.290836444; 692,-9.290803952; 693,-9.290771499; 694,-9.290739086; 695,-9.290706713;
            696,-9.290674378; 697,-9.290642083; 698,-9.290609827; 699,-9.29057761; 700,-9.290545432; 701,-9.290513292; 702,-9.290481192; 703,-9.29044913;
            704,-9.290417107; 705,-9.290385122; 706,-9.290353176; 707,-9.290321268; 708,-9.290289398; 709,-9.290257567; 710,-9.290225774; 711,-9.290194019;
            712,-9.290162301; 713,-9.290130622; 714,-9.290098981; 715,-9.290067377; 716,-9.290035811; 717,-9.290004283; 718,-9.289972792; 719,-9.289941339;
            720,-9.289909923; 721,-9.289878544; 722,-9.289847202; 723,-9.289815898; 724,-9.28978463; 725,-9.2897534; 726,-9.289722206; 727,-9.289691049;
            728,-9.289659929; 729,-9.289628846; 730,-9.289597799; 731,-9.289566788; 732,-9.289535814; 733,-9.289504877; 734,-9.289473975; 735,-9.28944311;
            736,-9.289412281; 737,-9.289381488; 738,-9.28935073; 739,-9.289320009; 740,-9.289289323; 741,-9.289258673; 742,-9.289228059; 743,-9.28919748;
            744,-9.289166937; 745,-9.289136429; 746,-9.289105956; 747,-9.289075519; 748,-9.289045116; 749,-9.289014749; 750,-9.288984417; 751,-9.288954119;
            752,-9.288923857; 753,-9.288893629; 754,-9.288863436; 755,-9.288833277; 756,-9.288803153; 757,-9.288773063; 758,-9.288742993; 759,-9.288712955;
            760,-9.288682949; 761,-9.288652975; 762,-9.288623033; 763,-9.288593123; 764,-9.288563245; 765,-9.288533399; 766,-9.288503584; 767,-9.288473801;
            768,-9.28844405; 769,-9.28841433; 770,-9.288384642; 771,-9.288354986; 772,-9.288325361; 773,-9.288295768; 774,-9.288266206; 775,-9.288236675;
            776,-9.288207176; 777,-9.288177708; 778,-9.288148272; 779,-9.288118867; 780,-9.288089492; 781,-9.28806015; 782,-9.288030838; 783,-9.288001557;
            784,-9.287972307; 785,-9.287943089; 786,-9.287913901; 787,-9.287884744; 788,-9.287855619; 789,-9.287826524; 790,-9.287797459; 791,-9.287768426;
            792,-9.287739423; 793,-9.287710451; 794,-9.28768151; 795,-9.287652599; 796,-9.287623719; 797,-9.28759487; 798,-9.28756605; 799,-9.287537262;
            800,-9.287508504; 801,-9.287479776; 802,-9.287451078; 803,-9.287422411; 804,-9.287393774; 805,-9.287365167; 806,-9.28733659; 807,-9.287308044;
            808,-9.287279527; 809,-9.287251041; 810,-9.287222585; 811,-9.287194158; 812,-9.287165762; 813,-9.287137395; 814,-9.287109059; 815,-9.287080752;
            816,-9.287052475; 817,-9.287024227; 818,-9.28699601; 819,-9.286967822; 820,-9.286939663; 821,-9.286911534; 822,-9.286883435; 823,-9.286855365;
            824,-9.286827325; 825,-9.286799314; 826,-9.286771332; 827,-9.28674338; 828,-9.286715457; 829,-9.286687563; 830,-9.286659699; 831,-9.286631864;
            832,-9.286604058; 833,-9.286576281; 834,-9.286548533; 835,-9.286520814; 836,-9.286493123; 837,-9.286465462; 838,-9.28643783; 839,-9.286410227;
            840,-9.286382652; 841,-9.286355107; 842,-9.28632759; 843,-9.286300101; 844,-9.286272642; 845,-9.286245211; 846,-9.286217808; 847,-9.286190434;
            848,-9.286163089; 849,-9.286135772; 850,-9.286108483; 851,-9.286081223; 852,-9.286053991; 853,-9.286026788; 854,-9.285999613; 855,-9.285972465;
            856,-9.285945347; 857,-9.285918256; 858,-9.285891193; 859,-9.285864159; 860,-9.285837152; 861,-9.285810173; 862,-9.285783223; 863,-9.2857563;
            864,-9.285729405; 865,-9.285702538; 866,-9.285675699; 867,-9.285648887; 868,-9.285622103; 869,-9.285595347; 870,-9.285568619; 871,-9.285541918;
            872,-9.285515244; 873,-9.285488598; 874,-9.28546198; 875,-9.285435389; 876,-9.285408825; 877,-9.285382289; 878,-9.28535578; 879,-9.285329298;
            880,-9.285302843; 881,-9.285276416; 882,-9.285250016; 883,-9.285223642; 884,-9.285197296; 885,-9.285170977; 886,-9.285144685; 887,-9.28511842;
            888,-9.285092182; 889,-9.28506597; 890,-9.285039786; 891,-9.285013628; 892,-9.284987497; 893,-9.284961393; 894,-9.284935315; 895,-9.284909264;
            896,-9.28488324; 897,-9.284857264; 898,-9.28483132; 899,-9.2848054; 900,-9.284779505; 901,-9.284753635; 902,-9.28472779; 903,-9.28470197;
            904,-9.284676175; 905,-9.284650404; 906,-9.284624658; 907,-9.284598937; 908,-9.284573241; 909,-9.284547569; 910,-9.284521922; 911,-9.2844963;
            912,-9.284470702; 913,-9.284445129; 914,-9.284419581; 915,-9.284394057; 916,-9.284368558; 917,-9.284343083; 918,-9.284317633; 919,-9.284292207;
            920,-9.284266806; 921,-9.284241429; 922,-9.284216077; 923,-9.284190749; 924,-9.284165446; 925,-9.284140167; 926,-9.284114912; 927,-9.284089682;
            928,-9.284064476; 929,-9.284039294; 930,-9.284014137; 931,-9.283989004; 932,-9.283963895; 933,-9.28393881; 934,-9.28391375; 935,-9.283888713;
            936,-9.283863701; 937,-9.283838713; 938,-9.28381375; 939,-9.28378881; 940,-9.283763894; 941,-9.283739003; 942,-9.283714135; 943,-9.283689292;
            944,-9.283664472; 945,-9.283639677; 946,-9.283614905; 947,-9.283590158; 948,-9.283565434; 949,-9.283540734; 950,-9.283516058; 951,-9.283491406;
            952,-9.283466778; 953,-9.283442174; 954,-9.283417593; 955,-9.283393037; 956,-9.283368504; 957,-9.283343994; 958,-9.283319509; 959,-9.283295047;
            960,-9.283270609; 961,-9.283246195; 962,-9.283221804; 963,-9.283197437; 964,-9.283173093; 965,-9.283148773; 966,-9.283124477; 967,-9.283100204;
            968,-9.283075955; 969,-9.283051729; 970,-9.283027527; 971,-9.283003348; 972,-9.282979192; 973,-9.28295506; 974,-9.282930952; 975,-9.282906867;
            976,-9.282882805; 977,-9.282858766; 978,-9.282834751; 979,-9.282810759; 980,-9.282786791; 981,-9.282762846; 982,-9.282738924; 983,-9.282715025;
            984,-9.282691149; 985,-9.282667297; 986,-9.282643467; 987,-9.282619661; 988,-9.282595878; 989,-9.282572118; 990,-9.282548382; 991,-9.282524668;
            992,-9.282500977; 993,-9.28247731; 994,-9.282453665; 995,-9.282430043; 996,-9.282406445; 997,-9.282382869; 998,-9.282359316; 999,-9.282335786;
            1000,-9.282312279; 1001,-9.282288795; 1002,-9.282265334; 1003,-9.282241895; 1004,-9.28221848; 1005,-9.282195087; 1006,-9.282171717;
            1007,-9.282148369; 1008,-9.282125044; 1009,-9.282101743; 1010,-9.282078463; 1011,-9.282055207; 1012,-9.282031973; 1013,-9.282008761;
            1014,-9.281985573; 1015,-9.281962407; 1016,-9.281939263; 1017,-9.281916142; 1018,-9.281893043; 1019,-9.281869967; 1020,-9.281846914;
            1021,-9.281823883; 1022,-9.281800874; 1023,-9.281777888; 1024,-9.281754924; 1025,-9.281731983; 1026,-9.281709064; 1027,-9.281686167;
            1028,-9.281663293; 1029,-9.281640441; 1030,-9.281617611; 1031,-9.281594804; 1032,-9.281572018; 1033,-9.281549255; 1034,-9.281526515;
            1035,-9.281503796; 1036,-9.2814811; 1037,-9.281458425; 1038,-9.281435773; 1039,-9.281413143; 1040,-9.281390535; 1041,-9.281367949;
            1042,-9.281345385; 1043,-9.281322843; 1044,-9.281300323; 1045,-9.281277826; 1046,-9.28125535; 1047,-9.281232896; 1048,-9.281210464;
            1049,-9.281188054; 1050,-9.281165665; 1051,-9.281143299; 1052,-9.281120954; 1053,-9.281098632; 1054,-9.281076331; 1055,-9.281054052;
            1056,-9.281031794; 1057,-9.281009559; 1058,-9.280987345; 1059,-9.280965153; 1060,-9.280942982; 1061,-9.280920833; 1062,-9.280898706;
            1063,-9.280876601; 1064,-9.280854517; 1065,-9.280832454; 1066,-9.280810413; 1067,-9.280788394; 1068,-9.280766396; 1069,-9.28074442;
            1070,-9.280722465; 1071,-9.280700532; 1072,-9.28067862; 1073,-9.28065673; 1074,-9.280634861; 1075,-9.280613013; 1076,-9.280591187;
            1077,-9.280569382; 1078,-9.280547599; 1079,-9.280525836; 1080,-9.280504095; 1081,-9.280482376; 1082,-9.280460677; 1083,-9.280439;
            1084,-9.280417344; 1085,-9.280395709; 1086,-9.280374095; 1087,-9.280352503; 1088,-9.280330931; 1089,-9.280309381; 1090,-9.280287851;
            1091,-9.280266343; 1092,-9.280244856; 1093,-9.28022339; 1094,-9.280201945; 1095,-9.280180521; 1096,-9.280159118; 1097,-9.280137735;
            1098,-9.280116374; 1099,-9.280095034; 1100,-9.280073714; 1101,-9.280052416; 1102,-9.280031138; 1103,-9.280009881; 1104,-9.279988645;
            1105,-9.279967429; 1106,-9.279946235; 1107,-9.279925061; 1108,-9.279903907; 1109,-9.279882775; 1110,-9.279861663; 1111,-9.279840572;
            1112,-9.279819502; 1113,-9.279798452; 1114,-9.279777423; 1115,-9.279756414; 1116,-9.279735426; 1117,-9.279714458; 1118,-9.279693511;
            1119,-9.279672585; 1120,-9.279651679; 1121,-9.279630793; 1122,-9.279609928; 1123,-9.279589083; 1124,-9.279568259; 1125,-9.279547455;
            1126,-9.279526672; 1127,-9.279505908; 1128,-9.279485165; 1129,-9.279464443; 1130,-9.279443741; 1131,-9.279423059; 1132,-9.279402397;
            1133,-9.279381755; 1134,-9.279361134; 1135,-9.279340533; 1136,-9.279319952; 1137,-9.279299391; 1138,-9.27927885; 1139,-9.279258329;
            1140,-9.279237829; 1141,-9.279217348; 1142,-9.279196888; 1143,-9.279176447; 1144,-9.279156027; 1145,-9.279135626; 1146,-9.279115246;
            1147,-9.279094885; 1148,-9.279074545; 1149,-9.279054224; 1150,-9.279033923; 1151,-9.279013642; 1152,-9.278993381; 1153,-9.27897314;
            1154,-9.278952918; 1155,-9.278932717; 1156,-9.278912535; 1157,-9.278892372; 1158,-9.27887223; 1159,-9.278852107; 1160,-9.278832004;
            1161,-9.278811921; 1162,-9.278791857; 1163,-9.278771813; 1164,-9.278751788; 1165,-9.278731783; 1166,-9.278711798; 1167,-9.278691832;
            1168,-9.278671885; 1169,-9.278651959; 1170,-9.278632051; 1171,-9.278612163; 1172,-9.278592295; 1173,-9.278572446; 1174,-9.278552616;
            1175,-9.278532803; 1176,-9.278513004; 1177,-9.278493223; 1178,-9.278473461; 1179,-9.278453717; 1180,-9.278433992; 1181,-9.278414286;
            1182,-9.278394598; 1183,-9.278374929; 1184,-9.278355278; 1185,-9.278335646; 1186,-9.278316032; 1187,-9.278296437; 1188,-9.27827686;
            1189,-9.278257302; 1190,-9.278237762; 1191,-9.278218241; 1192,-9.278198738; 1193,-9.278179254; 1194,-9.278159788; 1195,-9.27814034;
            1196,-9.278120911; 1197,-9.2781015; 1198,-9.278082107; 1199,-9.278062733; 1200,-9.278043377; 1201,-9.27802404; 1202,-9.27800472; 1203,
            -9.277985419; 1204,-9.277966137; 1205,-9.277946872; 1206,-9.277927626; 1207,-9.277908398; 1208,-9.277889188; 1209,-9.277869996; 1210,
            -9.277850823; 1211,-9.277831668; 1212,-9.27781253; 1213,-9.277793411; 1214,-9.277774311; 1215,-9.277755228; 1216,-9.277736163; 1217,-9.277717117;
            1218,-9.277698088; 1219,-9.277679078; 1220,-9.277660085; 1221,-9.277641111; 1222,-9.277622154; 1223,-9.277603216; 1224,-9.277584296;
            1225,-9.277565393; 1226,-9.277546509; 1227,-9.277527642; 1228,-9.277508794; 1229,-9.277489963; 1230,-9.27747115; 1231,-9.277452355;
            1232,-9.277433578; 1233,-9.277414819; 1234,-9.277396078; 1235,-9.277377354; 1236,-9.277358649; 1237,-9.277339961; 1238,-9.277321291;
            1239,-9.277302638; 1240,-9.277284004; 1241,-9.277265387; 1242,-9.277246788; 1243,-9.277228206; 1244,-9.277209643; 1245,-9.277191097;
            1246,-9.277172568; 1247,-9.277154058; 1248,-9.277135565; 1249,-9.277117089; 1250,-9.277098632; 1251,-9.277080191; 1252,-9.277061769;
            1253,-9.277043364; 1254,-9.277024977; 1255,-9.277006607; 1256,-9.276988254; 1257,-9.276969919; 1258,-9.276951602; 1259,-9.276933302;
            1260,-9.27691502; 1261,-9.276896755; 1262,-9.276878508; 1263,-9.276860278; 1264,-9.276842065; 1265,-9.27682387; 1266,-9.276805692;
            1267,-9.276787532; 1268,-9.276769389; 1269,-9.276751263; 1270,-9.276733155; 1271,-9.276715064; 1272,-9.27669699; 1273,-9.276678933;
            1274,-9.276660894; 1275,-9.276642872; 1276,-9.276624868; 1277,-9.27660688; 1278,-9.27658891; 1279,-9.276570957; 1280,-9.276553021;
            1281,-9.276535103; 1282,-9.276517201; 1283,-9.276499317; 1284,-9.27648145; 1285,-9.2764636; 1286,-9.276445767; 1287,-9.276427951;
            1288,-9.276410153; 1289,-9.276392371; 1290,-9.276374606; 1291,-9.276356859; 1292,-9.276339128; 1293,-9.276321415; 1294,-9.276303718;
            1295,-9.276286039; 1296,-9.276268376; 1297,-9.276250731; 1298,-9.276233102; 1299,-9.27621549; 1300,-9.276197896; 1301,-9.276180318;
            1302,-9.276162757; 1303,-9.276145212; 1304,-9.276127685; 1305,-9.276110175; 1306,-9.276092681; 1307,-9.276075204; 1308,-9.276057744;
            1309,-9.276040301; 1310,-9.276022875; 1311,-9.276005465; 1312,-9.275988072; 1313,-9.275970696; 1314,-9.275953336; 1315,-9.275935994;
            1316,-9.275918668; 1317,-9.275901358; 1318,-9.275884065; 1319,-9.275866789; 1320,-9.27584953; 1321,-9.275832287; 1322,-9.275815061;
            1323,-9.275797851; 1324,-9.275780658; 1325,-9.275763481; 1326,-9.275746321; 1327,-9.275729178; 1328,-9.275712051; 1329,-9.275694941;
            1330,-9.275677847; 1331,-9.275660769; 1332,-9.275643708; 1333,-9.275626664; 1334,-9.275609636; 1335,-9.275592624; 1336,-9.275575629;
            1337,-9.27555865; 1338,-9.275541687; 1339,-9.275524741; 1340,-9.275507811; 1341,-9.275490898; 1342,-9.275474001; 1343,-9.27545712;
            1344,-9.275440256; 1345,-9.275423407; 1346,-9.275406575; 1347,-9.27538976; 1348,-9.27537296; 1349,-9.275356177; 1350,-9.27533941;
            1351,-9.275322659; 1352,-9.275305924; 1353,-9.275289206; 1354,-9.275272504; 1355,-9.275255817; 1356,-9.275239147; 1357,-9.275222493;
            1358,-9.275205855; 1359,-9.275189234; 1360,-9.275172628; 1361,-9.275156038; 1362,-9.275139465; 1363,-9.275122907; 1364,-9.275106366;
            1365,-9.27508984; 1366,-9.27507333; 1367,-9.275056837; 1368,-9.275040359; 1369,-9.275023897; 1370,-9.275007452; 1371,-9.274991022;
            1372,-9.274974608; 1373,-9.27495821; 1374,-9.274941827; 1375,-9.274925461; 1376,-9.274909111; 1377,-9.274892776; 1378,-9.274876457;
            1379,-9.274860154; 1380,-9.274843867; 1381,-9.274827595; 1382,-9.27481134; 1383,-9.2747951; 1384,-9.274778875; 1385,-9.274762667;
            1386,-9.274746474; 1387,-9.274730297; 1388,-9.274714135; 1389,-9.27469799; 1390,-9.274681859; 1391,-9.274665745; 1392,-9.274649646;
            1393,-9.274633563; 1394,-9.274617495; 1395,-9.274601443; 1396,-9.274585406; 1397,-9.274569385; 1398,-9.27455338; 1399,-9.27453739;
            1400,-9.274521415; 1401,-9.274505456; 1402,-9.274489513; 1403,-9.274473585; 1404,-9.274457672; 1405,-9.274441775; 1406,-9.274425893;
            1407,-9.274410027; 1408,-9.274394176; 1409,-9.274378341; 1410,-9.274362521; 1411,-9.274346716; 1412,-9.274330926; 1413,-9.274315152;
            1414,-9.274299393; 1415,-9.27428365; 1416,-9.274267921; 1417,-9.274252208; 1418,-9.274236511; 1419,-9.274220828; 1420,-9.274205161;
            1421,-9.274189509; 1422,-9.274173872; 1423,-9.27415825; 1424,-9.274142644; 1425,-9.274127052; 1426,-9.274111476; 1427,-9.274095915;
            1428,-9.274080369; 1429,-9.274064838; 1430,-9.274049322; 1431,-9.274033822; 1432,-9.274018336; 1433,-9.274002865; 1434,-9.27398741;
            1435,-9.273971969; 1436,-9.273956544; 1437,-9.273941133; 1438,-9.273925737; 1439,-9.273910357; 1440,-9.273894991; 1441,-9.27387964;
            1442,-9.273864304; 1443,-9.273848983; 1444,-9.273833677; 1445,-9.273818386; 1446,-9.27380311; 1447,-9.273787848; 1448,-9.273772602;
            1449,-9.27375737; 1450,-9.273742153; 1451,-9.27372695; 1452,-9.273711763; 1453,-9.27369659; 1454,-9.273681433; 1455,-9.273666291;
            1456,-9.273651163; 1457,-9.273636049; 1458,-9.27362095; 1459,-9.273605864; 1460,-9.273590793; 1461,-9.273575737; 1462,-9.273560694;
            1463,-9.273545666; 1464,-9.273530652; 1465,-9.273515653; 1466,-9.273500667; 1467,-9.273485696; 1468,-9.273470738; 1469,-9.273455795;
            1470,-9.273440867; 1471,-9.273425952; 1472,-9.273411051; 1473,-9.273396165; 1474,-9.273381293; 1475,-9.273366434; 1476,-9.27335159;
            1477,-9.27333676; 1478,-9.273321944; 1479,-9.273307142; 1480,-9.273292354; 1481,-9.273277581; 1482,-9.273262821; 1483,-9.273248075;
            1484,-9.273233343; 1485,-9.273218625; 1486,-9.273203922; 1487,-9.273189232; 1488,-9.273174556; 1489,-9.273159894; 1490,-9.273145246;
            1491,-9.273130612; 1492,-9.273115992; 1493,-9.273101386; 1494,-9.273086794; 1495,-9.273072215; 1496,-9.273057651; 1497,-9.2730431;
            1498,-9.273028563; 1499,-9.27301404; 1500,-9.272999531; 1501,-9.272985036; 1502,-9.272970554; 1503,-9.272956087; 1504,-9.272941633;
            1505,-9.272927193; 1506,-9.272912766; 1507,-9.272898354; 1508,-9.272883955; 1509,-9.27286957; 1510,-9.272855198; 1511,-9.272840841;
            1512,-9.272826497; 1513,-9.272812166; 1514,-9.27279785; 1515,-9.272783547; 1516,-9.272769257; 1517,-9.272754982; 1518,-9.27274072;
            1519,-9.272726472; 1520,-9.272712237; 1521,-9.272698016; 1522,-9.272683808; 1523,-9.272669614; 1524,-9.272655434; 1525,-9.272641267;
            1526,-9.272627114; 1527,-9.272612974; 1528,-9.272598848; 1529,-9.272584735; 1530,-9.272570636; 1531,-9.27255655; 1532,-9.272542478;
            1533,-9.272528419; 1534,-9.272514374; 1535,-9.272500342; 1536,-9.272486324; 1537,-9.272472319; 1538,-9.272458328; 1539,-9.27244435;
            1540,-9.272430385; 1541,-9.272416434; 1542,-9.272402496; 1543,-9.272388571; 1544,-9.27237466; 1545,-9.272360762; 1546,-9.272346878;
            1547,-9.272333007; 1548,-9.272319149; 1549,-9.272305304; 1550,-9.272291473; 1551,-9.272277655; 1552,-9.27226385; 1553,-9.272250059;
            1554,-9.272236281; 1555,-9.272222516; 1556,-9.272208764; 1557,-9.272195025; 1558,-9.2721813; 1559,-9.272167588; 1560,-9.272153889;
            1561,-9.272140203; 1562,-9.272126531; 1563,-9.272112871; 1564,-9.272099225; 1565,-9.272085592; 1566,-9.272071972; 1567,-9.272058365;
            1568,-9.272044771; 1569,-9.27203119; 1570,-9.272017623; 1571,-9.272004068; 1572,-9.271990526; 1573,-9.271976998; 1574,-9.271963482;
            1575,-9.27194998; 1576,-9.27193649; 1577,-9.271923014; 1578,-9.27190955; 1579,-9.2718961; 1580,-9.271882662; 1581,-9.271869238; 1582,
            -9.271855826; 1583,-9.271842428; 1584,-9.271829042; 1585,-9.271815669; 1586,-9.271802309; 1587,-9.271788962; 1588,-9.271775628; 1589,
            -9.271762307; 1590,-9.271748998; 1591,-9.271735703; 1592,-9.27172242; 1593,-9.27170915; 1594,-9.271695893; 1595,-9.271682648; 1596,-9.271669417;
            1597,-9.271656198; 1598,-9.271642992; 1599,-9.271629799; 1600,-9.271616619; 1601,-9.271603451; 1602,-9.271590296; 1603,-9.271577154;
            1604,-9.271564024; 1605,-9.271550907; 1606,-9.271537803; 1607,-9.271524712; 1608,-9.271511633; 1609,-9.271498567; 1610,-9.271485513;
            1611,-9.271472472; 1612,-9.271459444; 1613,-9.271446428; 1614,-9.271433425; 1615,-9.271420435; 1616,-9.271407457; 1617,-9.271394492;
            1618,-9.271381539; 1619,-9.271368599; 1620,-9.271355671; 1621,-9.271342756; 1622,-9.271329853; 1623,-9.271316963; 1624,-9.271304085;
            1625,-9.27129122; 1626,-9.271278367; 1627,-9.271265527; 1628,-9.271252699; 1629,-9.271239884; 1630,-9.271227081; 1631,-9.27121429;
            1632,-9.271201512; 1633,-9.271188747; 1634,-9.271175993; 1635,-9.271163252; 1636,-9.271150524; 1637,-9.271137807; 1638,-9.271125103;
            1639,-9.271112412; 1640,-9.271099733; 1641,-9.271087066; 1642,-9.271074411; 1643,-9.271061769; 1644,-9.271049138; 1645,-9.271036521;
            1646,-9.271023915; 1647,-9.271011322; 1648,-9.270998741; 1649,-9.270986172; 1650,-9.270973615; 1651,-9.27096107; 1652,-9.270948538;
            1653,-9.270936018; 1654,-9.27092351; 1655,-9.270911014; 1656,-9.270898531; 1657,-9.270886059; 1658,-9.2708736; 1659,-9.270861152;
            1660,-9.270848717; 1661,-9.270836294; 1662,-9.270823883; 1663,-9.270811484; 1664,-9.270799097; 1665,-9.270786722; 1666,-9.27077436;
            1667,-9.270762009; 1668,-9.27074967; 1669,-9.270737343; 1670,-9.270725029; 1671,-9.270712726; 1672,-9.270700435; 1673,-9.270688156;
            1674,-9.270675889; 1675,-9.270663634; 1676,-9.270651391; 1677,-9.27063916; 1678,-9.270626941; 1679,-9.270614734; 1680,-9.270602538;
            1681,-9.270590355; 1682,-9.270578183; 1683,-9.270566023; 1684,-9.270553875; 1685,-9.270541739; 1686,-9.270529615; 1687,-9.270517502;
            1688,-9.270505401; 1689,-9.270493312; 1690,-9.270481235; 1691,-9.27046917; 1692,-9.270457116; 1693,-9.270445074; 1694,-9.270433044;
            1695,-9.270421026; 1696,-9.270409019; 1697,-9.270397024; 1698,-9.270385041; 1699,-9.270373069; 1700,-9.270361109; 1701,-9.270349161;
            1702,-9.270337224; 1703,-9.270325299; 1704,-9.270313385; 1705,-9.270301484; 1706,-9.270289593; 1707,-9.270277715; 1708,-9.270265848;
            1709,-9.270253992; 1710,-9.270242148; 1711,-9.270230316; 1712,-9.270218495; 1713,-9.270206686; 1714,-9.270194888; 1715,-9.270183102;
            1716,-9.270171327; 1717,-9.270159564; 1718,-9.270147812; 1719,-9.270136072; 1720,-9.270124343; 1721,-9.270112625; 1722,-9.270100919;
            1723,-9.270089225; 1724,-9.270077541; 1725,-9.27006587; 1726,-9.270054209; 1727,-9.27004256; 1728,-9.270030922; 1729,-9.270019296;
            1730,-9.270007681; 1731,-9.269996078; 1732,-9.269984486; 1733,-9.269972905; 1734,-9.269961336; 1735,-9.269949777; 1736,-9.26993823;
            1737,-9.269926694; 1738,-9.269915168; 1739,-9.269903654; 1740,-9.26989215; 1741,-9.269880657; 1742,-9.269869176; 1743,-9.269857705;
            1744,-9.269846245; 1745,-9.269834796; 1746,-9.269823358; 1747,-9.269811931; 1748,-9.269800515; 1749,-9.26978911; 1750,-9.269777715;
            1751,-9.269766332; 1752,-9.269754959; 1753,-9.269743597; 1754,-9.269732246; 1755,-9.269720905; 1756,-9.269709576; 1757,-9.269698257;
            1758,-9.26968695; 1759,-9.269675652; 1760,-9.269664366; 1761,-9.269653091; 1762,-9.269641826; 1763,-9.269630572; 1764,-9.269619329;
            1765,-9.269608096; 1766,-9.269596875; 1767,-9.269585664; 1768,-9.269574463; 1769,-9.269563274; 1770,-9.269552095; 1771,-9.269540927;
            1772,-9.269529769; 1773,-9.269518622; 1774,-9.269507486; 1775,-9.269496361; 1776,-9.269485246; 1777,-9.269474141; 1778,-9.269463048;
            1779,-9.269451965; 1780,-9.269440892; 1781,-9.269429831; 1782,-9.26941878; 1783,-9.269407739; 1784,-9.269396709; 1785,-9.26938569;
            1786,-9.269374681; 1787,-9.269363682; 1788,-9.269352695; 1789,-9.269341718; 1790,-9.269330751; 1791,-9.269319795; 1792,-9.269308849;
            1793,-9.269297914; 1794,-9.269286989; 1795,-9.269276075; 1796,-9.269265171; 1797,-9.269254278; 1798,-9.269243396; 1799,-9.269232523;
            1800,-9.269221661; 1801,-9.26921081; 1802,-9.269199969; 1803,-9.269189139; 1804,-9.269178318; 1805,-9.269167509; 1806,-9.269156709;
            1807,-9.26914592; 1808,-9.269135142; 1809,-9.269124374; 1810,-9.269113616; 1811,-9.269102868; 1812,-9.269092131; 1813,-9.269081404;
            1814,-9.269070688; 1815,-9.269059982; 1816,-9.269049286; 1817,-9.2690386; 1818,-9.269027925; 1819,-9.26901726; 1820,-9.269006606;
            1821,-9.268995961; 1822,-9.268985327; 1823,-9.268974703; 1824,-9.268964089; 1825,-9.268953486; 1826,-9.268942893; 1827,-9.26893231;
            1828,-9.268921737; 1829,-9.268911175; 1830,-9.268900622; 1831,-9.26889008; 1832,-9.268879548; 1833,-9.268869026; 1834,-9.268858514;
            1835,-9.268848013; 1836,-9.268837522; 1837,-9.26882704; 1838,-9.268816569; 1839,-9.268806108; 1840,-9.268795657; 1841,-9.268785217;
            1842,-9.268774786; 1843,-9.268764365; 1844,-9.268753955; 1845,-9.268743554; 1846,-9.268733164; 1847,-9.268722783; 1848,-9.268712413;
            1849,-9.268702053; 1850,-9.268691703; 1851,-9.268681362; 1852,-9.268671032; 1853,-9.268660712; 1854,-9.268650402; 1855,-9.268640101;
            1856,-9.268629811; 1857,-9.268619531; 1858,-9.26860926; 1859,-9.268599; 1860,-9.268588749; 1861,-9.268578509; 1862,-9.268568278; 1863,
            -9.268558057; 1864,-9.268547847; 1865,-9.268537646; 1866,-9.268527455; 1867,-9.268517274; 1868,-9.268507102; 1869,-9.268496941; 1870,
            -9.268486789; 1871,-9.268476648; 1872,-9.268466516; 1873,-9.268456394; 1874,-9.268446282; 1875,-9.268436179; 1876,-9.268426087; 1877,
            -9.268416004; 1878,-9.268405931; 1879,-9.268395868; 1880,-9.268385814; 1881,-9.26837577; 1882,-9.268365737; 1883,-9.268355712; 1884,-9.268345698;
            1885,-9.268335693; 1886,-9.268325698; 1887,-9.268315713; 1888,-9.268305737; 1889,-9.268295771; 1890,-9.268285815; 1891,-9.268275869;
            1892,-9.268265932; 1893,-9.268256005; 1894,-9.268246087; 1895,-9.268236179; 1896,-9.268226281; 1897,-9.268216392; 1898,-9.268206513;
            1899,-9.268196644; 1900,-9.268186784; 1901,-9.268176934; 1902,-9.268167093; 1903,-9.268157262; 1904,-9.268147441; 1905,-9.268137629;
            1906,-9.268127827; 1907,-9.268118034; 1908,-9.268108251; 1909,-9.268098477; 1910,-9.268088713; 1911,-9.268078958; 1912,-9.268069213;
            1913,-9.268059477; 1914,-9.268049751; 1915,-9.268040034; 1916,-9.268030327; 1917,-9.268020629; 1918,-9.268010941; 1919,-9.268001262;
            1920,-9.267991592; 1921,-9.267981932; 1922,-9.267972281; 1923,-9.26796264; 1924,-9.267953008; 1925,-9.267943386; 1926,-9.267933773;
            1927,-9.267924169; 1928,-9.267914575; 1929,-9.26790499; 1930,-9.267895414; 1931,-9.267885848; 1932,-9.267876291; 1933,-9.267866743;
            1934,-9.267857205; 1935,-9.267847676; 1936,-9.267838156; 1937,-9.267828646; 1938,-9.267819145; 1939,-9.267809653; 1940,-9.26780017;
            1941,-9.267790697; 1942,-9.267781233; 1943,-9.267771778; 1944,-9.267762332; 1945,-9.267752896; 1946,-9.267743469; 1947,-9.267734051;
            1948,-9.267724642; 1949,-9.267715243; 1950,-9.267705852; 1951,-9.267696471; 1952,-9.267687099; 1953,-9.267677736; 1954,-9.267668382;
            1955,-9.267659038; 1956,-9.267649702; 1957,-9.267640376; 1958,-9.267631059; 1959,-9.26762175; 1960,-9.267612451; 1961,-9.267603161;
            1962,-9.267593881; 1963,-9.267584609; 1964,-9.267575346; 1965,-9.267566092; 1966,-9.267556848; 1967,-9.267547612; 1968,-9.267538386;
            1969,-9.267529168; 1970,-9.267519959; 1971,-9.26751076; 1972,-9.267501569; 1973,-9.267492388; 1974,-9.267483215; 1975,-9.267474052;
            1976,-9.267464897; 1977,-9.267455751; 1978,-9.267446615; 1979,-9.267437487; 1980,-9.267428368; 1981,-9.267419258; 1982,-9.267410157;
            1983,-9.267401065; 1984,-9.267391981; 1985,-9.267382907; 1986,-9.267373842; 1987,-9.267364785; 1988,-9.267355737; 1989,-9.267346698;
            1990,-9.267337668; 1991,-9.267328647; 1992,-9.267319635; 1993,-9.267310631; 1994,-9.267301636; 1995,-9.26729265; 1996,-9.267283673;
            1997,-9.267274705; 1998,-9.267265745; 1999,-9.267256794; 2000,-9.267247852],
        startTime=0,
        shiftTime=100) annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
      Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-12,-8},{8,12}})));
    equation
      connect(Brine_Oulet.ports[1], mEE_FC3_1.Saltwater_Reject_Oulet)
        annotation (Line(points={{198,-4},{184,-4},{184,-2},{180,-2}}, color={0,127,255}));
      connect(Brine_Source.ports[1], mEE_FC3_1.Saltwater_Input)
        annotation (Line(points={{198,16},{184,16},{184,14},{180,14}}, color={0,127,255}));
      connect(mEE_FC3_1.Condensate_Oulet, sensor_m_flow1.port_a) annotation (Line(points={{160,-13.6},{160,-44},{168,-44}}, color={0,127,255}));
      connect(sensor_m_flow1.port_b,Condensate_Out. ports[1]) annotation (Line(points={{188,-44},{198,-44}}, color={0,127,255}));
      connect(condens1.ports[1], mEE_FC3_1.Steam_Input) annotation (Line(points={{72,14},{140,14}}, color={0,127,255}));
      connect(condens.ports[1], mEE_FC3_1.Water_Outlet) annotation (Line(points={{104,-34},{130,-34},{130,-2},{140,-2}}, color={0,127,255}));
      connect(timeTable.y, gain.u) annotation (Line(points={{-39,-4},{-22,-4},{-22,2},{-14,2}}, color={0,0,127}));
      connect(gain.y, condens1.m_flow_in) annotation (Line(points={{9,2},{42,2},{42,22},{52,22}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE_upwoSEEHRSG;

    model GT_HRSG_ST_MEE_up3 "Test of HRSG"
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=false,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{218,6},{198,26}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{168,-54},{188,-34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{218,-54},{198,-34}})));
      Desalination.MEE.Multiple_Effect.MEE_FC3
                              mEE_FC3_1(
        redeclare Desalination.MEE.ControlSystems.CS_TemperatureControlSystem3 CS,
        data(
          m1=15,
          m2=14,
          m3=13),
        CV2(dp_nominal=5000))
        annotation (Placement(transformation(extent={{136,-10},{176,30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{70,-12},{90,8}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h
                                                     Condensate_Out2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=7.4,
        h=2.6e6,
        nPorts=1)
        annotation (Placement(transformation(extent={{66,16},{86,36}})));
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        redeclare package Medium = Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{38,-4},{18,16}},
                      rotation=0)));
      HRSG                                  heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        Nominal_Flow=7.4,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=100000, k=-0.0003))
        annotation (Placement(transformation(extent={{6,-36},{-74,44}})));
      GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{-72,-102},{-52,-82}})));
      SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                     SES(capacity=dataCapacity.SES_capacity, redeclare
          SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity CS(W_totalSetpoint(displayUnit="MW")=
            35000000))
        annotation (Placement(transformation(extent={{-164,-42},{-104,18}})));
      NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
        annotation (Placement(transformation(extent={{-92,78},{-72,98}})));
      TRANSFORM.Fluid.Machines.Turbine_SinglePhase_Stodola    turbine(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        h_a_start=3E6,
        h_b_start=2.4E6,
        m_flow_start=0,
        eta_mech=0.98,
        p_a_start=800000,
        p_b_start=200000,
        T_a_start=453.15,
        T_b_start=393.15,
        m_flow_nominal=3,
        p_inlet_nominal=700000,
        T_nominal=453.15) annotation (Placement(transformation(extent={{86,70},{106,50}})));
      TRANSFORM.Fluid.Volumes.IdealCondenser condenser(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        V_liquid_start=2) annotation (Placement(transformation(extent={{126,-36},{106,-16}})));
      Electrical.Generator      generator1(J=1e4)
        annotation (Placement(transformation(extent={{156,50},{176,70}})));
      TRANSFORM.Electrical.Sensors.PowerSensor sensorW
        annotation (Placement(transformation(extent={{186,50},{206,70}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{126,70},{146,50}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{240,50},{220,70}})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=200000,
        redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10))
        annotation (Placement(transformation(extent={{28,-54},{48,-34}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=5)  annotation (Placement(transformation(extent={{-8,44},{12,64}})));
    equation
      connect(sensor_m_flow1.port_b,Condensate_Out. ports[1]) annotation (Line(points={{188,-44},{198,-44}}, color={0,127,255}));
      connect(mEE_FC3_1.Saltwater_Input, Brine_Source.ports[1])
        annotation (Line(points={{176,18},{188,18},{188,16},{198,16}}, color={0,127,255}));
      connect(mEE_FC3_1.Saltwater_Reject_Oulet, Brine_Oulet.ports[1])
        annotation (Line(points={{176,2},{188,2},{188,-4},{198,-4}}, color={0,127,255}));
      connect(mEE_FC3_1.Condensate_Oulet, sensor_m_flow1.port_a) annotation (Line(points={{156,-9.6},{156,-44},{168,-44}}, color={0,127,255}));
      connect(mEE_FC3_1.Steam_Input, Condensate_Out2.ports[1]) annotation (Line(points={{136,18},{92,18},{92,26},{86,26}}, color={0,127,255}));
      connect(Condensate_Out1.ports[1], mEE_FC3_1.Water_Outlet) annotation (Line(points={{90,-2},{128,-2},{128,2},{136,2}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port,SinkExhaustGas. ports[1]) annotation (Line(points={{6,4},{12,4},{12,6},{18,6}},
                                                                                                                                color={0,127,255}));
      connect(elecLoad.portElec_a,SES. portElec_b)
        annotation (Line(points={{-72,-92},{-82,-92},{-82,-12},{-104,-12}},                    color={238,46,47}));
      connect(SES.FlueGas_b,heatRecoverySteamGenerator. Gas_Inlet_Port)
        annotation (Line(points={{-104,6},{-90,6},{-90,4},{-74,4}},
                                                                  color={0,127,255}));
      connect(generator1.portElec,sensorW. port_a)
        annotation (Line(points={{176,60},{186,60}},
                                                   color={255,0,0}));
      connect(powerSensor.flange_b,generator1. shaft_a)
        annotation (Line(points={{146,60},{156,60}},
                                                  color={0,0,0}));
      connect(powerSensor.flange_a,turbine. shaft_b) annotation (Line(points={{126,60},{106,60}},
                                                                                                color={0,0,0}));
      connect(sinkElec.port,sensorW. port_b) annotation (Line(points={{220,60},{206,60}}, color={255,0,0}));
      connect(volume.port_b,condenser. port_b) annotation (Line(points={{44,-44},{116,-44},{116,-34}}, color={0,127,255}));
      connect(volume.port_a,heatRecoverySteamGenerator. Feed_port) annotation (Line(points={{32,-44},{-34,-44},{-34,-36}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port,resistance. port_a)
        annotation (Line(points={{-34,44},{-34,54},{-5,54}},  color={0,127,255}));
      connect(resistance.port_b,turbine. port_a) annotation (Line(points={{9,54},{86,54}}, color={0,127,255}));
      connect(turbine.port_b, condenser.port_a)
        annotation (Line(points={{106,54},{118,54},{118,-10},{122,-10},{122,-14},{123,-14},{123,-19}}, color={0,127,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
        experiment(
          StopTime=100,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE_up3;

    model GT_HRSG_ST_MEE_upwoSEEHRSGtest2 "Test of HRSG"
      Desalination.MEE.Multiple_Effect.MEE_FC3
                              mEE_FC3_1(
        redeclare Desalination.MEE.ControlSystems.CS_TemperatureControlSystem3 CS,
        data(
          m1=15,
          m2=14,
          m3=13),
        CV2(dp_nominal=5000))
        annotation (Placement(transformation(extent={{100,0},{140,40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        p=10000,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{178,12},{158,-8}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Source(
        redeclare package Medium = Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        use_X_in=false,
        p=100000,
        h=1.5e5,
        X={0.92,0.08},
        nPorts=1) annotation (Placement(transformation(extent={{178,18},{158,38}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{130,-38},{150,-18}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Condensate_Out(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{178,-38},{158,-18}})));
      Modelica.Fluid.Sources.Boundary_pT SinkExhaustGas(
        redeclare package Medium = Media.FlueGas,
        use_p_in=false,
        nPorts=1)           annotation (Placement(transformation(extent={{22,18},{2,38}},
                      rotation=0)));
      HRSG                                  heatRecoverySteamGenerator(
        use_nat_circ=true,
        use_booster_pump=true,
        use_Econimizer=true,
        use_Superheater=false,
        Recirculation_Rate=25,
        P_sys=862000,
        YMAX=50,
        n_tubes_EVAP=52,
        EVAP_L=4,
        EVAP_tube_Dia(displayUnit="mm") = 0.1,
        EVAP_shell_Dia(displayUnit="mm") = 1,
        EVAP_DC_Dia=0.07,
        n_tubes_ECON=40,
        ECON_L=1,
        ECON_tube_Dia(displayUnit="mm") = 0.1,
        ECON_shell_Dia(displayUnit="mm") = 1,
        ECON_DC_Dia=0.3,
        threeElementContoller(
          k=100,
          kp=1e5,
          Ti=2.5),
        pressure_Control_Valve_Simple(Nominal_dp=1000, k=-0.0003),
        steam_Drum(p_start=2000000))
        annotation (Placement(transformation(extent={{-14,-12},{-94,68}})));
      GasTurbine.Sources.PrescribedFrequency
                             elecLoad(f=60)
        annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));
      SecondaryEnergySupply.NaturalGasFiredTurbine.GTPP_PowerCtrl_GasExit
                     SES(capacity=dataCapacity.SES_capacity, redeclare
          SecondaryEnergySupply.NaturalGasFiredTurbine.Examples.Standalone_Examples.CS_GTPP_fixedCapacity CS(W_totalSetpoint(displayUnit="MW")=
            35000000))
        annotation (Placement(transformation(extent={{-180,-20},{-120,40}})));
      NHES.Systems.Examples.BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW"), SES_capacity(displayUnit="MW") = 20000000)
        annotation (Placement(transformation(extent={{-154,76},{-134,96}})));
      TRANSFORM.Fluid.Machines.Turbine_SinglePhase_Stodola    turbine(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_start=false,
        h_a_start=3E6,
        h_b_start=2.4E6,
        m_flow_start=7,
        eta_mech=0.98,
        p_a_start=800000,
        p_b_start=200000,
        T_a_start=453.15,
        T_b_start=393.15,
        m_flow_nominal=7,
        p_inlet_nominal=900000,
        T_nominal=453.15) annotation (Placement(transformation(extent={{24,92},{44,72}})));
      TRANSFORM.Fluid.Volumes.IdealCondenser condenser(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        V_liquid_start=2) annotation (Placement(transformation(extent={{72,-16},{52,4}})));
      Electrical.Generator      generator1(J=1e4)
        annotation (Placement(transformation(extent={{144,72},{164,92}})));
      Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{110,92},{130,72}})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=200000,
        redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=10))
        annotation (Placement(transformation(extent={{12,-32},{32,-12}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=5)  annotation (Placement(transformation(extent={{-24,66},{-4,86}})));
    equation
      connect(Brine_Oulet.ports[1], mEE_FC3_1.Saltwater_Reject_Oulet)
        annotation (Line(points={{158,2},{148,2},{148,12},{140,12}}, color={0,127,255}));
      connect(Brine_Source.ports[1], mEE_FC3_1.Saltwater_Input) annotation (Line(points={{158,28},{140,28}}, color={0,127,255}));
      connect(mEE_FC3_1.Condensate_Oulet, sensor_m_flow1.port_a) annotation (Line(points={{120,0.4},{120,-28},{130,-28}}, color={0,127,255}));
      connect(sensor_m_flow1.port_b,Condensate_Out. ports[1]) annotation (Line(points={{150,-28},{158,-28}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Gas_Outlet_Port,SinkExhaustGas. ports[1]) annotation (Line(points={{-14,28},{2,28}},   color={0,127,255}));
      connect(elecLoad.portElec_a,SES. portElec_b)
        annotation (Line(points={{-88,-70},{-98,-70},{-98,10},{-120,10}},                      color={238,46,47}));
      connect(SES.FlueGas_b,heatRecoverySteamGenerator. Gas_Inlet_Port)
        annotation (Line(points={{-120,28},{-94,28}},             color={0,127,255}));
      connect(powerSensor.flange_b,generator1. shaft_a)
        annotation (Line(points={{130,82},{144,82}},
                                                  color={0,0,0}));
      connect(powerSensor.flange_a,turbine. shaft_b) annotation (Line(points={{110,82},{44,82}},color={0,0,0}));
      connect(volume.port_b,condenser. port_b) annotation (Line(points={{28,-22},{62,-22},{62,-14}},   color={0,127,255}));
      connect(volume.port_a,heatRecoverySteamGenerator. Feed_port) annotation (Line(points={{16,-22},{-54,-22},{-54,-12}}, color={0,127,255}));
      connect(heatRecoverySteamGenerator.Steam_Outlet_port,resistance. port_a)
        annotation (Line(points={{-54,68},{-54,76},{-21,76}}, color={0,127,255}));
      connect(resistance.port_b,turbine. port_a) annotation (Line(points={{-7,76},{24,76}},color={0,127,255}));
      connect(turbine.port_b, mEE_FC3_1.Steam_Input) annotation (Line(points={{44,76},{84,76},{84,28},{100,28}}, color={0,127,255}));
      connect(mEE_FC3_1.Water_Outlet, condenser.port_a) annotation (Line(points={{100,12},{70,12},{70,0},{69,0},{69,1}}, color={0,127,255}));
      connect(generator1.portElec, elecLoad.portElec_a)
        annotation (Line(points={{164,82},{172,82},{172,60},{48,60},{48,-42},{-98,-42},{-98,-70},{-88,-70}}, color={255,0,0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}}),
                            graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent={{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,100}})),
        experiment(
          StopTime=100,
          Interval=0.1,
          __Dymola_Algorithm="Esdirk45a"));
    end GT_HRSG_ST_MEE_upwoSEEHRSGtest2;
    annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Polygon(
            origin={8,14},
            lineColor={78,138,73},
            fillColor={78,138,73},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
  end Examples;

  model ThreeElementContoller

    parameter Real FlowErrorGain(unit="1")=100 "Gain of Flow Error";
    parameter Real LevelErrorGain(unit="1")=1 "Gain of Level Error";
    parameter Real k(min=0, unit="1") = 1 "Gain of controller";
    parameter Real yMax(start=1) "Upper limit of output";
    parameter Real yMin(start=0) "Lower limit of output";
    parameter Real kp(min=0) = 1 "Proportional Gain";
    parameter Real DelayTime = 2 "Time Delay for start of controller";
    parameter Real SS_guess = 0 "Init Guess for SS before start of controller";
    parameter Real LevelSet(min=0, max=1)=0.5
                                             "Relative set point for level";
  parameter Real xi_start=0
      "Initial or guess value for integrator output (= integrator state)";
    parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small)=0.5;
    parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
      "Ni*Ti is time constant of anti-windup compensation";
    constant Modelica.Units.SI.Time unitTime=1;
    Modelica.Blocks.Interfaces.RealInput Level
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput FeedFlow annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-50,-120})));
    Modelica.Blocks.Interfaces.RealInput SteamFlow annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={50,-120})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Sources.RealExpression LevelSetPoint(y=LevelSet)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    Modelica.Blocks.Math.Add LevelError(k1=-1)
      annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    Modelica.Blocks.Math.Add FlowError(k1=+1, k2=-1)
                                              annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={0,-80})));
    Modelica.Blocks.Math.Add TotalError(k1=FlowErrorGain, k2=LevelErrorGain)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-30,-50})));
    Modelica.Blocks.Math.Gain P(k=kp)
      annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Blocks.Continuous.Integrator I(k=unitTime/Ti, y_start=xi_start)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Math.Add addPI(k1=1, k2=1)
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    Modelica.Blocks.Math.Gain gainPID(k=k)
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=yMax, uMin=yMin)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    Modelica.Blocks.Logical.Switch DelaySwitch annotation (Placement(transformation(extent={{60,10},{80,-10}})));
    Modelica.Blocks.Sources.BooleanStep DelayTimer(startTime=DelayTime, startValue=true)
                                                                        annotation (Placement(transformation(extent={{20,0},{40,20}})));
    Modelica.Blocks.Sources.RealExpression SteadyStateGuess(y=SS_guess) annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  equation
    connect(LevelSetPoint.y, LevelError.u2)
      annotation (Line(points={{-79,-16},{-72,-16},{-72,-6}}, color={0,0,127}));
    connect(Level, LevelError.u1)
      annotation (Line(points={{-120,0},{-80,0},{-80,6},{-72,6}}, color={0,0,127}));
    connect(FeedFlow, FlowError.u2) annotation (Line(points={{-50,-120},{-50,-96},{-6,-96},
            {-6,-92}}, color={0,0,127}));
    connect(SteamFlow, FlowError.u1)
      annotation (Line(points={{50,-120},{50,-96},{6,-96},{6,-92}}, color={0,0,127}));
    connect(LevelError.y, TotalError.u2) annotation (Line(points={{-49,0},{-44,0},{-44,-68},
            {-36,-68},{-36,-62}}, color={0,0,127}));
    connect(I.y, addPI.u2)
      annotation (Line(points={{-19,50},{-8,50},{-8,64},{-2,64}}, color={0,0,127}));
    connect(P.y, addPI.u1)
      annotation (Line(points={{-59,90},{-8,90},{-8,76},{-2,76}}, color={0,0,127}));
    connect(addPI.y, gainPID.u)
      annotation (Line(points={{21,70},{28,70}}, color={0,0,127}));
    connect(gainPID.y, limiter.u)
      annotation (Line(points={{51,70},{58,70}}, color={0,0,127}));
    connect(P.u, TotalError.y) annotation (Line(points={{-82,90},{-88,90},{-88,18},{
            -28,18},{-28,-30},{-30,-30},{-30,-39}}, color={0,0,127}));
    connect(I.u, TotalError.y) annotation (Line(points={{-42,50},{-66,50},{-66,48},{
            -88,48},{-88,18},{-28,18},{-28,-30},{-30,-30},{-30,-39}}, color={0,0,127}));
    connect(FlowError.y, TotalError.u1) annotation (Line(points={{2.05391e-15,-69},{2.05391e-15,-64},{-18,-64},{-18,-68},
            {-24,-68},{-24,-62}}, color={0,0,127}));
    connect(DelaySwitch.y, y) annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
    connect(DelayTimer.y, DelaySwitch.u2) annotation (Line(points={{41,10},{50,10},{50,0},{58,0}}, color={255,0,255}));
    connect(limiter.y, DelaySwitch.u3) annotation (Line(points={{81,70},{86,70},{86,14},{58,14},{58,8}}, color={0,0,127}));
    connect(SteadyStateGuess.y, DelaySwitch.u1) annotation (Line(points={{41,-20},{52,-20},{52,-8},{58,-8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                  Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
            textString="%name"),
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
          Text(
            extent={{-20,-20},{80,-60}},
            textColor={192,192,192},
            textString="3EC")}),                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ThreeElementContoller;

end HRSG;
