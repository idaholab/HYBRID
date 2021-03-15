within NHES.Fluid.Pipes;
model StraightPipe "Pipe with constant diameter"

  extends NHES.Fluid.Pipes.BaseClasses.GenericPipe(
    final lengths=fill(length/nV, nV),
    final crossAreas=fill(crossArea, nV),
    final dimensions=fill(4*crossArea/perimeter, nV),
    final perimeters=fill(perimeter, nV),
    final roughnesses=fill(roughness, nV),
    final dheights=fill(dheight/nV, nV));

  // Geometry
  // Note: define nParallel as Real to support inverse calculations
  parameter SI.Length length "Length"
    annotation (Dialog(tab="General", group="Geometry"));
  parameter Boolean isCircular=true
    "= true if cross sectional area is circular"
    annotation (Evaluate, Dialog(tab="General", group="Geometry"));
  parameter SI.Diameter diameter=if isCircular then 0 else 4*crossArea/perimeter  "Hydraulic diameter"
    annotation (Dialog(group="Geometry", enable=isCircular));
  parameter SI.Area crossArea=pi*diameter*diameter/4 "Inner cross sectional area"
    annotation (Dialog(
      tab="General",
      group="Geometry",
      enable=not isCircular));
  parameter SI.Length perimeter=pi*diameter "Inner wetted perimeter"
    annotation (Dialog(
      tab="General",
      group="Geometry",
      enable=not isCircular));
  parameter SI.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Geometry"));
  parameter SI.Length dheight=0
    "Height(port_b) - Height(port_a)"
    annotation (Dialog(group="Static head"), Evaluate=true);

equation
  assert(diameter>0, "Pipe diameter must be > 0");
  annotation (defaultComponentName="pipe",
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model of a straight pipe with distributed mass, energy and momentum balances. It provides the complete balance equations for one-dimensional fluid flow as formulated in <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\">UsersGuide.ComponentDefinition.BalanceEquations</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The pipe is split into nV equally spaced segments along the flow path. The default value is nV=2. This results in two lumped mass and energy balances and one lumped momentum balance across the dynamic pipe. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Note that this generally leads to high-index DAEs for pressure states if pipes are directly connected to each other, or generally to models with storage exposing a thermodynamic state through the port. This may not be valid if the pipe is connected to a model with non-differentiable pressure, like a Sources.Boundary_pT with prescribed jumping pressure. The <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> can be configured as appropriate in such situations, in order to place a momentum balance between a pressure state of the pipe and a non-differentiable boundary condition. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The default <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> is <code></span><span style=\"font-family: Courier New,courier;\">av_vb</code></span><span style=\"font-family: MS Shell Dlg 2;\"> (see Advanced tab). The simplest possible alternative symmetric configuration, avoiding potential high-index DAEs at the cost of the potential introduction of nonlinear equation systems, is obtained with the setting <code></span><span style=\"font-family: Courier New,courier;\">nV=1, modelStructure=a_v_b</code></span><span style=\"font-family: MS Shell Dlg 2;\">. Depending on the configured model structure, the first and the last pipe segment, or the flow path length of the first and the last momentum balance, are of half size. See the documentation of the base class<a href=\"TRANSFORM.Fluid.Pipes.BaseClasses.PartialTwoPortFlowTemp\"> TRANSFORM.Fluid.Pipes.BaseClasses.PartialTwoPortFlowTemp</a>, also covering asymmetric configurations. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> component specifies the source term <code></span><span style=\"font-family: Courier New,courier;\">Qb_flows</code></span><span style=\"font-family: MS Shell Dlg 2;\"> of the energy balance. The default component uses a constant coefficient for the heat transfer between the bulk flow and the segment boundaries exposed through the <code></span><span style=\"font-family: Courier New,courier;\">heatPorts</code></span><span style=\"font-family: MS Shell Dlg 2;\">. The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> model is replaceable and can be exchanged with any model extended from <a href=\"TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer\">TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The intended use is for complex networks of pipes and other flow devices, like valves. See, e.g., </span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"modelica://Modelica.Fluid.Examples.BranchingDynamicPipes\">Examples.BranchingDynamicPipes</a>, or </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"modelica://Modelica.Fluid.Examples.IncompressibleFluidNetwork\">Examples.IncompressibleFluidNetwork</a>.</span></li>
</ul>
</html>"));
end StraightPipe;
