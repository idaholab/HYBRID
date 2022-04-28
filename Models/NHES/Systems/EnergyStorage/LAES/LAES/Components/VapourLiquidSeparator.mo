within NHES.Systems.EnergyStorage.LAES.LAES.Components;
model VapourLiquidSeparator
  "Splits the liquid and vapour streams from a Joule-Thomson valve"
  import LAES_INL =
         NHES.Systems.EnergyStorage.LAES;
  extends LAES_INL.LAES.Components.Icons.VapourLiquidSeparator;

  replaceable package Medium = LAES_INL.LAES.Media.AirCoolProp constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";

  parameter Modelica.Units.SI.AbsolutePressure p_start=1;
  Modelica.Units.SI.MassFraction x "Vapour quality";
  Modelica.Units.SI.EnthalpyFlowRate HMixIn "Enthalpy flow rate at inlet";
  Modelica.Units.SI.EnthalpyFlowRate HVapourOut
    "Enthalpy flow rate at vapour outlet";
  Modelica.Units.SI.EnthalpyFlowRate HLiquidOut
    "Enthalpy flow rate at liquid outlet";
  Medium.ThermodynamicState InletState "Thermodynamic state of the fluid at inlet";
  Medium.SaturationProperties InletSat "Saturation properties of the fluid at inlet";
  Modelica.Units.SI.AbsolutePressure p(start=p_start) "System pressure";

  Modelica.Fluid.Interfaces.FluidPort_a        MixIn(redeclare package Medium
      =        Medium) "Mixed stream in" annotation (Placement(
        transformation(extent={{-120,0},{-80,40}}), iconTransformation(
          extent={{-120,0},{-80,40}})));
  Modelica.Fluid.Interfaces.FluidPort_b VaporOut(redeclare package Medium =
        Medium) "Vapor stream out"
    annotation (Placement(transformation(extent={{80,40},{120,80}})));
  Modelica.Fluid.Interfaces.FluidPort_b        LiquidOut(redeclare package
      Medium = Medium) "Liquid stream out"
    annotation (Placement(transformation(extent={{80,-80},{120,-40}})));

equation

  assert(MixIn.m_flow >= 0, "Reverse flow not allowed in separator");

  //Set fluid thermodynamic state and saturation properties
  InletState = Medium.setState_ph(MixIn.p, inStream(MixIn.h_outflow));
  x = Medium.vapourQuality(InletState);
  InletSat = Medium.setSat_p(p);

  //Mass balance
  LiquidOut.m_flow = -MixIn.m_flow * (1 - x) "Mass flow rate of liquid out defined by vapour quality";
  VaporOut.m_flow = -MixIn.m_flow*x
    "Mass flow rate of vapour out defined by vapour quality";

  //Equal pressure throughout
  MixIn.p = p;
  LiquidOut.p = p;

  //Enthalpy flow rate calculations
  HMixIn = inStream(MixIn.h_outflow) * MixIn.m_flow;
  HVapourOut =VaporOut.h_outflow*(-VaporOut.m_flow);
  HLiquidOut = LiquidOut.h_outflow * (-LiquidOut.m_flow);

  //Energy balance from quality calculations
  LiquidOut.h_outflow = Medium.bubbleEnthalpy(InletSat);
  HMixIn = HVapourOut + HLiquidOut;

  //Unused equations to complete the balance
  (LiquidOut.m_flow*inStream(LiquidOut.h_outflow)) + (VaporOut.m_flow*inStream(
    VaporOut.h_outflow)) + (MixIn.m_flow*MixIn.h_outflow) = 0 annotation (Icon(
        coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end VapourLiquidSeparator;
