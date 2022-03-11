within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload;
package Components

  model Pebble_Bed_Rankine_Standalone
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{80,124},{100,144}})));

    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
      NTU=1.25,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      redeclare package Shell_medium = Aux_Heat_App_Medium,
      V_Tube=3,
      V_Shell=3,
      V_buffers=1,
      p_start_tube=6030000,
      h_start_tube_inlet=3600e3,
      h_start_tube_outlet=2900e3,
      p_start_shell=1000000,
      h_start_shell_inlet=600e3,
      h_start_shell_outlet=1000e3,
      dp_init_tube=30000,
      dp_init_shell=40000,
      Q_init=-100000000,
      Cr_init=0.8,
      m_start_tube=300,
      m_start_shell=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,8})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium = Aux_Heat_App_Medium,
      use_m_flow_in=false,
      m_flow=55,
      T=353.15,
      nPorts=1) annotation (Placement(transformation(extent={{-58,38},{-38,58}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Aux_Heat_App_Medium,
      p=8000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-106,-44},{-86,-24}})));
    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{40,14},{60,34}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{50,-52},{30,-32}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={88,-8})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          origin={64,-42})));

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{-8,-50},{-28,-30}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{-76,-80},{-96,-60}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{84,76},{96,90}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={14,-42})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = steamTurbine.Q_mech/core.Q_total.y;
    connect(boundary2.ports[1], Steam_Offtake.Shell_in) annotation (Line(points={
            {-38,48},{-14,48},{-14,18},{-2,18}}, color={0,127,255}));
    connect(compressor_Controlled.inlet, Steam_Offtake.Tube_out) annotation (Line(
          points={{44,32},{4,32},{4,18}},                                  color=
            {0,127,255}));
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{88,-18},
            {88,-42},{74,-42}},   color={0,127,255}));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{56,32},{56,38},{88,38},{88,2}},
                                                            color={0,127,255}));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{47,-42},{54,-42}},   color={0,127,255}));
    connect(boundary1.ports[1], steamTurbine.portLP)
      annotation (Line(points={{-86,-34},{-28,-34}}, color={0,127,255}));
    connect(steamTurbine.portHP, Steam_Offtake.Shell_out)
      annotation (Line(points={{-8,-34},{-2,-34},{-2,-2}}, color={0,127,255}));
    connect(generator.shaft, steamTurbine.shaft_b) annotation (Line(points={{-75.9,
            -70.1},{-28,-70.1},{-28,-40},{-28,-40}}, color={0,0,0}));
    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,83},{82.8,83}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{33,-42},{24,-42}}, color={0,127,255}));
    connect(sensor_T.port_b, Steam_Offtake.Tube_in)
      annotation (Line(points={{4,-42},{2,-42},{2,-6},{4,-6},{4,-2}},
                                                         color={0,127,255}));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,-18},{14,-18},{14,-38.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{30,34},{50,34},{50,32.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,-8},{84.4,-8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=591,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone;

  model Pebble_Bed_Rankine_Standalone_Complex
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{80,124},{100,144}})));

    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
      NTU=1.25,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      redeclare package Shell_medium = Aux_Heat_App_Medium,
      V_Tube=3,
      V_Shell=3,
      V_buffers=1,
      p_start_tube=6030000,
      h_start_tube_inlet=3600e3,
      h_start_tube_outlet=2900e3,
      p_start_shell=1000000,
      h_start_shell_inlet=600e3,
      h_start_shell_outlet=1000e3,
      dp_init_tube=30000,
      dp_init_shell=40000,
      Q_init=-100000000,
      Cr_init=0.8,
      m_start_tube=300,
      m_start_shell=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,8})));
    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{12,14},{32,34}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{54,-50},{34,-30}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={66,18})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          origin={70,-40})));

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{-34,-44},{-54,-24}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{-62,-44},{-82,-24}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{84,76},{96,90}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={18,-40})));
    Fluid.Vessels.IdealCondenser condenser(p=10000)
      annotation (Placement(transformation(extent={{-58,-10},{-78,10}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=3900000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{-64,40},{-44,60}})));
    Modelica.Blocks.Sources.Constant const(k=1500)
      annotation (Placement(transformation(extent={{-88,60},{-68,80}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-18,-28})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-18,-54})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = steamTurbine.Q_mech/core.Q_total.y;
    connect(compressor_Controlled.inlet, Steam_Offtake.Tube_out) annotation (Line(
          points={{16,32},{16,38},{4,38},{4,18}},                          color=
            {0,127,255}));
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{66,8},{
            66,-26},{84,-26},{84,-40},{80,-40}},
                                  color={0,127,255}));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{28,32},{66,32},{66,28}},    color={0,127,255}));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{51,-40},{60,-40}},   color={0,127,255}));
    connect(generator.shaft, steamTurbine.shaft_b) annotation (Line(points={{-61.9,
            -34.1},{-54,-34}},                       color={0,0,0}));
    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,83},{82.8,83}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{37,-40},{28,-40}}, color={0,127,255}));
    connect(sensor_T.port_b, Steam_Offtake.Tube_in)
      annotation (Line(points={{8,-40},{2,-40},{2,-6},{4,-6},{4,-2}},
                                                         color={0,127,255}));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,-6},{18,-6},{18,-36.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{30,38},{22,38},{22,32.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,76},{50,76},{50,34},{52,34},{52,18},{62.4,18}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(steamTurbine.portLP, condenser.port_a) annotation (Line(points={{-54,-28},
            {-58,-28},{-58,-14},{-54,-14},{-54,14},{-61,14},{-61,10}},
                                                     color={0,127,255}));
    connect(const.y, pump.inputSignal) annotation (Line(points={{-67,70},{-54,
            70},{-54,57}},                                color={0,0,127}));
    connect(condenser.port_b, pump.port_a) annotation (Line(points={{-68,-10},{
            -68,-14},{-82,-14},{-82,50},{-64,50}},
                  color={0,127,255}));
    connect(pump.port_b, Steam_Offtake.Shell_in) annotation (Line(points={{-44,50},
            {0,50},{0,22},{-2,22},{-2,18}},                 color={0,127,255}));
    connect(steamTurbine.portHP, sensor_T1.port_b)
      annotation (Line(points={{-34,-28},{-28,-28}}, color={0,127,255}));
    connect(sensor_T1.port_a, Steam_Offtake.Shell_out) annotation (Line(points={{-8,-28},
            {-2,-28},{-2,-2}},                          color={0,127,255}));
    connect(sensor_p.port, sensor_T1.port_a) annotation (Line(points={{-18,-64},
            {-18,-68},{0,-68},{0,-28},{-8,-28}},
          color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=10000,
        __Dymola_NumberOfIntervals=591,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_Complex;

  model Pebble_Bed_Rankine_Standalone_STHX
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Power_Change_2 CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{120,10},{140,30}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{114,-50},{94,-30}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={184,-16})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=true,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          origin={146,-40})));

    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{-42,-40},{-62,-60}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{-118,-60},{-138,-40}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{84,76},{96,90}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={58,-40})));
    Fluid.Vessels.IdealCondenser condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{-106,-106},{-126,-86}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{-128,38},{-108,58}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-24,-44})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={22,-76})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-52},{30,-32}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase STHX(
      NTU=2,
      K_tube=100,
      K_shell=1000,
      redeclare package Tube_medium =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT,

      V_Tube=10,
      V_Shell=10,
      V_buffers=5,
      p_start_tube=6000000,
      h_start_tube_inlet=5000e3,
      h_start_tube_outlet=3000e3,
      p_start_shell=14000000,
      h_start_shell_inlet=800e3,
      h_start_shell_outlet=3000e3,
      m_start_tube=150,
      m_start_shell=50) annotation (Placement(transformation(
          extent={{12,11},{-12,-11}},
          rotation=90,
          origin={5,12})));

    TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50)
      annotation (Placement(transformation(extent={{4,-80},{-16,-100}})));
    Modelica.Blocks.Sources.Constant const4(k=1.0)
      annotation (Placement(transformation(extent={{-46,-112},{-26,-92}})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-112,96},{-100,110}})));
    TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{-80,-40},{-100,-60}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-140,14})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-84,-32},{-64,-12}})));
    TRANSFORM.Fluid.Valves.ValveLinear valveLinear1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5)
      annotation (Placement(transformation(extent={{-102,8},{-122,-12}})));
    Modelica.Blocks.Sources.Constant const1(k=1)
      annotation (Placement(transformation(extent={{-138,-36},{-118,-16}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,48})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{-142,-94},{-162,-74}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      separator(redeclare package Medium = Modelica.Media.Water.StandardWater,
        redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{-40,10},{-60,-10}})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50)
      annotation (Placement(transformation(extent={{18,-136},{-2,-156}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=8000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-40,-156},{-20,-136}})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p1(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-72,-72})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{7,-7},{-7,7}},
          rotation=90,
          origin={-109,-71})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-106,110},{-94,124}})));
    Modelica.Blocks.Sources.RealExpression TBV_Flow(y=TBV.m_flow)
      annotation (Placement(transformation(extent={{-106,126},{-94,140}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=16700000,
      use_T_start=false,
      T_start=723.15,
      h_start=210e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-28,36},{-8,56}})));
    TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      crossArea=5,
      length=1) annotation (Placement(transformation(extent={{4,-36},{24,-16}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{184,-26},
            {184,-40},{156,-40}}, color={0,127,255}));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{136,28},{184,28},{184,-6}}, color={0,127,255}));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{111,-40},{136,-40}}, color={0,127,255}));
    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,83},{82.8,83}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{97,-40},{68,-40}}, color={0,127,255}));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,-16},{58,-16},{58,-36.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{30,60},{130,60},{130,28.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,-16},{180.4,-16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(steamTurbine.portHP, sensor_T1.port_b)
      annotation (Line(points={{-42,-56},{-38,-56},{-38,-44},{-34,-44}},
                                                     color={0,127,255}));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{26,-42},{32,-42},
            {32,-46},{38,-46},{38,-84},{40,-84},{40,-86},{22,-86}}, color={0,127,255}));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{-30,-28},{-24,-28},{-24,-40.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,70},{-114,70},{-114,55},{-118,55}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-32,100},{-32,-20},{-2,-20},{-2,-42},{6,-42},{6,-76},{
            16,-76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensor_p.port, valveLinear.port_a) annotation (Line(points={{22,-86},
            {18,-86},{18,-92},{6,-92},{6,-90},{4,-90}}, color={0,127,255}));
    connect(valveLinear.port_b, sensor_T1.port_a) annotation (Line(points={{-16,-90},
            {-20,-90},{-20,-66},{-6,-66},{-6,-44},{-14,-44}},
                                                 color={0,127,255}));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-72,100},{-72,103},{-99.4,103}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(steamTurbine1.shaft_b, generator.shaft)
      annotation (Line(points={{-100,-50},{-117.9,-50.1}}, color={0,0,0}));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{-140,20},{-140,
            50},{-128,50},{-128,48}}, color={0,127,255}));
    connect(steamTurbine1.portHP, tee.port_1) annotation (Line(points={{-80,-56},
            {-74,-56},{-74,-36},{-88,-36},{-88,-22},{-84,-22}}, color={0,127,255}));
    connect(tee.port_3, valveLinear1.port_a) annotation (Line(points={{-74,-12},{
            -74,-2},{-102,-2}}, color={0,127,255}));
    connect(valveLinear1.port_b, volume1.port_a) annotation (Line(points={{-122,
            -2},{-134,-2},{-134,8},{-140,8}}, color={0,127,255}));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-80,48},{-108,48}}, color={0,127,255}));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,60},{-72,60},{-72,51.6},{-70,51.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(condenser.port_b, pump1.port_a) annotation (Line(points={{-116,-106},{
            -124,-106},{-124,-100},{-136,-100},{-136,-84},{-142,-84}},color={0,
            127,255}));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{-162,-84},{
            -174,-84},{-174,-28},{-140,-28},{-140,8}}, color={0,127,255}));
    connect(steamTurbine.shaft_b, steamTurbine1.shaft_a)
      annotation (Line(points={{-62,-50},{-80,-50}}, color={0,0,0}));
    connect(actuatorBus.TCV_Position, valveLinear.opening) annotation (Line(
        points={{30,100},{30,60},{242,60},{242,-108},{-8,-108},{-8,-98},{-6,-98}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, valveLinear1.opening) annotation (
        Line(
        points={{30,100},{30,70},{-172,70},{-172,-24},{-112,-24},{-112,-10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(steamTurbine.portLP, separator.port_a) annotation (Line(points={{-62,
            -56},{-64,-56},{-64,-58},{-66,-58},{-66,-34},{-36,-34},{-36,0},{-44,0}},
          color={0,127,255}));
    connect(separator.port_b, tee.port_2)
      annotation (Line(points={{-56,0},{-56,-22},{-64,-22}}, color={0,127,255}));
    connect(separator.port_Liquid, volume1.port_a) annotation (Line(points={{-46,
            4},{-46,28},{-152,28},{-152,8},{-140,8}}, color={0,127,255}));
    connect(TBV.port_a, volume.port_b) annotation (Line(points={{18,-146},{68,
            -146},{68,-66},{26,-66},{26,-42}}, color={0,127,255}));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{242,100},{242,-154},{8,-154}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-2,-146},{-2,
            -148},{-20,-148},{-20,-146}},                 color={0,127,255}));
    connect(sensor_p1.port, steamTurbine.portLP)
      annotation (Line(points={{-72,-82},{-72,-86},{-66,-86},{-66,-56},{-62,-56}},
                                                           color={0,127,255}));
    connect(steamTurbine1.portLP, sensor_m_flow1.port_a) annotation (Line(points={
            {-100,-56},{-109,-56},{-109,-64}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, condenser.port_a)
      annotation (Line(points={{-109,-78},{-109,-86}}, color={0,127,255}));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,117},{-93.4,117}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Bypass_Flow, TBV_Flow.y) annotation (Line(
        points={{-30,100},{-32,100},{-32,133},{-93.4,133}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume2.port_b, STHX.Shell_in) annotation (Line(points={{-12,46},{-2,
            46},{-2,48},{2.8,48},{2.8,24}}, color={0,127,255}));
    connect(volume2.port_a, sensor_T2.port_b) annotation (Line(points={{-24,46},{
            -54,46},{-54,48},{-60,48}}, color={0,127,255}));
    connect(transportDelayPipe.port_b, volume.port_a) annotation (Line(points={{
            24,-26},{32,-26},{32,-36},{12,-36},{12,-42},{14,-42}}, color={0,127,
            255}));
    connect(transportDelayPipe.port_a, STHX.Shell_out) annotation (Line(points={{
            4,-26},{0,-26},{0,-4},{2.8,-4},{2.8,8.88178e-16}}, color={0,127,255}));
    connect(sensor_T.port_b, STHX.Tube_out) annotation (Line(points={{48,-40},{50,
            -40},{50,28},{14,28},{14,24},{9.4,24}}, color={0,127,255}));
    connect(STHX.Tube_in, compressor_Controlled.inlet) annotation (Line(points={{
            9.4,0},{9.4,-12},{84,-12},{84,30},{86,30},{86,28},{124,28}}, color={0,
            127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(__Dymola_NumberOfIntervals=113, __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX;

  model Pebble_Bed_Rankine_Standalone_STHX_Storage_Integration
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Power_Change CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-82,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-43,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=500*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=2),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-37,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium
        = Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(extent={{-11,-11},{11,11}},
          rotation=180,
          origin={99,-37}),                          iconTransformation(extent={{86,-58},
              {108,-36}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium
        = Modelica.Media.Water.StandardWater) annotation (Placement(
          transformation(extent={{-11,-11},{11,11}},
          rotation=180,
          origin={99,73}),                              iconTransformation(extent={{86,44},
              {108,66}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
            {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-58,-30},{-58,-41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-80,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
            30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
            {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_a, Condenser.port_a)
      annotation (Line(points={{99,-37},{81,-36}}, color={0,127,255}));
    connect(volume.port_b, port_b) annotation (Line(
        points={{-14,30},{-10,30},{-10,66},{-6,66},{-6,73},{99,73}},
        color={0,127,255},
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=6000,
        Interval=100,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_Storage_Integration;

  model Pebble_Bed_Rankine_Standalone_STHX_02
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Two CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-82,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-43,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=500*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=2),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-37,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
            {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-58,-30},{-58,-41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-80,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
            30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
            {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=6000,
        Interval=100,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_02;

  model Pebble_Bed_Rankine_Standalone_STHX_03
    extends Pebble_Bed_Rankine_Standalone_STHX_02(
      compressor_Controlled(gas_iso(state(phase(start=1)))),
      core(coolantSubchannel(state_a(phase(start=1)), state_b(phase(start=1))),
          fuelModel(Fuel_kernel(port_b1(T(start={790.9180376325126,
                    808.9378945319855,833.6825766036188,846.7840416077452}))),
            Fuel_kernel_center(port_b1(T(start={806.7688034248663,
                    822.1468660243927,846.8915480959446,857.3512188001525}))))),
      generator(shaft(tau(start=106529.6527746159))),
      resistance(port_a(p(start=11735599.702357637))),
      tee(port_2(m_flow(start=40.31413699208795))));
  end Pebble_Bed_Rankine_Standalone_STHX_03;

  model Pebble_Bed_Rankine_Standalone_STHX_04
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Two CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-46,-60},{-66,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-68,28},{-56,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-78,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-80,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-41,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,

      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=500*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=3),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-35,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-46,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-136,70},{-116,90}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-88,-40},
            {-94,-40},{-94,-16},{-80,-16},{-80,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-62,-42},{-64,-42},{-64,-40},{-68,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-66.2,35},{-80,35},{-80,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-57.8,35},{-57.8,34},{-42,34},{-42,32},{-41,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-38.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-56,-30},{-56,
            -41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-78,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},
            {-34,30},{-34,14},{-35,14},{-35,10}},
                                                color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-40.06,-14},{-40.06,-34},{-50,-34},{-50,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-35,-14},{-35,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-40.06,
            10},{-40,10},{-40,16},{-41,16},{-41,22}},
                                                  color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{32,100},{32,78.4},{-46,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,44},
            {-72,44},{-72,72},{-54,72}}, color={0,127,255}));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-38,72},{-26,
            72},{-26,74},{-14,74},{-14,80},{-116,80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        Interval=30,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_04;

  model Pebble_Bed_Rankine_Standalone_STHX_05
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Two_03 CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-82,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-43,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,

      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=100*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=3),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-37,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-46,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-136,70},{-116,90}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
            {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-58,-30},{-58,-41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-80,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
            30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
            {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{32,100},{32,78.4},{-46,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,44},
            {-72,44},{-72,72},{-54,72}}, color={0,127,255}));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-38,72},{-26,
            72},{-26,74},{-14,74},{-14,80},{-116,80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=72000,
        Interval=30,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_05;

  model Pebble_Bed_Rankine_Standalone_STHX_06
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Power_Change_2 CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
        Q_total=600000000,
        Q_total_el=300000000,
        K_P_Release=10000,
        m_flow=637.1,
        length_core=15.0,
        d_core=3.0,
        r_outer_fuelRod=0.03,
        th_clad_fuelRod=0.025,
        th_gap_fuelRod=0.02,
        r_pellet_fuelRod=0.01,
        pitch_fuelRod=0.06,
        sizeAssembly=17,
        nRodFuel_assembly=264,
        nAssembly=24,
        V_Core_Outlet=1.5,
        HX_Reheat_Tube_Vol=0.1,
        HX_Reheat_Shell_Vol=0.1,
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(
      P_LP_Comp_Ref=4000000,
      T_Core_Inlet=473.15,
      T_Core_Outlet=673.15)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-82,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-43,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,

      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=100*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=3),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-37,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-46,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-136,70},{-116,90}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
            {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-58,-30},{-58,-41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-80,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
            30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
            {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{32,100},{32,78.4},{-46,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,44},
            {-72,44},{-72,72},{-54,72}}, color={0,127,255}));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-38,72},{-26,
            72},{-26,74},{-14,74},{-14,80},{-116,80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=100,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_06;

  model Pebble_Bed_Rankine_Standalone_STHX_DNE
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_DNE CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));
      Real eff;
    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,

      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
        R=1000)
      annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-40})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
      exposeState_a=false,
      exposeState_b=false,
      Ts_start(displayUnit="degC"),
      fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      redeclare record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
      redeclare record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
      rho_input=CR_reactivity.y,
      redeclare package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.Helium,
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-82,2})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          TRANSFORM.Media.ExternalMedia.CoolProp.Helium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={-43,27})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,

      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=500*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=3),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell =
          NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT)
      annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={-37,-2})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={-46,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-136,70},{-116,90}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
    eff = generator.power/core.Q_total.y;
    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
            {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{-30,100},{-30,50},{-100,50},{-100,-30},{-58,-30},{-58,-41.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-43.6},{-80,-43.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
            30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
        thickness=0.5));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                            color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(STHX.port_a_tube, sensor_T2.port_b)
      annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{8,54},{8,48},{0,48},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
            {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{32,100},{32,78.4},{-46,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,44},
            {-72,44},{-72,72},{-54,72}}, color={0,127,255}));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-38,72},{-26,
            72},{-26,74},{-14,74},{-14,80},{-116,80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        Interval=30,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end Pebble_Bed_Rankine_Standalone_STHX_DNE;

  model HTGR_PebbleBed_Primary_Loop
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_Two CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));

    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    Brayton_Systems.Compressor_Controlled compressor_Controlled(
      redeclare package Medium = Coolant_Medium,
      explicitIsentropicEnthalpy=false,
      pstart_in=5500000,
      Tstart_in=398.15,
      Tstart_out=423.15,
      use_w0_port=true,
      PR0=1.05,
      w0nom=300)
      annotation (Placement(transformation(extent={{40,-58},{20,-38}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Coolant_Medium,
        R=1000)
      annotation (Placement(transformation(extent={{-8,32},{4,46}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = Coolant_Medium) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-22,-34})));
    Nuclear.CoreSubchannels.Pebble_Bed_2 core(
      redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
      redeclare package Pebble_Material = Media.Solids.Graphite_5,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
      Q_fission_input(displayUnit="MW") = 100000000,
      alpha_fuel=-5e-5,
      alpha_coolant=0.0,
      p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
      Q_nominal(displayUnit="MW") = 125000000,
      SigmaF_start=26,
      p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
      T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
      T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
      m_flow_a_start=300,
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
      SF_start_power={0.3,0.25,0.25,0.2},
      nParallel=data.nAssembly,
      redeclare model Geometry =
          TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
          (
          width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
          rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
              data.r_outer_fuelRod},
          length=data.length_core,
          nPins=data.nRodFuel_assembly,
          nPins_nonFuel=data.nRodNonFuel_assembly,
          angle=1.5707963267949),
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
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-32,8})));

    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T(redeclare package Medium =
          Coolant_Medium) annotation (Placement(
          transformation(
          extent={{-5,-7},{5,7}},
          rotation=270,
          origin={53,35})));

    Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
      annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
                          annotation (Placement(
          transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
              {86,-44},{108,-22}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
                          annotation (Placement(
          transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
              38},{108,60}})));
    TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
      redeclare model FlowModel_shell =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,

      redeclare model FlowModel_tube =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,

      p_b_start_shell=14300000,
      p_b_start_tube=3900000,
      T_a_start_tube=373.15,
      T_b_start_tube=773.15,
      exposeState_b_shell=true,
      exposeState_b_tube=true,
      redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,

      p_a_start_shell=14400000,
      T_a_start_shell=1023.15,
      T_b_start_shell=723.15,
      m_flow_a_start_shell=300,
      p_a_start_tube=4000000,
      use_Ts_start_tube=true,
      m_flow_a_start_tube=50,
      redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_i_shell(displayUnit="m") = 0.011,
          D_o_shell=0.022,
          crossAreaEmpty_shell=500*0.05,
          length_shell=75,
          nTubes=1500,
          nV=6,
          dimension_tube(displayUnit="mm") = 0.0254,
          length_tube=75,
          th_wall=0.003,
          nR=3),
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,

      redeclare package Medium_shell = Coolant_Medium)
                          annotation (Placement(transformation(
          extent={{-12,-11},{12,11}},
          rotation=90,
          origin={63,-4})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

    connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-32,-34},
            {-38,-34},{-38,-6},{-32,-6},{-32,-2}},
                                  color={0,127,255},
        thickness=0.5));
    connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
      annotation (Line(points={{24,-40},{24,-34},{-12,-34}},color={0,127,255},
        thickness=0.5));
    connect(resistance.port_a, core.port_b)
      annotation (Line(points={{-6.2,39},{-18,39},{-18,18},{-32,18}},
                                                     color={0,127,255},
        thickness=0.5));
    connect(resistance.port_b, sensor_T.port_a)
      annotation (Line(points={{2.2,39},{42,39},{42,44},{53,44},{53,40}},
                                                   color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
        points={{-30,100},{60,100},{60,44},{64,44},{64,35},{55.52,35}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
        Line(
        points={{30,100},{30,-39.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
        points={{-30,100},{-30,-20},{-36,-20},{-36,-48},{-22,-48},{-22,-37.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
        points={{-30,100},{-30,111},{-79.4,111}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(port_b, STHX.port_b_tube) annotation (Line(points={{97,49},{84,49},
            {84,14},{60,14},{60,10},{64,10}}, color={0,127,255}));
    connect(port_a, STHX.port_a_tube) annotation (Line(points={{97,-33},{64,-33},
            {64,-18}}, color={0,127,255}));
    connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
          points={{57.94,-16},{56,-16},{56,-40},{36,-40}}, color={0,127,255}));
    connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{57.94,
            8},{58,8},{58,28},{54,28},{54,30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        Interval=30,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end HTGR_PebbleBed_Primary_Loop;

  model HTGR_Rankine_Cycle
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Rankine_DNE CS,
      redeclare replaceable HTGR_Rankine_Upload.ED_Dummy ED,
      redeclare Data.Data_HTGR_Pebble data(
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
        HX_Reheat_Buffer_Vol=0.1));

    replaceable package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload.BaseClasses.He_HighT
                                                                                                  annotation(choicesAllMatching = true,dialog(group="Media"));
    replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
    replaceable package Pebble_Medium =
        Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
        replaceable package Aux_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
        replaceable package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

    //Modelica.Units.SI.Power Q_Recup;

   /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
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

    Data.DataInitial_HTGR_Pebble
                        dataInitial(P_LP_Comp_Ref=4000000)
      annotation (Placement(transformation(extent={{78,120},{98,140}})));

    TRANSFORM.Fluid.Machines.SteamTurbine HPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=2500000,
      T_nominal=673.15)
      annotation (Placement(transformation(extent={{38,26},{58,46}})));
    TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
      annotation (Placement(transformation(extent={{58,-20},{38,0}})));
    TRANSFORM.Blocks.RealExpression CR_reactivity
      annotation (Placement(transformation(extent={{68,94},{80,108}})));
    Fluid.Vessels.IdealCondenser Condenser(
      p=10000,
      V_total=75,
      V_liquid_start=1.2)
      annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled pump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{6,6},{-6,-6}},
          rotation=180,
          origin={20,30})));
    TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare function iconUnit =
          TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                         annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-18,54})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=723.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-20,30})));

    TRANSFORM.Fluid.Valves.ValveLinear TCV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=180,
          origin={0,30})));
    Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
      annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
    TRANSFORM.Fluid.Machines.SteamTurbine LPT(
      nUnits=1,
      eta_mech=0.93,
      redeclare model Eta_wetSteam =
          TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
      p_a_start=3000000,
      p_b_start=8000,
      T_a_start=673.15,
      T_b_start=343.15,
      m_flow_nominal=200,
      p_inlet_nominal=14000000,
      p_outlet_nominal=8000,
      T_nominal=673.15) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={74,4})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p_start=3900000,
      T_start=473.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5.0),
      use_TraceMassPort=false)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={22,-60})));
    TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
        package Medium = Modelica.Media.Water.StandardWater, V=5)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=90,
          origin={80,28})));
    TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=2.5) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={108,2})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-28,-60})));
    TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                             pump1(redeclare package Medium =
          Modelica.Media.Water.StandardWater,
      use_input=false,
      p_nominal=5500000,
      allowFlowReversal=false)
      annotation (Placement(transformation(extent={{60,-70},{40,-50}})));
    BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
      Moisture_Separator(redeclare package Medium =
          Modelica.Media.Water.StandardWater, redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
      annotation (Placement(transformation(extent={{58,32},{78,52}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium =
          Modelica.Media.Water.StandardWater)            annotation (Placement(
          transformation(
          extent={{8,-6},{-8,6}},
          rotation=90,
          origin={80,-18})));
    TRANSFORM.Fluid.Valves.ValveLinear TBV(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=100000,
      m_flow_nominal=50) annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={-46,72})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=12000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-116,62},{-96,82}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
                          annotation (Placement(
          transformation(extent={{-108,-54},{-88,-34}}), iconTransformation(
            extent={{-108,-54},{-88,-34}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium
        = Modelica.Media.Water.StandardWater)
                          annotation (Placement(
          transformation(extent={{-108,28},{-88,48}}), iconTransformation(extent={
              {-108,28},{-88,48}})));
  initial equation

  equation
   // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

    connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
        points={{38,42},{32,42},{32,30},{26,30}},
        color={0,127,255},
        thickness=0.5));
    connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
            {-18,44}},                                              color={0,127,255}));
    connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
        points={{-30,100},{30,100},{30,36},{20,36},{20,32.16}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
        points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
        points={{-30,100},{-30,54},{-24,54}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
        points={{8,30},{14,30}},
        color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
        points={{-30,100},{-55.4,99}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(LPT.shaft_b, generator.shaft) annotation (Line(
        points={{74,-6},{74,-10.1},{58.1,-10.1}},
        color={0,0,0},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                      color={0,127,255},
        thickness=0.5));
    connect(LPT.portHP, tee.port_1) annotation (Line(
        points={{80,14},{80,16},{80,16},{80,18}},
        color={0,127,255},
        thickness=0.5));
    connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
        points={{90,28},{108,28},{108,12}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
        points={{108,-8},{108,-72},{36,-72},{36,-60},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_T2.port_a, pump.port_b)
      annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
        thickness=0.5));
    connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
        points={{-30,100},{-30,50},{-100,50},{-100,-76},{-28,-76},{-28,-63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
            -60},{60,-60}},                                           color={0,127,
            255},
        thickness=0.5));
    connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
            -60}},                                     color={0,127,255},
        thickness=0.5));
    connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
        points={{58,36},{74,36},{74,14}},
        color={0,0,0},
        pattern=LinePattern.Dash));
    connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
        points={{30,100},{30,54},{0,54},{0,36.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
        Line(
        points={{30,100},{30,88},{116,88},{116,2}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
        points={{58,42},{62,42}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
        points={{74,42},{80,42},{80,38}},
        color={0,127,255},
        thickness=0.5));
    connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
        points={{64,38},{64,8},{28,8},{28,-60}},
        color={0,127,255},
        thickness=0.5));
    connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
        points={{80,-6},{80,-8},{80,-8},{80,-10}},
        color={0,127,255},
        thickness=0.5));
    connect(sensor_m_flow1.port_b,Condenser. port_a)
      annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                       color={0,127,255},
        thickness=0.5));
    connect(TCV.port_a, volume.port_b) annotation (Line(
        points={{-8,30},{-14,30}},
        color={0,127,255},
        thickness=0.5));

    connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
        points={{30,100},{30,101},{66.8,101}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV, TBV.opening) annotation (Line(
        points={{30,100},{30,88},{-46,88},{-46,78.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,
            72},{-38,72}},               color={0,127,255}));
    connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{
            -96,72}},                                  color={0,127,255}));
    connect(port_a, volume.port_a) annotation (Line(points={{-98,38},{-78,38},{
            -78,36},{-56,36},{-56,30},{-26,30}}, color={0,127,255}));
    connect(sensor_T2.port_b, port_b) annotation (Line(points={{-38,-60},{-52,
            -60},{-52,-58},{-70,-58},{-70,-44},{-100,-44}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=86400,
        Interval=30,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>The goal of the HTGR models is to obtain a baseline functioning model that can be used to investigate HTGR applications within IES. That being the motivation, there are likely incorrect time constants throughout the system without relevant comparative data to use. Note also that the current core model structure, while this loop is described as a pebble bed (prismatic is pending), is still using the old nuclear core geometry file. This is due to some odd modeling failures during attempts to change. I will modify this description should I obtain the correct core functioning with a reasonable geometry. Using the old core geometry to obtain the correct flow values (flow area, hydraulic diameters, Reynolds numbers) should provide accurate-enough information. </p>
<p>The Dittus-Boelter simple correlation for single phase heat transfer in turbulent flow is used to calculate the heat transfer between the fuel and the coolant, and maximum fuel temperatures appear to agree with literature (~1200C). </p>
<p>Separate HTGR models will be developed for different uses. The primary differentiator is whether a combined cycle is going to be integrated or not. The combined cycle thoerized to be used here takes advantage of the relatively hot waste heat that is produced by an HTGR to boil water at low pressure and send that to a turbine. </p>
<p>No part of this HTGR model should be considered to be optimized. Additionally, thermal mass of the system needs references and then will need to be adjusted (likely through pipes replacing current zero-volume volume nodes) to more appropriately reflect system time constants. </p>
</html>"));
  end HTGR_Rankine_Cycle;
end Components;
