within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function Viscosity "Function to Compute Liquid Viscosity"
  input Real T; //Temperature in F
  input Real P; //Pressure in psia
  output Real Viscosity; //Liquid Viscosity of Water

protected
  Real a[3]={3.69971196,4.27115194,0.75003508};
  Real b[3]={-0.01342834,-0.03890983,-2.19455284e-3};
  Real aa[4]={8.52917235e-4,-4.17979848e-5,2.6043459e-7,-2.20531928e-11};
  Real bb[4]={-1.13658775,0.01495184,-2.86548888e-5,2.17440064e-9};

  Real DeltaT;
  Real Vsat;
  Real R;
algorithm
  DeltaT :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
    P) - T;
  for i in 1:3 loop
    Vsat:=Vsat + a[i]*exp(b[i]*T);
  end for;
 R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2 + aa[4]*DeltaT^3)*(bb[1] + bb[2]*T
     + bb[3]*T^2 + bb[4]*T^3);
 Viscosity:=Vsat + R;

end Viscosity;
