within NHES.Systems.Examples;
package TES_Use_Case

  model HTGR_SHS_Total
    extends Modelica.Icons.Example;
    PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS,
        redeclare package Power_Medium =
          NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt)
      annotation (Placement(transformation(extent={{-116,-16},{-50,44}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_Total_Power_Prod_RealHX
      two_Tank_SHS_Total_Power_Prod_RealHX(
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        hot_tank_init_temp=823.15,
        cold_tank_init_temp=648.15,
        DHX_NTU=0.8,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_h_start_tube_inlet=500e3,
        DHX_h_start_tube_outlet=200e3,
        DHX_h_start_shell_inlet=400e3,
        DHX_h_start_shell_outlet=3100e3),
      redeclare package Storage_Medium =
          NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt,
      Produced_steam_flow=50)
      annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=4000000,
      T=583.15,
      nPorts=1) annotation (Placement(transformation(extent={{94,20},{74,40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=75,
      T=473.15,
      nPorts=1) annotation (Placement(transformation(extent={{98,-18},{78,2}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 140e5;
    connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_ch_a,
      hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(points={{-27.4,27.6},{
            -40,27.6},{-40,28.7},{-50.99,28.7}}, color={0,127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_a,
      two_Tank_SHS_Total_Power_Prod_RealHX.port_ch_b) annotation (Line(points={{-50.99,
            4.1},{-34,4.1},{-34,-6.6},{-27.4,-6.6}}, color={0,127,255}));
    connect(boundary.ports[1], two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_b)
      annotation (Line(points={{74,30},{31.4,29.4}}, color={0,127,255}));
    connect(boundary1.ports[1], two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_a)
      annotation (Line(points={{78,-8},{38,-8},{38,-6.6},{31.4,-6.6}}, color={0,
            127,255}));
    annotation (experiment(
        StopTime=10,
        __Dymola_NumberOfIntervals=50,
        __Dymola_Algorithm="Dassl"),     Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
  end HTGR_SHS_Total;

  model HTGR_SHS_Independent
    extends Modelica.Icons.Example;
    BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries
                                              BOP(nPorts_a3=1)
      annotation (Placement(transformation(extent={{56,-18},{116,42}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{168,-28},{148,-8}})));
    PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
      annotation (Placement(transformation(extent={{-114,-20},{-44,38}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
      two_Tank_SHS_System_NTU
      annotation (Placement(transformation(extent={{-24,-90},{32,-32}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(
      port_a1_nominal(
        p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
      port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p, h=
            nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h),
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-26,-20},{36,42}})));
    BalanceOfPlant.Turbine.HTGR_Rankine_Cycle hTGR_Rankine_Cycle1
      annotation (Placement(transformation(extent={{62,-90},{122,-30}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.sensor_p.p;
    connect(EM.port_a1, hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(
          points={{-26,23.4},{-34,23.4},{-34,23.21},{-45.05,23.21}}, color={0,127,
            255}));
    connect(EM.port_b1, hTGR_PebbleBed_Primary_Loop.port_a) annotation (Line(
          points={{-26,-1.4},{-26,-0.57},{-45.05,-0.57}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{36,-1.4},{36,0},{56,0}}, color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{36,23.4},{56,24}}, color={0,127,255}));
    connect(sinkElec.port, hTGR_Rankine_Cycle1.port_e) annotation (Line(points={{
            148,-18},{136,-18},{136,-60},{122,-60}}, color={255,0,0}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, hTGR_Rankine_Cycle1.port_a)
      annotation (Line(points={{31.44,-44.18},{52,-44.18},{52,-48},{62,-48}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, hTGR_Rankine_Cycle1.port_b)
      annotation (Line(points={{31.44,-78.98},{52,-78.98},{52,-72},{62,-72}},
          color={0,127,255}));
    connect(BOP.portElec_b, hTGR_Rankine_Cycle1.port_e) annotation (Line(points={
            {116,12},{136,12},{136,-60},{122,-60}}, color={255,0,0}));
    connect(EM.port_b3[1], two_Tank_SHS_System_NTU.port_ch_a) annotation (Line(
          points={{17.4,-20},{17.4,-28},{-36,-28},{-36,-45.92},{-23.44,-45.92}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, BOP.port_a3[1]) annotation (Line(
          points={{-23.44,-78.98},{-52,-78.98},{-52,-102},{128,-102},{128,-26},{
            124,-26},{124,-22},{74,-22},{74,-18}}, color={0,127,255}));
    annotation (experiment(
        StopTime=10,
        __Dymola_NumberOfIntervals=50,
        __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
  end HTGR_SHS_Independent;

  model HTGR_SHS_Peaking
    extends Modelica.Icons.Example;
    BalanceOfPlant.StagebyStageTurbineSecondary.NuScale_Modal_Secondary_Arbitrage_Ports
                                              nuScale_Modal_Secondary_Arbitrage_Ports
      annotation (Placement(transformation(extent={{-30,-22},{30,38}})));
    PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS)
      annotation (Placement(transformation(extent={{-114,-20},{-44,38}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
      two_Tank_SHS_System_NTU
      annotation (Placement(transformation(extent={{52,-22},{110,36}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
      nuScale_Modal_Secondary_Arbitrage_Ports.sensor_p.p;
    connect(nuScale_Modal_Secondary_Arbitrage_Ports.SG_Return,
      hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(points={{-30.6,22.4},{
            -38.3,22.4},{-38.3,23.21},{-45.05,23.21}}, color={0,127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_a,
      nuScale_Modal_Secondary_Arbitrage_Ports.Feedwater) annotation (Line(points=
            {{-45.05,-0.57},{-36,-0.57},{-36,-8.2},{-30.6,-8.2}}, color={0,127,
            255}));
    connect(two_Tank_SHS_System_NTU.port_ch_a,
      nuScale_Modal_Secondary_Arbitrage_Ports.TBV_Send) annotation (Line(points={
            {52.58,22.08},{38,22.08},{38,25.4},{31.2,25.4}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_ch_b,
      nuScale_Modal_Secondary_Arbitrage_Ports.TBV_Return) annotation (Line(points=
           {{52.58,-10.98},{38,-10.98},{38,-8.8},{31.2,-8.8}}, color={0,127,255}));
    connect(nuScale_Modal_Secondary_Arbitrage_Ports.Arbitrage_Send,
      two_Tank_SHS_System_NTU.port_dch_a) annotation (Line(points={{-5.4,-22.6},{
            -4,-22.6},{-4,-40},{118,-40},{118,-10.98},{109.42,-10.98}}, color={0,
            127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_b,
      nuScale_Modal_Secondary_Arbitrage_Ports.Arbitrage_Return) annotation (Line(
          points={{109.42,23.82},{116,23.82},{116,-30},{14,-30},{14,-26},{15,-26},
            {15,-22}}, color={0,127,255}));
    annotation (experiment(
        StopTime=10,
        __Dymola_NumberOfIntervals=50,
        __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
  end HTGR_SHS_Peaking;

  model HTGR_SHS_Total_Component_by_Component
    extends Modelica.Icons.Example;
    PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS,
        redeclare package Power_Medium =
          NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt)
      annotation (Placement(transformation(extent={{-98,40},{-32,100}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_Total_Power_Prod_RealHX
      two_Tank_SHS_Total_Power_Prod_RealHX(
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
        hot_tank_init_temp=823.15,
        cold_tank_init_temp=648.15,
        DHX_NTU=0.8,
        DHX_K_tube(unit="1/m4"),
        DHX_K_shell(unit="1/m4"),
        DHX_h_start_tube_inlet=500e3,
        DHX_h_start_tube_outlet=200e3,
        DHX_h_start_shell_inlet=400e3,
        DHX_h_start_shell_outlet=3100e3),
      redeclare package Storage_Medium =
          NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt,
      Produced_steam_flow=50)
      annotation (Placement(transformation(extent={{-30,-28},{30,32}})));
    BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
        p(displayUnit="MPa") = 10500000,
        h=3070e3,
        m_flow=61.77), port_b_nominal(p=10500000, h=186.28e3))
      annotation (Placement(transformation(extent={{-28,-100},{34,-38}})));
                SwitchYard.SimpleYard.SimpleConnections                   SY(nPorts_a=
          1)
      annotation (Placement(transformation(extent={{94,-96},{150,-40}})));
                ElectricalGrid.InfiniteGrid.Infinite                          EG
      annotation (Placement(transformation(extent={{172,-96},{228,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=67.1,
      T=668.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-102,-72},{-58,-28}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=10500000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,-64},{-56,-120}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=10500000,
      T=668.15,
      nPorts=1) annotation (Placement(transformation(extent={{110,6},{84,34}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=67.1,
      T=315.43,
      nPorts=1) annotation (Placement(transformation(extent={{132,6},{88,-38}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
      redeclare package Medium = NHES.Media.He_HighT,
      p=10500000,
      T=668.15,
      nPorts=1) annotation (Placement(transformation(extent={{-72,0},{-46,-28}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary5(
      redeclare package Medium = Media.He_HighT,
      p=10500000,
      T=668.15,
      nPorts=1) annotation (Placement(transformation(extent={{-72,32},{-46,4}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 140e5;
    connect(EG.portElec_a, SY.port_Grid)
      annotation (Line(points={{172,-68},{150,-68}}, color={255,0,0}));
    connect(SY.port_a[1], BOP.portElec_b) annotation (Line(points={{94,-68},{62,
            -68},{62,-69},{34,-69}}, color={255,0,0}));
    connect(boundary.ports[1], BOP.port_a) annotation (Line(points={{-58,-50},{
            -36,-50},{-36,-56.6},{-28,-56.6}}, color={0,127,255}));
    connect(boundary1.ports[1], BOP.port_b) annotation (Line(points={{-56,-92},{
            -34,-92},{-34,-81.4},{-28,-81.4}}, color={0,127,255}));
    connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_b, boundary2.ports[1])
      annotation (Line(points={{29.4,19.4},{84,20}}, color={0,127,255}));
    connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_a, boundary3.ports[1])
      annotation (Line(points={{29.4,-16.6},{88,-16}}, color={0,127,255}));
    annotation (experiment(
        StopTime=10,
        __Dymola_NumberOfIntervals=50,
        __Dymola_Algorithm="Dassl"),     Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"),
      Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
      Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
  end HTGR_SHS_Total_Component_by_Component;

  model SMR_highfidelity_TES_1
    "High Fidelity Natural Circulation Model based on NuScale reactor. Hot channel calcs, pressurizer, and beginning of cycle reactivity feedback"
   parameter Real fracNominal_BOP = abs(EM.port_b2_nominal.m_flow)/EM.port_a1_nominal.m_flow;
   parameter Real fracNominal_Other = sum(abs(EM.port_b3_nominal_m_flow))/EM.port_a1_nominal.m_flow;
   Real demandChange=
   min(1.05,
   max(SC.W_totalSetpoint_BOP/SC.W_nominal_BOP*fracNominal_BOP
       + sum(EM.port_b3.m_flow./EM.port_b3_nominal_m_flow)*fracNominal_Other,
       0.5));
    PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity
      nuScale_Tave_enthalpy_Pressurizer_CR(
      port_a_nominal(
        m_flow=90,
        T(displayUnit="degC") = 421.15,
        p=3447380),
      port_b_nominal(
        T(displayUnit="degC") = 579.75,
        h=2997670,
        p=3447380),
      redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
        SG_exit_enthalpy=3e6,
        m_setpoint=90.0,
        Q_nom(displayUnit="MW") = 200000000,
        demand=1.0),
      redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-92,-24},{-38,34}})));
    EnergyManifold.SteamManifold.SteamManifold_L1_boundaries EM(port_a1_nominal(
        p=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.p,
        h=nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.h,
        m_flow=-nuScale_Tave_enthalpy_Pressurizer_CR.port_b_nominal.m_flow),
        port_b1_nominal(p=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.p,
          h=nuScale_Tave_enthalpy_Pressurizer_CR.port_a_nominal.h),
      nPorts_b3=1)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(
      port_a_nominal(
        p=EM.port_b2_nominal.p,
        h=EM.port_b2_nominal.h,
        m_flow=-EM.port_b2_nominal.m_flow),
      port_b_nominal(p=EM.port_a2_nominal.p, h=EM.port_a2_nominal.h),
      redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_OTSG_TCV_Pressure_TBV_Power_Control
        CS(
        delayStartTCV=100,
        p_nominal=3447400,
        W_totalSetpoint=SC.W_totalSetpoint_BOP),
      nPorts_a3=1)
      annotation (Placement(transformation(extent={{42,-20},{82,20}})));
    SwitchYard.SimpleYard.SimpleConnections SY(nPorts_a=2)
      annotation (Placement(transformation(extent={{100,-22},{140,22}})));
    ElectricalGrid.InfiniteGrid.Infinite EG
      annotation (Placement(transformation(extent={{160,-20},{200,20}})));
    BaseClasses.Data_Capacity dataCapacity(IP_capacity(displayUnit="MW")=
        53303300, BOP_capacity(displayUnit="MW") = 60000000)
      annotation (Placement(transformation(extent={{-100,82},{-80,102}})));
    Modelica.Blocks.Sources.Constant delayStart(k=0)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    SupervisoryControl.InputSetpointData SC(delayStart=delayStart.k,
      W_nominal_BOP(displayUnit="MW") = 60000000,
      fileName=Modelica.Utilities.Files.loadResource(
          "modelica://NHES/Resources/Data/RAVEN/Uprate_timeSeries.txt"))
      annotation (Placement(transformation(extent={{158,60},{198,100}})));
    EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_System_NTU
      two_Tank_SHS_System_NTU(Produced_steam_flow=10)
      annotation (Placement(transformation(extent={{-22,-78},{18,-32}})));
    BalanceOfPlant.Turbine.HTGR_Rankine_Cycle hTGR_Rankine_Cycle1(redeclare
        NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_PressureAndPowerControl
        CS)
      annotation (Placement(transformation(extent={{42,-76},{82,-34}})));
  equation
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_b, EM.port_a1) annotation (
        Line(points={{-37.1692,13.2857},{-30,13.2857},{-30,8},{-20,8}}, color={0,
            127,255}));
    connect(nuScale_Tave_enthalpy_Pressurizer_CR.port_a, EM.port_b1) annotation (
        Line(points={{-37.1692,-0.385714},{-30,-0.385714},{-30,-8},{-20,-8}},
          color={0,127,255}));
    connect(EM.port_b2, BOP.port_a)
      annotation (Line(points={{20,8},{42,8}}, color={0,127,255}));
    connect(EM.port_a2, BOP.port_b)
      annotation (Line(points={{20,-8},{42,-8}}, color={0,127,255}));
    connect(BOP.portElec_b, SY.port_a[1])
      annotation (Line(points={{82,0},{92,0},{92,-1.1},{100,-1.1}},
                                                color={255,0,0}));
    connect(SY.port_Grid, EG.portElec_a)
      annotation (Line(points={{140,0},{160,0}}, color={255,0,0}));
    connect(hTGR_Rankine_Cycle1.port_e, SY.port_a[2]) annotation (Line(points={
            {82,-55},{90,-55},{90,1.1},{100,1.1}}, color={255,0,0}));
    connect(two_Tank_SHS_System_NTU.port_ch_b, BOP.port_a3[1]) annotation (Line(
          points={{-21.6,-69.26},{-38,-69.26},{-38,-84},{32,-84},{32,-24},{54,
            -24},{54,-20}}, color={0,127,255}));
    connect(EM.port_b3[1], two_Tank_SHS_System_NTU.port_ch_a) annotation (Line(
          points={{8,-20},{10,-20},{10,-28},{-30,-28},{-30,-43.04},{-21.6,
            -43.04}}, color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_b, hTGR_Rankine_Cycle1.port_a)
      annotation (Line(points={{17.6,-41.66},{36,-41.66},{36,-46.6},{42,-46.6}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_NTU.port_dch_a, hTGR_Rankine_Cycle1.port_b)
      annotation (Line(points={{17.6,-69.26},{26,-69.26},{26,-63.4},{42,-63.4}},
          color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{220,100}}), graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-38,-104},{162,96}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{26,52},{126,-8},{26,-68},{26,52}})}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-100,-100},{220,100}})),
      experiment(
        StopTime=18000,
        Interval=1,
        __Dymola_Algorithm="Esdirk45a"));
  end SMR_highfidelity_TES_1;
end TES_Use_Case;
