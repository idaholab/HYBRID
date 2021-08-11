within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
model TemperatureTwoPort_Superheat
  "Ideal two port temperature sensor measuring superheat"
  extends TRANSFORM.Fluid.Sensors.BaseClasses.PartialTwoPortSensor;
  extends TRANSFORM.Fluid.Sensors.BaseClasses.PartialMultiSensor_1values(final
      var=T, redeclare replaceable function iconUnit =
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC
      constrainedby
      TRANSFORM.Units.Conversions.Functions.Temperature_K.BaseClasses.to);
  Modelica.Units.SI.Temperature Tsat;
  Modelica.Units.SI.Temperature T;
  replaceable package HTF =Modelica.Media.Water.StandardWater
  constrainedby Modelica.Media.Interfaces.PartialMedium annotation(allMatchingChoices=true);
  /*"This is introduced because for some reason when I use Medium.saturationTemperature(),
  it says it's not in the Medium package. So. I've gone around it. It worked previously as 
  Medium.saturationTemperature(). Any fix would be greatly appreciated. -Daniel" */
  Modelica.Blocks.Interfaces.RealOutput dT(
    final quantity="ThermodynamicTemperature",
    min=0,
    displayUnit="degC") "Temperature of the passing fluid" annotation (
      Placement(transformation(
        origin={0,110},
        extent={{10,-10},{-10,10}},
        rotation=270), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,36})));
protected
  Medium.Temperature T_a_inflow "Temperature of inflowing fluid at port_a";
  Medium.Temperature T_b_inflow
    "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow";
equation

  Tsat = HTF.saturationTemperature(port_a.p);
  //dT, which is the real output connector. By applying the spliceTanh function, this model is designed to be connected to a shutoff valve.
  dT = TRANSFORM.Math.spliceTanh(1,0,(T-Tsat-5),4.0);
  if allowFlowReversal then
    T_a_inflow = Medium.temperature(Medium.setState_phX(
      port_b.p,
      port_b.h_outflow,
      port_b.Xi_outflow));
    T_b_inflow = Medium.temperature(Medium.setState_phX(
      port_a.p,
      port_a.h_outflow,
      port_a.Xi_outflow));
    T = Modelica.Fluid.Utilities.regStep(
      port_a.m_flow,
      T_a_inflow,
      T_b_inflow,
      m_flow_small);
  else
    T = Medium.temperature(Medium.setState_phX(
      port_b.p,
      port_b.h_outflow,
      port_b.Xi_outflow));
    T_a_inflow = T;
    T_b_inflow = T;
  end if;
  annotation (
    defaultComponentName="sensor_T",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{78,56},{-18,27}},
          lineColor={0,0,0},
          textString="T"),
        Line(points={{50,0},{100,0}}, color={0,128,255}),
        Line(points={{-100,0},{-50,0}}, color={0,128,255})}),
    Documentation(info="<html>
<p>The two port temperature sensor from TRANSFORM is the base model. The only difference is that instead of measuring the actual temperature, this model measures the amount of superheat of the fluid. This is then, in this model, transferred into an open or close signal. Its design is to then be connected into a valve and to close said valve if the temperature of the fluid becomes saturated or subcooled. </p>
</html>"));
end TemperatureTwoPort_Superheat;
