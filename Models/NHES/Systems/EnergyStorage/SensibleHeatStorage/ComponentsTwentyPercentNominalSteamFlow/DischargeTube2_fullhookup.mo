within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model DischargeTube2_fullhookup
  Modelica.Blocks.Interfaces.RealInput T_HT
    annotation (Placement(transformation(extent={{-124,16},{-100,40}})));
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

parameter Real cp_tes=0.614              "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
parameter Real rho_tes=50.473            "Density of Therminol-66 at ~450F (lbm/ft^3)";
parameter Real k_tes=0.055               "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
parameter Real mu_tes=0.992              "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
parameter Real ktube=10.3                "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
parameter Real KFCV2line=100             "Assumed Line Loss for FCV2 line";
parameter Real A_FCV2=2.5                "Area of FCV2 in ft^2";
parameter Real dPumpFCV2=32413           "Pump Power of the pump running from cold tank to hot tank";
parameter Real Tamb=0                    "Ambient Temperature Outside of the Tanks (F)";
parameter Real UA_CT=0                   "Effective Heat Transfer out of Hot Tank";
parameter Real A_CT=133333               "Cross Sectional Area of Cold Tank (ft^2)";
parameter Real De_tubes=0.044            "Effective Diameter of tube side (ft)";
parameter Real ntubes=32761              "Number of tubes running through the Boiler";
parameter Real Ltube=30                  "Length of tubes running through the Boiler (ft)";
parameter Real ri=0.022                  "Tube Inner Radius (ft)";
parameter Real ro=0.029                  "Tube Outer Radius (ft)";
parameter Real Pcond=0.7                 "Assumed Pressure of Condensor (psia)";
parameter Real Wnominal=180              "Nominal Turbine Output (MWe)";
parameter Real Wpeakdesign=45            "Designed TES System Peaking Capacity (MWe)";

Real T_Boilerexit(start=410);            //Temperature of the TES fluid exiting the Boiler (F)
Real Pr,Re,Nui;                          //Prandtl Number, Reynolds Number, Nusselt Number
Real hi;                                 //Inner Tube Convective Heat Transfer Coefficient
Real UA;                                 //Heat Transfer Area (e.g. UA value associated with tubes of Boiler)
Real A,B,C;                              //Dummy Variables
Real ho;                                 //Outer Shell Convective Heat Transfer Coefficient
Real UiPw;
Real Chi;                                //Dummy Variable
Real eta;                                //Dummy Variable
Real delTw;                              //Wall Superheat
Real TbarB(start=490);                   //Effective Average TES Temperature along whole tube length (F)
Real BetaB;                              //Dummy Variable
Real AA,BB,DeltaTm;                      //Dummy Variable, Dummy Variable, Log mean Temperature Difference
Real Vinnerboiler;                       //Volume of tubes
Real Ax_Boiler_inner;                    //Cross Sectional Area of Tubes
Real FlowErr, FlowErr1,FlowErr2;         //Flow Errors used to Open and Close Valves associated with Tubeside of Boiler
Real eff;                                //Assumed Turbine Efficiency
Real Wdemand;                            //Turbine Demand (MWe)
Real Wturb,CC;                           //Turbine Output (MWe), Dummy Variable
Real DelTdesign;                         //Designed DeltaT between the Hot Tank and Cold Tank (F)
Real m_tes2ref;                          //Reference TES flow rate (lbm/sec)
Real m_tes2demand;                       //TES flow rate demand (lbm/sec)
Real m_tes2kghr;                         //TES flow rate in kg/hr
Real x_exhturb;                          //quality at exit of turbine if turbine is assumed isentropic
Real h_exhturb;                          //turbine exit enthalpy if turbine is assumed isentropic
Real Woutput;                            //Output of Turbine
protected
 Real gc=32.17;                          //converts (lbm/sec^2/ft) to lbf/ft^2
 Real g=4.17e8;                          //For heat transfer correlations
 Real conv1=144;                         //converts to psia to lbf/ft^2
 Real pi=3.14159;                        //Constant Pi
 Real G1=0.2, G2=4.;

