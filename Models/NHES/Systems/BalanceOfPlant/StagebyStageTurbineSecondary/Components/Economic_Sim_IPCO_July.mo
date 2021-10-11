within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Components;
model Economic_Sim_IPCO_July
  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  parameter Modelica.Units.SI.Time Ramp_Time=300 "Time allowed for demand ramp";
  parameter Modelica.Units.SI.Power Q_nom=52000000;

  parameter Modelica.Units.SI.Time Interval_length = 3600;
  parameter Integer intervals_to_steady_state = 2;
  parameter Integer demand_intervals = 24*5;
  Modelica.Units.SI.Power netDemand_Internal;
  Modelica.Units.SI.Time t_track;
  Modelica.Units.SI.Time t_remain;
  Integer count(start = 1);
  Real Anticipatory_Internal;
  /* Demand intervals need to have nominal power placed in during intervals to steady state, and then add 1 at the end for the final 
  0.5*Ramp_Time length of the useful simulation as the reactor would continue to a new power level.*/
  parameter Modelica.Units.SI.Power Demand_Input[demand_intervals + intervals_to_steady_state+1] = 1e6*{52.0,52.0,
  56.6,57.5,52.8,47.8,43.1,44.4,43.1,42.4,41.7,41.5,43.2,43.6,45.5,48.2,50.4,54.5,58.3,59.9,60.9,61.3,62.3,61.5,60.4,58.6,
  56.6,53.5,50.6,46.6,43.0,41.4,39.9,38.2,37.3,38.8,40.5,41.1,42.7,43.2,49.9,47.4,50.0,52.7,54.8,56.0,54.8,54.7,56.1,56.0,
  52.9,49.2,44.8,41.6,41.2,40.2,38.6,38.3,37.7,39.0,41.3,41.7,41.7,42.9,44.5,46.9,47.8,48.6,49.9,51.3,51.6,51.4,52.2,52.5,
  49.9,47.6,43.9,40.9,38.4,36.7,36.3,37.1,37.4,37.5,38.2,38.3,39.9,42.6,45.1,47.9,50.4,52.6,53.9,55.7,56.8,57.0,56.7,53.4,
  51.3,48.7,45.3,43.2,41.4,39.8,38.9,38.4,37.8,38.2,38.2,38.1,39.3,41.0,43.5,46.7,49.8,52.7,55.4,58.0,60.2,61.1,61.0,59.6,56.6};
  Modelica.Blocks.Sources.RealExpression
                           Anticipatory_Signals(y=Anticipatory_Internal)        annotation (Placement(
        transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={16,0})));
  Modelica.Blocks.Sources.RealExpression
                            Net_Demand(y=netDemand_Internal)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-44,-28})));
initial equation
  Anticipatory_Internal = 0;
  t_track = 0;
equation
  //1
  der(t_track) = 1;
  //2

  //3
  t_remain = Interval_length - t_track;
  when
      (t_track >=Interval_length) then
    //4
    count = pre(count) +1;
    reinit(t_track,0);
  end when;
  //5
  if
    (t_track >= Interval_length - 0.5*Ramp_Time) then
    netDemand_Internal = 0.5*(1+t_remain/(0.5*Ramp_Time))*Demand_Input[count] + 0.5*(1-t_remain/(0.5*Ramp_Time))*Demand_Input[count+1];
    elseif
          (t_track <= 0.5*Ramp_Time and count > 1) then
    netDemand_Internal = 0.5*(1-t_track/(0.5*Ramp_Time))*Demand_Input[count-1] + 0.5*(1+t_track/(0.5*Ramp_Time))*Demand_Input[count];
    else
    netDemand_Internal = Demand_Input[count];
  end if;

  //6
  if
    (netDemand_Internal > Q_nom and t_track > Interval_length-Ramp_Time or t_track < Ramp_Time and netDemand_Internal > Q_nom) then
    der(Anticipatory_Internal) = 1-Anticipatory_Internal;
  else
    der(Anticipatory_Internal) = -Anticipatory_Internal;
  end if;

annotation(defaultComponentName="SC", experiment(StopTime=3600,
        __Dymola_NumberOfIntervals=3600),
    Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Input Setpoints: Modelica Path")}));
end Economic_Sim_IPCO_July;
