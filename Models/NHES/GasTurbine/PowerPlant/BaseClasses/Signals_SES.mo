within NHES.GasTurbine.PowerPlant.BaseClasses;
expandable connector Signals_SES "Data bus for SES signals"
  extends GasTurbine.Interfaces.SignalSubBus;

  SI.Power s_W_load(displayUnit="MW") "Electrical load to the GT plant" annotation ();
  SI.Power s_W_gen(displayUnit="MW") "Generated electricity from the GT plant" annotation ();
  SI.MassFlowRate s_wf "Fuel (natural gas) consumption in the GT plant" annotation ();
  SI.MassFlowRate s_wCO2 "CO2 emission rate from the GT plant" annotation ();

  Real c_wf_pu(unit="1") "Controller output: Fuel flow signal to regulate the power generation from the GTPP";

end Signals_SES;
