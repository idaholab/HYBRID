within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function allNodesCoincidentFraction
  "Coincident area fractions for ALL nodes.
     nR = size(drs,1),  nTheta = size(dphis,1) — no separate count needed.

     Conservation check: sum(f_circle) ≈ 1.0 when the circle is fully
     inside the cylinder."
  input Real    r_small    "Small circle radius [m]";
  input Real    r_loc      "Circle centre radial position [m]";
  input Real    theta_loc  "Circle centre angular position [rad]";
  input Real    drs[:]     "Radial widths  [m],  size = nR";
  input Real    dphis[:]   "Angular widths [rad], size = nTheta";
  input Real    R_inner    = 0.0 "Inner radius offset [m]";
  input Integer N_r        = 60;
  input Integer N_phi      = 120;
  output Real f_node   [size(drs,1), size(dphis,1)];
  output Real f_circle [size(drs,1), size(dphis,1)];
  output Modelica.Units.SI.Area A_overlap[size(drs,1), size(dphis,1)];
protected
  Integer nR     = size(drs,  1);
  Integer nTheta = size(dphis,1);
  Real fn, fc, Ao, An, Ac;
algorithm
  for ii in 1:nR loop
    for jj in 1:nTheta loop
      (fn, fc, Ao, An, Ac) := coincidentAreaFraction(
          r_small, r_loc, theta_loc,
          ii, jj, drs, dphis, R_inner,
          N_r, N_phi);
      f_node   [ii, jj] := fn;
      f_circle [ii, jj] := fc;
      A_overlap[ii, jj] := Ao;
      assert(f_node[ii, jj] < 1, "Node scheme completely encompasses a node", AssertionLevel.error);

    end for;
  end for;
end allNodesCoincidentFraction;
