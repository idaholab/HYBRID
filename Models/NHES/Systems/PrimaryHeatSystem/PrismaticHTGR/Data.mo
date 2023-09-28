within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR;
package Data

  model Data_Dummy

    extends BaseClasses.Record_Data;

    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="changeMe")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
</html>"));
  end Data_Dummy;

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

  model Data_1

    extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
    parameter Modelica.Units.SI.Length l_ci=0.7;
    parameter Modelica.Units.SI.Length l_co=0.7;
    parameter Modelica.Units.SI.Radius r_coolant=0.0075;
    parameter Modelica.Units.SI.Volume V_up=11;
    parameter Modelica.Units.SI.Volume V_lp=11;
    parameter Integer nAsm=30;
    parameter Integer nSCs=19;
    parameter Modelica.Units.SI.Length l_fRX=7;
    parameter Modelica.Units.SI.Radius r_fRX=0.35;
    parameter Modelica.Units.SI.Length l_tRX=7;
    parameter Modelica.Units.SI.Radius r_i_tRX=0.35;
    parameter Modelica.Units.SI.Radius r_o_tRX=0.5;
    parameter Modelica.Units.SI.Length l_CO=5.6;
    parameter Modelica.Units.SI.Radius r_i_CO=3.25;
    parameter Modelica.Units.SI.Radius r_o_CO=3.5;
    annotation (
      defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            lineColor={0,0,0},
            extent={{-100,-90},{100,-70}},
            textString="changeMe")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
</html>"));
  end Data_1;
end Data;
