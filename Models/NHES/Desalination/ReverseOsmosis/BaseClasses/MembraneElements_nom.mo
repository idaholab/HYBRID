within NHES.Desalination.ReverseOsmosis.BaseClasses;
model MembraneElements_nom "RO membrane element model - nominal operating conditions"
  extends NHES.Desalination.Icons.MembraneElement;
  import BrineProperties = NHES.Desalination.Media.BrineProp;

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium =
      NHES.Desalination.Media.BrineProp.BrineDriesner
    constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model" annotation (choicesAllMatching=true);

  // ---------- Define constants -----------------------------------------------
  constant Real Rg(final unit = "J/(mol.K)") = Modelica.Constants.R
    "Molar gas constant";
  constant Real MW_NaCl(final unit = "g/mol") = 1000*BrineProperties.SaltData.M_NaCl
    "Molecular weight of NaCl";
  constant Integer NumValElectrons_NaCl = BrineProperties.SaltData.nM_NaCl
    "[ion moles/mol]";

  // ---------- Define parameters ----------------------------------------------

  // ----- Membrane specifications -----
  parameter SI.Length lb = 0.8665 "Brine channel length of RO element";
  parameter SI.Length hb = 0.0007112 "Brine channel height of RO element";
  parameter SI.Length wb = 1.34 "Brine channel width of RO element";
  parameter Integer ne = 16 "Number of leaves per element";
  parameter Real alpha1 = 8.6464 "Constant for solvent transport";
  parameter NHES.Desalination.Types.solvent_transport_const alpha2 = 0.0149
    "Constant for solvent transport";
  parameter Real beta1 = 14.648 "Constant for solute transport";
  parameter NHES.Desalination.Types.solvent_transport_para Lv0 = 1.042 * 1e-11
    "Intrinsic solvent transport parameter";
  parameter NHES.Desalination.Types.solute_transport_para Ls0 = 1.333 * 1e-8
    "Intrinsic solute transport parameter";
  parameter Real scaling_percent(unit = "1") = 5
    "Percentage of inactive membrane area due to scaling [%]";
  parameter NHES.Desalination.Types.fouling_cake Rc = 0 "fouling due to cake formation";
  parameter Real void_fraction = 0.9 " Void fraction of the brine channel";
  //parameter Integer No_elements = 1;
  parameter Integer No_elements = 6;
  final parameter SI.Area Am = lb * wb * 2 * ne * No_elements
    "Active membrane area";
  final parameter NHES.Desalination.Types.specific_surface asp = 8 / hb
    "Specific surface of a feed spacer";
  final parameter SI.Length dh = 4 * void_fraction / (2 / hb + (1 - void_fraction) * asp)
    "Hydraulic diameter";
  final parameter SI.Volume Vb = ne * lb * hb * wb * void_fraction * No_elements
    "Total volume of the brine channel per element";
  parameter NHES.Desalination.Utilities.Options.Temp initOpt = NHES.Desalination.Utilities.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  // ----- Operating conditions -----
  parameter SI.Pressure Pf_start = 17.51325e5 "Feed Pressure Start Value [Pa]" annotation(Dialog(tab = "Initialisation"));
  parameter SI.Pressure Pr_start = 15.4989e5
    "Retentate Pressure Start Value [Pa]" annotation(Dialog(tab = "Initialisation"));
  final parameter SI.Pressure Pb_start = (Pf_start + Pr_start)/2
    "Bulk stream pressure start value [Pa]";
  parameter SI.Pressure Pp_start = 1.01325e5
    "Permeate Pressure Start Value [Pa]"  annotation(Dialog(tab = "Initialisation"));
  parameter SI.Pressure Osmotic_Pstart_Pa = 4.91635e5
    "Osmotic pressure start value[Pa]"  annotation(Dialog(tab = "Initialisation"));
  parameter Real Re_b_start = 248.997 "Start value of Reynolds No. for brine - bulk"  annotation(Dialog(tab = "Initialisation"));

  parameter SI.Temperature Tf_start_K = 25 + 273.15
    "Start value of feed temperature [K]" annotation(Dialog(tab = "Initialisation"));
  parameter SI.Temperature Tr_start_K = 25.2599 + 273.15
    "Start value of retentate temperature [K]" annotation(Dialog(tab = "Initialisation"));
  final parameter SI.Temperature Tb_start_K = (Tf_start_K + Tr_start_K)/2
    "Start value of average brine temperature [K]";
  parameter SI.Temperature Tp_start_K = Tb_start_K
    "Start value of permeate temperature [K]" annotation(Dialog(tab = "Initialisation"));

  parameter SI.MassFraction Xif_NaCl_start = 0.003502 "Start value of X_NaCl at feed []" annotation(Dialog(tab = "Initialisation"));
  parameter SI.MassFraction Xir_NaCl_start = 0.0066598 "Start value of X_NaCl at retentate []" annotation(Dialog(tab = "Initialisation"));
  parameter SI.MassFraction Xip_NaCl_start = 31.9019 * 1e-6 "Start value of X_NaCl at permeate []" annotation(Dialog(tab = "Initialisation"));
  final parameter SI.MassFraction Xif_start[:] = NHES.Desalination.Media.BrineProp.Xi2X({Xif_NaCl_start})
    "Start value of mass fractions at feed";
  final parameter SI.MassFraction Xir_start[:] = NHES.Desalination.Media.BrineProp.Xi2X({Xir_NaCl_start})
    "Start value of mass fractions at retentate";
  final parameter SI.MassFraction Xib_start[:] = NHES.Desalination.Media.BrineProp.Xi2X({(Xif_NaCl_start + Xir_NaCl_start)/2})
    "Start value of mass fractions of the bulk stream";
  final parameter SI.MassFraction Xip_start[:] = NHES.Desalination.Media.BrineProp.Xi2X({Xip_NaCl_start})
    "Start value of mass fractions at permeate";

  final parameter SI.SpecificEnthalpy hstartFeed = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(Pf_start, Tf_start_K, Xif_start[1])
    "Start value of the feed specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy hstartRetentate = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(Pr_start, Tr_start_K, Xir_start[1])
    "Start value of the retentate specific enthalpy [J/kg]";
  final parameter SI.SpecificEnthalpy hstartPermeate = NHES.Desalination.Media.BrineProp.SpecificEnthalpies.specificEnthalpy_pTX_Driesner(Pp_start, Tp_start_K, Xip_start[1])
    "Start value of the permeate specific enthalpy [J/kg]";

  parameter SI.MassFlowRate wf_start = 4.39693 "Start value of the feed mass flow rate" annotation(Dialog(tab = "Initialisation"));
  parameter SI.MassFlowRate wr_start = 2.30206 "Start value of the retentate mass flow rate" annotation(Dialog(tab = "Initialisation"));

  final parameter NHES.Desalination.Types.VolumeFlowRate_m3_hr Qf_start = wf_start/Medium.density(stateFeedStart)*3600 "Start value of the feed volumetric flow rate [m3/hr])";
  final parameter NHES.Desalination.Types.VolumeFlowRate_m3_hr Qr_start = wr_start/Medium.density(stateRetentateStart)*3600 "Start value of the retentate volumetric flow rate [m3/hr])";
  final parameter NHES.Desalination.Types.VolumeFlowRate_m3_hr Qp_start = (wf_start - wr_start)/Medium.density(statePermeateStart)*3600 "Start value of the permeate volumetric flow rate [m3/hr])";

  final parameter SI.Density rho_f_start =    Medium.density(stateFeedStart) "Start value of the feed (saline water) density [kg/m3]";
  final parameter SI.Density rho_r_start =    Medium.density(stateRetentateStart) "Start value of the retentate (concentrate) density [kg/m3]";
  final parameter SI.Density rho_bulk_start = Medium.density(stateBulkStart) "Start value of the bulk density [kg/m3]";
  final parameter SI.Density rho_p_start =    Medium.density(statePermeateStart) "Start value of the permeate (fresh water) density [kg/m3]";

  final parameter NHES.Desalination.Types.solute_transport_para Ls_b_start = Ls0*exp(beta1*(Tb_start_K - 273)/273) "Start value for the solute transport parameter [m/s]";
  parameter NHES.Desalination.Types.solvent_transport_para Lv_b_start = 8.9111*1e-12
    "Start value for the solvent transport parameter [m/(Pa.s)]" annotation(Dialog(tab = "Initialisation"));

  // ----- Declare variables -----
  SI.MassFlowRate wf(min = 0, start = wf_start) "Feed mass flow rate [kg/s]";
  SI.MassFlowRate wr(min = 0, start = wr_start) "Retentate mass flow rate [kg/s]";
  SI.MassFlowRate wp(min = 0, start = wf_start - wr_start) "Permeate mass flow rate [kg/s]";

  Medium.SpecificEnthalpy hf(start = hstartFeed) "Enthalpy of entering fluid - Feed";
  Medium.SpecificEnthalpy hr(start = hstartRetentate) "Enthalpy of outgoing fluid - Retentate";
  Medium.SpecificEnthalpy hp(start = hstartPermeate) "Enthalpy of outgoing fluid - Permeate";

  Medium.MassFraction Xi_f[Medium.nX](min={0,0},max={1,1}, start = Xif_start) "Reduced solute mass fractions";
  Medium.MassFraction Xi_r[Medium.nX](min={0,0},max={1,1}, start = Xir_start) "Reduced solute mass fractions";
  Medium.MassFraction Xi_p[Medium.nX](min={0,0},max={1,1}, start = Xip_start) "Reduced solute mass fractions";
  Medium.MassFraction Xi_b[Medium.nX](min={0,0},max={1,1}, start = Xib_start) "Reduced solute mass fractions";

  Medium.Temperature Tf(min = 273, start = Tf_start_K)
    "Feed temperature [K]";
  Medium.Temperature Tr(min = 273, start = Tr_start_K)
    "Retentate temperature [K]";
  Medium.Temperature Tb(min = 273, start = Tb_start_K)
    "Average brine temperature [K]";
  Medium.Temperature Tp(min = 273, start = Tp_start_K)
    "Permeate temperature [K]";
  Modelica.Units.NonSI.Temperature_degC Tf_C(min=0) "Feed temperature [C])";
  Modelica.Units.NonSI.Temperature_degC Tr_C(min=0)
    "Rententate temperature [C]";
  Modelica.Units.NonSI.Temperature_degC Tp_C(min=0) "Permeate temperature [C]";

  SI.Density rho_f(min = 0, start = rho_f_start) "feed (saline water) density [kg/m3]";
  SI.Density rho_r(min = 0, start = rho_r_start) "retentate (concentrate) density [kg/m3]";
  SI.Density rho_bulk(min = 0, start = rho_bulk_start) "bulk density [kg/m3]";
  SI.Density rho_p(min = 0, start = rho_p_start) "permeate (fresh water) density [kg/m3]";

  SI.Pressure Pf_Pa(min = 101300, start = Pf_start) "feed absolute pressure [Pa]";
  SI.Pressure Pr_Pa(min = 101300, start = Pr_start) "retentate absolute pressure [Pa]";
  SI.Pressure Pp_Pa(min = 101300, start = Pp_start) "permeate absolute pressure [Pa]";
  SI.Pressure Pb_Pa(min = 101300, start = Pb_start) "bulk absolute pressure [Pa]";
  NHES.Desalination.Types.Pressure_bar Pf(min = 0, start = Pf_start*1e-5) "Feed pressure [bar]";
  NHES.Desalination.Types.Pressure_bar Pr(min = 0, start = Pr_start*1e-5) "retentate pressure [bar]";

  NHES.Desalination.Types.Salinity Sf(min = 0, start = Xif_NaCl_start*1e6) "feed NaCl salinity [ppm]";
  NHES.Desalination.Types.Salinity Sr(min = 0, start = Xir_NaCl_start*1e6) "retentate NaCl salinity [ppm])";
  NHES.Desalination.Types.Salinity Sb(min = 0, start = (Xif_NaCl_start+Xir_NaCl_start)/2*1e6) "bulk NaCl salinity [ppm]";
  NHES.Desalination.Types.Salinity Sp(min = 0, start = Xip_NaCl_start*1e6) "permeate NaCl salinity [ppm]";

  NHES.Desalination.Types.VolumeFlowRate_m3_hr Qf(min = 0, start = Qf_start) "feed volumetric flow rate [m3/hr])";
  NHES.Desalination.Types.VolumeFlowRate_m3_hr Qr(min = 0, start = Qr_start) "retentate volumetric flow rate [m3/hr]";
  NHES.Desalination.Types.VolumeFlowRate_m3_hr Qp(min = 0, start = Qp_start) "permeate volumetric flow rate [m3/hr]";

  SI.Velocity Vzf(min = 0, start = Qf_start/3600/(wb*hb*void_fraction*ne))
    "feed crossflow velocity in an RO brine channel";
  SI.Velocity Vzr(min = 0, start = Qr_start/3600/(wb*hb*void_fraction*ne))
    "retentate crossflow velocity in an RO brine channel";
  SI.Velocity Vzb(min = 0, start = (Qf_start+Qr_start)/3600/(wb*hb*void_fraction*ne))
    "bulk crossflow velocity in an RO brine channel";

  SI.MassConcentration Cf_mass(min = 0, start = Xif_NaCl_start*rho_f_start) "feed mass concentration [kg/m3]";
  SI.MassConcentration Cr_mass(min = 0, start = Xir_NaCl_start*rho_r_start) "retentate mass concentration [kg/m3]";
  SI.MassConcentration Cb_mass(min = 0, start = (Xif_NaCl_start + Xir_NaCl_start)/2*rho_bulk_start) "bulk mass concentration [kg/m3]";
  SI.MassConcentration Cp_mass(min = 0, start = Xip_NaCl_start*rho_p_start) "permeate mass concentration [kg/m3]";

  SI.DynamicViscosity Dyn_visb(min = 0) "dynamic viscosity of the brine [Pa.s]";
  SI.KinematicViscosity Kin_visb(min = 0) "kinematic viscosity of the brine [m2/s]";
  SI.DiffusionCoefficient D_NaCl_b(min = 0) "solute diffusion coefficient [m2/s]";
  NHES.Desalination.Types.MassTransferCoefficient k_NaCl_b(min = 0) "solute mass transfer coefficient [m/s]";
  NHES.Desalination.Types.solute_transport_para Ls_b(min = 0, start = Ls_b_start) "solute transport parameter [m/s]";
  NHES.Desalination.Types.solvent_transport_para Lv_b(min = 0, start = Lv_b_start)
    "solvent transport parameter [m/(Pa.s)]";

  Real Re_b(min = 0, start = Re_b_start) "Reynolds No. for brine - bulk";
  Real friction_factor(min = 0) "friction factor for the pressure drop across an RO element []";
  SI.Pressure Pd_avg_Pa(min = 0, start=(Pf_start - Pr_start)/2) "average pressure drop across an RO element [Pa]";
  SI.Pressure Trans_deltaP_Pa(min = 0, start = Pf_start - Pp_start) "tranmembrane operating pressure differential [Pa]";
  NHES.Desalination.Types.MolarConcentration Cb_mol(min = 0) "bulk molar concentration [mol/m3]";
  NHES.Desalination.Types.MolarConcentration Cp_mol(min = 0) "permeate molar concentration [mol/m3]";
  NHES.Desalination.Types.SolventFlux Jv_b(min = 0) "Solvent transport or flux [m/s]";

  SI.Pressure Osmotic_P_Pa(min = 100000, start = Osmotic_Pstart_Pa) "osmotic pressure difference [Pa]";
  NHES.Desalination.Types.Pressure_bar Osmotic_P(min = 1, start=Osmotic_Pstart_Pa*1e-5) "osmotic pressure difference [bar]";
  SI.Mass m(min = 0, start = Vb*rho_bulk_start) "mass of the medium within the control volume [kg]";
  SI.InternalEnergy U(min = 0, start = Vb*rho_bulk_start*Medium.specificInternalEnergy(stateBulkStart)) "total internal energy [J]";

  Real conPolarization "concentration polarization factor []";
  SI.MassConcentration Cm_mass(min = 0)
    "salt concentration at the membrane surface [kg/m3]";
  SI.MassConcentration Cm_Cp_mass
    "concentration driving force across the membrane [kg/m3]";
  SI.MassConcentration Cb_Cp_mass
    "concentration driving force between the brine and permeate [kg/m3]";

  NHES.Desalination.Types.SoluteFlux Js_b(min = 0) "solute transport or flux [kg/(m2.s)]";
  Real SaltRejection(unit = "1", min = 80, max = 100) "Salt rejection [%]";
  NHES.Desalination.Types.MassFlowRate_kg_hr mp(min = 0) "permeate mass flow rate [kg/hr]";
  NHES.Desalination.Types.MassFlowRate_kg_hr mp_NaCl(min = 0) "solute mass flow rate [kg/hr]";

  // ----- Initial thermodynamic states  -----
