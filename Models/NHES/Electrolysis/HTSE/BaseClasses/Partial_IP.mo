within NHES.Electrolysis.HTSE.BaseClasses;
partial model Partial_IP
  "Partial Industrial Process (e.g., a high-temperature steam electrolysis plant)"
  import Modelica.Constants;

  extends Electrolysis.Icons.PartialBackground;

  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true, Dialog(group="Working fluid for the hot utility"));

  parameter Boolean allowFlowReversal = true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium =Medium,
    m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,50},{-150,70}}),
        iconTransformation(extent={{-170,50},{-150,70}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium =Medium,
    m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-170,-70},{-150,-50}}),
        iconTransformation(extent={{-170,-70},{-150,-50}})));

  Signals_IP
    signalBus annotation (Placement(transformation(extent={{-16,144},{16,
              176}}),
        iconTransformation(extent={{-20,140},{20,180}})));

  Interfaces.ElectricalPowerPort_a portElec_a annotation (Placement(
        transformation(extent={{150,-10},{170,10}}), iconTransformation(extent=
            {{150,-10},{170,10}})));
  annotation (defaultComponentName="IP",
  Icon(coordinateSystem(extent={{-160,-160},{160,160}}, preserveAspectRatio=
             false),
       graphics={   Text(
          extent={{-112,-98},{114,-116}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Industrial Process")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -160},{160,160}})));
end Partial_IP;
