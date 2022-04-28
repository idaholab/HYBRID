within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES.Components.Icons;
partial model Tank

  annotation (Icon(graphics={
        Rectangle(
          extent={{-60,58},{60,-82}},
          lineColor={0,0,0},
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,60},{54,12}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-54,12},{54,-72}}, lineColor={57,150,0},
          fillColor={57,150,0},
          fillPattern=FillPattern.Solid)}));
end Tank;
