within NHES.Desalination.MEE.Components;
model SEE_Tube_Side_PoolBoilingBulk
 import Modelica.Fluid.Types.Dynamics;

replaceable package MediumT = Modelica.Media.Water.StandardWater;
replaceable package MediumS = Modelica.Media.Water.StandardWater;
MediumS.SaturationProperties  satS;
MediumT.SaturationProperties  satT;
MediumT.ThermodynamicState LiT;
MediumT.ThermodynamicState VaT;
MediumS.ThermodynamicState LiS;
MediumS.ThermodynamicState VaS;
parameter Modelica.Units.SI.AbsolutePressure p_start=1e5  "tube side pressure start";
parameter Modelica.Units.SI.MassFlowRate m_start=1 "start mass flow rate";
input Modelica.Units.SI.Area Ax=1e4    "Heat Transfer Area (Outside Tube Area)";
parameter Modelica.Units.SI.Diameter Do=0.01
                                            "Outer Diameter of the Tubes";
parameter Modelica.Units.SI.Thickness th=0.001
                                              "Thickness of the Cladding";
parameter Modelica.Units.SI.PressureDifference dP=10
                                                    "Pressure Drop across the tubes";
parameter Modelica.Units.SI.ThermalConductivity k=0.01
                                                      "Thermal Conductivity of the Cladding";

