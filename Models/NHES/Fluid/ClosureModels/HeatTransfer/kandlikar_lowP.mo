within NHES.Fluid.ClosureModels.HeatTransfer;
function kandlikar_lowP
  "Kandlikar correlation to calculate two phase heat transfer coefficient in low pressure situations"
  import TRANSFORM;
  /*
.

Notes:
Saturated fluid properties are based on the bulk fluid temperature and pressure.

  */
  //Constants
 // Modelica.SIunits.HeatFlux q = 100000;
  input SI.Length D "Characteristic dimension (e.g., hydraulic diameter)";
  // Variables
  input TRANSFORM.Units.MassFlux G(min = 1e-8) "Mass flux";
  input TRANSFORM.Units.NonDim x(min=0.0, max=1.0) "Absolute Steam quality";
  input Modelica.Units.SI.HeatFlux q "Heat flux";
  input SI.Density rhof "Saturated liquid density";
  input SI.Density rhog "Vapour density";
  input SI.SpecificEnthalpy h_fg "Latent heat of vaporization";
  output Real twophmult;
protected
  Real C1;
  Real C2;
  Real C3;
  Real C4;
  Real Co;
  Real Bo;
  Real xf;
  Real rhofr;
 // Real q;
algorithm
  //q:= 100000;
  // Source 1: eq. A-10
  if G <= 0 or h_fg <= 0 then
    Bo := 1;
   else
  Bo := q/(G*h_fg);
  end if;
  if x<= 0.0 or x >=1 or Bo < 0 then
    twophmult := 1;
  elseif x <= 0.02 and x > 0 then
    xf := (1-x)/x;
    rhofr :=rhog/rhof;
    Co := xf^0.8*rhofr^0.5;
 // Co := ((1-x)/(abs(x)+1e-7))^0.8*(rhog/rhof)^0.5;
  C1 := TRANSFORM.Math.spliceTanh(0.6683,1.136,Co-0.65,0.1);
  C2 := TRANSFORM.Math.spliceTanh(-0.2,-0.9,Co-0.65,0.1);
  C3 := TRANSFORM.Math.spliceTanh(1058,667.2,Co-0.65,0.1);
  C4 := 0.7;
  twophmult := TRANSFORM.Math.spliceTanh(C1*Co^C2 + C3*Bo^C4,1,x-0.01,0.02);
  elseif x<1 and x>= 0.9 then
    xf := (1-x)/x;
    rhofr :=rhog/rhof;
    Co := xf^0.8*rhofr^0.5;
//  Co := ((1-x)/x)^0.8*(rhog/rhof)^0.5;
  C1 := TRANSFORM.Math.spliceTanh(0.6683,1.136,Co-0.65,0.1);
  C2 := TRANSFORM.Math.spliceTanh(-0.2,-0.9,Co-0.65,0.1);
  C3 := TRANSFORM.Math.spliceTanh(1058,667.2,Co-0.65,0.1);
  C4 := 0.7;
  twophmult := TRANSFORM.Math.spliceTanh(1,C1*Co^C2 + C3*Bo^C4,x-0.9,0.1);
  else
    xf := (1-x)/x;
    rhofr :=rhog/rhof;
    Co := xf^0.8*rhofr^0.5;
 // Co := ((1-x)/x)^0.8*(rhog/rhof)^0.5;
  C1 := TRANSFORM.Math.spliceTanh(0.6683,1.136,Co-0.65,0.1);
  C2 := TRANSFORM.Math.spliceTanh(-0.2,-0.9,Co-0.65,0.1);
  C3 := TRANSFORM.Math.spliceTanh(1058,667.2,Co-0.65,0.1);
  C4 := 0.7;
  twophmult := C1*Co^C2 + C3*Bo^C4;

  end if;
  annotation (Documentation(info="<html>
<p>Chen&apos;s correlation for the computation of the heat transfer coefficient in two-phase flows. </p>
</html>"));
end kandlikar_lowP;
