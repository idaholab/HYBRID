within NHES.Systems.BalanceOfPlant.sCO2_BraytonCycle;
model SubSystem_Dummy

  extends EnergyStorage.CompressedAirEnergyStorage.BaseClasses.Partial_SubSystem_A(
    redeclare replaceable EnergyStorage.CompressedAirEnergyStorage.CS_Dummy CS,
    redeclare replaceable EnergyStorage.CompressedAirEnergyStorage.ED_Dummy ED);
    //redeclare EnergyStorage.CompressedAirEnergyStorage.Data.Data_Dummy data);

equation

  annotation (
    defaultComponentName="changeMe",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="sCO2 Power Cycle")}));
end SubSystem_Dummy;
