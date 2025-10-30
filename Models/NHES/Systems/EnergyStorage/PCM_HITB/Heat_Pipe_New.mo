within NHES.Systems.EnergyStorage.PCM_HITB;
model Heat_Pipe_New
  "Model describing a heat pipe using primarily conduction nodes, reducing mass relative to the previous version(s)"
  parameter Integer nV_Z = 6 "Number of axial nodes";
  parameter Integer nR_Wick = 1;
  parameter Integer nR_Core = 1;
  parameter Integer nR_Wall = 1;
  Modelica.Units.SI.Area cap_R_vec[nR_Wick+nR_Core+nR_Wall];
  /* This model is meant to be used in conjunction with the rest of the HITB systems, so the goal is to use consistent terminology. 
  The other assumption is that the guide tube extends all the way into the "CHX" and "DHX" areas of the experiment.*/
  parameter Modelica.Units.SI.Temperature T_init = 673.15 annotation(Dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Length l_total = 1.0 annotation(Dialog(tab = "Geometry", group = "Axial"));

  parameter Modelica.Units.SI.Length r_inner_wick = r_outer_wick - 0.0011 "Radius of the vapor core and wick inner surface" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length r_outer_wick = r_heat_pipe-0.0032 "Outer radius of the wick and inner radius of the wall" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length r_heat_pipe = 1.0*0.0254 "Outer radius of the wick and inner radius of the wall" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length r_insulation = 0.0254 "Insulation around the guide tube" annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.Length thickness_cap = 0.0254 "End cap thickness, assumed to be planar." annotation(Dialog(tab = "Geometry", group = "Diameter"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 10 "Air convective heat transfer coefficient";

      replaceable package Core_Material = TRANSFORM.Media.Solids.SS316 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy annotation (Dialog(tab=
          "General"),
      choicesAllMatching=true);
  replaceable package Wick_Material = NHES.Media.Solids.FoamGlass constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                                   annotation(Dialog(tab = "General"), choicesAllMatching = true);
  replaceable package Tube_Material = TRANSFORM.Media.Solids.SS316 constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                                                              annotation(Dialog(tab = "General"), choicesAllMatching = true);

  input Modelica.Units.SI.Temperature T_air_evaporator annotation(Dialog(tab = "External"));
  input Modelica.Units.SI.Temperature T_air_condenser annotation(Dialog(tab = "External"));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_cap_evaporator[nR_Wall
     + nR_Wick + nR_Core](surfaceArea=cap_R_vec,
                             alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-12,26})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D Wick(
    redeclare package Material = Wick_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=T_init,
    T_b1_start=T_init,
    T_a2_start=T_init,
    T_b2_start=T_init,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nR_Wick,
        nZ=nV_Z,
        r_inner=r_inner_wick,
        r_outer=r_outer_wick,
        length_z=l_total),
    showName=true)
    annotation (Placement(transformation(extent={{-10,-18},{32,10}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi Adiabatic_Core(nPorts=
        nV_Z) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-76,-4})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_State heat_pipe_port[nV_Z]
    annotation (Placement(transformation(extent={{36,24},{56,44}}),
        iconTransformation(extent={{36,24},{56,44}})));

  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D Heat_Pipe_Core(
    redeclare package Material = Core_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=T_init,
    T_b1_start=T_init,
    T_a2_start=T_init,
    T_b2_start=T_init,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nR_Core,
        nZ=nV_Z,
        r_inner=0,
        r_outer=r_inner_wick,
        length_z=l_total),
    showName=true)
    annotation (Placement(transformation(extent={{-60,-18},{-18,10}})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D Heat_Pipe_Wall(
    redeclare package Material = Tube_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=T_init,
    T_b1_start=T_init,
    T_a2_start=T_init,
    T_b2_start=T_init,
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
        (
        nR=nR_Wall,
        nZ=nV_Z,
        r_inner=r_outer_wick,
        r_outer=r_heat_pipe,
        length_z=l_total),
    showName=true)
    annotation (Placement(transformation(extent={{40,-18},{82,10}})));

  TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_cap_condenser[nR_Wall
     + nR_Wick + nR_Core](surfaceArea=cap_R_vec,
                             alpha=hc_air) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={36,-34})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi Temperature_Evaporater_BC(nPorts=
        nR_Core + nR_Wall + nR_Wick, use_port=true) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-42,26})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi Temperature_Condenser_BC(nPorts=
        nR_Core + nR_Wall + nR_Wick, use_port=true) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={64,-34})));
  Modelica.Blocks.Sources.RealExpression realExpression[nR_Core + nR_Wall +
    nR_Wick](y=T_air_evaporator)
    annotation (Placement(transformation(extent={{-78,16},{-58,36}})));
  Modelica.Blocks.Sources.RealExpression realExpression1[nR_Wick + nR_Core +
    nR_Wall](y=T_air_condenser)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,-34})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Heat_Pipe_Evaporator_Cap[nR_Core
     + nR_Wick + nR_Wall](redeclare package Material = Tube_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    T_a1_start=T_init,
    T_b1_start=T_init,                redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D
        (length_x=thickness_cap, length_z=Modelica.Constants.pi*r_outer_wick*r_outer_wick/(nR_Core+nR_Wall+nR_Wick)))
                                                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={12,26})));
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Heat_Pipe_Condenser_Cap[nR_Core
     + nR_Wick + nR_Wall](redeclare package Material = Tube_Material,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    T_a1_start=T_init,
    T_b1_start=T_init,                redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D
        (length_x=thickness_cap, length_z=Modelica.Constants.pi*r_outer_wick*r_outer_wick/(nR_Core+nR_Wall+nR_Wick))) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={14,-34})));
