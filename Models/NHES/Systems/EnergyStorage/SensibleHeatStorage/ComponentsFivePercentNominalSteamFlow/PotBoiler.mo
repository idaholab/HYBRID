within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow;
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
        parameter Real V_Boiler=4500;
        parameter Real AxBoiler=90;
        parameter Real Level_ref;
        //parameter Real K_TCV=1e5;
        parameter Real K_TCVline=50;
        //parameter Real KFDCV=1e5;
        parameter Real KFDCVline=100;
        parameter Real Pcond=0.7;
        parameter Real A_FDCV=1;
        parameter Real A_TCV=1;
        parameter Real dPumpFDCV=22700;
        parameter Real P_LPT=175;
        parameter Real P_Boilerdesign=200;
        Real rho_boiler(start=43.5);
        Real rhou_boiler(start=15600);
        Real m_FDCV(start=0.001);
        //Real m_LPT;
        //Real P_Boiler(start=200, fixed=true);
        Real alphag_boiler(start=0.2, fixed=true);
        //Real Q_TES;
        Real FlowErr1,FlowErr;
        Real FlowErr2;
        Real G1=10;
        Real G2=1;
        Real Level(start=40);
//assert(m_tbv3>=0, "m_tbv3wrong");
//assert(m_tbv4>=0, "m_tbv4wrong");

protected
 Real gc=32.17; //converts (lbm/sec^2/ft) to lbf/ft^2
 Real conv1=144; //converts to psia to lbf/ft^2
 Real pi=3.14159;

equation

 //Mass
  V_Boiler*der(rho_boiler)=m_FDCV-m_LPT;
 //Energy
  V_Boiler*der(rhou_boiler) = m_FDCV*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.hf(
     Pcond) - m_LPT*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.hg(
     P_Boiler) + Q_TES;

  rho_boiler =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhof(
     P_Boiler) + alphag_boiler*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhog(
     P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhof(
     P_Boiler));                                                                   //State Equation for density

  rhou_boiler =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhof(
     P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.uf(
     P_Boiler) + alphag_boiler*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhog(
     P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.ug(
     P_Boiler) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhof(
     P_Boiler)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.uf(
     P_Boiler));                                                                                                                                        //State Equation for rhou

//
//   //State Equations
//   rho_boiler=TESSystem.rhof(P_Boiler)-alphag_boiler*(TESSystem.rhof(P_Boiler)-TESSystem.rhog(P_Boiler));
//   rhou_boiler=TESSystem.rhof(P_Boiler)*TESSystem.uf(P_Boiler)-alphag_boiler*(TESSystem.rhof(P_Boiler)*TESSystem.uf(P_Boiler)-TESSystem.rhog(P_Boiler)*TESSystem.ug(P_Boiler));

  //Momentum Equations
  Pcond*conv1 + dPumpFDCV = P_Boiler*conv1 + ((KFDCV + KFDCVline)*(m_FDCV^2)/(2*
    gc*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhof(
     Pcond)*(A_FDCV^2)));
  P_Boiler*conv1 = P_LPT*conv1 + ((K_TCV + K_TCVline)*(m_LPT^2)/(2*gc*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsFivePercentNominalSteamFlow.rhog(
     P_Boiler)*(A_TCV^2)));

  //Energy
  //Q_TES=100;

assert(m_FDCV>=0, "m_FDCVwrong");
assert(m_LPT>=0, "m_LPTwrong");

algorithm

  //TCV Error
FlowErr:=(P_Boiler - P_Boilerdesign)/P_Boiler;
if FlowErr > 1 then
       FlowErr:=1;
     end if;
     if FlowErr < -1 then
       FlowErr:=-1;
     end if;
 TCVError:=FlowErr;

 Level:=(1 - alphag_boiler)*(V_Boiler/AxBoiler);
 //FDCVError
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PotBoiler;
