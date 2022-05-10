within NHES.Fluid.HeatExchangers;
package HRSGs "Heat Recovery Steam Generators"
  model HRSG
    "Single stage natural circulation or forced convection Heat recovery steam generator, with options for a econimzer and preheater."
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
          parameter Modelica.Units.SI.Length ECON_L=10 if use_Superheater "Height of Econimizer"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Tubes"));
          parameter Modelica.Units.SI.Length ECON_tube_Dia=50e-3 if use_Superheater "Hydraulic Diameter of Tubes"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Tubes"));
          parameter Modelica.Units.SI.Length ECON_shell_Dia=300e-3 if use_Superheater "Hydraulic Diameter of Shell"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Shell"));
          parameter Real n_tubes_ECON_DC=1 if use_Superheater "Number of Downcomers in Econimizer"
  annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Downcomer"));
  parameter Modelica.Units.SI.Length ECON_DC_Dia=0.75 if use_Superheater "Diameter of Downcomer"
    annotation (Dialog(tab="Econimizer Dimensions",
          group="Econimizer Downcomer"));

  parameter Real n_tubes_SH=20 "Number of Tubes in Superheater"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_L=10 if use_Econimizer "Height of Superheater"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_tube_Dia=50e-3 if use_Econimizer "Hydraulic Diameter of Tubes"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Tubes"));
          parameter Modelica.Units.SI.Length SH_shell_Dia=300e-3 if use_Econimizer "Hydraulic Diameter of Shell"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Shell"));
          parameter Real n_tubes_SH_DC=1 if use_Econimizer "Number of Downcomers in Superheater"
  annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Downcomer"));
          parameter Modelica.Units.SI.Length SH_DC_Dia=0.75 if use_Econimizer "Diameter of Downcomer"
    annotation (Dialog(tab="Superheater Dimensions",
          group="Superheater Downcomer"));

    Modelica.Fluid.Interfaces.FluidPort_a Feed_port(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-10,-170},{10,-150}}),  iconTransformation(extent={{-10,-170},{10,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_a Gas_Inlet_Port(redeclare package
        Medium =
          NHES.Media.FlueGas)
      annotation (Placement(transformation(extent={{150,-10},{170,10}}), iconTransformation(extent={{150,-10},{170,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b Gas_Outlet_Port(redeclare package
        Medium =
          NHES.Media.FlueGas)
      annotation (Placement(transformation(extent={{-170,-10},{-150,10}}), iconTransformation(extent={{-170,-10},{-150,10}})));
    Modelica.Fluid.Interfaces.FluidPort_b Steam_Outlet_port(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater) annotation (Placement(transformation(extent={{-10,150},{10,170}}), iconTransformation(extent={{-10,150},
              {10,170}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium
        =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-104,28},{-84,48}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium
        =
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
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
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
    NCSU_INL.ThreeElementContoller threeElementContoller(
      FlowErrorGain=0.01,
      k=100,
      yMax=YMAX,
      yMin=0,
      kp=250,
      LevelSet=0.5,
      xi_start=0)
      annotation (Placement(transformation(extent={{8,80},{-16,102}})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Evaporator(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
          (
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

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance EvaporatorResistance(redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,
        R=5)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={30,-2})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance DowncomerResistance(redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,                                                                                                     R=
         5)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-14,-14})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Feed_Resistance(redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,                                                                                                 R=5) if not use_Econimizer
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-58,38})));
    Vessels.Steam_Drum steam_Drum_SI_5_1(
      p_start=P_sys*1.2,
      alphag_start=0.7,
      allowFlowReversal=false,
      V_drum=10)
      annotation (Placement(transformation(extent={{16,28},{36,48}})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Economizer(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
          (
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
      m_flow_a_start_tube=0)  if use_Econimizer  annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-56,-38})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Gas_Resistance(redeclare
        package Medium =
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
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension(displayUnit="mm") = ECON_DC_Dia,
          length=ECON_L,
          nV=3),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
                                                                                                                                                   if use_Econimizer
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-74,-42})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX Superheater(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.StraightPipeHX
          (
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
      m_flow_a_start_tube=Recirculation_Rate*0.1)
                              if use_Superheater  annotation (Placement(transformation(
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
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension(displayUnit="mm") = SH_DC_Dia,
          length=SH_L,
          nV=3),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
                                                                                                                                                   if use_Superheater
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={54,-38})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Gas_Resistance_2(redeclare
        package Medium =
          NHES.Media.FlueGas,                                                                                                  R=5) if not use_Superheater
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={126,-112})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow Booster_Pump(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater,
      use_input=true,                                                                                                        m_flow_nominal=20)
                                                                                                                                         if use_booster_pump
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-124,50})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance Steam_Resistance(redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,                                                                                  R=5)  if not use_Superheater
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={64,48})));
    NCSU_INL.Pressure_Control_Valve pressure_Control_Valve(
      P_sys=P_sys,
      Nominal_dp=P_sys ./ 1000,
      Nominal_Flow=Recirculation_Rate*0.1,
      Delay_Opening=PCV_opening_start)
      annotation (Placement(transformation(extent={{50,120},{30,140}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow RecircPump(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater,                                                                              m_flow_nominal=
          Recirculation_Rate) if not use_nat_circ annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={4,-84})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance NatCirc(redeclare
        package Medium =
          Modelica.Media.Water.StandardWater,                                                                                         R=0) if use_nat_circ
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
    connect(Feed_Resistance.port_a, steam_Drum_SI_5_1.feed_port) annotation (Line(points={{-51,38},{16,38}}, color={0,127,255}));
    connect(EvaporatorResistance.port_b,steam_Drum_SI_5_1. riser_port)
      annotation (Line(points={{30,5},{30,28}},                               color={244,125,35}));
    connect(steam_Drum_SI_5_1.RelLevel,threeElementContoller. Level) annotation (Line(points={{36.2,38},{38,38},{38,91},{10.4,91}},
                                                            color={0,0,127}));
    connect(Evaporator.port_b_shell,Gas_Resistance. port_a)
      annotation (Line(points={{30.6,-54},{30.6,-96},{-60,-96},{-60,-110},{-69,-110}},
                                                                 color={0,140,72}));
    connect(valveLinear.port_b,massFlowRate. port_a)
      annotation (Line(points={{-90,78},{-84,78},{-84,62},{-108,62},{-108,38},{-104,38}},
                                                     color={0,127,255}));
    connect(ECON_Downcomer.port_b,Economizer. port_a_tube)
      annotation (Line(points={{-74,-52},{-74,-58},{-56,-58},{-56,-48}},     color={0,127,255}));
    connect(SH_Downcomer.port_b,Superheater. port_a_tube)
      annotation (Line(points={{54,-48},{54,-52},{82,-52},{82,-46}}, color={238,46,47}));
    connect(Evaporator.port_a_shell,Gas_Resistance_2. port_b)
      annotation (Line(points={{30.6,-34},{30.6,-24},{40,-24},{40,-82},{60,-82},{60,-112},{119,-112}},
                                                                                  color={0,140,72}));
    connect(Gas_Inlet_Port, Superheater.port_a_shell) annotation (Line(points={{160,0},{154,0},{154,-20},{86.6,-20},{86.6,-26}},
                                                                                                                   color={0,140,72}));
    connect(Gas_Outlet_Port, Economizer.port_b_shell)
      annotation (Line(points={{-160,0},{-118,0},{-118,-72},{-51.4,-72},{-51.4,-48}},   color={0,140,72}));
    connect(Feed_port, Booster_Pump.port_a) annotation (Line(points={{0,-160},{0,-148},{-148,-148},{-148,50},{-134,50}},
                                                                                                     color={0,127,255}));
    connect(Booster_Pump.in_m_flow, threeElementContoller.y)
      annotation (Line(points={{-124,57.3},{-124,91},{-17.2,91}},                                         color={0,0,127}));
    connect(Feed_port, valveLinear.port_a) annotation (Line(points={{0,-160},{0,-148},{-148,-148},{-148,78},{-110,78}}, color={0,127,255}));
    connect(Booster_Pump.port_b, massFlowRate.port_a) annotation (Line(points={{-114,50},{-108,50},{-108,38},{-104,38}}, color={0,127,255}));
    connect(SH_Downcomer.port_a, steam_Drum_SI_5_1.steam_port) annotation (Line(points={{54,-28},{54,48},{26,48}},   color={238,46,47}));
    connect(massFlowRate.port_b, ECON_Downcomer.port_a) annotation (Line(points={{-84,38},{-74,38},{-74,-32}}, color={0,127,255}));
    connect(Superheater.port_b_tube, massFlowRate1.port_a) annotation (Line(points={{82,-26},{82,60}},            color={238,46,47}));
    connect(massFlowRate.port_b, Feed_Resistance.port_b) annotation (Line(points={{-84,38},{-65,38}}, color={0,127,255}));
    connect(steam_Drum_SI_5_1.steam_port, Steam_Resistance.port_b) annotation (Line(points={{26,48},{57,48}},  color={238,46,47}));
    connect(Steam_Resistance.port_a, massFlowRate1.port_a) annotation (Line(points={{71,48},{82,48},{82,60}},
                                                                                                        color={238,46,47}));
    connect(Economizer.port_b_tube, steam_Drum_SI_5_1.feed_port) annotation (Line(points={{-56,-28},{-56,38},{16,38}}, color={0,127,255}));
    connect(Gas_Resistance.port_b, Gas_Outlet_Port) annotation (Line(points={{-83,-110},{-118,-110},{-118,0},{-160,0}},     color={0,140,72}));
    connect(Superheater.port_b_shell, Evaporator.port_a_shell)
      annotation (Line(points={{86.6,-46},{86.6,-54},{40,-54},{40,-24},{30.6,-24},{30.6,-34}},   color={0,140,72}));
    connect(Gas_Resistance_2.port_a, Gas_Inlet_Port) annotation (Line(points={{133,-112},{154,-112},{154,0},{160,0}},     color={0,140,72}));
    connect(massFlowRate1.port_b, pressure_Control_Valve.port_a) annotation (Line(points={{82,80},{82,130},{50,130}},
                                                                                                              color={238,46,47}));
    connect(pressure_Control_Valve.port_b, Steam_Outlet_port) annotation (Line(points={{30,130},{0,130},{0,160}},
                                                                                                           color={238,46,47}));
    connect(steam_Drum_SI_5_1.downcomer_port, DowncomerResistance.port_b)
      annotation (Line(points={{22,28},{22,4},{-14,4},{-14,-7}}, color={244,125,35}));
    connect(Economizer.port_a_shell, Evaporator.port_b_shell)
      annotation (Line(points={{-51.4,-28},{-52,-28},{-52,-24},{-44,-24},{-44,-96},{30.6,-96},{30.6,-54}}, color={0,140,72}));
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
end HRSGs;
