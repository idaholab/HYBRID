within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlap;
pure function isPointInAnnularSector
  "Return true if Cartesian point (x,y) lies within the closed annular
     sector [r1,r2] x [theta1,theta2).
     Convention: x = r*sin(θ),  y = r*cos(θ)."
  input Real x, y;
  input Real r1, r2, theta1, theta2;
  output Boolean inside;
protected
  Real r_pt, theta_pt;
algorithm
  r_pt := sqrt(x * x + y * y);
  if r_pt < r1 or r_pt > r2 then
    inside := false;
    return;
  end if;
  if r_pt < 1.0e-14 then
    inside := true;
    return;
  end if;
  // atan2(x, y) gives θ under the inverted convention x=r·sin,y=r·cos
  theta_pt := Modelica.Math.atan2(x, y);
  if theta_pt < 0.0 then
    theta_pt := theta_pt + 2.0 * Modelica.Constants.pi;
  end if;
  inside := (theta_pt >= theta1 and theta_pt < theta2);
end isPointInAnnularSector;
