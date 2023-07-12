within NHES.ExperimentalSystems.TEDS_New.Examples;
model Executable_example
  Components.TEDSloop_allmodes_test_DMM tEDSloop_allmodes_test_DMM(redeclare
      NHES.ExperimentalSystems.TEDS_New.CS.Control_System_Therminol_4_element_all_modes_DMM
      CS) annotation (Placement(transformation(extent={{-44,-70},{68,38}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Executable_example;
