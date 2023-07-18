within NHES.Systems.Examples;
package HTGR_BOP
  model HTGR_BOP_L1_Transient
    import NHES;
    extends Modelica.Icons.Example;
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
      BOP(
      nPorts_a3=1,
      port_a3_nominal_m_flow={0},
      port_a_nominal(
        m_flow=45.7058,
        p=14000000,
        h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 813)),
      port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
            481)),
      redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
        CS(
        delayStartTCV=0,
        delayStartBV=0,
        p_nominal=14000000,
        W_totalSetpoint=ElectricPowerDemand.y),
      reservoir(level_start=10))
      annotation (Placement(transformation(extent={{14,-30},{74,30}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{96,-8},{84,8}})));
    Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-26,-22},{-46,-2}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-30,2},{-10,22}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-58,-70},{-14,-40}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-42,20},{2,50}})));
    Modelica.Fluid.Sources.MassFlowSource_h source1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      use_m_flow_in=false,
      m_flow=10,
      h=3e6)
      annotation (Placement(transformation(extent={{56,-56},{36,-36}})));
    NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX
      hTGR_PebbleBed_Primary_Loop(redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS
        CS)
      annotation (Placement(transformation(extent={{-112,-30},{-54,26}})));
    Modelica.Blocks.Sources.Constant ElectricPowerDemand(k=4.4e7)
      annotation (Placement(transformation(extent={{-98,76},{-78,96}})));
    TRANSFORM.Fluid.Machines.Pump_Controlled feedWaterpump(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      redeclare model EfficiencyChar =
          TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant,
      N_nominal=1200,
      dp_nominal=15000000,
      m_flow_nominal=50,
      d_nominal=1000,
      controlType="RPM",
      use_port=true)
      annotation (Placement(transformation(extent={{2,-2},{-18,-22}})));

    Modelica.Blocks.Sources.Constant const2(k=-1e-1)
      annotation (Placement(transformation(extent={{3,-3},{-3,3}},
          rotation=90,
          origin={21,-65})));
    Modelica.Blocks.Sources.Constant const10(k=5000)
      annotation (Placement(transformation(extent={{3,-3},{-3,3}},
          rotation=90,
          origin={37,-65})));
    Modelica.Blocks.Sources.Constant const1(k=-150)
      annotation (Placement(transformation(extent={{3,-3},{-3,3}},
          rotation=90,
          origin={29,-65})));
    Modelica.Blocks.Sources.Constant setpoint_SteamTemperature(k=540)
      annotation (Placement(transformation(extent={{52,-88},{46,-82}})));
    NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.SupportComponent.VarLimVarK_PID
      PID(
      use_k_in=true,
      use_lowlim_in=true,
      use_uplim_in=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=true,
      k=-5e-1,
      Ti=30)
      annotation (Placement(transformation(extent={{34,-86},{24,-76}})));
    Modelica.Blocks.Math.Add         add
      annotation (Placement(transformation(extent={{8,-78},{-4,-66}})));
    Modelica.Blocks.Sources.Constant RPM_basis(k=1000)
      annotation (Placement(transformation(extent={{24,-60},{18,-54}})));
    Modelica.Blocks.Sources.RealExpression SteamTemperature(y=stateDisplay1.T)
      annotation (Placement(transformation(extent={{-8,-98},{18,-82}})));
    Modelica.Blocks.Sources.Constant const6(k=0)
      annotation (Placement(transformation(extent={{52,-76},{46,-70}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
      BOP.pressure.p;

    connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
          points={{-20,31.1},{-20,12.05},{-19.95,12.05}},            color={0,0,0}));
    connect(stateDisplay.statePort, stateSensor2.statePort) annotation (Line(
          points={{-36,-58.9},{-36,-11.95},{-36.05,-11.95}}, color={0,0,0}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-10,12},{14,12}},  color={0,127,255}));
    connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{36,-46},{
            32,-46},{32,-30}},    color={0,127,255}));
    connect(BOP.portElec_b, sinkElec.port)
      annotation (Line(points={{74,0},{84,0}}, color={255,0,0}));
    connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
        Line(points={{-54.87,11.72},{-54.87,12},{-30,12}}, color={0,127,255}));
    connect(stateSensor2.port_b, hTGR_PebbleBed_Primary_Loop.port_a) annotation (
        Line(points={{-46,-12},{-54.87,-12},{-54.87,-11.24}}, color={0,127,255}));
    connect(stateSensor2.port_a, feedWaterpump.port_b)
      annotation (Line(points={{-26,-12},{-18,-12}}, color={0,127,255}));
    connect(feedWaterpump.port_a, BOP.port_b)
      annotation (Line(points={{2,-12},{14,-12}},    color={0,127,255}));
    connect(const10.y,PID. upperlim)
      annotation (Line(points={{37,-68.3},{32,-68.3},{32,-75.5}},
                                                               color={0,0,127}));
    connect(const1.y,PID. lowerlim) annotation (Line(points={{29,-68.3},{29,-75.5}},
                        color={0,0,127}));
    connect(PID.y,add. u2) annotation (Line(points={{23.5,-81},{20,-81},{20,-75.6},
            {9.2,-75.6}},
                        color={0,0,127}));
    connect(add.y, feedWaterpump.inputSignal) annotation (Line(points={{-4.6,-72},
            {-8,-72},{-8,-19}},                        color={0,0,127}));
    connect(SteamTemperature.y, PID.u_m)
      annotation (Line(points={{19.3,-90},{29,-90},{29,-87}}, color={0,0,127}));
    connect(setpoint_SteamTemperature.y, PID.u_s) annotation (Line(points={{45.7,
            -85},{40,-85},{40,-81},{35,-81}}, color={0,0,127}));
    connect(PID.u_ff, const6.y) annotation (Line(points={{35,-77},{40,-77},{40,
            -73},{45.7,-73}}, color={0,0,127}));
    connect(const2.y, PID.prop_k) annotation (Line(points={{21,-68.3},{25.3,-68.3},
            {25.3,-75.3}}, color={0,0,127}));
    connect(add.u1, RPM_basis.y) annotation (Line(points={{9.2,-68.4},{10,-68.4},
            {10,-68},{12,-68},{12,-57},{17.7,-57}}, color={0,0,127}));
    annotation (experiment(
        StopTime=60000,
        __Dymola_NumberOfIntervals=200,
        __Dymola_Algorithm="Esdirk34a"), __Dymola_experimentSetupOutput(events=
            false),
      Documentation(info="<html>
<p><b><span style=\"font-size: 18pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">HTGR-1_Section_BOP (Rankine cycle with feedwater heating internal to the system) for Transient</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">Transient test of HTGR(PebbleBed)_OneSectionBOP(Rankine). The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </span></p>
<p><span style=\"font-size: 12pt;\">This example is developed in order to compare results with HTGR-3 Section BOP (Rankine cycle with feedwater heating internal to the system). Details of comparison can be found in [1]. </span></p>
<p><br><b><span style=\"font-size: 18pt;\">What Users Can Do </span></b></p>
<p><span style=\"font-size: 12pt;\">If one would like to test transient scenario where electric power demand changes, one needs to change ElectricPowerDemand block in the model. </span></p>
<p><br><b><span style=\"font-size: 18pt;\">Reference </span></b></p>
<p><span style=\"font-size: 12pt;\">[1] Status Report on Thermal Extraction Modeling in HYBRID (INL/RPT-23-03062)</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Junyung Kim and Daniel Mikkelson.</span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Daniel Mikkelson (Daniel.Mikkelson@inl.gov). </span></p>
</html>"));
  end HTGR_BOP_L1_Transient;

  model HTGR_BOP_L2_Transient
    extends Modelica.Icons.Example;
    BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.HTGR_Rankine_Cycle_Transient
      hTGR_Rankine_Cycle(redeclare
        NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
        CS) annotation (Placement(transformation(extent={{8,-18},{72,42}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{100,2},{80,22}})));
    PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_TransientControl
        CS) annotation (Placement(transformation(extent={{-108,-20},{-38,40}})));
    Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-26,14},{-4,36}})));
    Fluid.Sensors.stateDisplay stateDisplay1
      annotation (Placement(transformation(extent={{-38,38},{8,68}})));
    Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-4,-10},{-26,10}})));
    Fluid.Sensors.stateDisplay stateDisplay
      annotation (Placement(transformation(extent={{-38,-24},{8,-52}})));
  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
    connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
      annotation (Line(points={{80,12},{72,12}}, color={255,0,0}));
    connect(hTGR_Rankine_Cycle.port_b, stateSensor2.port_a)
      annotation (Line(points={{8,0},{-4,0}}, color={0,127,255}));
    connect(stateSensor2.port_b, hTGR_PebbleBed_Primary_Loop.port_a)
      annotation (Line(points={{-26,0},{-39.05,0.1}}, color={0,127,255}));
    connect(hTGR_Rankine_Cycle.port_a, stateSensor1.port_b) annotation (Line(
          points={{8,24},{6,24},{6,25},{-4,25}}, color={0,127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a)
      annotation (Line(points={{-39.05,24.7},{-26,25}}, color={0,127,255}));
    connect(stateDisplay1.statePort, stateSensor1.statePort)
      annotation (Line(points={{-15,49.1},{-14.945,25.055}}, color={0,0,0}));
    connect(stateSensor2.statePort, stateDisplay.statePort)
      annotation (Line(points={{-15.055,0.05},{-15,-34.36}}, color={0,0,0}));
    annotation (experiment(
        StopTime=1004200,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p><b><span style=\"font-size: 18pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">HTGR-2_Section_BOP (Rankine cycle with feedwater heating internal to the system) for Transient</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Design Purpose of Exampe</span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">What Users Can Do </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">Reference </span></b></p>
<p><i><span style=\"font-size: 12pt;\">&lt; Please fill this section, if needed &gt;</span></i></p>
<p><br><b><span style=\"font-size: 18pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Aidan Rigby and Daniel Mikkelson. </span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Daniel Mikkelson (Daniel.Mikkelson@inl.gov). </span></p>
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
              fixedStepSize=0)))));
  end HTGR_BOP_L2_Transient;

  model HTGR_BOP_L3_Transient
    extends Modelica.Icons.Example;

    Real Thermal_Power_Norm;
    BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HTGR BOP
            annotation (Placement(transformation(extent={{-6,-10},{62,38}})));
    TRANSFORM.Electrical.Sources.FrequencySource
                                       sinkElec(f=60)
      annotation (Placement(transformation(extent={{98,6},{84,22}})));
    PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX hTGR_PebbleBed_Primary_Loop(
        redeclare
        NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS
        CS) annotation (Placement(transformation(extent={{-98,-18},{-40,40}})));
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

  equation
    hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.sensor_p.p;
    Thermal_Power_Norm = hTGR_PebbleBed_Primary_Loop.Thermal_Power.y/2.26177E8;
    connect(sinkElec.port, BOP.port_e)
      annotation (Line(points={{84,14},{62,14}}, color={255,0,0}));
    connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
        Line(points={{-40.87,25.21},{-40.87,26},{-30,26}}, color={0,127,255}));
    connect(stateSensor1.port_b, BOP.port_a)
      annotation (Line(points={{-14,26},{-6,26},{-6,25.52}}, color={0,127,255}));
    connect(stateSensor2.port_a, BOP.port_b)
      annotation (Line(points={{-14,0},{-6,0.08}}, color={0,127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_a, stateSensor2.port_b) annotation (
        Line(points={{-40.87,1.43},{-40.87,0},{-30,0}}, color={0,127,255}));
    connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
          points={{-21.96,26.05},{-22,26.05},{-22,45.1}}, color={0,0,0}));
    connect(stateSensor2.statePort, stateDisplay1.statePort)
      annotation (Line(points={{-22.04,0.05},{-22,-21.1}}, color={0,0,0}));
    annotation (experiment(
        StopTime=50000,
        Interval=1000,
        __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p><b><span style=\"font-size: 18pt;\">Example Name</span></b></p>
<p><span style=\"font-size: 12pt;\">HTGR-3_Section_BOP (Rankine cycle with feedwater heating internal to the system) for Transient</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Design Purpose of Exampe</span></b></p>
<p><span style=\"font-size: 12pt;\">Transient test of HTGR(PebbleBed)_ThreeSectionBOP(Rankine). The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </span></p>
<p><span style=\"font-size: 12pt;\">This example is developed in order to compare results with HTGR-1_ Section_BOP (Rankine cycle with feedwater heating internal to the system). Details of comparison can be found in [1]. </span></p>
<p><br><b><span style=\"font-size: 18pt;\">What Users Can Do </span></b></p>
<p><span style=\"font-size: 12pt;\">Users of this example model can test transient initiated from external electricity demand (i.e., time for demand increase; time for demand decrease; time for maximum electricity demand; one-cycle time period for electricity demand; and maximum anout of electricity demanded). See <i>Parameters</i> in the <i><span style=\"font-family: (Default);\">BOP</span></i> model.</p>
<p><br><b><span style=\"font-size: 18pt;\">Reference </span></b></p>
<p><span style=\"font-size: 12pt;\">[1] Status Report on Thermal Extraction Modeling in HYBRID (INL/RPT-23-03062)</span></p>
<p><br><b><span style=\"font-size: 18pt;\">Contact Deatils </span></b></p>
<p><span style=\"font-size: 12pt;\">This model was designed by Junyung Kim and Daniel Mikkelson. </span></p>
<p><span style=\"font-size: 12pt;\">All initial questions should be directed to Daniel Mikkelson (Daniel.Mikkelson@inl.gov). </span></p>
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
  end HTGR_BOP_L3_Transient;
end HTGR_BOP;
