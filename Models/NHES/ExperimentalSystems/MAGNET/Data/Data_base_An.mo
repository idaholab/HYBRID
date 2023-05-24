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

parameter Modelica.Units.SI.Pressure P_Release=p_vc_rp/2.975
    "Boundary release valve pressure downstream of precooler"
    annotation (dialog(group="System Boundary Conditions"));

parameter Modelica.Units.SI.Length d_outer_4in=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(4.5);
parameter Modelica.Units.SI.Length th_4in_sch40=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.237);
parameter Modelica.Units.SI.Length d_inner_4in=d_outer_4in - 2*th_4in_sch40;

parameter Modelica.Units.SI.Length d_outer_3in=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(3.5);
parameter Modelica.Units.SI.Length th_3in_sch40=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_in(0.216);
parameter Modelica.Units.SI.Length d_inner_3in=d_outer_3in - 2*th_3in_sch40;

parameter Modelica.Units.SI.Pressure p_atm=1e5;

parameter Modelica.Units.SI.MassFlowRate m_flow=0.938;
parameter Modelica.Units.SI.MassFlowRate m_flow_SCFM=
      TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_ft3_min(
      1706);                                                                                                          // ain't the same as m_flow...

parameter Modelica.Units.SI.Length length_dummy=1.0
    "place holder, should be deleted";

// Piping: Recuperator to Vacuum Chamber (rp_vc)
parameter Modelica.Units.SI.Length d_rp_vc=d_inner_4in;
parameter Modelica.Units.SI.Length length_rp_vc=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(18);                             //length_dummy;
parameter Modelica.Units.SI.Pressure p_rp_vc=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.5) + p_atm;
parameter Modelica.Units.SI.Temperature T_rp_vc=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(363);

// Vacuum chamber (vc)
parameter Modelica.Units.SI.Power Q_vc=250e3;
//parameter SI.Volume V_vc = TRANSFORM.Units.Conversions.Functions.Volume_m3.from_ft3(5*5*10); // taken from pg.6 of Environmental Chamber Relief Capacity Evaluation
parameter Modelica.Units.SI.PressureDifference dp_vc=p_vc_rp - p_rp_vc;
parameter Modelica.Units.SI.TemperatureDifference dT_vc=T_vc_rp - T_rp_vc;

// Piping: Vacuum Chamber to Recuperator (vc_rp)
parameter Modelica.Units.SI.Length d_vc_rp=d_inner_4in;
parameter Modelica.Units.SI.Length length_vc_rp=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(18);                             //length_dummy;
parameter Modelica.Units.SI.Pressure p_vc_rp=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.4) + p_atm;
parameter Modelica.Units.SI.Temperature T_vc_rp=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(602);
parameter Modelica.Units.SI.Temperature T_TEDS_rp=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(378);

// Recuperator (rp)
//parameter SI.Power Q_flow_rp = m_flow*(Medium.specificEnthalpy_pT(p_vc_rp,T_vc_rp) - Medium.specificEnthalpy_pT(p_rp_hx,T_rp_hx));
parameter Modelica.Units.SI.Power Q_flow_rp=m_flow*(Medium.specificEnthalpy_pT(
      p_rp_vc, T_rp_vc) - Medium.specificEnthalpy_pT(p_co_rp, T_co_rp));
parameter Modelica.Units.SI.PressureDifference dp_rp_hot=p_rp_hx - p_vc_rp;
parameter Modelica.Units.SI.TemperatureDifference dT_rp_hot=T_rp_hx - T_vc_rp;
parameter Modelica.Units.SI.Pressure dp_rp_cold=p_rp_vc - p_co_rp;
parameter Modelica.Units.SI.TemperatureDifference dT_rp_cold=T_rp_vc - T_co_rp;
parameter Modelica.Units.SI.ThermalConductance UA_rp=261.842;
                                                // calculated from MAGNET_TEDS_Boundaries_1
//
parameter Modelica.Units.SI.ThermalConductance UA_rp_MAGNET=48.7654;
                                                       // Calculated from MAGNET_insulated_pipes_SS
//47.874603;// calculated by Scott Greenwood

// Piping: Recuperator to Rejection Heat Exchanger (rp_hx)
parameter Modelica.Units.SI.Length d_rp_hx=d_inner_3in;
parameter Modelica.Units.SI.Length length_rp_hx=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(6 + 3);                           //length_dummy;
parameter Modelica.Units.SI.Pressure p_rp_hx=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(11.1) + p_atm;
parameter Modelica.Units.SI.Temperature T_rp_hx=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(284);

// Rejection Heat Exchanger to Chilled Water (hx)
parameter Modelica.Units.SI.Power Q_flow_hx=m_flow*(Medium.specificEnthalpy_pT(
      p_rp_hx, T_rp_hx) - Medium.specificEnthalpy_pT(p_hx_co, T_hx_co));
