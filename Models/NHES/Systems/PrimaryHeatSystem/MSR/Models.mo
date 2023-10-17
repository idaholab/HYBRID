within NHES.Systems.PrimaryHeatSystem.MSR;
package Models

  model PrimaryFuelLoop

  //  extends TRANSFORM.Icons.Example;

    import TRANSFORM;
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_MSR_PFL CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare Data.data_MSR data);

    input Real Feed_Temp_input annotation(Dialog(tab="General"));

  protected
    package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
          C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
    package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

    Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
        Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
      "Mass flow rate of salt to drain tank (+)";

    replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
            kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

    parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

    // Constant volume spacing for radial geometry
    //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
    //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

    // Initialization
    import Modelica.Constants.N_A;
    //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
    //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
    //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
    //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
    //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
    //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
    //     "Mole fraction of LiF";
    //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
    //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
    //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
    //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
    //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
    //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
    //     "Mole fraction of lithium in flibe that is Li-7";
    //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
    //     "Mole fraction of lithium in flibe that is Li-6";

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
   // parameter Integer nV_pipeFromPHX_PCL=2;
  //  parameter Integer nV_pipeToPHX_PCL=2;
  ///  parameter Integer nV_pipeToSHX_PCL=2;

    // Summary Calculations
  public
    Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
      "Total thermal power output (from primary fission)";
  protected
    Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

    Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

    Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

    parameter Integer iPu=kinetics.data.nC + SupportComponents.FindIndexOfMatch(   20094239, kinetics.reactivity.data.SIZZZAAA);

    parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
        30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
        30054137};
  public
    parameter Integer iSep[:]={kinetics.data.nC + SupportComponents.FindIndexOfMatch(   i, kinetics.reactivity.data.SIZZZAAA)
        for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

    Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
      pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
        1,
        {plenum_lower.medium.T},
        reflA_lower.mediums.T,
        fuelCell.mediums.T,
        reflA_upper.mediums.T,
        {plenum_upper.medium.T},
        pipeToPHX_PFL.mediums.T,
        PHX.tube.mediums.T,
        pipeFromPHX_PFL.mediums.T,
        {tee_inlet.medium.T});

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
      nParallel=data_MSR.nFcells,
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      T_b_start=data_MSR.T_inlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      m_flow_a_start=0.95*data_MSR.m_flow,
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gens=kinetics.mC_gens_all),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gens=kinetics.Qs),
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_f,
          perimeter=data_MSR.perimeter_f,
          length=data_MSR.length_cells,
          angle=toggleStaticHead*90,
          surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
          nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    SupportComponents.GenericPipe_forMSRs reflA_upper(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 50,
      T_a_start=data_MSR.T_inlet_tube,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
              reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel
              /reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[
              end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,60})));

    SupportComponents.MixingVolume_forMSRs plenum_upper(
      p_start=data_MSR.p_inlet_tube,
      T_start=data_MSR.T_inlet_tube,
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      redeclare package Medium = Medium_PFL,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,90})));
    SupportComponents.GenericPipe_forMSRs reflA_lower(
      C_a_start=Cs_start,
      m_flow_a_start=data_MSR.m_flow,
      p_a_start=data_MSR.p_inlet_tube + 150,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_a=false,
      exposeState_b=true,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          crossArea=data_MSR.crossArea_reflA_ring,
          perimeter=data_MSR.perimeter_reflA_ring,
          length=data_MSR.length_reflA,
          nV=2,
          nSurfaces=2,
          angle=toggleStaticHead*90,
          surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
              reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel
              /reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[
              end, :])}),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-60})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,30})));
    SupportComponents.MixingVolume_forMSRs plenum_lower(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=1,
      redeclare package Medium = Medium_PFL,
      nPorts_a=1,
      p_start=data_MSR.p_inlet_tube + 150,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_plenum,
          crossArea=data_MSR.crossArea_plenum,
          angle=toggleStaticHead*90),
      T_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,112})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
      redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
      nParallel=2*data_MSR.nfG*data_MSR.nFcells,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_fG,
          length_y=data_MSR.length_cells,
          length_z=data_MSR.length_fG),
      exposeState_b2=true,
      exposeState_b1=true,
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
        nPorts=fuelCell.nV, showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
          fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
      redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
      T_a2_start=data_MSR.T_inlet_tube,
      T_b2_start=data_MSR.T_inlet_tube,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=data_MSR.T_inlet_tube,
      T_b1_start=data_MSR.T_inlet_tube,
      nParallel=data_MSR.n_reflA_ringG,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          nZ=reflA_upper.nV,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,90})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
         reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,30})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
      redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      nParallel=data_MSR.n_reflA_ringG,
      T_a1_start=data_MSR.T_outlet_tube,
      T_b1_start=data_MSR.T_outlet_tube,
      T_a2_start=data_MSR.T_outlet_tube,
      T_b2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
          (
          nR=5,
          r_inner=data_MSR.rs_ring_edge_inner[6],
          r_outer=data_MSR.rs_ring_edge_outer[6],
          length_z=data_MSR.length_reflA,
          nZ=reflA_lower.nV,
          angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-30,-60})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-28})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
         reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-30,-90})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
    SupportComponents.MixingVolume_forMSRs tee_inlet(
      C_start=Cs_start,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      T_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube + 200,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
          (
          length=data_MSR.length_tee_inlet,
          crossArea=data_MSR.crossArea_tee_inlet,
          angle=toggleStaticHead*90),
      nPorts_a=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-130})));
    SupportComponents.GenericPipe_forMSRs pipeFromPHX_PFL(
      nParallel=3,
      T_a_start=data_MSR.T_outlet_tube,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 250,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          length=data_MSR.length_PHXToRCTR,
          dimension=data_MSR.D_PFL,
          dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
          nV=nV_pipeFromPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,-70})));

    SupportComponents.GenericDistributed_HX_withMass_forMSRs PHX(
      redeclare package Medium_shell = Medium_PCL,
      redeclare package Medium_tube = Medium_PFL,
      p_a_start_shell=data_MSR.p_inlet_shell,
      T_a_start_shell=data_MSR.T_inlet_shell,
      T_b_start_shell=data_MSR.T_outlet_shell,
      p_a_start_tube=data_MSR.p_inlet_tube,
      T_a_start_tube=data_MSR.T_inlet_tube,
      T_b_start_tube=data_MSR.T_outlet_tube,
      nParallel=24,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
      C_a_start_tube=Cs_start,
      m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer,
          S_T=data_MSR.pitch_tube,
          S_L=data_MSR.pitch_tube,
          CFs=fill(
                  0.44,
                  PHX.shell.heatTransfer.nHT,
                  PHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          D_o_shell=data_MSR.D_shell_inner,
          nTubes=data_MSR.nTubes,
          nR=3,
          length_shell=data_MSR.length_tube,
          th_wall=data_MSR.th_tube,
          dimension_tube=data_MSR.D_tube_inner,
          length_tube=data_MSR.length_tube,
          nV=nV_PHX),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={160,0})));

    SupportComponents.GenericPipe_forMSRs pipeToPHX_PFL(
      nParallel=3,
      redeclare package Medium = Medium_PFL,
      p_a_start=data_MSR.p_inlet_tube + 350,
      T_a_start=data_MSR.T_inlet_tube,
      C_a_start=Cs_start,
      m_flow_a_start=2*3*data_MSR.m_flow_tube,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PFL,
          length=data_MSR.length_pumpToPHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
          nV=nV_pipeToPHX_PFL),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={160,70})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
      redeclare package Medium = Medium_PFL,
      m_flow_nominal=2*3*data_MSR.m_flow_tube,
      use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
    SupportComponents.ExpansionTank pumpBowl_PFL(
      redeclare package Medium = Medium_PFL,
      p_start=data_MSR.p_inlet_tube,
      level_start=data_MSR.level_pumpbowlnominal,
      C_start=Cs_start,
      showName=systemTF.showName,
      h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
          data_MSR.T_inlet_tube),
      A=3*data_MSR.crossArea_pumpbowl,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{10,124},{30,144}})));
    inner TRANSFORM.Fluid.SystemTF systemTF(
      showName=false,
      showColors=true,
      val_max=data_MSR.T_inlet_tube,
      val_min=data_MSR.T_inlet_shell)
      annotation (Placement(transformation(extent={{200,120},{220,140}})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
      annotation (Placement(transformation(extent={{290,120},{310,140}})));
    SupportComponents.GenericPipe_forMSRs reflR(
      C_a_start=Cs_start,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      T_a_start=data_MSR.T_outlet_tube,
      exposeState_b=true,
      p_a_start=data_MSR.p_inlet_tube + 100,
      redeclare package Medium = Medium_PFL,
      use_HeatTransfer=true,
      showName=systemTF.showName,
      nParallel=data_MSR.nRegions,
      m_flow_a_start=0.05*data_MSR.m_flow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          angle=toggleStaticHead*90,
          crossArea=data_MSR.crossArea_reflR,
          perimeter=data_MSR.perimeter_reflR,
          length=data_MSR.length_reflR,
          surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
              [1, :])},
          nV=fuelCell.nV),
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,0})));

    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
      redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
      exposeState_b2=true,
      exposeState_b1=true,
      T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_a2_start=data_MSR.T_outlet_tube,
      showName=systemTF.showName,
      nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
      T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
      T_b2_start=data_MSR.T_outlet_tube,
      redeclare model Geometry =
          TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
          (
          nX=5,
          nY=fuelCell.nV,
          length_x=0.5*data_MSR.width_reflR_blockG,
          length_y=data_MSR.length_reflR,
          length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={50,0})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-30})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
        showName=systemTF.showName, nPorts=reflR.nV)
      annotation (Placement(transformation(extent={{88,-10},{68,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
          systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-30})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));

    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
      kinetics(
      nV=fuelCell.nV,
      Q_nominal=data_MSR.Q_nominal,
      specifyPower=false,
      redeclare record Data = Data_PG,
      Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
      rho_input=realExpression4.u,
      mCs_all=fuelCell.mCs*fuelCell.nParallel,
      nFeedback=2,
      alphas_feedback={-3.22e-5,2.35e-5},
      vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
      vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
      toggle_Reactivity=false,
      redeclare model Reactivity =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
          (
          redeclare record Data = Data_ISO,
          mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
          use_noGen=true,
          i_noGen=i_mCs_start_salt))
      "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
      annotation (Placement(transformation(extent={{-90,-12},{-70,8}})));

    //////////
    //    //Comment/Uncomment as a block - BIG DATA - 2b
    //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //
    //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
    //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
    //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
    //              19.43194,99.693068,185.13937};
    //
    //          constant Integer i_mCs_start_salt[:]={1009,1013};
    //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

    //Comment/Uncomment as a block - BIG DATA - 2b
    //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
    //     constant Integer i_mCs_start_salt[:]={1009,1013};

    //Comment/Uncomment as a block - MEDIUM DATA - 2a
    record Data_ISO = Data.fissionProducts_1a;
    constant Integer i_mCs_start_salt[:]={89,92};

    // for cases 2a and 2b
    constant String actinide[:]={"u-235","u-238"};
    constant Integer nA=size(i_mCs_start_salt, 1);
    constant SI.MassFraction x_actinide[nA]={0.05,0.95};

    // initial uranium mass estimate
    constant Real Ufrac = 0.01;
    constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
    constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
    constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

    constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
        nA};

      constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
      constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
          for i in 1:nA};

  //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
  //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
  //        for i in 1:nA};

    //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
    //         *nV_total;

    //   //Comment/Uncomment as a block - SMALL DATA - test
    //       record Data_ISO =
    //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
    //
    //       constant Integer i_mCs_start_salt[:]={4};
    //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

    ////
    parameter Real mCs_start_ISO[kinetics.reactivity.nC]=SupportComponents.InitializeArray(
        kinetics.reactivity.nC,
        0.0,
        i_mCs_start_salt,
        mCs_start_salt);
    parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
        1,
        fill(0, kinetics.data.nC),
        mCs_start_ISO);

  parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

  protected
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
      annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
    //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
    //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
    //
    //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
    //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
    //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
    //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
    //        + 1:end];
    //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
    //       end];
    //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
    //       kinetics.data.nC + 1:end];
    //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

    //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
    //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

    // atoms per node

  public
    SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
    SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_upper.mCs;
    SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        reflA_lower.mCs;
    SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
       pipeFromPHX_PFL.mCs;
    SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
    SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
        pipeToPHX_PFL.mCs;
    SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

    // atoms component total
    SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
    SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
    SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
    SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
    SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
    SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
        drainTank_liquid.mC;
    SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
        :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
        :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
        pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
    SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
        reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

    // atoms total
    SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
        mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
        mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
        mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
        mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
         + kinetics.reactivity.data.nC};

    // nParallel
    Real plenum_upper_nParallel=1;
    Real plenum_lower_nParallel=1;
    Real tee_inlet_nParallel=1;
    Real pumpBowl_PFL_nParallel=1;
    Real drainTank_gas_nParallel=1;
    Real drainTank_liquid_nParallel=1;
    Real fuelCell_nParallel=fuelCell.nParallel;
    Real reflA_upper_nParallel=reflA_upper.nParallel;
    Real reflA_lower_nParallel=reflA_lower.nParallel;
    Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
    Real PHX_tube_nParallel=PHX.tube.nParallel;
    Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
    Real reflR_nParallel=reflR.nParallel;

    // mass per node
    SI.Mass plenum_upper_m=plenum_upper.m;
    SI.Mass plenum_lower_m=plenum_lower.m;
    SI.Mass tee_inlet_m=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m=drainTank_liquid.m;
    SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
    SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
    SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
    SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
    SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
    SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
    SI.Mass reflR_m[reflR.nV]=reflR.ms;

    // mass component total
    SI.Mass plenum_upper_m_total=plenum_upper.m;
    SI.Mass plenum_lower_m_total=plenum_lower.m;
    SI.Mass tee_inlet_m_total=tee_inlet.m;
    SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
    SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
    SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
    SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
    SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
    SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
    SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
    SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
    SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

    // mass total
    SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
        pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
        reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
        pipeToPHX_PFL_m_total + reflR_m_total;

    // volume nodal
    SI.Volume plenum_upper_V=plenum_upper.V;
    SI.Volume plenum_lower_V=plenum_lower.V;
    SI.Volume tee_inlet_V=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
    SI.Volume drainTank_liquid_V=drainTank_liquid.V;
    SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
    SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
    SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
    SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
    SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
    SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
    SI.Volume reflR_V[reflR.nV]=reflR.Vs;

    // volume component total
    SI.Volume plenum_upper_V_total=plenum_upper.V;
    SI.Volume plenum_lower_V_total=plenum_lower.V;
    SI.Volume tee_inlet_V_total=tee_inlet.V;
    SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
    SI.Volume drainTank_gas_V_total=drainTank_gas.V;
    SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
    SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
    SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
    SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
    SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
    SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
    SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
    SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

    // volume total
    SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
        pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
        reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
        pipeToPHX_PFL_V_total + reflR_V_total;

    // nV
    Integer fuelCell_nV=fuelCell.nV;
    Integer reflA_upper_nV=reflA_upper.nV;
    Integer reflA_lower_nV=reflA_lower.nV;
    Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
    Integer PHX_tube_nV=PHX.tube.nV;
    Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
    Integer reflR_nV=reflR.nV;

    // lengths
    SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
    SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
    SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
    SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
    SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
    SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
    SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

    // dimensions
    SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
    SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
    SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
    SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
    SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
    SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
    SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

    Data.data_MSR data_MSR(
      nHX_total=6,
      nParallel=3,
      nHX_total_SHX=6,
      nParallel_SHX=3)
      annotation (Placement(transformation(extent={{266,-128},{286,-108}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRatePrimary(redeclare package
        Medium = Medium_PFL) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={148,32})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_PCL)
      annotation (Placement(transformation(extent={{296,-62},{316,-42}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_PCL)
      annotation (Placement(transformation(extent={{292,0},{312,20}})));
    Modelica.Fluid.Sensors.Temperature outlet_temp(redeclare package Medium =
          Medium_PFL)
      annotation (Placement(transformation(extent={{54,60},{34,80}})));
    Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
          Medium_PFL)
      annotation (Placement(transformation(extent={{26,-106},{46,-86}})));
    Modelica.Blocks.Sources.RealExpression Feed_Temp(y=Feed_Temp_input)
      annotation (Placement(transformation(extent={{-154,158},{-134,178}})));
    TRANSFORM.Blocks.RealExpression realExpression4
      annotation (Placement(transformation(extent={{248,44},{268,64}})));
  protected
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.Q_nominal,
      k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
      annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
      annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
    TRANSFORM.Controls.LimPID PID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      k_s=1/data_MSR.T_inlet_tube,
      k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
      annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
      annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
      redeclare package Medium = Medium_OffGas,
      nPorts=2,
      T=data_OFFGAS.T_carbon,
      p=data_OFFGAS.p_sep_ref,
      use_p_in=true,
      showName=systemTF.showName) annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
      T=data_OFFGAS.T_sep_ref,
      redeclare package Medium = Medium_OffGas,
      m_flow=data_OFFGAS.m_flow_He_adsorber,
      use_m_flow_in=true,
      use_T_in=true,
      nPorts=1,
      use_C_in=false,
      showName=systemTF.showName)
      annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
    TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix adsorberBed(
      nV=10,
      redeclare package Medium = Medium_OffGas,
      d_adsorber=data_OFFGAS.d_carbon,
      cp_adsorber=data_OFFGAS.cp_carbon,
      tau_res=data_OFFGAS.delay_charcoalBed,
      R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
      use_HeatPort=true,
      T_a_start=data_OFFGAS.T_carbon,
      showName=systemTF.showName,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
      annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
      annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary_thermal_adsorberBed(
      nPorts=adsorberBed.nV,
      T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-268,18})));
    SupportComponents.MixingVolume_forMSRs drainTank_gas(
      use_HeatPort=true,
      redeclare package Medium = Medium_OffGas,
      T_start=data_OFFGAS.T_drainTank,
      p_start=data_OFFGAS.p_drainTank,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO,
      nPorts_b=2,
      nPorts_a=1,
      showName=systemTF.showName,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
      annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
    SupportComponents.ExpansionTank drainTank_liquid(
      redeclare package Medium = Medium_PFL,
      p_surface=drainTank_gas.medium.p,
      h_start=pumpBowl_PFL.h_start,
      p_start=drainTank_gas.p_start,
      C_start=Cs_start,
      use_HeatPort=true,
      A=data_OFFGAS.crossArea_drainTank_inner,
      level_start=0.20,
      showName=systemTF.showName,
      Q_gen=100,
      redeclare record Data_PG = Data_PG,
      redeclare record Data_ISO = Data_ISO)
      annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fromDrainTank(
      redeclare package Medium = Medium_PFL,
      R=1,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-268,-52})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
        package Medium =                                                                   Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
        package Medium =
                 Medium_OffGas) annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
        package Medium = Medium_OffGas)
      annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
          m_flow_OffGas_adsorberBed.y)
      annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
    Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
          boundary_OffGas_m_flow.y)
      annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
    TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
      iSep=iSep,
      iCar=iSep,
      m_flow_sepFluid=m_flow_toDrainTank,
      redeclare package Medium = Medium_PFL,
      redeclare package Medium_carrier = Medium_OffGas,
      showName=systemTF.showName) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-318,98})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare package
        Medium =                                                                        Medium_PFL,
        use_input=true) annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
    Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
      annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
    Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
      annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
    Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
      annotation (Placement(transformation(extent={{200,80},{220,100}})));
    TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
          sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
        redeclare package Medium = Medium_PFL)
      annotation (Placement(transformation(extent={{100,118},{120,138}})));
    Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
  equation
    connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
      annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
    connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
      annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
    connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
            -70},{-6.66134e-16,-70}}, color={0,127,255}));
    connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
      annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
    connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
      annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
    connect(reflA_upper.port_b, plenum_upper.port_a[1])
      annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
    connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{
            -4.44089e-16,105},{-4.44089e-16,100.5},{0.25,100.5},{0.25,96}},  color={0,127,255}));
    connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
      annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
    connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
      annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
    connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
      annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
    connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
      annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
    connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
      annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
    connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
      annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
    connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
      annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
      annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
    connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
      annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
    connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
      annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
    connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
            {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
    connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
            -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
    connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
      annotation (Line(points={{-3.88578e-16,-96},{-3.88578e-16,-100},{0,-100},{0,
            -103}},                               color={0,127,255}));
    connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
      annotation (Line(points={{0,-117},{0,-120},{0,-124},{0.25,-124}},
                                                   color={0,127,255}));
    connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
      annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
    connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
      annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
      annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
    connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},
            {160,-140},{-3.88578e-16,-140},{-3.88578e-16,-136}},
                                                      color={0,127,255}));
    connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
      annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
    connect(reflR.port_a, resistance_reflR_inlet.port_b)
      annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
    connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
      annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
    connect(resistance_reflR_outlet.port_a, reflR.port_b)
      annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
    connect(reflRG.port_a1, reflR.heatPorts[:, 1])
      annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
    connect(reflRG.port_a2, reflRG_lower_bc.port)
      annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
    connect(reflRG.port_b1, reflRG_centerline_bc.port)
      annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
    connect(reflRG.port_b2, reflRG_upper_bc.port)
      annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
    connect(realExpression.y, PID.u_s)
      annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
    connect(realExpression1.y, PID.u_m)
      annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
    connect(realExpression2.y, PID2.u_s)
      annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
    connect(realExpression3.y, PID2.u_m)
      annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
    connect(boundary_OffGas_T.y, boundary_OffGas_source.T_in)
      annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
    connect(boundary_OffGas_m_flow.y, boundary_OffGas_source.m_flow_in)
      annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}}, color={0,0,127}));
    connect(boundary_thermal_adsorberBed.port, adsorberBed.heatPorts)
      annotation (Line(points={{-268,8},{-268,-7}}, color={191,0,0}));
    connect(drainTank_liquid.port_b, resistance_fromDrainTank.port_a)
      annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
    connect(resistance_fromDrainTank.port_b, pump_drainTank.port_a)
      annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
    connect(adsorberBed.port_b, pump_OffGas_adsorberBed.port_a)
      annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
    connect(m_flow_OffGas_bypass.y, pump_OffGas_bypass.in_m_flow)
      annotation (Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
    connect(m_flow_OffGas_adsorberBed.y, pump_OffGas_adsorberBed.in_m_flow)
      annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}}, color={0,0,127}));
    connect(boundary_OffGas_source.ports[1], traceSeparator.port_a_carrier)
      annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
    connect(m_flow_pump_bypass.y, pump_bypass.in_m_flow)
      annotation (Line(points={{-305,134},{-296,134},{-296,127.3}}, color={0,0,127}));
    connect(adsorberBed.port_a, drainTank_gas.port_b[1])
      annotation (Line(points={{-278,-12},{-286,-12},{-286,-11.75},{-292,
            -11.75}},                                                            color={0,127,255}));
    connect(pump_bypass.port_b, traceSeparator.port_a)
      annotation (Line(points={{-306,120},{-312,120},{-312,108}}, color={0,127,255}));
    connect(traceSeparator.port_sepFluid, drainTank_liquid.port_a)
      annotation (Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
    connect(traceSeparator.port_b_carrier, drainTank_gas.port_a[1])
      annotation (Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
    connect(pump_OffGas_bypass.port_a, drainTank_gas.port_b[2])
      annotation (Line(points={{-278,38},{-286,38},{-286,-12.25},{-292,-12.25}},
                                                                               color={0,127,255}));
    connect(pump_OffGas_bypass.port_b, boundary_OffGas_sink.ports[1])
      annotation (Line(points={{-258,38},{-248,38},{-248,37},{-238,37}}, color={0,127,255}));
    connect(pump_OffGas_adsorberBed.port_b, boundary_OffGas_sink.ports[2]) annotation (Line(points={{-228,
            -12},{-206,-12},{-206,24},{-246,24},{-246,39},{-238,39}}, color={0,127,255}));
    connect(boundary_fromPump_PFL_bypass_p.y, boundary_OffGas_sink.p_in)
      annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
    connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
            78},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_drainTank.port_b, pumpBowl_PFL.port_a)
      annotation (Line(points={{-228,-52},{-188,-52},{-188,128},{13,128}}, color={0,127,255}));
    connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
            158},{160,158},{160,80}}, color={0,127,255}));
    connect(boundary_OffGas_T1.y, pump_drainTank.in_m_flow)
      annotation (Line(points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
    connect(pump_PFL.port_b, simpleSeparator.port_a)
      annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
    connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
      annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
    connect(massFlowRatePrimary.port_a, pipeToPHX_PFL.port_b) annotation (Line(
          points={{148,42},{152,42},{152,60},{160,60}}, color={0,127,255}));
    connect(massFlowRatePrimary.port_b, PHX.port_a_tube)
      annotation (Line(points={{148,22},{148,10},{160,10}}, color={0,127,255}));
    connect(PHX.port_b_shell, port_b)
      annotation (Line(points={{164.6,10},{302,10}}, color={0,127,255}));
    connect(PHX.port_a_shell, port_a) annotation (Line(points={{164.6,-10},{164.6,
            -52},{306,-52}}, color={0,127,255}));
    connect(outlet_temp.port, plenum_upper.port_b[2]) annotation (Line(points={{44,60},
            {22,60},{22,96},{-0.25,96}},        color={0,127,255}));
    connect(temperature.port, tee_inlet.port_b[2]) annotation (Line(points={{36,
            -106},{36,-124},{-0.25,-124}}, color={0,127,255}));
    connect(sensorBus.temp_outlet, outlet_temp.T) annotation (Line(
        points={{-30,166},{72,166},{72,54},{37,54},{37,70}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.temp_inlet, temperature.T) annotation (Line(
        points={{-30,166},{10,166},{10,-80},{43,-80},{43,-96}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.pump_speed, pump_PFL.in_m_flow) annotation (Line(
        points={{30,166},{30,154},{50,154},{50,135.3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.Feed_Temp_input, Feed_Temp.y) annotation (Line(
        points={{-30,166},{-81.5,166},{-81.5,168},{-133,168}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.CR_reactivity, realExpression4.u) annotation (Line(
        points={{30,166},{88,166},{88,54},{246,54}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
          annotation (Placement(transformation(extent={{260,120},{280,140}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
      experiment(
        StopTime=157680000,
        __Dymola_NumberOfIntervals=1825,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p><br>More information can also be found in the below paper</p>
<p>Greenwood, M. Scott, Benjamin R. Betzler, A. Lou Qualls, Junsoo Yoo, and Cristian Rabiti. &quot;Demonstration of the advanced dynamic system modeling tool TRANSFORM in a molten salt reactor application via a model of the molten salt demonstration reactor.&quot; Nuclear Technology 206, no. 3 (2020): 478-504.</p>
<p>To obtain the correct power, the heat exchangers were scaled to have 24 heat exchangers for the PHX.</p>
<p><br><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Contact: Sarah Creasman&nbsp;<a href=\"mailto:sarah.creasman@inl.gov\">sarah.creasman@inl.gov</a></span></p>
<p><span style=\"font-family: Arial;\">Documentation updated September 2023</span></p>
</html>"));
  end PrimaryFuelLoop;

  model PrimaryCoolantLoop
    extends MSR.BaseClasses.Partial_SubSystem_A(
      redeclare replaceable Data.data_MSR data,
      redeclare replaceable ControlSystems.CS_MSR_PCL CS,
      redeclare replaceable ControlSystems.ED_Dummy ED);

      replaceable package Medium_PFL =
        TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT
      "Primary fuel loop medium";

    package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

    package Medium_BOP = Modelica.Media.Water.StandardWater;

      record Data_PG =
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

          parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

    // import Modelica.Constants.N_A;

    parameter Integer nV_fuelCell=2;
    parameter Integer nV_PHX=2;
    parameter Integer nV_SHX=2;
    parameter Integer nV_pipeToPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PFL=2;
    parameter Integer nV_pipeFromPHX_PCL=2;
    parameter Integer nV_pipeToPHX_PCL=2;
    parameter Integer nV_pipeToSHX_PCL=2;

    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{88,-34},{108,-14}}),
          iconTransformation(extent={{88,-34},{108,-14}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{88,38},{108,58}}),
          iconTransformation(extent={{88,38},{108,58}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
          Medium_BOP)
      annotation (Placement(transformation(extent={{88,48},{108,68}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package Medium =
          Medium_PCL)
      annotation (Placement(transformation(extent={{-108,36},{-88,56}}),
          iconTransformation(extent={{-108,36},{-88,56}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1(redeclare package Medium =
          Medium_PCL)
      annotation (Placement(transformation(extent={{-108,-36},{-88,-16}}),
          iconTransformation(extent={{-108,-36},{-88,-16}})));

    //  C_a_start_tube=Cs_start,

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
      redeclare package Medium = Medium_PCL,
      p=1000000,
      nPorts=1) annotation (Placement(transformation(extent={{-18,-6},{2,14}})));
  public
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
      nParallel=3,
      redeclare package Medium = Medium_PCL,
      p_a_start=data_MSR.p_inlet_shell - 50,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_PHXsToPump,
          dheight=toggleStaticHead*data_MSR.height_PHXsToPump,
          nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-30,46})));
     // showName=systemTF.showName,
    TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
      level_start=data_MSR.level_pumpbowlnominal,
      redeclare package Medium = Medium_PCL,
      A=3*data_MSR.crossArea_pumpbowl,
      h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start,
          data_MSR.T_outlet_shell_SHX))
      annotation (Placement(transformation(extent={{-10,42},{10,62}})));
    //  showName=systemTF.showName,
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_nominal=2*3*data_MSR.m_flow_shell,
      use_input=true)  annotation (Placement(transformation(extent={{20,36},{40,56}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
      nParallel=3,
      redeclare package Medium = Medium_PCL,
      T_a_start=data_MSR.T_outlet_shell,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 300,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_pumpToSHX,
          dheight=toggleStaticHead*data_MSR.height_pumpToSHX,
          nV=nV_pipeToSHX_PCL),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
                                annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={60,46})));
   //   showName=systemTF.showName,
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
      redeclare package Medium = Medium_PCL,
      m_flow_a_start=2*3*data_MSR.m_flow_shell,
      p_a_start=data_MSR.p_inlet_shell + 50,
      T_a_start=data_MSR.T_inlet_shell,
      nParallel=3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data_MSR.D_PCL,
          length=data_MSR.length_SHXToPHX,
          dheight=toggleStaticHead*data_MSR.height_SHXToPHX,
          nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={10,-34})));
   //   showName=systemTF.showName,

    TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
      redeclare package Medium_shell = Medium_PCL,
      nParallel=24,
      p_a_start_shell=data_MSR.p_inlet_shell_SHX,
      T_a_start_shell=data_MSR.T_inlet_shell_SHX,
      T_b_start_shell=data_MSR.T_outlet_shell_SHX,
      m_flow_a_start_shell=2*3*data_MSR.m_flow_shell_SHX,
      p_a_start_tube=data_MSR.p_inlet_tube_SHX,
      T_a_start_tube=data_MSR.T_inlet_tube_SHX,
      T_b_start_tube=data_MSR.T_outlet_tube_SHX,
      m_flow_a_start_tube=288.5733428,
      redeclare model HeatTransfer_tube =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      redeclare model HeatTransfer_shell =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
          (
          D=data_MSR.D_tube_outer_SHX,
          S_T=data_MSR.pitch_tube_SHX,
          S_L=data_MSR.pitch_tube_SHX,
          CFs=fill(
              0.44,
              SHX.shell.heatTransfer.nHT,
              SHX.shell.heatTransfer.nSurfaces)),
      redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
      redeclare package Medium_tube = Medium_BOP,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
          (
          nR=3,
          D_o_shell=data_MSR.D_shell_inner_SHX,
          nTubes=data_MSR.nTubes_SHX,
          length_shell=data_MSR.length_tube_SHX,
          dimension_tube=data_MSR.D_tube_inner_SHX,
          length_tube=data_MSR.length_tube_SHX,
          th_wall=data_MSR.th_tube_SHX,
          nV=nV_SHX)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,6})));

    TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
      redeclare package Medium_OffGas =
          Modelica.Media.IdealGases.SingleGases.He,
      redeclare package Medium_PFL = Medium_PFL,
      redeclare package Material_Graphite =
          TRANSFORM.Media.Solids.Graphite.Graphite_0,
      redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
      nG_reflA_blocks=1,
      dims_reflAG_1=1,
      dims_reflAG_2=1,
      dims_reflAG_3=1,
      dims_reflAG_4=0.017453292519943,
      crossArea_reflA=1,
      perimeter_reflA=1,
      alpha_reflA=111,
      surfaceArea_reflA=1,
      m_reflAG=1,
      m_reflA=1,
      nG_reflR_blocks=1,
      dims_reflRG_1=1,
      dims_reflRG_2=1,
      dims_reflRG_3=1,
      crossArea_reflR=1,
      perimeter_reflR=1,
      alpha_reflR=1,
      surfaceArea_reflR=1,
      m_reflRG=1,
      m_reflR=1,
      volume_reflRG=1,
      nG_fuelCell=1,
      dims_fuelG_1=1,
      dims_fuelG_2=1,
      dims_fuelG_3=1,
      crossArea_fuel=1,
      perimeter_fuel=1,
      alpha_fuel=1,
      surfaceArea_fuel=1,
      m_fuelG=1,
      m_fuel=1,
      m_plenum=1,
      m_tee_inlet=1,
      dims_pumpBowl_1=1,
      dims_pumpBowl_2=1,
      level_nom_pumpBowl=1,
      m_pumpBowl=1,
      dims_pipeToPHX_1=1,
      dims_pipeToPHX_2=1,
      m_pipeToPHX_PFL=1,
      dims_pipeFromPHX_1=1,
      dims_pipeFromPHX_2=1,
      m_pipeFromPHX_PFL=1,
      T_tube_inlet_PHX=data_MSR.T_inlet_tube,
      T_tube_outlet_PHX=data_MSR.T_outlet_tube,
      p_inlet_tube_PHX=data_MSR.p_inlet_tube,
      dp_tube_PHX=100000,
      m_flow_tube_PHX=data_MSR.m_flow_tube,
      T_shell_inlet_PHX=data_MSR.T_inlet_shell,
      T_shell_outlet_PHX=data_MSR.T_outlet_shell,
      p_inlet_shell_PHX=data_MSR.p_inlet_shell,
      dp_shell_PHX=100000,
      m_flow_shell_PHX=data_MSR.m_flow_shell,
      nTubes_PHX=1,
      diameter_outer_tube_PHX=1,
      th_tube_PHX=1,
      length_tube_PHX=1,
      tube_pitch_PHX=data_MSR.pitch_tube,
      redeclare package Medium_PCL = Medium_PCL,
      alpha_tube_PHX=1,
      surfaceArea_tube_PHX=1,
      m_tube_PHX=1,
      crossArea_shell_PHX=1,
      perimeter_shell_PHX=1,
      alpha_shell_PHX=1,
      surfaceArea_shell_PHX=1,
      m_shell_PHX=1,
      dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
      dims_pumpBowl_PCL_2=data_MSR.length_pumpbowl,
      level_nom_pumpBowl_PCL=data_MSR.level_pumpbowlnominal,
      m_pumpBowl_PCL=pumpBowl_PCL.m/3,
      dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
      dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
      m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
      dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
      dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
      m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
      dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
      dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
      m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
      T_tube_inlet_SHX=data_MSR.T_inlet_tube_SHX,
      T_tube_outlet_SHX=data_MSR.T_outlet_tube_SHX,
      p_inlet_tube_SHX=data_MSR.p_inlet_tube_SHX,
      dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
      m_flow_tube_SHX=data_MSR.m_flow_tube_SHX,
      T_shell_inlet_SHX=data_MSR.T_inlet_shell_SHX,
      T_shell_outlet_SHX=data_MSR.T_outlet_shell_SHX,
      p_inlet_shell_SHX=data_MSR.p_inlet_shell_SHX,
      dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
      m_flow_shell_SHX=data_MSR.m_flow_shell_SHX,
      nTubes_SHX=SHX.geometry.nTubes,
      diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
      th_tube_SHX=SHX.geometry.th_wall,
      length_tube_SHX=SHX.geometry.length_tube,
      tube_pitch_SHX=data_MSR.pitch_tube_SHX,
      surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
      redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
      alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
      m_tube_SHX=1,
      crossArea_shell_SHX=1,
      perimeter_shell_SHX=1,
      alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV,
      surfaceArea_shell_SHX=1,
      m_shell_SHX=1)
      annotation (Placement(transformation(extent={{-96,78},{-76,98}})));

    Data.data_MSR data_MSR
      annotation (Placement(transformation(extent={{-70,78},{-50,98}})));
  equation
    connect(pipeFromPHX_PCL.port_b,pumpBowl_PCL. port_a)
      annotation (Line(points={{-20,46},{-7,46}},  color={0,127,255}));
    connect(pumpBowl_PCL.port_b,pump_PCL. port_a)
      annotation (Line(points={{7,46},{20,46}},    color={0,127,255}));
    connect(pump_PCL.port_b,pipeToSHX_PCL. port_a)
      annotation (Line(points={{40,46},{50,46}},   color={0,127,255}));
    connect(pipeToPHX_PCL.port_a,SHX. port_b_shell)
      annotation (Line(points={{20,-34},{75.4,-34},{75.4,-4}},     color={0,127,255}));
    connect(pipeToSHX_PCL.port_b,SHX. port_a_shell)
      annotation (Line(points={{70,46},{75.4,46},{75.4,16}},    color={0,127,255}));
  public
    record Data_ISO = Data.fissionProducts_1a;
  equation
    connect(port_a, SHX.port_a_tube) annotation (Line(points={{98,-24},{98,-10},{
            80,-10},{80,-4}},  color={0,127,255}));
    connect(actuatorBus.pump_speed, pump_PCL.in_m_flow) annotation (Line(
        points={{30,166},{30,53.3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(SHX.port_b_tube, sensor_p.port) annotation (Line(points={{80,16},
            {80,42},{98,42},{98,48}}, color={0,127,255}));
    connect(sensor_p.port, port_b) annotation (Line(points={{98,48},{98,48}},
                                        color={0,127,255}));
    connect(sensorBus.SG_pressure, sensor_p.p) annotation (Line(
        points={{-30,166},{114,166},{114,58},{104,58}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(port_a1, pipeFromPHX_PCL.port_a) annotation (Line(points={{-98,46},{
            -70,46},{-70,46},{-40,46}},
                           color={0,127,255}));
    connect(port_b1, pipeToPHX_PCL.port_b) annotation (Line(points={{-98,-26},{-6,
            -26},{-6,-34},{1.77636e-15,-34}},
                                     color={0,127,255}));
    connect(port_b1, port_b1)
      annotation (Line(points={{-98,-26},{-98,-26}}, color={0,127,255}));
    connect(boundary.ports[1], pipeToPHX_PCL.port_a) annotation (Line(points={{2,
            4},{26,4},{26,-34},{20,-34}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-78,70},{74,-50}},
            textColor={28,108,200},
            textString="MSR-PCL")}),                               Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000000, __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p><br>More information can also be found in the below paper</p>
<p>Greenwood, M. Scott, Benjamin R. Betzler, A. Lou Qualls, Junsoo Yoo, and Cristian Rabiti. &quot;Demonstration of the advanced dynamic system modeling tool TRANSFORM in a molten salt reactor application via a model of the molten salt demonstration reactor.&quot; Nuclear Technology 206, no. 3 (2020): 478-504.</p>
<p>To obtain the correct power, the heat exchangers were scaled to have 24 heat exchangers for the SHX.</p>
<p><br><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Contact: Sarah Creasman&nbsp;<a href=\"mailto:sarah.creasman@inl.gov\">sarah.creasman@inl.gov</a></span></p>
<p><span style=\"font-family: Arial;\">Documentation updated September 2023</span></p>
</html>"));
  end PrimaryCoolantLoop;
end Models;
