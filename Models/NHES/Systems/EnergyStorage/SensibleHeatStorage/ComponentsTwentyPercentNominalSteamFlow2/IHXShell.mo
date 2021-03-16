within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
model IHXShell

 parameter Real V_IHX=6000              "Volume of the Intermediate Heat Exchnager (ft^3)"; //ft^3
 parameter Real Ahw=69.27               "Area of Hotwell under the IHX (ft^2)";
 parameter Real Hotwell_ref=8           "Hotwell Reference Height (ft)";
 parameter Real A_ACV=0.34              "Area of Auxiliary Control Valve  (ft^2)";
 parameter Real A_PRV=0.5               "Area of Pressure Relief Valve (ft^2)";
 parameter Real G1=0.01                 "Gain for ACV first error signal";
 parameter Real G2=10                   "Gain for ACV second error signal";
 parameter Real KACVline=100            "Line Loss assumed for ACV line";
 parameter Real KPRVline=100            "Line Loss assumed for PRV line";
 parameter Real P_IHX_LB=760            "Lower Bound of Pressure Relief Valve (psia)";
 parameter Real P_IHX_UB=780            "Upper Bound of Pressure Relief Valve (psia)";
 parameter Real A_TESTBV1=0.394         "Area of TES TBV 1 (ft^2)";
 parameter Real A_TESTBV2=0.394         "Area of TES TBV 2 (ft^2)";
 parameter Real A_TESTBV3=0.394         "Area of TES TBV 3 (ft^2)";
 parameter Real A_TESTBV4=0.394         "Area of TES TBV 4 (ft^2)";
 parameter Real KTESTBVline             "Line Loss assumed for TESTBV lines";
 type MassFlow = Real(min=0);
 MassFlow m_tbv1(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
 MassFlow m_tbv2(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
 MassFlow m_tbv3(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
 MassFlow m_tbv4(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
 Real FlowErr,FlowErr1,FlowErr2;        //Different FlowErrs used to open and close valves
 Real rho(start=5.74);                  //Effective Density of IHX as a whole (lbm/ft^3)
 Real rhou(start=3399);                 //Effective Internal Energy of IHX as a whole (Btu/ft^3)
 Real alphag(start=0.907, fixed=true);  //Void Fraction of IHX
 Real m_prv(start=0);                   //Mass Flow Rate through Pressure Relief Valve
 Real m_ihx(start=0);                   //Mass Flow Rate through Auxiliary Control Valve at Bottom of IHX
 Real Hotwell_level(start=8);           //Fluid Level in the Hotwell Below the IHX (ft)
 Real m_tbvkghr;                        //Total Mass Flow through the 4 TESTBVS in (kg/hr)
 Real hsg;                              //Enthalpy of Fluid Entering the IHX from the Steam Generator (Btu/lbm)
 Real P_HDR;                            //Pressure of the Equalization Header Prior to the main TCVs (psia)
 Real Pcond;                            //Condenser Pressure (psia)

  Modelica.Blocks.Interfaces.RealOutput P_IHX(start=700, fixed=true)
    annotation (Placement(transformation(extent={{100,-60},{128,-32}})));
  Modelica.Blocks.Interfaces.RealInput KACV
    annotation (Placement(transformation(extent={{-118,-32},{-104,-18}})));
  Modelica.Blocks.Interfaces.RealOutput ACVError
    annotation (Placement(transformation(extent={{100,-92},{126,-66}})));

  Modelica.Blocks.Interfaces.RealInput KPRV
    annotation (Placement(transformation(extent={{-118,-8},{-102,8}})));
  Modelica.Blocks.Interfaces.RealOutput PRVError
    annotation (Placement(transformation(extent={{100,-26},{128,2}})));
  Modelica.Blocks.Interfaces.RealInput PRVPosition
    annotation (Placement(transformation(extent={{-116,10},{-100,26}})));

protected
  Real gc=32.17;                        //converts (lbm/sec^2/ft) to lbf/ft^2
  Real conv1=144;                       //converts to psia to lbf/ft^2

public
  Modelica.Blocks.Interfaces.RealInput KTESTBV1
    annotation (Placement(transformation(extent={{-116,40},{-100,56}})));
  Modelica.Blocks.Interfaces.RealInput KTESTBV2
    annotation (Placement(transformation(extent={{-116,56},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput KTESTBV3
    annotation (Placement(transformation(extent={{-116,72},{-100,88}})));
  Modelica.Blocks.Interfaces.RealInput KTESTBV4
    annotation (Placement(transformation(extent={{-116,86},{-100,102}})));
  Modelica.Blocks.Interfaces.RealOutput m_tbv
    annotation (Placement(transformation(extent={{100,12},{128,40}})));

  Modelica.Blocks.Interfaces.RealInput TESTBVPosition4 annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-34,110})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition3 annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-54,108})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition2 annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-74,108})));
  Modelica.Blocks.Interfaces.RealInput TESTBVPosition1 annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-92,108})));
  Modelica.Blocks.Interfaces.RealInput ACVPosition annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-16,110})));

  Modelica.Blocks.Interfaces.RealInput Q_IHX
    annotation (Placement(transformation(extent={{-116,-56},{-102,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,-112},{-10,-92}})));
