within NHES.Fluid.Pipes.BaseClasses;
partial model PartialStraightPipeParameters "Summary of straight pipe parameters"

  import Modelica.Fluid.Types.Dynamics;
  import Modelica.Fluid.Types.ModelStructure;
  import NHES.Fluid.Types.LumpedLocation;

  outer Modelica.Fluid.System system "System properties";

  extends NHES.Fluid.Pipes.BaseClasses.PartialGenericPipeParameters(
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialStraightPipeParameters;
