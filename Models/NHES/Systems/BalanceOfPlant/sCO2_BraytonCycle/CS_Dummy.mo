within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle;
model CS_Dummy

  extends EnergyStorage.CompressedAirEnergyStorage.BaseClasses.Partial_ControlSystem;

equation

annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Dummy;
