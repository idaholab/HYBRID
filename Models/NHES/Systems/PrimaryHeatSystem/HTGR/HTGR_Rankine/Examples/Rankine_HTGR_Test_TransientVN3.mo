within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Test_TransientVN3
  extends Modelica.Icons.Example;
  Components.HTGR_PebbleBed_Primary_Loop_HeOut hTGR_PebbleBed_Primary_Loop(
      redeclare
      ControlSystems.CS_VN
      CS(
      const6(k=5e6),
      add(k1=0.5),
      ramp(height=0.88)),
    data(
      Q_total=270000000,
      length_core=5,
      nPebble=5000),
    core(nPebble=150000))
          annotation (Placement(transformation(extent={{-110,-16},{-40,42}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=4000000,
    T=378.15,
    nPorts=1) annotation (Placement(transformation(extent={{38,22},{18,42}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    p=4000000,
    T=523.15,
    nPorts=1) annotation (Placement(transformation(extent={{42,-22},{22,-2}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;
  connect(hTGR_PebbleBed_Primary_Loop.port_b, boundary.ports[1]) annotation (
      Line(points={{-41.05,27.21},{12,27.21},{12,32},{18,32}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a, boundary1.ports[1]) annotation (
      Line(points={{-41.05,3.43},{18,3.43},{18,-12},{22,-12}}, color={0,127,255}));
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
end Rankine_HTGR_Test_TransientVN3;
