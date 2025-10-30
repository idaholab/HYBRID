within NHES.Systems.EnergyStorage.PCM_HITB.Components;
model Convection_DifferentNodes "Convection"

    parameter Integer nodes_a;
    parameter Integer nodes_b;
  input SI.Area surfaceArea[nodes_a,nodes_b] "Heat transfer surface area" annotation(Dialog(group="Inputs"));
  input SI.CoefficientOfHeatTransfer alpha[nodes_a,nodes_b] "Convection heat transfer coefficient" annotation(Dialog(group="Inputs"));

      extends TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
  SI.ThermalResistance R[nodes_a, nodes_b] "Thermal resistance";
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_a[nodes_a]
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}),
        iconTransformation(extent={{-80,-10},{-60,10}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_b[nodes_b]
    annotation (Placement(transformation(extent={{60,-10},{80,10}}),
        iconTransformation(extent={{60,-10},{80,10}})));
equation
  R = 1/(alpha.*max(Modelica.Constants.eps,surfaceArea));
    port_a.Q_flow + port_b.Q_flow = 0;
  port_a.Q_flow = (port_a.T - port_b.T)/R;
  annotation (defaultComponentName="convection",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={{
              -40,-100},{40,-30}}, fileName=
              "modelica://TRANSFORM/Resources/Images/Icons/Convection.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Convection_DifferentNodes;
