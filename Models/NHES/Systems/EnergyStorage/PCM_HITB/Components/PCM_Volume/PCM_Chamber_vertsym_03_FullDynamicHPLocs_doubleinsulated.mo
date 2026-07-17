within NHES.Systems.EnergyStorage.PCM_HITB.Components.PCM_Volume;
model PCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated "Contained PCM chamber generalizable interact with a heat pipe 
  at location specified by user as node Nr and Ntheta. 
  It is on implementation that any Z-dependencies should be enforced. 
  Convection BCs on the outside surfaces are allowed, adiabatic internal conditions imposed."
  parameter Integer nR = 10 annotation(Dialog(group = "Nodalization"));
  parameter Integer nTheta = 11 annotation(Dialog(group = "Nodalization"));
  parameter Integer nZ = 6 annotation(Dialog(group = "Nodalization"));
  parameter Integer n_HPs = 2 annotation(Dialog(group = "Heat Pipes"));
  parameter Integer n_Thermocouples = 9 annotation(Dialog(group = "Thermocouples")); //This method still is only counting the r-theta thermoucouples. The actual z-locations of thermocouples are still ignored for now. While that could be added, that will necessitate a further method but it could match experiment numbering with some effort.
  parameter Real HPMatrixLocs[n_HPs, 2] = {{0.0254*4.5,0},{0.0254*6.75,120*Modelica.Constants.pi/180}} annotation(Dialog(group = "Heat Pipes"));
  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000 annotation(Dialog(group = "Heat Pipes"));
  parameter Modelica.Units.SI.Length R_PCM = 0.295275 annotation(Dialog(group = "Geometry"));
  parameter Modelica.Units.SI.Length D_TC = 0.25*25.4/1000 annotation(Dialog(group = "Thermocouples"));
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.74,25,25,25,25,29.5275} annotation(Dialog(group = "Nodalization"));
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15} annotation(Dialog(group = "Nodalization"));
  parameter Modelica.Units.SI.Length dzs_one[nZ] = 0.595/nZ*ones(nZ) annotation(Dialog(group = "Nodalization"));
  Real dAs_1_int_hp[nR+1, nTheta, nZ, n_HPs]  "Radial direction area reduction factors (range of 0-1) for each cell interface";
  Real dAs_2_int_hp[nR, nTheta+1, nZ, n_HPs]  "Azimuthal direction area reduction factors (range of 0-1) for each cell interface";
  Real dAs_3_int_hp[nR, nTheta, nZ+1, n_HPs]  "Axial direction area reduction factors (range of 0-1) for each cell interface";
  Real dAs_1[nR+1, nTheta, nZ]  "Radial direction area reduction factors (range of 0-1) for each cell interface";
  Real dAs_2[nR, nTheta+1, nZ]  "Azimuthal direction area reduction factors (range of 0-1) for each cell interface";
  Real dAs_3[nR, nTheta, nZ+1]  "Axial direction area reduction factors (range of 0-1) for each cell interface";
  parameter Modelica.Units.SI.Length l_PCM = 0.595 annotation(Dialog(group = "Geometry"));
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025 annotation(Dialog(group = "Geometry"));
  parameter Modelica.Units.SI.Length t_heat_trace = 0.0025 annotation(Dialog(group = "Geometry"));

  parameter Integer TCs[n_Thermocouples, 2] = {{1,1},{4,3},{4,6},{4,11},{7,1},{7,3},{7,6},{7,9},{7,11}} annotation(Dialog(group = "Thermocouples"));
  parameter Real TCs_Locs[n_Thermocouples, 2] = {{0.001, 0.001}, {0.045*2.54, Modelica.Constants.pi/4}, {0.045*2.54, Modelica.Constants.pi/2},{0.045*2.54, Modelica.Constants.pi-0.001}, {0.09*2.54, 0.001}, {0.09*2.54, Modelica.Constants.pi/4}, {0.09*2.54, Modelica.Constants.pi/2},{0.09*2.54, Modelica.Constants.pi*3/4}, {0.09*2.54, Modelica.Constants.pi-0.001}} annotation(Dialog(group = "Thermocouples"));
  //convention for TCs_Locs should be to have them in order of increasing radius and then increasing angle, so all r_1 thermocouples go first and then all r_2 thermocouples and each of those in order of increasing angle.
  Integer TC_Map[n_Thermocouples, 2]; //This is based on a changeable grid.
 // parameter Modelica.Units.SI.Length t_insulation = 2*0.0254 annotation(Dialog(group = "Insulation"));
    parameter Modelica.Units.SI.Length t_insulation_inner = 2*0.0254 annotation(Dialog(group = "Insulation"));
  parameter Modelica.Units.SI.Length t_insulation_outer = 2*0.0254 annotation(Dialog(group = "Insulation"));
  //input Modelica.Units.SI.Length t_insulation_end = min(t_insulation,0.15) annotation(Dialog(group = "Insulation"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5 annotation(Dialog(group = "Insulation"));
  parameter Modelica.Units.SI.Temperature T_Init = 443+273.15-5 "Constant storage medium temperature, always use because also used for wall temperature"
 annotation(Dialog(tab = "Initialization", group = "Storage"));
  parameter Modelica.Units.SI.Temperature T_Init_Insulation_Inner = 443+273.15-5 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature T_Init_Insulation_Outer = 443+273.15-5 annotation(Dialog(tab = "Initialization"));

  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_TCs[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_heat[nZ,n_HPs]; //amount of heat that the model sees from the heat pipes, it is currently heat port * HPFrac
//  Modelica.Units.SI.Power Q_thru[nZ, len_HPMatrix]; //amount of heat that gets put into the battery from the heat pipes, distributed by fractions.
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];
  Modelica.Units.SI.Length l_shell[nTheta, nZ];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta, nZ];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  Modelica.Units.SI.Temperature T_ave_theta[nTheta];
  Modelica.Units.SI.Temperature T_ave_z[nZ];
  parameter Modelica.Units.SI.DynamicViscosity mu =  5e-4 annotation(Dialog(group = "Other"));

  Modelica.Units.SI.Power Q_conv_r[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_t[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_net[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_through_3d[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_loss;
  Modelica.Units.SI.Power Q_net_trace_and_loss;
  Real Nu_r[nR,nTheta,nZ];
  Real Nu_t[nR,nTheta,nZ];
  Real Gr_r[nR,nTheta,nZ];
  Real Gr_t[nR,nTheta,nZ];
  Real Pr[nR,nTheta,nZ];
  Real beta[nR,nTheta,nZ](unit = "1/K");
  Modelica.Units.SI.Temperature Temp_Profile[nR,nTheta,nZ];
  Modelica.Units.SI.Mass m_total;
  Modelica.Units.SI.Temperature T_TCs[n_Thermocouples,nZ];
 // input Modelica.Units.SI.Power Q_heat_trace[nTheta, nZ] annotation(Dialog(tab = "General"));
  Modelica.Units.SI.Power actual_total_heat_trace;
  Real dVFracs[nR, nTheta, nZ, n_HPs];
  replaceable package Insulation_Material_Inner = NHES.Media.Solids.FoamGlass constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                   annotation(Dialog(tab = "General"), choicesAllMatching = true);
      replaceable package Insulation_Material_Outer =
      NHES.Media.Solids.FoamGlass                                                 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy annotation (Dialog(tab=
          "General"), choicesAllMatching=true);
  replaceable package PCM_Material = PCM_Materials.PCM_HITB_2_Sin
    constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                    annotation(Dialog(tab = "General"), choicesAllMatching = true);

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_3D conduction(
    redeclare package Material =
        NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.PCM_HITB_DensityFactor
        (density_mult=0.6),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Ts_start=T_field_init,
    T_a1_start=T_Init,
    T_b1_start=T_Init,
    T_a2_start=T_Init,
    T_b2_start=T_Init,
    T_a3_start=T_Init,
    T_b3_start=T_Init,
    exposeState_a1=true,
    exposeState_b1=true,
    exposeState_a2=true,
    exposeState_b2=true,
    exposeState_a3=true,
    exposeState_b3=true,
    redeclare model Geometry = HITB.Cylinder_3D_InteriorPipe (
        nR=nR,
        nTheta=nTheta,
        nZ=nZ,
        drs=drs,
        dthetas=dthetas,
        dzs=dzs,
        dVs_int=dVs_HP + dVs_TCs,
        dAs_1=dAs_1,
        dAs_2=dAs_2,
        dAs_3=dAs_3),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3.GenericHeatGeneration
        (Q_gens=Q_gens))
    annotation (Placement(transformation(extent={{-18,-42},{64,42}})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[
    nTheta,nZ]
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta[nR,nZ]
    annotation (Placement(transformation(extent={{-14,-88},{6,-68}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta1[nR,nZ]
    annotation (Placement(transformation(extent={{-14,48},{6,68}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nTheta,nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init,
    length=l_shell,
    r_inner=R_PCM,
    r_outer=R_PCM + t_PCM_wall)
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nTheta,nZ](T=293.15)
               annotation (Placement(transformation(extent={{238,-10},{218,10}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nTheta,nZ](
      surfaceArea=SA_shell, alpha=hc_air)
    annotation (Placement(transformation(extent={{210,-10},{190,10}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nR,nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init,
    th=t_PCM_wall,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-42,-54})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nR,nTheta](
    th=t_PCM_wall,
    surfaceArea=SA_End,
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,66})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nR,nTheta](
     surfaceArea=SA_End, alpha=hc_air)
                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-116})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-42,-144})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={70,158})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nR,nTheta](
     surfaceArea=SA_End, alpha=hc_air)
                                      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={70,126})));

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[nZ,n_HPs]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Heat_Trace
                                                                     [nTheta,nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_heat_trace,
    Q_gen=Heat_Tape_Input/(nTheta*nZ))
    annotation (Placement(transformation(extent={{112,-10},{132,10}})));
  Modelica.Blocks.Interfaces.RealInput Heat_Tape_Input annotation (Placement(
        transformation(extent={{-56,-46},{-96,-6}}),iconTransformation(extent={{
            100,-20},{60,20}})));

  Real f_node   [nR, nTheta, n_HPs];
  Real f_circle [nR, nTheta, n_HPs];
  Modelica.Units.SI.Area A_overlap[nR, nTheta, n_HPs];
  Real heatfracs[nR, nTheta, n_HPs];
  Real heatfracs3D[nR, nTheta, nZ, n_HPs];
  Real totalheatfrac[n_HPs];
  Modelica.Units.SI.Length heatlength[nR, nTheta, n_HPs];
  Modelica.Units.SI.Length heatlength_3D[nR, nTheta, nZ, n_HPs];

  parameter Boolean Read_T_Init = false annotation(Dialog(tab = "Initialization", group = "Storage"));
  parameter Modelica.Units.SI.Temperature T_field_init[nR, nTheta, nZ] = T_Init*ones(nR, nTheta,nZ) annotation(Dialog(tab = "Initialization", group = "Storage", enable = not Read_T_Init));

  parameter String filename = "file_loc" annotation(Dialog(tab = "Initialization", group = "Storage", enable = Read_T_Init));
  parameter String tablename = "T_Field" annotation(Dialog(tab = "Initialization", group = "Storage", enable = Read_T_Init));
  //This method requires that a 3-D table be printed into a file as a set of 2-D files with the table name "name#" where "#" is replaced by the index number in dimension 3, i.e. T_init1 (2-d table on file...) T_init2 (2-d table on file....)
  parameter Modelica.Units.SI.Temperature T_field_use[nR, nTheta, nZ] = if Read_T_Init then CylindricalNodeOverlapEstimated.ThreeDTablefrom2D(nR, nTheta, nZ, filename, tablename) else T_field_init annotation(Dialog(tab = "Initialization", group = "Storage", enable = false));
  parameter Modelica.Units.SI.Temperature T_Insulation = 120 + 273.15 annotation(Dialog(tab = "Initialization", group = "Insulation"));

  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation[nTheta,nZ](
    redeclare package Material = Insulation_Material_Inner,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Inner,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_insulation_inner)
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation_Outer[nTheta,nZ](
    redeclare package Material = Insulation_Material_Outer,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Outer,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall + t_insulation_inner,
    r_outer=R_PCM + t_PCM_wall + t_insulation_inner + t_insulation_outer)
    annotation (Placement(transformation(extent={{164,10},{184,-10}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_1a[nR,nTheta](
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    th=t_insulation_inner,
    surfaceArea=SA_End,
    redeclare package Material = Insulation_Material_Inner,
    T_start=T_Init_Insulation_Inner)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={4,94})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2a[nR,nTheta](
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    th=t_insulation_outer,
    surfaceArea=SA_End,
    redeclare package Material = Insulation_Material_Outer,
    T_start=T_Init_Insulation_Outer)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={28,94})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_1b[nR,nTheta](
    redeclare package Material = Insulation_Material_Inner,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Inner,
    th=t_insulation_inner,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,-88})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2b[nR,nTheta](
    redeclare package Material = Insulation_Material_Outer,
    T_start=T_Init_Insulation_Outer,
    th=t_insulation_outer,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-90,-88})));
initial equation
  Gr_r = zeros(nR, nTheta, nZ);

algorithm
  dVs_TCs[:,:,:] := zeros(nR, nTheta, nZ);
  dVs_HP[:,:,:] := zeros(nR, nTheta, nZ);
  dVFracs[:,:,:,:]:= zeros(nR, nTheta, nZ, n_HPs);
  for p in 1:n_HPs loop
   (f_node[:,:,p], f_circle[:,:,p], A_overlap[:,:,p]) := CylindricalNodeOverlapEstimated.allNodesCoincidentFraction(R_HP, HPMatrixLocs[p,1], HPMatrixLocs[p,2],
   drs_one, dthetas_one, 0, nR*10, nTheta*10);
   for i in 1:nR loop
     for j in 1:nTheta loop
       dVs_HP[i,j,:] := dVs_HP[i,j,:] - A_overlap[i,j,p]*dzs_one;
       dAs_3_int_hp[i,j,:,p] := (1 - A_overlap[i,j,p]/(drs_one[i]*dthetas_one[j]))*ones(nZ+1);
     end for;
   end for;
  end for;
  for p in 1:n_Thermocouples loop
    (TC_Map[p,1], TC_Map[p,2]) := CylindricalNodeOverlapEstimated.FindPointInAnnularGrid(TCs_Locs[p,1], TCs_Locs[p,2],nR, nTheta, drs_one, dthetas_one, 0, 0);
  end for;
  for i in 1:n_Thermocouples loop
    dVs_TCs[TC_Map[i,1],TC_Map[i,2],:] := -D_TC*D_TC/4*Modelica.Constants.pi*dzs_one;
  end for;

  dAs_1 := ones(nR+1, nTheta, nZ);
  dAs_2 := ones(nR, nTheta+1, nZ);
  dAs_3 := ones(nR, nTheta, nZ+1);
  for k in 1:nZ loop

  for p in 1:n_HPs loop
  (dAs_1_int_hp[:,:,k,p], dAs_2_int_hp[:,:,k,p]) := CylindricalNodeOverlapEstimated.dAs_function(R_HP,HPMatrixLocs[p,1], HPMatrixLocs[p,2], nR, nTheta, drs_one, dthetas_one, 50);
  //dAs_3_int_hp[:,:,k,p] :=A_overlap[:, :, p];
  end for;
  end for;

  for i in 1:nR+1 loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        for p in 1:n_HPs loop
          dAs_1[i,j,k] := dAs_1[i,j,k] - (1-dAs_1_int_hp[i,j,k,p]);
        end for;
      end for;
    end for;
  end for;
    for i in 1:nR loop
    for j in 1:nTheta+1 loop
      for k in 1:nZ loop
        for p in 1:n_HPs loop
        dAs_2[i,j,k] := dAs_2[i,j,k] - (1-dAs_2_int_hp[i,j,k,p]);
        end for;
      end for;
    end for;
    end for;
        for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ+1 loop
        for p in 1:n_HPs loop
        dAs_3[i,j,k] := dAs_3[i,j,k] - (1-dAs_3_int_hp[i,j,k,p]);
        end for;
      end for;
    end for;
    end for;

  for p in 1: n_HPs loop
    (heatfracs[:, :, p],heatlength[:,:,p]) := CylindricalNodeOverlapEstimated.circleArcInNode(R_HP, HPMatrixLocs[p,1], HPMatrixLocs[p,2], nR, nTheta,drs_one, dthetas_one, 360);
  end for;
  for k in 1:nZ loop
    heatfracs3D[:, :, k, :] :=heatfracs[:, :, :];
    heatlength_3D[:, :, k, :] :=heatlength[:, :, :];
  end for;




equation
  m_total = sum(conduction.geometry.Vs.*conduction.materials.d);
  for i in 1:n_Thermocouples loop
    for k in 1:nZ loop
    T_TCs[i,k] = Temp_Profile[TC_Map[i,1],TC_Map[i,2],k];
    end for;
  end for;
  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        if i == 1 and j==1 then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k]+Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif i == 1 and j == nTheta then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k]+Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == nR and j == 1 then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif i == nR and j == nTheta then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == 1 and j>1 and j<nTheta then
          Q_conv_net[i,j,k] = 0-Q_conv_r[i,j,k] + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif i == nR and j>1 and j<nTheta then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-0 + Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        elseif j== 1 and i>1 and i<nR then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k] + Q_conv_t[i,nTheta,k]-Q_conv_t[i,j,k];
        elseif j == nTheta and i>1 and i<nR then
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k] + Q_conv_t[i,j-1,k] - Q_conv_t[i,j,k];
        else
          Q_conv_net[i,j,k] = Q_conv_r[i-1,j,k]-Q_conv_r[i,j,k]+Q_conv_t[i,j-1,k]-Q_conv_t[i,j,k];
        end if;
      end for;
    end for;
  end for;

  for i in 1:nR loop
    T_ave_r[i] = sum(conduction.materials[i,:,:].T)/(nTheta*nZ);
    for j in 1:nTheta loop
      SA_End[i,j] = ((conduction.geometry.rs[i,j,1]+0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]+0.5*drs_one[i])-(conduction.geometry.rs[i,j,1]-0.5*drs_one[i])*(conduction.geometry.rs[i,j,1]-0.5*drs_one[i]))*dthetas_one[j]/2;
      for k in 1:nZ loop
        Temp_Profile[i,j,k] = conduction.materials[i,j,k].T;
        drs[i,j,k] = drs_one[i];
        dthetas[i,j,k] = dthetas_one[j];
        dzs[i,j,k] = dzs_one[k];
        beta[i,j,k] = conduction.Material.linearExpansionCoefficient(conduction.materials[i,j,k].state);
        Pr[i,j,k] = conduction.Material.specificHeatCapacityCp(conduction.materials[i,j,k].state)*mu/conduction.Material.thermalConductivity(conduction.materials[i,j,k].state);
        Q_gens[i,j,k] = Q_conv_net[i,j,k] + Q_through_3d[i,j,k];

      end for;
    end for;
  end for;

  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        Q_through_3d[i,j,k] = heatfracs3D[i,j,k,:]*Q_heat[k,:];
      end for;
    end for;
  end for;
  for l in 1:n_HPs loop
    totalheatfrac[l] = sum(heatfracs3D[:,:,:,l]);
  end for;
  for k in 1:nZ loop
    T_ave_z[k] = sum(conduction.materials[:,:,k].T)/(nR*nTheta);

      for l in 1:n_HPs loop
    Q_heat[k,l] = port_b[k,l].Q_flow;
   // port_b[k,l].T = conduction.materials[TC_Map[l,1], TC_Map[l, 2],k].T;
    port_b[k,l].T = sum(heatfracs3D[:,:,k,l].*(conduction.materials[:,:,k].T))/sum(heatfracs3D[:,:,k,l]);

   // port_b[k,l].T = Modelica.Units.Conversions.to_degC(sum(heatfracs3D[:,:,k,l].*Modelica.Units.Conversions.from_degC(conduction.materials[:,:,k].T))/sum(heatfracs3D[:,:,k]));
    end for;
  end for;

  for j in 1:nTheta loop
    T_ave_theta[j] = sum(conduction.materials[:,j,:].T)/(nR*nZ);
    for k in 1:nZ loop
      SA_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*(R_PCM+t_PCM_wall+t_insulation_inner+t_insulation_outer+t_heat_trace)*dzs_one[k];
      l_shell[j,k] = dthetas_one[j]/(2*Modelica.Constants.pi)*dzs_one[k]/(2*Modelica.Constants.pi);
    //l_shell[j,k] = dzs_one[k];
    end for;
  end for;

  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        if i < nR then
      der(Gr_r[i,j,k]) = -Gr_r[i,j,k] + (Modelica.Constants.g_n*cos(conduction.geometry.thetas[i,j,k])*beta[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])^3)/(0.5*(mu/conduction.materials[i+1,j,k].d+mu/conduction.materials[i,j,k].d)^2);
      Nu_r[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_r[i,j,k]*Pr[i,j,k]))^0.25;

        else
          der(Gr_r[i,j,k]) = 0;
          Nu_r[i,j,k] = 0;
     //     Q_conv_r[i,j,k] = 0;
        end if;
        if j<nTheta then
                Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*
                (conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T)*
                (conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,j+1,k].d+mu/conduction.materials[i,j,k].d)^2);
        else  Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,1,k].d+mu/conduction.materials[i,j,k].d)^2);
        end if;
      end for;
    end for;
  end for;

  for i in 1:nR loop
    for j in 1:nTheta loop
      for k in 1:nZ loop
        if i < nR then
           Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.conductionModel.Q_flows_1[i,j,k];
        else
          Q_conv_r[i,j,k] = 0;
        end if;
          if j<nTheta then
        Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j,k];
          else
            Q_conv_t[i,j,k] = 0;
          end if;
      end for;
    end for;
  end for;
 // Q_loss = 2*Modelica.Constants.pi/sum(dthetas_one)*(sum(End_Insulation_1.port_b.Q_flow)+sum(End_Insulation_2.port_b.Q_flow)+sum(Radial_Insulation.port_b.Q_flow));
  Q_loss =2*Modelica.Constants.pi/sum(dthetas_one)*(sum(End_Insulation_2a.port_b.Q_flow)
     + sum(End_Insulation_2b.port_b.Q_flow) + sum(Radial_Insulation_Outer.port_b.Q_flow));

  Q_net_trace_and_loss = 2*Modelica.Constants.pi/sum(dthetas_one)*(sum(conduction.port_a1.Q_flow)+sum(conduction.port_a2.Q_flow)+sum(conduction.port_a3.Q_flow)+sum(conduction.port_b1.Q_flow)+sum(conduction.port_b2.Q_flow)+sum(conduction.port_b3.Q_flow));
  actual_total_heat_trace = Heat_Tape_Input;
  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-18,0},
          {-34,0},{-34,2},{-50,2}},       color={191,0,0}));
  connect(adiabatic_theta.port, conduction.port_a2) annotation (Line(points={{6,-78},
          {22,-78},{22,-44},{23,-44},{23,-42}},          color={191,0,0}));
  connect(adiabatic_theta1.port, conduction.port_b2) annotation (Line(points={{6,58},{
          22,58},{22,48},{23,48},{23,42}},
                                       color={191,0,0}));
  connect(convection2.port_a,Air_PCM_Axial. port)
    annotation (Line(points={{207,0},{218,0}},   color={191,0,0}));
  connect(convection3.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-42,-123},{-42,-134}},
                                                   color={191,0,0}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{70,148},{70,133}}, color={191,0,0}));
  connect(PCM_Outer.port_a, conduction.port_b1) annotation (Line(points={{78,0},{
          64,0}},                   color={191,0,0}));
  connect(simpleWall1.port_a, conduction.port_b3) annotation (Line(points={{70,56},
          {70,33.6},{55.8,33.6}},             color={191,0,0}));
  connect(simpleWall.port_a, conduction.port_a3) annotation (Line(points={{-42,-44},
          {-42,-33.6},{-9.8,-33.6}},color={191,0,0}));
  connect(PCM_Outer.port_b, Heat_Trace.port_a)
    annotation (Line(points={{98,0},{112,0}}, color={191,0,0}));
  connect(Radial_Insulation_Outer.port_a,Radial_Insulation. port_b) annotation (
     Line(points={{164,0},{160,0}},
        color={191,0,0}));
  connect(Radial_Insulation_Outer.port_b, convection2.port_b) annotation (Line(
        points={{184,0},{193,0}},                                     color={191,
          0,0}));
  connect(Radial_Insulation.port_a, Heat_Trace.port_b) annotation (Line(points={{140,0},
          {132,0}},                           color={191,0,0}));
  connect(End_Insulation_2a.port_a,End_Insulation_1a. port_b)
    annotation (Line(points={{18,94},{14,94}},            color={191,0,0}));
  connect(End_Insulation_2a.port_b, convection4.port_b)
    annotation (Line(points={{38,94},{70,94},{70,119}}, color={191,0,0}));
  connect(simpleWall1.port_b, End_Insulation_1a.port_a) annotation (Line(points
        ={{70,76},{70,80},{-10,80},{-10,94},{-6,94}}, color={191,0,0}));
  connect(End_Insulation_1b.port_b,End_Insulation_2b. port_a)
    annotation (Line(points={{-76,-88},{-80,-88}},  color={191,0,0}));
  connect(End_Insulation_1b.port_a, simpleWall.port_b)
    annotation (Line(points={{-56,-88},{-42,-88},{-42,-64}}, color={191,0,0}));
  connect(End_Insulation_2b.port_b, convection3.port_b) annotation (Line(points
        ={{-100,-88},{-104,-88},{-104,-104},{-56,-104},{-56,-102},{-42,-102},{-42,
          -109}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(PreserveAspectRatio=false), graphics={
        Bitmap(extent={{-70,76},{62,-74}}, fileName=
              "modelica://NHES/Image_PCM.png"),
        Line(
          points={{-2,70},{-2,-66}},
          color={255,0,0},
          thickness=2),
        Line(
          points={{-2,66},{18,62},{40,50},{52,36},{62,10},{62,-14},{50,-38},{26,
              -60},{-4,-66}},
          color={255,0,0},
          thickness=2)}),                                        Diagram(
        coordinateSystem(PreserveAspectRatio=false), graphics={Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={94,123},
          rotation=90,
          textString="<--- Z direction")}));
end PCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated;
