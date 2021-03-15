within NHES.Systems.Examples.BaseClasses;
partial model PartialExample_A

  extends Modelica.Icons.Example;

  replaceable NHES.Systems.PrimaryHeatSystem.BaseClasses.SubSystem_PlaceHolder
    PHS constrainedby
    NHES.Systems.PrimaryHeatSystem.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-198,82},{-142,138}})));
  replaceable NHES.Systems.EnergyManifold.BaseClasses.SubSystem_PlaceHolder EM
    constrainedby NHES.Systems.EnergyManifold.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-118,82},{-62,138}})));
  replaceable NHES.Systems.BalanceOfPlant.BaseClasses.SubSystem_PlaceHolder BOP
    constrainedby NHES.Systems.BalanceOfPlant.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-18,82},{38,138}})));
  replaceable NHES.Systems.IndustrialProcess.BaseClasses.SubSystem_PlaceHolder
    IP constrainedby
    NHES.Systems.IndustrialProcess.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-118,-38},{-62,18}})));
  replaceable NHES.Systems.EnergyStorage.BaseClasses.SubSystem_PlaceHolder ES
    constrainedby NHES.Systems.EnergyStorage.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-18,2},{38,58}})));
  replaceable
    NHES.Systems.SecondaryEnergySupply.BaseClasses.SubSystem_PlaceHolder SES
    constrainedby
    NHES.Systems.SecondaryEnergySupply.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{-18,-78},{38,-22}})));
  replaceable NHES.Systems.SwitchYard.BaseClasses.SubSystem_PlaceHolder SY
    constrainedby NHES.Systems.SwitchYard.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{82,2},{138,58}})));
  replaceable NHES.Systems.ElectricalGrid.BaseClasses.SubSystem_PlaceHolder EG
    constrainedby NHES.Systems.ElectricalGrid.BaseClasses.Partial_SubSystem
    annotation (Placement(transformation(extent={{162,2},{218,58}})));
  replaceable NHES.Systems.SupervisoryControl.BaseClasses.Partial_ControlSystem
    SC annotation (Placement(transformation(extent={{122,102},{178,158}})));
equation

  annotation (Diagram(coordinateSystem(extent={{-220,-100},{240,180}},
          preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-100,-100},
            {100,100}})));
end PartialExample_A;