//parameter SI.Power Q_flow_hx = m_flow*(Medium.specificEnthalpy_pT(p_hx_cw,T_hx_cw) - Medium.specificEnthalpy_pT(p_cw_hx,T_cw_hx));
parameter Modelica.Units.SI.PressureDifference dp_hx_hot=p_hx_co - p_rp_hx;
parameter Modelica.Units.SI.TemperatureDifference dT_hx_hot=T_hx_co - T_rp_hx;
parameter Modelica.Units.SI.TemperatureDifference dT_hx_cold=50;
                                                    //guess
parameter Modelica.Units.SI.MassFlowRate m_flow_cw=Q_flow_hx/(
      Medium_cw.specificEnthalpy_pT(p_hx_cw, T_hx_cw) -
      Medium_cw.specificEnthalpy_pT(p_cw_hx, T_cw_hx));                                                                                            //guess
parameter Modelica.Units.SI.ThermalConductance UA_hx=380.68774;
                                                  // Calculated from MAGNET_insulated_pipes_SS
parameter Modelica.Units.SI.ThermalConductance UA_hx_MAGNET=698.87;
                                                       // Calculated by SCott Greenwood from PID

// Piping: Chilled Water to Rejection Heat Exchanger (cw_hx)
// parameter SI.Length d_cw_hx = d_inner_4in; //guess
// parameter SI.Length length_cw_hx = length_dummy; //guess
parameter Modelica.Units.SI.Pressure p_cw_hx=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(1) + p_atm;                           //guess
parameter Modelica.Units.SI.Temperature T_cw_hx=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF(65);

// Piping: Rejection Heat Exchanger to Chilled Water (hx_cw)
// parameter SI.Length d_hx_cw = d_inner_4in; //guess
// parameter SI.Length length_hx_cw = length_dummy; //guess
parameter Modelica.Units.SI.Pressure p_hx_cw=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(1) + p_atm;                           //guess
parameter Modelica.Units.SI.Temperature T_hx_cw=T_cw_hx + dT_hx_cold;
                                                         //guess

// Piping: Rejection Heat Exchanger to Compressor (hx_co)
parameter Modelica.Units.SI.Length d_hx_co=d_inner_3in;
parameter Modelica.Units.SI.Length length_hx_co=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(84);                             //length_dummy;
parameter Modelica.Units.SI.Pressure p_hx_co=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(10.8) + p_atm;
parameter Modelica.Units.SI.Temperature T_hx_co=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(20);

// Compressor (co)
parameter Modelica.Units.SI.Power Q_flow_co=m_flow*(Medium.specificEnthalpy_pT(
      p_co_rp, T_co_rp) - Medium.specificEnthalpy_pT(p_hx_co, T_hx_co));
parameter Modelica.Units.SI.PressureDifference dp_co=p_co_rp - p_hx_co;
parameter Modelica.Units.SI.TemperatureDifference dT_co=T_co_rp - T_hx_co;

// Piping: Compressor to Recuperator (co_rp)
parameter Modelica.Units.SI.Length d_co_rp=d_inner_3in;
parameter Modelica.Units.SI.Length length_co_rp=
      TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft(114.625);                             //length_dummy;
parameter Modelica.Units.SI.Pressure p_co_rp=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(12) + p_atm;
parameter Modelica.Units.SI.Temperature T_co_rp=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(37.8);

// Pressurization System (ps)
parameter Modelica.Units.SI.Pressure p_ps=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(22) + p_atm;
parameter Modelica.Units.SI.Temperature T_ps=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(20);                           // this is a guess as not specified. Could be calculated from thermodynamic estimates.

// TEDS
parameter Modelica.Units.SI.Temperature T_hot_side=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(325);
parameter Modelica.Units.SI.Temperature T_cold_side=
      TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(225);

// Gas Turbine
parameter Modelica.Units.SI.Power GT_demand=30e3;
                                     //kW
parameter Real eta_mech = 0.98 "Mechanical efficiency";

// MAGNET_TEDS_HX
parameter Modelica.Units.SI.ThermalConductance UA_MAGNET_TEDS=73.33;
                                                        // Calculated from PID
parameter Modelica.Units.SI.Pressure p_TEDS_out=
      TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_bar(0.18);
parameter Modelica.Units.SI.Pressure p_TEDS_in=p_TEDS_out + 100;
parameter Modelica.Units.SI.Power Q_MAGNET_TEDS=TEDS_nominal_flow_rate*(
      Medium_TEDS.specificEnthalpy_pT(p_TEDS_out, T_hot_side) -
      Medium_TEDS.specificEnthalpy_pT(p_TEDS_in, T_cold_side));
parameter Modelica.Units.SI.MassFlowRate TEDS_nominal_flow_rate=0.689;
parameter Modelica.Units.SI.MassFlowRate m_flow_TEDS=TEDS_nominal_flow_rate;
  annotation (defaultComponentName="data",Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><img src=\"modelica://TRANSFORM_Examples/Resources/Images/magnetSystemBasic.png\"/></p>
</html>"));                                             //0.735; // Modeling the Idaho National Laboratory Thermal-Energy Distribution System (TEDS) in the Modelica Ecosystem
end Data_base_An;
