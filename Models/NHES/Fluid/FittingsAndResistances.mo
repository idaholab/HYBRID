within NHES.Fluid;
package FittingsAndResistances
  extends TRANSFORM.Icons.VariantsPackage;
  model LocalLoss
    extends TRANSFORM.Fluid.FittingsAndResistances.BaseClasses.PartialResistance;


    input Real K=1
      annotation (Dialog(group="Inputs"));

    Modelica.Units.SI.Density d;
    parameter Modelica.Units.SI.Area Ax=0.01
                                            "Cross Sectional Area";
  initial equation
  equation
    d = Medium.density(state);

    dp=K*((m_flow/Ax)^2)/(d*2);

    annotation (defaultComponentName="resistance",
          Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-30,-50},{30,-70}},
            lineColor={0,0,0},
            textString="Set R")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Loss resistance is a 2 port fluid connector that calculates a pressure drop based on a loss coefficient K. This is a typical loss coefficient in lookup tables divided by the area of the resistance squared. </p>
</html>"));
  end LocalLoss;
end FittingsAndResistances;
