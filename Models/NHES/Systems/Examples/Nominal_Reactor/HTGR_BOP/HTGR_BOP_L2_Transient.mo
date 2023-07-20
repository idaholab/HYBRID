within NHES.Systems.Examples.Nominal_Reactor.HTGR_BOP;
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
