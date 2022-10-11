within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Examples;
model SMR_Test_TES
  "Testing to determine how much salt pumping would be necessary to be able to operate 
  the NuScale reactor by sending its power through a molten salt SHS. High fidelity model is used
  to have maximum accuracy."
  extends Modelica.Icons.Example;

  Components.SMR_High_fidelity_no_pump_test_full_TES_Salt
                               nuScale_Tave_enthalpy(
    redeclare CS_SMR_Tave_Enthalpy CS(
      T_SG_exit=579.15,
      Q_nom(displayUnit="MW") = 160000000,
      demand=1.0),
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    port_a_nominal(
      m_flow=930,
      p=200000,
      T(displayUnit="degC") = 443.15),
    port_b_nominal(p=100000, T(displayUnit="degC") = 573.15),
    redeclare package Medium_Secondary = NHES.Media.Hitec.Hitec)
    annotation (Placement(transformation(extent={{-112,-42},{-16,74}})));
  Modelica.Fluid.Sources.MassFlowSource_T
                                     boundary2(
    redeclare package Medium = NHES.Media.Hitec.Hitec,
    use_m_flow_in=true,
    T(displayUnit="K") = 170 + 273.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{76,-14},{52,10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary3(
    redeclare package Medium = NHES.Media.Hitec.Hitec,
    T=473.15,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{80,24},{56,46}})));
  TRANSFORM.Controls.LimPID PID_CR1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-8,
    yMin=-900,
    initType=Modelica.Blocks.Types.Init.NoInit,
    Ti=5,
    k_s=1,
    k_m=1)
    annotation (Placement(transformation(extent={{74,-52},{94,-32}})));
  Modelica.Blocks.Sources.RealExpression
                                   T_avg_nominal1(y=nuScale_Tave_enthalpy.core.Q_total.y)
    "576"
    annotation (Placement(transformation(extent={{52,-80},{72,-60}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{120,-44},{140,-24}})));
  Modelica.Blocks.Sources.Constant const(k=930)
    annotation (Placement(transformation(extent={{86,-20},{106,0}})));
  Modelica.Blocks.Sources.Constant const1(k=160e6)
    annotation (Placement(transformation(extent={{32,-54},{52,-34}})));
equation
  connect(boundary2.ports[1],nuScale_Tave_enthalpy. port_a) annotation (
      Line(points={{52,-2},{-4,-2},{-4,5.22857},{-14.5231,5.22857}},  color=
         {0,127,255}));
  connect(boundary3.ports[1],nuScale_Tave_enthalpy. port_b) annotation (
      Line(points={{56,35},{-4,35},{-4,32.5714},{-14.5231,32.5714}},color={
          0,127,255}));
  connect(PID_CR1.u_m, T_avg_nominal1.y)
    annotation (Line(points={{84,-54},{84,-70},{73,-70}}, color={0,0,127}));
  connect(add.u1, const.y) annotation (Line(points={{118,-28},{114,-28},{114,-10},
          {107,-10}}, color={0,0,127}));
  connect(add.u2, PID_CR1.y) annotation (Line(points={{118,-40},{108,-40},{108,-42},
          {95,-42}}, color={0,0,127}));
  connect(PID_CR1.u_s, const1.y) annotation (Line(points={{72,-42},{62,-42},{62,
          -44},{53,-44}}, color={0,0,127}));
  connect(add.y, boundary2.m_flow_in) annotation (Line(points={{141,-34},{154,-34},
          {154,7.6},{76,7.6}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(__Dymola_NumberOfIntervals=180, __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end SMR_Test_TES;
