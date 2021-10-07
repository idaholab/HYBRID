within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Examples;
model SMR_Nominal
  extends Modelica.Icons.Example;
  parameter Real LP_NTU = 1.5;
  parameter Real IP_NTU = 20.0;
  parameter Real HP_NTU = 4.0;
  parameter Modelica.Units.SI.Power Q_nom=53510600;
  Modelica.Units.SI.Energy dEdCycle;
  Modelica.Units.SI.Power Elec_Power;
  Modelica.Units.SI.Temperature Feed_Temp;

  PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump             Reactor(
    redeclare
      NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy_RXPower
      CS,
    port_a_nominal(
      m_flow=70,
      p=3447380,
      T(displayUnit="degC") = 421.15),
    port_b_nominal(
      p=3447380,
      T(displayUnit="degC") = 579.25,
      h=2997670))
    annotation (Placement(transformation(extent={{-104,-42},{-10,68}})));
  NuScale_Secondary SecSide(
    LP_NTU=LP_NTU,
    IP_NTU=IP_NTU,
    HP_NTU=HP_NTU,
    Q_nom=Q_nom,
    redeclare CS_Mass CS)
    annotation (Placement(transformation(extent={{14,-32},{98,52}})));
equation
  SecSide.dEdCycle = dEdCycle;
  Elec_Power =SecSide.generator.power;
  Feed_Temp =SecSide.HP.Tex_t;
  SecSide.Q_RX_Internal = Reactor.Q_total.y;
  SecSide.Demand_Internal = Q_nom;

  connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{13.16,
          -12.68},{0,-12.68},{0,6.23077},{-8.29091,6.23077}},
                                                      color={0,127,255}));
  connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{13.16,30.16},
          {0,30.16},{0,34.1538},{-8.29091,34.1538}},
                                                   color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,100}})),
    experiment(
      StopTime=4000,
      __Dymola_NumberOfIntervals=783,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
    __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"),
    Documentation(info="<html>
<p>This example shows the steady state for the SMR_Generic system 160MWt, ~52MWe system. The system is &quot;mass&quot; controlled. Instead of trying to meet any power demands of the system, the system operates based on opening &amp; closing control valves. </p>
<p>The control system for this example is &quot;CS_Mass&quot; and it currently does not cycle the system whatsoever. This example should be a good starting point for any attempts to add any integration technologies into the NuScale secondary side model. </p>
<p>Changes to the secondary side parameters (turbine design, most pressure values, volumes, etc.) should be done within the lower model rather than the upper. Not all parameters are currently passed to the upper level. </p>
<p>To make any restart files using the full secondary models, note that there is a variable &quot;t_track&quot; that uses reinit() periodically. Therefore, if you want to reset a restart file to t=0, make sure not only to set the t_start = 0 at the beginning of the file, but ctrl + f &quot;t_track&quot; and set ALL instances of it to 0 as well. Models with periodically resetting values use this. Economic components may also have a similar value. Another potentially existing variable is &quot;t_sim_init&quot; which is actually a very useful variable. Its use is designed such that t_sim_init = 0 when your actual simulation period begins (so if you have 1800 seconds of initialization to reach steady state, then you should find the reinit() condition for t_sim_init and set it such that it occurs at t=1800 only). Then, later, you can change the x-variable on your plots to this t_sim_init variable and set the x-range to [0,:] and you&apos;ll have time-plots set properly without having to use the import() functionality. </p>
<p>In later versions, some additional parameterization at this level may come available from the lower models. </p>
<p>- Models by Daniel Mikkelson, daniel.mikkelson@inl.gov </p>
</html>"));
end SMR_Nominal;
