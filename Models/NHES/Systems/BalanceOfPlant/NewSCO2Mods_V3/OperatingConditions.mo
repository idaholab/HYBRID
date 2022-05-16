within NHES.Systems.BalanceOfPlant.NewSCO2Mods_V3;
record OperatingConditions

  extends TRANSFORM.Icons.Record;

parameter Real Turbine_Efficiency = 0.9;
parameter Real Turbine_PressureRatio = 2.318;
parameter SI.MassFlowRate Turbine_NominalMassFlowRate = 2865;

parameter Real Comp1_Efficiency = 0.9;
parameter Real Comp1_PressureRatio = 2.39;
parameter SI.MassFlowRate Comp1_NominalMassFlowRate = 1084;

parameter Real Comp2_Efficiency = 0.9;
parameter Real Comp2_PressureRatio = 2.39;
parameter SI.MassFlowRate Comp2_NominalMassFlowRate = 1783;

//High Temperature Recuperator
parameter Real HTR_NTU = 10.6;
parameter Real HTR_volume_tube = 1;
parameter Real HTR_volume_shell = 1;
parameter Real HTR_K_tube( unit = "1/m4") = 1;
parameter Real HTR_K_shell( unit = "1/m4") = 1;

//Low Temperature Recuperator
parameter Real LTR_NTU = 4.255;
parameter Real LTR_volume_tube = 1;
parameter Real LTR_volume_shell = 1;
parameter Real LTR_K_tube( unit = "1/m4") = 1;
parameter Real LTR_K_shell( unit = "1/m4") = 1;

//Resistances
parameter Real FlowResistance1 = 0.378250591016547;
parameter Real FlowResistance2 = 1 - 0.378250591016547;

//Cooler
parameter SI.HeatFlowRate Cooler_HeatOut = -305e6;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="SCO2")}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OperatingConditions;
