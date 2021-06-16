within NHES.Fluid.Vessels;
model Desorber

  replaceable package Medium_v =
  Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching);

  replaceable package Medium_sol =
    Media.TwoPhaseMixtures.LithiumBromideWater.LithiumBromideWater_pTX constrainedby
    Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching);

  parameter SI.Diameter D_pool=0.25 "Solution pool diameter";
  SI.Height H_pool(start=1) "Solution pool height";
  SI.Volume V_sol(min=1e-6) "Solution volume";
  SI.Mass m_sol(
    start=5.8,
    min=0,
    fixed=true) "Solution mass";
  SI.Density d_sol(start=1500, min=1e-6)
    "Solution bulk density";
  SI.Energy U_sol "Solution internal energy";
  SI.MassFraction X_sol(start=0.653, fixed=true)
    "Solution bulk mass fraction";
  SI.Temperature T_sat_sol(
    start=360,
    min=280,
    fixed=true) "Solution bulk saturation temperature";
  SI.MassFraction X_a_check;

  outer Modelica.Fluid.System system;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare package Medium = Medium_sol,
    h_outflow(start=458.3e3))
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium_sol,
    h_outflow(start=170.7e3))
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_v(
    redeclare package Medium = Medium_v,
    h_outflow(start=2946e3))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Q
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

protected
  Medium_sol.ThermodynamicState port_a_state_inflow;
  Medium_sol.ThermodynamicState port_b_state_inflow;
  Medium_v.ThermodynamicState port_v_state_inflow;
  Medium_sol.ThermodynamicState pool_state;

equation
  m_sol = d_sol*V_sol;
  der(m_sol) = port_a.m_flow + port_b.m_flow + port_v.m_flow;
  der(X_sol*m_sol) = port_a.m_flow*actualStream(port_a.Xi_outflow[1]) + port_b.m_flow*actualStream(port_b.Xi_outflow[1]);
  der(U_sol) = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*actualStream(port_b.h_outflow) + port_v.m_flow*actualStream(port_v.h_outflow) + port_Q.Q_flow;

  U_sol = m_sol*Medium_sol.specificInternalEnergy(pool_state);
  V_sol = H_pool*Modelica.Constants.pi*(D_pool/2)^2 "Assume cylindrical solution pool";
  d_sol = Medium_sol.density(pool_state);

  port_a.p = port_v.p;
  port_b.p = port_v.p;
  port_v.p = Media.TwoPhaseMixtures.LithiumBromideWater.LiBrW_Utilities.BaseLiBrW.Basic.psat(T_sat_sol, port_b.Xi_outflow);

  port_a.h_outflow = Medium_sol.specificEnthalpy(port_a_state_inflow);
  port_b.h_outflow = Medium_sol.specificEnthalpy(pool_state);
  port_v.h_outflow = Medium_sol.specificEnthalpy(port_v_state_inflow);

  port_a.Xi_outflow = Medium_sol.massfraction(port_a_state_inflow);
  port_b.Xi_outflow = Medium_sol.massfraction(pool_state);
  port_v.Xi_outflow = Medium_sol.massfraction(port_v_state_inflow);

  // Medium states for inflowing fluid
  port_a_state_inflow = Medium_sol.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
  port_b_state_inflow = Medium_sol.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
  port_v_state_inflow = Medium_v.setState_phX(port_v.p, inStream(port_v.h_outflow), inStream(port_v.Xi_outflow));

  pool_state = Medium_sol.setState_pTX(port_b.p, T_sat_sol, {X_sol, 1 - X_sol});
  X_a_check = actualStream(port_a.Xi_outflow[1]);

  // Heat transfer assumptions
  port_Q.T = T_sat_sol;

end Desorber;
