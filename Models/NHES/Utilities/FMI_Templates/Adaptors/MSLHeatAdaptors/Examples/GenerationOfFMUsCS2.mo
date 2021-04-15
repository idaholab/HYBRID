within NHES.Utilities.FMI_Templates.Adaptors.MSLHeatAdaptors.Examples;
model GenerationOfFMUsCS2
  "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine1(f=2, amplitude=1000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Utilities.FMIs.MSLHeatAdaptors_Utilities_CombinedCapacityCSdymola_fmu
    mSLHeatAdaptors_Utilities_CombinedCapacityCSdymola_fmu
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
equation
  connect(sine1.y,
    mSLHeatAdaptors_Utilities_CombinedCapacityCSdymola_fmu.Q_flowDrive)
    annotation (Line(points={{-79,50},{-0.4,50}}, color={0,0,127}));
  annotation (experiment(
      StopTime=1,
      Interval=0.001,
      __Dymola_Algorithm="Dassl"),                    Documentation(info="<html>
<p><b>Note</b>: Copy of the Modelica Standard Library Example File. (Just bringing it down to the NHES system to collect together FMU creation.)</p>
<p>This example demonstrates how to generate an input/output block (e.g. in form of an FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various HeatTransfer components. The goal is to export such an input/output block from Modelica and import it in another modeling environment. The essential issue is that before exporting it must be known in which way the component is utilized in the target environment. Depending on the target usage, different flange variables need to be in the interface with either input or output causality. Note, this example model can be used to test the FMU export/import of a Modelica tool. Just export the components marked in the icons as &quot;toFMU&quot; as FMUs and import them back. The models should then still work and give the same results as a pure Modelica model. </p>
<p><b>Connecting two masses</b></p><p>The upper part (DirectCapacity, InverseCapacity) demonstrates how to export two heat capacitors and connect them together in a target system. This requires that one of the capacitors (here: DirectCapacity) is defined to have states and the temperature and derivative of temperature are provided in the interface. The other capacitor (here: InverseCapacity) requires heat flow according to the provided input temperature and derivative of temperature. </p>
<p><b>Connecting a conduction element that needs only temperature</b></p><p>The lower part (Conductor) demonstrates how to export a conduction element that needs only temperatures for its conduction law and connect this conduction law in a target system between two capacitors. </p>
</html>"),
    __Dymola_experimentSetupOutput(events=false));
end GenerationOfFMUsCS2;
