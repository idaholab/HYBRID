within NHES.GasTurbine.Turbine;
model Turbine "Gas Turbine"
  extends GasTurbine.Turbine.BaseClasses.TurbineBase(pstart_in=pstart_out*PR0,
      w(start=w0));

  parameter Real eta0 = 0.89
    "Isentropic efficiency at nominal operating conditions";
  parameter Real PR0 "Nominal compression ratio";
  parameter Modelica.Units.SI.MassFlowRate w0 "Nominal gas flow rate";

equation
  eta = eta0;
  PR = PR0*(w/w0);

  annotation (Documentation(info="<html>
<p>This turbine model does not support two-phase media such as CoolProp from an ExternalMedia package. Use single-phase fluids such as those built from the NASA Glenn coefficients from MSL. </p>
</html>"),
         Diagram(graphics));
end Turbine;
