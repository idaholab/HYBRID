within NHES.Media.TwoPhaseMixtures.LithiumBromideWater;
package LithiumBromideWater_phX
    extends LithiumBromideWater_base(
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.phX,
      reducedX=false,
      fixedX=false,
      final pTX_explicit=false,
      final phX_explicit=true,
      final dTX_explicit=false,
      reference_X={0.6,0.4});

end LithiumBromideWater_phX;
