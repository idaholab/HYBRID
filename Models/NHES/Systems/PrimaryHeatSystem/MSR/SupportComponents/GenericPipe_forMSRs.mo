within NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents;
model GenericPipe_forMSRs
  extends TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface(
      replaceable package Medium =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
            extraPropertiesNames, C_nominal=C_nominal), redeclare replaceable
      model             InternalTraceGen =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens=mC_gens));

  extends Data.Datasets;

  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens[nV,data_PG.nC + data_ISO.nC]=cat(
      2,
      mC_gens_PG,
      mC_gens_ISO);
  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_PG[nV,data_PG.nC];
  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_ISO[nV,data_ISO.nC];

equation

  for i in 1:nV loop
    for j in 1:data_PG.nC loop
      mC_gens_PG[i, j] = -data_PG.lambdas[j]*mCs[i, j]*nParallel;
    end for;
    for j in 1:data_ISO.nC loop
      mC_gens_ISO[i, j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mCs[i,
        data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC]*nParallel
        for k in 1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mCs[i, j + data_PG.nC]*
        nParallel;
    end for;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Segoe UI;\">Adds fission product tracking to the GenericPipe_MultiTransferSurface model in TRANSFORM</span></p>
<p>Contact: Sarah Creasman sarah.creasman@inl.gov</p>
<p>Documentation updated September 2023</p>
</html>"));
end GenericPipe_forMSRs;
