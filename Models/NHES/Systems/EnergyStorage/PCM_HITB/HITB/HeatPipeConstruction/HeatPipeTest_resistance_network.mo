within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model HeatPipeTest_resistance_network
  //Steel
  parameter SI.Density rho_steel = 7740.0;
  parameter SI.SpecificHeatCapacityAtConstantPressure cp_steel = 571.1;
  parameter SI.ThermalConductivity k_steel = 21.5;
  //Sodium
  parameter SI.Density rho_na = 760.0;
  parameter SI.SpecificHeatCapacityAtConstantPressure cp_na = 1257;
  parameter SI.ThermalConductivity k_na = 61.4;
  //Aluminum
  parameter SI.Density rho_Al = 2700;
  parameter SI.SpecificHeatCapacityAtConstantPressure cp_Al = 921.1;
  parameter SI.ThermalConductivity k_Al = 220.0;
  //Euctectic (43.1% MgCl_2 56.9% NaCl)
  parameter SI.Density rho_wf = 2229;
  parameter SI.SpecificHeatCapacityAtConstantPressure cp_wf = 863.3;
  parameter SI.ThermalConductivity k_wf = 0.3;
  parameter SI.SpecificEnergy H_wf = 333e3;

  parameter Real porosity = 0.7;
  //Wick Properties
  SI.Density rho_effwick = porosity*rho_na + (1-porosity)*rho_steel;
  SI.SpecificHeatCapacityAtConstantPressure cp_effwick = porosity*cp_na + (1-porosity)*cp_steel;

  //Geometry of the Unit
  //Guide Tube
  parameter SI.Length D_guidetube_outer = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(2.875);
  parameter SI.Length D_guidetube_inner = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(2.469);
  SI.Length thickness = (D_guidetube_outer - D_guidetube_inner)/2.0;

  //Heat Pipe
  parameter SI.Length D_HeatPipe_outer = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(1.9);
  parameter SI.Length D_HeatPipe_inner = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(1.61);
  parameter SI.Length L_heatpipe = 1.5;
  parameter SI.Length L_E = 0.45;
  parameter SI.Length L_C = 0.45;
  parameter SI.Length L_A = 0.45;
  parameter SI.Length L_tes = 0.6;

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D wick_heater(
    redeclare package Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_inner - 0.00045,
        r_outer(displayUnit="mm") = Heat_pipewall_heater.geometry.r_inner,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-50,48},{-30,68}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    Heat_pipewall_heater(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.02045,
        r_outer=0.024,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-14,48},{6,68}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    GuideTube_Heater(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.03136,
        r_outer=0.03651,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{58,48},{78,68}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    Interface_heater(
    redeclare package Material = TRANSFORM.Media.Solids.Helium,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_outer,
        r_outer=GuideTube_Heater.geometry.r_inner,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{22,48},{42,68}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D wick_adiabatic(
    redeclare package Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a1=false,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_inner - 0.00045,
        r_outer(displayUnit="mm") = Heat_pipewall_heater.geometry.r_inner,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-50,4},{-30,24}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    heat_pipewall_adiabatic(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.02045,
        r_outer=0.024,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-14,4},{6,24}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    Guidetube_Adiabatic(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.03136,
        r_outer=0.03651,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{58,4},{78,24}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    Interface_adiabatic(
    redeclare package Material = TRANSFORM.Media.Solids.Helium,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_outer,
        r_outer=GuideTube_Heater.geometry.r_inner,
        length_z=0.45),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{22,4},{42,24}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D wick_storage(
    redeclare package Material = PCM_Materials.Lambda_wick_d_5000_cp_1000,
    exposeState_a1=false,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_inner - 0.00045,
        r_outer(displayUnit="mm") = Heat_pipewall_heater.geometry.r_inner,
        length_z=L_tes),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-50,-42},{-30,-22}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    heat_pipe_wall_storage(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.02045,
        r_outer=0.024,
        length_z=L_tes),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{-14,-40},{6,-20}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    GuideTube_Storage(
    redeclare package Material = TRANSFORM.Media.Solids.SS316,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=0.03136,
        r_outer=0.03651,
        length_z=L_tes),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{58,-40},{78,-20}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D
    Interface_Storage(
    redeclare package Material = TRANSFORM.Media.Solids.Helium,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        r_inner=Heat_pipewall_heater.geometry.r_outer,
        r_outer=GuideTube_Heater.geometry.r_inner,
        length_z=L_tes),
    redeclare model ConductionModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.ForwardDifference_1O)
    annotation (Placement(transformation(extent={{22,-40},{42,-20}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,100})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-6,100})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic2 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={30,100})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic3 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={68,100})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic4 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-38,-66})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic5 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-66})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic6 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,-66})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic7 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-66})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow_multi Heater(Q_flow(
        displayUnit="kW") = {1000})
    annotation (Placement(transformation(extent={{124,48},{104,68}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    adiabatic11 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={114,14})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
    phase_change annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={142,-30})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder simpleWall(
    length=L_tes,
    r_inner=GuideTube_Storage.geometry.r_outer,
    r_outer=0.5,
    redeclare package Material =
        TRANSFORM.Media.Solids.CustomSolids.Lambda_0_33_d_1200_cp_500,
    exposeState_a=true,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{96,-40},{116,-20}})));
