within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.OldTestModels;
model DischargingFinal
  Real DischargeStopTrig;

  parameter Real tablePhicT[5, 4]=[1, 90, 100, 110;
                                   2.36, 4.68e-3, 4.68e-3, 4.68e-3;
                                   2.88, 4.68e-3, 4.68e-3, 4.68e-3;
                                   3.56, 4.68e-3, 4.68e-3, 4.68e-3;
                                   4.46, 4.68e-3, 4.68e-3, 4.68e-3];

  parameter Real tableEtaT[5, 4]=[1, 90, 100, 110;
                                  2.36, 89e-2, 89.5e-2, 89.3e-2;
                                  2.88, 90e-2, 90.6e-2, 90.5e-2;
                                  3.56, 90.5e-2, 90.6e-2, 90.5e-2;
                                  4.46, 90.2e-2, 90.3e-2, 90e-2];
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{172,170},{192,190}})));
  Components.Turbine2      turbine2(
    redeclare package Medium = Media.Air,
    pstart_in=710000,
    pstart_out=200000,
    tablePhic=tablePhicT,
    tableEta=tableEtaT,
    Table=NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes.matrix,
    Tstart_out=423.15,
    Tdes_in=473.15,
    Tstart_in=473.15,
    Ndesign=157.08) annotation (Placement(transformation(extent={{40,-106},{100,-46}},rotation=0)));
  TRANSFORM.Fluid.Volumes.SimpleVolume_1Port
                                       Cavern(
    redeclare package Medium = Media.Air,
    p_start=2650000,
    T_start=313.15,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=150000),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{-22,55},{-78,1}})));
  TRANSFORM.Fluid.Valves.ValveLinear TurbValve(
    redeclare package Medium = Media.Air,
    dp_nominal=1000,
    m_flow_nominal=1)  annotation (Placement(transformation(extent={{10,18},{30,38}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Sink(
    redeclare package Medium = Media.Air,
    p=10000,
    T=423.15,
    nPorts=1) annotation (Placement(transformation(extent={{136,-34},{116,-14}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume vol2(
    redeclare package Medium = Media.Air,
    p_start=turbine2.pstart_in,
    redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.00001))
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={46,-8})));
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,5e7; 1,5e7; 2,5e7; 3,5e7], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{168,112},{148,132}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    yMax=1,
    yMin=0.00001)
                 annotation (Placement(transformation(extent={{106,112},{86,132}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=turbine2.TurbPower)
    annotation (Placement(transformation(extent={{172,50},{152,70}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection(surfaceArea=25000, alpha=30)
    annotation (Placement(transformation(extent={{-70,64},{-122,112}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-174,78},{-154,98}})));
  Modelica.Blocks.Sources.RealExpression DischargeTrigger(y=DischargeStopTrig)
    annotation (Placement(transformation(extent={{172,-158},{152,-138}})));
initial equation
  DischargeStopTrig = 1;

equation
  der(DischargeStopTrig) = 1e-20;
  when Cavern.medium.p <= 18E5 then
    reinit(DischargeStopTrig,0);
  end when;

  connect(turbine2.outlet,Sink. ports[1])
    annotation (Line(points={{94,-52},{94,-24},{116,-24}},   color={159,159,223}));
  connect(vol2.port_b,turbine2. inlet)
    annotation (Line(points={{46,-15.2},{46,-52}},
                                                 color={0,127,255}));
  connect(Cavern.port, TurbValve.port_a) annotation (Line(points={{-33.2,28},{10,28}},  color={0,127,255}));
  connect(PID.u_s, timeTable.y) annotation (Line(points={{108,122},{147,122}}, color={0,0,127}));
  connect(realExpression1.y, PID.u_m) annotation (Line(points={{151,60},{96,60},{96,110}}, color={0,0,127}));
  connect(PID.y, TurbValve.opening) annotation (Line(points={{85,122},{20,122},{20,36}}, color={0,0,127}));
  connect(Cavern.heatPort, convection.port_a) annotation (Line(points={{-50,44.2},{-50,88},{-77.8,88}}, color={191,0,0}));
  connect(convection.port_b, fixedTemperature.port) annotation (Line(points={{-114.2,88},{-154,88}}, color={191,0,0}));
  connect(vol2.port_a, TurbValve.port_b) annotation (Line(points={{46,-0.8},{46,28},{30,28}},  color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
    Icon(coordinateSystem(extent={{-120,-100},{160,100}}), graphics={
                             Bitmap(extent={{-92,-72},{92,76}},   fileName="modelica://NHES/Icons/EnergyStoragePackage/CAES.jpg")}),
    Documentation(revisions="<html>
<ul>
<li><i>10 Dec 2008</i>
    by <a>Luca Savoldelli</a>:<br>
       First release.</li>
</ul>
</html>",
      info="<html>
<p>This model contains the  gas turbine, generator and network models. The network model is based on swing equation.
</html>"),
    experiment(
      StopTime=10000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Esdirk45a"));
end DischargingFinal;
