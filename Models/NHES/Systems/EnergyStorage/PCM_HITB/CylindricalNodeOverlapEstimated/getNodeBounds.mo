within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function getNodeBounds
  "Return the radial and angular boundaries of node [i,j] from
     non-uniform spacing vectors drs[nR] and dphis[nTheta].
     R_inner offsets the radial origin (default 0)."
  input Integer i            "Radial index  [1 .. nR]";
  input Integer j            "Angular index [1 .. nTheta]";
  input Real    drs[:]       "Radial width of each ring   [m],  size = nR";
  input Real    dphis[:]     "Angular width of each sector [rad], size = nTheta";
  input Real    R_inner = 0.0 "Inner radius offset [m]";
  output Real   r1           "Node inner radial boundary [m]";
  output Real   r2           "Node outer radial boundary [m]";
  output Real   theta1       "Node start angle [rad]";
  output Real   theta2       "Node end   angle [rad]";

algorithm

  // Cumulative sum up to, but not including, index i  → r1
  // Cumulative sum up to and including index i        → r2
  r1 := R_inner;
  for k in 1:(i - 1) loop
    r1 := r1 + drs[k];
  end for;
  r2 := r1 + drs[i];

  theta1 := 0.0;
  for k in 1:(j - 1) loop
    theta1 := theta1 + dphis[k];
  end for;
  theta2 := theta1 + dphis[j];
end getNodeBounds;
