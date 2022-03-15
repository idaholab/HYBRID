within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model Energy_Arbitrage_Modal
  extends Modelica.Icons.Example;
   parameter Integer TES_nPipes=950;
  parameter Modelica.Units.SI.Length TES_Length=175 "HTF pipe length";
   parameter Real PipConcLRat = 3;
  parameter Modelica.Units.SI.Length TES_Thick=0.6;
  parameter Modelica.Units.SI.Length TES_Width=0.8;
   parameter Real  LP_NTU=1.5 "Low pressure NTUHX NTU value";
   parameter Real IP_NTU=20 "Intermediate pressure NTUHX NTU value";
   parameter Real HP_NTU=4 "High pressure NTUHX NTU value";
  parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;

  parameter Modelica.Units.SI.Power Q_nom=52000000 "Nominal electrical power";
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
   parameter Integer nPrices = 24*8 "Number of price intervals";
   parameter Real Interval=3600 "Length in seconds of a price interval";
   parameter Real[nPrices] PriceList = {17.02,16.04,15.3,14.7,13.68,14.41,15.69,15.27,14.48,17.75,19.04,23.11,
27.52,42.28,48.49,70.03,80.62,53.17,40.12,36.83,27.73,22.93,21.63,20.74,2.05E+01,2.01E+01,1.98E+01,1.96E+01,2.05E+01,2.15E+01,2.69E+01,
2.86E+01,2.59E+01,2.77E+01,3.12E+01,3.50E+01,4.98E+01,6.31E+01,7.17E+01,9.55E+01,9.11E+01,4.51E+01,4.39E+01,3.39E+01,2.63E+01,2.38E+01,2.18E+01,2.08E+01,
1.84E+01,1.73E+01,1.64E+01,1.62E+01,1.66E+01,1.82E+01,2.41E+01,2.46E+01,2.39E+01,2.41E+01,2.05E+01,2.39E+01,2.25E+01,2.48E+01,2.66E+01,3.78E+01,3.94E+01,3.64E+01,3.16E+01,3.06E+01,2.37E+01,
2.32E+01,2.20E+01,1.89E+01,1.94E+01,1.85E+01,1.81E+01,1.76E+01,1.81E+01,2.10E+01,2.43E+01,2.46E+01,2.37E+01,2.46E+01,2.53E+01,2.66E+01,2.72E+01,3.47E+01,3.37E+01,4.61E+01,4.80E+01,3.82E+01,
3.21E+01,3.09E+01,2.61E+01,2.37E+01,2.22E+01,2.00E+01,1.96E+01,1.83E+01,1.71E+01,1.70E+01,1.75E+01,1.94E+01,2.29E+01,2.41E+01,2.59E+01,2.63E+01,2.77E+01,2.97E+01,3.52E+01,
4.56E+01,5.15E+01,5.69E+01,6.13E+01,5.54E+01,5.09E+01,4.13E+01,3.03E+01,2.70E+01,2.42E+01,2.31E+01,2.14E+01,2.04E+01,1.88E+01,1.87E+01,1.99E+01,2.18E+01,3.24E+01,
2.44E+01,2.19E+01,2.38E+01,2.33E+01,2.61E+01,2.74E+01,2.86E+01,2.87E+01,3.03E+01,3.41E+01,3.40E+01,3.80E+01,4.61E+01,3.19E+01,2.83E+01,2.61E+01,2.43E+01,2.87E+01,
2.41E+01,2.14E+01,2.07E+01,2.08E+01,2.39E+01,2.95E+01,2.85E+01,3.15E+01,3.10E+01,3.12E+01,2.93E+01,2.90E+01,2.46E+01,2.37E+01,2.35E+01,2.52E+01,2.53E+01,
2.60E+01,2.56E+01,2.42E+01,2.45E+01,2.37E+01,2.23E+01,2.03E+01,1.71E+01,1.60E+01,1.59E+01,1.59E+01,1.63E+01,1.67E+01,1.57E+01,1.76E+01,
1.83E+01,1.94E+01,2.05E+01,2.17E+01,2.58E+01,2.85E+01,3.37E+01,3.24E+01,2.71E+01,2.71E+01,2.76E+01,2.29E+01,2.17E+01,1.98E+01,1.86E+01} "cents/kWh for pricing profile, likely will be replaced later with a data block";
  Modelica.Units.SI.Time Int_Track(start=0);
   Integer value(start = 1);
 //  Real Price(start = 17.02);
   Real MoneyMade(unit = "1");
   Real MoneyNominal;
   Real Price;
  Modelica.Units.SI.Temperature T_Feed_Ref=273.15 + 140;

  PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump             Reactor(
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy_RXPower CS,
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-114,-40},{-14,64}})));
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
    Q_nom=Q_nom)
    annotation (Placement(transformation(extent={{20,-36},{100,54}})));
  Components.Economic_Sim_Profile Econ_Sim
    annotation (Placement(transformation(extent={{-16,64},{20,100}})));
initial equation
  MoneyMade = 0;
  MoneyNominal = 0;
equation
  SecSide.dEdCycle = dEdCycle;
  TES_E_Dep =SecSide.TES.E_store_daily;
  Elec_Power =SecSide.generator.power;
  Feed_Temp =SecSide.HP.Tex_t;
  T_Ave_Conc = SecSide.TES.T_Ave_Conc;
  Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
  Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
  Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
  m_dis =SecSide.DFV.m_flow;
  p_dis =SecSide.DFV.port_b.p;
  SecSide.Q_RX_Internal = Reactor.Q_total.y;
  der(Int_Track) = 1/Interval;
  when
      (Int_Track>=1.0) then
    value = pre(value) + 1;
    reinit(Int_Track,0);
 //   reinit(Price,PriceList[value]);
  end when;
  //Prices are in cents/kWh, so: we divide Price/100 = Dollars/kWh, and we divide power by 1000 to make it kW, and divide by 3600 to cancel
  //out and make it per hour.
  der(MoneyMade) = (1/100)*(1/3600)*PriceList[value]*Elec_Power/1000;
  Price = PriceList[value];
  der(MoneyNominal) = (1/100)*(1/3600)*PriceList[value]*Q_nom/1000;
  Econ_Sim.Net_Demand.y = SecSide.Demand_Internal;

  Econ_Sim.Anticipatory_Signals.y = SecSide.DFV_Anticipatory_Internal;

  connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{20.8,-13.5},
          {20.8,2},{-4,2},{-4,5.6},{-12.1818,5.6}},          color={0,127,255}));
  connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{20,31.5},{
          -4,31.5},{-4,32},{-12.1818,32}},       color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,
            100}})),
    experiment(
      StopTime=30,
      __Dymola_NumberOfIntervals=193,
      Tolerance=0.01,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"),
    Documentation(info="<html>
<p>The goal of this example is to show how a power-controlled system might do some energy arbitrage based on some economic modeling. The economics portion of this model are not included here, but do know that the demand profile set in the Economic_Sim model and linked up with the secondary side model is based on an economic optimization. The pricing data included in this model shows the pricing source data. </p>
<p>Note that for default settings, 30 second simulation and 193 intervals, this model requires about 25 minutes. The simulation speed should increase after the system gets to an initial operating state. </p>
</html>"));
end Energy_Arbitrage_Modal;
