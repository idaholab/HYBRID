within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine;
model TeeJunctionIdeal_Cyl
  "Splitting/joining component with static balances for an infinitesimal control volume. Effectively the opposite of a Turbine_Tap, but uses 3 Fluid Flow ports."
  extends
    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.PartialTeeJunction_Cyl;

equation
  connect(port_1, port_2) annotation (Line(
      points={{-100,0},{100,0}}, color={0,127,255}));
  connect(port_1, port_3) annotation (Line(
      points={{-100,0},{0,0},{0,100}}, color={0,127,255}));
  annotation(Documentation(info="<html>
  This model is the simplest implementation for a splitting/joining component for
  three flows. Its use is not required. It just formulates the balance
  equations in the same way that the connect semantics would formulate them anyways.
  The main advantage of using this component is, that the user does not get
  confused when looking at the specific enthalpy at each port which might be confusing
  when not using a splitting/joining component. The reason for the confusion is that one examines the mixing
  enthalpy of the infinitesimal control volume introduced with the connect statement when
  looking at the specific enthalpy in the connector which
  might not be equal to the specific enthalpy at the port in the \"real world\".</html>"));
end TeeJunctionIdeal_Cyl;
