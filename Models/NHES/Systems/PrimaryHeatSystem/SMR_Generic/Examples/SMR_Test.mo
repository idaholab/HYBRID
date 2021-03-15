within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Examples;
model SMR_Test
  extends Modelica.Icons.Example;

  Components.SMR_Tave_enthalpy nuScale_Tave_enthalpy(
    redeclare CS_SMR_Tave_Enthalpy CS(
      T_SG_exit=579.15,
      Q_nom(displayUnit="MW") = 160000000,
      demand=1.0),
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-74,-52},{22,64}})));
  Modelica.Fluid.Sources.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T(displayUnit="K") = 421.15,
    nPorts=1,
    p=3447380)
    annotation (Placement(transformation(extent={{76,-14},{52,10}})));
  Modelica.Fluid.Sources.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    h=nuScale_Tave_enthalpy.port_b_nominal.h,
    nPorts=1,
    p=nuScale_Tave_enthalpy.port_b_nominal.p)
    annotation (Placement(transformation(extent={{74,18},{50,40}})));
equation
  connect(boundary2.ports[1],nuScale_Tave_enthalpy. port_a) annotation (
      Line(points={{52,-2},{36,-2},{36,-1.13846},{23.7455,-1.13846}}, color=
         {0,127,255}));
  connect(boundary3.ports[1],nuScale_Tave_enthalpy. port_b) annotation (
      Line(points={{50,29},{36,29},{36,28.3077},{23.7455,28.3077}}, color={
          0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=1800,
      __Dymola_NumberOfIntervals=180,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})));
end SMR_Test;
