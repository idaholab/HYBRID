within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function circleRingThetaIntersections
  "Angular positions (θ) where a small circle crosses a ring of radius r_large.
   Returns n_int ∈ {0,1,2} intersection angles, normalised to [0, 2π) and
   sorted ascending."
  input  Modelica.Units.SI.Length    r_small     "Small circle radius [m]";
  input  Modelica.Units.SI.Length    r_loc       "Small circle centre — radial distance [m]";
  input  Real    theta_loc   "Small circle centre — angle [rad]";
  input  Modelica.Units.SI.Length    r_large     "Ring radius [m]";
  output Integer n_int       "Number of intersections: 0, 1, or 2";
  output Real    theta_int[2] "Intersection angles [rad] ∈ [0, 2π), sorted ascending
                               — only theta_int[1..n_int] are valid";
protected
  Real cos_val   "cos(Δθ) from law of cosines";
  Real delta     "arccos(cos_val) ∈ [0, π]";
  Real t1, t2    "Raw (un-normalised) candidate angles";
  Real twoPi = 2.0 * Modelica.Constants.pi;
algorithm
  theta_int := {0.0, 0.0};

  // Special case: centre at origin — circle is symmetric, no unique theta crossings
  if r_loc < 1.0e-12 then
    n_int := 0;
    return;
  end if;

  cos_val := (r_large^2 + r_loc^2 - r_small^2)
           / (2.0 * r_large * r_loc);

  if cos_val > 1.0 + 1.0e-10 or cos_val < -1.0 - 1.0e-10 then
    // Circles do not intersect
    n_int := 0;

  elseif cos_val >= 1.0 then
    // Tangent: circles touch at θ_loc (nearest point on ring to circle centre)
    n_int          := 1;
    theta_int[1]   := mod(theta_loc, twoPi);

  elseif cos_val <= -1.0 then
    // Tangent: circles touch at θ_loc + π (farthest point on ring)
    n_int          := 1;
    theta_int[1]   := mod(theta_loc + Modelica.Constants.pi, twoPi);

  else
    // Two intersections at θ_loc ± Δθ
    n_int := 2;
    delta := acos(cos_val);          // Δθ ∈ (0, π)
    t1    := mod(theta_loc - delta, twoPi);
    t2    := mod(theta_loc + delta, twoPi);
    // Sort ascending
    if t1 <= t2 then
      theta_int[1] := t1;
      theta_int[2] := t2;
    else
      theta_int[1] := t2;
      theta_int[2] := t1;
    end if;
  end if;
end circleRingThetaIntersections;
