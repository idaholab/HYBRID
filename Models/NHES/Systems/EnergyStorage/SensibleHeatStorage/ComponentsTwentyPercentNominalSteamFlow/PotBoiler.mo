within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow;
model PotBoiler
  Modelica.Blocks.Interfaces.RealInput KFDCV
    annotation (Placement(transformation(extent={{-132,42},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput K_TCV
    annotation (Placement(transformation(extent={{-132,-46},{-100,-14}})));
  Modelica.Blocks.Interfaces.RealOutput TCVError
    annotation (Placement(transformation(extent={{100,54},{120,74}})));
  Modelica.Blocks.Interfaces.RealOutput FDCVError
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput Q_TES
    annotation (Placement(transformation(extent={{-132,-4},{-100,28}})));
  Modelica.Blocks.Interfaces.RealOutput P_Boiler(start=200, fixed=true)
    annotation (Placement(transformation(extent={{100,-26},{120,-6}})));
  Modelica.Blocks.Interfaces.RealOutput m_LPT(start=0.001)
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
parameter Real V_Boiler=4500               "Volume of Boiler (ft^3)";
parameter Real AxBoiler=90                 "Cross Section Area of Boiler (ft^2)";
parameter Real Level_ref                   "Reference Level in Boiler (ft)";
parameter Real K_TCVline=50                "Assumed Line Loss for TCV line";
parameter Real KFDCVline=100               "Assumed Line Loss for FDCV Line";
parameter Real Pcond=0.7                   "Assumed Pressure of the Condenser";
parameter Real A_FDCV=1                    "Cross Sectional Area of FDCV (ft^2)";
parameter Real A_TCV=1                     "Cross Sectional Area of TCV (ft^2)";
parameter Real dPumpFDCV=22700             "Pump Power (lbf/ft^2)";
parameter Real P_LPT=175                   "Assumed Re-entrance pressure of Low Pressure Turbine (psia)";
parameter Real P_Boilerdesign=200          "Boiler Design Pressure (psia)";

Real rho_boiler(start=43.5);                //Effective Density of the Boiler (lbm/ft^3)
Real rhou_boiler(start=15600);              //Effective Internal Energy of the Boiler (Btu/ft^3)
Real m_FDCV(start=0.001);                   //mass flow rate entering the boiler from the feed control valve (lbm/sec)
Real alphag_boiler(start=0.2, fixed=true);  //Effective Void in the Boiler
Real FlowErr1,FlowErr;                      //FlowErrors used to control the valves opening and closing
Real FlowErr2;                              //FlowError used to control the valves opening and closing
Real G1=10;                                 //Gain on three-element controller used to match level with reference level
Real G2=1;                                  //Gain on three-element controller used to match steam flow with feed flow
Real Level(start=40);                       //Level in the Boiler

protected
 Real gc=32.17;                           //converts (lbm/sec^2/ft) to lbf/ft^2
 Real conv1=144;                          //converts to psia to lbf/ft^2
 Real pi=3.14159;                         //Constant Pi

equation

 //Mass Equation***************************************************************************************************************

  V_Boiler*der(rho_boiler)=m_FDCV-m_LPT;

 //End Mass Equation***********************************************************************************************************
 //****************************************************************************************************************************
 //Energy Equation ************************************************************************************************************

  V_Boiler*der(rhou_boiler) = m_FDCV*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hf(
    Pcond) - m_LPT*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hg(
    P_Boiler) + Q_TES;

 //End Energy Equation ********************************************************************************************************
 //****************************************************************************************************************************
 //State Equations*************************************************************************************************************

  rho_boiler =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhof(
    P_Boiler) + alphag_boiler*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhog(
    P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhof(
    P_Boiler));

  rhou_boiler =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhof(
    P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.uf(
    P_Boiler) + alphag_boiler*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhog(
    P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.ug(
    P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhof(
    P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.uf(
    P_Boiler));

  //End State Equations************************************************************************************************************
  //*******************************************************************************************************************************
  //Momentum Equations*************************************************************************************************************
  Pcond*conv1 + dPumpFDCV = P_Boiler*conv1 + ((KFDCV + KFDCVline)*(m_FDCV^2)/
    (2*gc*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhof(
    Pcond)*(A_FDCV^2)));

  P_Boiler*conv1 = P_LPT*conv1 + ((K_TCV + K_TCVline)*(m_LPT^2)/(2*gc*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.rhog(
    P_Boiler)*(A_TCV^2)));

  assert(m_FDCV>=0, "m_FDCVwrong");
  assert(m_LPT>=0, "m_LPTwrong");
  //End Momentum Equation***********************************************************************************************************

algorithm

//Pressure Valve Error************************************************************************************************************
FlowErr:=(P_Boiler - P_Boilerdesign)/P_Boiler;
if FlowErr > 1 then
       FlowErr:=1;
     end if;
     if FlowErr < -1 then
       FlowErr:=-1;
     end if;
 TCVError:=FlowErr;
 //End Pressure Valve Error*********************************************************************************************************
 //*********************************************************************************************************************************
 //Feed Control Valve Error*********************************************************************************************************

 Level:=(1 - alphag_boiler)*(V_Boiler/AxBoiler);
 FlowErr1:=(Level_ref - Level)/(Level_ref);
 FlowErr2:=(m_LPT - m_FDCV)/(m_LPT + m_FDCV);
  FlowErr:=G1*FlowErr1 + G2*FlowErr2;
    if FlowErr > 1 then
       FlowErr:=1;
     end if;
     if FlowErr < -1 then
       FlowErr:=-1;
     end if;
    FDCVError:=FlowErr;
 //End Feed Control Valve Error*****************************************************************************************************
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PotBoiler;
