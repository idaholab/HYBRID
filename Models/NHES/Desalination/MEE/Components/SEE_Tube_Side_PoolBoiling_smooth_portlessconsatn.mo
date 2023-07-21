within NHES.Desalination.MEE.Components;
model SEE_Tube_Side_PoolBoiling_smooth_portlessconsatn
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
input Modelica.Units.SI.SpecificEnthalpy h_input annotation(Dialog(group="Inputs"));
input Modelica.Units.SI.MassFlowRate m_flow_input annotation(Dialog(group="Inputs"));
input Modelica.Units.SI.AbsolutePressure p_input annotation(Dialog(group="Inputs"));
parameter Modelica.Units.SI.Area Ax=1e4
                                       "Heat Transfer Area (Outside Tube Area)";
parameter Modelica.Units.SI.Diameter Do=0.01
                                            "Outer Diameter of the Tubes";
parameter Modelica.Units.SI.Thickness th=0.001
                                              "Thickness of the Cladding";
parameter Modelica.Units.SI.PressureDifference dP=10
                                                    "Pressure Drop across the tubes";
parameter Modelica.Units.SI.ThermalConductivity k=0.01
                                                      "Thermal Conductivity of the Cladding";
parameter Integer nV=5 "Number of Nodes";

parameter Modelica.Units.SI.SpecificEnthalpy hinstart=MediumT.dewEnthalpy(MediumT.setSat_p(p_start));
//2000e3;
//
parameter Modelica.Units.SI.SpecificEnthalpy houtstart=MediumT.bubbleEnthalpy(MediumT.setSat_p(p_start));
//400e3;
//
parameter Modelica.Units.SI.SpecificEnthalpy hstart[:]=linspace(
                                                       hinstart,
                                                       houtstart,nV);
parameter Modelica.Units.SI.Temperature TwTst=MediumT.saturationTemperature((p_start))-3;
parameter Modelica.Units.SI.Temperature TwSst=MediumS.saturationTemperature(max((p_start-0.3e5),1e4))+3;
parameter Modelica.Units.SI.Temperature TwTstart[:]=linspace(TwTst,TwTst,nV);
parameter Modelica.Units.SI.Temperature TwSstart[:]=linspace(TwSst,TwSst,nV);

  Modelica.Units.SI.Area Axt;
  Modelica.Units.SI.AbsolutePressure pT(start=p_start);
  Modelica.Units.SI.AbsolutePressure pS;
  Modelica.Units.SI.AbsolutePressure Pcr;
  Modelica.Units.SI.SpecificEnthalpy h_gT;
  Modelica.Units.SI.SpecificEnthalpy h_in(start=hinstart);
  Modelica.Units.SI.SpecificEnthalpy h_out[nV](start=hstart);
  Modelica.Units.SI.MassFlowRate mdot;
  Modelica.Units.SI.HeatFlowRate Qhx[nV](start=linspace(1e2,1e1,nV),fixed=true);
  Modelica.Units.SI.HeatFlowRate Q;

parameter    Modelica.Units.SI.CoefficientOfHeatTransfer [nV] hi_smooth=fill(9700,nV);
parameter  Modelica.Units.SI.CoefficientOfHeatTransfer [nV] ho_smooth =fill(735,nV);
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
  Modelica.Units.SI.Temperature TwT[nV](start=TwTstart);
  Modelica.Units.SI.Temperature TwS[nV](start=TwSstart);
  Modelica.Units.SI.Temperature TS;
  Modelica.Units.SI.Temperature TsT[nV];
  Real PrT;
  Real PrS;
  Modelica.Units.SI.Diameter ls;
  Modelica.Units.SI.Thickness delta[nV];
  Modelica.Units.SI.DynamicViscosity muS;
  Modelica.Units.SI.SurfaceTension sigma;

  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow Heat_Port
    annotation (Placement(transformation(extent={{-10,40},{10,60}}),
        iconTransformation(extent={{-10,40},{10,60}})));

//initial equation
//  for i in 1:nV loop
//    h_out[i]=hstart;
//  end for;

  parameter SI.Time tau=5 "Time Constant";
algorithm
  Axt:=Ax/nV;
  Di:=Do - 2*th;
  Axi:=Axt*Di/Do;
equation
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

  for i in 1:nV loop

  TsT[i]=MediumT.temperature_ph(pT,h_out[i]);

  //hi[i]=NHES.Fluid.ClosureModels.HeatTransfer.alpha_Nusselt_Cond_horizontal_tubes( TwT[i],satT.Tsat,hgT,hfT,rhogT,rhofT,lamT,cpT,PrT,Di);
  //hi[i]=TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
    //  Di,kT,rhofT,mufT,lamT,cpT,rhogT,mugT,hfgT,TsT[i],satT.Tsat,TwT[i]);
  Qhx[i]=hi_smooth[i]*Axi*(TsT[i]-TwT[i]);
  //delta[i]=1;
  delta[i]=(kS*(TwS[i]-TS)*Axt/(Qhx[i]));
  //Qhx[i]=((3.36e-5)*((ls/delta[i])^1.18)*((pS/Pcr)^(-0.58))
          //*((pS*ls/(muS*(hgS-hfS)^0.5))^0.406)*(muS*(hgS-hfS)*Axt/ls));
 // ho[i]=((cpS/((hgS-hfS)*(PrS*0.01)))^3)*muS*(hgS-hfS)*
      //  ((Modelica.Constants.g_n*(rhofS-rhogS)/sigma)^0.5);
  Qhx[i]=Axt*ho_smooth[i]* (TwS[i]-TS);
  Qhx[i]=2*k*Axt/(Do*log(Do/Di))*(TwT[i]-TwS[i]);

  end for;

 // Total HT
 if mdot>1e-8 then
 h_out[1]=h_in-Qhx[1]/mdot;
 else
 h_out[1]=h_in;
 end if;
 if mdot>1e-8 then
 for i in 2:nV loop
     h_out[i]=h_out[i-1]-Qhx[i]/mdot;
 end for;
  else
   for i in 2:nV loop
     h_out[i]=h_out[i-1];
 end for;
 end if;
  Q=sum(Qhx);
  //Connectors

  p_input = pT;
  mdot=m_flow_input;
  h_in =h_input;
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
end SEE_Tube_Side_PoolBoiling_smooth_portlessconsatn;
