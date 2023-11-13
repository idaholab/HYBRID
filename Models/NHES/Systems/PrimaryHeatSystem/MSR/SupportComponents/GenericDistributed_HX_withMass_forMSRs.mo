within NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents;
model GenericDistributed_HX_withMass_forMSRs
  extends TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass(
      replaceable package Medium_tube =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
            extraPropertiesNames, C_nominal=C_nominal), redeclare replaceable
      model             InternalTraceGen_tube =
        TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
        (mC_gens=mC_gens));

  extends Data.Datasets;

  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens[geometry.nV,data_PG.nC + data_ISO.nC]=cat(
      2,
      mC_gens_PG,
      mC_gens_ISO);
  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_PG[geometry.nV,data_PG.nC];
  TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_ISO[geometry.nV,data_ISO.nC];

equation

  for i in 1:geometry.nV loop
    for j in 1:data_PG.nC loop
      mC_gens_PG[i, j] = -data_PG.lambdas[j]*tube.mCs[i, j]*tube.nParallel;
    end for;
    for j in 1:data_ISO.nC loop
      mC_gens_ISO[i, j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*tube.mCs[i,
        data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC]*tube.nParallel
        for k in 1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*tube.mCs[i, j + data_PG.nC]*
        tube.nParallel;
    end for;
  end for;

  annotation (Documentation(info="<html>
<p><span style=\"font-family: Segoe UI;\">Adds fission product tracking to the GenericDistributed_HX_withMass model in TRANSFORM</span></p>
<p><span style=\"font-family: Segoe UI;\">Contact: Sarah Creasman sarah.creasman@inl.gov</span></p>
<p><span style=\"font-family: Segoe UI;\">Documentation updated September 2023</span></p>
</html>"));
end GenericDistributed_HX_withMass_forMSRs;
