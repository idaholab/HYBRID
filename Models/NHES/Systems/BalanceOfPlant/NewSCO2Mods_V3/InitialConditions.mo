within NHES.Systems.BalanceOfPlant.NewSCO2Mods_V3;
record InitialConditions

  extends TRANSFORM.Icons.Record;

//Turbine
parameter SI.Pressure Turbine_P_ref = 84.51e5;
parameter SI.Temperature Turbine_TStart_In = 750+273.15;
parameter SI.Temperature Turbine_TStart_Out = 635.2+273.15;

//Compressors
parameter SI.Pressure Comp1_P_ref = 84.11e5;
parameter SI.Temperature Comp1_TStart_In = 99.1+273.15;
parameter SI.Temperature Comp1_TStart_Out = 185+273.15;

parameter SI.Pressure Comp2_P_ref = 84.11e5;
parameter SI.Temperature Comp2_TStart_In = 36+273.15;
parameter SI.Temperature Comp2_TStart_Out = 68+273.15;

//High Temperature Recuperator
parameter SI.Pressure HTR_PStart_Tube = 84.51e5;
parameter SI.SpecificEnthalpy HTR_HStart_Tube_In = 1147600;
parameter SI.SpecificEnthalpy HTR_HStart_Tube_Out = 643750;
parameter SI.MassFlowRate HTR_MassFlowStart_Tube = 2867;
parameter SI.Pressure HTR_dp_Tube = 0.2e5;

parameter SI.Pressure HTR_PStart_Shell = 84.51e5;
parameter SI.SpecificEnthalpy HTR_HStart_Shell_In = 576280;
parameter SI.SpecificEnthalpy HTR_HStart_Shell_Out = 1077200;
parameter SI.MassFlowRate HTR_MassFlowStart_Shell = 2867;
parameter SI.Pressure HTR_dp_Shell = 0.2e5;

//Low Temperature Recuperator
parameter SI.Pressure LTR_PStart_Tube = 201.3e5;
parameter SI.SpecificEnthalpy LTR_HStart_Tube_In = 361690;
parameter SI.SpecificEnthalpy LTR_HStart_Tube_Out = 576280;
parameter SI.MassFlowRate LTR_MassFlowStart_Tube = 1783;
parameter SI.Pressure LTR_dp_Tube = 0.2e5;

parameter SI.Pressure LTR_PStart_Shell = 84.31e5;
parameter SI.SpecificEnthalpy LTR_HStart_Shell_In = 643750;
parameter SI.SpecificEnthalpy LTR_HStart_Shell_Out = 515350;
parameter SI.MassFlowRate LTR_MassFlowStart_Shell = 2867;
parameter SI.Pressure LTR_dp_Shell = 0.2e5;

//Heat Exchanger Heat Capacity Ratios
parameter Real CR_init_HTR = 0.8506; //HTR Heat capacity ratio
parameter Real CR_init_LTR = 0.7114; //LTR Heat capacity ratio

//Cooler
parameter SI.Pressure Cooler_PStart = 84.11e5;
parameter SI.Temperature Cooler_TStart = 36+273.15;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="SCO2")}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InitialConditions;
