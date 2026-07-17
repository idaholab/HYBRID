within NHES.Systems.EnergyStorage.PCM_HITB;
model Guide_Tube_New_Air_Inputs
  "Model describing the guide tube portion of the HITB"
  parameter Integer nV_Z = 6 "Number of axial nodes of the thermal battery";
  parameter Integer nV_ZGTe = 8 "Number of axial nodes of the guide tube external to the battery";
  parameter Integer nV_ZHT = 4 "Number of nodes over which heat tape input power is distributed for the mock CHX";
  parameter Integer nR = 1 "No reason to make this not equal to 1, but it's also not unallowed";
  constant Integer nV_ZGT_Total = 2*nV_ZGTe+nV_Z "Total number of guide tube nodes" annotation(Dialog(enable = false));

  /* This model is meant to be used in conjunction with the rest of the HITB systems, so the goal is to use consistent terminology. 
  The other assumption is that the guide tube extends all the way into the "CHX" and "DHX" areas of the experiment.*/
  parameter Modelica.Units.SI.Length l_CHX = 0.33 "Length of charging heat exchange system" annotation(Dialog(tab = "Geometry", group = "Axial"));
  parameter Modelica.Units.SI.Length l_CHX_gap = 0.33 "Length of section between the edge of the thermal battery and the charging heat exchange system." annotation(Dialog(tab = "Geometry", group = "Axial"));
  parameter Modelica.Units.SI.Length l_DHX = 0.33 "Length of dixcharging heat exchange system" annotation(Dialog(tab = "Geometry", group = "Axial"));
  parameter Modelica.Units.SI.Length l_DHX_gap = 0.33 "Length of section between the edge of the thermal battery and the discharging heat exchange system." annotation(Dialog(tab = "Geometry", group = "Axial"));

  parameter Modelica.Units.SI.Length l_Battery = 0.295 "Length of the thermal battery section" annotation(Dialog(tab = "Geometry", group = "Axial"));
  parameter Modelica.Units.SI.Length l_total = l_CHX+l_CHX_gap+l_DHX+l_DHX_gap+l_Battery annotation(Dialog(tab = "Geometry", group = "Axial"));
  Modelica.Units.SI.Length dzs[nR,nV_ZGT_Total] annotation(Dialog(tab = "Geometry", enable=false));
  parameter Modelica.Units.SI.Temperature T_init_tube = 673.15 "Metal temperature" annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature T_init_insulation = 373.15 "External insulation temperature" annotation(Dialog(tab = "Initialization"));

  parameter Modelica.Units.SI.Length r_outer = r_inner+thickness "Outer radius of the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length r_inner = r_outer-thickness "Inner radius of the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length t_insulation_CHX_Inner = 0.0254*3/4 "Insulation around the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length t_insulation_CHX_Outer = 0.0254*3/4 "Insulation around the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length t_insulation_DHX = 0.0254*3/4 "Insulation around the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length thickness = r_outer-r_inner "Guide tube thickness" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 10 "Air convective heat transfer coefficient";

  parameter Integer nV_Zh = 4 annotation(Dialog(tab = "External"));
  Modelica.Units.SI.Area A_HP_Overlap[nV_ZGT_Total, nV_Zh];
  Modelica.Units.SI.Area A_Air_Overlap[nV_ZGT_Total];
  replaceable package Insulation_Material_CHX_Outer =
      NHES.Media.Solids.FoamGlass                                                 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                             annotation(Dialog(tab = "General"), choicesAllMatching = true);
  replaceable package Insulation_Material_CHX_Inner =
      NHES.Media.Solids.FoamGlass                                                 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                             annotation(Dialog(tab = "General"), choicesAllMatching = true);
  replaceable package Insulation_Material_DHX = NHES.Media.Solids.FoamGlass constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                       annotation(Dialog(tab = "General"), choicesAllMatching = true);
  replaceable package Tube_Material = TRANSFORM.Media.Solids.SS316 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy;
  Modelica.Blocks.Interfaces.RealInput z_max_heatpipe annotation (Placement(
        transformation(extent={{-146,8},{-124,30}}), iconTransformation(extent={
            {-146,-24},{-124,-2}})));
  Modelica.Units.SI.Power Q_Loss_GT;
  Modelica.Units.SI.Power Q_HP_Tape[nR,nV_ZGT_Total];
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial1[nV_ZGTe](T=293.15)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-16})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_DHXSide[nV_ZGTe](
      surfaceArea=(l_DHX_gap + l_DHX)/nV_ZGTe*2*Modelica.Constants.pi*(r_outer
         + t_insulation_DHX),
                       alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={66,-16})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder DHX_Side_Exterior_insulation[nV_ZGTe](
    length=(l_DHX_gap + l_DHX)/nV_ZGTe,
    r_inner=r_outer,
    r_outer=r_outer + t_insulation_DHX,
    redeclare package Material = Insulation_Material_DHX,
    T_start=T_init_insulation)
                    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={44,-16})));
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder CHX_Side_Exterior_insulation_Inner[nV_ZGTe](
    length=(l_CHX_gap + l_CHX)/nV_ZGTe,
    r_inner=r_outer,
    r_outer=r_outer + t_insulation_CHX_Inner,
    redeclare package Material = Insulation_Material_CHX_Inner,
    T_start=T_init_insulation) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={42,10})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_CHXSide[nV_ZGTe](
      surfaceArea=(l_CHX_gap + l_CHX)/nV_ZGTe*2*Modelica.Constants.pi*(r_outer
         + t_insulation_CHX_Inner + t_insulation_CHX_Outer),
                       alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,10})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial2[nV_ZGTe](T=293.15)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={114,10})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_CHXSide2(
      surfaceArea=Modelica.Constants.pi*((r_outer)*(r_outer) - r_inner*r_inner),
      alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-24,30})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_GT_End(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-24,52})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D Guide_Tube(
    redeclare package Material = Tube_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=T_init_tube,
    T_b1_start=T_init_tube,
    T_a2_start=T_init_tube,
    T_b2_start=T_init_tube,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nR,
        nZ=nV_ZGT_Total,
        r_inner=r_inner,
        r_outer=r_outer,
        length_z=l_total,
        dzs=dzs),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
        (Q_gens=Q_HP_Tape),
    showName=true)
    annotation (Placement(transformation(extent={{-22,-18},{20,10}})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_CHXSide3(
      surfaceArea=Modelica.Constants.pi*((r_outer)*(r_outer) - r_inner*r_inner),
      alpha=hc_air) annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-15,-31})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_GT_End1(T=293.15)
    annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=270,
        origin={-15,-55})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial3(T=293.15)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-116,6})));
  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation  radiation1      [
    nV_ZGT_Total](surfaceArea=A_Air_Overlap, epsilon=0.29) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-16})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_HP
                                                                [nV_Zh]
    annotation (Placement(transformation(extent={{-88,12},{-68,32}}),
        iconTransformation(extent={{-88,12},{-68,32}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State port_battery[nV_Z]
    annotation (Placement(transformation(extent={{-2,28},{18,48}}),
        iconTransformation(extent={{-2,28},{18,48}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector[
    nV_ZGT_Total](m=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,2})));
  Components.Collector_Variable_Convection collector(
    n_a=nV_ZGT_Total,
    n_b=nV_Zh,
    A_vec=A_HP_Overlap,
    h=5000*ones(nV_ZGT_Total, nV_Zh))
    annotation (Placement(transformation(extent={{-40,12},{-60,32}})));
  Modelica.Units.SI.Length z_vec_HP[nV_Zh+1];
  Modelica.Units.SI.Length z_vec_GT[nV_ZGT_Total+1];
  TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder CHX_Side_Exterior_insulation_Outer[nV_ZGTe](
    length=(l_CHX_gap + l_CHX)/nV_ZGTe,
    r_inner=r_outer + t_insulation_CHX_Inner,
    r_outer=r_outer + t_insulation_CHX_Inner + t_insulation_CHX_Outer,
    redeclare package Material = Insulation_Material_CHX_Outer,
    T_start=T_init_insulation) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={66,10})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D CHX_Air_Side(
    redeclare package Material = PCM_Materials.Solid_Air,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_a1_start=Air_PCM_Axial3.T,
    T_b1_start=T_init_tube,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_1D_z
        (
        nZ=nV_ZGTe,
        r_outer=r_inner,
        length_z=l_CHX + l_CHX_gap),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.GenericHeatGeneration,
    showName=true)
    annotation (Placement(transformation(extent={{-96,-2},{-80,12}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature Air_PCM_Axial4(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-56,-36})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D DHX_Air_Side1(
    redeclare package Material = PCM_Materials.Solid_Air,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_a1_start=Air_PCM_Axial3.T,
    T_b1_start=T_init_tube,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_1D_z
        (
        nZ=nV_ZGTe,
        r_outer=r_inner,
        length_z=l_DHX + l_DHX_gap),
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.GenericHeatGeneration,
    showName=true)
    annotation (Placement(transformation(extent={{-96,-30},{-78,-44}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_PCM_Axial5
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-120,-38})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_PCM_Axial6
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,6})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic Air_PCM_Axial7[nV_Z]
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-118,-16})));
  Modelica.Blocks.Interfaces.RealInput z_min_heatpipe annotation (Placement(
        transformation(extent={{-146,8},{-124,30}}), iconTransformation(extent={
            {-146,8},{-124,30}})));
  Modelica.Blocks.Interfaces.RealInput Heat_Tape_Input annotation (Placement(
        transformation(extent={{-166,-20},{-126,20}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={78,48})));
initial equation
algorithm
  for k in 1:nR loop
    for j in 1:nV_ZGTe loop
      dzs[k,j] := (l_CHX + l_CHX_gap)/nV_ZGTe;
      dzs[k,2*nV_ZGTe+nV_Z-j+1] := dzs[k,j];
    end for;
    for i in 1:nV_Z loop
      dzs[k,i+nV_ZGTe] :=l_Battery/nV_Z;
    end for;
  end for;
    z_vec_GT[1] := 0.0;
    z_vec_HP[1] := z_min_heatpipe;
  for j in 1:nV_Zh loop
    z_vec_HP[j+1] := j/nV_Zh*(z_max_heatpipe-z_min_heatpipe)+z_min_heatpipe;
  end for;
  for i in 2:nV_ZGT_Total+1 loop
    z_vec_GT[i] := z_vec_GT[i-1]+dzs[1,i-1];
  end for;
  for i in 1:nV_ZGT_Total loop
    for j in 1:nV_Zh loop
      if z_vec_GT[i+1] <= z_vec_HP[j] or z_vec_GT[i] >= z_vec_HP[j+1] then
        A_HP_Overlap[i,j] := 0;
      elseif z_vec_GT[i+1] >= z_vec_HP[j+1] and z_vec_GT[i] >= z_vec_HP[j] then
        A_HP_Overlap[i,j] := Modelica.Constants.pi*r_inner*2*(z_vec_HP[j+1]-z_vec_GT[i]);
      elseif z_vec_GT[i+1] <= z_vec_HP[j+1] and z_vec_GT[i]<=z_vec_HP[j] then
        A_HP_Overlap[i,j] := Modelica.Constants.pi*r_inner*2*(z_vec_GT[i+1]-z_vec_HP[j]);
      elseif z_vec_GT[i+1] <= z_vec_HP[j+1] and z_vec_GT[i] >= z_vec_HP[j] then
        A_HP_Overlap[i,j] := Modelica.Constants.pi*r_inner*2*(z_vec_GT[i+1]-z_vec_GT[i]);
      else
        A_HP_Overlap[i,j] := Modelica.Constants.pi*r_inner*2*(z_vec_HP[j+1]-z_vec_GT[j]);
      end if;
    end for;
  end for;
  for k in 1:nR loop
  for i in 1:nV_ZHT loop
    if k == nR then
  Q_HP_Tape[k,i] :=1/(nV_ZHT)*Heat_Tape_Input;
    else
      Q_HP_Tape[k,i] := 0;
    end if;
  end for;
  for i in nV_ZHT+1 :nV_ZGT_Total loop
    Q_HP_Tape[k,i]:=0;
  end for;
  end for;
  for i in 1:nV_ZGT_Total loop
    A_Air_Overlap[i] := max(Modelica.Constants.pi*r_inner*2*(z_vec_GT[i+1]-z_vec_GT[i])-sum(A_HP_Overlap[i,:]),1e-4);
  end for;
Q_Loss_GT := sum(convection_CHXSide[:].port_b.Q_flow) + sum(convection_CHXSide.port_a.Q_flow)
     + convection_CHXSide2.port_b.Q_flow + convection_CHXSide3.port_a.Q_flow + sum(convection_DHXSide.port_a.Q_flow);
equation
  for i in 1:nV_Z loop
    connect(port_battery[i], Guide_Tube.port_b1[i + nV_ZGTe]) annotation (Line(
          points={{8,38},{8,16},{20,16},{20,-4}},         color={191,0,0}));
    connect(Air_PCM_Axial7[i].port, radiation1[i + nV_ZGTe].port_b) annotation (
       Line(points={{-108,-16},{-77,-16}},                     color={191,0,0}));
  end for;
  for i in 1:nV_ZGTe loop
    connect(CHX_Side_Exterior_insulation_Inner[i].port_a, Guide_Tube.port_b1[i])
      annotation (Line(points={{32,10},{24,10},{24,2},{26,2},{26,-4},{20,-4}},
                                                                 color={191,0,0}));
    connect(CHX_Air_Side.port_external[i], radiation1[i].port_b) annotation (
        Line(points={{-94.4,-0.6},{-94.4,-16},{-77,-16}},              color={
            191,0,0}));
    connect(DHX_Side_Exterior_insulation[i].port_a, Guide_Tube.port_b1[i + nV_Z +
      nV_ZGTe]) annotation (Line(points={{34,-16},{26,-16},{26,-4},{20,-4}},
          color={191,0,0}));
    connect(DHX_Air_Side1.port_external[i], radiation1[i + nV_Z + nV_ZGTe].port_b)
      annotation (Line(points={{-94.2,-31.4},{-94.2,-16},{-77,-16}},   color={
            191,0,0}));
  end for;
  connect(convection_CHXSide.port_a, Air_PCM_Axial2.port) annotation (Line(
        points={{97,10},{104,10}},                    color={191,0,0}));
  connect(Air_PCM_Axial1.port, convection_DHXSide.port_a)
    annotation (Line(points={{80,-16},{73,-16}},   color={191,0,0}));
  connect(convection_DHXSide.port_b,DHX_Side_Exterior_insulation. port_b)
    annotation (Line(points={{59,-16},{54,-16}},  color={191,0,0}));
  connect(convection_CHXSide3.port_b, Guide_Tube.port_a2[1]) annotation (Line(
        points={{-15,-23.3},{-15,-18},{-1,-18}},    color={191,0,0}));
  connect(convection_CHXSide3.port_a, Air_GT_End1.port) annotation (Line(points={{-15,
          -38.7},{-15,-44}},                                color={191,0,0}));
  connect(Guide_Tube.port_b2[1], convection_CHXSide2.port_a) annotation (Line(
        points={{-1,10},{-1,20},{-24,20},{-24,23}},           color={191,0,0}));
  connect(convection_CHXSide2.port_b, Air_GT_End.port) annotation (Line(points={{-24,37},
          {-24,42}},                                       color={191,0,0}));
  connect(thermalCollector.port_b, Guide_Tube.port_a1) annotation (Line(points={{-30,2},
          {-30,-10},{-26,-10},{-26,-4},{-22,-4}},           color={191,0,0}));
  connect(radiation1.port_a, thermalCollector.port_a[1]) annotation (Line(
        points={{-63,-16},{-56,-16},{-56,2},{-49.75,2}},        color={191,0,0}));
  connect(collector.port_a, thermalCollector.port_a[2]) annotation (Line(points={{-40,22},
          {-40,12},{-58,12},{-58,2},{-50.25,2}},             color={191,0,0}));
  connect(port_HP, collector.port_b) annotation (Line(points={{-78,22},{-60,22}},
                            color={191,0,0}));
  connect(CHX_Side_Exterior_insulation_Inner.port_b,
    CHX_Side_Exterior_insulation_Outer.port_a)
    annotation (Line(points={{52,10},{56,10}}, color={191,0,0}));
  connect(CHX_Side_Exterior_insulation_Outer.port_b, convection_CHXSide.port_b)
    annotation (Line(points={{76,10},{83,10}},  color={191,0,0}));
  connect(Air_PCM_Axial3.port, CHX_Air_Side.port_a1) annotation (Line(points={{-106,6},
          {-101,6},{-101,5},{-96,5}},         color={191,0,0}));
  connect(CHX_Air_Side.port_b1, Air_PCM_Axial6.port) annotation (Line(points={{-80,5},
          {-77,5},{-77,6},{-74,6}},          color={191,0,0}));
  connect(Air_PCM_Axial5.port, DHX_Air_Side1.port_a1)
    annotation (Line(points={{-110,-38},{-110,-37},{-96,-37}},
                                                     color={191,0,0}));
  connect(Air_PCM_Axial4.port, DHX_Air_Side1.port_b1) annotation (Line(points={{-66,-36},
          {-72,-36},{-72,-37},{-78,-37}},                              color={191,
          0,0}));
                                                                                                                                 annotation(Dialog(tab = "General"), choicesAllMatching = true,
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -100},{140,100}}),                                  graphics={
        Ellipse(
          extent={{-130,26},{-96,-20}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-114,26},{108,-20}},
          lineColor={28,108,200},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{96,26},{120,-20}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-114,20},{108,-16}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-126,20},{-100,-16}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{98,20},{118,-16}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,
            100}})),
    Documentation(info="<html>
<p>This guide tube model is enhanced with an internal heat exchange relationship with an assumed-to-be filled-by-air system. The air itself is modeled as a conduction system, based on a presumed horizontal configuration that would not introduce consistent natural convection currents. </p>
</html>"));

                                //this is if right edge < left edge or left edge > right edge, there's no overlap, so = 0
        //this is the case where we have a right-centered overlap
       //this is the case where we have a left-centered overlap
       // this is the case where the guide tube node completely envelops the heat pipe node
      // this is the case where the heat pipe node completely envelops the heat pipe node, it's the only remaining possibility because we already checked the others.

end Guide_Tube_New_Air_Inputs;
