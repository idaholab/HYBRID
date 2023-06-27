within NHES.Systems.PrimaryHeatSystem.HTGR;
package BraytonCycle

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model ReactorBOPIntegrated_Brayton_Simple
      extends Modelica.Icons.Example;
      NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.Models.PebbleBed_Brayton
        Pebble_Bed_HTGR(
        redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Basic
          CS,
        redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED,
        redeclare package Coolant_Medium =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(extent={{-48,-42},{20,22}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        m_flow=0,
        T=373.15,
        nPorts=1) annotation (Placement(transformation(extent={{-88,0},{-68,20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=1500000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-88,-36},{-64,-12}})));
      ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
        annotation (Placement(transformation(extent={{62,-20},{82,0}})));
    equation
      connect(Pebble_Bed_HTGR.auxiliary_heating_port_a, boundary2.ports[1])
        annotation (Line(points={{-48,9.2},{-48,10},{-68,10}}, color={0,127,255}));
      connect(Pebble_Bed_HTGR.auxiliary_heating_port_b, boundary1.ports[1])
        annotation (Line(points={{-48,-24.72},{-64,-24.72},{-64,-24}},
            color={0,127,255}));
      connect(EG.portElec_a, Pebble_Bed_HTGR.port_a)
        annotation (Line(points={{62,-10},{20,-10}}, color={255,0,0}));
      annotation (experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"));
    end ReactorBOPIntegrated_Brayton_Simple;

    model ReactorBOPIntegrated_Brayton_Complex
      extends Modelica.Icons.Example;
      NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.Models.PebbleBed_Brayton_CC
        Pebble_Bed_HTGR(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Basic
          CS, redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED) annotation (Placement(transformation(extent={{-48,-44},{22,24}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Intercooler_Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=20,
        T=306.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{54,-62},{34,-42}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={14,-52})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T3(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-8,9},{8,-9}},
            rotation=270,
            origin={-32,-59})));
      TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
        p_a_start=200000,
        p_b_start=1000,
        T_a_start=433.15,
        T_b_start=383.15,
        m_flow_start=65,
        m_flow_nominal=65,
        p_inlet_nominal=400000,
        p_outlet_nominal=1000,
        T_nominal=433.15)
        annotation (Placement(transformation(extent={{-26,-90},{-4,-68}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1)
        annotation (Placement(transformation(extent={{38,-86},{18,-66}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{4,-94},{24,-74}})));
      ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
        annotation (Placement(transformation(extent={{80,-22},{116,14}})));
    equation
      connect(Water_T1.port_a,Intercooler_Source. ports[1])
        annotation (Line(points={{24,-52},{34,-52}},          color={0,127,255}));
      connect(Water_T3.port_b,steamTurbine. portHP) annotation (Line(points={{-32,-67},
              {-32,-72.4},{-26,-72.4}},                               color={0,127,255}));
      connect(steamTurbine.portLP,boundary7. ports[1]) annotation (Line(points={{-4,
              -72.4},{-4,-68},{14,-68},{14,-72},{18,-72},{18,-76}},
                                               color={0,127,255}));
      connect(steamTurbine.shaft_b,generator. shaft) annotation (Line(points={{-4,-79},
              {-4,-78},{0,-78},{0,-84.1},{3.9,-84.1}},             color={0,0,0}));
      connect(Water_T1.port_b, Pebble_Bed_HTGR.combined_cycle_port_a) annotation (
          Line(points={{4,-52},{-2,-52},{-2,-44},{-1.8,-44}},
                                                       color={0,127,255}));
      connect(Water_T3.port_a, Pebble_Bed_HTGR.combined_cycle_port_b) annotation (
          Line(points={{-32,-51},{-32.6,-51},{-32.6,-44}},   color={0,127,255}));
      connect(EG.portElec_a, Pebble_Bed_HTGR.port_a)
        annotation (Line(points={{80,-4},{80,-3.2},{22,-3.2}}, color={255,0,0}));
    end ReactorBOPIntegrated_Brayton_Complex;

    model ReactorBOPIntegrated_Brayton_WorkshopDemo
      extends Modelica.Icons.Example;
      Real total_efficiency;
      Models.PebbleBed_Brayton_CC Pebble_Bed_HTGR(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Basic
          CS, redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED) annotation (Placement(transformation(extent={{-48,-20},{20,44}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Intercooler_Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=20,
        T=306.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{58,-40},{38,-20}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-6,8},{6,-8}},
            rotation=180,
            origin={18,-30})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Water_T3(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{8,9},{-8,-9}},
            rotation=270,
            origin={-92,-15})));
      TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
        nUnits=2,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=400000,
        p_b_start=1000,
        T_a_start=433.15,
        T_b_start=323.15,
        m_flow_start=20,
        partialArc_nominal=0.1,
        m_flow_nominal=20,
        use_Stodola=true,
        Kt_constant=0.025,
        use_NominalInlet=false,
        p_inlet_nominal=400000,
        p_outlet_nominal=8000,
        T_nominal=433.15)
        annotation (Placement(transformation(extent={{-82,-58},{-54,-30}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph CC_Dump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=10000,
        nPorts=1) annotation (Placement(transformation(
            extent={{4,-5},{-4,5}},
            rotation=90,
            origin={-42,-31})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{-42,-58},{-16,-32}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Steam_Offtake_Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        m_flow=15,
        T=308.15,
        nPorts=1) annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
      ElectricalGrid.InfiniteGrid.Infinite EG(Q_nominal=280e6)
        annotation (Placement(transformation(extent={{50,-6},{104,42}})));
      EnergyStorage.Concrete_Solid_Media.Components.Dual_Pipe_Model_Two_HTFs
        dual_Pipe_Model_Two_HTFs(Hot_Con_Start=673.15, Cold_Con_Start=398.15)
        annotation (Placement(transformation(extent={{-54,-14},{-82,6}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Offtake_Dump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=2000000,
        nPorts=1) annotation (Placement(transformation(
            extent={{3,-4},{-3,4}},
            rotation=90,
            origin={-72,13})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=12,
        rising=300,
        width=6600,
        falling=300,
        period=18000,
        nperiod=22)
        annotation (Placement(transformation(extent={{-104,34},{-96,42}})));
    equation
      total_efficiency = (steamTurbine.Q_mech+Pebble_Bed_HTGR.port_a.W)/Pebble_Bed_HTGR.core.Q_total.y;
      connect(Water_T1.port_a,Intercooler_Source. ports[1])
        annotation (Line(points={{24,-30},{38,-30}},          color={0,127,255}));
      connect(steamTurbine.shaft_b,generator. shaft) annotation (Line(points={{-54,-44},
              {-54,-45.13},{-42.13,-45.13}},                       color={0,0,0}));
      connect(Water_T1.port_b, Pebble_Bed_HTGR.combined_cycle_port_a) annotation (
          Line(points={{12,-30},{-2,-30},{-2,-24},{-3.12,-24},{-3.12,-20}},
                                                       color={0,127,255}));
      connect(Water_T3.port_a, Pebble_Bed_HTGR.combined_cycle_port_b) annotation (
          Line(points={{-92,-23},{-92,-68},{-12,-68},{-12,-32},{-33.04,-32},{-33.04,
              -20}},                                         color={0,127,255}));
      connect(EG.portElec_a, Pebble_Bed_HTGR.port_a) annotation (Line(points={{50,18},
              {20,18.4}},                         color={255,0,0}));
      connect(dual_Pipe_Model_Two_HTFs.Charge_Outlet, Steam_Offtake_Dump.ports[1])
        annotation (Line(points={{-72.2,2.2},{-72,10}}, color={0,127,255}));
      connect(steamTurbine.portHP, dual_Pipe_Model_Two_HTFs.Discharge_Outlet)
        annotation (Line(points={{-82,-35.6},{-86,-35.6},{-86,-26},{-66,-26},{-66,
              -9.6},{-65.76,-9.6}},
                       color={0,127,255}));
      connect(Water_T3.port_b, dual_Pipe_Model_Two_HTFs.Discharge_Inlet)
        annotation (Line(points={{-92,-7},{-92,-4.2},{-78.92,-4.2}},
                                color={0,127,255}));
      connect(trapezoid.y, Steam_Offtake_Source.m_flow_in) annotation (Line(points={{-95.6,
              38},{-86,38}},                           color={0,0,127}));
      connect(steamTurbine.portLP, CC_Dump.ports[1]) annotation (Line(points={{-54,
              -35.6},{-54,-38},{-42,-38},{-42,-35}},                     color={0,
              127,255}));
      connect(dual_Pipe_Model_Two_HTFs.Charge_Inlet, Pebble_Bed_HTGR.auxiliary_heating_port_b)
        annotation (Line(points={{-57.08,-1.8},{-48,-2.72}}, color={0,127,255}));
      connect(Steam_Offtake_Source.ports[1], Pebble_Bed_HTGR.auxiliary_heating_port_a)
        annotation (Line(points={{-66,30},{-66,31.2},{-48,31.2}}, color={0,127,255}));
      annotation (experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"));
    end ReactorBOPIntegrated_Brayton_WorkshopDemo;
  end Examples;

  package Models

    model PebbleBed_Brayton
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Simple
          CS,
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED,
        redeclare Data.Model_HTGR_Pebble_BraytonCycle data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          LP_Comp_Efficiency=0.88,
          HP_Comp_Efficiency=0.88,
          HX_Reheat_NTU=15,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          nPebble=1056000));

      replaceable package Coolant_Medium =
         Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                        annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

        Modelica.Units.SI.Power Q_gen;
        Real cycle_eff;

        parameter Real eff = 0.9;
      TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_Core_Outlet,
        T_start=data.T_Core_Outlet,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-72,-32})));
      GasTurbine.Turbine.Turbine      turbine(
        redeclare package Medium =
           Coolant_Medium,
        pstart_out=data.P_Turbine_Ref,
        Tstart_in=data.TStart_In_Turbine,
        Tstart_out=data.TStart_Out_Turbine,
        eta0=data.Turbine_Efficiency,
        PR0=data.Turbine_Pressure_Ratio,
        w0=data.Turbine_Nominal_MassFlowRate)
                annotation (Placement(transformation(extent={{-72,-16},{-20,22}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
        NTU=data.HX_Reheat_NTU,
        K_tube=data.HX_Reheat_K_tube,
        K_shell=data.HX_Reheat_K_shell,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium =
            Coolant_Medium,
        V_Tube=data.HX_Reheat_Tube_Vol,
        V_Shell=data.HX_Reheat_Shell_Vol,
        p_start_tube=data.Recuperator_P_Tube,
        use_T_start_tube=true,
        T_start_tube_inlet=673.15,
        T_start_tube_outlet=673.15,
        h_start_tube_inlet=data.Recuperator_h_Tube_Inlet,
        h_start_tube_outlet=data.Recuperator_h_Tube_Outlet,
        p_start_shell=data.Recuperator_P_Tube,
        use_T_start_shell=true,
        T_start_shell_inlet=673.15,
        T_start_shell_outlet=673.15,
        h_start_shell_inlet=data.Recuperator_h_Shell_Inlet,
        h_start_shell_outlet=data.HX_Aux_h_tube_out,
        dp_init_tube=data.Recuperator_dp_Tube,
        dp_init_shell=data.Recuperator_dp_Shell,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=data.Recuperator_m_Tube,
        m_start_shell=data.Recuperator_m_Shell)
        annotation (Placement(transformation(extent={{10,-36},{-10,-16}})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={28,-6})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_HP_Comp_Ref,
        T_start=data.T_Precooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0),
        use_HeatPort=true) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={28,32})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary3(use_port=
            false, T=data.T_Precooler)
        annotation (Placement(transformation(extent={{6,-6},{-6,6}},
            rotation=180,
            origin={10,32})));
      GasTurbine.Compressor.Compressor      compressor(
        redeclare package Medium =
            Coolant_Medium,
        pstart_in=data.P_LP_Comp_Ref,
        Tstart_in=data.TStart_LP_Comp_In,
        Tstart_out=data.TStart_LP_Comp_Out,
        eta0=data.LP_Comp_Efficiency,
        PR0=data.LP_Comp_P_Ratio,
        w0=data.LP_Comp_MassFlowRate)
                annotation (Placement(transformation(extent={{34,22},{78,54}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                           transportDelayPipe(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={84,28})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_LP_Comp_Ref,
        T_start=data.T_Intercooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.0),
        use_HeatPort=true,
        Q_gen=0)           annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={84,-48})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
            false, T=data.T_Intercooler)
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=180,
            origin={106,-48})));
      GasTurbine.Compressor.Compressor      compressor1(
        redeclare package Medium =
            Coolant_Medium,
        allowFlowReversal=false,
        pstart_in=data.P_HP_Comp_Ref,
        Tstart_in=data.TStart_HP_Comp_In,
        Tstart_out=data.TStart_HP_Comp_Out,
        eta0=data.HP_Comp_Efficiency,
        PR0=data.HP_Comp_P_Ratio,
        w0=data.HP_Comp_MassFlowRate)
                annotation (Placement(transformation(extent={{25,-18},{-25,18}},
            rotation=0,
            origin={55,-82})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                           transportDelayPipe1(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-52})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
        springBallValve(
        redeclare package Medium = Coolant_Medium,
        p_spring=data.P_Release,
        K=data.K_P_Release,
        opening_init=0.) annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={8,54})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
        redeclare package Medium = Coolant_Medium,
        p=data.P_Release,
        nPorts=1)
        annotation (Placement(transformation(extent={{4,-4},{-4,4}},
            rotation=90,
            origin={8,70})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
          Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-6,8},{6,-8}},
            rotation=180,
            origin={-26,-46})));

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.Coolant_Medium,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
        tube_av_b=false,
        shell_av_b=false,
        NTU=1,
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium = Aux_Heat_App_Medium,
        V_Tube=3,
        V_Shell=3,
        p_start_tube=5920000,
        use_T_start_tube=true,
        T_start_tube_inlet=1123.15,
        T_start_tube_outlet=1123.15,
        h_start_tube_inlet=3600e3,
        h_start_tube_outlet=2900e3,
        p_start_shell=1000000,
        h_start_shell_inlet=600e3,
        h_start_shell_outlet=1000e3,
        dp_init_tube=30000,
        dp_init_shell=40000,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=296.1,
        m_start_shell=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-84,4})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
          package Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={84,-18})));
      TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-70,-74})));
      Modelica.Fluid.Interfaces.FluidPort_a auxiliary_heating_port_a(redeclare
          package Medium =
                   Aux_Heat_App_Medium)  annotation (
          Placement(transformation(extent={{-110,50},{-90,70}}),
            iconTransformation(extent={{-110,50},{-90,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b auxiliary_heating_port_b(redeclare
          package Medium =
                   Aux_Heat_App_Medium)  annotation (
          Placement(transformation(extent={{-110,-56},{-90,-36}}),
                                                                 iconTransformation(
              extent={{-110,-56},{-90,-36}})));

      TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a annotation (
          Placement(transformation(extent={{90,-10},{110,10}}),
            iconTransformation(extent={{90,-10},{110,10}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{78,94},{90,108}})));
      Modelica.Blocks.Sources.RealExpression PR_Compressor(y=core.port_a.m_flow)
        "total thermal power"
        annotation (Placement(transformation(extent={{-104,94},{-92,106}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        nPebble=1056000,
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (
            d_pebble=2*data.r_Pebble,
            nPebble=data.Pebble,
            packing_factor=0.55),
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input=600000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = data.P_Core_Outlet,
        Q_nominal=600000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = data.P_Core_Inlet,
        T_a_start(displayUnit="K") = data.T_Core_Inlet,
        T_b_start(displayUnit="K") = data.T_Core_Outlet,
        m_flow_a_start=data.m_flow,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.2,0.3,0.3,0.2},
        nParallel=data.nAssembly,
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-50,-46})));

    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
     Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
     cycle_eff = Q_gen / core.Q_total.y;

        port_a.W = Q_gen;
      connect(Precooler.heatPort, boundary3.port)
        annotation (Line(points={{22,32},{16,32}},color={191,0,0}));
      connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{28,38},
              {28,56},{48,56},{48,50.8},{42.8,50.8}},
                                            color={0,127,255}));
      connect(Intercooler.heatPort, boundary4.port)
        annotation (Line(points={{90,-48},{100,-48}},      color={191,0,0}));
      connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
            points={{40,-67.6},{40,-68},{20,-68},{20,-62}},              color={0,
              127,255}));
      connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{84,-54},
              {84,-68},{70,-68},{70,-67.6}},color={0,127,255}));
      connect(springBallValve.port_b,boundary5. ports[1])
        annotation (Line(points={{8,60},{8,66}},              color={0,127,255}));
      connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{8,48},{
              28,48},{28,38}},                        color={0,127,255}));
      connect(Reheater.Shell_in, transportDelayPipe1.port_b)
        annotation (Line(points={{10,-28},{20,-28},{20,-42}},
                                                          color={0,127,255}));
      connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-10,-28},
              {-14,-28},{-14,-46},{-20,-46}},            color={0,127,255}));
      connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-30.4,18.2},
              {-30.4,18},{-16,18},{-16,-22},{-10,-22}},
                                                  color={0,127,255}));
      connect(Reheater.Tube_out, sensor_T.port_a)
        annotation (Line(points={{10,-22},{28,-22},{28,-16}},
                                                           color={0,127,255}));
      connect(Core_Outlet.port_b, Steam_Offtake.Tube_in) annotation (Line(points={{-72,-26},
              {-72,-18},{-80,-18},{-80,-6}},              color={0,127,255}));
      connect(Steam_Offtake.Tube_out, turbine.inlet) annotation (Line(points={{-80,14},
              {-80,26},{-62,26},{-62,22},{-61.6,22},{-61.6,18.2}},
                                        color={0,127,255}));
      connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{69.2,
              50.8},{74,50.8},{74,58},{84,58},{84,38}},
                                                color={0,127,255}));
      connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
          Line(points={{84,18},{84,-8}},                     color={0,127,255}));
      connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
        annotation (Line(points={{84,-42},{84,-28}}, color={0,127,255}));
      connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-70,-64},
              {-70,-46},{-72,-46},{-72,-38}},      color={0,127,255}));
      connect(auxiliary_heating_port_a, Steam_Offtake.Shell_in) annotation (Line(
            points={{-100,60},{-86,60},{-86,14}},
            color={0,0,0}));
      connect(Steam_Offtake.Shell_out, auxiliary_heating_port_b) annotation (Line(
            points={{-86,-6},{-86,-46},{-100,-46}},
            color={0,0,0}));
      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,101},{76.8,101}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, Core_Outlet_T.T) annotation (Line(
          points={{-30,100},{-30,74},{-114,74},{-114,-74},{-76,-74}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(sensor_T.port_b, Precooler.port_a) annotation (Line(points={{28,4},{
              28,26}},                   color={0,127,255}));
      connect(sensorBus.Core_Mass_Flow, PR_Compressor.y) annotation (Line(
          points={{-30,100},{-91.4,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(Core_Inlet_T.port_b, core.port_a)
        annotation (Line(points={{-32,-46},{-40,-46}}, color={0,127,255}));
      connect(Core_Outlet.port_a, core.port_b) annotation (Line(points={{-72,-38},{
              -72,-46},{-60,-46}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000,
          __Dymola_NumberOfIntervals=591,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>Three ports allow this model to be interconnected to outside components. There are two fluid ports and one electrical port. The electrical port should be connected to some grid or electrical distribution model. </p>
<p>Two fluid ports on the side of the model are used for a thermal application by removing heat from the Helium coolant upstream of the turbine. Note that this is not a bypass flow as it has been in steam systems, although that may be used in the future (the system should be evaluated to determine which method is more efficient). </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
<p>It is necessary to have pressure relief within the system. In this model, this is done via a spring valve that opens just upstream of the first compressor. </p>
</html>"));
    end PebbleBed_Brayton;

    model PebbleBed_Brayton_CC
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Simple
          CS,
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED,
        redeclare Data.Model_HTGR_Pebble_BraytonCycle data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          nPebble=1056000));

      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                          annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

        Modelica.Units.SI.Power Q_gen;
        Real cycle_eff;

        Modelica.Units.SI.Power Q_Trans;
        parameter Real eff = 0.9;
      TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_Core_Outlet,
        T_start=data.T_Core_Outlet,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-68,-20})));
      GasTurbine.Turbine.Turbine      turbine(
        redeclare package Medium =
           Coolant_Medium,
        pstart_out=data.P_Turbine_Ref,
        Tstart_in=data.TStart_In_Turbine,
        Tstart_out=data.TStart_Out_Turbine,
        eta0=data.Turbine_Efficiency,
        PR0=data.Turbine_Pressure_Ratio,
        w0=data.Turbine_Nominal_MassFlowRate)
                annotation (Placement(transformation(extent={{-72,-16},{-20,22}})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
        NTU=data.HX_Reheat_NTU,
        K_tube=data.HX_Reheat_K_tube,
        K_shell=data.HX_Reheat_K_shell,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium =
            Coolant_Medium,
        V_Tube=data.HX_Reheat_Tube_Vol,
        V_Shell=data.HX_Reheat_Shell_Vol,
        p_start_tube=data.Recuperator_P_Tube,
        use_T_start_tube=true,
        T_start_tube_inlet=873.15,
        T_start_tube_outlet=873.15,
        h_start_tube_inlet=data.Recuperator_h_Tube_Inlet,
        h_start_tube_outlet=data.Recuperator_h_Tube_Outlet,
        p_start_shell=data.Recuperator_P_Tube,
        use_T_start_shell=true,
        T_start_shell_inlet=873.15,
        T_start_shell_outlet=873.15,
        h_start_shell_inlet=data.Recuperator_h_Shell_Inlet,
        h_start_shell_outlet=data.HX_Aux_h_tube_out,
        dp_init_tube=data.Recuperator_dp_Tube,
        dp_init_shell=data.Recuperator_dp_Shell,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=data.Recuperator_m_Tube,
        m_start_shell=data.Recuperator_m_Shell)
        annotation (Placement(transformation(extent={{10,-36},{-10,-16}})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={12,-6})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_HP_Comp_Ref,
        T_start=data.T_Precooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0),
        use_HeatPort=true) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={26,34})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Precooler_Temp(use_port=
            false, T=data.T_Precooler) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-2,34})));
      GasTurbine.Compressor.Compressor      compressor(
        redeclare package Medium =
            Coolant_Medium,
        pstart_in=data.P_LP_Comp_Ref,
        Tstart_in=data.TStart_LP_Comp_In,
        Tstart_out=data.TStart_LP_Comp_Out,
        eta0=data.LP_Comp_Efficiency,
        PR0=data.LP_Comp_P_Ratio,
        w0=data.LP_Comp_MassFlowRate)
                annotation (Placement(transformation(extent={{40,28},{84,60}})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                           transportDelayPipe(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={84,20})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_LP_Comp_Ref,
        T_start=data.T_Intercooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.0),
        use_HeatPort=true,
        Q_gen=-Q_Trans)    annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={84,-62})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Intercooler_Temp(use_port=
            false, T=data.T_Intercooler) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={110,-62})));
      GasTurbine.Compressor.Compressor      compressor1(
        redeclare package Medium =
            Coolant_Medium,
        allowFlowReversal=false,
        pstart_in=data.P_HP_Comp_Ref,
        Tstart_in=data.TStart_HP_Comp_In,
        Tstart_out=data.TStart_HP_Comp_Out,
        eta0=data.HP_Comp_Efficiency,
        PR0=data.HP_Comp_P_Ratio,
        w0=data.HP_Comp_MassFlowRate)
                annotation (Placement(transformation(extent={{25,18},{-25,-18}},
            rotation=0,
            origin={-1,-94})));
      TRANSFORM.Fluid.Pipes.TransportDelayPipe
                                           transportDelayPipe1(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-52})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
        springBallValve(
        redeclare package Medium = Coolant_Medium,
        p_spring=data.P_Release,
        K=data.K_P_Release,
        opening_init=0.) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={4,58})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
        redeclare package Medium = Coolant_Medium,
        p=data.P_Release,
        nPorts=1)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={4,86})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
          Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-6,8},{6,-8}},
            rotation=180,
            origin={-16,-46})));


      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
        shell_av_b=false,
        NTU=1.6,
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium = Aux_Heat_App_Medium,
        V_Tube=3,
        V_Shell=3,
        p_start_tube=5920000,
        h_start_tube_inlet=3600e3,
        h_start_tube_outlet=2900e3,
        p_start_shell=1000000,
        h_start_shell_inlet=600e3,
        h_start_shell_outlet=1000e3,
        dp_init_tube=30000,
        dp_init_shell=40000,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=296.1,
        m_start_shell=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,20})));
      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Reheat_Waste(
        NTU=10,
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium = Waste_Heat_App_Medium,
        V_Tube=0.1,
        V_Shell=0.1,
        p_start_tube=1990000,
        use_T_start_tube=true,
        T_start_tube_inlet=673.15,
        T_start_tube_outlet=673.15,
        h_start_tube_inlet=2307e3,
        h_start_tube_outlet=3600e3,
        p_start_shell=400000,
        use_T_start_shell=true,
        T_start_shell_inlet=673.15,
        T_start_shell_outlet=673.15,
        h_start_shell_inlet=600e3,
        h_start_shell_outlet=700e3,
        dp_init_tube=30000,
        dp_init_shell=40000,
        Q_init=-1e7,
        Cr_init=0.8,
        m_start_tube=296.1,
        m_start_shell=296.1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={46,-12})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Waste_Heat_Vol(
        redeclare package Medium = Waste_Heat_App_Medium,
        p_start=450000,
        T_start=353.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0),
        Q_gen=Q_Trans) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={66,-58})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
          package Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={84,-32})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Mid_Temp(redeclare package
          Medium = Waste_Heat_App_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={66,4})));
      TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-68,-58})));
      Modelica.Fluid.Interfaces.FluidPort_a combined_cycle_port_a(redeclare
          package Medium =
                   Waste_Heat_App_Medium)                         annotation (
          Placement(transformation(extent={{22,-110},{42,-90}}),
                                                               iconTransformation(
              extent={{22,-110},{42,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b combined_cycle_port_b(redeclare
          package Medium =
                   Waste_Heat_App_Medium)                         annotation (
          Placement(transformation(extent={{-66,-110},{-46,-90}}),
                                                                 iconTransformation(
              extent={{-66,-110},{-46,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_a auxiliary_heating_port_a(redeclare
          package Medium =
                   Aux_Heat_App_Medium)  annotation (
          Placement(transformation(extent={{-110,50},{-90,70}}),
            iconTransformation(extent={{-110,50},{-90,70}})));
      Modelica.Fluid.Interfaces.FluidPort_b auxiliary_heating_port_b(redeclare
          package Medium =
                   Aux_Heat_App_Medium)  annotation (
          Placement(transformation(extent={{-110,-56},{-90,-36}}),
                                                                 iconTransformation(
              extent={{-110,-56},{-90,-36}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Inlet_Temp(redeclare
          package Medium =
                   Waste_Heat_App_Medium) annotation (Placement(transformation(
            extent={{8,7},{-8,-7}},
            rotation=270,
            origin={66,-85})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort CC_Outlet_Temp(redeclare
          package Medium =
                   Waste_Heat_App_Medium) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={44,-74})));

      TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a annotation (
          Placement(transformation(extent={{90,10},{110,30}}),
            iconTransformation(extent={{90,10},{110,30}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{74,78},{86,92}})));
      TRANSFORM.Blocks.RealExpression PR_Compressor
        annotation (Placement(transformation(extent={{74,66},{86,80}})));
      Modelica.Blocks.Sources.RealExpression Core_M_flow(y=core.port_a.m_flow)
        annotation (Placement(transformation(extent={{-60,104},{-48,118}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (
            d_pebble=2*data.r_Pebble,
            nPebble=data.Pebble,
            packing_factor=0.55),
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input=600000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = data.P_Core_Outlet,
        Q_nominal=600000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = data.P_Core_Inlet,
        T_a_start(displayUnit="K") = data.T_Core_Inlet,
        T_b_start(displayUnit="K") = data.T_Core_Outlet,
        m_flow_a_start=data.m_flow,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.2,0.3,0.3,0.2},
        nParallel=data.nAssembly,
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-44,-46})));

    initial equation
      Q_Trans = 1e7;
    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
     Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
     cycle_eff = Q_gen / core.Q_total.y;

     der(Q_Trans) =eff*min(abs(Intercooler_Pre_Temp.port_a.m_flow*
        Coolant_Medium.specificHeatCapacityCp(Coolant_Medium.setState_pT(
        Intercooler_Pre_Temp.port_a.p, Intercooler_Pre_Temp.T))*(
        Intercooler_Pre_Temp.T - CC_Inlet_Temp.T)), abs(CC_Inlet_Temp.port_a.m_flow*
        (CC_Inlet_Temp.Medium.specificEnthalpy_pT(CC_Inlet_Temp.port_a.p,
        Intercooler_Pre_Temp.T) - CC_Inlet_Temp.Medium.specificEnthalpy_pT(CC_Inlet_Temp.port_a.p,
        CC_Inlet_Temp.T)))) - Q_Trans;
        port_a.W = Q_gen;
      connect(Precooler.heatPort, Precooler_Temp.port)
        annotation (Line(points={{20,34},{8,34}}, color={191,0,0}));
      connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{26,40},{
              26,56},{48,56},{48,56.8},{48.8,56.8}},
                                            color={0,127,255}));
      connect(Intercooler.heatPort, Intercooler_Temp.port)
        annotation (Line(points={{90,-62},{100,-62}}, color={191,0,0}));
      connect(compressor1.outlet, transportDelayPipe1.port_a) annotation (Line(
            points={{-16,-108.4},{-16,-116},{-74,-116},{-74,-72},{20,-72},{20,-62}},
                                                                         color={0,
              127,255}));
      connect(Intercooler.port_b, compressor1.inlet) annotation (Line(points={{84,-68},
              {84,-118},{14,-118},{14,-108.4}},
                                            color={0,127,255}));
      connect(springBallValve.port_b,boundary5. ports[1])
        annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
      connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
              4,44},{26,44},{26,40}},                 color={0,127,255}));
      connect(Reheater.Shell_in, transportDelayPipe1.port_b)
        annotation (Line(points={{10,-28},{20,-28},{20,-42}},
                                                          color={0,127,255}));
      connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-10,-28},
              {-10,-46}},                                color={0,127,255}));
      connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-30.4,18.2},
              {-30.4,18},{-12,18},{-12,-22},{-10,-22}},
                                                  color={0,127,255}));
      connect(Reheater.Tube_out, sensor_T.port_a)
        annotation (Line(points={{10,-22},{26,-22},{26,-16},{12,-16}},
                                                           color={0,127,255}));
      connect(Core_Outlet.port_b, Steam_Offtake.Tube_in) annotation (Line(points={{-68,-14},
              {-86,-14},{-86,10}},                        color={0,127,255}));
      connect(Steam_Offtake.Tube_out, turbine.inlet) annotation (Line(points={{-86,30},
              {-86,34},{-60,34},{-60,20},{-61.6,20},{-61.6,18.2}},
                                        color={0,127,255}));
      connect(Steam_Reheat_Waste.Tube_in, sensor_T.port_b)
        annotation (Line(points={{42,-22},{42,-26},{28,-26},{28,8},{12,8},{12,4}},
                                                   color={0,127,255}));
      connect(Steam_Reheat_Waste.Tube_out, Precooler.port_a) annotation (Line(
            points={{42,-2},{42,20},{26,20},{26,28}}, color={0,127,255}));
      connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{75.2,
              56.8},{74,56.8},{74,58},{84,58},{84,30}},
                                                color={0,127,255}));
      connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
          Line(points={{84,10},{84,-22}},                    color={0,127,255}));
      connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
        annotation (Line(points={{84,-56},{84,-42}}, color={0,127,255}));
      connect(Waste_Heat_Vol.port_b, CC_Mid_Temp.port_a) annotation (Line(points={{66,-52},
              {66,-8},{80,-8},{80,4},{76,4}},
                                          color={0,0,0}));
      connect(CC_Mid_Temp.port_b, Steam_Reheat_Waste.Shell_in) annotation (Line(
            points={{56,4},{48,4},{48,-2}},                color={0,0,0}));
      connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-68,-48},
              {-68,-26}},                          color={0,127,255}));
      connect(auxiliary_heating_port_a, Steam_Offtake.Shell_in) annotation (Line(
            points={{-100,60},{-86,60},{-86,36},{-92,36},{-92,30}},
            color={0,0,0}));
      connect(Steam_Offtake.Shell_out, auxiliary_heating_port_b) annotation (Line(
            points={{-92,10},{-92,-46},{-100,-46}},
            color={0,0,0}));
      connect(combined_cycle_port_a, CC_Inlet_Temp.port_a) annotation (Line(points={{32,-100},
              {32,-86},{54,-86},{54,-96},{66,-96},{66,-93}}, color={0,0,0}));
      connect(CC_Inlet_Temp.port_b, Waste_Heat_Vol.port_a)
        annotation (Line(points={{66,-77},{66,-64}},color={0,0,0}));
      connect(Steam_Reheat_Waste.Shell_out, CC_Outlet_Temp.port_a)
        annotation (Line(points={{48,-22},{48,-26},{54,-26},{54,-74}},
                                                              color={0,0,0}));
      connect(CC_Outlet_Temp.port_b, combined_cycle_port_b) annotation (Line(points={{34,-74},
              {-38,-74},{-38,-84},{-56,-84},{-56,-100}},
                                             color={0,0,0}));
      connect(combined_cycle_port_b, combined_cycle_port_b)
        annotation (Line(points={{-56,-100},{-56,-100}}, color={0,127,255}));
      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{66,100},{66,85},{72.8,85}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, Core_Outlet_T.T) annotation (Line(
          points={{-30,100},{-30,74},{-114,74},{-114,-60},{-82,-60},{-82,-58},{-74,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));

      connect(actuatorBus.PR_Compressor, PR_Compressor.u) annotation (Line(
          points={{30,100},{30,73},{72.8,73}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.Core_Mass_Flow, Core_M_flow.y) annotation (Line(
          points={{-30,100},{-47.4,111}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Core_Outlet_T.port, core.port_b) annotation (Line(points={{-68,-48},{
              -68,-46},{-54,-46}}, color={0,127,255}));
      connect(Core_Inlet_T.port_b, core.port_a)
        annotation (Line(points={{-22,-46},{-34,-46}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName=
                  "modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000,
          __Dymola_NumberOfIntervals=591,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>Five ports allow this model to be interconnected to outside components. There are four fluid ports and one electrical port. The electrical port should be connected to some grid or electrical distribution model. </p>
<p>Two ports on the side of the model are used for a thermal application by removing heat from the Helium coolant upstream of the turbine. Note that this is not a bypass flow as it has been in steam systems, although that may be used in the future (the system should be evaluated to determine which method is more efficient). </p>
<p>The two fluid ports on the bottom of the model feed and remove the combined cycle fluid (nominally steam). The combined cycle heat removal is calculated upstream of the intercooler and precooler. This means that the intercooler and precooler temperatures continue to dictate system temperatures. </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
<p>It is necessary to have pressure relief within the system. In this model, this is done via a spring valve that opens just upstream of the first compressor. </p>
</html>"));
    end PebbleBed_Brayton_CC;

    model PebbleBed_Brayton_FullRX
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Simple
          CS,
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED,
        redeclare Data.Model_HTGR_Pebble_BraytonCycle data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          nPebble=1056000));

      replaceable package Coolant_Medium =
          Modelica.Media.IdealGases.SingleGases.He                                    constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                              annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                      annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                             annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;
        package Medium =
          Modelica.Media.IdealGases.SingleGases.He;
        Modelica.Units.SI.Power Q_gen;
        Real cycle_eff;

        parameter Real eff = 0.9;
      TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_Core_Outlet,
        T_start=data.T_Core_Outlet,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-66,-26})));

      GasTurbine.Turbine.Turbine turbine(
        redeclare package Medium =
            Coolant_Medium,
        pstart_out=data.P_Turbine_Ref,
        Tstart_in=data.TStart_In_Turbine,
        Tstart_out=data.TStart_Out_Turbine,
        eta0=data.Turbine_Efficiency,
        PR0=data.Turbine_Pressure_Ratio,
        w0=data.Turbine_Nominal_MassFlowRate)
        annotation (Placement(transformation(extent={{-80,46},{-16,0}})));

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
        NTU=data.HX_Reheat_NTU,
        K_tube=data.HX_Reheat_K_tube,
        K_shell=data.HX_Reheat_K_shell,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium =
            Coolant_Medium,
        V_Tube=data.HX_Reheat_Tube_Vol,
        V_Shell=data.HX_Reheat_Shell_Vol,
        p_start_tube=data.Recuperator_P_Tube,
        use_T_start_tube=true,
        T_start_tube_inlet=773.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.Recuperator_h_Tube_Inlet,
        h_start_tube_outlet=data.Recuperator_h_Tube_Outlet,
        p_start_shell=data.Recuperator_P_Tube,
        use_T_start_shell=true,
        T_start_shell_inlet=573.15,
        T_start_shell_outlet=773.15,
        h_start_shell_inlet=data.Recuperator_h_Shell_Inlet,
        h_start_shell_outlet=data.HX_Aux_h_tube_out,
        dp_init_tube=data.Recuperator_dp_Tube,
        dp_init_shell=data.Recuperator_dp_Shell,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=data.Recuperator_m_Tube,
        m_start_shell=data.Recuperator_m_Shell)
        annotation (Placement(transformation(extent={{18,-18},{-2,2}})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={38,10})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_HP_Comp_Ref,
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
      GasTurbine.Compressor.Compressor compressor(
        redeclare package Medium =
            Coolant_Medium,
        pstart_in=data.P_LP_Comp_Ref,
        Tstart_in=data.TStart_LP_Comp_In,
        Tstart_out=data.TStart_LP_Comp_Out,
        eta0=data.LP_Comp_Efficiency,
        PR0=data.LP_Comp_P_Ratio,
        w0=data.LP_Comp_MassFlowRate)
        annotation (Placement(transformation(extent={{54,18},{98,50}})));

      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={100,20})));

      TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_LP_Comp_Ref,
        T_start=data.T_Intercooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.0),
        use_HeatPort=true) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,-54})));

      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
            false, T=data.T_Intercooler)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={78,-54})));
      GasTurbine.Compressor.Compressor compressor1(
        redeclare package Medium =
            Coolant_Medium,
        allowFlowReversal=false,
        pstart_in=data.P_HP_Comp_Ref,
        Tstart_in=data.TStart_HP_Comp_In,
        Tstart_out=data.TStart_HP_Comp_Out,
        eta0=data.HP_Comp_Efficiency,
        PR0=data.HP_Comp_P_Ratio,
        w0=data.HP_Comp_MassFlowRate) annotation (Placement(transformation(
            extent={{25,-18},{-25,18}},
            rotation=0,
            origin={73,-92})));

      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={56,-38})));

      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
        springBallValve(
        redeclare package Medium = Coolant_Medium,
        p_spring=data.P_Release,
        K=data.K_P_Release,
        opening_init=0.) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={4,58})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
        redeclare package Medium = Coolant_Medium,
        p=data.P_Release,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={4,86})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
          Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-8,-42})));

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.Coolant_Medium,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
          package Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={100,-16})));
      TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-76,-78})));
      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-8,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-102,-52},{-82,-32}})));
      Modelica.Blocks.Sources.Constant const1(k=850 + 273.15)
        annotation (Placement(transformation(extent={{-136,-52},{-116,-32}})));

      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (
            d_pebble=2*data.r_Pebble,
            nPebble=data.Pebble,
            packing_factor=0.55),
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input=600000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = data.P_Core_Outlet,
        Q_nominal=600000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = data.P_Core_Inlet,
        T_a_start(displayUnit="K") = data.T_Core_Inlet,
        T_b_start(displayUnit="K") = data.T_Core_Outlet,
        m_flow_a_start=data.m_flow,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.2,0.3,0.3,0.2},
        nParallel=data.nAssembly,
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-36,-62})));

    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
     Q_gen = turbine.Wt - compressor.Wc - compressor1.Wc;
     cycle_eff = Q_gen / core.Q_total.y;

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
      connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-2,-10},
              {-8,-10},{-8,-32}},                        color={0,127,255}));
      connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-28.8,4.6},
              {-28.8,-12},{-10,-12},{-10,-4},{-2,-4}},
                                                  color={0,127,255}));
      connect(Reheater.Tube_out, sensor_T.port_a)
        annotation (Line(points={{18,-4},{38,-4},{38,0}},  color={0,127,255}));
      connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{89.2,
              46.8},{90,46.8},{90,46},{100,46},{100,30}},
                                                color={0,127,255}));
      connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
          Line(points={{100,10},{100,-6}},                   color={0,127,255}));
      connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
        annotation (Line(points={{100,-48},{100,-26}},
                                                     color={0,127,255}));
      connect(Core_Outlet_T.T,CR. u_m) annotation (Line(points={{-82,-78},{-92,-78},
              {-92,-54}},       color={0,0,127}));
      connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-76,-68},
              {-76,-64},{-66,-64},{-66,-32}},      color={0,127,255}));
      connect(const1.y,CR. u_s) annotation (Line(points={{-115,-42},{-104,-42}},
                                     color={0,0,127}));
      connect(Core_Outlet.port_b, turbine.inlet) annotation (Line(points={{-66,-20},
              {-66,0},{-67.2,0},{-67.2,4.6}},
                                           color={0,127,255}));
      connect(sensor_T.port_b, Precooler.port_a)
        annotation (Line(points={{38,20},{38,32}}, color={0,127,255}));
      connect(Core_Inlet_T.port_b, core.port_a)
        annotation (Line(points={{-8,-52},{-8,-62},{-26,-62}}, color={0,127,255}));
      connect(Core_Outlet.port_a, core.port_b) annotation (Line(points={{-66,-32},{
              -66,-62},{-46,-62}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-90},{78,86}}, fileName=
                  "modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000,
          __Dymola_NumberOfIntervals=591,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is self-contained. It is recommended that anyone attempting to modify the HTGR-Brayton system begins by copying this model (including testing new control methods). </p>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
</html>"));
    end PebbleBed_Brayton_FullRX;

    model PebbleBed_Brayton_FullRX_Transient
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.CS_Basic_Transient_Example
          CS,
        redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.HTGR.BraytonCycle.ControlSystems.ED_Simple
          ED,
        redeclare Data.Model_HTGR_Pebble_BraytonCycle data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          nPebble=1056000));

      replaceable package Coolant_Medium =
          Modelica.Media.IdealGases.SingleGases.He                                    constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                              annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                      annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                             annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;
        package Medium =
          Modelica.Media.IdealGases.SingleGases.He;
        Modelica.Units.SI.Power Q_gen;
        Real cycle_eff;

        parameter Real eff = 0.9;
      TRANSFORM.Fluid.Volumes.SimpleVolume Core_Outlet(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_Core_Outlet,
        T_start=data.T_Core_Outlet,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-66,-26})));

      GasTurbine.Turbine.Turbine turbine(
        redeclare package Medium =
            Coolant_Medium,
        pstart_out=data.P_Turbine_Ref,
        Tstart_in=data.TStart_In_Turbine,
        Tstart_out=data.TStart_Out_Turbine,
        eta0=data.Turbine_Efficiency,
        PR0=data.Turbine_Pressure_Ratio,
        w0=data.Turbine_Nominal_MassFlowRate)
        annotation (Placement(transformation(extent={{-80,46},{-16,0}})));

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Reheater(
        NTU=data.HX_Reheat_NTU,
        K_tube=data.HX_Reheat_K_tube,
        K_shell=data.HX_Reheat_K_shell,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium =
            Coolant_Medium,
        V_Tube=data.HX_Reheat_Tube_Vol,
        V_Shell=data.HX_Reheat_Shell_Vol,
        p_start_tube=data.Recuperator_P_Tube,
        use_T_start_tube=true,
        T_start_tube_inlet=773.15,
        T_start_tube_outlet=573.15,
        h_start_tube_inlet=data.Recuperator_h_Tube_Inlet,
        h_start_tube_outlet=data.Recuperator_h_Tube_Outlet,
        p_start_shell=data.Recuperator_P_Tube,
        use_T_start_shell=true,
        T_start_shell_inlet=573.15,
        T_start_shell_outlet=773.15,
        h_start_shell_inlet=data.Recuperator_h_Shell_Inlet,
        h_start_shell_outlet=data.HX_Aux_h_tube_out,
        dp_init_tube=data.Recuperator_dp_Tube,
        dp_init_shell=data.Recuperator_dp_Shell,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=data.Recuperator_m_Tube,
        m_start_shell=data.Recuperator_m_Shell)
        annotation (Placement(transformation(extent={{18,-18},{-2,2}})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={38,10})));
      TRANSFORM.Fluid.Volumes.SimpleVolume Precooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_HP_Comp_Ref,
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
      GasTurbine.Compressor.Compressor compressor(
        redeclare package Medium =
            Coolant_Medium,
        pstart_in=data.P_LP_Comp_Ref,
        Tstart_in=data.TStart_LP_Comp_In,
        Tstart_out=data.TStart_LP_Comp_Out,
        eta0=data.LP_Comp_Efficiency,
        PR0=data.LP_Comp_P_Ratio,
        w0=data.LP_Comp_MassFlowRate)
        annotation (Placement(transformation(extent={{54,18},{98,50}})));

      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={100,20})));

      TRANSFORM.Fluid.Volumes.SimpleVolume Intercooler(
        redeclare package Medium =
            Coolant_Medium,
        p_start=data.P_LP_Comp_Ref,
        T_start=data.T_Intercooler,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=0.0),
        use_HeatPort=true) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,-54})));

      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature    boundary4(use_port=
            false, T=data.T_Intercooler)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={78,-54})));
      SupportComponents.Compressor_Controlled compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        allowFlowReversal=false,
        pstart_in=data.P_HP_Comp_Ref,
        Tstart_in=data.TStart_HP_Comp_In,
        Tstart_out=data.TStart_HP_Comp_Out,
        use_w0_port=true,
        eta0=data.HP_Comp_Efficiency,
        PR0=data.HP_Comp_P_Ratio,
        w0nom=300) annotation (Placement(transformation(
            extent={{25,-18},{-25,18}},
            rotation=0,
            origin={73,-92})));

      TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe1(
        redeclare package Medium =
            Coolant_Medium,
        crossArea=data.A_HPDelay,
        length=data.L_HPDelay) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={56,-38})));

      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
        springBallValve(
        redeclare package Medium = Coolant_Medium,
        p_spring=data.P_Release,
        K=data.K_P_Release,
        opening_init=0.) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={4,58})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
        redeclare package Medium = Coolant_Medium,
        p=data.P_Release,
        nPorts=1) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={4,86})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Core_Inlet_T(redeclare package
          Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-8,-42})));

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.Coolant_Medium,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort Intercooler_Pre_Temp(redeclare
          package Medium = Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={100,-16})));
      TRANSFORM.Fluid.Sensors.Temperature Core_Outlet_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-76,-78})));

      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (
            d_pebble=2*data.r_Pebble,
            nPebble=data.Pebble,
            packing_factor=0.55),
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input=600000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = data.P_Core_Outlet,
        Q_nominal=600000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = data.P_Core_Inlet,
        T_a_start(displayUnit="K") = data.T_Core_Inlet,
        T_b_start(displayUnit="K") = data.T_Core_Outlet,
        m_flow_a_start=data.m_flow,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.u,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.2,0.3,0.3,0.2},
        nParallel=data.nAssembly,
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-36,-62})));

      Modelica.Blocks.Sources.RealExpression Charging_Mass_Flow(y=turbine.Wt)
        annotation (Placement(transformation(extent={{-80,90},{-60,110}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{74,76},{86,90}})));
    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
     Q_gen =turbine.Wt - compressor.Wc - compressor_Controlled.Wc;
     cycle_eff = Q_gen / core.Q_total.y;

      connect(Precooler.heatPort, boundary3.port)
        annotation (Line(points={{32,38},{32,36},{12,36}},
                                                  color={191,0,0}));
      connect(Precooler.port_b, compressor.inlet) annotation (Line(points={{38,44},{
              26,44},{26,56},{62.8,56},{62.8,46.8}},
                                            color={0,127,255}));
      connect(Intercooler.heatPort, boundary4.port)
        annotation (Line(points={{94,-54},{88,-54}},       color={191,0,0}));
      connect(compressor_Controlled.outlet, transportDelayPipe1.port_a) annotation (
         Line(points={{58,-77.6},{58,-52},{56,-52},{56,-48}}, color={0,127,255}));
      connect(Intercooler.port_b, compressor_Controlled.inlet) annotation (Line(
            points={{100,-60},{100,-70},{88,-70},{88,-77.6}}, color={0,127,255}));
      connect(springBallValve.port_b,boundary5. ports[1])
        annotation (Line(points={{4,68},{4,76}},              color={0,127,255}));
      connect(springBallValve.port_a, Precooler.port_b) annotation (Line(points={{4,48},{
              4,44},{38,44}},                         color={0,127,255}));
      connect(Reheater.Shell_in, transportDelayPipe1.port_b)
        annotation (Line(points={{18,-10},{56,-10},{56,-28}},
                                                          color={0,127,255}));
      connect(Reheater.Shell_out, Core_Inlet_T.port_a) annotation (Line(points={{-2,-10},
              {-8,-10},{-8,-32}},                        color={0,127,255}));
      connect(turbine.outlet, Reheater.Tube_in) annotation (Line(points={{-28.8,4.6},
              {-28.8,-12},{-10,-12},{-10,-4},{-2,-4}},
                                                  color={0,127,255}));
      connect(Reheater.Tube_out, sensor_T.port_a)
        annotation (Line(points={{18,-4},{38,-4},{38,0}},  color={0,127,255}));
      connect(compressor.outlet, transportDelayPipe.port_a) annotation (Line(points={{89.2,
              46.8},{90,46.8},{90,46},{100,46},{100,30}},
                                                color={0,127,255}));
      connect(transportDelayPipe.port_b, Intercooler_Pre_Temp.port_b) annotation (
          Line(points={{100,10},{100,-6}},                   color={0,127,255}));
      connect(Intercooler.port_a, Intercooler_Pre_Temp.port_a)
        annotation (Line(points={{100,-48},{100,-26}},
                                                     color={0,127,255}));
      connect(Core_Outlet_T.port, Core_Outlet.port_a) annotation (Line(points={{-76,-68},
              {-76,-64},{-66,-64},{-66,-32}},      color={0,127,255}));
      connect(Core_Outlet.port_b, turbine.inlet) annotation (Line(points={{-66,-20},
              {-66,0},{-67.2,0},{-67.2,4.6}},
                                           color={0,127,255}));
      connect(sensor_T.port_b, Precooler.port_a)
        annotation (Line(points={{38,20},{38,32}}, color={0,127,255}));
      connect(Core_Inlet_T.port_b, core.port_a)
        annotation (Line(points={{-8,-52},{-8,-62},{-26,-62}}, color={0,127,255}));
      connect(Core_Outlet.port_a, core.port_b) annotation (Line(points={{-66,-32},{
              -66,-62},{-46,-62}}, color={0,127,255}));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{88,100},{88,98},{146,98},{146,-76.52},{73,-76.52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Turbine_Power, Charging_Mass_Flow.y) annotation (Line(
          points={{-30,100},{-59,100}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, Core_Outlet_T.T) annotation (Line(
          points={{-30,100},{-30,72},{-114,72},{-114,-78},{-82,-78}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,84},{70,84},{70,83},{72.8,83}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-90},{78,86}}, fileName=
                  "modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000,
          __Dymola_NumberOfIntervals=591,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is self-contained. It is recommended that anyone attempting to modify the HTGR-Brayton system begins by copying this model (including testing new control methods). </p>
<p>The core model used here is the current pebble bed model that uses TRISO structured fuel. </p>
<p>The system has only been tested (as of March 2022) with Helium coolant, but any gas package should operate properly. </p>
<p>A breakdown of the components: </p>
<p>The core model is effectively a replaceable heat source. The default is a pebble bed system, and a prismatic fuel model will be forthcoming. </p>
<p>The turbine model uses inputs from the data structure to describe its size and efficiency characteristics. </p>
<p>The recuperating heat exchanger is of NTU type. There is no description in the literature to describe the actual geometry of a recuperating heat exchanger of this size. The NTU HX is used for simulation speed, and the NTU value describes the effective size of that heat exchanger. </p>
<p>The precooler and intercooler are named to match the diagram included in the documentation of the overall Brayton_Systems package. The boundary conditions applied there dictate the fluid flow temperatures. In the future, a heat exchanger to evaluate the necessary cooling requirements could replace these boundary conditions. </p>
<p>The compression of the Helium is split into two stages, each coming immediately after a cooling stage. </p>
</html>"));
    end PebbleBed_Brayton_FullRX_Transient;
  end Models;

  package ControlSystems "Control systems"
    model CS_Simple

      extends BaseClasses.Partial_ControlSystem;

      Modelica.Blocks.Sources.RealExpression CR_Reactivity
        annotation (Placement(transformation(extent={{-14,-58},{6,-38}})));
      TRANSFORM.Blocks.RealExpression T_RX
        annotation (Placement(transformation(extent={{-84,-86},{-72,-72}})));
      Modelica.Blocks.Sources.RealExpression PR_Compressor
        annotation (Placement(transformation(extent={{22,-24},{42,-4}})));
      TRANSFORM.Blocks.RealExpression Core_mass_flow_rate
        annotation (Placement(transformation(extent={{-84,-62},{-72,-48}})));
    equation

      connect(actuatorBus.CR_Reactivity, CR_Reactivity.y) annotation (Line(
          points={{30,-100},{30,-48},{7,-48}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, T_RX.u) annotation (Line(
          points={{-30,-100},{-30,-78},{-34,-78},{-34,-68},{-92,-68},{-92,-79},
              {-85.2,-79}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, Core_mass_flow_rate.u) annotation (Line(
          points={{-30,-100},{-30,-44},{-90,-44},{-90,-55},{-85.2,-55}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, PR_Compressor.y) annotation (Line(
          points={{30,-100},{30,-40},{28,-40},{28,-24},{64,-24},{64,-14},{43,-14}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Simple;

    model ED_Simple

      extends BaseClasses.Partial_EventDriver;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end ED_Simple;

    model CS_Basic

      extends BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-8,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));
      Modelica.Blocks.Sources.RealExpression PR_Compressor(y=0)
        "total thermal power"
        annotation (Placement(transformation(extent={{-4,-100},{8,-88}})));
      TRANSFORM.Blocks.RealExpression Core_M_Flow
        annotation (Placement(transformation(extent={{-4,-90},{8,-76}})));
      Data.CS_HTGR_Pebble_BraytonCycle data
        annotation (Placement(transformation(extent={{-96,74},{-76,94}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-51,-54},{-42,-54}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{30,-54},{-19,-54}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, PR_Compressor.y) annotation (Line(
          points={{30,-100},{20,-100},{20,-94},{8.6,-94}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, Core_M_Flow.u) annotation (Line(
          points={{-30,-100},{-30,-83},{-5.2,-83}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics),
        Documentation(info="<html>
<p>The default Brayton system control only moves control rods to control core outlet temperature. In more complicated systems, it is expected that additional controls may be needed. </p>
</html>"));
    end CS_Basic;

    model CS_Basic_Transient_Example
      "Example running 10% ramps for two out of four hours."

      extends BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-8,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-40,-64},{-20,-44}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));
      Data.CS_HTGR_Pebble_BraytonCycle data(T_Rx_Exit_Ref=1123.15)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Blocks.RealExpression Core_M_Flow
        annotation (Placement(transformation(extent={{-4,-90},{8,-76}})));
      TRANSFORM.Controls.LimPID Mass_Flow_Cont(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-8,
        Ti=15,
        yMax=200,
        yMin=-280,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=-54e6,
        rising=300,
        width=6900,
        falling=300,
        period=14400,
        offset=540e6,
        startTime=3600)
        annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
      Modelica.Blocks.Sources.Constant const2(k=300)
        annotation (Placement(transformation(extent={{-40,22},{-20,42}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{2,10},{22,30}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-51,-54},{-42,-54}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-66}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{30,-54},{-19,-54}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, Core_M_Flow.u) annotation (Line(
          points={{-30,-100},{-30,-83},{-5.2,-83}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y,Mass_Flow_Cont. u_s) annotation (Line(points={{-55,0},{
              -42,0}},                       color={0,0,127}));
      connect(Mass_Flow_Cont.y,add. u2) annotation (Line(points={{-19,0},{-6,0},{-6,
              14},{0,14}},          color={0,0,127}));
      connect(const2.y,add. u1) annotation (Line(points={{-19,32},{-6,32},{-6,26},{
              0,26}},     color={0,0,127}));
      connect(sensorBus.Turbine_Power, Mass_Flow_Cont.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-18},{-30,-18},{-30,-12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
          points={{30,-100},{30,20},{23,20}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics),
        Documentation(info="<html>
<p>The default Brayton system control only moves control rods to control core outlet temperature. In more complicated systems, it is expected that additional controls may be needed. </p>
</html>"));
    end CS_Basic_Transient_Example;

  end ControlSystems;

  package Data

    model CS_HTGR_Pebble_BraytonCycle

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref = 850;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end CS_HTGR_Pebble_BraytonCycle;

    model Model_HTGR_Pebble_BraytonCycle

      extends BaseClasses.Record_Data;

      import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

      replaceable package Coolant_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));

      //-----------------------------------------------------------------//
      // General //
      //-----------------------------------------------------------------//
      parameter SI.Power Q_total=160e6 "Total thermal output"                              annotation(dialog(tab = "General", group = "System Reference"));
      parameter SI.Power Q_total_el=45e6 "Total electrical output"                         annotation(dialog(tab = "General", group = "System Reference"));
      parameter Real eta=Q_total_el/Q_total "Net efficiency"                               annotation(dialog(tab = "General", group = "System Reference"));

      parameter SI.Pressure P_Release = 19.3e5 "Boundary release valve pressure downstream of precooler"                    annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.Temperature T_Intercooler = 35+273.15                                                                    annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.Temperature T_Precooler = 33+273.15                                                                      annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.MassFlowRate m_flow=700 "Primary Side Flow"                                                              annotation(dialog(tab = "General", group = "System Boundary Conditions"));

      parameter SI.Length length_core=2.408 "meters (based on 1.33 H/D ratio)"                                              annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length d_core=1.5                                                                                        annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length r_outer_fuelRod=0.5*from_in(0.374) "Outside diameter of fuel rod (d3s1)"                          annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length th_clad_fuelRod=from_in(0.024) "Cladding thickness of fuel rod (d3s1)"                            annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0065) "Gap thickness between pellet and cladding (d3s1)"             annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3195) "Pellet radius (d3s1)"                                       annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)"                                              annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)"                         annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)"                           annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)"   annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2)     annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Volume V_Core_Outlet = 0.5                                                                               annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Area A_LPDelay = 1                                                                                       annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length L_LPDelay = 5                                                                                     annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Area A_HPDelay = 1                                                                                       annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length L_HPDelay = 1                                                                                     annotation(dialog(tab = "General", group = "Geometry"));

      parameter Real K_P_Release( unit="1/(m.kg)")                                                                          annotation(dialog(tab = "General", group = "Valves"));

      parameter Real Turbine_Efficiency = 0.93                                                                              annotation(dialog(tab = "General", group = "Turbine"));
      parameter Real Turbine_Pressure_Ratio = 2.975                                                                         annotation(dialog(tab = "General", group = "Turbine"));
      parameter SI.MassFlowRate Turbine_Nominal_MassFlowRate = 296                                                          annotation(dialog(tab = "General", group = "Turbine"));

      parameter Real LP_Comp_Efficiency = 0.91                                                                              annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real LP_Comp_P_Ratio = 1.77                                                                                 annotation(dialog(tab = "General", group = "Compressors"));
      parameter SI.MassFlowRate LP_Comp_MassFlowRate = 300                                                                  annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real HP_Comp_Efficiency = 0.91                                                                              annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real HP_Comp_P_Ratio = 1.77                                                                                 annotation(dialog(tab = "General", group = "Compressors"));
      parameter SI.MassFlowRate HP_Comp_MassFlowRate = 300                                                                  annotation(dialog(tab = "General", group = "Compressors"));

      parameter Real HX_Aux_NTU = 1                                                                                         annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter SI.Volume HX_Aux_Tube_Vol = 3                                                                               annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter SI.Volume HX_Aux_Shell_Vol = 3                                                                              annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter Real HX_Aux_K_tube(unit = "1/m4") = 1                                                                       annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter Real HX_Aux_K_shell(unit = "1/m4") = 1                                                                      annotation(dialog(tab = "General", group = "HX_Aux"));

      parameter Real HX_Reheat_NTU = 10                                                                                     annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter SI.Volume HX_Reheat_Tube_Vol = 0.2                                                                          annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter SI.Volume HX_Reheat_Shell_Vol = 0.2                                                                         annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter Real HX_Reheat_K_tube(unit = "1/m4") = 1                                                                    annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter Real HX_Reheat_K_shell(unit = "1/m4") = 1                                                                   annotation(dialog(tab = "General", group = "HX_Reheat"));

      parameter SI.Volume V_Intercooler = 0.0                                                                               annotation(dialog(tab = "General", group = "Coolers"));
      parameter SI.Volume V_Precooler = 0.0                                                                                 annotation(dialog(tab = "General", group = "Coolers"));

      parameter Real nKernel_per_Pebble = 15000                                                                             annotation(dialog(tab = "General", group = "Pebble"));
      parameter Real nPebble = 55000                                                                                        annotation(dialog(tab = "General", group = "Pebble"));
      parameter Integer nR_Fuel = 1                                                                                         annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Pebble = 0.03                                                                                   annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Fuel = 200e-6                                                                                   annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Buffer = r_Fuel + 100e-6                                                                        annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_IPyC = r_Buffer+40e-6                                                                           annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_SiC = r_IPyC+35e-6                                                                              annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_OPyC = r_SiC+40e-6                                                                              annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_Buffer= 2.25                                                                       annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_IPyC = 8.0                                                                         annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_SiC = 175                                                                          annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_OPyC = 8.0                                                                         annotation(dialog(tab = "General", group = "Pebble"));

      //-----------------------------------------------------------------//
      // Initialization //
      //-----------------------------------------------------------------//
      parameter SI.Temperature Pebble_Surface_Init = 750+273.15                                                             annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));
      parameter SI.Temperature Pebble_Center_Init = 1100+273.15                                                             annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));

      parameter SI.Pressure P_Turbine_Ref = 19.9e5                                                                          annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_In_Turbine = 850+273.15                                                               annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_Out_Turbine = 478+273.15                                                              annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Pressure P_LP_Comp_Ref = 19.3e5                                                                          annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_LP_Comp_In = 33+273.15                                                                annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15                                                              annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Pressure P_HP_Comp_Ref = 19.9e5                                                                          annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_HP_Comp_In = 850+273.15                                                               annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15                                                              annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Power HX_Aux_Q_Init = -1e6                                                                               annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3                                                                annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3                                                               annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.Pressure HX_Aux_p_tube = 1e5                                                                             annotation(dialog(tab = "Initialization", group = "HX_Aux"));

      parameter SI.Pressure P_Core_Inlet = 60e5                                                                             annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Pressure P_Core_Outlet = 59.4e5                                                                          annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Core_Inlet = 623.15                                                                        annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Core_Outlet = 1023.15                                                                      annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Pebble_Init = T_Core_Outlet                                                                annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Fuel_Center_Init = 1473.15                                                                 annotation(dialog(tab = "Initialization", group = "Reactor_Core"));

      parameter SI.Pressure Recuperator_P_Tube = 19.4e5                                                                     annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3                                                       annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3                                                      annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.Pressure Recuperator_dp_Tube = 0.3e5                                                                     annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.MassFlowRate Recuperator_m_Tube = 296.1                                                                  annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));

      parameter SI.Pressure Recuperator_P_Shell = 60.4e5                                                                    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3                                                      annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3                                                     annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.Pressure Recuperator_dp_Shell = 0.4e5                                                                    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.MassFlowRate Recuperator_m_Shell = 296.1                                                                 annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));

      parameter SI.Pressure P_Intercooler = 59.2e5                                                                          annotation(dialog(tab = "Initialization", group = "Cooler"));
      parameter SI.Pressure P_Precooler = 30e5                                                                              annotation(dialog(tab = "Initialization", group = "Cooler"));

      //-----------------------------------------------------------------//
      // ControlSystem //
      //-----------------------------------------------------------------//

      parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref = 850;

    equation
     // assert(abs(lengths[1] - lengths[2]) <= Modelica.Constants.eps, "Hot/cold leg lengths must be equal");
     // assert(abs(length_reactorVessel - lengths[1] - length_pressurizer) <= Modelica.Constants.eps, "Hot leg and pressurizer must be equal to reactor vessel length");

                                                                                                                            annotation(dialog(tab = "Control"),
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="Pebble Bed")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Model_HTGR_Pebble_BraytonCycle;

  end Data;

  package SupportComponents
    model Compressor_Controlled "Gas compressor"
      extends GasTurbine.Compressor.BaseClasses.CompressorBase(pstart_out=pstart_in*
            PR0);
      parameter Boolean use_w0_port = false;
      parameter Real eta0 = 0.86
        "Isentropic efficiency at nominal operating conditions";
      parameter Real PR0 "Nominal compression ratio";
      parameter Modelica.Units.SI.MassFlowRate w0nom "Nominal gas flow rate"  annotation (Dialog(enable = not use_w0_port));

      Modelica.Blocks.Interfaces.RealInput w0in if use_w0_port
                                                 annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={0,-100}), iconTransformation(
            extent={{14,-14},{-14,14}},
            rotation=90,
            origin={0,86})));

    protected
        Modelica.Blocks.Interfaces.RealInput w0_in_internal(unit="kg/s")
        "Needed to connect to conditional connector";
    equation
      eta = eta0;
      PR = PR0*(w/w0_in_internal);

       if not use_w0_port then
        w0_in_internal = w0nom;
      end if;
      connect(w0in,w0_in_internal);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})), Documentation(info="<html>
<p>This is an altered version of the compressor model built in TRANSFORM. It should be replaced if a superior control method is constructed by later users. </p>
</html>"));
    end Compressor_Controlled;
  end SupportComponents;

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
  end BaseClasses;
annotation (Documentation(info="<html>
<p>The Brayton cycle HTGR is constructed a little bit differently than the typical Hybrid power generation system. The entire HTGR power production system is built as a single drag-and-drop module as opposed to a split between the primary and secondary sides. This is due to the fact that a Brayton system is a direct power generation system: the core coolant is the same fluid that is producing the electricity. While it is possible to split the model (see the BalanceOfPlant.Brayton_Cycle module as the secondary side of this particular model without the core), the primary side becomes a single component, which is simplistic. </p>
<p>The Brayton cycle system is based on the HTGR-GT from &quot;Gas turbine power conversion systems for modular HTGRs&quot;, IAEA-TECDOC-1238, on pp 42-43. Standard TRISO fuel (UO2-loaded) is used rather than the document&apos;s Pu-based system. The table on page 43 indicates that the Helium core exit temperature is 850C. </p>
<p><img src=\"modelica://NHES/Systems/PrimaryHeatSystem/HTGR/Brayton_HTGR_Cycle_Example.png\"/></p>
<p><br>There are multiple models held within this package in the Components folder. The &quot;Complete&quot; model effectively the system described by the image above. Two other models are included in the Components folder. </p>
<p>The first other model is Pebble_Bed_CC, which uses the heat of the intercooler and precooler to produce steam that is then used by a steam turbine to produce additional electricity. </p>
<p>The second model Pebble_Bed_Brayton includes a heat exchanger upstream of the turbine for heat applications. Note that this is a similar structure to a TBV in a PWR system for integration. </p>
</html>"));
end BraytonCycle;
