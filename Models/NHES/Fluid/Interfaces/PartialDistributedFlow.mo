within NHES.Fluid.Interfaces;
partial model PartialDistributedFlow
  "Base class for a distributed momentum balance"

  outer Modelica.Fluid.System system "System properties";

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component";

  parameter Boolean allowFlowReversal = system.allowFlowReversal
"= true to allow flow reversal, false restricts to design direction (m_flows >= zeros(m))"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  // Discretization
  parameter Integer nFM=1 "Number of flow segments";

  // Inputs provided to the flow model
  input SI.Length[nFM] lengthsFM "Lengths along flow path";

  // Variables defined by momentum model
  Medium.MassFlowRate[nFM] m_flows(
     each min=if allowFlowReversal then -Modelica.Constants.inf else 0,
     start = m_flows_start,
     each stateSelect = if momentumDynamics ==Modelica.Fluid.Types.Dynamics.SteadyState
                                                                          then StateSelect.default else
                               StateSelect.prefer)
"mass flow rates between states";

  // Parameters
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
"Formulation of momentum balance"
    annotation(Dialog(tab="Assumptions", group="Dynamics"), Evaluate=true);

  parameter Medium.MassFlowRate[nFM] m_flows_start
    "Start value of mass flow rates"
    annotation(Dialog(tab="Initialization"));
//   parameter Medium.AbsolutePressure[nFM+1] ps_start
//     "Start value of pressure {a,...,b}"
//     annotation(Dialog(tab = "Initialization"));
  parameter SI.PressureDifference[nFM] dps_fg_start
    "Start value of pressure {a,...,b}"
    annotation(Dialog(tab = "Initialization"));

  // Total quantities
  SI.Momentum[nFM] Is "Momenta of flow segments";

  // Source terms and forces to be defined by an extending model (zero if not used)
  SI.Force[nFM] Ib_flows "Flow of momentum across boundaries";
  SI.Force[nFM] Fs_p "Pressure forces";
  SI.Force[nFM] Fs_fg "Friction and gravity forces";

equation
  // Total quantities
  Is = {m_flows[i]*lengthsFM[i] for i in 1:nFM};

  // Momentum balances
  if momentumDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
    zeros(nFM) = Ib_flows - Fs_p - Fs_fg;
  else
    der(Is) = Ib_flows - Fs_p - Fs_fg;
  end if;

initial equation
  if momentumDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
    m_flows = m_flows_start;
  elseif momentumDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
    der(m_flows) = zeros(nFM);
  end if;

  annotation (
     Documentation(info="<html>
<p>
Interface and base class for <code><b>nFM</b></code> momentum balances, defining the mass flow rates <code><b>m_flows[nFM]</b></code>
of a given <code>Medium</code> in <code><b>nFM</b></code> flow segments.
</p>
<p>
The following boundary flow and force terms are part of the momentum balances and must be specified in an extending model (to zero if not considered):
</p>
<ul>
<li><code><b>Ib_flows[nFM]</b></code>, the flows of momentum across segment boundaries,</li>
<li><code><b>Fs_p[nFM]</b></code>, pressure forces, and</li>
<li><code><b>Fs_fg[nFM]</b></code>, friction and gravity forces.</li>
</ul>
<p>
The lengths along the flow path <code><b>lengthsFM[nFM]</b></code> are an input that needs to be set in an extending class to complete the model.
</p>
</html>"));
end PartialDistributedFlow;
