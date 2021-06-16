within NHES.Media.TwoPhaseMixtures.LithiumBromideWater;
package LithiumBromideWater_pTX
    extends LithiumBromideWater_base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX,
      reducedX=false,
      fixedX=false,
      final pTX_explicit=true,
      final phX_explicit=false,
      final dTX_explicit=false,
      reference_X={0.6,0.4});

end LithiumBromideWater_pTX;
