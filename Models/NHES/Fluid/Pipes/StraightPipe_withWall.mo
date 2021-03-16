within NHES.Fluid.Pipes;
model StraightPipe_withWall

  import Modelica.Fluid.Types.ModelStructure;

  extends Modelica.Fluid.Interfaces.PartialTwoPort(
    final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb),
    final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

  extends NHES.Fluid.Pipes.BaseClasses.PartialStraightPipeParameters(
      final use_HeatTransfer=true, nV(min=3) = 3);

  replaceable package Wall_Material =
      NHES.Media.Interfaces.PartialAlloy      "Wall material"
     annotation (choicesAllMatching);
  replaceable model SolutionMethod_FD =
      NHES.Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.AxVolCentered_2O
    constrainedby
    NHES.Thermal.Conduction.FiniteDifference.Cylindrical.BaseClasses.Partial_FDCond_Cylinder
    "Finite Difference Solution Method"
      annotation (choicesAllMatching=true,Dialog(enable=false));

  parameter SI.Length th_wall "Wall thickness"
    annotation(Dialog(group="Wall Parameters"));
  parameter Integer nRadial(min=3)=3 "Nodes in radial direction in tube wall"
    annotation(Dialog(group="Wall Parameters"));

  parameter Boolean counterCurrent=false
    "Swap temperature and flux vector order";
  parameter SI.Temperature Tref = sum(Ts_start)/nV
  "Wall reference temperature"
    annotation (Dialog(tab = "Initialization",group="Start Value: Wall Temperature"));
  parameter SI.Temperature[nRadial,nV] Twall_start=fill(Tref, nRadial, nV)
    "Wall temperatures"
    annotation (Dialog(tab = "Initialization",group="Start Value: Wall Temperature"));

  StraightPipe pipe(
    length=length,
    isCircular=isCircular,
    diameter=diameter,
    crossArea=crossArea,
    perimeter=perimeter,
    roughness=roughness,
    redeclare package Medium = Medium,
    nParallel=nParallel,
    height_a=height_a,
    dheight=dheight,
    redeclare model FlowModel = FlowModel,
    allowFlowReversal=allowFlowReversal,
    nV=nV,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    ps_start=ps_start,
    use_Ts_start=use_Ts_start,
    T_a_start=T_a_start,
    T_b_start=T_b_start,
    Ts_start=Ts_start,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start,
    Xs_start=Xs_start,
    Cs_start=Cs_start,
    momentumDynamics=momentumDynamics,
    m_flow_a_start=m_flow_a_start,
    m_flow_b_start=m_flow_b_start,
    m_flows_start=m_flows_start,
    modelStructure=modelStructure,
    useLumpedPressure=useLumpedPressure,
    lumpPressureAt=lumpPressureAt,
    useInnerPortProperties=useInnerPortProperties,
    redeclare model HeatTransfer = HeatTransfer,
    surfaceAreas=surfaceAreas,
    Qint_flows=Qint_flows,
    use_HeatTransfer=true,
    Ts_wall(start=wall.T_start[1, :]))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-60})));

  Thermal.Conduction.FiniteDifference.Interfaces.ScalePower
    scalePower_WallToPipe(nElem=integer(pipe.nParallel), nNodes=pipe.nV)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-30})));
  Thermal.Conduction.FiniteDifference.Cylinder_FD
    wall(
    energyDynamics=energyDynamics,
    nRadial=nRadial,
    nAxial=pipe.nV,
    r=linspace(
        wall.r_inner,
        wall.r_outer,
        wall.nRadial),
    z=linspace(
        0.5*wall.length/wall.nAxial,
        wall.length*(1 - 0.5/wall.nAxial),
        wall.nAxial),
    r_inner=0.5*pipe.diameter,
    r_outer=wall.r_inner + th_wall,
    length=pipe.length,
    T_start=Twall_start,
    Tref=Tref,
    redeclare package material = Wall_Material,
    redeclare model SolutionMethod_FD = SolutionMethod_FD)
    annotation (Placement(transformation(extent={{-22,-22},{22,22}},
        rotation=90,
        origin={0,0})));
  Thermal.Conduction.FiniteDifference.Interfaces.ScalePower scalePower_WallToExternal(
    nElem=integer(pipe.nParallel),
    counterCurrent=counterCurrent,
    nNodes=pipe.nV)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));

  Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD1(nNodes=wall.nRadial) annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-32,0})));
  Thermal.Conduction.FiniteDifference.BoundaryConditions.Adiabatic_FD
    adiabatic_FD(nNodes=wall.nRadial) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={32,0})));

  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nV] annotation (Placement(
        transformation(extent={{-10,51},{10,71}}), iconTransformation(extent={{-30,
            36},{32,52}})));
equation
  connect(port_a, pipe.port_a) annotation (Line(points={{-100,0},{-60,0},{-60,-60},
          {-10,-60}}, color={0,127,255}));
  connect(pipe.port_b, port_b) annotation (Line(points={{10,-60},{60,-60},{60,0},
          {100,0}}, color={0,127,255}));
  connect(pipe.heatPorts, scalePower_WallToPipe.heatPorts_b) annotation (Line(
        points={{0.1,-55.6},{0.1,-47.8},{0,-47.8},{0,-40}}, color={127,0,0}));
  connect(scalePower_WallToPipe.heatPorts_a, wall.heatPorts_inner)
    annotation (Line(points={{0,-20},{0,-12.98}}, color={127,0,0}));
  connect(wall.heatPorts_outer, scalePower_WallToExternal.heatPorts_a)
    annotation (Line(points={{0,12.98},{0,20}}, color={127,0,0}));
  connect(adiabatic_FD.port, wall.heatPorts_bottom)
    annotation (Line(points={{27,0},{12.98,0}},           color={191,0,0}));
  connect(adiabatic_FD1.port, wall.heatPorts_top)
    annotation (Line(points={{-27,0},{-13.42,0}},            color={191,0,0}));
  connect(heatPorts, heatPorts)
    annotation (Line(points={{0,61},{-15.5,61},{0,61}}, color={127,0,0}));
  connect(heatPorts, scalePower_WallToExternal.heatPorts_b)
    annotation (Line(points={{0,61},{0,50.5},{0,40}}, color={127,0,0}));
  annotation (defaultComponentName="pipe",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                     Rectangle(
          extent={{-100,36},{100,-36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
                              Ellipse(
          extent={{-70,10},{-50,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
                    Text(
                    extent={{-46,17},{48,-18}},
                    lineColor={0,0,0},
          textString="%nV"),
        Rectangle(
          extent={{-100,44},{100,36}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-36},{100,-44}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward)}),                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StraightPipe_withWall;
