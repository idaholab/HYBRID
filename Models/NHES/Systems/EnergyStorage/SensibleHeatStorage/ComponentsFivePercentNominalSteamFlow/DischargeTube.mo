within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
model DischargeTube
  Modelica.Blocks.Interfaces.RealInput P_HT
    annotation (Placement(transformation(extent={{-124,60},{-100,84}})));
  Modelica.Blocks.Interfaces.RealInput T_HT
    annotation (Placement(transformation(extent={{-124,16},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput P_CT
    annotation (Placement(transformation(extent={{-124,38},{-100,62}})));
  Modelica.Blocks.Interfaces.RealOutput T_CT(start=400, fixed=true)
    annotation (Placement(transformation(extent={{100,54},{120,74}})));
  Modelica.Blocks.Interfaces.RealOutput m_tes2(start=0.0001)
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealInput H_CT
    annotation (Placement(transformation(extent={{-124,-8},{-100,16}})));
  Modelica.Blocks.Interfaces.RealInput P_Boiler
    annotation (Placement(transformation(extent={{-124,-36},{-100,-12}})));
  Modelica.Blocks.Interfaces.RealInput Relativedemand
    annotation (Placement(transformation(extent={{-124,-82},{-100,-58}})));
  Modelica.Blocks.Interfaces.RealInput m_LPT
    annotation (Placement(transformation(extent={{-124,-58},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealOutput FCV2Error
    annotation (Placement(transformation(extent={{100,-16},{120,4}})));
  Modelica.Blocks.Interfaces.RealOutput Q_TES(start=1)
    annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
  Modelica.Blocks.Interfaces.RealInput KFCV2
    annotation (Placement(transformation(extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={-91,111})));

parameter Real cp_tes=0.614 "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
parameter Real rho_tes=50.473 "Density of Therminol-66 at ~450F (lbm/ft^3)";
parameter Real k_tes=0.055 "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
parameter Real mu_tes=0.992 "dynamic viscosity of Therminol-66 (lbm/ft-hr)";
parameter Real ktube=10.3 "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
parameter Real KFCV2line=100;
parameter Real A_FCV2=2.5 "Area of FCV2 in ft^2";
parameter Real dPumpFCV2=32413 "Pump Power of the pump running from cold tank to hot tank";
//parameter Real KFCV2;
//parameter Real Vinnerboiler=1500 "Volume inside tubes";
parameter Real Tamb=0 "Ambient Temperature Outside of the Tanks (F)";
parameter Real UA_CT=0 "Effective Heat Transfer out of Hot Tank";
parameter Real A_CT=133333 "Cross Sectional Area of Cold Tank (ft^2)";
//parameter Real Ax_Boiler_inner "Cross Sectional Area of inner tubes (ft^2)";
parameter Real De_tubes=0.044 "Effective Diameter of tube side (ft)";
parameter Real ntubes=32761 "Number of tubes running through the Boiler";
parameter Real Ltube=15 "Length of tubes running through the Boiler (ft)";
parameter Real ri=0.022 "Tube Inner Radius (ft)";
parameter Real ro=0.029 "Tube Outer Radius (ft)";
parameter Real Pcond=0.7;
parameter Real Wnominal=180;
parameter Real Wpeakdesign=45;

//Real m_tes2;
Real T_Boilerexit(start=410);
//Real Q_TES;
Real Pr,Re,Nui,hi;
Real UA;
Real A,B,C;
Real ho;
Real UiPw;
Real Chi;
Real eta;
Real delTw;
Real TbarB(start=490);
Real BetaB;
Real AA,BB,DeltaTm;
Real Vinnerboiler;
Real Ax_Boiler_inner;
Real FlowErr, FlowErr1,FlowErr2;
Real eff;
Real Wdemand;
Real Wturb,CC;
Real DelTdesign;
Real m_tes2ref;
Real m_tes2demand;
Real m_tes2kghr;
protected
 Real gc=32.17; //converts (lbm/sec^2/ft) to lbf/ft^2
 Real g=4.17e8; //For heat transfer correlations
 Real conv1=144; //converts to psia to lbf/ft^2
 Real pi=3.14159;
 Real G1=0.2, G2=8.;

equation
Vinnerboiler=pi*ntubes*(ri^2)*Ltube;
Ax_Boiler_inner=pi*ntubes*(ri^2);
//Momentum Equation
P_HT*conv1+dPumpFCV2=P_CT*conv1+((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));

//Tube Energy Equation
Vinnerboiler*rho_tes*cp_tes*der(T_Boilerexit)=m_tes2*cp_tes*(T_HT-T_Boilerexit)-Q_TES;  //Might want to check this at some point

//Cold Tank Energy Equation
//T_CT=0;
rho_tes*A_CT*H_CT*der(T_CT)=m_tes2*cp_tes*(T_Boilerexit-T_CT)-UA_CT*(T_CT-Tamb);

assert(m_tes2>=0, "m_tes2 wrong");

algorithm
  Pr:=cp_tes*mu_tes/k_tes;
  Re:=m_tes2*3600*De_tubes/(Ax_Boiler_inner*mu_tes);
  Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.3)); //This is cooling the fluid hence 0.3 on the coefficient
  hi:=k_tes*Nui/De_tubes;

  A:=(1/(hi*ri));
  B:=log(ro/ri)/ktube;

  UiPw:=2*pi*((A + B)^(-1));

  eta:=(exp(2*P_Boiler/1260)/(72^2))*1000000;
  Chi:=UiPw/(2*pi*ro*eta);

  delTw := (-Chi/2.) + (0.5)*sqrt((Chi^2. + 4.*Chi*(TbarB -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
    P_Boiler))));

  ho:=eta*(delTw);

//Solve for the

  C:=(1/(ho*ro));
 // C:=0;
  UA:=2*pi*ntubes*Ltube/(A + B + C);
  //Solves for the Heat Transfer Rate

//Determining the average temperature of the TES fluid
if m_tes2 > 0.001 then
BetaB:=UA/(m_tes2*3600*cp_tes);
    TbarB :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
      P_Boiler) - ((
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
      P_Boiler) - T_HT)/BetaB)*(1 - exp(-BetaB));

    AA := T_HT -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
      P_Boiler);

    CC :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
      P_Boiler);
    BB := T_Boilerexit -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.Tsat(
      P_Boiler);
    if BB > 0.1 and m_tes2 > 0.1 then
    DeltaTm:=(T_HT - T_Boilerexit)/(log(AA/BB));

    //Q_TES:=UA*(DeltaTm)/3600;
    Q_TES:=UA*(TbarB - CC)/3600;
    else
      Q_TES:=1.;
    end if;
else
  Q_TES:=1;
  end if;
//Determine the error on the amount of turbine bypass needed

//Wdemand=Relative_Demand
eff:=1.;//(Assumes a total cycle efficiency of "x"%

  Wturb := m_LPT*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.hg(
    P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.hf(
    Pcond))*eff/947.817;                                                          //MW

Wdemand:=(Relativedemand-100)*Wnominal/100;
if Wdemand <= 0 then
  Wdemand:=0;
end if;
//Error Simulator for the FCV (Will be based on peaking needed//
//FlowErr

DelTdesign:=100;
m_tes2ref:=Wpeakdesign*3.412e06/(cp_tes*3600*(DelTdesign));
m_tes2demand:=m_tes2ref*(Wdemand/Wpeakdesign)+m_tes2ref*((Wdemand - Wturb)/Wpeakdesign);
m_tes2kghr:=m_tes2*3600/2.2;
FlowErr1:=((m_tes2demand - m_tes2)/m_tes2ref);
FlowErr2:=(Wdemand - Wturb)/Wpeakdesign;

FlowErr:=G1*FlowErr1 + G2*FlowErr2;
  if FlowErr > 1 then
    FlowErr:=1;
  elseif FlowErr < -1 then
    FlowErr:=-1;
  end if;
FCV2Error:=FlowErr;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DischargeTube;
