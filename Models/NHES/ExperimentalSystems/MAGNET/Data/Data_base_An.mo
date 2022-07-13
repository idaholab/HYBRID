within NHES.ExperimentalSystems.MAGNET.Data;
model Data_base_An
  extends TRANSFORM.Icons.Data;

  /*
  source 1:
  Functional and Operating Requirements for the Microreactor Agile Non-Nuclear Experimental Test Bed (MAGNET)
  Document ID: FOR-523
  Revision ID: 0
  Date: 05/20/22
  
  VC - vacuum (or environmental) chamber
  RP - recuperator
  HX - Rejection heat exchanger to chilled water
  CO - compressor
  PS - pressurization system
  CW - chilled water
  
  dp - outlet - inlet
  dT - outlet - inlet 
  
  */

// General
package Medium = Modelica.Media.IdealGases.SingleGases.N2;//TRANSFORM.Media.ExternalMedia.CoolProp.Nitrogen;
package Medium_cw = Modelica.Media.Water.StandardWater;
package Medium_TEDS =
      TRANSFORM.Media.Fluids.Therminol_66.LinearTherminol66_A_250C;

parameter SI.Length d_outer_4in = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(4.5);
parameter SI.Length th_4in_sch40 = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.237);
parameter SI.Length d_inner_4in = d_outer_4in - 2*th_4in_sch40;

parameter SI.Length d_outer_3in = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(3.5);
parameter SI.Length th_3in_sch40 = TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.216);
parameter SI.Length d_inner_3in = d_outer_3in - 2*th_3in_sch40;

parameter SI.Pressure p_atm = 1e5;

parameter SI.MassFlowRate m_flow = 0.938;
parameter SI.MassFlowRate m_flow_SCFM = TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_ft3_min(1706); // ain't the same as m_flow...

parameter SI.Length length_dummy = 1.0 "place holder, should be deleted";

// Piping: Recuperator to Vacuum Chamber (rp_vc)
parameter SI.Length d_rp_vc = d_inner_4in;
parameter SI.Length length_rp_vc = TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(18);//length_dummy;
parameter SI.Pressure p_rp_vc = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
parameter SI.Temperature T_rp_vc = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(363);

// Vacuum chamber (vc)
parameter SI.Power Q_vc = 250e3;
//parameter SI.Volume V_vc = TRANSFORM.Units.Conversions.Functions.Volume_m3.from_ft3(5*5*10); // taken from pg.6 of Environmental Chamber Relief Capacity Evaluation
parameter SI.PressureDifference dp_vc = p_vc_rp - p_rp_vc;
parameter SI.TemperatureDifference dT_vc = T_vc_rp - T_rp_vc;

// Piping: Vacuum Chamber to Recuperator (vc_rp)
parameter SI.Length d_vc_rp = d_inner_4in;
parameter SI.Length length_vc_rp = TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(18);//length_dummy;
parameter SI.Pressure p_vc_rp = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.4) + p_atm;
parameter SI.Temperature T_vc_rp = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);

// Recuperator (rp)
parameter SI.Power Q_flow_rp = m_flow*(Medium.specificEnthalpy_pT(p_vc_rp,T_vc_rp) - Medium.specificEnthalpy_pT(p_rp_hx,T_rp_hx));
parameter SI.PressureDifference dp_rp_hot = p_rp_hx - p_vc_rp;
parameter SI.TemperatureDifference dT_rp_hot = T_rp_hx - T_vc_rp;
parameter SI.Pressure dp_rp_cold = p_rp_vc - p_co_rp;
parameter SI.TemperatureDifference dT_rp_cold = T_rp_vc - T_co_rp;
parameter SI.ThermalConductance UA_rp = 47.599945;//47.874603; // Calculated from PID

// Piping: Recuperator to Rejection Heat Exchanger (rp_hx)
parameter SI.Length d_rp_hx = d_inner_3in;
parameter SI.Length length_rp_hx = TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(6+3);//length_dummy;
parameter SI.Pressure p_rp_hx = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.1) + p_atm;
parameter SI.Temperature T_rp_hx = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(284);