protected
  final parameter Medium.ThermodynamicState stateFeedStart =      Medium.setState_pTX(Pf_start, Tf_start_K, Xif_start);
  final parameter Medium.ThermodynamicState stateRetentateStart = Medium.setState_pTX(Pr_start, Tr_start_K, Xir_start);
  final parameter Medium.ThermodynamicState stateBulkStart =      Medium.setState_pTX(Pb_start, Tb_start_K, Xib_start);
  final parameter Medium.ThermodynamicState statePermeateStart =  Medium.setState_pTX(Pp_start, Tp_start_K, Xip_start);

  // ----- Thermodynamic states -----
  Medium.ThermodynamicState stateFeed(p(start = Pf_start), T(start = Tf_start_K), X(start = Xif_start))
    "Fluid properties in the feed side";
  Medium.ThermodynamicState stateRetentate(p(start = Pr_start), T(start = Tr_start_K), X(start = Xir_start))
    "Fluid properties in the retentate side";
  Medium.ThermodynamicState stateBulk(p(start = Pb_start), T(start = Tb_start_K), X(start = Xib_start))
    "Fluid properties in the brine (bulk) side";
  Medium.ThermodynamicState statePermeate(p(start = Pp_start), T(start = Tp_start_K), X(start = Xip_start))
    "Fluid properties in the permeate side";

