within NHES.HydrogenTurbine.PowerPlant.BaseClasses;
partial model Partial_SES
  "Partial Secondary Energy Supply, i.e., a natural gas-fired gas turbine power plant"
  extends HydrogenTurbine.Icons.PartialBackground;

  Interfaces.SignalBus
    signalBus annotation (Placement(transformation(extent={{-16,104},{16,
              136}}),
        iconTransformation(extent={{-20,100},{20,140}})));

  Interfaces.ElectricalPowerPort_b
    portElec_b
    annotation (Placement(transformation(extent={{110,-10},{130,10}})));
  annotation (defaultComponentName="SES",
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-120},{120,
              120}}),
                   graphics={
                    Text(
          extent={{-104,-68},{104,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
            textString="Secondary Energy Supply")}),
                                                   Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-120,-120},{120,120}})));
end Partial_SES;
