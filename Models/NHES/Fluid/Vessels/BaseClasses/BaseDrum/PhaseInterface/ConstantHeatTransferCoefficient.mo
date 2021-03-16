within NHES.Fluid.Vessels.BaseClasses.BaseDrum.PhaseInterface;
model ConstantHeatTransferCoefficient

  extends
    NHES.Fluid.Vessels.BaseClasses.BaseDrum.PhaseInterface.PartialPhase_alpha;

  parameter SI.CoefficientOfHeatTransfer alpha0 = 0 "Heat transfer coefficient";

equation
  alpha = alpha0;

end ConstantHeatTransferCoefficient;
