within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function coincidentAreaFraction
  "Coincident area fractions for node [i,j] with non-uniform spacing.

     Inputs
     ------
     drs  [nR]     – radial widths of every ring   [m]
     dphis[nTheta] – angular widths of every sector [rad]

     Outputs
     -------
     f_node   = A_overlap / A_node   (fraction of the node   covered)
     f_circle = A_overlap / A_circle (fraction of the circle in this node)
     A_overlap, A_node, A_circle     [m²]"
  input Real    r_small    "Small circle radius [m]";
  input Real    r_loc      "Circle centre radial position [m]";
  input Real    theta_loc  "Circle centre angular position [rad]";
  input Integer i          "Radial  node index";
  input Integer j          "Angular node index";
  input Real    drs[:]     "Radial widths  [m],  size = nR";
  input Real    dphis[:]   "Angular widths [rad], size = nTheta";
  input Real    R_inner    = 0.0 "Inner radius offset [m]";
  input Integer N_r        = 60;
  input Integer N_phi      = 120;
  output Real f_node, f_circle, A_overlap, A_node, A_circle;
protected
  Real r1, r2, theta1, theta2;
algorithm
  (r1, r2, theta1, theta2) :=
      getNodeBounds(i, j, drs, dphis, R_inner);

  A_node   := 0.5 * (r2 * r2 - r1 * r1) * (theta2 - theta1);
  A_circle := Modelica.Constants.pi * r_small * r_small;
  A_overlap := circleNodeOverlapArea(
      r_small, r_loc, theta_loc,
      r1, r2, theta1, theta2,
      N_r, N_phi);

  f_node   := if A_node   > 0.0 then A_overlap / A_node   else 0.0;
  f_circle := if A_circle > 0.0 then A_overlap / A_circle else 0.0;
end coincidentAreaFraction;
