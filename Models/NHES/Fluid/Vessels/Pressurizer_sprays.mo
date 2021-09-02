within NHES.Fluid.Vessels;
model Pressurizer_sprays
  "Pressurizer with the ability to handle both sprays and heater inputs. Based on a three equation equilibrium model."

  import Modelica.Fluid.Types.Dynamics;

  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialTwoPhaseMedium
    "Medium in the component"
     annotation(choicesAllMatching=true);
  type specific_energy = Real (final unit="J/m3");

//extends NHES.Fluid.Vessels.BaseClasses.BaseDrum.PartialDrum2Phase;

  outer Modelica.Fluid.System system "System properties";

  // Initialization
  parameter SI.Pressure p_start=127.5e5 "Initial pressure" annotation(Dialog(tab="Initialization"));
  parameter Real alphag_start=0.5 "Initial void fraction" annotation(Dialog(tab="Initialization"));

 /* Assumptions */
  parameter Boolean allowFlowReversal=system.allowFlowReversal
    "= true to allow flow reversal, false restrics to design direction"
    annotation(Dialog(tab="Assumptions"));

  parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial "Formulation of energy balances"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
  parameter Dynamics massDynamics=energyDynamics "Formulation of mass balances"
    annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));

 // Medium.SaturationProperties sat "Saturation properties";

  parameter SI.Volume V_pressurizer=1;

  Modelica.Fluid.Interfaces.FluidPort_a spray_port(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b surge_port(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heaters_Port
    annotation (Placement(transformation(extent={{-110,-58},{-90,-38}})));
  parameter SI.Area A_Pressurizer = 15;
  SI.MassFlowRate mspray;
  SI.MassFlowRate m_surge;
  SI.Density rho_prz;
  SI.Height level;
  specific_energy rhou;
  Real alphag(start=alphag_start, fixed=true);
//  input SI.Power Q_htr;

  /* Redefinition of Port Parameters */
//   SI.MassFlowRate W_surge "Mass flowrate of surgePort";
   SI.SpecificEnthalpy h_surge(start=Medium.bubbleEnthalpy(Medium.setSat_p(p_start))) "Specific enthalpy of surgePort";
   SI.SpecificEnthalpy h_spray(start=Medium.dewEnthalpy(Medium.setSat_p(p_start))) "Specific enthalpy of sprayPort";
   SI.Pressure p(start=p_start, fixed=true);

  Real rhof_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhof(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  Real rhog_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.rhog(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  Real ug_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.ug(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  Real uf_eng = NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.uf(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));

  Modelica.Fluid.Interfaces.FluidPort_b CVCS_Outlet_Port(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{62,90},{82,110}})));

initial equation
    // Mass Balance
  if massDynamics == Dynamics.FixedInitial then
    p = p_start;
  elseif massDynamics == Dynamics.SteadyStateInitial then
    der(rho_prz) = 0;
  end if;

  // Energy Balance
  if energyDynamics == Dynamics.FixedInitial then
    alphag = alphag_start;
  elseif energyDynamics == Dynamics.SteadyStateInitial then
    der(rhou) = 0;
  end if;

equation

  //Mass Conservation Equation

  if massDynamics == Dynamics.SteadyState then
    0 = mspray - m_surge + CVCS_Outlet_Port.m_flow;
  else
    der(rho_prz)*V_pressurizer = mspray - m_surge + CVCS_Outlet_Port.m_flow;
  end if;
  //Energy Conservation Equation

 if energyDynamics == Dynamics.SteadyState then
  0 = mspray*h_spray - m_surge*h_surge + Heaters_Port.Q_flow + CVCS_Outlet_Port.m_flow*surge_port.h_outflow;
  level = (1.-alphag)*V_pressurizer/A_Pressurizer;
 else
  der(rhou)*V_pressurizer = mspray*h_spray - m_surge*h_surge + Heaters_Port.Q_flow + CVCS_Outlet_Port.m_flow*surge_port.h_outflow;
  level = (1.-alphag)*V_pressurizer/A_Pressurizer;
 end if;

  //state equations
  if alphag >=0 and alphag <=1 then
    rho_prz = TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_ft3((rhof_eng + alphag*(rhog_eng - rhof_eng)));
    rhou = 3.726e4*(rhof_eng*uf_eng + alphag*(rhog_eng*ug_eng - rhof_eng*uf_eng));
  else
    rho_prz = TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_ft3((rhof_eng));
    rhou = 3.726e4*rhof_eng*uf_eng;
  end if;

  //Liquid Mass Equation

//Connector Defintions

  spray_port.p = p;
  spray_port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  surge_port.p = p + Modelica.Constants.g_n*TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_ft3((rhof_eng))*level;
  surge_port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hf(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  Heaters_Port.T=300; //This doesn't actually do anything. Just need it to solve the equation.

  //CVCS_Outlet_Port.h_outflow = 2326.0*NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2.hg(TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_psi(p));
  CVCS_Outlet_Port.h_outflow = (rhou + p)/rho_prz;

  CVCS_Outlet_Port.p = p;
  mspray=spray_port.m_flow;
  m_surge=-surge_port.m_flow;

  h_surge = homotopy(if not allowFlowReversal then inStream(surge_port.h_outflow)
     else noEvent(actualStream(surge_port.h_outflow)), inStream(surge_port.h_outflow));

// Spray Port

  h_spray =homotopy(if not allowFlowReversal then inStream(spray_port.h_outflow)
     else noEvent(actualStream(spray_port.h_outflow)), inStream(spray_port.h_outflow));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-66,-76},{80,50}}, fileName=
              "modelica://NHES/Resources/Images/Systems/Pressurizer.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pressurizer_sprays;