equation

  connect(wick_heater.port_a2, wick_adiabatic.port_b2)
    annotation (Line(points={{-40,48},{-40,24}}, color={191,0,0}));
  connect(Heat_pipewall_heater.port_a2, heat_pipewall_adiabatic.port_b2)
    annotation (Line(points={{-4,48},{-4,24}}, color={191,0,0}));
  connect(Interface_heater.port_a2, Interface_adiabatic.port_b2)
    annotation (Line(points={{32,48},{32,24}}, color={191,0,0}));
  connect(GuideTube_Heater.port_a2, Guidetube_Adiabatic.port_b2)
    annotation (Line(points={{68,48},{68,24}}, color={191,0,0}));
  connect(wick_adiabatic.port_a2, wick_storage.port_b2)
    annotation (Line(points={{-40,4},{-40,-22}}, color={191,0,0}));
  connect(heat_pipewall_adiabatic.port_a2, heat_pipe_wall_storage.port_b2)
    annotation (Line(points={{-4,4},{-4,-20}}, color={191,0,0}));
  connect(Interface_adiabatic.port_a2, Interface_Storage.port_b2)
    annotation (Line(points={{32,4},{32,-20}}, color={191,0,0}));
  connect(Guidetube_Adiabatic.port_a2, GuideTube_Storage.port_b2)
    annotation (Line(points={{68,4},{68,-20}}, color={191,0,0}));
  connect(adiabatic.port, wick_heater.port_b2)
    annotation (Line(points={{-40,90},{-40,68}}, color={191,0,0}));
  connect(adiabatic1.port, Heat_pipewall_heater.port_b2) annotation (Line(
        points={{-6,90},{-6,72},{-4,72},{-4,68}}, color={191,0,0}));
  connect(adiabatic2.port, Interface_heater.port_b2) annotation (Line(points={{30,
          90},{30,72},{32,72},{32,68}}, color={191,0,0}));
  connect(adiabatic3.port, GuideTube_Heater.port_b2)
    annotation (Line(points={{68,90},{68,68}}, color={191,0,0}));
  connect(wick_heater.port_b1, Heat_pipewall_heater.port_a1)
    annotation (Line(points={{-30,58},{-14,58}}, color={191,0,0}));
  connect(Heat_pipewall_heater.port_b1, Interface_heater.port_a1)
    annotation (Line(points={{6,58},{22,58}}, color={191,0,0}));
  connect(Interface_heater.port_b1, GuideTube_Heater.port_a1)
    annotation (Line(points={{42,58},{58,58}}, color={191,0,0}));
  connect(wick_adiabatic.port_b1, heat_pipewall_adiabatic.port_a1)
    annotation (Line(points={{-30,14},{-14,14}}, color={191,0,0}));
  connect(heat_pipewall_adiabatic.port_b1, Interface_adiabatic.port_a1)
    annotation (Line(points={{6,14},{22,14}}, color={191,0,0}));
  connect(Interface_adiabatic.port_b1, Guidetube_Adiabatic.port_a1)
    annotation (Line(points={{42,14},{58,14}}, color={191,0,0}));
  connect(wick_storage.port_b1, heat_pipe_wall_storage.port_a1)
    annotation (Line(points={{-30,-32},{-22,-32},{-22,-30},{-14,-30}},
                                                   color={191,0,0}));
  connect(heat_pipe_wall_storage.port_b1, Interface_Storage.port_a1)
    annotation (Line(points={{6,-30},{22,-30}}, color={191,0,0}));
  connect(Interface_Storage.port_b1, GuideTube_Storage.port_a1)
    annotation (Line(points={{42,-30},{58,-30}}, color={191,0,0}));
  connect(adiabatic4.port, wick_storage.port_a2) annotation (Line(points={{-38,-56},
          {-38,-44},{-40,-44},{-40,-42}}, color={191,0,0}));
  connect(adiabatic5.port, heat_pipe_wall_storage.port_a2) annotation (Line(
        points={{-4,-56},{-2,-56},{-2,-44},{-4,-44},{-4,-40}}, color={191,0,0}));
  connect(adiabatic6.port, Interface_Storage.port_a2)
    annotation (Line(points={{32,-56},{32,-40}}, color={191,0,0}));
  connect(adiabatic7.port, GuideTube_Storage.port_a2) annotation (Line(points={{
          70,-56},{70,-44},{68,-44},{68,-40}}, color={191,0,0}));
  connect(Heater.port, GuideTube_Heater.port_b1)
    annotation (Line(points={{104,58},{78,58}},          color={191,0,0}));
  connect(adiabatic11.port, Guidetube_Adiabatic.port_b1)
    annotation (Line(points={{104,14},{78,14}}, color={191,0,0}));
  connect(wick_heater.port_a1, wick_storage.port_a1) annotation (Line(points={{
          -50,58},{-64,58},{-64,-32},{-50,-32}}, color={191,0,0}));
  connect(wick_adiabatic.port_a1, wick_storage.port_a1) annotation (Line(points=
         {{-50,14},{-66,14},{-66,12},{-78,12},{-78,-32},{-50,-32}}, color={191,
          0,0}));
  connect(GuideTube_Storage.port_b1[1], simpleWall.port_a)
    annotation (Line(points={{78,-30},{96,-30}}, color={191,0,0}));
  connect(simpleWall.port_b, phase_change.port[1])
    annotation (Line(points={{116,-30},{132,-30}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPipeTest_resistance_network;
