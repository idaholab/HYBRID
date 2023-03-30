within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Test_TransientVN
  extends Modelica.Icons.Example;
  BalanceOfPlant.Turbine.HTGR_RankineCycles.HTGR_Rankine_Cycle_Transient
    hTGR_Rankine_Cycle(redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
      CS) annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
  TRANSFORM.Electrical.Sources.FrequencySource
                                     sinkElec(f=60)
    annotation (Placement(transformation(extent={{78,2},{58,22}})));
  Components.HTGR_PebbleBed_Primary_Loop_STHX hTGR_PebbleBed_Primary_Loop(
      redeclare
      ControlSystems.CS_VN
      CS) annotation (Placement(transformation(extent={{-110,-18},{-40,40}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
  connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
    annotation (Line(points={{58,12},{32,12}}, color={255,0,0}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
    annotation (Line(points={{-41.05,25.21},{-42,25.21},{-42,24},{-28,24}},
                                                                   color={0,127,
          255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, hTGR_Rankine_Cycle.port_b)
    annotation (Line(points={{-41.05,1.43},{-28,0}},
        color={0,127,255}));
  annotation (experiment(
      StopTime=1004200,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
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
end Rankine_HTGR_Test_TransientVN;
