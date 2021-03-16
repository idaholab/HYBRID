within NHES.Systems.EnergyStorage.SensibleHeatStorage.Components;
model SimpleControlVolume7_outerreal_ports

 //Real m_in=100;    //lbm/sec
 //Real m_out;    //lbm/sec
 parameter Real V_IHX=6000; //ft^3
 //Real rho(start=29.854);
 Real rho(start=5.74);
 //Real rhou(start=14980);
 Real rhou(start=3399);
 //Real hsg=1244;  //Btu/lbm
 //Real P_IHX(start=700, fixed=true); //psia
 //Real alphag(start=0.4);
 Real alphag(start=0.907, fixed=true);
 Real m_prv(start=0);
 //Real m_ihx(start=571);
 Real m_ihx(start=0);
 //Real m_tbv;
 //Real Hotwell_level(start=51.97);
 Real Hotwell_level(start=8);
 Real m_tbvkghr;

 parameter Real Ahw=69.27;
 parameter Real Hotwell_ref=8;
 Integer TESmode=0;
 parameter Real A_ACV=0.34; //area of ACV
 parameter Real A_PRV=0.5; //area of PCV
 //parameter Real Pcond=0.7; //psia

 parameter Real G1=0.01;  //Gain for ACV first error signal
 parameter Real G2=10;  //Gain for ACV second error signal
 parameter Real KACVline=100; //Line loss assumed for ACV line
 parameter Real KPRVline=100; //line loss assumed for PRV line
 //Integer TESmode;
 parameter Real P_IHX_LB=760;
 parameter Real P_IHX_UB=780;
 parameter Real A_TESTBV1=0.394;
 parameter Real A_TESTBV2=0.394;
 parameter Real A_TESTBV3=0.394;
 parameter Real A_TESTBV4=0.394;
 parameter Real KTESTBVline;
 //parameter Real P_HDR=825;
 type MassFlow = Real(min=0);
 MassFlow m_tbv1(start=0);
 MassFlow m_tbv2(start=0);
 MassFlow m_tbv3(start=0);
 MassFlow m_tbv4(start=0);
 //Real deltat;
 //Real PRVposition=0;
  Real FlowErr,FlowErr1,FlowErr2;

 Real hsg;
 Real P_HDR;
 Real Pcond;

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
  Real gc=32.17; //converts (lbm/sec^2/ft) to lbf/ft^2
  Real conv1=144; //converts to psia to lbf/ft^2

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
// initial equation
//  //P_IHX=700;
//  //alphag=0.7;
//  //Hotwell_level=
//  rho=TESSystem.rhof(P_IHX)+alphag*(TESSystem.rhog(P_IHX)-TESSystem.rhof(P_IHX)); //lbm/ft^3
//  rhou=TESSystem.rhof(P_IHX)*TESSystem.uf(P_IHX)+alphag*(TESSystem.rhog(P_IHX)*TESSystem.ug(P_IHX)-TESSystem.rhof(P_IHX)*TESSystem.uf(P_IHX));  //Btu/ft^3
//  Q_IHX=m_tbv*(hsg-TESSystem.hf(P_IHX));
 //m_ihx=0;
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
        Medium)
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-30,-112},{-10,-92}})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true);
equation

  m_tbv*0.454 = port_a.m_flow;
  m_ihx*0.454 = - port_b.m_flow;

  port_a.p/6894.76 = P_HDR;
  port_b.p/6894.76 = Pcond;

  inStream(port_a.h_outflow)/2326 = hsg;

  inStream(port_a.Xi_outflow) = port_b.Xi_outflow;

  NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.hf(P_IHX)*2326 = port_b.h_outflow;

  // Reverse flow: not used
  inStream(port_b.h_outflow)/2326 = port_a.h_outflow;
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);

  //m_out=m_prv+m_ihx;

 //Mass Equation
  V_IHX*der(rho) =m_tbv - m_prv-m_ihx;

  //Energy Equation
  V_IHX*der(rhou) =m_tbv*hsg - m_prv*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.hg(P_IHX)-
                   m_ihx*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.hf(P_IHX)-Q_IHX;
  //TESSystem.hf(P_IHX);

 rho=NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX)+alphag*
    (NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_IHX)-
     NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX));    //State Equation for density

 rhou=NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX)*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.uf(P_IHX)+
      alphag*(NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_IHX)*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.ug(P_IHX)-
      NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX)*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.uf(P_IHX)); //State Equation for rhou
  //P_IHX=Pcond
 Hotwell_level=(1-alphag)*V_IHX/Ahw;

  //Q_IHX=m_tbv*(hsg-TESSystem.hf(P_IHX));

//Momentum Equation running from IHX to Condenser

if ACVPosition > 0.00001 then
  P_IHX*conv1=Pcond*conv1+(m_ihx^2)*(KACV+KACVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhof(P_IHX)*gc*(A_ACV^2));
else
  m_ihx=0.0000;
end if;

//Momentum Equation for PRV
  if PRVPosition > 0.00001 then
    P_IHX*conv1=Pcond*conv1+(m_prv^2)*(KPRV+KPRVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_IHX)*gc*(A_PRV^2));
  else
     m_prv=0.0000;
  end if;
//Momentum Equations for each TBV 1 through 4

// Momentum Equation Selection
  if TESTBVPosition1 > 0.00001 then
  P_HDR*conv1=P_IHX*conv1+(m_tbv1^2)*(KTESTBV1+KTESTBVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_HDR)*gc*(A_TESTBV1^2));
  else
    m_tbv1=0.0000;
  end if;
  if TESTBVPosition2 > 0.00001 then
  P_HDR*conv1=P_IHX*conv1+(m_tbv2^2)*(KTESTBV2+KTESTBVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_HDR)*gc*(A_TESTBV2^2));
  else
    m_tbv2=0.000;
  end if;
  if TESTBVPosition3 > 0.00001 then
  P_HDR*conv1=P_IHX*conv1+(m_tbv3^2)*(KTESTBV3+KTESTBVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_HDR)*gc*(A_TESTBV3^2));
  else
    m_tbv3=0.0000;
  end if;
  if TESTBVPosition4 > 0.00001 then
  P_HDR*conv1=P_IHX*conv1+(m_tbv4^2)*(KTESTBV4+KTESTBVline)/(2*NHES.Systems.EnergyStorage.SensibleHeatStorage.Components.rhog(P_HDR)*gc*(A_TESTBV4^2));
  else
    m_tbv4=0.0000;
  end if;
  //P_HDR*conv1=P_IHX*conv1+(m_tbv2^2)*(KTESTBV2+KTESTBVline)/(2*TESSystem.rhog(P_HDR)*gc*(A_TESTBV2^2));

assert(m_tbv1>=0, "m_tbv1wrong");
assert(m_tbv2>=0, "m_tbv2wrong");
assert(m_tbv3>=0, "m_tbv3wrong");
assert(m_tbv4>=0, "m_tbv4wrong");

m_tbv=m_tbv1+m_tbv2+m_tbv3+m_tbv4;

//deltat=time-pre(time);
//Section for calculating Flow Errors
algorithm
  m_tbvkghr:=m_tbv*3600/2.2;
// if m_tbv==0 and m_ihx==0 and m_prv==0 then
//   TESmode:=4;
// else
//   TESmode:=1;
// end if;

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
end SimpleControlVolume7_outerreal_ports;
