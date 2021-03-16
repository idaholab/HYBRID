within NHES.HydrogenTurbine.Turbine;
model Turbine "Gas Turbine"
  extends HydrogenTurbine.Turbine.BaseClasses.TurbineBase(pstart_in=pstart_out*
        PR0, w(start=w0));

  parameter Real eta0 = 0.89
    "Isentropic efficiency at nominal operating conditions";
  parameter Real PR0 "Nominal compression ratio";
  parameter Modelica.Units.SI.MassFlowRate w0 "Nominal gas flow rate";

equation
  eta = eta0;
  PR = PR0*(w/w0);

  annotation (Documentation(info="<html>
</html>"),
         Diagram(graphics));
end Turbine;
