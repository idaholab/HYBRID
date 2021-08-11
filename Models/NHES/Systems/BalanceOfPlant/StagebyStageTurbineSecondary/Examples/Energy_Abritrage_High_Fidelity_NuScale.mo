within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model Energy_Abritrage_High_Fidelity_NuScale
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
    Q_total_th=160e6,
    Q_total_el=52e6,
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
    annotation (Placement(transformation(extent={{-210,-104},{-40,72}})));
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
    annotation (Placement(transformation(extent={{6,-76},{124,42}})));

  Components.Economic_Sim_IPCO_July
                            ES
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

  connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{7.18,-46.5},
          {-26,-46.5},{-26,-32.3429},{-37.3846,-32.3429}},   color={0,127,255}));
  connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{6,12.5},{-8,
          12.5},{-8,10},{-22,10},{-22,9.14286},{-37.3846,9.14286}},
                                                 color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=10800,
      __Dymola_NumberOfIntervals=1080,
      Tolerance=0.0005,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"));
end Energy_Abritrage_High_Fidelity_NuScale;
