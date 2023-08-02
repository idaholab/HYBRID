within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_ThreeStageTurbine_OFWH
  extends Modelica.Icons.Example;

  Components.HTGR_PebbleBed_Primary_Loop_STHX hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_Primary_SS_RX
      CS) annotation (Placement(transformation(extent={{-100,-20},{-40,40}})));
  Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,16},{-14,36}})));
  Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-14,-10},{-30,10}})));
  Fluid.Sensors.stateDisplay stateDisplay2
    annotation (Placement(transformation(extent={{-42,34},{-2,64}})));
  Fluid.Sensors.stateDisplay stateDisplay1
    annotation (Placement(transformation(extent={{-42,-10},{-2,-40}})));
  BalanceOfPlant.Turbine.SteamTurbine_L3_HPOFWH BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3_HTGR CS(data(
        HPT_p_in=14000000,
        p_dump=16000000,
        Tin=788.15,
        Tfeed=481.15,
        d_HPT_in(displayUnit="kg/m3") = 43.049187,
        d_LPT1_in(displayUnit="kg/m3") = 1.783316,
        d_LPT2_in(displayUnit="kg/m3"),
        mdot_total=50.55,
        mdot_fh=10.6,
        mdot_hpt=39.945,
        mdot_lpt1=39.945,
        mdot_lpt2=35.7553,
        eta_t=0.9,
        eta_mech=0.95), Power_set(y=1e10)),
    redeclare replaceable BalanceOfPlant.Turbine.Data.Data_L3 data(
      HPT_p_in=14000000,
      p_dump=16000000,
      Tin=788.15,
      Tfeed=481.15,
      d_HPT_in(displayUnit="kg/m3") = 43.049187,
      d_LPT1_in(displayUnit="kg/m3") = 1.783316,
      d_LPT2_in(displayUnit="kg/m3"),
      mdot_total=50.55,
      mdot_fh=10.6,
      mdot_hpt=39.945,
      mdot_lpt1=39.945,
      mdot_lpt2=35.7553,
      eta_t=0.9,
      eta_mech=0.95),
    OFWH_1(T_start=333.15),
    OFWH_2(T_start=353.15))
    annotation (Placement(transformation(extent={{58,-26},{138,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=280000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,-66},{20,-46}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=3400000,
    nPorts=1)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{180,4},{160,24}})));
  BalanceOfPlant.Turbine.Data.Data_L3 data(HPT_p_in=14000000, p_dump=16000000, Tin=788.15, Tfeed=481.15, d_HPT_in(displayUnit="kg/m3") = 43.049187, d_LPT1_in(displayUnit="kg/m3") = 1.783316, d_LPT2_in(displayUnit="kg/m3"), mdot_total=50.55, mdot_fh=10.6, mdot_hpt=39.945, mdot_lpt1=39.945, mdot_lpt2=35.7553, eta_t=0.9, eta_mech=0.95)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.TCV.port_a.p;
  connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
      Line(points={{-40.9,24.7},{-40.9,26},{-30,26}},    color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, stateSensor2.port_b) annotation (
      Line(points={{-40.9,0.1},{-40.9,0},{-30,0}},    color={0,127,255}));
  connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
        points={{-21.96,26.05},{-22,26.05},{-22,45.1}}, color={0,0,0}));
  connect(stateSensor2.statePort, stateDisplay1.statePort)
    annotation (Line(points={{-22.04,0.05},{-22,-21.1}}, color={0,0,0}));
  connect(bypassdump.ports[1],BOP. port_b_bypass)
    annotation (Line(points={{20,-56},{48,-56},{48,14},{58,14}},
                                             color={0,127,255}));
  connect(steamdump.ports[1],BOP. prt_b_steamdump)
    annotation (Line(points={{20,84},{50,84},{50,54},{58,54}},
                                               color={0,127,255}));
  connect(boundary.port,BOP. port_a_elec)
    annotation (Line(points={{160,14},{138,14}},
                                               color={255,0,0}));
  connect(BOP.port_a_steam, stateSensor1.port_b) annotation (Line(points={{58,
          38},{4,38},{4,26},{-14,26}}, color={0,127,255}));
  connect(stateSensor2.port_a, BOP.port_b_feed) annotation (Line(points={{-14,0},
          {48,0},{48,-10},{58,-10}}, color={0,127,255}));
  annotation (experiment(
      StopTime=2000000,
      Interval=100,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Three-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>The ThreeStaged Turbine BOP model contains four control elements: </p>
<p>1. maintaining steam (steam generator outlet) pressure by using TCV</p>
<p>2. controling amount of electricity generated by using LPTBV1</p>
<p>3. maintaining feedwater temperature by using LPTBV2</p>
<p>4. maintaining steam (steam generator outlet) temperature by controlling feedwater pump RPM</p>
</html>"),
    __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
          Design.Internal.Records.ModelDependencySetup(
          Model=
            "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
          dependencyParameters={Design.Internal.Records.DependencyParameter(
            name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
            1e-05,
            1e-06,
            6))},
          VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
            Design.Internal.Records.VariableToPlot(name=
            "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
          integrator=Design.Internal.Records.Integrator(
            startTime=0,
            stopTime=1004200,
            numberOfIntervals=0,
            outputInterval=10,
            method="Esdirk45a",
            tolerance=0.0001,
            fixedStepSize=0)))),
    __Dymola_experimentSetupOutput(events=false));
end Rankine_HTGR_ThreeStageTurbine_OFWH;
