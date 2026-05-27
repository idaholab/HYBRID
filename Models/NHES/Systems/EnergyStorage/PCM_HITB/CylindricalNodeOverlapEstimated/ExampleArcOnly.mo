within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
model ExampleArcOnly "Usage with non-uniform spacing vectors."
  parameter Integer nR=6;
  parameter Integer nTheta=8;

  // Non-uniform radial and azimuthal spacings — supply your own vectors
  parameter Real drs[nR]={0.05,0.08,0.08,0.05,0.12,0.15};
  parameter Real dthetas[nTheta]=Modelica.Constants.pi/180*{15,15,25,25,25,25,25,25};
  /*  parameter Real dthetas[nTheta] = {0.60, 0.70, 0.80, 0.90,
                                  0.80, 0.70, 0.60, 0.15559}
    "Angular widths of each sector [rad]  (should sum to 2π)";
*/
  parameter Real r_small=0.05 "Small circle radius [m]";
  parameter Real r_loc=0.20 "Circle centre radial position [m]";
  parameter Real theta_loc=120/180*Modelica.Constants.pi "Circle centre angle [rad]";
  parameter Real R_inner=0.0 "Inner radius [m]";

  //  Real small_circ_fracs [nR, nTheta];
  //  Modelica.Units.SI.Length small_circ_pers [nR, nTheta];
  Real rs_one[nR + 1];
  Real thetas_one[nTheta + 1];

  Real arcfrac[nR, nTheta];
  Real arclength[nR, nTheta];
algorithm
  rs_one[1] := R_inner;
  for i in 1:nR loop
    rs_one[i + 1] := rs_one[i] + drs[i];
  end for;
  thetas_one[1] := 0;
  for j in 1:nTheta loop
    thetas_one[j + 1] := thetas_one[j] + dthetas[j];
  end for;
algorithm

  (arcfrac, arclength) :=circleArcInNode(r_small, r_loc, theta_loc, nR, nTheta,rs_one, thetas_one, 360);

end ExampleArcOnly;
