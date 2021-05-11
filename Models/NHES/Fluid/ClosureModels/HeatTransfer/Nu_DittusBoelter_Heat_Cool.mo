within NHES.Fluid.ClosureModels.HeatTransfer;
function Nu_DittusBoelter_Heat_Cool
  "Dittus-Boelter correlation for one-phase flow in a tube Nu = A*Re^alpha*Pr^beta"
  input SI.ReynoldsNumber Re "Reynolds number";
  input SI.PrandtlNumber Pr "Prandtl number";
  input SI.TemperatureDifference dT "Temperature difference (wall-fluid)";
  constant Real A = 0.023 "Multiplication value";
  constant Real alpha = 0.8 "Exponent to Reynolds number";

  output SI.NusseltNumber Nu "Nusselt number";
protected
  Real beta "Exponent of Prandtl #";
algorithm
  if
    (dT<0) then
    beta:=0.3;
  else
    beta:=0.4;
  end if;
  Nu := A*Re^alpha*Pr^beta;
  annotation (Documentation(info="<html>
<p>Dittus-Boelter&apos;s correlation for the computation of the heat transfer coefficient in one-phase flows. </p>
</html>"));
end Nu_DittusBoelter_Heat_Cool;
