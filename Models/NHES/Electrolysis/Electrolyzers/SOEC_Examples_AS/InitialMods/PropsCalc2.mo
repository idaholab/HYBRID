within NHES.Electrolysis.Electrolyzers.SOEC_Examples_AS.InitialMods;
model PropsCalc2
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.MassFlowSource_T TubeFeed(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    use_m_flow_in=true,
    X=NHES.Electrolysis.Utilities.moleToMassFractions({0.1,0.9}, {Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM*1000,Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM
        *1000}),
    m_flow=0.908085*5,
    nPorts=1,
    T=1063.15) annotation (Placement(transformation(extent={{124,-52},{104,-32}})));
  Modelica.Fluid.Sensors.MassFlowRate TubeFlowMeasure(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{94,-52},{74,-32}})));
  Modelica.Blocks.Sources.Constant TubeFlowControl(k=13.47/3600) annotation (Placement(transformation(extent={{160,-44},{140,-24}})));
  Modelica.Fluid.Sources.Boundary_pT TubeSink(
    redeclare package Medium = Media.Electrolysis.CathodeGas,
    p(displayUnit="Pa") = 103800,
    T=1063.15,
    nPorts=1) annotation (Placement(transformation(extent={{-42,-52},{-22,-32}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort TubeTemp(redeclare package Medium =
        Media.Electrolysis.CathodeGas)
    annotation (Placement(transformation(extent={{64,-52},{44,-32}})));
  TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort TubeInEnth(redeclare package Medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas)                                                                                 annotation (Placement(transformation(extent={{32,-52},
            {12,-32}})));
equation
  connect(TubeFeed.ports[1], TubeFlowMeasure.port_a) annotation (Line(points={{104,-42},{94,-42}}, color={0,127,255}));
  connect(TubeFeed.m_flow_in, TubeFlowControl.y) annotation (Line(points={{124,-34},{139,-34}}, color={0,0,127}));
  connect(TubeFlowMeasure.port_b, TubeTemp.port_a) annotation (Line(points={{74,-42},{64,-42}}, color={0,127,255}));
  connect(TubeTemp.port_b, TubeInEnth.port_a) annotation (Line(points={{44,-42},{32,-42}}, color={0,127,255}));
  connect(TubeInEnth.port_b, TubeSink.ports[1]) annotation (Line(points={{12,-42},{-22,-42}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),
            experiment(StopTime=1e3,
            __Dymola_Algorithm="Esdirk45a"),
  Documentation(info="<html>
  <p>HX analysis to model recuperative heat exchangers for the HTSE setup. Simple HXs are causing an issue with the volume, therefore need to look into the single_phase NTU HX. Use the NTU_new model as it has some unnecessary equations removed. For now, the NTU HX is very slow. Need to figure out how to speed it up.</p>   
 </html>"));
end PropsCalc2;