initial equation

equation

algorithm
  for i in 1:nR_Core loop
    cap_R_vec[i] := Modelica.Constants.pi*(i*r_inner_wick/nR_Core*i*r_inner_wick/nR_Core - (i-1)*r_inner_wick/nR_Core*(i-1)*r_inner_wick/nR_Core);

   /* for j in Heat_Pipe_Condenser_Cap.geometry.nX loop
      Heat_Pipe_Condenser_Cap[i].geometry.dzs[j] := Modelica.Constants.pi*(i*r_inner_wick/nR_Core*i*r_inner_wick/nR_Core - (i-1)*r_inner_wick/nR_Core*(i-1)*r_inner_wick/nR_Core);
    end for;
        for j in Heat_Pipe_Evaporator_Cap.geometry.nX loop
      Heat_Pipe_Evaporator_Cap[i].geometry.dzs[j] := Modelica.Constants.pi*(i*r_inner_wick/nR_Core*i*r_inner_wick/nR_Core - (i-1)*r_inner_wick/nR_Core*(i-1)*r_inner_wick/nR_Core);
    end for;*/
  end for;
  for i in 1:nR_Wick loop
      cap_R_vec[i] := Modelica.Constants.pi*((i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*(i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick - ((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick);

  /*  for j in Heat_Pipe_Condenser_Cap.geometry.nX loop
    Heat_Pipe_Condenser_Cap[nR_Core+i].geometry.dzs[j] := Modelica.Constants.pi*((i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*(i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick - ((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick);
    end for;
        for j in Heat_Pipe_Evaporator_Cap.geometry.nX loop
    Heat_Pipe_Evaporator_Cap[nR_Core+i].geometry.dzs[j] := Modelica.Constants.pi*((i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*(i*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick - ((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick*((i-1)*(r_outer_wick-r_inner_wick)+r_inner_wick)/nR_Wick);
    end for;*/
  end for;
  for i in 1:nR_Wall loop
     cap_R_vec[i] := Modelica.Constants.pi*((i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*(i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall - ((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall);
 /*   for j in Heat_Pipe_Condenser_Cap.geometry.nX loop
    Heat_Pipe_Condenser_Cap[nR_Wick+nR_Core+i].geometry.dzs[j] := Modelica.Constants.pi*((i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*(i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall - ((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall);
    end for;
        for j in Heat_Pipe_Evaporator_Cap.geometry.nX loop
    Heat_Pipe_Evaporator_Cap[nR_Wick+nR_Core+i].geometry.dzs[j] := Modelica.Constants.pi*((i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*(i*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall - ((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall*((i-1)*(r_heat_pipe-r_outer_wick)+r_outer_wick)/nR_Wall);
    end for;*/
  end for;

equation
  for i in 1:nR_Core loop
    connect(Heat_Pipe_Condenser_Cap[i].port_b1, Heat_Pipe_Core.port_a2[i])
      annotation (Line(points={{4,-34},{4,-22},{-39,-22},{-39,-18}},     color={
            191,0,0}));
    connect(Heat_Pipe_Evaporator_Cap[i].port_b1, Heat_Pipe_Core.port_b2[i])
      annotation (Line(points={{22,26},{22,18},{-39,18},{-39,10}},   color={191,
            0,0}));
  end for;
  for i in 1:nR_Wick loop
    connect(Heat_Pipe_Condenser_Cap[i + nR_Core].port_b1, Wick.port_a2[i])
      annotation (Line(points={{4,-34},{4,-24},{11,-24},{11,-18}},       color={
            191,0,0}));
    connect(Heat_Pipe_Evaporator_Cap[i + nR_Core].port_b1, Wick.port_b2[i])
      annotation (Line(points={{22,26},{22,10},{11,10}},
          color={191,0,0}));
  end for;
  for i in 1:nR_Wall loop
    connect(Heat_Pipe_Condenser_Cap[i + nR_Core + nR_Wick].port_b1,
      Heat_Pipe_Wall.port_a2[i]) annotation (Line(points={{4,-34},{4,-24},{61,
            -24},{61,-18}},
                   color={191,0,0}));
    connect(Heat_Pipe_Evaporator_Cap[i + nR_Core + nR_Wick].port_b1,
      Heat_Pipe_Wall.port_b2[i]) annotation (Line(points={{22,26},{22,10},{61,
            10}},                 color={191,0,0}));
  end for;

  connect(Heat_Pipe_Wall.port_b1, heat_pipe_port) annotation (Line(points={{82,-4},
          {82,34},{46,34}},                         color={191,0,0}));
  connect(Heat_Pipe_Wall.port_a1, Wick.port_b1) annotation (Line(points={{40,-4},
          {32,-4}},                 color={191,0,0}));
  connect(Heat_Pipe_Core.port_b1, Wick.port_a1) annotation (Line(points={{-18,-4},
          {-10,-4}},                   color={191,0,0}));
  connect(Adiabatic_Core.port, Heat_Pipe_Core.port_a1) annotation (Line(points={{-66,-4},
          {-60,-4}},                               color={191,0,0}));

  connect(Temperature_Evaporater_BC.port, convection_cap_evaporator.port_b)
    annotation (Line(points={{-32,26},{-19,26}},          color={191,0,0}));
  connect(Temperature_Condenser_BC.port, convection_cap_condenser.port_a)
    annotation (Line(points={{54,-34},{43,-34}},                color={191,0,0}));
  connect(Temperature_Evaporater_BC.T_ext, realExpression.y) annotation (Line(
        points={{-46,26},{-57,26}},                    color={0,0,127}));
  connect(Temperature_Condenser_BC.T_ext, realExpression1.y)
    annotation (Line(points={{68,-34},{75,-34}},      color={0,0,127}));
  connect(Heat_Pipe_Evaporator_Cap.port_a1, convection_cap_evaporator.port_a)
    annotation (Line(points={{2,26},{-5,26}},                      color={191,0,
          0}));
  connect(Heat_Pipe_Condenser_Cap.port_a1, convection_cap_condenser.port_b)
    annotation (Line(points={{24,-34},{29,-34}},                        color={191,
          0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-130,26},{-96,-20}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-114,26},{108,-20}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{96,26},{120,-20}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-128,24},{-100,-18}},
          fillColor={255,255,255},
          fillPattern=FillPattern.CrossDiag,
          pattern=LinePattern.None),
        Ellipse(
          extent={{96,24},{118,-18}},
          fillColor={255,255,255},
          fillPattern=FillPattern.CrossDiag,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-114,24},{108,-18}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-114,22},{108,-16}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Ellipse(
          extent={{-126,22},{-100,-16}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Sphere,
          pattern=LinePattern.None),
        Ellipse(
          extent={{98,22},{116,-16}},
          fillColor={255,0,0},
          fillPattern=FillPattern.Sphere,
          pattern=LinePattern.None)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The heat pipe is an enhanced thermal conductivity method heat pipe that will conduct heat through the core along the axial direction to quickly move heat along the structure. The mutiple layers of material represent an actual heat pipe structure, although homogenizing them for simplicity would not be inappropriate. </p>
</html>"));
end Heat_Pipe_New;
