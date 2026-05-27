within NHES.Systems.EnergyStorage.PCM_HITB.CylindricalNodeOverlapEstimated;
pure function circleArcFractionInWedge
  "Arc length (and fraction of full circumference) of a circle that lies
   within the angular wedge [theta_min, theta_max].

   ── Coordinate convention ────────────────────────────────────────────────
     x = r·sin(θ),   y = r·cos(θ)
     θ = 0 → +y (up)   θ = π/2 → +x (right)   θ = π → −y (down)

   ── Key geometry ─────────────────────────────────────────────────────────
   Each wedge boundary is a LINE through the origin at angle θ_j.
   The signed perpendicular distance from the circle centre to that line is:

     d = x_c·cos(θ_j) − y_c·sin(θ_j)
       = r_loc·sin(θ_loc − θ_j)          [from trig identity]

   Sign convention: d > 0  ↔  centre is on the 'inside' of that boundary.

   The arc of the circle on the inside of the boundary:
     arc_angle = 2·arccos(−d / r_small)  for |d| ≤ r_small
               = 2π                       for  d ≥ r_small   (fully inside)
               = 0                        for  d ≤ −r_small  (fully outside)

   ── The 5 cases ──────────────────────────────────────────────────────────
   Using:
     d_min = r_loc·sin(θ_loc − θ_min)   [+ when centre is above θ_min]
     d_max = r_loc·sin(θ_max − θ_loc)   [+ when centre is below θ_max]

   Case 0  d_min ≤ −r_s  OR  d_max ≤ −r_s   → no arc in wedge
   Case 1  |d_min| < r_s AND d_max ≥  r_s   → θ_min boundary clips only
   Case 2   d_min ≥  r_s AND |d_max| < r_s   → θ_max boundary clips only
   Case 3   d_min ≥  r_s AND  d_max ≥  r_s   → circle fully inside wedge
   Case 4  |d_min| < r_s AND |d_max| < r_s   → both boundaries clip

   For Case 4 (inclusion-exclusion on two arcs sharing the full circle):
     arc_angle = 2·[arccos(−d_min/r_s) + arccos(−d_max/r_s) − π]
   clamped to 0 from below (handles the sub-case where arcs don't overlap).

   ── Assumptions ──────────────────────────────────────────────────────────
   • r_small < r_loc  (circle does not contain the origin).
     When r_loc ≈ 0 the function returns the exact sector-proportional value.
   • 0 < theta_max − theta_min < 2π  (valid sector width).
  "
//NOTE TO DANIEL: THIS IS FOR CALCULATING THE AMOUNT OF HEAT INPUT INTO A GIVEN NODE FROM A GIVEN HEAT PIPE
  input  Modelica.Units.SI.Length r_small    "Circle radius [m]";
  input  Modelica.Units.SI.Length r_loc      "Circle centre radial distance [m]";
  input  Modelica.Units.SI.Angle theta_loc  "Circle centre angle [rad]";
  input  Modelica.Units.SI.Angle theta_min  "Wedge start angle   [rad]";
  input  Modelica.Units.SI.Angle theta_max  "Wedge end   angle   [rad]   (> theta_min)";
//  input  Modelica.Units.SI.Length r_in "Inner radial value [m]";
//  input  Modelica.Units.SI.Length r_out "Outer radial value [m]";
  output Real arc_fraction "Arc inside wedge / full circumference  [−]  ∈ [0,1]";
  output Modelica.Units.SI.Length arc_length   "Arc inside wedge [m]";

protected
  Modelica.Units.SI.Length d_min   "Signed distance: centre → theta_min line  [m]";
  Modelica.Units.SI.Length d_max   "Signed distance: centre → theta_max line  [m]";
  Modelica.Units.SI.Angle alpha_min "Half arc-angle from theta_min boundary [rad]";
  Modelica.Units.SI.Angle alpha_max "Half arc-angle from theta_max boundary [rad]";
  Modelica.Units.SI.Angle arc_angle "Total arc angle inside wedge            [rad]";

algorithm
  // ── Special case: circle centred at/near origin ─────────────────────────
  // Circle is rotationally symmetric; arc proportional to wedge width.
  // ── Signed distances from centre to each boundary line ──────────────────
  d_min := r_loc * sin(theta_loc - theta_min);  // + → centre above theta_min
  d_max := r_loc * sin(theta_max - theta_loc);  // + → centre below theta_max

  // ── Case 0: no overlap ──────────────────────────────────────────────────
  if d_min <= -r_small or d_max <= -r_small then
    arc_angle := 0.0;

  // ── Case 3: circle fully inside wedge ───────────────────────────────────
  elseif d_min >= r_small and d_max >= r_small then
    arc_angle := 2.0 * Modelica.Constants.pi;

  // ── Case 1: only theta_min boundary clips ───────────────────────────────
  elseif d_max >= r_small then   // d_min in (−r_s, +r_s)
    alpha_min := acos(max(-1.0, min(1.0, -d_min / r_small)));
    arc_angle := 2.0 * alpha_min;

  // ── Case 2: only theta_max boundary clips ───────────────────────────────
  elseif d_min >= r_small then   // d_max in (−r_s, +r_s)
    alpha_max := acos(max(-1.0, min(1.0, -d_max / r_small)));
    arc_angle := 2.0 * alpha_max;

  // ── Case 4: both boundaries clip ────────────────────────────────────────
  else
    alpha_min := acos(max(-1.0, min(1.0, -d_min / r_small)));
    alpha_max := acos(max(-1.0, min(1.0, -d_max / r_small)));
    // Inclusion-exclusion: arc_in_both = arc_in_min + arc_in_max − full_circle
    // Clamped to 0 for the degenerate sub-case where arcs don't overlap.
    arc_angle := max(0.0, 2.0 * (alpha_min + alpha_max - Modelica.Constants.pi));
  end if;

  arc_fraction := arc_angle / (2.0 * Modelica.Constants.pi);
  arc_length   := r_small * arc_angle;

end circleArcFractionInWedge;
