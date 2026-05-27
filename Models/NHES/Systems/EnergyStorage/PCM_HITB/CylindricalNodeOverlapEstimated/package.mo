within NHES.Systems.EnergyStorage.PCM_HITB;
package CylindricalNodeOverlapEstimated "Coincident area fractions of a small circle with cylindrical polar
   discrete nodes [i,j] in [1,nR] x [1,nTheta].

   Grid spacing is supplied as non-uniform differential vectors:
     drs  [nR]     – radial widths    of each ring   [m]
     dphis[nTheta] – angular widths   of each sector [rad]

   Coordinate convention (inverted from standard polar):
     x = r * sin(theta)
     y = r * cos(theta)
   so  theta = 0   → vertically upward   (+y axis)
       theta = π   → vertically downward  (−y axis)
       theta = π/2 → rightward            (+x axis)"

  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------


// =============================================================================
// PRIMITIVE 1
// Theta intersection points of a small circle with a ring of radius r_large.
//
// Convention: x = r·sin(θ),  y = r·cos(θ)
//
// Derivation
// ----------
// Small circle centre in Cartesian: (x_c, y_c) = (r_loc·sin θ_loc, r_loc·cos θ_loc)
// Large ring (circle at origin, radius r_large): x² + y² = r_large²
//
// Subtracting the two circle equations eliminates the quadratic terms,
// leaving the radical-axis line:
//   x·x_c + y·y_c = ½(r_large² + r_loc² − r_small²)  ≡ k
//
// On the ring, write x = r_large·sin θ, y = r_large·cos θ.  Substituting:
//   r_large·r_loc·[sin θ·sin θ_loc + cos θ·cos θ_loc] = k
//   r_large·r_loc·cos(θ − θ_loc) = k
//
// This is just the law of cosines → cos(Δθ) = (r_large²+r_loc²−r_small²)/(2·r_large·r_loc)
//
// Intersection angles:  θ = θ_loc ± arccos(cos_val),  normalised to [0, 2π).
//
// Cases
// -----
//   cos_val >  1  → circles too far apart, no intersection
//   cos_val < −1  → small circle encloses large ring or vice-versa, no intersection
//   cos_val =  1  → tangent at θ_loc               (n_int = 1)
//   cos_val = −1  → tangent at θ_loc + π           (n_int = 1)
//   |cos_val| < 1 → two intersections at θ_loc ± Δθ (n_int = 2)
// =============================================================================


// =============================================================================
// PRIMITIVE 2
// Radial (r) intersection points of a small circle with a ray from the origin.
//
// Convention: x = r·sin(θ),  y = r·cos(θ)
//
// Derivation
// ----------
// Ray at angle θ_ray:  x(t) = t·sin θ_ray,  y(t) = t·cos θ_ray,  t ≥ 0.
// (t is the radial distance along the ray from the origin.)
//
// Substituting into (x − x_c)² + (y − y_c)² = r_small²:
//   t² − 2t·D + r_loc² − r_small² = 0
//
// where  D = x_c·sin θ_ray + y_c·cos θ_ray = r_loc·cos(θ_ray − θ_loc)
//        (D is the projection of the circle centre onto the ray direction)
//
// Discriminant:  disc = D² − (r_loc² − r_small²)
//                     = r_small² − r_loc²·sin²(Δθ),   Δθ = θ_ray − θ_loc
//   disc < 0 → ray line misses circle entirely
//   disc = 0 → ray line tangent to circle  (t = D)
//   disc > 0 → two solutions  t = D ± √disc
//
// Only solutions with t ≥ 0 are on the ray (positive radial direction).
//
// Cases (disc > 0)
// ----------------
//   t2 < 0           → both intersections behind origin   (n_int = 0)
//   t1 < 0 ≤ t2      → origin is inside the circle        (n_int = 1, r = t2)
//   0 ≤ t1 ≤ t2      → ray passes through circle          (n_int = 2)
// =============================================================================

  annotation();
end CylindricalNodeOverlapEstimated;
