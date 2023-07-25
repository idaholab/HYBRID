within NHES.Systems.BalanceOfPlant.RankineCycle.Data;
record DataInitial_HTGR_BoP_3stage

  extends TRANSFORM.Icons.Record;

  // HPT Boundary conditions
parameter SI.Pressure HPT_P_inlet =     4.1384e6 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
parameter SI.Pressure HPT_P_outlet =    4.0723e5 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
parameter SI.Temperature HPT_T_inlet =  540.13 + 273.15 annotation (Evaluate=true, Dialog(group="HPT_conditions"));
parameter SI.Temperature HPT_T_outlet = 253.77 + 273.15 annotation (Evaluate=true, Dialog(group="HPT_conditions"));

  // LPT1 Boundary conditions
parameter SI.Pressure LPT1_P_inlet =     4.0562e5 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
parameter SI.Pressure LPT1_P_outlet =    2.0920e5 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
parameter SI.Temperature LPT1_T_inlet =  253.77 + 273.15 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));
parameter SI.Temperature LPT1_T_outlet = 121.64 + 273.15 annotation (Evaluate=true, Dialog(group="LPT1_conditions"));

  // LPT2 Boundary conditions
parameter SI.Pressure LPT2_P_inlet =     2.0920e5 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
parameter SI.Pressure LPT2_P_outlet =    0.0080e5 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
parameter SI.Temperature LPT2_T_inlet =  121.64 + 273.15 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));
parameter SI.Temperature LPT2_T_outlet =  41.52 + 273.15 annotation (Evaluate=true, Dialog(group="LPT2_conditions"));

  // Circulation Pump Boundary conditions
  parameter SI.Pressure cirPump_P_nomi =     5.5e6 annotation (Evaluate=true, Dialog(group="CirculationPump_conditions"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="BOP_3stage")}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DataInitial_HTGR_BoP_3stage;
