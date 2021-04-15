within NHES.Utilities.FMI_Templates.Adaptors.ElectricalAdaptors;
model GeneralFrequencyToPowerFlowAdaptor
  "Signal adaptor for a HeatTransfer port with heat flow as output and temperature and derivative of temperature as input (especially useful for FMUs)"
  extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
    final Name_p="freq",
    final Name_pder="dfreq",
    final Name_pder2="d2freq",
    final Name_f="Power",
    final Name_fder="der(Power)",
    final Name_fder2="der2(Power)",
    final use_pder2=false,
    final use_fder=false,
    final use_fder2=false,
    p(unit="Hz"),
    final pder(unit="Hz/s"),
    final pder2(unit="Hz/s2"),
    final f(unit="W"),
    final fder(unit="W/s"),
    final fder2(unit="W/s2"));
  Electrical.Interfaces.ElectricalPowerPort_a portElec_a
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
equation
  y = portElec_a.W "output = flow = power flow";
  u = portElec_a.f "input = potential = frequency";
  annotation (defaultComponentName="temperatureToHeatFlowAdaptor",
    Documentation(info="<html>
<p>
Adaptor between a heatport connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a HeatTransfer model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Examples.GenerationOfFMUs\">HeatTransfer.Examples.GenerationOfFMUs</a>.
This adaptor has temperature and derivative of temperature as input signals and heatflow as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(derT=der(T)).
</p>
</html>"),
    Icon(graphics={
            Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={191,0,0},
          radius=10,
          lineThickness=0.5)}));
end GeneralFrequencyToPowerFlowAdaptor;
