within NHES.Nuclear.New_Geometries;
model PackedBed "Geometry file for a packed pebble bed arrangement"
  import Modelica.Constants.pi;
  parameter Integer nV=4 "# of discrete axial volumes";
  parameter Integer nSurfaces = 2 "Allowing for later calculations as necessary, surface 1 is heat transfer from fuel and surface 2 is to the core vessel";
  parameter Real nPebble = 20000 "# of solid media pins";
  parameter Real nPebble_Reflector = 0.5*nPebble "# of pins non-fueled pins (e.g., control rod guides)";
  parameter Real LoverD = 5.5 "Length to diameter ratio of core, averaged across core height (ignoring bottom core funnel)";
  input SI.Length d_pebble "Pebble diameter, assumed to be identical for fueled and reflector" annotation(Dialog(group="Inputs"));
  parameter Real packing_factor = 0.5;
  input SI.Length d_vessel = (4*V_core/(pi*LoverD))^(1/3) annotation(Dialog(group="Inputs"));
  input SI.Volume V_core = (nPebble+nPebble_Reflector)*1/6*pi*d_pebble^3/packing_factor "Core volume" annotation(Dialog(group="Inputs"));
 // input SI.Length dimension = 4*crossArea/perimeter "Characteristic dimension (e.g., hydraulic diameter)" annotation(Dialog(group="Inputs"));
  input SI.Area crossArea_flow = pi*d_vessel*d_vessel/4*(1-packing_factor) "Cross-sectional flow areas" annotation(Dialog(group="Inputs"));
  //  input SI.Length perimeter= 4*crossArea_flow/d_pebble "Wetted perimeters" annotation(Dialog(group="Inputs"));
  // The new wetted perimeter is calculated assuming that the average spherical perimeter when looking at it from an axial view is 2R/3. If then it is assumed that A_p = PF*A_net and A_net = pi*d_vessel^2/4, then the value below comes out for wetted perimeter:
  input SI.Length perimeter = 3/4*packing_factor*d_vessel^2/d_pebble;
  input SI.Length core_height = (4*LoverD^2*V_core/pi)^(1/3) "Heated flow length" annotation(Dialog(group="Inputs"));
  input SI.Area surfaceArea[2] = {pi*d_pebble*d_pebble*nPebble,pi*d_vessel*core_height};
  input SI.Height roughness = 2.5e-5 "Average heights of surface asperities" annotation(Dialog(group="Inputs"));
  // Static head
  input SI.Angle angle=0.0 "Vertical angle from the horizontal (-pi/2 < x <= pi/2)"
    annotation (Dialog(group="Inputs Elevation"));
  input SI.Length dheight= core_height*sin(angle)
    "Height(port_b) - Height(port_a) distributed by flow segment"
    annotation (Dialog(group="Inputs Elevation"));
  input SI.Length height_a=0
    "Elevation at port_a: Reference value only. No impact on calculations."
    annotation (Dialog(group="Inputs Elevation"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PackedBed;
