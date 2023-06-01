within NHES.TestModels_AS;
model HeliumWater_CTHX_DoesNotWork "Helium-based steam generator"
  import TRANSFORM;
  extends TRANSFORM.Icons.Example;
   parameter SI.TemperatureDifference DT_lm2 = 43.2 "Log mean temperature difference";
   parameter SI.CoefficientOfHeatTransfer U2_shell = 38.1 "Overall heat transfer coefficient - shell side";
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T tube_inlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=0.2,
    T(displayUnit="degC") = 394.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-99,-34},{-87,-22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT tube_outlet(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p(displayUnit="bar") = 200000,
    T(displayUnit="degC") = 313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{97,-33},{87,-23}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T shell_inlet(
    m_flow=1,
    T(displayUnit="degC") = 293.15,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    nPorts=1)
    annotation (Placement(transformation(extent={{97,15},{85,27}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT shell_outlet(
    p(displayUnit="bar") = 120000,
    T(displayUnit="degC") = 333.15,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
    nPorts=1)
    annotation (Placement(transformation(extent={{-99,15},{-89,25}})));
  TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
    p_b_start_shell=shell_outlet.p,
    T_a_start_shell=shell_inlet.T,
    T_b_start_shell=shell_outlet.T,
    p_b_start_tube=tube_outlet.p,
    counterCurrent=true,
    m_flow_a_start_tube=tube_inlet.m_flow,
    m_flow_a_start_shell=shell_inlet.m_flow,
    redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
    redeclare package Medium_shell = Modelica.Media.IdealGases.SingleGases.He,
    redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ConcentricTubeHX (
        D_o_shell=0.5,
        length_tube=5,
        dimension_tube=0.09,
        th_wall=0.01,
        nV=5,
        nR=3),
    p_a_start_tube=tube_outlet.p + 100,
    T_a_start_tube=tube_inlet.T,
    T_b_start_tube=tube_outlet.T,
    p_a_start_shell=shell_outlet.p + 100,
    energyDynamics={Modelica.Fluid.Types.Dynamics.SteadyStateInitial,Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        Modelica.Fluid.Types.Dynamics.SteadyStateInitial},
    redeclare model HeatTransfer_tube =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_3Region_Chato_Condensation_AS2022,
    redeclare model HeatTransfer_shell =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region)
    annotation (Placement(transformation(extent={{-21,-20},{21,20}})));
   SI.TemperatureDifference DT_lm "Log mean temperature difference";
   SI.ThermalConductance UA "Overall heat transfer conductance";
   SI.CoefficientOfHeatTransfer U_shell "Overall heat transfer coefficient - shell side";
   SI.CoefficientOfHeatTransfer U_tube "Overall heat transfer coefficient - tube side";
   SI.CoefficientOfHeatTransfer alphaAvg_shell "Average shell side heat transfer coefficient";
   SI.ThermalResistance R_shell;
   SI.CoefficientOfHeatTransfer alphaAvg_tube;
   SI.ThermalResistance R_tube;
  UserInteraction.Outputs.SpatialPlot2 spatialPlot2_1(
    y1={STHX.tube.mediums[i].T for i in 1:STHX.geometry.nV},
    y2={STHX.shell.mediums[i].T for i in 1:STHX.geometry.nV},
    x1=STHX.tube.summary.xpos_norm,
    minY1=min({tube_inlet.T,shell_inlet.T,tube_outlet.T,shell_outlet.T}),
    maxY1=max({tube_inlet.T,shell_inlet.T,tube_outlet.T,shell_outlet.T}),
    minY2=min({tube_inlet.T,shell_inlet.T,tube_outlet.T,shell_outlet.T}),
    maxY2=max({tube_inlet.T,shell_inlet.T,tube_outlet.T,shell_outlet.T}),
    x2=if STHX.counterCurrent == true then Modelica.Math.Vectors.reverse(STHX.shell.summary.xpos_norm)
         else STHX.shell.summary.xpos_norm)
    annotation (Placement(transformation(extent={{-96,-92},{-46,-48}})));
  TRANSFORM.Utilities.ErrorAnalysis.UnitTests
                                    unitTests(n=4, x={STHX.tube.mediums[2].p,
        STHX.shell.mediums[2].p,STHX.tube.mediums[2].h,STHX.shell.mediums[2].h})
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort HeTempIn(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-30,10},{-50,30}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort HeTempOut(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{50,11},{30,31}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort WaterTempIn(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-50,-38},{-30,-18}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort WaterTempOut(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,-38},{50,-18}})));
  TRANSFORM.Fluid.Sensors.Pressure HeInPress(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
  TRANSFORM.Fluid.Sensors.Pressure HeOutPress(redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He)
    annotation (Placement(transformation(extent={{54,21},{74,41}})));
  TRANSFORM.Fluid.Sensors.Pressure WaterInPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-78,-28},{-58,-8}})));
  TRANSFORM.Fluid.Sensors.Pressure WaterOutPress(redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{56,-28},{76,-8}})));
