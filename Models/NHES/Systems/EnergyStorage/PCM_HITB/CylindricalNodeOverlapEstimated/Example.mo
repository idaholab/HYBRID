within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
model Example "Usage with non-uniform spacing vectors."
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
  parameter Real r_loc=0.219 "Circle centre radial position [m]";
  parameter Real theta_loc=105/180*Modelica.Constants.pi "Circle centre angle [rad]";
  parameter Real R_inner=0.0 "Inner radius [m]";

  Real f_node[nR, nTheta];
  Real f_circle[nR, nTheta];
  Modelica.Units.SI.Area A_overlap[nR, nTheta];
  Real circle_fraction_sum "Conservation check — should be ≈ 1.0";
  //  Real small_circ_fracs [nR, nTheta];
  //  Modelica.Units.SI.Length small_circ_pers [nR, nTheta];
  Real rs_one[nR + 1];
  Real thetas_one[nTheta + 1];
 // Integer n_int_one;
//  Integer n_int_two;
//  Real r_int_one[nTheta, 2];
//  Real theta_int_one[nTheta, 2];
  Real dAs_1[nR+1, nTheta];
  Real dAs_2[nR, nTheta+1];

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
equation


  (f_node,f_circle,A_overlap) = allNodesCoincidentFraction(
    r_small,
    r_loc,
    theta_loc,
    drs,
    dthetas,
    R_inner,
    N_r=60,
    N_phi=120);

  circle_fraction_sum = sum(f_circle);
algorithm
  /*  (dAs_1[:,:],dAs_2[:,:]) :=
        CylindricalNodeOverlapEstimated.dAs_function(
        r_small,
        r_loc,
        theta_loc,
        nR,
        nTheta,
        drs,
        dthetas);
        for j in 1:nTheta loop
         (theta_int_one[j, :],r_int_one[j, :]) := circleRayRIntersections(
        r_small,
        r_loc,
        theta_loc,
        thetas_one[j]);
        end for;*/
/*  for i in 1:nR loop
    for j in 1:nTheta loop
      (n_int_one,r_int_one) := circleRayRIntersections(
        r_small,
        r_loc,
        theta_loc,
        thetas_one[j]);
      if n_int_one > 1 then
        if rs_one[i] > r_int_one[2] then
          //no crossover, segment is below 
          dAs_2[i, j] := 1.0;
        elseif rs_one[i + 1] < r_int_one[2] then
          //no crossover, segment is above
          dAs_2[i, j] := 1.0;
        elseif rs_one[i] > r_int_one[1] and rs_one[i + 1] < r_int_one[2] then
          //segment is entirely contained
          dAs_2[i, j] := 1 - (r_int_one[2] - r_int_one[1])/(drs[i]);
        elseif rs_one[i] > r_int_one[1] and rs_one[i + 1] < r_int_one[2] then
          //segment encompasses the 
          dAs_2[i, j] := 0;
        elseif rs_one[i] < r_int_one[1] and rs_one[i + 1] < r_int_one[2] then
          //segment is at upper edge, 
          dAs_2[i, j] := (r_int_one[1] - rs_one[i])/(drs[i]);
        elseif rs_one[i] > r_int_one[1] and rs_one[i + 1] > r_int_one[2] then
          //segment is at lower edge
          dAs_2[i, j] := (rs_one[i + 1] - r_int_one[2])/drs[i];
        else
          //some case I haven't thought of exists and the default value should be 1.0
          dAs_2[i, j] := 1.0;
        end if;
      else
        dAs_2[i, j] := 1.0;
      end if;
     (n_int_two, theta_int_one) := circleRingThetaIntersections(r_small, r_loc, theta_loc, rs_one[i+1]);
           if n_int_two > 1 then
        if thetas_one[j] > theta_int_one[2] then
          //no crossover, segment is below 
          dAs_1[i, j] := 1.0;
        elseif thetas_one[j + 1] < theta_int_one[2] then
          //no crossover, segment is above
          dAs_1[i, j] := 1.0;
        elseif thetas_one[j] > theta_int_one[1] and thetas_one[j + 1] < theta_int_one[2] then
          //segment is entirely contained
          dAs_1[i, j] := 1 - (theta_int_one[2] - theta_int_one[1])/(dthetas[j]);
        elseif thetas_one[j] > theta_int_one[1] and thetas_one[j + 1] < theta_int_one[2] then
          //segment encompasses the 
          dAs_1[i, j] := 0;
        elseif thetas_one[j] < theta_int_one[1] and thetas_one[j + 1] < theta_int_one[2] then
          //segment is at upper edge, 
          dAs_1[i, j] := (theta_int_one[1] - thetas_one[j])/(dthetas[j]);
        elseif thetas_one[j] > theta_int_one[1] and thetas_one[j + 1] > theta_int_one[2] then
          //segment is at lower edge
          dAs_1[i, j] := (thetas_one[j + 1] - theta_int_one[2])/dthetas[j];
        else
          //some case I haven't thought of exists and the default value should be 1.0
          dAs_1[i, j] := 1.0;
        end if;
      else
        dAs_1[i, j] := 1.0;
           end if;
    end for;
  end for;*/
  (arcfrac, arclength) :=circleArcInNode(r_small, r_loc, theta_loc, nR, nTheta,drs, dthetas, 360);
  (dAs_1, dAs_2) :=dAs_function(
    r_small,
    r_loc,
    theta_loc,
    nR,
    nTheta,
    drs,
    dthetas,
    50);

end Example;
