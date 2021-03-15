within NHES.Electrolysis.Utilities;
package OptionsGasSpecies "Type, constants and menu choices to select the specific component (type of component in a SOEC stack)"
  constant Integer H2 = 1 "Hydrogen";
  constant Integer H2O = 2 "Steam";
  constant Integer N2 = 3 "Nitrogen";
  constant Integer O2 = 4 "Oxygen";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,112},{98,-78}},
          lineColor={238,46,47},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="e")}));
end OptionsGasSpecies;
