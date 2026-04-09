within NHES.Systems.EnergyStorage.PCM_HITB;
model PCM_Chamber_Connected_DynamicHPLocs "Contained PCM chamber generalizable interact with a heat pipe 
  at location specified by user as node Nr and Ntheta. 
  It is on implementation that any Z-dependencies should be enforced. 
  Convection BCs on the outside surfaces are allowed, adiabatic internal conditions imposed."
  parameter Integer nR = 10;
  parameter Integer nTheta = 11;
  parameter Integer nZ = 6;
  parameter Integer n_HPs = 2;
  parameter Integer n_Thermocouples = 9;

  parameter Modelica.Units.SI.Length R_HP = 1.325*25.4/1000;
  parameter Modelica.Units.SI.Length R_PCM = 0.295275;
  parameter Modelica.Units.SI.Length D_TC = 0.25*25.4/1000;
  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26-73.66,27.74,25,25,25,25,29.5275};
  //parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = {0.3472,0.2,0.2,0.6,0.20.2,2*pi/3-1.7472,0.3472,0.2,0.2,0.5*0.6};
  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15};
  parameter Modelica.Units.SI.Length dzs_one[nZ] = 0.595/nZ*ones(nZ);
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.0025;
  parameter Modelica.Units.SI.Length t_heat_trace = 0.0025;
  parameter Modelica.Units.SI.Length l_PCM = 0.595;
  parameter Integer len_HPMatrix = 3; //This is the number of cells in the geometry that will have heat pipes in them
  parameter Integer HPMatrix[len_HPMatrix, 3] = {{4, 1, 1}, {4, 8, 2}, {4, 9, 2}}; //r-theta coordinate and heat pipe # of each heat pipe
  parameter Real HPFracs[len_HPMatrix] = {0.5, 0.7, 0.3}; //POWER fraction of heat pipe that is within the node associated with the nth term of HPMatrix, should be equivalent to perimeter fraction within node.
  parameter Real HPVolFracs[len_HPMatrix] = {0.5, 0.7, 0.3}; //VOLUME fraction of the heat pipe that is within the node associated with the nth term of HPMatrix
  parameter Integer nR_HP = 4;
  parameter Real[n_HPs] HPFrac = {0.5,1};
  parameter Integer nTheta_HP[n_HPs] = {1,8};
  parameter Integer HPs[nTheta] = {1,0,0,0,0,0,0,2,0,0,0}; //This should be thought of as an index. This is used to point to HPFrac.
  parameter Integer TCs[n_Thermocouples, 2] = {{1,1},{4,3},{4,6},{4,11},{7,1},{7,3},{7,6},{7,9},{7,11}};
  parameter Integer HP_Locs[n_HPs, 2] = {{4,1},{4,8}};
  parameter Modelica.Units.SI.Length t_insulation_inner = 2*0.0254;
  parameter Modelica.Units.SI.Length t_insulation_outer = 2*0.0254;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 2.5;
  parameter Modelica.Units.SI.Temperature T_Init = 443+273.15-5 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature T_Init_Wall = 443+273.15-5 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature T_Init_Insulation_Inner = 443+273.15-5 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature T_Init_Insulation_Outer = 443+273.15-5 annotation(Dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature T_Init_HT = 443+273.15-5 annotation(Dialog(tab = "Initialization"));

//  Real dAs_2[nR,nTheta,nZ];

  Modelica.Units.SI.Length drs[nR, nTheta, nZ];
  Modelica.Units.SI.Angle dthetas[nR, nTheta, nZ];
  Modelica.Units.SI.Length dzs[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_HP[nR, nTheta, nZ];
  Modelica.Units.SI.Volume dVs_TCs[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_heat[nZ,n_HPs];
    Modelica.Units.SI.Power Q_thru[nZ, len_HPMatrix]; //amount of heat that gets put into the battery from the heat pipes, distributed by fractions.
      Modelica.Units.SI.Power Q_through_3d[nR, nTheta, nZ];
  Modelica.Units.SI.Power Q_gens[nR, nTheta, nZ];
  Modelica.Units.SI.Length l_shell[nTheta, nZ];
  Modelica.Units.SI.Area SA_End[nR, nTheta];
  Modelica.Units.SI.Area SA_shell[nTheta, nZ];
  Modelica.Units.SI.Temperature T_ave_r[nR];
  Modelica.Units.SI.Temperature T_ave_theta[nTheta];
  Modelica.Units.SI.Temperature T_ave_z[nZ];
  parameter Modelica.Units.SI.DynamicViscosity mu =  5e-4;

  Modelica.Units.SI.Power Q_conv_r[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_t[nR,nTheta,nZ];
  Modelica.Units.SI.Power Q_conv_net[nR, nTheta, nZ];
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
  Modelica.Units.SI.Temperature T_TCs[n_Thermocouples];
  Modelica.Units.SI.Power Q_heat_trace[nTheta, nZ];
  Modelica.Units.SI.Power actual_total_heat_trace;
  replaceable package Insulation_Material_Inner = NHES.Media.Solids.FoamGlass constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                   annotation(Dialog(tab = "General"), choicesAllMatching = true);
      replaceable package Insulation_Material_Outer =
      NHES.Media.Solids.FoamGlass                                                 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy annotation (Dialog(tab=
          "General"), choicesAllMatching=true);
  replaceable package PCM_Material = PCM_Materials.PCM_HITB_2_Sin
    constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                    annotation(Dialog(tab = "General"), choicesAllMatching = true);

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_3D conduction(
    redeclare package Material = PCM_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
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
        dVs_int=dVs_HP + dVs_TCs),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3.ForwardDifference_1O,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_3.GenericHeatGeneration
        (Q_gens=Q_gens))
    annotation (Placement(transformation(extent={{-18,-40},{64,44}})));

     //   dAs_2=dAs_2,
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_r[
    nTheta,nZ]
    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta[nR,nZ]
    annotation (Placement(transformation(extent={{-8,-64},{12,-44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic
    adiabatic_theta1[nR,nZ]
    annotation (Placement(transformation(extent={{-6,48},{14,68}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder PCM_Outer[nTheta,nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Wall,
    length=l_shell,
    r_inner=R_PCM*ones(nTheta, nZ),
    r_outer=(R_PCM + t_PCM_wall)*ones(nTheta, nZ))
    annotation (Placement(transformation(extent={{78,-8},{98,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial[nTheta,nZ](T=293.15)
               annotation (Placement(transformation(extent={{220,12},{200,-8}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection2[nTheta,nZ](
      surfaceArea=SA_shell, alpha=hc_air)
    annotation (Placement(transformation(extent={{196,-8},{176,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall[nR,nTheta](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Wall,
    th=t_PCM_wall,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-32})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall simpleWall1[nR,nTheta](
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    th=t_PCM_wall,
    surfaceArea=SA_End,
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init_Wall)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={78,36})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection3[nR,nTheta](
     surfaceArea=SA_End, alpha=hc_air)
                                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-100,-32})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-122,-32})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nR,nTheta](T=293.15)
               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={170,36})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection4[nR,nTheta](
     surfaceArea=SA_End, alpha=hc_air)
                                      annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={150,36})));

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_b[nZ,n_HPs]
    annotation (Placement(transformation(extent={{4,6},{24,26}}),
        iconTransformation(extent={{4,6},{24,26}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_1b[nR,nTheta](
    redeclare package Material = Insulation_Material_Inner,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Inner,
    th=t_insulation_inner,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-54,-32})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation[nTheta,nZ](
    redeclare package Material = Insulation_Material_Inner,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Inner,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_insulation_inner)
    annotation (Placement(transformation(extent={{130,-8},{150,12}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_1a[nR,nTheta](
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    th=t_insulation_inner,
    surfaceArea=SA_End,
    redeclare package Material = Insulation_Material_Inner,
    T_start=T_Init_Insulation_Inner)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={104,36})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Heat_Trace
                                                                     [nTheta,nZ](
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    T_start=T_Init_HT,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall,
    r_outer=R_PCM + t_PCM_wall + t_heat_trace,
    Q_gen=Q_heat_trace)
    annotation (Placement(transformation(extent={{104,12},{124,-8}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder Radial_Insulation_Outer[nTheta,nZ](
    redeclare package Material = Insulation_Material_Outer,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_Init_Insulation_Outer,
    length=l_shell,
    r_inner=R_PCM + t_PCM_wall + t_insulation_inner,
    r_outer=R_PCM + t_PCM_wall + t_insulation_inner + t_insulation_outer)
    annotation (Placement(transformation(extent={{154,12},{174,-8}})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2b[nR,nTheta](
    redeclare package Material = Insulation_Material_Outer,
    T_start=T_Init_Insulation_Outer,
    th=t_insulation_outer,
    surfaceArea=SA_End) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-78,-32})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall End_Insulation_2a[nR,nTheta](
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    th=t_insulation_outer,
    surfaceArea=SA_End,
    redeclare package Material = Insulation_Material_Outer,
    T_start=T_Init_Insulation_Outer)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={128,36})));
  Modelica.Blocks.Interfaces.RealInput Heat_Tape_Input annotation (Placement(
        transformation(extent={{100,-20},{60,20}}), iconTransformation(extent={{
            100,-20},{60,20}})));
initial equation
  Gr_r = zeros(nR, nTheta, nZ);

algorithm
  dVs_TCs[:,:,:] := zeros(nR, nTheta, nZ);
    dVs_HP[:,:,:] := zeros(nR, nTheta, nZ);
  for i in 1:n_Thermocouples loop
    dVs_TCs[TCs[i,1],TCs[i,2],:] := -D_TC*D_TC/4*Modelica.Constants.pi*dzs_one;
  end for;
    for r in 1:len_HPMatrix loop
    dVs_HP[HPMatrix[r,1], HPMatrix[r,2],:] := -Modelica.Constants.pi*R_HP*R_HP*dzs_one*HPVolFracs[r];
  end for;
  Q_through_3d[:,:,:] :=zeros(nR, nTheta, nZ);
  for r in 1:len_HPMatrix loop
    Q_through_3d[HPMatrix[r,1],HPMatrix[r,2],:] := Q_through_3d[HPMatrix[r,1],HPMatrix[r,2],:]+Q_thru[:,r];
  end for;


  for j in 1:nTheta loop
    for h in 1:n_HPs loop
      //check if angle cuts through the heat pipes
    end for;
  end for;

equation
  Q_heat_trace = ones(nTheta,nZ)*Heat_Tape_Input/nTheta/nZ;
  m_total = sum(conduction.geometry.Vs.*conduction.materials.d);
  for i in 1:n_Thermocouples loop
    T_TCs[i] = 1/3*(Temp_Profile[TCs[i,1],TCs[i,2],1]+Temp_Profile[TCs[i,1],TCs[i,2],2]+Temp_Profile[TCs[i,1],TCs[i,2],3]);
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
        //  if i == nR_HP and HPs[j]>0 then
         //   dVs_HP[i,j,k] = -Modelica.Constants.pi*R_HP*R_HP*dzs_one[k]*HPFrac[HPs[j]];
      //      Q_gens[i,j,k] = Q_heat[k,HPs[j]]+Q_conv_net[i,j,k];
       //     else
      //      dVs_HP[i,j,k] = 0;
       //     Q_gens[i,j,k] = Q_conv_net[i,j,k];
      //    end if;

      end for;
    end for;
  end for;

  for k in 1:nZ loop
    T_ave_z[k] = sum(conduction.materials[:,:,k].T)/(nR*nTheta);
  //  Q_heat[k,1] = port_b[k,1].Q_flow*HPFrac[1];
   // Q_heat[k,2] = port_b[k,2].Q_flow*HPFrac[2];
      for l in 1:n_HPs loop
    Q_heat[k,l] = port_b[k,l].Q_flow*HPFrac[l];
    port_b[k,l].T = conduction.materials[nR_HP,nTheta_HP[l],k].T;
    end for;
  end for;

  for r in 1:len_HPMatrix loop
    Q_thru[:,r] = Q_heat[:,HPMatrix[r,3]]*HPFracs[r];
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
       // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.conductionModel.Q_flows_1[i,j,k];
        if i < nR then
      der(Gr_r[i,j,k]) = -Gr_r[i,j,k] + (Modelica.Constants.g_n*cos(conduction.geometry.thetas[i,j,k])*beta[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])^3)/(0.5*(mu/conduction.materials[i+1,j,k].d+mu/conduction.materials[i,j,k].d)^2);
      Nu_r[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_r[i,j,k]*Pr[i,j,k]))^0.25;

     // Q_conv_r[i,j,k] = Nu_r[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i+1,j,k]-conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_1[i,j,k]*(conduction.materials[i+1,j,k].T-conduction.materials[i,j,k].T);

        else
          der(Gr_r[i,j,k]) = 0;
          Nu_r[i,j,k] = 0;
     //     Q_conv_r[i,j,k] = 0;
        end if;
       // Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j+1,k];
        if j<nTheta then
                Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*
                (conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T)*
                (conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,j+1,k].d+mu/conduction.materials[i,j,k].d)^2);
          //      Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,j+1,k].T-conduction.materials[i,j,k].T);

        else  Nu_t[i,j,k] = 0.75*(2*Pr[i,j,k]/(5*(1+2*Pr[i,j,k]^0.5+2*Pr[i,j,k])))^0.25*(abs(Gr_t[i,j,k]*Pr[i,j,k]))^0.25;
                Gr_t[i,j,k] = (Modelica.Constants.g_n*sin(conduction.geometry.thetas[i,j,k]+dthetas[i,j,k]/2)*beta[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T)*(conduction.geometry.rs[i,j,k]*dthetas[i,j,k])^3)/(0.5*(mu/conduction.materials[i,1,k].d+mu/conduction.materials[i,j,k].d)^2);
       //         Q_conv_t[i,j,k] =Nu_t[i,j,k]*conduction.Material.thermalConductivity(conduction.materials[i,j,k].state)/(conduction.geometry.rs[i,j,k])*conduction.geometry.crossAreas_2[i,j,k]*(conduction.materials[i,1,k].T-conduction.materials[i,j,k].T);
              //  Q_conv_t[i,j,k]= Nu_t[i,j,k]*(-1)*conduction.conductionModel.Q_flows_2[i,1,k];
           //     Q_conv_t[i,j,k] = Nu_t[i,j,k]*conduction.conductionModel.Q_flows_2[i,j,k];
        end if;
      end for;
    end for;
  end for;
/*  for i in 1:nR loop
      for k in 1:nZ loop
        for j in 1:nTheta-1 loop
        dAs_2[i,j,k] = 0;
        end for;
        dAs_2[i,nTheta,k] = 0.3;
      end for;
  end for;*/
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
  Q_loss =2*Modelica.Constants.pi/sum(dthetas_one)*(sum(End_Insulation_2a.port_b.Q_flow)
     + sum(End_Insulation_2b.port_b.Q_flow) + sum(Radial_Insulation_Outer.port_b.Q_flow));
  Q_net_trace_and_loss = 2*Modelica.Constants.pi/sum(dthetas_one)*(sum(conduction.port_a1.Q_flow)+sum(conduction.port_a2.Q_flow)+sum(conduction.port_a3.Q_flow)+sum(conduction.port_b1.Q_flow)+sum(conduction.port_b2.Q_flow)+sum(conduction.port_b3.Q_flow));
  actual_total_heat_trace = 2*Modelica.Constants.pi/sum(dthetas_one)*sum(Q_heat_trace);
  connect(conduction.port_a1, adiabatic_r.port) annotation (Line(points={{-18,2},
          {-50,2}},                       color={191,0,0}));
  connect(adiabatic_theta.port, conduction.port_a2) annotation (Line(points={{12,-54},
          {23,-54},{23,-40}},                            color={191,0,0}));
  connect(adiabatic_theta1.port, conduction.port_b2) annotation (Line(points={{14,58},
          {22,58},{22,48},{23,48},{23,44}},
                                       color={191,0,0}));
  connect(convection2.port_a,Air_PCM_Axial. port)
    annotation (Line(points={{193,2},{200,2}},   color={191,0,0}));
  connect(convection3.port_a,Air_PCM_Axial2. port)
    annotation (Line(points={{-107,-32},{-112,-32}},
                                                   color={191,0,0}));
  connect(Air_PCM_Axial1.port,convection4. port_a)
    annotation (Line(points={{160,36},{157,36}}, color={191,0,0}));
  connect(PCM_Outer.port_a, conduction.port_b1) annotation (Line(points={{78,2},{
          64,2}},                   color={191,0,0}));
  connect(simpleWall1.port_a, conduction.port_b3) annotation (Line(points={{68,36},
          {62.9,36},{62.9,35.6},{55.8,35.6}}, color={191,0,0}));
  connect(simpleWall.port_a, conduction.port_a3) annotation (Line(points={{-20,-32},
          {-15.9,-32},{-15.9,-31.6},{-9.8,-31.6}},
                                    color={191,0,0}));
  connect(simpleWall.port_b, End_Insulation_1b.port_a)
    annotation (Line(points={{-40,-32},{-44,-32}}, color={191,0,0}));
  connect(End_Insulation_1a.port_a, simpleWall1.port_b)
    annotation (Line(points={{94,36},{88,36}}, color={191,0,0}));
  connect(PCM_Outer.port_b, Heat_Trace.port_a)
    annotation (Line(points={{98,2},{104,2}}, color={191,0,0}));
  connect(Heat_Trace.port_b, Radial_Insulation.port_a)
    annotation (Line(points={{124,2},{130,2}}, color={191,0,0}));
  connect(End_Insulation_1b.port_b, End_Insulation_2b.port_a)
    annotation (Line(points={{-64,-32},{-68,-32}},  color={191,0,0}));
  connect(End_Insulation_2b.port_b, convection3.port_b)
    annotation (Line(points={{-88,-32},{-93,-32}},   color={191,0,0}));
  connect(Radial_Insulation_Outer.port_a, Radial_Insulation.port_b) annotation (
     Line(points={{154,2},{150,2}},
        color={191,0,0}));
  connect(Radial_Insulation_Outer.port_b, convection2.port_b) annotation (Line(
        points={{174,2},{179,2}},                     color={191,0,0}));
  connect(convection4.port_b, End_Insulation_2a.port_b)
    annotation (Line(points={{143,36},{138,36}}, color={191,0,0}));
  connect(End_Insulation_2a.port_a, End_Insulation_1a.port_b)
    annotation (Line(points={{118,36},{114,36}},          color={191,0,0}));
  annotation (Icon(coordinateSystem(PreserveAspectRatio=false, extent={{-160,
            -160},{220,180}}),                                  graphics={
        Bitmap(extent={{-70,-74},{62,76}}, fileName="modelica://NHES/Image_PCM.png"),
        Line(
          points={{-2,70},{-2,-66}},
          color={255,0,0},
          thickness=2),
        Line(
          points={{-2,66},{18,62},{40,50},{52,36},{62,10},{62,-14},{50,-38},{26,
              -60},{-4,-66}},
          color={255,0,0},
          thickness=2)}),                                        Diagram(
        coordinateSystem(PreserveAspectRatio=false, extent={{-160,-160},{220,
            180}}),                                  graphics={Text(
          extent={{34,9},{-34,-9}},
          textColor={28,108,200},
          origin={88,129},
          rotation=90,
          textString="<--- Z direction")}));
end PCM_Chamber_Connected_DynamicHPLocs;
