within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
function vg "Function to compute saturated vapor specific volume"

  input Real P; //Pressure in psia
  output Real vg; //Specific Volume in ft^3/lbm

protected
 Real sum;
 parameter Real a[7]={5931.557,1142.2341,171.5671,41.76546,
     11.64542,3.264609,0.8898603};
 parameter Real b[7]={11.60044,1.990131,0.3299698,
                                                 0.0806798,
     0.0200894,
              4.596498e-3,7.761257e-4};

algorithm

    sum:=0;
    for i in 1:7 loop
      sum:=sum + a[i]*exp(-b[i]*P);
    end for;
    vg:=sum;
end vg;
