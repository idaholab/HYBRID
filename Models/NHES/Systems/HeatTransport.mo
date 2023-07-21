within NHES.Systems;
package HeatTransport
  model HeatTransport
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data,
      redeclare replaceable data.pipe_data_1 Return_pipe_data(
        L=Supply_pipe_data.L,
        D=Supply_pipe_data.D,
        pth=Supply_pipe_data.pth,
        ith=Supply_pipe_data.ith,
        nV=Supply_pipe_data.nV,
        dH=-Supply_pipe_data.dH));
         replaceable package S_Medium = Modelica.Media.Interfaces.PartialMedium
                                                                                "Supply Media"
      annotation (Dialog(group="Fluid Medium"), __Dymola_choicesAllMatching=
          true);
      replaceable package R_Medium = Modelica.Media.Interfaces.PartialMedium "Return Media"
      annotation (Dialog(group="Fluid Medium"),__Dymola_choicesAllMatching=true);
       //HT-----------------------------------------------------------------

         //supply
        import NHES.Systems.HeatTransport.BaseClasses.choices.HT_Mode;

      parameter Boolean S_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_wall_res=false "Use A Given Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_ins_res=false "Use A Given Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity S_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_wall_res and S_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity S_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_ins_res and S_use_HeatTransfer));
      replaceable package Sp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Wall Material properties" annotation (
        choicesAllMatching=true, Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_wall_res));
      replaceable package Si_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Insulation Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_ins_res));
   //   parameter HT_Mode S_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
    //  annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer S_alpha=10 "External Supply Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature S_amb_T=303.15 "Supply Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      replaceable model S_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer), choicesAllMatching=true);
      replaceable model S_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Supply Internal heat generation" annotation (Dialog(
         tab="Heat Transfer",group="Supply Side"), choicesAllMatching=true);

      replaceable model S_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Supply Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);
      replaceable model R_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Return Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);

          //Return

      parameter Boolean R_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Boolean R_use_wall_res=false "Use Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Boolean R_use_ins_res=false "Use Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity R_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_wall_res and R_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity R_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_ins_res and R_use_HeatTransfer));
      replaceable package Rp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Return Pipe Wall Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer and not R_use_wall_res));
            replaceable package Ri_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                       constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Return Pipe Insulation Material properties" annotation (
        choicesAllMatching=true, Dialog(
        tab="Heat Transfer",
        group="Return Side",
        enable=
            R_use_HeatTransfer and not R_use_ins_res));
  //    parameter HT_Mode R_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
    //  annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer R_alpha=10 "External Return Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature R_amb_T=303.15 "Return Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer));

      replaceable model R_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer), choicesAllMatching=true);

      replaceable model R_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Return Internal heat generation" annotation (Dialog(
          tab="Heat Transfer",group="Return Side"), choicesAllMatching=true);

            //Pumps ---------------------------------------------------------------------
  //supply
    parameter Boolean use_Supply_pump=false "Use Supply Side Pump" annotation (Dialog(tab="Pumps"),choices(checkBox=true));

       parameter Boolean S_use_input=false "Use input for pump controls" annotation (Dialog(tab="Pumps"),choices(checkBox=true));
    //return
    parameter Boolean use_Return_pump=false "Use Return Side Pump" annotation (Dialog(tab="Pumps"),choices(checkBox=true));
      parameter Boolean R_use_input=false "Use input for pump controls" annotation (Dialog(tab="Pumps"),choices(checkBox=true));

      //init -----------------------------------------------------------------------

      parameter Modelica.Units.SI.AbsolutePressure S_p_a_start=S_Medium.p_default "Supply Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.AbsolutePressure S_p_b_start=S_Medium.p_default "Supply Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Boolean S_use_T_start=true "Use Initial Temperature for Supply Side" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.Temperature S_T_a_start=S_Medium.T_default "Supply Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.Temperature S_T_b_start=S_Medium.T_default "Supply Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_a_start=S_Medium.h_default "Supply Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_b_start=S_Medium.h_default "Supply Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_a_start=0 "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_b_start=-S_m_flow_a_start "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));

      parameter Modelica.Units.SI.AbsolutePressure R_p_a_start=R_Medium.p_default "Return Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.AbsolutePressure R_p_b_start=R_Medium.p_default "Return Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Boolean R_use_T_start=true "Use Initial Temperature for Return Side" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.Temperature R_T_a_start=R_Medium.T_default "Return Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Return",enable= R_use_T_start));
      parameter Modelica.Units.SI.Temperature R_T_b_start=R_Medium.T_default "Return Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Return",enable= R_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy R_h_a_start=R_Medium.h_default "Return Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Return",enable=not R_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy R_h_b_start=R_Medium.h_default "Return Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Return",enable=not R_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate R_m_flow_a_start=0 "Return Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.MassFlowRate R_m_flow_b_start=-R_m_flow_a_start "Return Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Return"));

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_S(redeclare package Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_S(redeclare package
        Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{90,30},{110,50}}),
          iconTransformation(extent={{90,30},{110,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_R(redeclare package Medium =
          R_Medium)
      annotation (Placement(transformation(extent={{90,-48},{110,-28}}),
          iconTransformation(extent={{90,-48},{110,-28}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_R(redeclare package
        Medium =
          R_Medium)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
          iconTransformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(redeclare
        package Medium = S_Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel = S_FlowModel,
      use_HeatTransfer=S_use_HeatTransfer,
      redeclare model HeatTransfer = S_HeatTransfer,
      redeclare model InternalHeatGen =S_InternalHeatGen)
      annotation (Placement(transformation(extent={{-20,0},{20,40}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Return(redeclare
        package Medium = R_Medium,
      use_Ts_start=R_use_T_start,
      p_a_start=R_p_a_start,
      p_b_start=R_p_b_start,
      T_a_start=R_T_a_start,
      T_b_start=R_T_b_start,
      h_a_start=R_h_a_start,
      h_b_start=R_h_b_start,
      m_flow_a_start=R_m_flow_a_start,
      m_flow_b_start=R_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Return_pipe_data.D,
          length=Return_pipe_data.L,
          dheight=Return_pipe_data.dH,
          nV=Return_pipe_data.nV),
      redeclare model FlowModel = R_FlowModel,
      use_HeatTransfer=R_use_HeatTransfer,
      redeclare model HeatTransfer = R_HeatTransfer,
      redeclare model InternalHeatGen = R_InternalHeatGen)
      annotation (Placement(transformation(extent={{20,0},{-20,-40}})));

    replaceable NHES.Fluid.Machines.Pump_MassFlow Supply_pump(redeclare package
        Medium = S_Medium, use_input=false) if use_Supply_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(tab="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-80,60},{-60,80}})));

    replaceable NHES.Fluid.Machines.Pump_MassFlow Return_pump(redeclare package
        Medium = R_Medium, use_input=false) if use_Return_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(tab="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{80,-60},{60,-80}})));

    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,30},{-40,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,30},{60,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_out(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_in(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_out(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,30},{-70,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,30},{90,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_in(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
    Modelica.Blocks.Math.Add Supply_dp(k2=-1)
      annotation (Placement(transformation(extent={{260,40},{280,60}})));
    Modelica.Blocks.Math.Add Supply_dt(k2=-1)
      annotation (Placement(transformation(extent={{260,40},{280,20}})));
    Modelica.Blocks.Math.Add Return_dt(k2=-1)
      annotation (Placement(transformation(extent={{260,-40},{280,-20}})));
    Modelica.Blocks.Math.Add Return_dp(k2=-1)
      annotation (Placement(transformation(extent={{260,-40},{280,-60}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder R_w_res[
      Return_pipe_data.nV](
      L=Return_pipe_data.L/Return_pipe_data.nV,
      r_in=(Return_pipe_data.D)/2,
      r_out=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      lambda=R_w_lambda) if R_use_wall_res
      annotation (Placement(transformation(extent={{-32,-64},{-12,-44}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder R_i_res[
      Return_pipe_data.nV](
      L=Return_pipe_data.L/Return_pipe_data.nV,
      r_in=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      r_out=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
          /2,
      lambda=R_i_lambda) if R_use_ins_res
      annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_i_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      lambda=S_i_lambda) if S_use_ins_res
      annotation (Placement(transformation(extent={{54,70},{74,50}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_w_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=Supply_pipe_data.D/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      lambda=S_w_lambda) if S_use_wall_res
      annotation (Placement(transformation(extent={{14,70},{34,50}})));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow R_wi[Return_pipe_data.nV]
      annotation (Placement(transformation(extent={{-52,-84},{-32,-64}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_wi[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{34,90},{54,70}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_it[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{74,90},{94,70}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow R_it[Return_pipe_data.nV]
      annotation (Placement(transformation(extent={{-92,-84},{-72,-64}}),
          iconVisible=false));
    Modelica.Blocks.Interfaces.RealInput S_u if S_use_input annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,100}),iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,100})));
    Modelica.Blocks.Interfaces.RealInput R_u if R_use_input and use_Return_pump annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={70,-100}),iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={70,-100})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_wall[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=Supply_pipe_data.D/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      redeclare package Material = Sp_Material)
      if S_use_HeatTransfer and not S_use_wall_res
      annotation (Placement(transformation(extent={{14,70},{34,90}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_insulation[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      redeclare package Material = Si_Material)
      if S_use_HeatTransfer and not S_use_ins_res
      annotation (Placement(transformation(extent={{54,70},{74,90}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{154,50},{134,70}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
                                 if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{112,50},{92,70}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_cond[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{154,70},{134,90}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder R_pipe_wall[
      Return_pipe_data.nV](
      length=Return_pipe_data.L/Return_pipe_data.nV,
      r_inner=Return_pipe_data.D/2,
      r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      redeclare package Material = Rp_Material)
      if S_use_HeatTransfer and not R_use_wall_res
      annotation (Placement(transformation(extent={{-12,-84},{-32,-64}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder R_pipe_insulation[
      Return_pipe_data.nV](
      length=Return_pipe_data.L/Return_pipe_data.nV,
      r_inner=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
          /2,
      redeclare package Material = Ri_Material)
      if S_use_HeatTransfer and not R_use_ins_res
      annotation (Placement(transformation(extent={{-52,-84},{-72,-64}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_conv[
      Supply_pipe_data.nV](T=R_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{-152,-64},{-132,-44}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      R_convection_constantArea_2DCyl(
      nNodes=Return_pipe_data.nV,
      r_outer=Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith,
      length=Return_pipe_data.L,
      alphas=R_alpha*ones(Return_pipe_data.nV))
                             if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{-112,-64},{-92,-44}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_cond[
      Return_pipe_data.nV](T=R_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{-152,-84},{-132,-64}})));
    parameter Boolean S_with_Cond = true;
     //S_HTmode==HT_Mode.Cond;
    parameter Boolean S_with_Conv = false;
    //S_HTmode==HT_Mode.Conv;
    parameter Boolean R_with_Cond = true;
    //R_HTmode==HT_Mode.Cond;
    parameter Boolean R_with_Conv = false;
    //R_HTmode==HT_Mode.Conv;

  equation
      //connections
    if  use_Supply_pump then
      connect( port_a_S, Supply_pump.port_a);
      connect( Supply_pump.port_b, Supply.port_a);
    else
      connect(port_a_S, Supply.port_a);
    end if;
    if  use_Return_pump then
      connect( port_a_R, Return_pump.port_a);
      connect( Return_pump.port_b, Return.port_a);
    else
      connect(port_a_R, Return.port_a);
    end if;

    connect(Supply.port_b, port_b_S)
      annotation (Line(points={{20,20},{20,40},{100,40}},
                                                  color={0,127,255}));
    connect(Return.port_b, port_b_R)
      annotation (Line(points={{-20,-20},{-20,-40},{-100,-40}},
                                                      color={0,127,255}));
    connect(S_convection_constantArea_2DCyl.port_a, S_boundary_conv.port)
      annotation (Line(points={{113,60},{134,60}},color={127,0,0}));
    connect(Supply.heatPorts[:, 1], S_pipe_wall.port_a)
      annotation (Line(points={{0,30},{0,80},{14,80}},color={191,0,0}));
    connect(R_convection_constantArea_2DCyl.port_a, R_boundary_conv.port)
      annotation (Line(points={{-113,-54},{-132,-54}}, color={127,0,0}));
    connect(R_pipe_wall.port_a, Return.heatPorts[:, 1])
      annotation (Line(points={{-12,-74},{0,-74},{0,-30}},
                                                  color={191,0,0}));
    connect(Return.port_b, sensor_p_R_out.port) annotation (Line(points={{-20,-20},
            {-20,-40},{-50,-40},{-50,-30}},
                                  color={0,127,255}));
    connect(Return.port_b, sensor_T_R_out.port) annotation (Line(points={{-20,-20},
            {-20,-40},{-80,-40},{-80,-30}},           color={0,127,255}));
    connect(Supply.port_a, sensor_T_S_in.port) annotation (Line(points={{-20,20},{
            -20,30},{-80,30}},                   color={0,127,255}));
    connect(Supply.port_a, sensor_p_S_in.port)
      annotation (Line(points={{-20,20},{-20,30},{-50,30}}, color={0,127,255}));
    connect(Return.port_a, sensor_p_R_in.port)
      annotation (Line(points={{20,-20},{20,-30},{50,-30}}, color={0,127,255}));
    connect(Return.port_a, sensor_T_R_in.port) annotation (Line(points={{20,-20},{
            20,-30},{80,-30}},                   color={0,127,255}));
    connect(Supply.port_b, sensor_p_S_out.port)
      annotation (Line(points={{20,20},{20,40},{50,40},{50,30}},
                                                         color={0,127,255}));
    connect(Supply.port_b, sensor_T_S_out.port) annotation (Line(points={{20,20},{
            20,40},{80,40},{80,30}},         color={0,127,255}));
    connect(sensor_p_S_in.p, Supply_dp.u1) annotation (Line(points={{-44,20},{-30,
            20},{-30,0},{248,0},{248,56},{258,56}},
                                           color={0,0,127}));
    connect(sensor_p_S_out.p, Supply_dp.u2) annotation (Line(points={{56,20},{56,0},
            {248,0},{248,44},{258,44}},        color={0,0,127}));
    connect(sensor_T_S_in.T, Supply_dt.u1) annotation (Line(points={{-74,20},{-74,
            0},{248,0},{248,24},{258,24}},          color={0,0,127}));
    connect(sensor_T_S_out.T, Supply_dt.u2) annotation (Line(points={{86,20},{86,0},
            {248,0},{248,36},{258,36}},
                                    color={0,0,127}));
    connect(sensor_p_R_out.p, Return_dp.u2) annotation (Line(points={{-44,-20},{-30,
            -20},{-30,0},{248,0},{248,-44},{258,-44}},
                                             color={0,0,127}));
    connect(sensor_p_R_in.p, Return_dp.u1) annotation (Line(points={{56,-20},{56,0},
            {248,0},{248,-56},{258,-56}}, color={0,0,127}));
    connect(sensor_T_R_in.T, Return_dt.u1) annotation (Line(points={{86,-20},{86,0},
            {248,0},{248,-24},{258,-24}}, color={0,0,127}));
    connect(sensor_T_R_out.T, Return_dt.u2) annotation (Line(points={{-74,-20},{-74,
            0},{248,0},{248,-36},{258,-36}},           color={0,0,127}));
    connect(R_pipe_insulation.port_a, R_wi)
      annotation (Line(points={{-52,-74},{-42,-74}},   color={191,0,0}));
    connect(R_pipe_wall.port_b, R_wi)
      annotation (Line(points={{-32,-74},{-42,-74}},   color={191,0,0}));
    connect(R_i_res.port_b, R_wi) annotation (Line(points={{-55,-54},{-42,-54},{-42,
            -74}},  color={191,0,0}));
    connect(R_w_res.port_a, R_wi) annotation (Line(points={{-29,-54},{-42,-54},{-42,
            -74}},  color={191,0,0}));
    connect(R_w_res.port_b, Return.heatPorts[:, 1])
      annotation (Line(points={{-15,-54},{0,-54},{0,-30}},color={191,0,0}));
    connect(S_wi, S_pipe_insulation.port_a)
      annotation (Line(points={{44,80},{54,80}},   color={191,0,0}));
    connect(S_pipe_wall.port_b, S_wi)
      annotation (Line(points={{34,80},{44,80}},   color={191,0,0}));
    connect(S_w_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{17,60},{0,60},{0,30}},color={191,0,0}));
    connect(S_w_res.port_b, S_wi)
      annotation (Line(points={{31,60},{44,60},{44,80}},  color={191,0,0}));
    connect(S_i_res.port_a, S_wi)
      annotation (Line(points={{57,60},{44,60},{44,80}},  color={191,0,0}));
    connect(S_pipe_insulation.port_b, S_it)
      annotation (Line(points={{74,80},{84,80}},   color={191,0,0}));
    connect(S_i_res.port_b, S_it)
      annotation (Line(points={{71,60},{84,60},{84,80}},  color={191,0,0}));
    connect(S_convection_constantArea_2DCyl.port_b, S_it)
      annotation (Line(points={{91,60},{84,60},{84,80}},  color={127,0,0}));
    connect(S_it, S_boundary_cond.port)
      annotation (Line(
      points={{84,80},{134,80}},   color={191,0,0}));
    connect(R_pipe_insulation.port_b, R_it)
      annotation (Line(points={{-72,-74},{-82,-74}},   color={191,0,0}));
    connect(R_it, R_convection_constantArea_2DCyl.port_b) annotation (Line(points={{-82,-74},
            {-82,-54},{-91,-54}},            color={191,0,0}));
    connect(R_it, R_boundary_cond.port)
      annotation (Line(points={{-82,-74},{-132,-74}},   color={191,0,0}));
    connect(R_i_res.port_a, R_it) annotation (Line(points={{-69,-54},{-82,-54},{-82,
            -74}},  color={191,0,0}));
    connect(R_u, Return_pump.inputSignal)
      annotation (Line(points={{70,-100},{70,-77.3}}, color={0,0,127}));
    connect(Supply_pump.inputSignal, S_u)
      annotation (Line(points={{-70,77.3},{-70,100}}, color={0,0,127}));
    connect(sensor_p_S_in.port, sensor_T_S_in.port)
      annotation (Line(points={{-50,30},{-80,30}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Rectangle(
            extent={{-100,36},{100,44}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-44},{100,-36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-90,34},{-50,74}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Rectangle(
            extent={{-70,34},{-34,46}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Ellipse(
            extent={{50,-74},{90,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Return_pump then true else false)),
          Rectangle(
            extent={{36,-46},{72,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Return_pump then true else false)),
          Line(
            points={{-40,-34},{-34,-24},{-44,-16},{-38,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-20,-34},{-14,-24},{-24,-16},{-18,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{0,-34},{6,-24},{-4,-16},{2,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,-34},{26,-24},{16,-16},{22,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-60,-34},{-54,-24},{-64,-16},{-58,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-80,-34},{-74,-24},{-84,-16},{-78,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-40,-46},{-34,-56},{-44,-64},{-38,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-20,-46},{-14,-56},{-24,-64},{-18,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{0,-46},{6,-56},{-4,-64},{2,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,-46},{26,-56},{16,-64},{22,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-60,-46},{-54,-56},{-64,-64},{-58,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-80,-46},{-74,-56},{-84,-64},{-78,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,34},{26,24},{16,16},{22,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,34},{46,24},{36,16},{42,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,34},{66,24},{56,16},{62,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,34},{86,24},{76,16},{82,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,34},{6,24},{-4,16},{2,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,34},{-14,24},{-24,16},{-18,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{20,46},{26,56},{16,64},{22,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,46},{46,56},{36,64},{42,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,46},{66,56},{56,64},{62,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,46},{86,56},{76,64},{82,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,46},{6,56},{-4,64},{2,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,46},{-14,56},{-24,64},{-18,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Text(
            extent={{-100,-88},{100,-128}},
            textColor={28,108,200},
            textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end HeatTransport;

  model HeatTransport_withCS
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data,
      redeclare replaceable data.pipe_data_1 Return_pipe_data(
        L=Supply_pipe_data.L,
        D=Supply_pipe_data.D,
        pth=Supply_pipe_data.pth,
        ith=Supply_pipe_data.ith,
        nV=Supply_pipe_data.nV,
        dH=-Supply_pipe_data.dH));
         replaceable package S_Medium = Modelica.Media.Interfaces.PartialMedium
                                                                                "Supply Media"
      annotation (Dialog(group="Fluid Medium"), __Dymola_choicesAllMatching=
          true);
      replaceable package R_Medium = Modelica.Media.Interfaces.PartialMedium "Return Media"
      annotation (Dialog(group="Fluid Medium"),__Dymola_choicesAllMatching=true);
       //HT-----------------------------------------------------------------

         //supply
        import NHES.Systems.HeatTransport.BaseClasses.choices.HT_Mode;

      parameter Boolean S_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_wall_res=false "Use A Given Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_ins_res=false "Use A Given Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity S_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_wall_res and S_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity S_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_ins_res and S_use_HeatTransfer));
      replaceable package Sp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Wall Material properties" annotation (
        choicesAllMatching=true, Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_wall_res));
      replaceable package Si_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Insulation Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_ins_res));
     // parameter HT_Mode S_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
     // annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer S_alpha=10 "External Supply Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature S_amb_T=303.15 "Supply Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      replaceable model S_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer), choicesAllMatching=true);
      replaceable model S_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Supply Internal heat generation" annotation (Dialog(
         tab="Heat Transfer",group="Supply Side"), choicesAllMatching=true);

      replaceable model S_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Supply Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);
      replaceable model R_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Return Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);

          //Return

      parameter Boolean R_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Boolean R_use_wall_res=false "Use Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Boolean R_use_ins_res=false "Use Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Return Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity R_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_wall_res and R_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity R_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_ins_res and R_use_HeatTransfer));
      replaceable package Rp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Return Pipe Wall Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer and not R_use_wall_res));
            replaceable package Ri_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                       constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Return Pipe Insulation Material properties" annotation (
        choicesAllMatching=true, Dialog(
        tab="Heat Transfer",
        group="Return Side",
        enable=
            R_use_HeatTransfer and not R_use_ins_res));
    //  parameter HT_Mode R_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
    //  annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer R_alpha=10 "External Return Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature R_amb_T=303.15 "Return Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer));

      replaceable model R_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Return Side",enable=R_use_HeatTransfer), choicesAllMatching=true);

      replaceable model R_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Return Internal heat generation" annotation (Dialog(
          tab="Heat Transfer",group="Return Side"), choicesAllMatching=true);

            //Pumps ---------------------------------------------------------------------
  //supply
    parameter Boolean use_Supply_pump=false "Use Supply Side Pump" annotation (Dialog(tab="Pumps"),choices(checkBox=true));

       parameter Boolean S_use_CS=false "Use control system input for pump controls" annotation (Dialog(tab="Pumps"),choices(checkBox=true));
    //return
    parameter Boolean use_Return_pump=false "Use Return Side Pump" annotation (Dialog(tab="Pumps"),choices(checkBox=true));
      parameter Boolean R_use_CS=false "Use control system input for pump controls" annotation (Dialog(tab="Pumps"),choices(checkBox=true));

      //init -----------------------------------------------------------------------

      parameter Modelica.Units.SI.AbsolutePressure S_p_a_start=S_Medium.p_default "Supply Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.AbsolutePressure S_p_b_start=S_Medium.p_default "Supply Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Boolean S_use_T_start=true "Use Initial Temperature for Supply Side" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.Temperature S_T_a_start=S_Medium.T_default "Supply Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.Temperature S_T_b_start=S_Medium.T_default "Supply Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_a_start=S_Medium.h_default "Supply Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_b_start=S_Medium.h_default "Supply Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_a_start=0 "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_b_start=-S_m_flow_a_start "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));

      parameter Modelica.Units.SI.AbsolutePressure R_p_a_start=R_Medium.p_default "Return Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.AbsolutePressure R_p_b_start=R_Medium.p_default "Return Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Boolean R_use_T_start=true "Use Initial Temperature for Return Side" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.Temperature R_T_a_start=R_Medium.T_default "Return Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Return",enable= R_use_T_start));
      parameter Modelica.Units.SI.Temperature R_T_b_start=R_Medium.T_default "Return Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Return",enable= R_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy R_h_a_start=R_Medium.h_default "Return Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Return",enable=not R_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy R_h_b_start=R_Medium.h_default "Return Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Return",enable=not R_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate R_m_flow_a_start=0 "Return Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Return"));
      parameter Modelica.Units.SI.MassFlowRate R_m_flow_b_start=-R_m_flow_a_start "Return Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Return"));

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_S(redeclare package Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_S(redeclare package
        Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{90,30},{110,50}}),
          iconTransformation(extent={{90,30},{110,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_R(redeclare package Medium =
          R_Medium)
      annotation (Placement(transformation(extent={{90,-48},{110,-28}}),
          iconTransformation(extent={{90,-48},{110,-28}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_R(redeclare package
        Medium =
          R_Medium)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
          iconTransformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(redeclare
        package Medium = S_Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel = S_FlowModel,
      use_HeatTransfer=S_use_HeatTransfer,
      redeclare model HeatTransfer = S_HeatTransfer,
      redeclare model InternalHeatGen =S_InternalHeatGen)
      annotation (Placement(transformation(extent={{-20,0},{20,40}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Return(redeclare
        package Medium = R_Medium,
      use_Ts_start=R_use_T_start,
      p_a_start=R_p_a_start,
      p_b_start=R_p_b_start,
      T_a_start=R_T_a_start,
      T_b_start=R_T_b_start,
      h_a_start=R_h_a_start,
      h_b_start=R_h_b_start,
      m_flow_a_start=R_m_flow_a_start,
      m_flow_b_start=R_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Return_pipe_data.D,
          length=Return_pipe_data.L,
          dheight=Return_pipe_data.dH,
          nV=Return_pipe_data.nV),
      redeclare model FlowModel = R_FlowModel,
      use_HeatTransfer=R_use_HeatTransfer,
      redeclare model HeatTransfer = R_HeatTransfer,
      redeclare model InternalHeatGen = R_InternalHeatGen)
      annotation (Placement(transformation(extent={{20,0},{-20,-40}})));

    replaceable NHES.Fluid.Machines.Pump_MassFlow Supply_pump(redeclare package
        Medium = S_Medium, use_input=false) if use_Supply_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(tab="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-80,60},{-60,80}})));

    replaceable NHES.Fluid.Machines.Pump_MassFlow Return_pump(redeclare package
        Medium = R_Medium, use_input=false) if use_Return_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(tab="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{80,-60},{60,-80}})));

    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,30},{-40,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,30},{60,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_out(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_in(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_out(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,30},{-70,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,30},{90,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_in(redeclare package Medium =
          R_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,-30},{90,-10}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder R_w_res[
      Return_pipe_data.nV](
      L=Return_pipe_data.L/Return_pipe_data.nV,
      r_in=(Return_pipe_data.D)/2,
      r_out=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      lambda=R_w_lambda) if R_use_wall_res
      annotation (Placement(transformation(extent={{-32,-64},{-12,-44}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder R_i_res[
      Return_pipe_data.nV](
      L=Return_pipe_data.L/Return_pipe_data.nV,
      r_in=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      r_out=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
          /2,
      lambda=R_i_lambda) if R_use_ins_res
      annotation (Placement(transformation(extent={{-72,-64},{-52,-44}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_i_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      lambda=S_i_lambda) if S_use_ins_res
      annotation (Placement(transformation(extent={{54,70},{74,50}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_w_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=Supply_pipe_data.D/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      lambda=S_w_lambda) if S_use_wall_res
      annotation (Placement(transformation(extent={{14,70},{34,50}})));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow R_wi[Return_pipe_data.nV]
      annotation (Placement(transformation(extent={{-52,-84},{-32,-64}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_wi[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{34,90},{54,70}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_it[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{74,90},{94,70}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow R_it[Return_pipe_data.nV]
      annotation (Placement(transformation(extent={{-92,-84},{-72,-64}}),
          iconVisible=false));

    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_wall[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=Supply_pipe_data.D/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      redeclare package Material = Sp_Material)
      if S_use_HeatTransfer and not S_use_wall_res
      annotation (Placement(transformation(extent={{14,70},{34,90}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_insulation[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      redeclare package Material = Si_Material)
      if S_use_HeatTransfer and not S_use_ins_res
      annotation (Placement(transformation(extent={{54,70},{74,90}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{154,50},{134,70}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
                                 if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{116,50},{96,70}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_cond[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{154,70},{134,90}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder R_pipe_wall[
      Return_pipe_data.nV](
      length=Return_pipe_data.L/Return_pipe_data.nV,
      r_inner=Return_pipe_data.D/2,
      r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      redeclare package Material = Rp_Material)
      if S_use_HeatTransfer and not R_use_wall_res
      annotation (Placement(transformation(extent={{-12,-84},{-32,-64}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder R_pipe_insulation[
      Return_pipe_data.nV](
      length=Return_pipe_data.L/Return_pipe_data.nV,
      r_inner=(Return_pipe_data.D + 2*Return_pipe_data.pth)/2,
      r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
          /2,
      redeclare package Material = Ri_Material)
      if S_use_HeatTransfer and not R_use_ins_res
      annotation (Placement(transformation(extent={{-52,-84},{-72,-64}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_conv[
      Supply_pipe_data.nV](T=R_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{-152,-64},{-132,-44}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      R_convection_constantArea_2DCyl(
      nNodes=Return_pipe_data.nV,
      r_outer=Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith,
      length=Return_pipe_data.L,
      alphas=R_alpha*ones(Return_pipe_data.nV))
                             if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{-112,-64},{-92,-44}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_cond[
      Return_pipe_data.nV](T=R_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{-152,-84},{-132,-64}})));
  //protected
    parameter Boolean S_with_Cond = true;
     //S_HTmode==HT_Mode.Cond;
    parameter Boolean S_with_Conv = false;
    //S_HTmode==HT_Mode.Conv;
    parameter Boolean R_with_Cond = true;
    //R_HTmode==HT_Mode.Cond;
    parameter Boolean R_with_Conv = false;
    //R_HTmode==HT_Mode.Conv;

  equation
      //connections
    if  use_Supply_pump then
      connect( port_a_S, Supply_pump.port_a);
      connect( Supply_pump.port_b, Supply.port_a);
    else
      connect(port_a_S, Supply.port_a);
    end if;
    if  use_Return_pump then
      connect( port_a_R, Return_pump.port_a);
      connect( Return_pump.port_b, Return.port_a);
    else
      connect(port_a_R, Return.port_a);
    end if;

    connect(Supply.port_b, port_b_S)
      annotation (Line(points={{20,20},{20,40},{100,40}},
                                                  color={0,127,255}));
    connect(Return.port_b, port_b_R)
      annotation (Line(points={{-20,-20},{-20,-40},{-100,-40}},
                                                      color={0,127,255}));
    connect(S_convection_constantArea_2DCyl.port_a, S_boundary_conv.port)
      annotation (Line(points={{117,60},{134,60}},color={127,0,0}));
    connect(Supply.heatPorts[:, 1], S_pipe_wall.port_a)
      annotation (Line(points={{0,30},{0,80},{14,80}},color={191,0,0}));
    connect(R_convection_constantArea_2DCyl.port_a, R_boundary_conv.port)
      annotation (Line(points={{-113,-54},{-132,-54}}, color={127,0,0}));
    connect(R_pipe_wall.port_a, Return.heatPorts[:, 1])
      annotation (Line(points={{-12,-74},{0,-74},{0,-30}},
                                                  color={191,0,0}));
    connect(Return.port_b, sensor_p_R_out.port) annotation (Line(points={{-20,-20},
            {-20,-40},{-50,-40},{-50,-30}},
                                  color={0,127,255}));
    connect(Return.port_b, sensor_T_R_out.port) annotation (Line(points={{-20,-20},
            {-20,-40},{-80,-40},{-80,-30}},           color={0,127,255}));
    connect(Supply.port_a, sensor_T_S_in.port) annotation (Line(points={{-20,20},{
            -20,30},{-80,30}},                   color={0,127,255}));
    connect(Supply.port_a, sensor_p_S_in.port)
      annotation (Line(points={{-20,20},{-20,30},{-50,30}}, color={0,127,255}));
    connect(Return.port_a, sensor_p_R_in.port)
      annotation (Line(points={{20,-20},{20,-30},{50,-30}}, color={0,127,255}));
    connect(Return.port_a, sensor_T_R_in.port) annotation (Line(points={{20,-20},{
            20,-30},{80,-30}},                   color={0,127,255}));
    connect(Supply.port_b, sensor_p_S_out.port)
      annotation (Line(points={{20,20},{20,40},{50,40},{50,30}},
                                                         color={0,127,255}));
    connect(Supply.port_b, sensor_T_S_out.port) annotation (Line(points={{20,20},{
            20,40},{80,40},{80,30}},         color={0,127,255}));
    connect(R_pipe_insulation.port_a, R_wi)
      annotation (Line(points={{-52,-74},{-42,-74}},   color={191,0,0}));
    connect(R_pipe_wall.port_b, R_wi)
      annotation (Line(points={{-32,-74},{-42,-74}},   color={191,0,0}));
    connect(R_i_res.port_b, R_wi) annotation (Line(points={{-55,-54},{-42,-54},{-42,
            -74}},  color={191,0,0}));
    connect(R_w_res.port_a, R_wi) annotation (Line(points={{-29,-54},{-42,-54},{-42,
            -74}},  color={191,0,0}));
    connect(R_w_res.port_b, Return.heatPorts[:, 1])
      annotation (Line(points={{-15,-54},{0,-54},{0,-30}},color={191,0,0}));
    connect(S_wi, S_pipe_insulation.port_a)
      annotation (Line(points={{44,80},{54,80}},   color={191,0,0}));
    connect(S_pipe_wall.port_b, S_wi)
      annotation (Line(points={{34,80},{44,80}},   color={191,0,0}));
    connect(S_w_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{17,60},{0,60},{0,30}},color={191,0,0}));
    connect(S_w_res.port_b, S_wi)
      annotation (Line(points={{31,60},{44,60},{44,80}},  color={191,0,0}));
    connect(S_i_res.port_a, S_wi)
      annotation (Line(points={{57,60},{44,60},{44,80}},  color={191,0,0}));
    connect(S_pipe_insulation.port_b, S_it)
      annotation (Line(points={{74,80},{84,80}},   color={191,0,0}));
    connect(S_i_res.port_b, S_it)
      annotation (Line(points={{71,60},{84,60},{84,80}},  color={191,0,0}));
    connect(S_convection_constantArea_2DCyl.port_b, S_it)
      annotation (Line(points={{95,60},{84,60},{84,80}},  color={127,0,0}));
    connect(S_it, S_boundary_cond.port)
      annotation (Line(
      points={{84,80},{134,80}},   color={191,0,0}));
    connect(R_pipe_insulation.port_b, R_it)
      annotation (Line(points={{-72,-74},{-82,-74}},   color={191,0,0}));
    connect(R_it, R_convection_constantArea_2DCyl.port_b) annotation (Line(points={{-82,-74},
            {-82,-54},{-91,-54}},            color={191,0,0}));
    connect(R_it, R_boundary_cond.port)
      annotation (Line(points={{-82,-74},{-132,-74}},   color={191,0,0}));
    connect(R_i_res.port_a, R_it) annotation (Line(points={{-69,-54},{-82,-54},{-82,
            -74}},  color={191,0,0}));
    connect(sensor_p_S_in.port, sensor_T_S_in.port)
      annotation (Line(points={{-50,30},{-80,30}}, color={0,127,255}));
    connect(actuatorBus.Return_Pump, Return_pump.inputSignal) annotation (Line(
        points={{30,100},{160,100},{160,-100},{70,-100},{70,-77.3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.Supply_Pump, Supply_pump.inputSignal) annotation (Line(
        points={{30,100},{160,100},{160,-100},{-160,-100},{-160,100},{-70,100},
            {-70,77.3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.S_T_in, sensor_T_S_in.T) annotation (Line(
        points={{-30,100},{-30,40},{-74,40},{-74,20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.S_p_in, sensor_p_S_in.p) annotation (Line(
        points={{-30,100},{-30,40},{-44,40},{-44,20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.S_T_out, sensor_T_S_out.T) annotation (Line(
        points={{-30,100},{-30,36},{86,36},{86,20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.S_p_out, sensor_p_S_out.p) annotation (Line(
        points={{-30,100},{-30,36},{56,36},{56,20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.R_T_out, sensor_T_R_out.T) annotation (Line(
        points={{-30,100},{-30,40},{-74,40},{-74,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.R_p_out, sensor_p_R_out.p) annotation (Line(
        points={{-30,100},{-30,40},{-44,40},{-44,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.R_p_in, sensor_p_R_in.p) annotation (Line(
        points={{-30,100},{-30,36},{56,36},{56,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.R_T_in, sensor_T_R_in.T) annotation (Line(
        points={{-30,100},{-30,36},{86,36},{86,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Rectangle(
            extent={{-100,36},{100,44}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,-44},{100,-36}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-90,34},{-50,74}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Rectangle(
            extent={{-70,34},{-34,46}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Ellipse(
            extent={{50,-74},{90,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Return_pump then true else false)),
          Rectangle(
            extent={{36,-46},{72,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Return_pump then true else false)),
          Line(
            points={{-40,-34},{-34,-24},{-44,-16},{-38,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-20,-34},{-14,-24},{-24,-16},{-18,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{0,-34},{6,-24},{-4,-16},{2,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,-34},{26,-24},{16,-16},{22,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-60,-34},{-54,-24},{-64,-16},{-58,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-80,-34},{-74,-24},{-84,-16},{-78,-4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-40,-46},{-34,-56},{-44,-64},{-38,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-20,-46},{-14,-56},{-24,-64},{-18,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{0,-46},{6,-56},{-4,-64},{2,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,-46},{26,-56},{16,-64},{22,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-60,-46},{-54,-56},{-64,-64},{-58,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{-80,-46},{-74,-56},{-84,-64},{-78,-76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=R_use_HeatTransfer),
          Line(
            points={{20,34},{26,24},{16,16},{22,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,34},{46,24},{36,16},{42,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,34},{66,24},{56,16},{62,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,34},{86,24},{76,16},{82,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,34},{6,24},{-4,16},{2,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,34},{-14,24},{-24,16},{-18,4}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{20,46},{26,56},{16,64},{22,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,46},{46,56},{36,64},{42,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,46},{66,56},{56,64},{62,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,46},{86,56},{76,64},{82,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,46},{6,56},{-4,64},{2,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,46},{-14,56},{-24,64},{-18,76}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Text(
            extent={{-100,-90},{100,-130}},
            textColor={28,108,200},
            textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end HeatTransport_withCS;

  model HeatTransport_Oneway
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_S(redeclare package Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_S(redeclare package
        Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(redeclare
        package Medium = S_Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel = S_FlowModel,
      use_HeatTransfer=S_use_HeatTransfer,
      redeclare model HeatTransfer = S_HeatTransfer,
      redeclare model InternalHeatGen = S_InternalHeatGen)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
        extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data);

      replaceable package S_Medium = Modelica.Media.Interfaces.PartialMedium "Supply Media"
      annotation (Dialog(group="Fluid Medium"),__Dymola_choicesAllMatching=true);

      replaceable model S_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Supply Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);

       //HT-----------------------------------------------------------------

               //supply
        import NHES.Systems.HeatTransport.BaseClasses.choices.HT_Mode;

      parameter Boolean S_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_wall_res=false "Use A Given Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_ins_res=false "Use A Given Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity S_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_wall_res and S_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity S_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_ins_res and S_use_HeatTransfer));
      replaceable package Sp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Wall Material properties" annotation (
        choicesAllMatching=true, Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_wall_res));
      replaceable package Si_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Insulation Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_ins_res));
     // parameter HT_Mode S_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
    //  annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer S_alpha=10 "External Supply Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature S_amb_T=303.15 "Supply Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      replaceable model S_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer), choicesAllMatching=true);
      replaceable model S_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Supply Internal heat generation" annotation (Dialog(
         tab="Heat Transfer",group="Supply Side"), choicesAllMatching=true);

      //init -----------------------------------------------------------------------

      parameter Modelica.Units.SI.AbsolutePressure S_p_a_start=S_Medium.p_default "Supply Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.AbsolutePressure S_p_b_start=S_Medium.p_default "Supply Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Boolean S_use_T_start=true "Use Initial Temperature for Supply Side" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.Temperature S_T_a_start=S_Medium.T_default "Supply Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.Temperature S_T_b_start=S_Medium.T_default "Supply Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_a_start=S_Medium.h_default "Supply Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_b_start=S_Medium.h_default "Supply Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_a_start=0 "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_b_start=-S_m_flow_a_start "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));

    //Pumps ---------------------------------------------------------------------
  //supply
    parameter Boolean use_Supply_pump=false "Use Supply Side Pump" annotation (Dialog(group="Pumps"),choices(checkBox=true));
    replaceable NHES.Fluid.Machines.Pump_MassFlow Supply_pump(redeclare package
        Medium = S_Medium, use_input=false) if use_Supply_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(group="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-80,10},{-60,30}})));
      parameter Boolean S_use_input=false "Use input for pump controls" annotation (Dialog(group="Pumps"),choices(checkBox=true));
    //return
        //sensors-------------------------------------------------------------------

    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,-20},{-40,-40}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,-20},{60,-40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,-20},{90,-40}})));
    Modelica.Blocks.Math.Add Supply_dp(k2=-1)
      annotation (Placement(transformation(extent={{140,-10},{160,10}})));
    Modelica.Blocks.Math.Add Supply_dt(k2=-1)
      annotation (Placement(transformation(extent={{140,-10},{160,-30}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_i_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      lambda=S_i_lambda) if S_use_ins_res
      annotation (Placement(transformation(extent={{40,40},{60,20}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_w_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=Supply_pipe_data.D/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      lambda=S_w_lambda) if S_use_wall_res
      annotation (Placement(transformation(extent={{0,40},{20,20}})));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_wi[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{20,60},{40,40}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_it[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{60,60},{80,40}}),
          iconVisible=false));
    Modelica.Blocks.Interfaces.RealInput S_u if S_use_input annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,50}), iconTransformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,50})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_wall[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=Supply_pipe_data.D/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      redeclare package Material = Sp_Material)
      if S_use_HeatTransfer and not S_use_wall_res
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_insulation[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      redeclare package Material = Si_Material)
      if S_use_HeatTransfer and not S_use_ins_res
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{140,20},{120,40}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
                                 if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{98,20},{78,40}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_cond[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{140,40},{120,60}})));

    parameter Boolean S_with_Cond = true;
     //S_HTmode==HT_Mode.Cond;
    parameter Boolean S_with_Conv = false;
    //S_HTmode==HT_Mode.Conv;

  equation
      //connections
    if  use_Supply_pump then
      connect( port_a_S, Supply_pump.port_a);
      connect( Supply_pump.port_b, Supply.port_a);
    else
      connect(port_a_S, Supply.port_a);
    end if;

    connect(Supply.port_b, port_b_S)
      annotation (Line(points={{40,0},{100,0}},   color={0,127,255}));
    connect(S_convection_constantArea_2DCyl.port_a, S_boundary_conv.port)
      annotation (Line(points={{99,30},{120,30}}, color={127,0,0}));
    connect(Supply.heatPorts[:, 1], S_pipe_wall.port_a)
      annotation (Line(points={{0,20},{0,50}},        color={191,0,0}));
    connect(Supply.port_a, sensor_T_S_in.port) annotation (Line(points={{-40,0},
            {-80,0},{-80,-20}},                  color={0,127,255}));
    connect(Supply.port_a, sensor_p_S_in.port)
      annotation (Line(points={{-40,0},{-50,0},{-50,-20}},  color={0,127,255}));
    connect(Supply.port_b, sensor_p_S_out.port)
      annotation (Line(points={{40,0},{50,0},{50,-20}},  color={0,127,255}));
    connect(Supply.port_b, sensor_T_S_out.port) annotation (Line(points={{40,0},{
            80,0},{80,-20}},                 color={0,127,255}));
    connect(sensor_p_S_in.p, Supply_dp.u1) annotation (Line(points={{-44,-30},{
            -44,-44},{130,-44},{130,6},{138,6}},
                                           color={0,0,127}));
    connect(sensor_p_S_out.p, Supply_dp.u2) annotation (Line(points={{56,-30},{
            66,-30},{66,-44},{130,-44},{130,-6},{138,-6}},
                                               color={0,0,127}));
    connect(sensor_T_S_in.T, Supply_dt.u1) annotation (Line(points={{-74,-30},{
            -64,-30},{-64,-44},{130,-44},{130,-26},{138,-26}},
                                                    color={0,0,127}));
    connect(sensor_T_S_out.T, Supply_dt.u2) annotation (Line(points={{86,-30},{
            86,-44},{130,-44},{130,-14},{138,-14}},
                                    color={0,0,127}));
    connect(S_wi, S_pipe_insulation.port_a)
      annotation (Line(points={{30,50},{40,50}},   color={191,0,0}));
    connect(S_pipe_wall.port_b, S_wi)
      annotation (Line(points={{20,50},{30,50}},   color={191,0,0}));
    connect(S_w_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{3,30},{3,26},{0,26},{0,20}},
                                                      color={191,0,0}));
    connect(S_w_res.port_b, S_wi)
      annotation (Line(points={{17,30},{17,50},{30,50}},  color={191,0,0}));
    connect(S_i_res.port_a, S_wi)
      annotation (Line(points={{43,30},{30,30},{30,50}},  color={191,0,0}));
    connect(S_pipe_insulation.port_b, S_it)
      annotation (Line(points={{60,50},{70,50}},   color={191,0,0}));
    connect(S_i_res.port_b, S_it)
      annotation (Line(points={{57,30},{70,30},{70,50}},  color={191,0,0}));
    connect(S_convection_constantArea_2DCyl.port_b, S_it)
      annotation (Line(points={{77,30},{70,30},{70,50}},  color={127,0,0}));
    connect(S_it, S_boundary_cond.port)
      annotation (Line(
      points={{70,50},{120,50}},   color={191,0,0}));
    connect(Supply_pump.inputSignal, S_u)
      annotation (Line(points={{-70,27.3},{-70,50}},  color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Rectangle(
            extent={{-100,-4},{100,4}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-90,-6},{-50,34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Rectangle(
            extent={{-70,-6},{-34,6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Line(
            points={{20,-6},{26,-16},{16,-24},{22,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,-6},{46,-16},{36,-24},{42,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,-6},{66,-16},{56,-24},{62,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,-6},{86,-16},{76,-24},{82,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,-6},{6,-16},{-4,-24},{2,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,-6},{-14,-16},{-24,-24},{-18,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{20,6},{26,16},{16,24},{22,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,6},{46,16},{36,24},{42,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,6},{66,16},{56,24},{62,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,6},{86,16},{76,24},{82,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,6},{6,16},{-4,24},{2,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,6},{-14,16},{-24,24},{-18,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Text(
            extent={{-100,-28},{100,-68}},
            textColor={28,108,200},
            textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end HeatTransport_Oneway;

  model HeatTransport_Oneway_withCS
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_S(redeclare package Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_S(redeclare package
        Medium =
          S_Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(redeclare
        package Medium = S_Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel = S_FlowModel,
      use_HeatTransfer=S_use_HeatTransfer,
      redeclare model HeatTransfer = S_HeatTransfer,
      redeclare model InternalHeatGen = S_InternalHeatGen)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
        extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data);

      replaceable package S_Medium = Modelica.Media.Interfaces.PartialMedium "Supply Media"
      annotation (Dialog(group="Fluid Medium"),__Dymola_choicesAllMatching=true);

      replaceable model S_FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.PartialDistributedStaggeredFlow
                                                  "Supply Flow model (i.e., momentum, pressure loss, wall friction)" annotation (Dialog(
          group="Pressure Loss"), choicesAllMatching=true);

       //HT-----------------------------------------------------------------

               //supply
        import NHES.Systems.HeatTransport.BaseClasses.choices.HT_Mode;

      parameter Boolean S_use_HeatTransfer=false "= true to use the HeatTransfer model"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_wall_res=false "Use A Given Thermal Resistance Instead of Material Model For Pipe Wall" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Boolean S_use_ins_res=false "Use A Given Thermal Resistance Instead of Material Model For Insulation" annotation (Dialog(tab="Heat Transfer",group="Supply Side"),choices(checkBox=true));
      parameter Modelica.Units.SI.ThermalConductivity S_w_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_wall_res and S_use_HeatTransfer));
      parameter Modelica.Units.SI.ThermalConductivity S_i_lambda=15 annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_ins_res and S_use_HeatTransfer));
      replaceable package Sp_Material = TRANSFORM.Media.Solids.SS304 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Wall Material properties" annotation (
        choicesAllMatching=true, Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_wall_res));
      replaceable package Si_Material =
        TRANSFORM.Media.Solids.FiberGlassGeneric                                 constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                              "Supply Pipe Insulation Material properties" annotation (
        choicesAllMatching=true,Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer and not S_use_ins_res));
    //  parameter HT_Mode S_HTmode =HT_Mode.Cond  "Heat Transfer Mode"
    //  annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer S_alpha=10 "External Supply Convective Heat Transfer Coefficient"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_HTmode==HT_Mode.Conv));
      parameter Modelica.Units.SI.Temperature S_amb_T=303.15 "Supply Side Ambient Temperature"
      annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer));
      replaceable model S_HeatTransfer =
        TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Ideal
      constrainedby
      TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.PartialHeatTransfer_setT
      "Coefficient of heat transfer" annotation (Dialog(tab="Heat Transfer",group="Supply Side",enable=S_use_HeatTransfer), choicesAllMatching=true);
      replaceable model S_InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
                                                       constrainedby
      TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.PartialInternalHeatGeneration
                                                  "Supply Internal heat generation" annotation (Dialog(
         tab="Heat Transfer",group="Supply Side"), choicesAllMatching=true);

      //init -----------------------------------------------------------------------

      parameter Modelica.Units.SI.AbsolutePressure S_p_a_start=S_Medium.p_default "Supply Port a Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.AbsolutePressure S_p_b_start=S_Medium.p_default "Supply Port b Initial Pressure" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Boolean S_use_T_start=true "Use Initial Temperature for Supply Side" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.Temperature S_T_a_start=S_Medium.T_default "Supply Port a Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.Temperature S_T_b_start=S_Medium.T_default "Supply Port b Initial Temperature" annotation (Dialog(tab="Initialization",group="Supply",enable=S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_a_start=S_Medium.h_default "Supply Port a Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.SpecificEnthalpy S_h_b_start=S_Medium.h_default "Supply Port b Initial Enthaply" annotation (Dialog(tab="Initialization",group="Supply",enable=not S_use_T_start));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_a_start=0 "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));
      parameter Modelica.Units.SI.MassFlowRate S_m_flow_b_start=-S_m_flow_a_start "Supply Port a Initial Mass Flow Rate" annotation (Dialog(tab="Initialization",group="Supply"));

    //Pumps ---------------------------------------------------------------------
  //supply
    parameter Boolean use_Supply_pump=false "Use Supply Side Pump" annotation (Dialog(group="Pumps"),choices(checkBox=true));
    replaceable NHES.Fluid.Machines.Pump_MassFlow Supply_pump(redeclare package
        Medium = S_Medium, use_input=true)  if use_Supply_pump constrainedby
      TRANSFORM.Fluid.Machines.BaseClasses.PartialPump_Simple annotation (
      Dialog(group="Pumps"),
      choicesAllMatching=true,
      Placement(transformation(extent={{-80,10},{-60,30}})));
      parameter Boolean S_use_input=false "Use input for pump controls" annotation (Dialog(group="Pumps"),choices(checkBox=true));
    //return
        //sensors-------------------------------------------------------------------

    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-60,-20},{-40,-40}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{40,-20},{60,-40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          S_Medium,                           precision=2)
      annotation (Placement(transformation(extent={{70,-20},{90,-40}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_i_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      lambda=S_i_lambda) if S_use_ins_res
      annotation (Placement(transformation(extent={{40,40},{60,20}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Cylinder S_w_res[
      Supply_pipe_data.nV](
      L=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_in=Supply_pipe_data.D/2,
      r_out=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      lambda=S_w_lambda) if S_use_wall_res
      annotation (Placement(transformation(extent={{0,40},{20,20}})));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_wi[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{20,60},{40,40}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow S_it[Supply_pipe_data.nV]
      annotation (Placement(transformation(extent={{60,60},{80,40}}),
          iconVisible=false));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_wall[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=Supply_pipe_data.D/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      redeclare package Material = Sp_Material)
      if S_use_HeatTransfer and not S_use_wall_res
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder S_pipe_insulation[
      Supply_pipe_data.nV](
      length=Supply_pipe_data.L/Supply_pipe_data.nV,
      r_inner=(Supply_pipe_data.D + 2*Supply_pipe_data.pth)/2,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      redeclare package Material = Si_Material)
      if S_use_HeatTransfer and not S_use_ins_res
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{140,20},{120,40}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
                                 if S_use_HeatTransfer and S_with_Conv
      annotation (Placement(transformation(extent={{98,20},{78,40}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_cond[
      Supply_pipe_data.nV](T=S_amb_T) if S_use_HeatTransfer and S_with_Cond
      annotation (Placement(transformation(extent={{140,40},{120,60}})));

    parameter Boolean S_with_Cond = true;
     //S_HTmode==HT_Mode.Cond;
    parameter Boolean S_with_Conv = false;
    //S_HTmode==HT_Mode.Conv;

  equation
      //connections
    if  use_Supply_pump then
      connect( port_a_S, Supply_pump.port_a);
      connect( Supply_pump.port_b, Supply.port_a);
    else
      connect(port_a_S, Supply.port_a);
    end if;

    connect(Supply.port_b, port_b_S)
      annotation (Line(points={{40,0},{100,0}},   color={0,127,255}));
    connect(S_convection_constantArea_2DCyl.port_a, S_boundary_conv.port)
      annotation (Line(points={{99,30},{120,30}}, color={127,0,0}));
    connect(Supply.heatPorts[:, 1], S_pipe_wall.port_a)
      annotation (Line(points={{0,20},{0,50}},        color={191,0,0}));
    connect(Supply.port_a, sensor_T_S_in.port) annotation (Line(points={{-40,0},
            {-80,0},{-80,-20}},                  color={0,127,255}));
    connect(Supply.port_a, sensor_p_S_in.port)
      annotation (Line(points={{-40,0},{-50,0},{-50,-20}},  color={0,127,255}));
    connect(Supply.port_b, sensor_p_S_out.port)
      annotation (Line(points={{40,0},{50,0},{50,-20}},  color={0,127,255}));
    connect(Supply.port_b, sensor_T_S_out.port) annotation (Line(points={{40,0},{
            80,0},{80,-20}},                 color={0,127,255}));
    connect(S_wi, S_pipe_insulation.port_a)
      annotation (Line(points={{30,50},{40,50}},   color={191,0,0}));
    connect(S_pipe_wall.port_b, S_wi)
      annotation (Line(points={{20,50},{30,50}},   color={191,0,0}));
    connect(S_w_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{3,30},{3,26},{0,26},{0,20}},
                                                      color={191,0,0}));
    connect(S_w_res.port_b, S_wi)
      annotation (Line(points={{17,30},{17,50},{30,50}},  color={191,0,0}));
    connect(S_i_res.port_a, S_wi)
      annotation (Line(points={{43,30},{30,30},{30,50}},  color={191,0,0}));
    connect(S_pipe_insulation.port_b, S_it)
      annotation (Line(points={{60,50},{70,50}},   color={191,0,0}));
    connect(S_i_res.port_b, S_it)
      annotation (Line(points={{57,30},{70,30},{70,50}},  color={191,0,0}));
    connect(S_convection_constantArea_2DCyl.port_b, S_it)
      annotation (Line(points={{77,30},{70,30},{70,50}},  color={127,0,0}));
    connect(S_it, S_boundary_cond.port)
      annotation (Line(
      points={{70,50},{120,50}},   color={191,0,0}));
    connect(actuatorBus.Supply_Pump, Supply_pump.inputSignal) annotation (Line(
        points={{30,100},{30,64},{-70,64},{-70,27.3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.S_T_in, sensor_T_S_in.T) annotation (Line(
        points={{-30,100},{-120,100},{-120,-100},{-68,-100},{-68,-30},{-74,-30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(sensorBus.S_p_in, sensor_p_S_in.p) annotation (Line(
        points={{-30,100},{-120,100},{-120,-100},{-40,-100},{-40,-30},{-44,-30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(sensorBus.S_p_out, sensor_p_S_out.p) annotation (Line(
        points={{-30,100},{-120,100},{-120,-100},{60,-100},{60,-30},{56,-30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.S_T_out, sensor_T_S_out.T) annotation (Line(
        points={{-30,100},{-120,100},{-120,-100},{92,-100},{92,-30},{86,-30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true), graphics={
          Rectangle(
            extent={{-100,-4},{100,4}},
            lineColor={238,46,47},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-90,-6},{-50,34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Rectangle(
            extent={{-70,-6},{-34,6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            visible=DynamicSelect(true, if use_Supply_pump then true else false)),
          Line(
            points={{20,-6},{26,-16},{16,-24},{22,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,-6},{46,-16},{36,-24},{42,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,-6},{66,-16},{56,-24},{62,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,-6},{86,-16},{76,-24},{82,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,-6},{6,-16},{-4,-24},{2,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,-6},{-14,-16},{-24,-24},{-18,-36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{20,6},{26,16},{16,24},{22,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{40,6},{46,16},{36,24},{42,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{60,6},{66,16},{56,24},{62,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{80,6},{86,16},{76,24},{82,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{0,6},{6,16},{-4,24},{2,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Line(
            points={{-20,6},{-14,16},{-24,24},{-18,36}},
            color={238,46,47},
            smooth=Smooth.Bezier,
            arrow={Arrow.None,Arrow.Filled},
            thickness=1,
            visible=S_use_HeatTransfer),
          Text(
            extent={{-100,-28},{100,-68}},
            textColor={28,108,200},
            textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end HeatTransport_Oneway_withCS;

  package data

    model pipe_data_1
      extends BaseClasses.Record_Data;
      import Modelica.Fluid.Types.Dynamics;
            //Geometery ---------------------------------------------------------
        parameter Modelica.Units.SI.Length L=100 "Supply Pipe Length" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Diameter D=0.25
                                                   "Inner Diameter Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Thickness pth=0.1  "Thickness Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Thickness ith=0.1  "Thickness Of Supply Pipe Insulation" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Integer nV(min=2) =10  "Number Of Volume Nodes In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Height dH=0 "Elevation Gain In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end pipe_data_1;
  end data;

  package BaseClasses
    partial model Partial_SubSystem

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable Partial_ControlSystem CS annotation (
          choicesAllMatching=true, Placement(transformation(extent={{-18,122},{
                -2,138}})));
      replaceable Partial_EventDriver ED annotation (
          choicesAllMatching=true, Placement(transformation(extent={{2,122},{18,
                138}})));

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus annotation (
          Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));

    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;
      extends TRANSFORM.Icons.BasesPackage;

    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput                           sensorBus annotation (
          Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus annotation (
          Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    package choices
      type HT_Mode = enumeration(
            Cond "Conduction",
            Conv "Convection") "Enumeration defining Heat Transfer Modes"
                                                     annotation (Evaluate=true);
    end choices;

    model Partial_SubSystem_A
      extends Partial_SubSystem;
      replaceable BaseClasses.Record_Data Supply_pipe_data
        annotation (Placement(transformation(extent={{60,122},{76,138}})));
      replaceable BaseClasses.Record_Data Return_pipe_data
        annotation (Placement(transformation(extent={{82,122},{98,138}})));
    end Partial_SubSystem_A;

    model Partial_SubSystem_B
      extends Partial_SubSystem;
      replaceable BaseClasses.Record_Data Supply_pipe_data
        annotation (Placement(transformation(extent={{60,122},{76,138}})));
    end Partial_SubSystem_B;
  end BaseClasses;

  package Examples
      extends Modelica.Icons.ExamplesPackage;
    model HTtest
      extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-114,-38},{-94,-18}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=323.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-132,18},{-112,38}})));
      NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
        redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
        p_start_shell=103350,
        h_start_shell_inlet=2E5,
        h_start_shell_outlet=9E4,
        dp_init_shell=500,
        m_start_shell=50)
        annotation (Placement(transformation(extent={{138,-2},{158,18}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{94,40},{114,60}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T
                                                     boundary4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=50,
        T=283.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{246,38},{226,58}})));
      HeatTransport heatTransport(
        Supply_pipe_data(D=0.25),
        Return_pipe_data(D=0.25),
        redeclare package S_Medium = Modelica.Media.Water.StandardWater,
        redeclare package R_Medium = Modelica.Media.Water.StandardWater,
        S_use_HeatTransfer=true,
        S_use_wall_res=true,
        S_use_ins_res=true,
        R_use_HeatTransfer=true,
        R_use_wall_res=true,
        R_use_ins_res=true,
        S_p_a_start=200000,
        S_p_b_start=160000,
        S_T_a_start=323.15,
        S_T_b_start=318.15,
        S_m_flow_a_start=50,
        R_p_a_start=150000,
        R_p_b_start=100000,
        R_T_a_start=283.15,
        R_T_b_start=284.15,
        R_m_flow_a_start=50,
        use_Supply_pump=true,
        Supply_pump(m_flow_nominal=50))
        annotation (Placement(transformation(extent={{-38,-20},{20,38}})));
    equation
      connect(boundary4.ports[1], nTU_HX_SinglePhase.Tube_in) annotation (Line(
            points={{226,48},{164,48},{164,12},{158,12}}, color={0,127,255}));
      connect(nTU_HX_SinglePhase.Tube_out, boundary3.ports[1]) annotation (Line(
            points={{138,12},{124,12},{124,50},{114,50}}, color={0,127,255}));
      connect(boundary2.ports[1], heatTransport.port_a_S) annotation (Line(points={{
              -112,28},{-48,28},{-48,20.6},{-38,20.6}}, color={0,127,255}));
      connect(heatTransport.port_b_S, nTU_HX_SinglePhase.Shell_in) annotation (Line(
            points={{20,20.6},{122,20.6},{122,6},{138,6}}, color={0,127,255}));
      connect(nTU_HX_SinglePhase.Shell_out, heatTransport.port_a_R) annotation (
          Line(points={{158,6},{164,6},{164,-8},{30,-8},{30,-2.02},{20,-2.02}},
            color={0,127,255}));
      connect(heatTransport.port_b_R, boundary1.ports[1]) annotation (Line(points={{
              -38,-2.6},{-88,-2.6},{-88,-28},{-94,-28}}, color={0,127,255}));
      annotation (experiment(
          StopTime=1000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest;

    model HTtest2
      extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-114,-38},{-94,-18}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-86,28},{-66,48}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-82,-32},{-62,-12}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-132,20},{-112,40}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-90,50},{-50,98}})));
      HeatTransport_Oneway heatTransport_Oneway(
        Supply_pipe_data(D=0.5),
        redeclare package S_Medium = Modelica.Media.Water.StandardWater,
        S_use_HeatTransfer=true,
        use_Supply_pump=true)
        annotation (Placement(transformation(extent={{-34,-50},{70,54}})));
    equation
      connect(boundary1.ports[1], sensor_p1.port) annotation (Line(points={{-94,
              -28},{-88,-28},{-88,-32},{-72,-32}}, color={0,127,255}));
      connect(boundary2.ports[1], sensor_p.port) annotation (Line(points={{-112,
              30},{-88,30},{-88,28},{-76,28}}, color={0,127,255}));
      connect(sensor_p.port, sensor_m_flow.port_a) annotation (Line(points={{-76,28},
              {-76,26},{-88,26},{-88,30},{-100,30},{-100,74},{-90,74}},   color={
              0,127,255}));
      connect(sensor_p.port, heatTransport_Oneway.port_a_S) annotation (Line(
            points={{-76,28},{-76,2},{-34,2}},       color={0,127,255}));
      connect(sensor_p1.port, heatTransport_Oneway.port_b_S) annotation (Line(
            points={{-72,-32},{-72,-56},{78,-56},{78,2},{70,2}},       color={0,127,
              255}));
      annotation (experiment(
          StopTime=10000,
          Interval=10,
          __Dymola_Algorithm="Dassl"));
    end HTtest2;

    model HTtest3
      extends Modelica.Icons.Example;
      package Medium = Modelica.Media.IdealGases.SingleGases.He;
      HeatTransport heatTransport(
        Return_pipe_data(D=1, ith=1),
        redeclare package S_Medium = Modelica.Media.IdealGases.SingleGases.He,
        redeclare package R_Medium = Modelica.Media.IdealGases.SingleGases.He,
        S_use_HeatTransfer=true,
        S_use_wall_res=false,
        S_use_ins_res=false,
        S_amb_T=573.15,
        R_use_HeatTransfer=true,
        R_use_wall_res=false,
        R_use_ins_res=false,
        R_amb_T=573.15,
        S_p_a_start=5940000,
        S_p_b_start=5900000,
        S_use_T_start=false,
        S_h_a_start=5.7E6,
        S_h_b_start=5.7E6,
        S_m_flow_a_start=300,
        R_p_a_start=6100000,
        R_p_b_start=6000000,
        R_T_a_start=623.15,
        R_T_b_start=623.15,
        R_m_flow_a_start=300,
        use_Supply_pump=false,
        Supply_pump(m_flow_nominal=50))
        annotation (Placement(transformation(extent={{-198,-18},{-140,40}})));
      NHES.Systems.BalanceOfPlant.BraytonCycle.Brayton_Cycle
                    brayton_Cycle(redeclare replaceable
          NHES.Systems.BalanceOfPlant.BraytonCycle.Data.Data_BC_Test data(
          K_P_Release(unit="1/(m.kg)") = 10000,
          HX_Aux_K_tube(unit="1/m4"),
          HX_Aux_K_shell(unit="1/m4"),
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          HX_Reheat_K_tube(unit="1/m4"),
          HX_Reheat_K_shell(unit="1/m4")), redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-40,-20},{40,60}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary(
        p=5940000,
        T=1123.15,
        redeclare package Medium = Medium,
        nPorts=1)
        annotation (Placement(transformation(extent={{-252,18},{-232,38}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary5(
        p=6000000,
        redeclare package Medium = Medium,
        T=623.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-254,-18},{-234,2}})));
      NHES.Systems.ElectricalGrid.InfiniteGrid.Infinite
                                           EG
        annotation (Placement(transformation(extent={{80,-20},{160,60}})));
    equation
      connect(brayton_Cycle.port_a1,EG. portElec_a)
        annotation (Line(points={{38.8,20.4},{59.4,20.4},{59.4,20},{80,20}},
                                                       color={255,0,0}));
      connect(boundary.ports[1], heatTransport.port_a_S) annotation (Line(points={{-232,28},
              {-217,28},{-217,22.6},{-198,22.6}},     color={0,127,255}));
      connect(heatTransport.port_b_S, brayton_Cycle.port_a) annotation (Line(points={{-140,
              22.6},{-46,22.6},{-46,37.2},{-38.8,37.2}},       color={0,127,255}));
      connect(brayton_Cycle.port_b, heatTransport.port_a_R) annotation (Line(points={{-38.8,6},
              {-134,6},{-134,-0.02},{-140,-0.02}},         color={0,127,255}));
      connect(heatTransport.port_b_R, boundary5.ports[1]) annotation (Line(points={{-198,
              -0.6},{-228,-0.6},{-228,-8},{-234,-8}},    color={0,127,255}));
      annotation (experiment(
          StopTime=100,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest3;

    model HTtest4
      extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Air.MoistAir,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-102,-14},{-82,6}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = Modelica.Media.Air.MoistAir,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
      NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
        redeclare package Shell_medium = Modelica.Media.Air.MoistAir,
        use_T_start_tube=true,
        T_start_tube_inlet=423.15,
        T_start_tube_outlet=423.15,
        p_start_shell=103350,
        use_T_start_shell=true,
        T_start_shell_inlet=573.15,
        T_start_shell_outlet=573.15,
        h_start_shell_inlet=2E5,
        h_start_shell_outlet=9E4,
        dp_init_shell=500,
        m_start_shell=50)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=90,
            origin={58,8})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=100000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{104,22},{84,42}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T
                                                     boundary4(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=50,
        T=473.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{102,-22},{82,-2}})));
      HeatTransport heatTransport_withCS(
        Supply_pipe_data(L=1000, D=0.25),
        Return_pipe_data(D=0.25),
        redeclare package S_Medium = Modelica.Media.Air.MoistAir,
        redeclare package R_Medium = Modelica.Media.Air.MoistAir,
        S_use_HeatTransfer=true,
        S_use_wall_res=true,
        S_use_ins_res=true,
        S_alpha=10,
        R_use_HeatTransfer=true,
        R_use_wall_res=true,
        R_use_ins_res=true,
        R_alpha=10,
        S_p_a_start=200000,
        S_p_b_start=160000,
        S_T_a_start=573.15,
        S_T_b_start=573.15,
        S_m_flow_a_start=50,
        R_p_a_start=150000,
        R_p_b_start=100000,
        R_T_a_start=573.15,
        R_T_b_start=573.15,
        R_m_flow_a_start=50,
        use_Supply_pump=true,
        Supply_pump(m_flow_nominal=50),
        S_with_Cond=false,
        S_with_Conv=true,
        R_with_Cond=false,
        R_with_Conv=true)
        annotation (Placement(transformation(extent={{-40,-20},{18,38}})));
    equation
      connect(boundary4.ports[1], nTU_HX_SinglePhase.Tube_in) annotation (Line(
            points={{82,-12},{62,-12},{62,-2}},           color={0,127,255}));
      connect(nTU_HX_SinglePhase.Tube_out, boundary3.ports[1]) annotation (Line(
            points={{62,18},{62,32},{84,32}},             color={0,127,255}));
      connect(boundary2.ports[1], heatTransport_withCS.port_a_S) annotation (Line(
            points={{-80,22},{-48,22},{-48,20.6},{-40,20.6}},  color={0,127,255}));
      connect(heatTransport_withCS.port_b_S, nTU_HX_SinglePhase.Shell_in)
        annotation (Line(points={{18,20.6},{38,20.6},{38,18},{56,18}},  color={0,127,
              255}));
      connect(nTU_HX_SinglePhase.Shell_out, heatTransport_withCS.port_a_R)
        annotation (Line(points={{56,-2},{56,-2.02},{18,-2.02}},
            color={0,127,255}));
      connect(heatTransport_withCS.port_b_R, boundary1.ports[1]) annotation (Line(
            points={{-40,-2.6},{-40,-4},{-82,-4}},              color={0,127,255}));
      annotation (experiment(
          StopTime=1000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest4;

    model HTtest6
      extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Medium,
        p=100000,
        T=T_out,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-22},{-80,-2}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = Medium,
        p=100000,
        T=T_in,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,2},{-80,22}})));
      HeatTransport heatTransport(
        redeclare package S_Medium = Medium,
        redeclare package R_Medium = Medium,
        S_use_HeatTransfer=true,
        S_use_wall_res=false,
        S_use_ins_res=false,
        R_use_HeatTransfer=true,
        R_use_wall_res=false,
        R_use_ins_res=false,
        S_p_a_start=200000,
        S_p_b_start=160000,
        S_T_a_start=T_in,
        S_T_b_start=T_in,
        S_m_flow_a_start=50,
        R_p_a_start=150000,
        R_p_b_start=100000,
        R_T_a_start=T_out,
        R_T_b_start=T_out,
        R_m_flow_a_start=50,
        use_Supply_pump=true,
        Supply_pump(m_flow_nominal=50),
        S_with_Cond=false,
        S_with_Conv=true,
        R_with_Cond=false,
        R_with_Conv=true)
        annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Medium,
        p_start=100000,
        T_start=T_out,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=1),
        use_HeatPort=true)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={60,0})));
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation (choicesAllMatching=true);
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
        boundary(T=T_out)
        annotation (Placement(transformation(extent={{106,-10},{86,10}})));
      parameter Modelica.Media.Interfaces.Types.Temperature T_in=363.15
        "Fixed value of temperature";
      parameter Modelica.Media.Interfaces.Types.Temperature T_out=303.15
        "Fixed value of temperature";
    equation
      connect(boundary2.ports[1], heatTransport.port_a_S) annotation (Line(
          points={{-80,12},{-30,12}},
          color={0,127,255},
          thickness=1));
      connect(heatTransport.port_b_R, boundary1.ports[1]) annotation (Line(
          points={{-30,-12},{-80,-12}},
          color={0,127,255},
          thickness=1));
      connect(heatTransport.port_a_R, volume.port_a) annotation (Line(
          points={{30,-11.4},{60,-11.4},{60,-6}},
          color={0,127,255},
          thickness=1));
      connect(volume.port_b, heatTransport.port_b_S) annotation (Line(
          points={{60,6},{60,12},{30,12}},
          color={0,127,255},
          thickness=1));
      connect(boundary.port, volume.heatPort) annotation (Line(points={{86,0},{
              76,0},{76,-3.88578e-16},{66,-3.88578e-16}},
                                                color={191,0,0},
          thickness=1));
      annotation (experiment(
          StopTime=1000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest6;

    model HTtest7
      extends Modelica.Icons.Example;
      parameter Integer nHT=5;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=500000,
        T=373.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{102,-10},{82,10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=500000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      HeatTransport_Oneway heatTransport_Oneway[nHT](
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=500,
          D=0.75,
          pth=0.05,
          nV=5),
        redeclare package S_Medium = Modelica.Media.Water.StandardWater,
        redeclare model S_FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        S_use_HeatTransfer=true,
        S_p_a_start=2500000,
        S_p_b_start=2500000,
        S_T_a_start=573.15,
        S_T_b_start=533.15,
        S_m_flow_a_start=10,
        use_Supply_pump=true,
        Supply_pump(m_flow_nominal=20, eta=1000))
        annotation (Placement(transformation(extent={{-26,-20},{14,20}})));
      TRANSFORM.Fluid.TemporaryBlock_Fluid temporary
        annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
      TRANSFORM.Fluid.TemporaryBlock_Fluid temporary1
        annotation (Placement(transformation(extent={{42,-10},{62,10}})));
    equation
      connect(boundary2.ports[1], temporary.port_a)
        annotation (Line(points={{-80,0},{-65,0}}, color={0,127,255}));
      connect(temporary.port_b, heatTransport_Oneway[1].port_a_S)
        annotation (Line(points={{-51,0},{-26,0}}, color={0,127,255}));
      connect(temporary1.port_a, heatTransport_Oneway[nHT].port_b_S)
        annotation (Line(points={{45,0},{14,0}}, color={0,127,255}));
      connect(temporary1.port_b, boundary1.ports[1])
        annotation (Line(points={{59,0},{82,0}}, color={0,127,255}));
      connect(heatTransport_Oneway[2:nHT].port_a_S, heatTransport_Oneway[1:nHT - 1].port_b_S)
        annotation (Line(points={{-26,0},{14,0}}, color={0,127,255}));
      annotation (experiment(
          StopTime=10000,
          Interval=100,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest7;
  end Examples;

  package ControlSystems
    model CS_Dummy

      extends BaseClasses.Partial_ControlSystem;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Dummy;

    model ED_Dummy

      extends
        NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Partial_EventDriver;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end ED_Dummy;
  end ControlSystems;

  model steamTransport
    extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data);

      parameter Real  K= 1
                          "Local Loss Coe";
      parameter Integer nV=3 "nodes";
    parameter Modelica.Units.SI.MassFlowRate mFlow=1 "system mass flow rate";
    parameter Modelica.Units.SI.AbsolutePressure p_sink=1e5
      "sink pressure";
    parameter Modelica.Units.SI.SpecificEnthalpy h_source=1000e3
      "inlet specific enthalpy";


    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe[Supply_pipe_data.nV](
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_Ts_start=false,
      p_a_start=p_sink,
      h_a_start=h_source,
      h_b_start=h_source,
      m_flow_a_start=mFlow,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h source(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      use_h_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph sink(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=true,
      use_h_in=false,
      nPorts=1)
      annotation (Placement(transformation(extent={{120,-10},{100,10}})));


    Modelica.Blocks.Sources.RealExpression realExpression(y=mFlow)
      annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=h_source)
      annotation (Placement(transformation(extent={{-160,-20},{-140,0}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=p_sink)
      annotation (Placement(transformation(extent={{160,0},{140,20}})));
    TRANSFORM.Fluid.TemporaryBlock_Fluid temporary(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    Fluid.FittingsAndResistances.LocalLoss resistance[Supply_pipe_data.nV](
        redeclare package Medium = Modelica.Media.Water.StandardWater, Ax=pi*(
          Supply_pipe_data.D^2)/4)
      annotation (Placement(transformation(extent={{28,-10},{48,10}})));
    TRANSFORM.Fluid.TemporaryBlock_Fluid temporary1(redeclare package Medium =
          Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  equation

    connect(realExpression1.y, source.h_in) annotation (Line(points={{-139,-10},{-130,
            -10},{-130,4},{-122,4}}, color={0,0,127}));
    connect(realExpression2.y, sink.p_in) annotation (Line(points={{139,10},{130,10},
            {130,8},{122,8}}, color={0,0,127}));
    connect(realExpression.y, source.m_flow_in)
      annotation (Line(points={{-139,10},{-139,8},{-120,8}}, color={0,0,127}));


    connect(source.ports[1], temporary.port_a)
      annotation (Line(points={{-100,0},{-65,0}}, color={0,127,255}));
    connect(temporary.port_b, pipe[1].port_a)
      annotation (Line(points={{-51,0},{-20,0}}, color={0,127,255}));
    connect(pipe.port_b, resistance.port_a)
      annotation (Line(points={{20,0},{31,0}}, color={0,127,255}));
    connect(resistance[Supply_pipe_data.nV].port_b, temporary1.port_a)
      annotation (Line(points={{45,0},{60,0}}, color={0,127,255}));
    connect(temporary1.port_b, sink.ports[1])
      annotation (Line(points={{75,0},{100,0}}, color={0,127,255}));
    connect(resistance[1:Supply_pipe_data.nV - 1].port_b, pipe[2:Supply_pipe_data.nV].port_a)
      annotation (Line(points={{45,0},{12.5,0},{12.5,-2},{-20,-2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end steamTransport;
  annotation (            Icon(graphics={
        Rectangle(
          extent={{-70,-30},{30,40}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{-60,-40},{-40,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-30},{72,-30},{72,-2},{50,24},{38,24},{30,24},{30,24},{30,
              -30}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{40,-40},{60,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{44,20},{44,-2},{66,-2}},
          color={0,0,0},
          thickness=1),          Bitmap(extent={{-70,-20},{28,34}},   fileName="modelica://NHES/Resources/Images/Systems/Fire.jpg")}));
end HeatTransport;
