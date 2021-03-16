within NHES.Electrolysis.HTSE.BaseClasses;
partial model Partial_IP_vessel
  "Partial Industrial Process (e.g., a high-temperature steam electrolysis plant)"
  import Modelica.Constants;

  extends Electrolysis.Icons.PartialBackground_vessel;

  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true, Dialog(group="Working fluid for the hot utility"));

  parameter Boolean allowFlowReversal = true
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

    Electrolysis.Interfaces.SignalBus_vessel signalBus annotation (
        Placement(transformation(extent={{-16,164},{16,196}}),
          iconTransformation(extent={{-20,80},{20,120}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-210,70},{-190,90}}),
        iconTransformation(extent={{-110,30},{-90,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-210,-110},{-190,-90}}),
        iconTransformation(extent={{-110,-50},{-90,-30}})));
    Electrolysis.Interfaces.ElectricalPowerPort_a portElec_a annotation (
        Placement(transformation(extent={{190,-10},{210,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));
  annotation (defaultComponentName="IP",
  Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=
             false),
       graphics={   Text(
          extent={{-90,-72},{88,-86}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Industrial Process")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-180},{200,
            180}})));
end Partial_IP_vessel;
