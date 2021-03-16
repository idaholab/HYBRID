within ;
package NHES "Nuclear Hybrid Energy Systems"

  extends NHES.Icons.NHESPackage;

import      Modelica.Units.SI;
import SItf = NHES.SIunits;
import SIadd = NHES.SIunits;
import Modelica.Constants.pi;
import Modelica.Math;

































annotation (
    uses(                      ThermoPower(version="3.1"),
    Modelica(version="4.0.0"),
    TRANSFORM(version="0.5")),
    version="2",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
  Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Package <b>NHES</b> is a <b>standardized</b> and <b>free</b> package that is developed with the Modelica&reg; language, see <a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>. It provides model components in many domains that are based on standardized interface definitions.</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"modelica://TRANSFORM.UsersGuide.Contact\">Contact</a> lists the contributors of the library.</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">The <b>Examples</b> packages in the various libraries, demonstrate how to use the components of the corresponding sublibrary. </span></li>
</ul>
</html>"),
  conversion(from(version="1", script=
          "modelica://NHES/Resources/Scripts/ConvertFromNHES_1.mos")));
end NHES;
