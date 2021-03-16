within NHES.Systems.EnergyStorage.ThermoclineHeatStorage.Data;
model Geometry


parameter SI.Length Radius_Tank = 7.3 "Radius of the Thermocline Tank";
parameter Real Porosity = 0.25 "Porosity";
parameter Integer nodes = 200 "Number of nodes in the thermocline";
parameter SI.Length dr = 0.04 "Nominal Diameter of filler material";
parameter SI.Length Insulation_thickness = 0.051*2 "Thickness of the Insulation";
parameter SI.Length Wall_Thickness = 0.051 "Thickness of the tank";
parameter SI.Length Height_Tank = 14.6 "Height of Thermocline Tank";
parameter SI.Area XS_Fluid = Porosity*Modelica.Constants.pi*(Radius_Tank^2.0) "Cross Sectional Area of the Fluid";
parameter SI.Length dz = Height_Tank/nodes "Delta Height";



parameter SI.Temperature T_amb = 293.15 "Temperature of the Ambient Air"
  annotation (Icon(graphics={Bitmap(extent={{-132,-100},{132,100}}, fileName="modelica://NHES/../../../../Desktop/TRANSFORM/TRANSFORM-Library-master/TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}));


end Geometry;
