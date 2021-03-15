within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
function ho_IHX "convective heat transfer coefficient for IHX"
extends Modelica.Icons.Function;
//extends TESSystem.PartialScalarfunctionforho_IHX;
extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
  //input Real TwIHX (u); //Wall Temperature in (F)
  input Real P_IHX; //Pressure in the IHX (pisa)
  input Real ktube; // tube thermal conductivity
  input Real ro_IHX; //tube inner radius
  input Real ri_IHX; //tube outer radius
  input Real hi; // heat transfer coefficient for inside the tubes
  input Real Tc1; // temperature entering the tubes
  input Real Tc2; // temperature at exit of intermediate heat exchanger
  input Real dihx; // diameter of IHX tube
  //output Real ho_IHX (y); // Convective heat transfer coefficient

protected
  Real g=4.17e8; // conversion factor for
  Real AA;
  Real BB,B;
  Real TsatIHX;
  Real hfg1;
  Real hcondens;
  Real Tcavg;
algorithm
  TsatIHX := NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.Tsat(P_IHX);
// A:=((rhof(P_IHX)*(rhof(P_IHX) - rhog(P_IHX)))*g*(kl(TsatnewIHX, P_IHX)^3.0));
//
// hfg1:=hfg(P_IHX);
 B:=((1./ktube)*log(ro_IHX/ri_IHX) + (1./(hi*ri_IHX)))^(-1.0);

AA:=NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX)*
   (NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_IHX))*g*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.kl(TsatIHX,P_IHX)^3);

hfg1:=NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.hfg(P_IHX)*((1 +
     (0.68*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.Cpl(TsatIHX,P_IHX)*(TsatIHX -
    u))/NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.hfg(P_IHX)));

BB:=NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.Viscosity(TsatIHX,P_IHX)*dihx*(TsatIHX - u);

Tcavg:=(Tc1 + Tc2)/2.;

hcondens:=0;
 if u < TsatIHX then
// hcondens:=(((A*((hfg1 + (0.68*Cpl(TsatnewIHX, P_IHX)*(TsatnewIHX - u)))))/(
//       Viscosity(TsatnewIHX, P_IHX)*dihx*(TsatnewIHX - u)))^(0.25))*0.725;

hcondens:=0.725*((AA*hfg1/BB)^0.25);
 end if;
y:=hcondens*ro_IHX*(TsatIHX - u) - B*(u - Tcavg);
end ho_IHX;
