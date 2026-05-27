within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlap;
pure function circleNodeOverlapArea
  "Overlap area [m²] between a circle (r_small, r_loc, theta_loc) and
     a single annular sector [r1,r2] x [theta1,theta2].
     Polar midpoint quadrature centred on the circle."
  input Real    r_small, r_loc, theta_loc;
  input Real    r1, r2, theta1, theta2;
  input Integer N_r   = 60;
  input Integer N_phi = 120;
  output Real A_overlap;
protected
  Real x_c, y_c, dr, dphi, r_s, phi, x_pt, y_pt, A_sum;
algorithm
  if (r_loc + r_small) < r1 or (r_loc - r_small) > r2 then
    A_overlap := 0.0;
    return;
  end if;
  x_c   := r_loc * sin(theta_loc);
  y_c   := r_loc * cos(theta_loc);
  dr    := r_small / N_r;
  dphi  := 2.0 * Modelica.Constants.pi / N_phi;
  A_sum := 0.0;
  for k_r in 1:N_r loop
    r_s := (k_r - 0.5) * dr;
    for k_phi in 1:N_phi loop
      phi   := (k_phi - 0.5) * dphi;
      x_pt  := x_c + r_s * cos(phi);
      y_pt  := y_c + r_s * sin(phi);
      if isPointInAnnularSector(x_pt, y_pt, r1, r2, theta1, theta2) then
        A_sum := A_sum + r_s * dr * dphi;
      end if;
    end for;
  end for;
  A_overlap := A_sum;
end circleNodeOverlapArea;
