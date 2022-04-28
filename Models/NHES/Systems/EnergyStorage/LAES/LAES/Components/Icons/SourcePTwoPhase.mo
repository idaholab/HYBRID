within NHES.Systems.EnergyStorage.LAES.LAES.Components.Icons;
partial model SourcePTwoPhase

  annotation (Icon(graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={57,150,0},
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,34},{28,-26}},
          lineColor={255,255,255},
          textString="P"),
        Text(extent={{-100,-78},{100,-106}}, textString="%name")}));
end SourcePTwoPhase;
