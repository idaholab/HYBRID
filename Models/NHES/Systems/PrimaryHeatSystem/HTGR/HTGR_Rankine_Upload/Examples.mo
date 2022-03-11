within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine_Upload;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model Rankine_HTGR_Test
    extends Modelica.Icons.Example;
    Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop
      annotation (Placement(transformation(extent={{-92,-18},{-34,40}})));
    Components.HTGR_Rankine_Cycle hTGR_Rankine_Cycle
      annotation (Placement(transformation(extent={{4,-16},{66,44}})));
  equation
    connect(hTGR_Rankine_Cycle.port_b, hTGR_PebbleBed_Primary_Loop.port_a)
      annotation (Line(points={{4.62,0.8},{4.62,1.43},{-34.87,1.43}}, color={0,
            127,255}));
    connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
      annotation (Line(points={{-34.87,25.21},{4.62,25.4}}, color={0,127,255}));
  end Rankine_HTGR_Test;
end Examples;
