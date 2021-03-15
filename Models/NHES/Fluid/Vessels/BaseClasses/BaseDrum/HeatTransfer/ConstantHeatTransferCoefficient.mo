within NHES.Fluid.Vessels.BaseClasses.BaseDrum.HeatTransfer;
model ConstantHeatTransferCoefficient

  extends
    NHES.Fluid.Vessels.BaseClasses.BaseDrum.HeatTransfer.PartialHeatTransfer;

  parameter SI.CoefficientOfHeatTransfer alpha0 = 0 "Heat transfer coefficient";

equation
  alpha = alpha0;

end ConstantHeatTransferCoefficient;
