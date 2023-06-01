within NHES.GasTurbine.Turbine;
model Turbine_v3 "Gas Turbine"
  extends GasTurbine.Turbine.BaseClasses.TurbineBase_v3(pstart_in=pstart_out*PR0,
      w(start=w0));

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
end Turbine_v3;
