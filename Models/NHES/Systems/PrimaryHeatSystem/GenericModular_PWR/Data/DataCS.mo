within NHES.Systems.PrimaryHeatSystem.GenericModular_PWR.Data;
record DataCS
  //Allows for control systems to have parameters set, data is reduced set from Data_GenericModule
  extends TRANSFORM.Icons.Record;

//core.coolantSubchannel
  parameter Real nModules=12;

  //per module
  parameter SI.Power Q_total=160e6 "Total thermal output";
  parameter SI.Power Q_total_el=45e6 "Total electrical output";
  parameter Real eta=Q_total_el/Q_total "Net efficiency";

  parameter SI.Pressure p=12.76e6;
  parameter SI.Temperature T_hot=325 + 273.15 "estimate";
  parameter SI.Temperature T_cold=Medium.temperature_ph(p, h_cold);
  parameter SI.Temperature T_avg=0.5*(T_hot+T_cold);
  parameter SI.TemperatureDifference dT_core=T_hot - T_cold;
  parameter SI.SpecificEnthalpy h_hot=Medium.specificEnthalpy_pT(p, T_hot);
  parameter SI.SpecificEnthalpy h_cold=h_hot - Q_total/m_flow;
  parameter SI.MassFlowRate m_flow=700 "rough estimate from normalizing IRIS and rounded down";

  parameter SI.Pressure p_steam = 3.5e6;
  parameter SI.Temperature T_steam_hot = 300+273.15;
  parameter SI.Temperature T_steam_cold=200+273.15;
  parameter SI.SpecificEnthalpy h_steam_hot=Medium.specificEnthalpy_pT(p_steam, T_steam_hot);
  parameter SI.SpecificEnthalpy h_steam_cold=Medium.specificEnthalpy_pT(p_steam, T_steam_cold);
  parameter SI.MassFlowRate m_flow_steam = Q_total/(h_steam_hot-h_steam_cold);


  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="GenericModule")}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DataCS;
