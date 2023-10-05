within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Data;
model Generic_PHTGR
  import Modelica.Constants.pi;

  parameter Integer nV=4 "# of discrete axial volumes";
  parameter Integer nPins = 54 "# of fuel media pins";
  parameter Integer nChannels[3]= {7,6,6} "# of coolant channels (center, edge, corner)";
  parameter Integer nAsm = 30 "# Number of Assembly Blocks";
  parameter Modelica.Units.SI.Length R_Coolant=0.0075
    "Characteristic dimension (e.g., hydraulic diameter)";
  parameter Modelica.Units.SI.Length H=4.2 "Core Height";
  parameter Modelica.Units.SI.Length pitch= 0.035
  "Distance Between Two Adjacent Fuel Pins";
  parameter Modelica.Units.SI.Length r_graphite=sqrt(0.82699*pitch^2 - 2*
      r_fuel^2) "Outer Graphite Ring Radius";
  parameter Modelica.Units.SI.Length r_fuel=0.0115
    "Specify outer radius or dthetas in r-dimension";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generic_PHTGR;