// Rejection Heat Exchanger to Chilled Water (hx)
parameter SI.Power Q_flow_hx = m_flow*(Medium.specificEnthalpy_pT(p_rp_hx,T_rp_hx) - Medium.specificEnthalpy_pT(p_hx_co,T_hx_co));
parameter SI.PressureDifference dp_hx_hot = p_hx_co - p_rp_hx;
parameter SI.TemperatureDifference dT_hx_hot = T_hx_co - T_rp_hx;
parameter SI.TemperatureDifference dT_hx_cold = 50; //guess
parameter SI.MassFlowRate m_flow_cw = Q_flow_hx/(Medium_cw.specificEnthalpy_pT(p_hx_cw,T_hx_cw) - Medium_cw.specificEnthalpy_pT(p_cw_hx,T_cw_hx)); //guess
parameter SI.ThermalConductance UA_hx = 380.68774;//698.87; // Calculated from PID

// Piping: Chilled Water to Rejection Heat Exchanger (cw_hx)
// parameter SI.Length d_cw_hx = d_inner_4in; //guess
// parameter SI.Length length_cw_hx = length_dummy; //guess
parameter SI.Pressure p_cw_hx = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(1) + p_atm; //guess
parameter SI.Temperature T_cw_hx = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF(65);

// Piping: Rejection Heat Exchanger to Chilled Water (hx_cw)
// parameter SI.Length d_hx_cw = d_inner_4in; //guess
// parameter SI.Length length_hx_cw = length_dummy; //guess
parameter SI.Pressure p_hx_cw = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(1) + p_atm; //guess
parameter SI.Temperature T_hx_cw = T_cw_hx + dT_hx_cold; //guess

// Piping: Rejection Heat Exchanger to Compressor (hx_co)
parameter SI.Length d_hx_co = d_inner_3in;
parameter SI.Length length_hx_co = TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(84);//length_dummy;
parameter SI.Pressure p_hx_co = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(10.8) + p_atm;
parameter SI.Temperature T_hx_co = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(20);

// Compressor (co)
parameter SI.Power Q_flow_co = m_flow*(Medium.specificEnthalpy_pT(p_co_rp,T_co_rp) - Medium.specificEnthalpy_pT(p_hx_co,T_hx_co));
parameter SI.PressureDifference dp_co = p_co_rp - p_hx_co;
parameter SI.TemperatureDifference dT_co = T_co_rp - T_hx_co;

// Piping: Compressor to Recuperator (co_rp)
parameter SI.Length d_co_rp = d_inner_3in;
parameter SI.Length length_co_rp = TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(114.625);//length_dummy;
parameter SI.Pressure p_co_rp = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(12) + p_atm;
parameter SI.Temperature T_co_rp = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(37.8);

// Pressurization System (ps)
parameter SI.Pressure p_ps = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(22) + p_atm;
parameter SI.Temperature T_ps = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(20); // this is a guess as not specified. Could be calculated from thermodynamic estimates.

// TEDS
parameter SI.Temperature T_hot_side = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(325);
parameter SI.Temperature T_cold_side = TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(225);

// MAGNET_TEDS_HX
parameter SI.MassFlowRate m_flow_TEDS = 0.689;
parameter SI.Pressure p_TEDS_out = TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(0.18);
parameter SI.Pressure p_TEDS_in = p_TEDS_out +100;
parameter SI.Power Q_MAGNET_TEDS = m_flow_TEDS*(Medium_TEDS.specificEnthalpy_pT(p_TEDS_out, T_hot_side) - Medium_TEDS.specificEnthalpy_pT(p_TEDS_in,T_cold_side));
  annotation (defaultComponentName="data",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><img src=\"modelica://TRANSFORM_Examples/Resources/Images/magnetSystemBasic.png\"/></p>
</html>"));
end Data_base_An;
