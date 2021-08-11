within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution;
model LossResistance
  extends
    TRANSFORM.Fluid.FittingsAndResistances.BaseClasses.PartialResistance;
  input Real K( unit="1/(m4)") "This value is equal to K_nominal/(2*A^2) for flow area A and lookup value K_nominal in standard engineering tables."
    annotation (Dialog(group="Inputs"));

  Modelica.Units.SI.Density d;
  parameter Modelica.Units.SI.Pressure dp_init=10000;

initial equation
//  dp_init = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.1*0.1)*K/state.d;
equation
  d = Medium.density(state);

 port_a.p-port_b.p = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.1*0.1)*K/d;

  annotation (defaultComponentName="resistance",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-30,-50},{30,-70}},
          lineColor={0,0,0},
          textString="Set R")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Loss resistance is a 2 port fluid connector that calculates a pressure drop based on a loss coefficient K. This is a typical loss coefficient in lookup tables divided by the area of the resistance squared. </p>
</html>"));
end LossResistance;
