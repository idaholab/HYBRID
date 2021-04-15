within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
model IHXTubeSide

  Modelica.Blocks.Interfaces.RealInput T_CT(start=400)
    annotation (Placement(transformation(extent={{-128,42},{-100,70}})));

  parameter Real cp_tes=0.614        "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
  parameter Real rho_tes=50.473      "Density of Therminol-66 at ~450F (lbm/ft^3)";
  parameter Real k_tes=0.055         "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
  parameter Real mu_tes=0.992        "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
  parameter Real ktube=10.3          "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
  parameter Real A_HT=133333         "Cross Sectional Area of Hot Tank (ft^2)";
  parameter Real A_CT=133333         "Cross Sectional Area of Cold Tank (ft^2)";
  parameter Real A_FCV=2.0           "Area of Valve Between Cold Tank and Hot Tank (ft^2)";
  parameter Real dPump1=32900        "Force of pump applied(lbf/ft^2)";
  parameter Real Mfillgas_CT=1.942e5 "Mass of Inert Nitrogen at top of Cold Tank (lbm)";
  parameter Real Mfillgas_HT=2.73e5  "Mass of Inert Nitrogen at top of Hot Tank (lbm)";
  parameter Real Tank_Height_CT=60   "Height of Cold Tank Vessel (ft)";
  parameter Real Tank_Height_HT=60   "Height of Hot Tank Vessel (ft)";
  parameter Real Tamb=0              "Ambient Temperature Outside of the Tanks (F)";
  parameter Real UA_HT=0             "Effective Heat Transfer out of Hot Tank";
  parameter Real ntubes=19140        "Number of tubes inside IHX";
  parameter Real KFCVline=100        "Assumed Line loss of FCV line";
  parameter Real Tube_height=36.9    "Height of tubes in IHX (ft)";
  parameter Real ri_IHX=0.022        "inner tube radius (ft)";
  parameter Real ro_IHX=0.029        "outer tube radius (ft)";
  parameter Real T_setpoint=500      "Reference Temperature at top of IHX (ft)";
  parameter Real De_IHX=0.044        "Effective Diameter of IHX (ft)";
  parameter Real hsg=1192.6          "enthalpy of steam entering the IHX (Btu/lbm)";
  parameter Real m_bypassref=844.4   "reference amount of bypass steam (lbm/sec)"; //lbm/sec

  Real Vinner;                       //Volume of inner tubes
  Real rho_CT;                       //density of Cold Tank inert nitrogen
  Real rho_HT;                       //density of Hot Tank inert nitrogen
  Real H_HT(start=30,fixed=true);    //Height of Hot Tank (ft)
  Real m_tes(start=1);               //mass flow of Therminol-66 from Cold Tank to Hot Tank lbm/sec
  Real T_IHXexit(start=497);         //Temperature of TES fluid exiting the top tubes of IHX
  Real E1,E2;                        //Error Signals
  Real Pr;                           //Prandtl Number
  Real Re;                           //Reynolds Number
  Real UA_IHX;                       //Effective Heat Transfer Value across IHX tubes
  Real Beta;                         //Dummy Variable
  Real hi;                           //heat transfer coefficient of inner tube
  Real TbarTES;
  Real Twmin;                        //Minimum Wall Temperature Bound (F)
  Real Twmax;                        //Maximum Wall Temperature Bound (F)
  Real ho;                           //outer convective heat transfer coefficient
  Real Nui;                          //Nusselt Number
  Real Ax_IHX_inner;                 //Effective Cross Sectional Area of tubes side
  Real dihx;                         //tube diameter
  Real m_teskghr;                    //mass flow rate of thermal energy storage fluid  in kg/hr
  Real m_tesref;
  Real TwIHX(start=450);
  Real A, B, C, AA, BB, hfg1;        //Dummy Variables
  Real HotTankpercentfull;           //Hot Tank percent full
  Real ColdTankpercentfull;          //Cold Tank percent full
protected
 Real gc=32.17;                      //converts (lbm/sec^2/ft) to lbf/ft^2
 Real g=4.17e8;                      //For heat transfer correlations
 Real conv1=144;                     //converts to psia to lbf/ft^2
 Real pi=3.14159;                    //Constant pi

 parameter Real G1=2;
 parameter Real G2=1;
 final parameter Real R=54.99         "Universal Gas Constant of Nitrogen (lbf*ft/(lbm*R))";

 Real TsatIHX;

