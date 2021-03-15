within NHES.Fluid.Pipes.BaseClasses.HeatTransfer;
model DittusBoelter "Dittus-Boelter: Single-phase"

  extends NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialPipeFlowHeatTransfer;

equation
   for i in 1:nHT loop
    alphas[i] = ClosureModels.HeatTransfer.alpha_DittusBoelter(
      D=dimensions[i],
      lambda=lambdas[i],
      Re=Res[i],
      Pr=Prs[i]);

    Nus[i] = alphas[i]*dimensions[i]/lambdas[i];
  end for;

end DittusBoelter;
