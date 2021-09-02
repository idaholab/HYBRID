within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
connector Torque "Connector of torque that communicates rotational speed"
  Modelica.Units.SI.AngularVelocity w;
  flow Modelica.Units.SI.Torque tau;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={181,181,181},
          fillPattern=FillPattern.Solid), Text(
          extent={{-40,24},{38,-22}},
          lineColor={0,0,0},
          fillColor={181,181,181},
          fillPattern=FillPattern.None,
          textString="Tau")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Torque;
