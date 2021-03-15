within NHES.Fluid.Interfaces;
partial model PartialDistributedVolume
  "Base class for distributed volume models"
  import Modelica.Fluid.Types.Dynamics;
  import Modelica.Media.Interfaces.Choices.IndependentVariables;

  outer Modelica.Fluid.System system "System properties";

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

  // Discretization
  parameter Integer nV(min=1)=2 "Number of discrete volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

  // Inputs provided to the volume model
  input SI.Volume[nV] fluidVolumes(min=0)
    "Discretized volume, determined in inheriting class";
//   input SI.Density[nV] rhos
//     "Discretized density, determined in inheriting class";

  // Assumptions
  parameter Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  parameter Dynamics massDynamics=system.massDynamics
    "Formulation of mass balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Dynamics substanceDynamics=massDynamics
    "Formulation of substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));
  final parameter Dynamics traceDynamics=massDynamics
    "Formulation of trace substance balances"
    annotation(Evaluate=true, Dialog(tab = "Assumptions", group="Dynamics"));

  //Initialization
  parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Pressure at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Pressure at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure[nV] ps_start=
    if nV > 1 then
      linspace(p_a_start,p_b_start,nV) else {(p_a_start + p_b_start)/2}
    "Pressures {port_a,...,port_b}"
    annotation(Dialog(tab = "Initialization",group="Start Value: Absolute Pressure"));

  parameter Boolean use_Ts_start=true "Use T_start if true, otherwise h_start"
     annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Temperature"));

  parameter Medium.Temperature T_a_start=system.T_start
      "Temperature at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature T_b_start=T_a_start
      "Temperature at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature[nV] Ts_start=
    if use_Ts_start then
      if nV > 1 then
         linspace(T_a_start,T_b_start,nV)
      else
        {(T_a_start+T_b_start)/2}
    else
      {Medium.temperature_phX(
        ps_start[i],
        hs_start[i],
        Xs_start) for i in 1:nV} "Temperatures {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Temperature", enable = use_Ts_start));

  parameter Medium.SpecificEnthalpy h_a_start=Medium.specificEnthalpy_pTX(p_a_start,T_a_start,Xs_start)
      "Specific enthalpy at port a"
    annotation(Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy h_b_start=Medium.specificEnthalpy_pTX(p_b_start,T_b_start,Xs_start)
      "Specific enthalpy at port b"
    annotation(Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy[nV] hs_start=
    if use_Ts_start then
      {Medium.specificEnthalpy_pTX(
        ps_start[i],
        Ts_start[i],
        Xs_start) for i in 1:nV}
    else
      if nV > 1 then
        linspace(h_a_start,h_b_start,nV)
      else
        {(h_a_start+h_b_start)/2}
    "Specific enthalpies {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));

  parameter Medium.MassFraction Xs_start[Medium.nX]=Medium.X_default
    "Mass fractions m_i/m"
    annotation (Dialog(tab="Initialization",group="Start Value: Mass Fractions", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty Cs_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Trace substances"
    annotation (Dialog(tab="Initialization",group="Start Value: Trace Substances", enable=Medium.nC > 0));

  // Total quantities
  SI.Energy[nV] Us "Internal energy of fluid";
  SI.Mass[nV] ms "Fluid mass";
  SI.Mass[nV,Medium.nXi] mXis "Substance mass";
  SI.Mass[nV,Medium.nC] mCs "Trace substance mass";

  // C has the additional parameter because it is not included in the medium
  // i.e.,Xi has medium[:].Xi but there is no variable medium[:].C
  SI.Mass[nV,Medium.nC] mCs_scaled "Scaled trace substance mass";
  Medium.ExtraProperty Cs[nV, Medium.nC] "Trace substance mixture content";

  Medium.BaseProperties[nV] mediums(
    each preferredMediumStates=true,
    p(start=ps_start),
    h(start=hs_start),
    T(start=Ts_start),
    each Xi(start=Xs_start[1:Medium.nXi]));

  //Source terms, have to be defined by an extending model (to zero if not used)
  Medium.MassFlowRate[nV] mb_flows "Mass flow rate, source or sink";
  Medium.MassFlowRate[nV,Medium.nXi] mbXi_flows
    "Independent mass flow rates, source or sink";
  Medium.ExtraPropertyFlowRate[nV,Medium.nC] mbC_flows
    "Trace substance mass flow rates, source or sink";
  SI.EnthalpyFlowRate[nV] Hb_flows "Enthalpy flow rate, source or sink";
  SI.HeatFlowRate[nV] Qb_flows "Heat flow rate, source or sink";
  SI.Power[nV] Wb_flows "Mechanical power, p*der(V) etc.";

protected
  parameter Boolean initialize_p = not Medium.singleState
    "= true to set up initial equations for pressure";

equation
  assert(not (energyDynamics<>Dynamics.SteadyState and massDynamics==Dynamics.SteadyState) or Medium.singleState,
         "Bad combination of dynamics options and Medium not conserving mass if fluidVolumes are fixed.");

  // Total quantities
  for i in 1:nV loop
    ms[i] =fluidVolumes[i]*mediums[i].d;
    mXis[i, :] = ms[i]*mediums[i].Xi;
    mCs[i, :]  = ms[i]*Cs[i, :];
    Us[i] = ms[i]*mediums[i].u;
  end for;

  // Energy and mass balances
  if energyDynamics == Dynamics.SteadyState then
    for i in 1:nV loop
      0 = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
    end for;
  else
    for i in 1:nV loop
      der(Us[i]) = Hb_flows[i] + Wb_flows[i] + Qb_flows[i];
    end for;
  end if;
  if massDynamics == Dynamics.SteadyState then
    for i in 1:nV loop
      0 = mb_flows[i];
    end for;
  else
    for i in 1:nV loop
      der(ms[i]) = mb_flows[i];
    end for;
  end if;
  if substanceDynamics == Dynamics.SteadyState then
    for i in 1:nV loop
      zeros(Medium.nXi) = mbXi_flows[i, :];
    end for;
  else
    for i in 1:nV loop
      der(mXis[i, :]) = mbXi_flows[i, :];
    end for;
  end if;
  if traceDynamics == Dynamics.SteadyState then
    for i in 1:nV loop
      zeros(Medium.nC)  = mbC_flows[i, :];
    end for;
  else
    for i in 1:nV loop
      der(mCs_scaled[i, :])  = mbC_flows[i, :]./Medium.C_nominal;
      mCs[i, :] = mCs_scaled[i, :].*Medium.C_nominal;
    end for;
  end if;

initial equation
  // initialization of balances
  if energyDynamics == Dynamics.FixedInitial then
    /*
    if use_T_start then
      mediums.T = Ts_start;
    else
      mediums.h = hs_start;
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or
       Medium.ThermoStates == IndependentVariables.phX then
       mediums.h = hs_start;
    else
       mediums.T = Ts_start;
    end if;

  elseif energyDynamics == Dynamics.SteadyStateInitial then
    /*
    if use_T_start then
      der(mediums.T) = zeros(nV);
    else
      der(mediums.h) = zeros(nV);
    end if;
    */
    if Medium.ThermoStates == IndependentVariables.ph or
       Medium.ThermoStates == IndependentVariables.phX then
       der(mediums.h) = zeros(nV);
    else
       der(mediums.T) = zeros(nV);
    end if;
  end if;

  if massDynamics == Dynamics.FixedInitial then
    if initialize_p then
      mediums.p = ps_start;
    end if;
  elseif massDynamics == Dynamics.SteadyStateInitial then
    if initialize_p then
      der(mediums.p) = zeros(nV);
    end if;
  end if;

  if substanceDynamics == Dynamics.FixedInitial then
    mediums.Xi = fill(Xs_start[1:Medium.nXi], nV);
  elseif substanceDynamics == Dynamics.SteadyStateInitial then
    for i in 1:nV loop
      der(mediums[i].Xi) = zeros(Medium.nXi);
    end for;
  end if;

  if traceDynamics == Dynamics.FixedInitial then
    Cs = fill(Cs_start[1:Medium.nC], nV);
  elseif traceDynamics == Dynamics.SteadyStateInitial then
    for i in 1:nV loop
      der(mCs[i,:])      = zeros(Medium.nC);
    end for;
  end if;

   annotation (      Documentation(info="<html>
<p>IMPORTANT:</p>
<p>-  Xis and Cis still need to be expanded to the more general initialization to remove assumptions of uniforminity between volumes</p>
<p>- We have concerns about how internal energy is used/calculated because the media library calculates a two-phase density based on a homogeneous non-slip assumption</p>
<p><br>Interface and base class for <code><b><span style=\"font-family: Courier New,courier;\">nV</span></b></code> ideally mixed fluid volumes with the ability to store mass and energy. It is intended to model a one-dimensional spatial discretization of fluid flow according to the finite volume method. </p>
<p><br>The following boundary flow and source terms are part of the energy balance and must be specified in an extending class: </p>
<ul>
<li><code><b><span style=\"font-family: Courier New,courier;\">Qb_flows[nV]</span></b></code>, heat flow term, e.g., conductive heat flows across segment boundaries, and</li>
<li><code><b><span style=\"font-family: Courier New,courier;\">Wb_flows[nV]</span></b></code>, work term.</li>
</ul>
<p>The following inputs need to be set in an extending class to complete the model: </p>
<ul>
<li><code><b><span style=\"font-family: Courier New,courier;\">fluidVolumes[nV]</b></code></span><span style=\"font-family: MS Shell Dlg 2;\">, component volumes</span></li>
<li><code><b><span style=\"font-family: Courier New,courier;\">mb_flows[nV]</b></code></span><span style=\"font-family: MS Shell Dlg 2;\">, component density</span></li>
</ul>
<p>Further source terms must be defined by an extending class for fluid flow across the segment boundary: </p>
<ul>
<li><code><b><span style=\"font-family: Courier New,courier;\">Hb_flows[nV]</span></b></code>, enthalpy flow,</li>
<li><code><b><span style=\"font-family: Courier New,courier;\">mb_flows[nV]</span></b></code>, mass flow,</li>
<li><code><b><span style=\"font-family: Courier New,courier;\">mbXi_flows[nV]</span></b></code>, substance mass flow, and</li>
<li><code><b><span style=\"font-family: Courier New,courier;\">mbC_flows[nV]</span></b></code>, trace substance mass flow.</li>
</ul>
</html>"));
end PartialDistributedVolume;