equation
  // ----------- Fluid properties ----------------------------------------------
//  stateFeed = Medium.setState_phX(FeedFlange.p, inStream(FeedFlange.h_outflow), inStream(FeedFlange.Xi_outflow));
//  stateFeed = Medium.setState_phX(Pf_Pa, hf, Xi_f);
//  Tf = Medium.temperature(stateFeed);
//  rho_f = Medium.density(stateFeed);

  stateFeed = Medium.setState_pTX(Pf_Pa, Tf, Xi_f);
  hf = Medium.specificEnthalpy(stateFeed);
  rho_f = Medium.density(stateFeed);

//  stateRetentate = Medium.setState_phX(RetentateFlange.p, RetentateFlange.h_outflow, RetentateFlange.Xi_outflow);
//  stateRetentate = Medium.setState_phX(Pr_Pa, hr, Xi_r);
//  Tr = Medium.temperature(stateRetentate);
//  rho_r = Medium.density(stateRetentate);

  stateRetentate = Medium.setState_pTX(Pr_Pa, Tr, Xi_r);
  hr = Medium.specificEnthalpy(stateRetentate);
  rho_r = Medium.density(stateRetentate);

  stateBulk = Medium.setState_pTX(Pb_Pa, Tb, Xi_b);
  rho_bulk  = Medium.density(stateBulk);
  Dyn_visb  = Medium.dynamicViscosity(stateBulk);

