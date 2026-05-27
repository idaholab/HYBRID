within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function circleRayRIntersections
  "Radial positions (r) where a small circle crosses a ray from the origin
   at angle theta_ray.
   Returns n_int ∈ {0,1,2} radial distances, sorted ascending.
   — only r_int[1..n_int] are valid."
  input  Modelica.Units.SI.Length    r_small    "Small circle radius [m]";
  input  Modelica.Units.SI.Length    r_loc      "Small circle centre — radial distance [m]";
  input  Real    theta_loc  "Small circle centre — angle [rad]";
  input  Real    theta_ray  "Ray angle [rad]";
  output Integer n_int      "Number of valid (t ≥ 0) intersections: 0, 1, or 2";
  output Modelica.Units.SI.Length    r_int[2]   "Radial distances of intersection points [m], sorted ascending
                             — only r_int[1..n_int] are valid";
protected
  Real delta_theta "theta_ray − theta_loc";
  Modelica.Units.SI.Length D           "Projection of circle centre onto ray [m]";
  Real disc        "Quadratic discriminant [m²]";
  Real sqrtDisc;
  Real t1, t2;
algorithm
  r_int       := {0.0, 0.0};
  delta_theta := theta_ray - theta_loc;
  D           := r_loc * cos(delta_theta);
  disc        := r_small^2 - r_loc^2 * sin(delta_theta)^2;

  if disc < 0.0 then
    // Perpendicular distance from centre to ray line exceeds r_small
    n_int := 0;

  elseif disc < 1.0e-20 then
    // Tangent: single contact point at t = D
    if D >= 0.0 then
      n_int    := 1;
      r_int[1] := D;
    else
      // Tangent point is behind the origin
      n_int := 0;
    end if;

  else
    sqrtDisc := sqrt(disc);
    t1       := D - sqrtDisc;   // closer intersection (smaller r)
    t2       := D + sqrtDisc;   // farther  intersection (larger r)

    if t2 < 0.0 then
      // Both intersections in the −t (behind-origin) direction
      n_int := 0;

    elseif t1 < 0.0 then
      // Origin lies inside the circle; only the forward intersection is on the ray
      n_int    := 1;
      r_int[1] := t2;

    else
      // Both intersections ahead of the origin
      n_int    := 2;
      r_int[1] := t1;
      r_int[2] := t2;
    end if;
  end if;
end circleRayRIntersections;