public
  Modelica.Blocks.Interfaces.RealInput KFCV
    annotation (Placement(transformation(extent={{-128,-24},{-100,4}})));
  Modelica.Blocks.Interfaces.RealOutput FlowErr
    annotation (Placement(transformation(extent={{100,16},{120,36}})));
  Modelica.Blocks.Interfaces.RealInput P_IHX(start=700)
    annotation (Placement(transformation(extent={{-126,-72},{-100,-46}})));
  Modelica.Blocks.Interfaces.RealOutput Q_IHX(start=1.)
    annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
  Modelica.Blocks.Interfaces.RealInput mbypass
    annotation (Placement(transformation(extent={{-126,-46},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput m_tes2(start=0.0001)
    annotation (Placement(transformation(extent={{-128,68},{-100,96}})));
  Modelica.Blocks.Interfaces.RealOutput T_HT(start=500, fixed=true)
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput P_CT
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_HT
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput H_CT(start=30,fixed=true)
    annotation (Placement(transformation(extent={{100,-14},{120,6}})));
equation

//Geometry Declaration**************************************************************************************

Vinner=pi*(ri_IHX^2)*ntubes*Tube_height;
Ax_IHX_inner=Vinner/Tube_height;
dihx=2*ro_IHX;

//End Geometry Declaration**********************************************************************************
//**********************************************************************************************************
//Tank Equations********************************************************************************************
der(H_HT)*A_HT*rho_tes=m_tes-m_tes2;

der(H_CT)*A_CT*rho_tes=m_tes2-m_tes;

// P_HT=rho_HT*R*(T_HT+459.67)/conv1;
//
// P_CT=rho_CT*R*(T_CT+459.67)/conv1;
//
// rho_CT=Mfillgas_CT/(A_CT*(Tank_Height_CT-H_CT));
//
// rho_HT=Mfillgas_HT/(A_HT*(Tank_Height_HT-H_HT));

//End Tank Equations****************************************************************************************
//**********************************************************************************************************
//Hot Tank Energy Equation**********************************************************************************

rho_tes*A_HT*H_HT*der(T_HT)=m_tes*cp_tes*(T_IHXexit-T_HT)-UA_HT*(T_HT-Tamb);

//End Hot Tank Energy Equation******************************************************************************
//**********************************************************************************************************
//Momentum Equation*****************************************************************************************

//P_CT*conv1+dPump1=P_HT*conv1+((KFCV+KFCVline)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));
dPump1=((KFCV+KFCVline)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));

//End Momentum Equation*************************************************************************************
//**********************************************************************************************************
//Temperature Exiting the IHX*******************************************************************************

Vinner*rho_tes*cp_tes*der(T_IHXexit)=Q_IHX+m_tes*cp_tes*(T_CT-T_IHXexit);

//End Temperature Exiting the IHX Equation******************************************************************

HotTankpercentfull=(H_HT/Tank_Height_HT)*100;
ColdTankpercentfull=(H_CT/Tank_Height_CT)*100;

algorithm

Pr:=cp_tes*mu_tes/k_tes;
Re:=m_tes*3600*De_IHX/(Ax_IHX_inner*mu_tes);
Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.4));
hi:=k_tes*Nui/De_IHX;
m_teskghr:=m_tes*3600/2.2;
  TsatIHX :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
    P_IHX);
Twmin:=(T_CT + T_IHXexit)/2;
Twmax:=TsatIHX - 0.0001;
  TwIHX := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
      function
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.ho_IHX(
        P_IHX=P_IHX,
        ktube=ktube,
        ro_IHX=ro_IHX,
        ri_IHX=ri_IHX,
        hi=hi,
        Tc1=T_CT,
        Tc2=T_IHXexit,
        dihx=2*ro_IHX),
      Twmin,
      Twmax,
      tolerance=1e-3);

  AA :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX)*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
    P_IHX))*g*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.kl(
    TsatIHX, P_IHX)^3);

  hfg1 :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hfg(
    P_IHX)*((1 + (0.68*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.Cpl(
    TsatIHX, P_IHX)*(TsatIHX - TwIHX))/
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hfg(
    P_IHX)));

  BB :=
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.Viscosity(
    TsatIHX, P_IHX)*dihx*(TsatIHX - TwIHX);

ho:=0.725*((AA*hfg1/BB)^0.25);

A:=(1/(hi*ri_IHX));
B:=(log(ro_IHX/ri_IHX)/ktube);
C:=(1/(ho*ro_IHX));
UA_IHX:=2*pi*ntubes*Tube_height/(A + B + C);
Beta:=UA_IHX/(m_tes*3600*cp_tes);
TbarTES:=TsatIHX - ((TsatIHX - T_CT)/Beta)*(1 - exp(-Beta));
Q_IHX:=UA_IHX*(TsatIHX - TbarTES)/3600;

//Energy Equation inside the tubes

  m_tesref := m_bypassref*(hsg -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(
    825))/(cp_tes*(T_setpoint - T_CT));

  E2:=(mbypass/m_bypassref)-(m_tes/m_tesref);
  //G2:=1;
  //G1:=1;

  E1:=(T_IHXexit - T_setpoint)/T_setpoint;

  FlowErr:=G1*E1 + G2*E2;

  if FlowErr > 1 then
    FlowErr:=1;
  elseif FlowErr < -1 then
    FlowErr:=-1;
  end if;

end IHXTubeSide;
