within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES.Components.Icons;
partial model CompressorTwoPhase

  annotation (Icon(graphics={
        Polygon(
          points={{24,26},{30,26},{30,76},{60,76},{60,82},{24,82},{24,26}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,76},{-30,56},{-24,56},{-24,82},{-60,82},{-60,76},{-30,
              76}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,60},{-30,-60},{30,-26},{30,26},{-30,60}},
          lineColor={128,128,128},
          lineThickness=0.5,
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid)}), Diagram(graphics));

end CompressorTwoPhase;
