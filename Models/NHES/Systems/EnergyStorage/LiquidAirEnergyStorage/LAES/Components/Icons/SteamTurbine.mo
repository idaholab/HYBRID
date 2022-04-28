within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES.Components.Icons;
partial model SteamTurbine

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-28,76},{-28,28},{-22,28},{-22,82},{-60,82},{-60,76},{-28,76}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{26,56},{32,56},{32,76},{60,76},{60,82},{26,82},{26,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-28,28},{-28,-26},{32,-60},{32,60},{-28,28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SteamTurbine;
