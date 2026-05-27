within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function dAs_function
  "Returns the dAs vector to enter a cylindrical geometry file.
  This method currently only counts inter-nodal defect in the r and theta direction. 
  For z direction, additional functionality will be required."
//  input Integer n_circs = 1;
  input Modelica.Units.SI.Length r_small, r_loc;
  input Modelica.Units.SI.Angle theta_loc;
  input Integer nR, nTheta;
  input Modelica.Units.SI.Length drs[nR];
  input Modelica.Units.SI.Angle dthetas[nTheta];
  input Integer num_points = 50;

  output Real dAs_1[nR+1, nTheta], dAs_2[nR, nTheta+1];
protected
  Integer n_int_one, n_int_two;
  Real theta_int_one[2], r_int_one[2];
  Modelica.Units.SI.Length rs_one[nR+1];
  Modelica.Units.SI.Angle thetas_one[nTheta+1];
  Integer points;
  Boolean isincirc;
  Real distance;
  Real r_temp;
  Real theta_temp;


algorithm
  rs_one[1] := 0;
  thetas_one[1] := 0;
  for j in 1:nTheta loop
    thetas_one[j+1] := thetas_one[j] + dthetas[j];
  end for;
  for i in 1:nR loop
    rs_one[i+1] := rs_one[i]+drs[i];
  end for;
  dAs_1 := ones(nR+1, nTheta);
  dAs_2 := ones(nR, nTheta+1);

  //check dAs_1
  for i in 1:nR+1 loop
    for j in 1:nTheta loop
      points := 0;
      for p in 1:num_points loop
        theta_temp := thetas_one[j] + (p-1)/num_points*dthetas[j];
          distance := sqrt(rs_one[i]*rs_one[i] + r_loc*r_loc - 2*r_loc*rs_one[i]*cos(theta_loc-theta_temp));
          if distance < r_small then
            points:=points+1;
          else
            points:=points;
          end if;
      end for;
      dAs_1[i,j] := max(1e-6,(num_points - points)/num_points);
    end for;
  end for;


  //check dAs_2

  for j in 1:nTheta+1 loop
    for i in 1:nR loop
      points := 0;
      for p in 1:num_points loop
          r_temp := rs_one[i] + (p-1)/num_points*drs[i];
          distance := sqrt(r_temp*r_temp + r_loc*r_loc - 2*r_loc*r_temp*cos(theta_loc-thetas_one[j]));
          if distance < r_small then
            points:= points+1;
          else
            points:=points;
          end if;
      end for;
      dAs_2[i,j] := max(1e-6,(num_points - points)/num_points);
    end for;
  end for;








end dAs_function;
