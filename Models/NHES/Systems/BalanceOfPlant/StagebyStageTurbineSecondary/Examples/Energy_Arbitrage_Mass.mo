within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model Energy_Arbitrage_Mass
  extends Modelica.Icons.Example;
   parameter Integer TES_nPipes=750;
  parameter Modelica.Units.SI.Length TES_Length=150;
  parameter Real PipConcLRat = 3;
  parameter Modelica.Units.SI.Length TES_Thick=0.3;
  parameter Modelica.Units.SI.Length TES_Width=0.8;
   parameter Real  LP_NTU=1.5;
   parameter Real IP_NTU=20;
   parameter Real HP_NTU=4;
  parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;
  parameter Modelica.Units.SI.Time Ramp_Stor=500;
  parameter Modelica.Units.SI.Time Ramp_Dis=500;
  parameter Modelica.Units.SI.Power Q_nom=53510600;
  Modelica.Units.SI.Energy dEdCycle;
  Modelica.Units.SI.Energy TES_E_Dep;
  Modelica.Units.SI.Power Elec_Power;
  Modelica.Units.SI.Temperature Feed_Temp;
  Modelica.Units.SI.Temperature Conc_Hot_Temp;
  Modelica.Units.SI.Temperature Conc_Mid_Temp;
  Modelica.Units.SI.Temperature Conc_Cold_Temp;
  Modelica.Units.SI.MassFlowRate m_dis;
  Modelica.Units.SI.Pressure p_dis;

protected
  PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump             Reactor(
    redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy CS,
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-104,-42},{-10,68}})));
  Mass_Controlled_System_CS_ED_Enabled                      SecSide(
    TES_nPipes=TES_nPipes,
    TES_Length=TES_Length,
    PipConcLRat=PipConcLRat,
    TES_Thick=TES_Thick,
    TES_Width=TES_Width,
    LP_NTU=LP_NTU,
    IP_NTU=IP_NTU,
    HP_NTU=HP_NTU,
    P_Rise_DFV=P_Rise_DFV,
    Ramp_Stor=Ramp_Stor,
    Ramp_Dis=Ramp_Dis,
    Q_nom=Q_nom, redeclare CS_Nominal_New CS)
    annotation (Placement(transformation(extent={{14,-32},{98,52}})));
equation
  SecSide.dEdCycle = dEdCycle;
  TES_E_Dep =SecSide.TES.E_store_daily;
  Elec_Power =SecSide.generator.power;
  Feed_Temp =SecSide.HP.Tex_t;
  Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
  Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
  Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
  m_dis =SecSide.DFV.m_flow;
  p_dis =SecSide.DFV.port_b.p;

  connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{14,-11},{0,
          -11},{0,6.23077},{-8.29091,6.23077}},       color={0,127,255}));
  connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{14,31},{0,
          31},{0,34.1538},{-8.29091,34.1538}},     color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=40,
      __Dymola_NumberOfIntervals=783,
      Tolerance=0.0005,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"),
    Documentation(info="<html>
<p>This example shows a daily energy arbitrage cycle for a SMR_Generic 160MWt, ~52MWe system. The system is &quot;mass&quot; controlled. Instead of trying to meet any power demands of the system, the system operates based on opening &amp; closing control valves. Cycle is set by trapezoidal parameters set up within the &quot;CS_Nominal_New&quot; component. </p>
</html>"));
end Energy_Arbitrage_Mass;
