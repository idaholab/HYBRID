within NHES.Fluid.HeatExchangers.Generic_HXs;
model Generic_HXR_NoMass

replaceable package Medium_h =
    Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX constrainedby
    Modelica.Media.Interfaces.PartialMedium
                                          annotation (choicesAllMatching);
replaceable package Medium_c =
    Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX constrainedby
    Modelica.Media.Interfaces.PartialMedium
                                          annotation (choicesAllMatching);

parameter Real epsilon(min=0, max=1)=0.9 "Heat exchanger effectiveness";
Modelica.Units.SI.EntropyFlowRate UA(start=1603e3, displayUnit="kW/K")
  "Overall HTC x HT area";

//SI.EntropyFlowRate C_h "Mean hot side heat rate";
//SI.EntropyFlowRate C_c "Mean cold side heat rate";
Medium_h.Temperature T_hi(start=545.7) = Modelica.Fluid.Utilities.regStep(
  port_hi.m_flow,
  Medium_h.temperature(hi_state),
  Medium_h.temperature(Medium_h.setState_phX(
    port_hi.p,
    port_hi.h_outflow,
    port_hi.Xi_outflow)));

Medium_h.Temperature T_ho(start=322.9) = Modelica.Fluid.Utilities.regStep(
  port_ho.m_flow,
  Medium_h.temperature(ho_state),
  Medium_h.temperature(Medium_h.setState_phX(
    port_ho.p,
    port_ho.h_outflow,
    port_ho.Xi_outflow)));

Medium_c.Temperature T_ci(start=298.2) = Modelica.Fluid.Utilities.regStep(
  port_ci.m_flow,
  Medium_c.temperature(ci_state),
  Medium_c.temperature(Medium_c.setState_phX(
    port_ci.p,
    port_ci.h_outflow,
    port_ci.Xi_outflow)));

Medium_c.Temperature T_co(start=485.7) = Modelica.Fluid.Utilities.regStep(
  port_co.m_flow,
  Medium_c.temperature(co_state),
  Medium_c.temperature(Medium_c.setState_phX(
    port_co.p,
    port_co.h_outflow,
    port_co.Xi_outflow)));

 //Medium_h.SpecificEnthalpy h_ho(start=170.7e3) = inStream(port_ho.h_outflow);
 //Medium_c.SpecificEnthalpy h_co(start=458.3e3) = inStream(port_co.h_outflow);

SI.Power Q_HT(start=63799e3) "Heat transfer";
SI.TemperatureDifference LMTD=Utilities.Functions.LMTD(
      T_hi,
      T_ho,
      T_ci,
      T_co,
      true) "Log-mean temperature difference";

outer Modelica.Fluid.System system;

Modelica.Fluid.Interfaces.FluidPort_a port_ci(redeclare package Medium =
      Medium_c)
  annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
Modelica.Fluid.Interfaces.FluidPort_b port_co(redeclare package Medium =
      Medium_c,
      h_outflow(start=458.3e3))
  annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
Modelica.Fluid.Interfaces.FluidPort_a port_hi(redeclare package Medium =
      Medium_h)
  annotation (Placement(transformation(extent={{50,90},{70,110}})));
Modelica.Fluid.Interfaces.FluidPort_b port_ho(redeclare package Medium =
      Medium_h,
      h_outflow(start=170.7e3))
  annotation (Placement(transformation(extent={{50,-110},{70,-90}})));

Medium_h.ThermodynamicState hi_state;
Medium_h.ThermodynamicState ho_state;
Medium_c.ThermodynamicState ci_state;
Medium_c.ThermodynamicState co_state;

equation
port_hi.m_flow + port_ho.m_flow = 0;
port_ci.m_flow + port_co.m_flow = 0;

port_hi.Xi_outflow = inStream(port_ho.Xi_outflow);
port_ho.Xi_outflow = inStream(port_hi.Xi_outflow);

port_ci.Xi_outflow = inStream(port_co.Xi_outflow);
port_co.Xi_outflow = inStream(port_ci.Xi_outflow);

port_hi.p = port_ho.p;
port_ci.p = port_co.p;

port_hi.h_outflow = inStream(port_ho.h_outflow);
Q_HT = port_ho.m_flow*(port_ho.h_outflow - inStream(port_hi.h_outflow));

port_ci.h_outflow = inStream(port_co.h_outflow);
Q_HT = port_co.m_flow*(inStream(port_ci.h_outflow) - port_co.h_outflow);

//C_h = port_hi.m_flow*Medium_h.specificHeatCapacityCp(hi_state);
//C_c = port_ci.m_flow*Medium_c.specificHeatCapacityCp(ci_state);

Q_HT = UA*LMTD;

epsilon = Utilities.Functions.epsilon(T_hi, T_co, T_ho, T_ci);

// Medium states for inflowing fluid
hi_state = Medium_h.setState_phX(
  port_hi.p,
  inStream(port_hi.h_outflow),
  inStream(port_hi.Xi_outflow));
ho_state = Medium_h.setState_phX(
  port_ho.p,
  inStream(port_ho.h_outflow),
  inStream(port_ho.Xi_outflow));
ci_state = Medium_c.setState_phX(
  port_ci.p,
  inStream(port_ci.h_outflow),
  inStream(port_ci.Xi_outflow));
co_state = Medium_c.setState_phX(
  port_co.p,
  inStream(port_co.h_outflow),
  inStream(port_co.Xi_outflow));
end Generic_HXR_NoMass;
