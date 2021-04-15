within NHES.HydrogenTurbine.Utilities;
package OptionsInit "Type, constants and menu choices to select the initialization options"
  constant Integer noInit = 0 "No initial equations";
  constant Integer userSpecified = 1 "User-specified initialisation";
  constant Integer steadyState = 2 "Steady-state initialisation";
  constant Integer steadyStateNoP = 3
  "Steady-state initialisation except pressures";
  constant Integer steadyStateNoT = 4
  "Steady-state initialisation except temperatures";
  constant Integer steadyStateNoPT = 5
  "Steady-state initialisation except pressures and temperatures";

  annotation(preferedView = "text", Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-84,116},{84,-84}},
          lineColor={255,0,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="e")}));
end OptionsInit;
