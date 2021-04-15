within NHES.HydrogenTurbine.CombustionChamber;
model CombustionChamber "Combustion chamber"
  extends HydrogenTurbine.CombustionChamber.BaseClasses.CombustionChamberBase(
    redeclare package Air = Media.Air "O2, H2O, Ar, N2",
    redeclare package Fuel = Media.Hydrogen "N2, CO2, H2",
    redeclare package Exhaust = Media.FlueGas "O2, Ar, H2O, CO2, N2");

  parameter Real eta0_comb = 0.99 "Constant combustion efficiency";

  Real wcomb(final quantity="MolarFlowRate", unit="mol/s")
    "Molar Combustion rate (H2)";
  Real wo2(final quantity="MolarFlowRate", unit="mol/s")
    "Molar flow rate rate (O2)";
  Real lambda
    "Stoichiometric ratio (>1 if air flow is greater than stoichiometric)";

protected
  Real ina_X[Air.nXi]=inStream(ina.Xi_outflow);
  Real inf_X[Fuel.nXi]=inStream(inf.Xi_outflow);

equation
  eta_comb = eta0_comb;

  wcomb = wf*inf_X[3]/Fuel.data[3].MM "Combustion molar flow rate";
  wo2 = (ina.m_flow*ina_X[1]/Air.data[1].MM);
  lambda = (ina.m_flow*ina_X[1]/Air.data[1].MM)/(0.5*wcomb);
  assert(lambda >= 1, "Not enough oxygen flow");


  //Combustion Stoichiometry ... Beautiful ...
  der(MX[1]) = ina.m_flow*ina_X[1] + out.m_flow*fluegas.X[1] - 0.5*wcomb*
    Exhaust.data[1].MM "O2";
  der(MX[2]) = ina.m_flow*ina_X[3] + out.m_flow*fluegas.X[2] "Ar";
  der(MX[3]) = ina.m_flow*ina_X[2] + out.m_flow*fluegas.X[3] + 1*wcomb*
    Exhaust.data[3].MM "H2O";
  der(MX[4]) = wf*inf_X[2] + out.m_flow*fluegas.X[4] "CO2";
  der(MX[5]) = ina.m_flow*ina_X[4] + out.m_flow*fluegas.X[5] + wf*
    inf_X[1] "N2";

  annotation (Icon(graphics), Documentation(info="<html>
<p>This model extends the CombustionChamber Base model, with the definition of the gases. </p>
<p>In particular, the air inlet uses the <span style=\"font-family: Courier New;\">Media.Air</span> medium model, the fuel input uses the <span style=\"font-family: Courier New;\">Media.Hydrogen</span> medium model, and the flue gas outlet uses the <span style=\"font-family: Courier New;\">Medium.FlueGas</span> medium model. </p>
<p>The composition of the outgoing gas is determined by the mass balance of every component, taking into account the combustion reaction H2 + 0.5O2---&gt;H2O</p>
<p>The model assumes complete combustion, so that it is only valid if the oxygen flow at the air inlet is greater than the stoichiometric flow corresponding to the flow at the fuel inlet.</p>
</html>"));
end CombustionChamber;
