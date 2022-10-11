within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model Energy_Abritrage_High_Fidelity_SMR_workshop
  extends Modelica.Icons.Example;
   parameter Integer TES_nPipes=800;
  parameter Modelica.Units.SI.Length TES_Length=150;
  parameter Modelica.Units.SI.Length TES_Thick=0.6;
  parameter Modelica.Units.SI.Length TES_Width=0.8;
   parameter Real  LP_NTU=1.5;
   parameter Real IP_NTU=20;
   parameter Real HP_NTU=4;
  parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;
  parameter Modelica.Units.SI.Time Ramp_Stor=600;
  parameter Modelica.Units.SI.Time Ramp_Dis=600;
  parameter Modelica.Units.SI.Power Q_nom=52000000;
  Modelica.Units.SI.Energy dEdCycle;
  Modelica.Units.SI.Energy TES_E_Dep;
  Modelica.Units.SI.Power Elec_Power;
  Modelica.Units.SI.Temperature Feed_Temp;
  Modelica.Units.SI.Temperature Conc_Hot_Temp;
  Modelica.Units.SI.Temperature Conc_Mid_Temp;
  Modelica.Units.SI.Temperature Conc_Cold_Temp;
  Modelica.Units.SI.Temperature T_Ave_Conc;
  Modelica.Units.SI.MassFlowRate m_dis;
  Modelica.Units.SI.Pressure p_dis;
   parameter Integer nPrices = 24*8;
   parameter Real Interval=3600;

  Modelica.Units.SI.Temperature T_Feed_Ref=273.15 + 140;
  Modelica.Units.SI.Time t_sim_post_init(start = -7200);

  PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump            Reactor(
    redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
      SG_exit_enthalpy=3000e3,
      m_setpoint=675,
      Q_nom=1,
      demand=1),
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-204,-86},{-34,90}})));
  NuScale_SBST_Secondary_With_CTES SecSide(
    redeclare NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.CS_Modal
      CS,
    TES_nPipes=TES_nPipes,
    TES_Length=TES_Length,
    TES_Thick=TES_Thick,
    TES_Width=TES_Width,
    LP_NTU=LP_NTU,
    IP_NTU=IP_NTU,
    HP_NTU=HP_NTU,
    P_Rise_DFV=P_Rise_DFV,
    Ramp_Stor=Ramp_Stor,
    Ramp_Dis=Ramp_Dis,
    Q_nom=Q_nom)
    annotation (Placement(transformation(extent={{6,-66},{124,52}})));

  Components.Economic_Sim_IPCO_July
                            ES(
    Interval_length=1200,
    intervals_to_steady_state=2,
    demand_intervals=24*5,
    Demand_Input=1e6*{52.0,52.0,52.0,52.0,52.0,52.0,56.6,57.5,52.8,47.8,43.1,
        44.4,43.1,42.4,41.7,41.5,43.2,43.6,45.5,48.2,50.4,54.5,58.3,59.9,60.9,
        61.3,62.3,61.5,60.4,58.6,56.6,53.5,50.6,46.6,43.0,41.4,39.9,38.2,37.3,
        38.8,40.5,41.1,42.7,43.2,49.9,47.4,50.0,52.7,54.8,56.0,54.8,54.7,56.1,
        56.0,52.9,49.2,44.8,41.6,41.2,40.2,38.6,38.3,37.7,39.0,41.3,41.7,41.7,
        42.9,44.5,46.9,47.8,48.6,49.9,51.3,51.6,51.4,52.2,52.5,49.9,47.6,43.9,
        40.9,38.4,36.7,36.3,37.1,37.4,37.5,38.2,38.3,39.9,42.6,45.1,47.9,50.4,
        52.6,53.9,55.7,56.8,57.0,56.7,53.4,51.3,48.7,45.3,43.2,41.4,39.8,38.9,
        38.4,37.8,38.2,38.2,38.1,39.3,41.0,43.5,46.7,49.8,52.7,55.4,58.0,60.2})
    annotation (Placement(transformation(extent={{-38,74},{-18,94}})));
initial equation
  t_sim_post_init = -7200;
equation
  der(t_sim_post_init) = 1;
  SecSide.dEdCycle = dEdCycle;
  TES_E_Dep =SecSide.TES.E_store_daily;
  Elec_Power =SecSide.generator.power;
  Feed_Temp =SecSide.HP.Tex_t;
  T_Ave_Conc = SecSide.TES.T_Ave_Conc;
  Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
  Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
  Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
  m_dis =SecSide.DCV.m_flow;
  p_dis =SecSide.DCV.port_b.p;

  //Prices are in cents/kWh, so: we divide Price/100 = Dollars/kWh, and we divide power by 1000 to make it kW, and divide by 3600 to cancel
  //out and make it per hour.
  //SecSide.Q_Rx_Total = Reactor.Q_total.y;
  Reactor.Q_total.y = SecSide.Q_RX_Internal;
  SecSide.DFV_Anticipatory_Internal = ES.Anticipatory_Signals.y;
  SecSide.Demand_Internal = ES.Net_Demand.y;

  connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{7.18,-36.5},
          {-20,-36.5},{-20,-14.3429},{-31.3846,-14.3429}},   color={0,127,255}));
  connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{6,22.5},{-8,
          22.5},{-8,10},{-22,10},{-22,27.1429},{-31.3846,27.1429}},
                                                 color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=199,
      Tolerance=0.0005,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"));
end Energy_Abritrage_High_Fidelity_SMR_workshop;
