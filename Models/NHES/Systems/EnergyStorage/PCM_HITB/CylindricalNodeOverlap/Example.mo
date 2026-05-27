within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlap;
model Example
  "Usage with non-uniform spacing vectors."
  parameter Integer nR     = 5;
  parameter Integer nTheta = 8;

  // Non-uniform radial and azimuthal spacings — supply your own vectors
  parameter Real drs  [nR]     = {0.05, 0.08, 0.10, 0.12, 0.15}
    "Radial widths of each ring [m]";
  parameter Real dphis[nTheta] = {0.60, 0.70, 0.80, 0.90,
                                  0.80, 0.70, 0.60, 0.15559}
    "Angular widths of each sector [rad]  (should sum to 2π)";

  parameter Real r_small   = 0.05  "Small circle radius [m]";
  parameter Real r_loc     = 0.20  "Circle centre radial position [m]";
  parameter Real theta_loc = 0.40  "Circle centre angle [rad]";
  parameter Real R_inner   = 0.0   "Inner radius [m]";

  Real f_node   [nR, nTheta];
  Real f_circle [nR, nTheta];
  Real A_overlap[nR, nTheta];
  Real circle_fraction_sum "Conservation check — should be ≈ 1.0";
equation
  (f_node, f_circle, A_overlap) =
      allNodesCoincidentFraction(
          r_small, r_loc, theta_loc,
          drs, dphis, R_inner,
          N_r  = 60,
          N_phi = 120);

  circle_fraction_sum = sum(f_circle);
end Example;