parameter Modelica.Units.SI.SpecificEnthalpy hinstart=MediumT.dewEnthalpy(MediumT.setSat_p(p_start));
//2000e3;
//
parameter Modelica.Units.SI.SpecificEnthalpy houtstart=MediumT.bubbleEnthalpy(MediumT.setSat_p(p_start));
//400e3;
parameter Modelica.Units.SI.Temperature TwTst=120;
parameter Modelica.Units.SI.Temperature TwSst=100;

  Modelica.Units.SI.AbsolutePressure pT(start=p_start);
  Modelica.Units.SI.AbsolutePressure pS;
  Modelica.Units.SI.AbsolutePressure Pcr;
  Modelica.Units.SI.SpecificEnthalpy h_gT;
  Modelica.Units.SI.SpecificEnthalpy h_in(start=hinstart);
  Modelica.Units.SI.SpecificEnthalpy h_out(start=houtstart);
  Modelica.Units.SI.MassFlowRate mdot;
  Modelica.Units.SI.HeatFlowRate Qhx;
  Modelica.Units.SI.HeatFlowRate Q;
  Modelica.Units.SI.CoefficientOfHeatTransfer hi;
  Modelica.Units.SI.Diameter Di;
  Modelica.Units.SI.Area Axi;
  Modelica.Units.SI.ThermalConductivity kT;
  Modelica.Units.SI.ThermalConductivity kS;
  Modelica.Units.SI.ThermalConductivity lamT;
  Modelica.Units.SI.DynamicViscosity mufT;
  Modelica.Units.SI.DynamicViscosity mugT;
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpT;
  Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpS;
  Modelica.Units.SI.Density rhofT;
  Modelica.Units.SI.Density rhogT;
  Modelica.Units.SI.Density rhofS;
  Modelica.Units.SI.Density rhogS;
  Modelica.Units.SI.SpecificEnthalpy hfT;
  Modelica.Units.SI.SpecificEnthalpy hgT;
  Modelica.Units.SI.SpecificEnthalpy hfS;
  Modelica.Units.SI.SpecificEnthalpy hgS;
  Modelica.Units.SI.SpecificEnthalpy hfgT;
  Modelica.Units.SI.Temperature TwT(start=TwTst);
  Modelica.Units.SI.Temperature TwS(start=TwSst);
  Modelica.Units.SI.Temperature TS;
  Modelica.Units.SI.Temperature TsT;
  Real PrT;
  Real PrS;
  Modelica.Units.SI.Diameter ls;
  Modelica.Units.SI.Thickness delta;
  Modelica.Units.SI.DynamicViscosity muS;
  Modelica.Units.SI.SurfaceTension sigma;

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
    annotation (Placement(transformation(extent={{-10,40},{10,60}}),
        iconTransformation(extent={{-10,40},{10,60}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Steam_Inlet_Port(
  p(start=p_start),
  redeclare package Medium = MediumT)
    annotation (
    Placement(transformation(extent={{-110,-10},{-90,10}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_State Liquid_Outlet_Port(
  p(start=p_start-dP),
  redeclare package Medium = MediumT)
    annotation (
    Placement(transformation(extent={{90,-10},{110,10}})));

equation

  Di=Do - 2*th;
  Axi=Ax*Di/Do;
  //Tube Side

  satT.psat = pT;
  satT.Tsat = MediumT.saturationTemperature(pT);
  h_gT = MediumT.dewEnthalpy(satT);
  kT= MediumT.thermalConductivity(VaT);
  LiT=MediumT.setBubbleState(satT);
  VaT=MediumT.setDewState(satT);
  mufT= MediumT.dynamicViscosity(LiT);
  mugT= MediumT.dynamicViscosity(VaT);
  lamT= MediumT.thermalConductivity(LiT);
  cpT= MediumT.specificHeatCapacityCp(LiT);
  rhogT=MediumT.density(VaT);
  rhofT=MediumT.density(LiT);
  hfT=MediumT.specificEnthalpy(LiT);
  hgT=MediumT.specificEnthalpy(VaT);
  PrT=MediumT.prandtlNumber(LiT);
  hfgT=hgT-hfT;

  //Shell Side
  TS=satS.Tsat;
  satS.psat= MediumS.saturationPressure(TS);
  pS=satS.psat;
  LiS=MediumS.setBubbleState(satS);
  VaS=MediumS.setDewState(satS);
  hfS=MediumS.specificEnthalpy(LiS);
  hgS=MediumS.specificEnthalpy(VaS);
  rhogS=MediumS.density(VaS);
  rhofS=MediumS.density(LiS);
  kS=MediumS.thermalConductivity(LiS);
  Pcr=220e5;
  sigma=MediumS.surfaceTension(satS);
  ls=sqrt((sigma/(rhofS-rhogS))*Modelica.Constants.g_n);
  muS=MediumS.dynamicViscosity(LiS);
  cpS= MediumS.specificHeatCapacityCp(LiT);
  PrS=MediumS.prandtlNumber(LiT);

  //Clading

  TsT=MediumT.temperature_ph(pT,h_out);

  hi=NHES.Fluid.ClosureModels.HeatTransfer.alpha_Nusselt_Cond_horizontal_tubes( TwT,satT.Tsat,hgT,hfT,rhogT,rhofT,lamT,cpT,PrT,Di);
  Qhx=hi*Axi*(TsT-TwT);
  delta=(kS*(TwS-TS)*Ax/(Qhx));
  Qhx=Ax*((cpS*(TwS-TS)/((hgS-hfS)*(PrS*0.01)))^3)*muS*(hgS-hfS)*
        ((Modelica.Constants.g_n*(rhofS-rhogS)/sigma)^0.5);
  Qhx=2*k*Ax/(Do*log(Do/Di))*(TwT-TwS);

 // Total HT
 if mdot>1e-8 then
 h_out=h_in-Qhx/mdot;
 else
 h_out=h_in;
 end if;

  Q=sum(Qhx);
  //Connectors
  Liquid_Outlet_Port.p = pT-dP;
  Liquid_Outlet_Port.h_outflow=h_out;
 - mdot=Liquid_Outlet_Port.m_flow;

  Steam_Inlet_Port.p = pT;
  mdot=Steam_Inlet_Port.m_flow;
  Steam_Inlet_Port.h_outflow = h_gT;
  h_in =inStream(Steam_Inlet_Port.h_outflow);
  TS=Heat_Port.T;
  Q =-Heat_Port.Q_flow;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,127,255}, if showColors then dynColor
               else {0,127,255})),
        Polygon(
          points={{68,40},{-90,42},{-90,-40},{-56,-38},{-50,-22},{-30,-12},{-26,
              0},{-16,4},{0,20},{68,40}},
          lineColor={85,170,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,42},{90,34}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,-32},{90,-40}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-100,-40},{100,-60}},
          textColor={28,108,200},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end SEE_Tube_Side_PoolBoilingBulk;
