within NHES.Systems.EnergyStorage.Concrete_Solid_Media.BaseClasses;
model Square_Grid_Piping_Two_Pipes
  extends
    TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.PartialGeometry_2D(
      final ns={nX,2*nY}, final figure=1);
  parameter Integer nX(min=1) = 1 "Number of nodes in x-direction";
  parameter Integer nY(min=1) = 1 "Number of nodes in y-direction";
  input SI.Length length_x=1 "Specify overall length or dxs in x-dimension"
    annotation (Dialog(group="Inputs"));
  input SI.Length length_y=1 "Specify overall length or dys in y-dimension"
    annotation (Dialog(group="Inputs"));
  input SI.Length length_z=1 "Specify length or dzs in z-dimension"
    annotation (Dialog(group="Inputs"));
  input SI.Length d_o = 0.1 "Specify outer diameter of the pipe within square grid"
  annotation(Dialog(group="Inputs"));
  input SI.Length dxs[nX,2*nY](min=0) = fill(
    (length_x)/nX,
    nX,
    2*nY) "Unit volume lengths of x-dimension"
    annotation (Dialog(group="Inputs"));
  input SI.Length dys[nX,2*nY](min=0) = fill(
    (length_y-d_o)/nY,
    nX,
    2*nY) "Unit volume lengths of y-dimension"
    annotation (Dialog(group="Inputs"));
  input SI.Length dzs[nX,2*nY](min=0) = fill(
    (length_y-d_o)/nY,
    nX,
    2*nY) "Unit volume lengths of z-dimension"
    annotation (Dialog(group="Inputs"));
  SI.Length xs[nX,2*nY] "Position in x-dimension";
  SI.Length ys[nX,2*nY] "Position in y-dimension";
  SI.Length zs[nX,2*nY] "Position in z-dimension";
initial equation
  closedDim_1 = fill(false,2*nY);
  closedDim_2 = fill(false,nX);
algorithm
  for j in 1:2*nY loop
    xs[1, j] := 0.5*dxs[1, j];
    for i in 2:nX loop
      xs[i, j] := sum(dxs[1:i - 1, j]) + 0.5*dxs[i, j];
    end for;
  end for;

  for i in 1:nX loop
    ys[i, 1] := d_o+0.5*dys[i, 1];
    for j in 2:nY loop
      ys[i, j] := d_o+sum(dys[i, 1:j - 1]) + 0.5*dys[i, j];
    end for;
    for j in 1:nY loop
      ys[i,2*nY-j+1] := ys[i,j];
    end for;
  end for;

  for i in 1:nX loop
    for j in 1:2*nY loop
      zs[i, j] := ys[i,j];
    end for;
  end for;
  for i in 1:nX loop
      Vs[i,1] := dxs[i,1]*ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;
    for j in 2:nY loop
      Vs[i, j] := dxs[i, j]*ys[i, j]*zs[i, j] - Vs[i,j-1];
    end for;
    for j in 1:nY loop
      Vs[i,2*nY+1-j] := Vs[i,j];
    end for;
  end for;

    for i in 1:nX loop
      crossAreas_1[i,1] := ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;

    end for;
      crossAreas_1[nX+1,1] := ys[nX,1]*zs[nX,1]-Modelica.Constants.pi*d_o*d_o/4;
  for j in 2:nY loop
    for i in 1:nX loop
      crossAreas_1[i, j] := ys[i, j]*zs[i, j]-ys[i,j-1]*zs[i,j-1];
    end for;
    crossAreas_1[nX + 1, j] := ys[nX, j]*zs[nX, j]-ys[nX,j-1]*zs[nX,j-1];
  end for;
  for i in 1:nX+1 loop
    for j in 1:nY loop
      crossAreas_1[i,2*nY+1-j] :=crossAreas_1[i, j];
    end for;
  end for;

  for i in 1:nX loop
    crossAreas_2[i,1] := d_o*Modelica.Constants.pi*dxs[i,1];
    for j in 2:nY loop
      crossAreas_2[i, j] := 4*dxs[i, j-1]*ys[i, j-1];
    end for;
    crossAreas_2[i, nY + 1] := 4*dxs[i, nY]*ys[i, nY];
    for j in 1:nY loop
      crossAreas_2[i,2*nY+2-j] := crossAreas_2[i,j];
    end for;
  end for;

  for i in 1:nX loop
    for j in 1:nY loop
      dlengths_1[i, j] := dxs[i, j];
      dlengths_2[i, j] := dys[i, j];
    end for;
  end for;
  for i in 1:nX loop
    for j in 1:nY loop
      cs_1[i, j] := xs[i, j];
      cs_2[i, j] := ys[i, j];
    end for;
  end for;
  for i in 1:nX loop
    for j in 1:nY loop
      surfaceAreas_3a[i, j] := dxs[i, j]*dys[i, j];
      surfaceAreas_3b[i, j] := dxs[i, j]*dys[i, j];
    end for;
  end for;
  annotation (
    defaultComponentName="geometry",
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end Square_Grid_Piping_Two_Pipes;
