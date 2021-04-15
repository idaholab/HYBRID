within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function Brent_ho_IHX
  "Nonlinear Solver for the convective heat transfer coefficient in the IHXSolve f(u) = 0 in a very reliable and efficient way (f(u_min) and f(u_max) must have different signs)"
  extends Modelica.Icons.Function;
  import Modelica.Utilities.Streams.error;

  input TESSystem.PartialScalarfunctionforho_IHX f
    "Function y = f(u); u is computed so that y=0";
  input Real u_min "Lower bound of search interval";
  input Real u_max "Upper bound of search interval";

//Addition to ensure data is passed properly
  input Real P_IHX; //Pressure in the IHX (psia)
  input Real ktube; // tube thermal conductivity
  input Real ro_IHX; //tube inner radius
  input Real ri_IHX; //tube outer radius
  input Real hi; // heat transfer coefficient for inside the tubes
  input Real Tc1; // temperature entering the tubes
  input Real Tc2; // temperature at exit of intermediate heat exchanger
  input Real dihx; // diameter of IHX tube
  //End of addition to make sure data is passed properly.

  input Real tolerance=100*Modelica.Constants.eps
    "Relative tolerance of solution u";
  output Real u "Value of independent variable u so that f(u) = 0";

protected
  constant Real eps=Modelica.Constants.eps "machine epsilon";
  Real a=u_min "Current best minimum interval value";
  Real b=u_max "Current best maximum interval value";
  Real c "Intermediate point a <= c <= b";
  Real d;
  Real e "b - a";
  Real m;
  Real s;
  Real p;
  Real q;
  Real r;
  Real tol;
  Real fa "= f(a)";
  Real fb "= f(b)";
  Real fc;
  Boolean found=false;
algorithm
  // Check that f(u_min) and f(u_max) have different sign
  fa := f(u_min,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);
  fb := f(u_max,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);
  fc := fb;
  if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
    error(
      "The arguments u_min and u_max provided in the function call\n"+
      "    solveOneNonlinearEquation(f,u_min,u_max)\n" +
      "do not bracket the root of the single non-linear equation 0=f(u):\n" +
      "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max)
       + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" +
      "  fb = f(u_max) = " + String(fb) + "\n" +
      "fa and fb must have opposite sign which is not the case");
  end if;

  // Initialize variables
  c := a;
  fc := fa;
  e := b - a;
  d := e;

  // Search loop
  while not found loop
    if abs(fc) < abs(fb) then
      a := b;
      b := c;
      c := a;
      fa := fb;
      fb := fc;
      fc := fa;
    end if;

    tol := 2*eps*abs(b) + tolerance;
    m := (c - b)/2;

    if abs(m) <= tol or fb == 0.0 then
      // root found (interval is small enough)
      found := true;
      u := b;
    else
      // Determine if a bisection is needed
      if abs(e) < tol or abs(fa) <= abs(fb) then
        e := m;
        d := e;
      else
        s := fb/fa;
        if a == c then
          // linear interpolation
          p := 2*m*s;
          q := 1 - s;
        else
          // inverse quadratic interpolation
          q := fa/fc;
          r := fb/fc;
          p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
          q := (q - 1)*(r - 1)*(s - 1);
        end if;

        if p > 0 then
          q := -q;
        else
          p := -p;
        end if;

        s := e;
        e := d;
        if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
          // interpolation successful
          d := p/q;
        else
          // use bi-section
          e := m;
          d := e;
        end if;
      end if;

      // Best guess value is defined as "a"
      a := b;
      fa := fb;
      b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
      fb := f(b,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);

      if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
        // initialize variables
        c := a;
        fc := fa;
        e := b - a;
        d := e;
      end if;
    end if;
  end while;

  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max);
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>Description</h4>

<p>
This function determines the solution of <b>one non-linear algebraic equation</b> \"y=f(u)\"
in <b>one unknown</b> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
have a different sign. The function computes a smaller interval
in which a sign change is present using the relative tolerance
\"tolerance\" that can be given as 4th input argument.
</p>

<p>
The interval reduction is performed using
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<blockquote>
<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.<br>
     Download: <a href=\"http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf\">http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf</a><br>
     Errata and new print: <a href=\"http://wwwmaths.anu.edu.au/~brent/pub/pub011.html\">http://wwwmaths.anu.edu.au/~brent/pub/pub011.html</a>
</dd>
</dl>
</blockquote>

<h4>Example</h4>

<p>
See the examples in <a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>
</html>"));
end Brent_ho_IHX;
