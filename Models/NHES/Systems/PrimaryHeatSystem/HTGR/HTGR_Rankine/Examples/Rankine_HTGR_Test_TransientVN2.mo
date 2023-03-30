within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples;
model Rankine_HTGR_Test_TransientVN2
  extends Modelica.Icons.Example;
  Components.HTGR_PebbleBed_Primary_Loop_STHX hTGR_PebbleBed_Primary_Loop(
      redeclare
      ControlSystems.CS_VN
      CS) annotation (Placement(transformation(extent={{-110,-18},{-40,40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=4000000,
    T=378.15,
    nPorts=1) annotation (Placement(transformation(extent={{38,22},{18,42}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=45,
    T=378.15,
    nPorts=1) annotation (Placement(transformation(extent={{40,-24},{20,-4}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 40;
  connect(boundary1.ports[1], hTGR_PebbleBed_Primary_Loop.port_a) annotation (
      Line(points={{20,-14},{-34,-14},{-34,1.43},{-41.05,1.43}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_b, boundary.ports[1]) annotation (
      Line(points={{-41.05,25.21},{12,25.21},{12,32},{18,32}}, color={0,127,255}));
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
end Rankine_HTGR_Test_TransientVN2;
