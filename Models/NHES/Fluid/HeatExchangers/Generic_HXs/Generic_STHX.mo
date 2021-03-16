within NHES.Fluid.HeatExchangers.Generic_HXs;
model Generic_STHX
  "A simple (i.e., no inlet/outlet plenum considerations, etc.) generic shell and tube heat exchanger where concurrent/counter flow is specified mass flow direction."

  extends NHES.Fluid.HeatExchangers.Generic_HXs.Generic_HX(final
      crossArea_shell=crossAreaNew_shell, final perimeter_shell=
        perimeterNew_shell);

  parameter Boolean isCircular_shell=true
    "= true if cross sectional area is circular or a circular annulus"
    annotation(Dialog(tab="Shell Parameters",group="Geometry"));
  parameter SI.Diameter D_o_shell=if isCircular_tube then 0 else 4*crossAreaEmpty_shell/perimeterEmpty_shell  "Outer diameter of shell"
    annotation(Dialog(tab="Shell Parameters",group="Geometry",enable=isCircular_shell));
  parameter SI.Diameter D_i_shell=0  "Inner diameter of shell (if itself is an annulus)"
    annotation(Dialog(tab="Shell Parameters",group="Geometry",enable=isCircular_shell));
  parameter SI.Area crossAreaEmpty_shell = 0.25*pi*(D_o_shell^2-D_i_shell^2) "Cross-sectional area of an empty shell (i.e., no tubes)"
    annotation(Dialog(tab="Shell Parameters",group="Geometry",enable=not isCircular_shell));
  parameter SI.Length perimeterEmpty_shell = pi*(D_o_shell+D_i_shell) "Wetted perimeter of an empty shell (i.e., no tubes)"
    annotation(Dialog(tab="Shell Parameters",group="Geometry",enable=not isCircular_shell));

  // Translate input parameters to best estimate of dimensions for closure models (i.e., flow and heat transfer models)
  final parameter SIadd.nonDim lengthRatio = length_tube/length_shell "Ratio of tube length to shell length";
  final parameter SI.Area crossAreaModded_tubewall = 0.25*pi*((diameter_tube+2*th_tube)^2-diameter_tube^2)*nTubes*lengthRatio "Estimate of cross sectional area of tubes (exact if tubes are circular) with an unequal shell-tube length factor correction";
  final parameter SI.Length perimeterModded_tube = pi*(diameter_tube+2*th_tube)*nTubes*lengthRatio "Wetted perimeter of tubes in shell with an unequal shell-tube length factor correction";
  final parameter SI.Area crossAreaNew_shell = crossAreaEmpty_shell-crossArea_tube*nTubes-crossAreaModded_tubewall "Cross-sectional flow area of shell";
  final parameter SI.Length perimeterNew_shell = perimeterEmpty_shell + perimeterModded_tube "Wetted perimeter of shell";

equation
  assert(crossAreaNew_shell > 0, "Cross flow area of tubes is greater than the area of the empty shell");

  annotation (defaultComponentName="STHX",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,2},{100,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={-28,0},
          rotation=-90),
        Rectangle(
          extent={{-100,16},{100,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,63,125},
          origin={46,0},
          rotation=-90),
        Rectangle(
          extent={{-100,26},{100,-26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255},
          origin={0,0},
          rotation=-90),
        Rectangle(
          extent={{-100,16},{100,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,63,125},
          origin={-46,0},
          rotation=-90),
        Rectangle(
          extent={{-100,2},{100,-2}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Forward,
          origin={28,0},
          rotation=-90),
        Polygon(
          points={{20,15},{-20,0},{20,-15},{20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,63,255},
          fillPattern=FillPattern.Solid,
          origin={0,51},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,63,255},
          smooth=Smooth.None,
          origin={-1,-13},
          rotation=-90),
        Polygon(
          points={{-20,15},{20,0},{-20,-15},{-20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={46,-43},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={45,23},
          rotation=-90),
        Polygon(
          points={{-20,15},{20,0},{-20,-15},{-20,15}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-46,-43},
          rotation=-90),
        Line(
          points={{45,0},{-45,0}},
          color={0,128,255},
          smooth=Smooth.None,
          origin={-47,23},
          rotation=-90)}),
    Documentation(info="<html>
<p>The shell and tube heat exchanger accounts for geometry variations via a ratio of the length of the tube and shell and factors this into heat transfer and geometry constraints.</p>
</html>"));
end Generic_STHX;
