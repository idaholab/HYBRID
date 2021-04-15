within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
function Cpl "Function to compute specific heat of liquid water"
  input Real T; //Temperature in F
  input Real P; //Pressure in psia
  output Real Cpl; //Liquid Viscosity of Water

protected
  Real a[3]={0.98850267,3.11434479e-4,9.79793383e-27};
  Real b[3]={1.00787645e-4,0.01223534,0.08836906};
  Real aa[3]={0.03500856,7.40539427e-4,-1.30297916e-6};
  Real bb[4]={0.41844219,-7.71336906e-3,3.23610762e-5,-3.94022105e-8};

  Real DeltaT;
  Real Cpsat;
  Real R;

algorithm
  DeltaT :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
    P) - T;
  Cpsat:=0;
  for i in 1:3 loop
    Cpsat:=Cpsat + a[i]*exp(b[i]*T);
  end for;
   R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2)*(bb[1] + bb[2]*T + bb[3]*T^2 + bb[
    4]*T^3);
   Cpl:=Cpsat + R;

end Cpl;
