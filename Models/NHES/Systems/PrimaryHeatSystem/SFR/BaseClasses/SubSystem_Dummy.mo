within NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses;
model SubSystem_Dummy

  extends BaseClasses.Partial_SubSystem_A(redeclare replaceable
      NHES.Systems.PrimaryHeatSystem.SFR.CS.CS_Dummy CS, redeclare
      Data.Data_Dummy data);

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
          textString="Change Me")}));
end SubSystem_Dummy;
