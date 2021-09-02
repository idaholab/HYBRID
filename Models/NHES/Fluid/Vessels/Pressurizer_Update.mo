within NHES.Fluid.Vessels;
model Pressurizer_Update
  "Pressurizer that has the ability to incorporate sprays and heaters based on three equation model using SI"

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
     annotation(choicesAllMatching=true);
  type specific_energy = Real (final unit="J/m3");

//extends NHES.Fluid.Vessels.BaseClasses.BaseDrum.PartialDrum2Phase;

  outer Modelica.Fluid.System system "System properties";

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
    annotation(Dialog(tab="Assumptions"));

 // Medium.SaturationProperties sat "Saturation properties";

 // parameter SI.Volume V_pressurizer=1;
  parameter SI.Volume V_total=1 "Total pressurizer volume";
  parameter SI.Pressure p_start=160e5 "Initial pressure" annotation(Dialog(tab="Initialization"));
  parameter Real alphaV_start=0.5 "Initial void fraction" annotation(Dialog(tab="Initialization"));
  Modelica.Fluid.Interfaces.FluidPort_a port_spray(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_surge(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heaters_Port
    annotation (Placement(transformation(extent={{-110,-58},{-90,-38}})));
 // parameter SI.Area A_Pressurizer = 15;
 // SI.MassFlowRate mspray;
 // SI.MassFlowRate m_surge;
 // SI.Density rho_prz;
 // SI.Height level;
 // specific_energy rhou;
 // Real alphag(start=0.5);
//  input SI.Power Q_htr;

  /* Redefinition of Port Parameters */
//   SI.MassFlowRate W_surge "Mass flowrate of surgePort";
   //SI.SpecificEnthalpy h_surge(start=Medium.bubbleEnthalpy(Medium.setSat_p(p))) "Specific enthalpy of surgePort";
//   SI.MassFlowRate W_steam "Mass flowrate of steamPort";
//   SI.SpecificEnthalpy h_steam "Specific enthalpy of steamPort";
//   SI.MassFlowRate W_spray "Mass flowrate of sprayPort";
 //  SI.SpecificEnthalpy h_spray(start=Medium.dewEnthalpy(Medium.setSat_p(p))) "Specific enthalpy of sprayPort";
 //  SI.Pressure p(start=1.27e5);

//  Real rhof_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
//  Real rhog_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
// Real ug_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.ug(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
// Real uf_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.uf(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));

  final parameter Medium.SaturationProperties sat_start=Medium.setSat_p(p_start) "Properties of saturated fluid";
  final parameter Medium.ThermodynamicState bubble_start=Medium.setBubbleState(sat_start, 1) "Bubble point state";
  final parameter Medium.ThermodynamicState dew_start=Medium.setDewState(sat_start, 1) "Dew point state";
  final parameter SI.Density d_start=(1 - alphaV_start)*bubble_start.d + alphaV_start*dew_start.d;
  final parameter SI.SpecificInternalEnergy u_lsat_start=bubble_start.h - p_start/bubble_start.d;
  final parameter SI.SpecificInternalEnergy u_vsat_start=dew_start.h - p_start/dew_start.d;
  final parameter SI.SpecificInternalEnergy u_start=((1 - alphaV_start)*bubble_start.d*u_lsat_start + alphaV_start*
      dew_start.d*u_vsat_start)/d_start;

  SI.Density d(start=d_start) "Average pressurizer density";

  Real alphaV(start=alphaV_start) "Void fraction";
  SI.Density d_lsat=bubble.d "Saturated liquid density";
  SI.Density d_vsat=dew.d "Saturated vapor density";

  SI.SpecificInternalEnergy u(start=u_start) "Specific internal energy";
  SI.SpecificInternalEnergy u_lsat(start=u_lsat_start) "Specific internal energy";
  SI.SpecificInternalEnergy u_vsat(start=u_vsat_start) "Specific internal energy";

  SI.Pressure p(start=p_start);

  Medium.SaturationProperties sat "Properties of saturated fluid";
  Medium.ThermodynamicState bubble "Bubble point state";
  Medium.ThermodynamicState dew "Dew point state";

equation

//    //p=1000;
//    //alphag=1.0;
//   // sat.psat = p;
//   // sat.Tsat = Modelica.Media.Water.WaterIF97_base.saturationTemperature(p);
//   mspray=spray_port.m_flow;
//   m_surge=-surge_port.m_flow;
//   //Mass Conservation Equation
//   der(rho_prz)*V_pressurizer = mspray - m_surge + CVCS_Outlet_Port.m_flow;
//
//   //Energy Conservation Equation
//   der(rhou)*V_pressurizer = mspray*h_spray - m_surge*h_surge + Heaters_Port.Q_flow + CVCS_Outlet_Port.m_flow*surge_port.h_outflow;
//   level = (1.-alphag)*V_pressurizer/A_Pressurizer;
//   //state equations
//   if alphag >=0 and alphag <=1 then
//    // rho_prz = Medium.bubbleDensity(sat)+ alphag*(Medium.dewDensity(sat)-Medium.bubbleDensity(sat));
//     rho_prz = TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_feet3((rhof_eng + alphag*(rhog_eng - rhof_eng)));
//
//     //rho_prz = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi()
//     rhou = 3.726e4*(rhof_eng*uf_eng + alphag*(rhog_eng*ug_eng - rhof_eng*uf_eng));
//     //rhou = Medium.bubbleDensity(sat)*Medium.bubbleEnthalpy(sat)+alphag*(Medium.dewDensity(sat)*Medium.dewEnthalpy(sat)-Medium.bubbleDensity(sat)*Medium.bubbleEnthalpy(sat));
//   else
//     rho_prz = TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_feet3((rhof_eng));
//     rhou = 3.726e4*rhof_eng*uf_eng;
//   end if;
//
//   //Liquid Mass Equation
//
//Connector Defintions
//
//   spray_port.p = p;
//   spray_port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
//   surge_port.p = p + Modelica.Constants.g_n*TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_feet3((rhof_eng))*level;
//   surge_port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
//   Heaters_Port.T=300; //This doesn't actually do anything. Just need it to solve the equation.
//
//   //CVCS_Outlet_Port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
//   CVCS_Outlet_Port.h_outflow = (rhou + p)/rho_prz;
//
//   CVCS_Outlet_Port.p = p;
//
//   h_surge = homotopy(if not allowFlowReversal then inStream(surge_port.h_outflow)
//      else noEvent(actualStream(surge_port.h_outflow)), inStream(surge_port.h_outflow));
//
// Spray Port
//
//   h_spray =homotopy(if not allowFlowReversal then inStream(spray_port.h_outflow)
//      else noEvent(actualStream(spray_port.h_outflow)), inStream(spray_port.h_outflow));

  sat = Medium.setSat_p(p);
  bubble = Medium.setBubbleState(sat, 1);
  dew = Medium.setDewState(sat, 1);

  u_lsat = bubble.h - p/bubble.d;
  u_vsat = dew.h - p/dew.d;

  //State Equations
  d = (1 - alphaV)*d_lsat + alphaV*d_vsat;
  d*u = (1 - alphaV)*d_lsat*u_lsat + alphaV*d_vsat*u_vsat;

  //Energy Balance
  V_total*der(d*u) = port_spray.m_flow*actualStream(port_spray.h_outflow) + port_surge.m_flow*actualStream(
    port_surge.h_outflow) + Heaters_Port.Q_flow;

  //Mass Balance
  V_total*der(d) = port_spray.m_flow + port_surge.m_flow;

  // Port Parameters
  port_spray.p = p;
  port_surge.p = p;
  port_surge.h_outflow = bubble.h;
  port_spray.h_outflow = dew.h;
  Heaters_Port.T = 300; //Useless

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-66,-76},{80,50}}, fileName="modelica://NHES/Resources/Images/Systems/Pressurizer.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pressurizer_Update;
