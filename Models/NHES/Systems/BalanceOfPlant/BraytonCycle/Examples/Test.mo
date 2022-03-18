within NHES.Systems.BalanceOfPlant.BraytonCycle.Examples;
model Test
  extends Modelica.Icons.Example;
  package Medium = Modelica.Media.IdealGases.SingleGases.He;
  Brayton_Cycle brayton_Cycle(redeclare replaceable Data.Data_BC_Test data(
      K_P_Release(unit="1/(m.kg)") = 10000,
      HX_Aux_K_tube(unit="1/m4"),
      HX_Aux_K_shell(unit="1/m4"),
      HX_Reheat_Tube_Vol=0.1,
      HX_Reheat_Shell_Vol=0.1,
      HX_Reheat_Buffer_Vol=0.1,
      HX_Reheat_K_tube(unit="1/m4"),
      HX_Reheat_K_shell(unit="1/m4")), redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary(
    p=5940000,
    T=1123.15,                                                                        redeclare
      package                                                                                           Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,6},{-90,26}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    p=6000000,                                                        redeclare
      package                                                                           Medium=Medium,
    T=623.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-28},{-90,-8}})));
  ElectricalGrid.InfiniteGrid.Infinite EG
    annotation (Placement(transformation(extent={{80,-44},{176,38}})));
equation
  connect(boundary1.ports[1], brayton_Cycle.port_b) annotation (Line(points={{
          -90,-18},{-46,-18},{-46,-16},{-38.8,-16}}, color={0,127,255}));
  connect(boundary.ports[1], brayton_Cycle.port_a) annotation (Line(points={{
          -90,16},{-64,16},{-64,15.2},{-38.8,15.2}}, color={0,127,255}));
  connect(brayton_Cycle.port_a1, EG.portElec_a)
    annotation (Line(points={{38.8,-1.6},{80,-3}}, color={255,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test;
