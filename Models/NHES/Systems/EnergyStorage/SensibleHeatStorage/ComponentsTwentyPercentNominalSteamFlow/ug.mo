within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
function ug "Function to compute saturated vapor internal energy (Btu/lbm)"

  input Real P;
  output Real ug;

  parameter Real a[8]={961.57632930,-0.06346313,2.69645643e-5,-2.46758641e-8,
            9.45803668e-12,-1.53574346e-15,82.19290877,0.13028136};

algorithm
  ug:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];
  //gives the answer in Btu/lbm

  //external "FORTRAN 77";
  //annotation(Include="include 'main.f'");
  //annotation(Library = "main.f");
//annotation(Library="ug.o");

annotation(derivative=dug);
end ug;
