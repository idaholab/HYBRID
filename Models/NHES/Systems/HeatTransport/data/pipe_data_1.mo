within NHES.Systems.HeatTransport.data;
model pipe_data_1
  extends BaseClasses.Record_Data;
  import Modelica.Fluid.Types.Dynamics;
        //Geometery ---------------------------------------------------------
    parameter Modelica.Units.SI.Length L=100 "Supply Pipe Length" annotation (Dialog(group="Supply Pipe Geometery"));
    parameter Modelica.Units.SI.Diameter D=0.25
                                               "Inner Diameter Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
    parameter Modelica.Units.SI.Thickness ith=0.1  "Thickness Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
    parameter Modelica.Units.SI.Thickness pth=0.1  "Thickness Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
    parameter Integer nV(min=2) =10  "Number Of Volume Nodes In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
    parameter Modelica.Units.SI.Height dH=0 "Elevation Gain In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end pipe_data_1;