equation
  alphaAvg_shell =sum(STHX.shell.heatTransfer.alphas)/STHX.geometry.nV;
  R_shell =1/(alphaAvg_shell*sum(STHX.shell.geometry.surfaceAreas));
  alphaAvg_tube =sum(STHX.tube.heatTransfer.alphas)/STHX.geometry.nV;
  R_tube =1/(alphaAvg_tube*sum(STHX.tube.geometry.surfaceAreas));
  DT_lm = TRANSFORM.HeatExchangers.Utilities.Functions.LMTD(
        T_hi=STHX.shell.mediums[1].T,
        T_ho=STHX.shell.mediums[STHX.geometry.nV].T,
        T_ci=STHX.tube.mediums[1].T,
        T_co=STHX.tube.mediums[STHX.geometry.nV].T,
        counterCurrent=STHX.counterCurrent);
  UA = TRANSFORM.HeatExchangers.Utilities.Functions.UA(
        n=3,
        isSeries={true,true,true},
        R=[R_tube; 1.25412e-6; R_shell]);
  U_shell =UA/sum(STHX.shell.geometry.surfaceAreas);
  U_tube =UA/sum(STHX.tube.geometry.surfaceAreas);
  connect(HeTempOut.port_b, STHX.port_a_shell) annotation (Line(points={{30,21},{21,21},{21,9.2}}, color={0,127,255}));
  connect(HeTempIn.port_a, STHX.port_b_shell) annotation (Line(points={{-30,20},{-21,20},{-21,9.2}}, color={0,127,255}));
  connect(WaterTempIn.port_b, STHX.port_a_tube) annotation (Line(points={{-30,-28},{-26,-28},{-26,0},{-21,0}}, color={0,127,255}));
  connect(WaterTempOut.port_a, STHX.port_b_tube) annotation (Line(points={{30,-28},{26,-28},{26,0},{21,0}}, color={0,127,255}));
  connect(WaterTempIn.port_a, WaterInPress.port) annotation (Line(points={{-50,-28},{-68,-28}}, color={0,127,255}));
  connect(WaterInPress.port, tube_inlet.ports[1]) annotation (Line(points={{-68,-28},{-87,-28}}, color={0,127,255}));
  connect(WaterTempOut.port_b, WaterOutPress.port) annotation (Line(points={{50,-28},{66,-28}}, color={0,127,255}));
  connect(WaterOutPress.port, tube_outlet.ports[1]) annotation (Line(points={{66,-28},{87,-28}}, color={0,127,255}));
  connect(HeTempIn.port_b, HeInPress.port) annotation (Line(points={{-50,20},{-72,20}}, color={0,127,255}));
  connect(HeInPress.port, shell_outlet.ports[1]) annotation (Line(points={{-72,20},{-89,20}}, color={0,127,255}));
  connect(HeTempOut.port_a, HeOutPress.port) annotation (Line(points={{50,21},{64,21}}, color={0,127,255}));
  connect(HeOutPress.port, shell_inlet.ports[1]) annotation (Line(points={{64,21},{85,21}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Example 11.1 (pp. 680-682).</p>
<p>A counterflow, concentric tube heat exchanger with oil and water taken from Example 11.1 (pp. 680-682) of Fundamentals of Heat and Mass Transfer by Incropera and DeWitt.</p>
</html>"));
end HeliumWater_CTHX_DoesNotWork;
