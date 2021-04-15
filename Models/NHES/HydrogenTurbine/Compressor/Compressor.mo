within NHES.HydrogenTurbine.Compressor;
model Compressor "Gas compressor"
  extends BaseClasses.CompressorBase(pstart_out=pstart_in*PR0);

  parameter Real eta0 = 0.86
    "Isentropic efficiency at nominal operating conditions";
  parameter Real PR0 "Nominal compression ratio";
  parameter Modelica.Units.SI.MassFlowRate w0 "Nominal gas flow rate";

equation
  eta = eta0;
  PR = PR0*(w/w0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end Compressor;
