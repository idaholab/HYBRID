within NHES.Fluid.Pipes.BaseClasses.HeatTransfer;
model IdealFlowHeatTransfer
  "IdealHeatTransfer: Ideal heat transfer without thermal resistance"
  extends NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer(
      alphas_start=Modelica.Constants.inf*ones(nHT));
equation
  Ts = heatPorts.T;
  alphas = Modelica.Constants.inf*ones(nHT);
  annotation(Documentation(info="<html>
Ideal heat transfer without thermal resistance.
</html>"));
end IdealFlowHeatTransfer;