equation

  m_tbv*0.454 = port_a.m_flow;
  m_ihx*0.454 = - port_b.m_flow;

  port_a.p/6894.76 = P_HDR;
  port_b.p/6894.76 = Pcond;

  inStream(port_a.h_outflow)/2326 = hsg;

  inStream(port_a.Xi_outflow) = port_b.Xi_outflow;

  NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(
    P_IHX)*2326 = port_b.h_outflow;

  // Reverse flow: not used
  inStream(port_b.h_outflow)/2326 = port_a.h_outflow;
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);

 //Mass Equation
  V_IHX*der(rho) =m_tbv - m_prv-m_ihx;

  //Energy Equation
  V_IHX*der(rhou) = m_tbv*hsg - m_prv*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(
    P_IHX) - m_ihx*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(
    P_IHX) - Q_IHX;

  rho =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX) + alphag*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
    P_IHX) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX));                                                                    //State Equation for density

  rhou =
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.uf(
    P_IHX) + alphag*(
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
    P_IHX)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.ug(
    P_IHX) -
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
    P_IHX)*
    NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.uf(
    P_IHX));                                                                                                                                      //State Equation for rhou
  //P_IHX=Pcond
 Hotwell_level=(1-alphag)*V_IHX/Ahw;

//Momentum Equation running from IHX to Condenser

if ACVPosition > 0.00001 then
    P_IHX*conv1 = Pcond*conv1 + (m_ihx^2)*(KACV + KACVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*gc*(A_ACV^2));
else
  m_ihx=0.0000;
end if;

//Momentum Equation for PRV
  if PRVPosition > 0.00001 then
    P_IHX*conv1 = Pcond*conv1 + (m_prv^2)*(KPRV + KPRVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX)*gc*(A_PRV^2));
  else
     m_prv=0.0000;
  end if;
//Momentum Equations for each TBV 1 through 4

// Momentum Equation Selection
  if TESTBVPosition1 > 0.00001 then
    P_HDR*conv1 = P_IHX*conv1 + (m_tbv1^2)*(KTESTBV1 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV1^2));
  else
    m_tbv1=0.0000;
  end if;
  if TESTBVPosition2 > 0.00001 then
    P_HDR*conv1 = P_IHX*conv1 + (m_tbv2^2)*(KTESTBV2 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV2^2));
  else
    m_tbv2=0.000;
  end if;
  if TESTBVPosition3 > 0.00001 then
    P_HDR*conv1 = P_IHX*conv1 + (m_tbv3^2)*(KTESTBV3 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV3^2));
  else
    m_tbv3=0.0000;
  end if;
  if TESTBVPosition4 > 0.00001 then
    P_HDR*conv1 = P_IHX*conv1 + (m_tbv4^2)*(KTESTBV4 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV4^2));
  else
    m_tbv4=0.0000;
  end if;

assert(m_tbv1>=0, "m_tbv1wrong");
assert(m_tbv2>=0, "m_tbv2wrong");
assert(m_tbv3>=0, "m_tbv3wrong");
assert(m_tbv4>=0, "m_tbv4wrong");

m_tbv=m_tbv1+m_tbv2+m_tbv3+m_tbv4;

//Section for calculating Flow Errors
algorithm
  m_tbvkghr:=m_tbv*3600/2.2;

//*******************************************************
// Section for ACV Error
   FlowErr1:=0;
   if m_tbv==0 and m_ihx==0 and m_prv==0 then
     FlowErr1:=0;
   else
      FlowErr1:=(m_tbv - m_ihx - m_prv)/(m_tbv + m_ihx + m_prv);
   end if;
   FlowErr2:=(Hotwell_level - Hotwell_ref)/(Hotwell_ref +
     Hotwell_level);

     FlowErr:=G1*FlowErr1 + G2*FlowErr2;
     if FlowErr > 1 then
       FlowErr:=1;
     end if;
     if FlowErr < -1 then
       FlowErr:=-1;
     end if;
     ACVError:=FlowErr;
     //End section for ACV Error
//********************************************************
//********************************************************
//Section for PRV Error
if PRVPosition < 0.0001 then
  FlowErr:=(P_IHX - P_IHX_UB)/P_IHX_UB;
else
  FlowErr:=(P_IHX - P_IHX_LB)/P_IHX_LB;
end if;

if FlowErr > 1 then
       FlowErr:=1;
     end if;
     if FlowErr < -1 then
       FlowErr:=-1;
     end if;

PRVError:=FlowErr;

    annotation (Placement(transformation(extent={{-122,-68},{-100,-46}})));
end IHXShell;
