within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function FindPointInAnnularGrid "Return true if Cartesian point (x,y) lies within the closed annular
     sector [r1,r2] x [theta1,theta2).
     Convention: x = r*sin(θ),  y = r*cos(θ)."
  input Real r, theta;
  input Integer nR, nTheta;
  input Real drs[nR], dthetas[nTheta], r_0, theta_0;
  output Integer nR_i, nTheta_j;
protected
  Real rs_one[nR+1], thetas_one[nTheta+1];
algorithm
  nR_i := 0;
  nTheta_j := 0;
  rs_one[1] := r_0;
  thetas_one[1] := theta_0;
  for i in 1:nR loop
    rs_one[i+1] := rs_one[i]+drs[i];
    if r <= rs_one[i+1] and r > rs_one[i] then
      nR_i := i;
    end if;
  end for;
  for j in 1:nTheta loop
    thetas_one[j+1] := thetas_one[j] + dthetas[j];
    if theta <= thetas_one[j+1] and theta > thetas_one[j] then
      nTheta_j := j;
    end if;
  end for;

end FindPointInAnnularGrid;
