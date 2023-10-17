within NHES.Systems.PrimaryHeatSystem.MSR;
package SupportComponents
  model GenericPipe_forMSRs
    extends TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface(
        replaceable package Medium =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
              extraPropertiesNames, C_nominal=C_nominal), redeclare
        replaceable model InternalTraceGen =
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

  model MixingVolume_forMSRs
    extends TRANSFORM.Fluid.Volumes.MixingVolume(replaceable package Medium =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
              extraPropertiesNames, C_nominal=C_nominal), mC_gen=cat(
          1,
          mC_gen_PG,
          mC_gen_ISO));

    extends Data.Datasets;

    TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_PG[data_PG.nC];
    TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_ISO[data_ISO.nC];

  equation

    for j in 1:data_PG.nC loop
      mC_gen_PG[j] = -data_PG.lambdas[j]*mC[j];
    end for;
    for j in 1:data_ISO.nC loop
      mC_gen_ISO[j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mC[
        data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC] for k in
            1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mC[j + data_PG.nC];
    end for;

    annotation (Documentation(info="<html>
<p><span style=\"font-family: Segoe UI;\">Adds fission product tracking to the MixingVolume model in TRANSFORM</span></p>
<p><span style=\"font-family: Segoe UI;\">Contact: Sarah Creasman sarah.creasman@inl.gov</span></p>
<p><span style=\"font-family: Segoe UI;\">Documentation updated September 2023</span></p>
</html>"));
  end MixingVolume_forMSRs;

  model GenericDistributed_HX_withMass_forMSRs
    extends TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass(
        replaceable package Medium_tube =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
              extraPropertiesNames, C_nominal=C_nominal), redeclare
        replaceable model InternalTraceGen_tube =
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

  model ExpansionTank
    extends TRANSFORM.Fluid.Volumes.ExpansionTank(
        replaceable package Medium =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
            extraPropertiesNames=extraPropertiesNames, C_nominal=
              C_nominal),
      mC_gen=cat(
          1,
          mC_gen_PG,
          mC_gen_ISO)+mC_gen_add);

        extends Data.Datasets;

    TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_PG[data_PG.nC];
    TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_ISO[data_ISO.nC];

    input SIadd.ExtraPropertyFlowRate mC_gen_add[Medium.nC]=fill(0,Medium.nC) "Additional internal trace mass generation"
      annotation (Dialog(tab="Advanced",group="Trace Mass Transfer"));

  equation

    for j in 1:data_PG.nC loop
      mC_gen_PG[j] = -data_PG.lambdas[j]*mC[j];
    end for;
    for j in 1:data_ISO.nC loop
      mC_gen_ISO[j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mC[
        data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC] for k in
            1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mC[j + data_PG.nC];
    end for;

    annotation (Documentation(info="<html>
<p><span style=\"font-family: Segoe UI;\">Adds fission product tracking to the ExpansionTank model in TRANSFORM</span></p>
<p><span style=\"font-family: Segoe UI;\">Contact: Sarah Creasman sarah.creasman@inl.gov</span></p>
<p><span style=\"font-family: Segoe UI;\">Documentation updated September 2023</span></p>
</html>"));
  end ExpansionTank;

  model DRACS
    extends TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
    replaceable package Medium_DRACS =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT constrainedby
      Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
    input Modelica.Units.SI.Area surfaceAreas_thimble[2]=fill(1, 2)
      "Heat transfer surface area for gas and salt"
      annotation (Dialog(group="Inputs"));
    input Modelica.Units.SI.CoefficientOfHeatTransfer alphas_drainTank[2]=fill(
        2000, 2)
      "Convection heat transfer coefficient at thimble-drain tank interface for gas and salt"
      annotation (Dialog(group="Inputs"));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_outer_drainTank(
      exposeState_b=true,
      redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
      length=data_OFFGAS.length_thimbles,
      r_inner=0.5*data_OFFGAS.D_thimbles - data_OFFGAS.th_thimbles,
      r_outer=0.5*data_OFFGAS.D_thimbles,
      T_start=data_OFFGAS.T_drainTank,
      exposeState_a=true,
      showName=false)
      annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation radiation_drainTank(
      surfaceArea=0.5*(thimble_inner_drainTank.surfaceArea_outer +
          thimble_outer_drainTank.surfaceArea_inner),
      epsilon=0.5,
      showName=false)
      annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_inner_drainTank(
      exposeState_a=true,
      redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
      length=data_OFFGAS.length_thimbles,
      r_inner=0.5*data_OFFGAS.D_inner_thimbles - data_OFFGAS.th_inner_thimbles,
      r_outer=0.5*data_OFFGAS.D_inner_thimbles,
      T_start=data_OFFGAS.T_hot_dracs,
      exposeState_b=true,
      showName=false)
      annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
    NHES.Systems.PrimaryHeatSystem.MSR.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{180,80},{200,100}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_inner_drainTank(nParallel=
         data_OFFGAS.nThimbles, showName=false)
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_outer_drainTank[2](each
        nParallel=data_OFFGAS.nThimbles, each showName=false)
      annotation (Placement(transformation(extent={{148,-70},{128,-50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface thimbles_drainTank_fluid(
      nParallel=data_OFFGAS.nThimbles,
      redeclare package Medium = Medium_DRACS,
      m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data_OFFGAS.D_inner_thimbles - 2*data_OFFGAS.th_inner_thimbles,
            length=data_OFFGAS.length_thimbles),
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showColors=true,
      val_min=data_OFFGAS.T_cold_dracs,
      val_max=data_OFFGAS.T_hot_dracs,
      T_a_start=data_OFFGAS.T_cold_dracs,
      T_b_start=data_OFFGAS.T_hot_dracs,
      showName=false) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-80,-40})));

    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_outer_waterTank(
      exposeState_b=true,
      redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
      length=data_OFFGAS.length_thimbles,
      r_inner=0.5*data_OFFGAS.D_thimbles - data_OFFGAS.th_thimbles,
      r_outer=0.5*data_OFFGAS.D_thimbles,
      exposeState_a=true,
      T_start=data_OFFGAS.T_inlet_waterTank,
      showName=false)
      annotation (Placement(transformation(extent={{70,30},{50,50}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation radiation_waterTank(
      surfaceArea=0.5*(thimble_inner_drainTank.surfaceArea_outer +
          thimble_outer_drainTank.surfaceArea_inner),
      epsilon=0.5,
      showName=false)
      annotation (Placement(transformation(extent={{40,30},{20,50}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_inner_waterTank(
      exposeState_a=true,
      redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
      length=data_OFFGAS.length_thimbles,
      r_inner=0.5*data_OFFGAS.D_inner_thimbles - data_OFFGAS.th_inner_thimbles,
      r_outer=0.5*data_OFFGAS.D_inner_thimbles,
      exposeState_b=true,
      T_start=data_OFFGAS.T_cold_dracs,
      showName=false)
      annotation (Placement(transformation(extent={{10,30},{-10,50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_inner_waterTank(nParallel=
         data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks, showName=false)
      annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_outer_waterTank(nParallel=
         data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks, showName=false)
      annotation (Placement(transformation(extent={{130,30},{110,50}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface riser_DRACS(
      redeclare package Medium = Medium_DRACS,
      m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
      T_a_start=data_OFFGAS.T_hot_dracs,
      showColors=true,
      val_min=data_OFFGAS.T_cold_dracs,
      val_max=data_OFFGAS.T_hot_dracs,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_OFFGAS.D_pipeToFrom_DRACS,
          length=data_OFFGAS.length_pipeToFrom_DRACS,
          angle=1.5707963267949),
      showName=false) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-50,-10})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface thimbles_waterTank_fluid(
      redeclare package Medium = Medium_DRACS,
      m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      nParallel=data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks,
      showColors=true,
      val_min=data_OFFGAS.T_cold_dracs,
      val_max=data_OFFGAS.T_hot_dracs,
      T_a_start=data_OFFGAS.T_hot_dracs,
      T_b_start=data_OFFGAS.T_cold_dracs,
      showName=false,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=data_OFFGAS.D_inner_thimbles - 2*data_OFFGAS.th_inner_thimbles,
            length=data_OFFGAS.length_thimbles_waterTank)) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-60,30})));

    TRANSFORM.Fluid.Volumes.ExpansionTank waterTank(
      use_HeatPort=true,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      A=data_OFFGAS.crossArea_waterTank*data_OFFGAS.nWaterTanks,
      level_start=data_OFFGAS.level_nominal_waterTank,
      h_start=waterTank.Medium.specificEnthalpy_pT(waterTank.p_start, 0.5*(
          data_OFFGAS.T_inlet_waterTank + data_OFFGAS.T_outlet_waterTank)),
      showName=false)
      annotation (Placement(transformation(extent={{130,58},{150,78}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_waterTank(
      surfaceArea=thimble_outer_waterTank.surfaceArea_outer,
      alpha=2000,
      showName=false)
      annotation (Placement(transformation(extent={{80,30},{100,50}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T source_waterTank(
      nPorts=1,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      T=data_OFFGAS.T_inlet_waterTank,
      m_flow=10*data_OFFGAS.m_flow_inlet_waterTank*data_OFFGAS.nWaterTanks,
      use_m_flow_in=true,
      showName=false)
      annotation (Placement(transformation(extent={{80,52},{100,72}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT sink_waterTank(
      T=data_OFFGAS.T_outlet_waterTank,
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      nPorts=1,
      p=100000,
      showName=false)
      annotation (Placement(transformation(extent={{200,52},{180,72}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow(redeclare
        package Medium = Modelica.Media.Water.StandardWater, use_input=true)
      annotation (Placement(transformation(extent={{152,52},{172,72}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=waterTank.port_a.m_flow)
      annotation (Placement(transformation(extent={{140,78},{160,98}})));
    TRANSFORM.Controls.LimPID PID_waterTank(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yb=data_OFFGAS.m_flow_inlet_waterTank*data_OFFGAS.nWaterTanks,
      yMin=0) annotation (Placement(transformation(extent={{48,76},{68,96}})));
    Modelica.Blocks.Sources.RealExpression waterTank_m_flow_set(y=waterTank.state_liquid.T)
      annotation (Placement(transformation(extent={{20,76},{40,96}})));
    Modelica.Blocks.Sources.RealExpression waterTank_m_flow_meas(y=data_OFFGAS.T_outlet_waterTank)
      annotation (Placement(transformation(extent={{20,54},{40,74}})));
    TRANSFORM.Fluid.Volumes.ExpansionTank expansionTank_DRACS(
      redeclare package Medium = Medium_DRACS,
      h_start=data_OFFGAS.h_cold_dracs,
      A=2,
      level_start=1,
      showName=false)
      annotation (Placement(transformation(extent={{-76,26},{-96,46}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface downcomer_DRACS(
      redeclare package Medium = Medium_DRACS,
      m_flow_a_start=data_OFFGAS.m_flow_cold_dracs,
      showColors=true,
      val_min=data_OFFGAS.T_cold_dracs,
      val_max=data_OFFGAS.T_hot_dracs,
      T_a_start=data_OFFGAS.T_cold_dracs,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_OFFGAS.D_pipeToFrom_DRACS,
          length=data_OFFGAS.length_pipeToFrom_DRACS,
          angle=1.5707963267949),
      showName=false) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-100,-10})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Medium_DRACS,
      showName=false,
      R=-2000) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-100,16})));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_thimbleWall[2]
      annotation (Placement(transformation(extent={{162,-70},{182,-50}}),
          iconTransformation(extent={{90,-70},{110,-50}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_outer_drainTank[2](
      surfaceArea=surfaceAreas_thimble,
      alpha=alphas_drainTank,
      each showName=false) "thimble_outer_drainTank.surfaceArea_outer"
      annotation (Placement(transformation(extent={{104,-70},{124,-50}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector(n=2,
        showName=false)
      annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  equation
    connect(radiation_drainTank.port_a, thimble_outer_drainTank.port_b)
      annotation (Line(points={{37,-60},{50,-60}}, color={191,0,0}));
    connect(thimble_inner_drainTank.port_a, radiation_drainTank.port_b)
      annotation (Line(points={{10,-60},{23,-60}}, color={191,0,0}));
    connect(nP_inner_drainTank.port_n, thimble_inner_drainTank.port_b)
      annotation (Line(points={{-20,-60},{-10,-60}}, color={191,0,0}));
    connect(radiation_waterTank.port_a, thimble_outer_waterTank.port_b)
      annotation (Line(points={{37,40},{50,40}}, color={191,0,0}));
    connect(thimble_inner_waterTank.port_a, radiation_waterTank.port_b)
      annotation (Line(points={{10,40},{23,40}}, color={191,0,0}));
    connect(nP_inner_waterTank.port_n, thimble_inner_waterTank.port_b)
      annotation (Line(points={{-20,40},{-10,40}}, color={191,0,0}));
    connect(riser_DRACS.port_a, thimbles_drainTank_fluid.port_b) annotation (Line(
          points={{-50,-20},{-50,-40},{-70,-40}}, color={0,127,255}));
    connect(riser_DRACS.port_b, thimbles_waterTank_fluid.port_a)
      annotation (Line(points={{-50,0},{-50,30}}, color={0,127,255}));
    connect(thimble_outer_waterTank.port_a, convection_waterTank.port_a)
      annotation (Line(points={{70,40},{83,40}}, color={191,0,0}));
    connect(convection_waterTank.port_b, nP_outer_waterTank.port_n)
      annotation (Line(points={{97,40},{110,40}}, color={191,0,0}));
    connect(nP_outer_waterTank.port_1, waterTank.heatPort)
      annotation (Line(points={{130,40},{140,40},{140,59.6}}, color={191,0,0}));
    connect(source_waterTank.ports[1], waterTank.port_a)
      annotation (Line(points={{100,62},{133,62}}, color={0,127,255}));
    connect(waterTank.port_b, pump_SimpleMassFlow.port_a)
      annotation (Line(points={{147,62},{152,62}}, color={0,127,255}));
    connect(pump_SimpleMassFlow.port_b, sink_waterTank.ports[1])
      annotation (Line(points={{172,62},{180,62}}, color={0,127,255}));
    connect(realExpression.y, pump_SimpleMassFlow.in_m_flow)
      annotation (Line(points={{161,88},{162,88},{162,69.3}}, color={0,0,127}));
    connect(waterTank_m_flow_meas.y, PID_waterTank.u_m)
      annotation (Line(points={{41,64},{58,64},{58,74}}, color={0,0,127}));
    connect(waterTank_m_flow_set.y, PID_waterTank.u_s)
      annotation (Line(points={{41,86},{46,86}}, color={0,0,127}));
    connect(PID_waterTank.y, source_waterTank.m_flow_in) annotation (Line(points={
            {69,86},{74,86},{74,70},{80,70}}, color={0,0,127}));
    connect(thimbles_waterTank_fluid.heatPorts[1, 1], nP_inner_waterTank.port_1)
      annotation (Line(points={{-60,35},{-60,40},{-40,40}}, color={191,0,0}));
    connect(expansionTank_DRACS.port_a, thimbles_waterTank_fluid.port_b)
      annotation (Line(points={{-79,30},{-70,30}}, color={0,127,255}));
    connect(downcomer_DRACS.port_b, thimbles_drainTank_fluid.port_a) annotation (
        Line(points={{-100,-20},{-100,-40},{-90,-40}}, color={0,127,255}));
    connect(resistance.port_b, downcomer_DRACS.port_a)
      annotation (Line(points={{-100,9},{-100,0}}, color={0,127,255}));
    connect(resistance.port_a, expansionTank_DRACS.port_b) annotation (Line(
          points={{-100,23},{-100,30},{-93,30}}, color={0,127,255}));
    connect(thimbles_drainTank_fluid.heatPorts[1, 1], nP_inner_drainTank.port_1)
      annotation (Line(points={{-80,-45},{-80,-60},{-40,-60}}, color={191,0,0}));
    connect(thimble_outer_drainTank.port_a, collector.port_b)
      annotation (Line(points={{70,-60},{80,-60}}, color={191,0,0}));
    connect(collector.port_a, convection_outer_drainTank.port_a)
      annotation (Line(points={{100,-60},{107,-60}}, color={191,0,0}));
    connect(convection_outer_drainTank.port_b, nP_outer_drainTank.port_n)
      annotation (Line(points={{121,-60},{124,-60},{124,-60},{128,-60}}, color={191,
            0,0}));
    connect(nP_outer_drainTank.port_1, port_thimbleWall) annotation (Line(points={{148,-60},
            {172,-60}},                               color={191,0,0}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Rectangle(
            extent={{40,-30},{94,-86}},
            pattern=LinePattern.None,
            fillColor={255,170,85},
            fillPattern=FillPattern.VerticalCylinder,
            lineColor={0,0,0}),
          Rectangle(
            extent={{84,-30},{78,-80}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={230,230,230}),
          Rectangle(
            extent={{70,-30},{64,-80}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={230,230,230}),
          Rectangle(
            extent={{56,-30},{50,-80}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={230,230,230}),
          Rectangle(
            extent={{74,48},{60,-20}},
            lineColor={28,108,200},
            fillColor={238,46,47},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-20,80},{40,40}},
            lineColor={28,108,200},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{74,60},{40,48}},
            lineColor={28,108,200},
            fillColor={238,46,47},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{40,60},{-20,56}},
            lineColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={230,230,230}),
          Rectangle(
            extent={{40,50},{-20,46}},
            lineColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={230,230,230}),
          Rectangle(
            extent={{-20,60},{-62,46}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-58,86},{-84,60}},
            lineColor={28,108,200},
            fillPattern=FillPattern.Sphere,
            fillColor={28,108,200}),
          Rectangle(
            extent={{-62,60},{-80,-20}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{5,60},{-5,-60}},
            lineColor={28,108,200},
            origin={-20,-25},
            rotation=90,
            fillColor={28,108,200},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{40,-20},{94,-30}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={230,230,230}),
          Ellipse(
            extent={{-84,60},{-58,86}},
            lineColor={28,108,200},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255},
            startAngle=0,
            endAngle=180),
          Rectangle(
            extent={{-20,80},{40,64}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-149,134},{151,94}},
            lineColor={0,0,255},
            textString="%name",
            visible=DynamicSelect(true,showName))}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,
              100}})),
      experiment(StopTime=5000, __Dymola_NumberOfIntervals=5000));
  end DRACS;

  function Finder_SIZZZAAA
    input Integer SIZZZAAA "<html>Isotope identification number<br>test new line</html>";
    input Integer filter = 0 annotation(choices(choice=0 "Molar mass [kg/mol]", choice=1 "Abundancy [atom%]", choice=2 "Decay constant [1/s]",choice=2 "Half-life [s]"));
    output Real y "Result based on filter selection";
  algorithm

  end Finder_SIZZZAAA;

  function InitializeArray
    input Integer n "Size of output array";
    input Real valNominal "Nominal value of array";
    input Integer iNonNominal[:] "Indices not equal to the nominal value";
    input Real valNonNominal[size(iNonNominal,1)] "Indice values not equal to the nominal value";
    output Real y[n] "Output array";
  protected
    Integer nNonNominal = size(iNonNominal,1);

  algorithm

    y :=fill(valNominal, n);
    for i in 1:nNonNominal loop
    y[iNonNominal[i]] :=valNonNominal[i];
    end for;

    annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">InitializeArray(5,&nbsp;1,&nbsp;{2,4},&nbsp;{3,8});</span></p>
<p><span style=\"font-family: Courier New;\">&nbsp;=&nbsp;{1.0,&nbsp;3.0,&nbsp;1.0,&nbsp;8.0,&nbsp;1.0}</span></p>
</html>"));
  end InitializeArray;

  function FindIndexOfMatch
    input Integer value "Search value";
    input Integer list[:] "List to be searched";
    output Integer y "Index of value in list. Return = 0 indicats not found";

  protected
    Integer n=size(list, 1);
    Integer i=1;
  algorithm

    y := 0;

    while i <= n loop
      if value == list[i] then
        y := i;
      end if;
      i := i + 1;
    end while;

  end FindIndexOfMatch;
end SupportComponents;
