within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function kl "Function to Compute the Thermal Conductivity of Water"
  input Real T; //Temperature in F
  input Real P; //Pressure in psia
  output Real kl; //thermal conductivity of water

protected
  Real a[6]={0.28956598,9.98373531e-4,-2.76514034e-6,1.31610616e-9,
          3.99581573e-12,-5.18550975e-15};
  Real aa[6]={-3.51256646e-3,6.04273366e-5,2.48976537e-7,3.85754267e-11,
         -1.59857317e-13,2.20172921e-16};
  Real bb[6]={-0.01305876,9.88477177e-4,-5.52334508e-6,6.66724984e-9,
          3.03459927e-11,-3.78351489e-14};

  Real DeltaT;
  Real Ksat;
  Real R;

algorithm
  DeltaT :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
    P) - T;
  Ksat:=0;

for i in 1:6 loop
  Ksat:=Ksat + a[i]*T^(i - 1);
end for;
      R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2 + aa[4]*DeltaT^3 + aa[5]*DeltaT^
    4 + aa[6]*DeltaT^5)*(bb[1] + bb[2]*T + bb[3]*T^2 + bb[4]*T^3 + bb[5]*T^4 +
    bb[6]*T^5);

kl:=Ksat + R;
end kl;