//  statePermeate = Medium.setState_phX(PermeateFlange.p, PermeateFlange.h_outflow, PermeateFlange.Xi_outflow);
  //statePermeate = Medium.setState_phX(Pp_Pa, hp, Xi_p);
  //Tp = Medium.temperature(statePermeate);
  //rho_p = Medium.density(statePermeate);

  statePermeate = Medium.setState_pTX(Pp_Pa, Tp, Xi_p);
  hp = Medium.specificEnthalpy(statePermeate);
  rho_p = Medium.density(statePermeate);

  // ---------- Boundary conditions --------------------------------------------
  wf = wf_start;
  //Pf_Pa = Pf_start "This will be determined by Pr sink, so remove later";
  Tf = Tf_start_K;
  Xi_f = Xif_start;

  Pp_Pa = 1.01325*1e5 "Incorporate Sink later";

  // ----- Intermediate variables -----
  Pb_Pa = (Pf_Pa + Pr_Pa)/2 "[Pa]";
  Pf = Pf_Pa * 1e-5;
  Pr = Pr_Pa * 1e-5;

  Tb = (Tf + Tr)/2;
  Tf_C =Modelica.Units.Conversions.to_degC(Tf);
  Tr_C =Modelica.Units.Conversions.to_degC(Tr);
  Tp_C =Modelica.Units.Conversions.to_degC(Tp);

  Sf = Xi_f[1]*1e6;
  Xi_r = NHES.Desalination.Media.BrineProp.Xi2X({Sr*1e-6});
  Xi_p = NHES.Desalination.Media.BrineProp.Xi2X({Sp*1e-6});
  Xi_b = (Xi_f + Xi_r)/2;
  Sb = (Sf + Sr)/2;

  Cf_mass = Xi_f[1] * rho_f;
  Cr_mass = Xi_r[1] * rho_r;
  Cb_mass = Xi_b[1] * rho_bulk;

  Qf = wf / rho_f * 3600 "[m3/hr]";
  Qr = wr / rho_r * 3600 "[m3/hr]";
  assert(Qr >= 0, "The RO model does not support flow reversal");
  Qp = wp / rho_p * 3600 "[m3/hr]";

  Vzf = Qf / 3600 / (wb * hb * void_fraction * ne);
  Vzr = Qr / 3600 / (wb * hb * void_fraction * ne);
  Vzb = (Vzf + Vzr) / 2;

  Kin_visb = Dyn_visb/rho_bulk;
  D_NaCl_b = NHES.Desalination.Utilities.diffusionCoefficient_TC(Tb, Cb_mass);
  k_NaCl_b = (dh*Vzb/Kin_visb) ^ 0.875 * (Kin_visb/D_NaCl_b) ^ 0.25*(D_NaCl_b/dh)*0.065;

  Ls_b = Ls0 * exp(beta1 * (Tb - 273) / 273);
  Lv_b = 1/(1/(Lv0 * exp(alpha1*(Tb - 293) / 293 - alpha2*Pf)) + Rc*Dyn_visb) * (1 - scaling_percent/100);
  Re_b = Vzb * dh / Kin_visb;
  friction_factor = 6.23 * Re_b ^ (-0.3);
  Trans_deltaP_Pa = Pf_Pa - Pp_Pa;

  Cb_mol = Cb_mass * 1000 / MW_NaCl;
  Cp_mol = Ls_b * Cb_mol * (1 + Jv_b / k_NaCl_b) / (Jv_b + Ls_b);
  Cp_mass = Cp_mol * MW_NaCl / 1000;
  Jv_b = Lv_b * (Trans_deltaP_Pa - Osmotic_P_Pa - Pd_avg_Pa);
  Osmotic_P_Pa = NumValElectrons_NaCl * (Cb_mol * (1 + Jv_b / k_NaCl_b) - Cp_mol) * Rg * Tb;
  Osmotic_P = Osmotic_P_Pa*1e-5;

  Sp = Cp_mol * MW_NaCl * 1000 / rho_p;
  Qp = Jv_b * Am * 3600;

  m = Vb * rho_bulk;
  U = m * Medium.specificInternalEnergy(stateBulk);

  // ----- Auxiliary variables -----
  conPolarization = exp(Jv_b/k_NaCl_b);
  Cm_mass = conPolarization*(Cb_mass-Cp_mass)+Cp_mass;
  Cm_Cp_mass = Cm_mass - Cp_mass;
  Cb_Cp_mass = Cb_mass - Cp_mass;
  Js_b = Jv_b*Cp_mass;

  SaltRejection = (1 - Sp / Sb) * 100;
  mp = rho_p * Qp;
  mp_NaCl = Cp_mass * Qp;

  // ---------- Momentum, mass, and energy balances ----------------------------
  // ----- Pressure drop -----
  Pd_avg_Pa = No_elements * friction_factor * rho_bulk * Vzb ^ 2 / (2 * dh) * lb / 2;
  Pr = Pf - (Pd_avg_Pa*1e-5)*2;
  Pr = 15.4989 "Remove later...";

  // ----- Overall material balance -----
  // 0 = wf - wr - wp;
  // 0 = Qf*rho_f - Qr*rho_r - Qp*rho_p;
  der(m) = wf - wr - wp;
  // Vb*der(rho_bulk) = (Qf*rho_f - Qr*rho_r - Qp*rho_p)/3600;

  // ----- Component (NaCl) material balance -----
  // 0 = Cf_mass*Qf - Cr_mass*Qr - Cp_mass*Qp;
  Vb*der(Cb_mass) = (Cf_mass * Qf - Cr_mass * Qr - Cp_mass * Qp) / 3600;

  // ----- Energy balances -----
  Tb = Tp;
  // 0 = hf*wf - hr*wr - hp*wp;
  der(U) = hf * wf - hr * wr - hp * wp;

initial equation
  if initOpt == NHES.Desalination.Utilities.Options.noInit then
    // do nothing
  elseif initOpt == NHES.Desalination.Utilities.Options.userSpecified then
    //  Vzr = Vzf;
    //  Sr = Sf;
    //  Tb = 25 + 273.15;

    //der(m) = 0;
    //der(Cb_mass) = 0;

  elseif initOpt == NHES.Desalination.Utilities.Options.steadyState then
    der(m) = 0;
    der(Cb_mass) = 0;
    der(U) = 0;
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      experiment(
      StopTime=100,
      Interval=1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end MembraneElements_nom;
