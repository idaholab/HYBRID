within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle.Components;
model Compressor_v2 "Gas compressor"
  extends BaseComponents.CompressorBase_v2(pstart_out=pstart_in*PR0);

  parameter Real eta0 = 0.86
    "Isentropic efficiency at nominal operating conditions";
  parameter Real PR0 "Nominal compression ratio";
  parameter Modelica.Units.SI.MassFlowRate w0 "Nominal gas flow rate";

equation
  eta = eta0;
  PR = PR0*(w/w0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),
              Documentation(info="<html>
  <p>Compressor model that references a modified base class. The modification in the base class is that of the dummy pressure -> 1e5 changed to 10e5 </p>
</html>"),
         Diagram(graphics));
end Compressor_v2;
