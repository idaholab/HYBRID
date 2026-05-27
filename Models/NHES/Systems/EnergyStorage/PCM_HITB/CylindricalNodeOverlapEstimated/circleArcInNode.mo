within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function circleArcInNode "Calculating arc fraction of a circle at point (r_loc, theta_loc)
and radius r_small  within a given [nR, nTheta] discretization scheme. 
Polar midpoint quadrature centered on the circle.
Note that the method is discrete, not continuous, measuring num_points around arc of the small circle.
Currently only works for 
Angle is measured clockwise with 0 at point (0,1) and 90 degrees at (1,0)"
  input Real    r_small, r_loc, theta_loc;
  input Integer nR   = 5;
  input Integer nTheta = 6;
  input Real drs[nR] = 2*r_loc/nR*ones(nR);
  input Real dthetas[nTheta] = Modelica.Constants.pi/nTheta*ones(nTheta);
  input Integer num_points = 360;
  output Real arc_frac[nR, nTheta];
  output Real arc_length[nR, nTheta];

protected
  Real phi_t, x_pt, y_pt, r_pt, theta_pt;
  Real rs_one[nR+1];
  Real thetas_one[nTheta+1];
  Boolean isinr, isintheta;
algorithm
  arc_frac :=zeros(nR, nTheta);
  arc_length :=zeros(nR, nTheta);
  rs_one[1] := 0;
    for i in 1:nR loop
      rs_one[i+1] := rs_one[i] + drs[i];
    end for;
    thetas_one[1] := 0;
    for j in 1:nTheta loop
      thetas_one[j+1] := thetas_one[j]+dthetas[j];
    end for;

  for t in 1:num_points loop
    phi_t :=Modelica.Constants.pi*t/180; //current angle point checked
    x_pt :=r_loc*sin(theta_loc) + r_small*cos(phi_t);
    y_pt :=r_loc*cos(theta_loc) + r_small*sin(phi_t);
    r_pt :=sqrt(x_pt*x_pt + y_pt*y_pt);
    theta_pt := if atan2(x_pt, y_pt)<0 then Modelica.Constants.pi*2 + atan2(x_pt, y_pt) else atan2(x_pt, y_pt);
    for i in 1:nR loop
        if r_pt > rs_one[i] and r_pt < rs_one[i+1] then
          isinr := true;
        else
          isinr := false;
        end if;
      for j in 1:nTheta loop
        if theta_pt > thetas_one[j] and theta_pt < thetas_one[j+1] then
          isintheta :=true;
        else
          isintheta:=false;
        end if;
        if isinr and isintheta then
          arc_frac[i,j] := arc_frac[i,j] + 1/num_points;
          arc_length[i,j] := arc_length[i,j] + 2*Modelica.Constants.pi/num_points*r_small;
        else
          arc_frac[i,j] := arc_frac[i,j];
          arc_length[i,j] := arc_length[i,j];
        end if;
      end for;
    end for;
  end for;
end circleArcInNode;