public
  Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (Placement(
        transformation(extent={{-114,-102},{-94,-82}}), iconTransformation(
          extent={{-168,-96},{-148,-76}})));
equation

//Geometry Declaration********************************************************************************************************
Vinnerboiler=pi*ntubes*(ri^2)*Ltube;
Ax_Boiler_inner=pi*ntubes*(ri^2);
//End Geometry Declaration****************************************************************************************************
//****************************************************************************************************************************
//Momentum Equation***********************************************************************************************************

//P_HT*conv1+dPumpFCV2=P_CT*conv1+((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
dPumpFCV2=((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
assert(m_tes2>=0, "m_tes2 wrong");

//End Momentum Equation ******************************************************************************************************
//****************************************************************************************************************************
//Tubeside Energy Equation****************************************************************************************************

Vinnerboiler*rho_tes*cp_tes*der(T_Boilerexit)=m_tes2*cp_tes*(T_HT-T_Boilerexit)-Q_TES;  //Might want to check this at some point

//End Tube Energy Equation*****************************************************************************************************
//*****************************************************************************************************************************
//Cold Tank Energy Equation****************************************************************************************************

rho_tes*A_CT*H_CT*der(T_CT)=m_tes2*cp_tes*(T_Boilerexit-T_CT)-UA_CT*(T_CT-Tamb);

//End Cold Tank Energy Equation************************************************************************************************

algorithm

//Determination of Q_TES*******************************************************************************************************

  Pr:=cp_tes*mu_tes/k_tes;
  Re:=m_tes2*3600*De_tubes/(Ax_Boiler_inner*mu_tes);
  Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.3));       //This is cooling the fluid hence 0.3 on the coefficient
  hi:=k_tes*Nui/De_tubes;

  A:=(1/(hi*ri));
  B:=log(ro/ri)/ktube;

  UiPw:=2*pi*((A + B)^(-1));

  eta:=(exp(2*P_Boiler/1260)/(72^2))*1000000;
  Chi:=UiPw/(2*pi*ro*eta);

  delTw := (-Chi/2.) + (0.5)*sqrt((Chi^2. + 4.*Chi*(TbarB -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
    P_Boiler))));

  ho:=eta*(delTw);

  C:=(1/(ho*ro));
  UA:=2*pi*ntubes*Ltube/(A + B + C);            //Solves for the Heat Transfer Rate

    //Determining the average temperature of the TES fluid
if m_tes2 > 0.001 then
BetaB:=UA/(m_tes2*3600*cp_tes);
    TbarB :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
      P_Boiler) - ((
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
      P_Boiler) - T_HT)/BetaB)*(1 - exp(-BetaB));

    AA := T_HT -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
      P_Boiler);

    CC :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
      P_Boiler);
    BB := T_Boilerexit -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.Tsat(
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
//End Determination of Q_TES*****************************************************************************************************
//*******************************************************************************************************************************
//Determine the error on the amount of turbine work being produced***************************************************************
eff:=1.;//(Assumes a total cycle efficiency of "x"%

//Assume a constant enthalpy turbine
  x_exhturb := (
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.sg(
    P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.sf(
    Pcond))/
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.sfg(
    Pcond);

  h_exhturb :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hf(
    Pcond) + x_exhturb*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hfg(
    Pcond);

  Wturb := m_LPT*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hg(
    P_Boiler) - h_exhturb)*eff/947.817;

Woutput:=Wturb*1e6;
portElec_b.W:=-Wturb*1e6;
//End Determination of Power Produced********************************************************************************************
//*******************************************************************************************************************************
//Determine Error on FCV2********************************************************************************************************

//Wdemand:=(Relativedemand-100)*Wnominal/100;
Wdemand:=Relativedemand/1e6;//MW
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
FlowErr1:=0;
FlowErr2:=(Wdemand - Wturb)/(1000*Wpeakdesign);

FlowErr:=G1*FlowErr1 + G2*FlowErr2;
  if FlowErr > 1 then
    FlowErr:=1;
  elseif FlowErr < -1 then
    FlowErr:=-1;
  end if;
FCV2Error:=FlowErr;
//End Determination of Error on FCV2***********************************************************************************************

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DischargeTube2_fullhookup;
