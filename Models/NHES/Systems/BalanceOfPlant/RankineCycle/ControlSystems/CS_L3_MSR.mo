within NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems;
model CS_L3_MSR

  extends PrimaryHeatSystem.MSR.TurbineMSR2.BaseClasses.Partial_ControlSystem;

  replaceable PrimaryHeatSystem.MSR.TurbineMSR2.Data.Data_L3 data(
    Tin=813.15,
    Tfeed=473.15,
    d_HPT_in(displayUnit="kg/m3") = 34.69607167,
    d_LPT1_in(displayUnit="kg/m3") = 8.189928251,
    d_LPT2_in(displayUnit="kg/m3") = 0.862546399,
    mdot_total=288.5733428,
    mdot_fh=1.128623343,
    mdot_hpt=287.4447195,
    mdot_lpt1=287.4447195,
    mdot_lpt2=268.7244172)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression P_in_set(y=1)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-3,
    Ti=30,
    yMax=2*data.mdot_hpt,
    yMin=data.mdot_hpt*0.1)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,74},{60,94}})));
  Modelica.Blocks.Sources.RealExpression T_in_set1(y=200)
    annotation (Placement(transformation(extent={{8,64},{28,84}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=data.HPT_p_in, uHigh=data.p_dump)
    annotation (Placement(transformation(extent={{-48,-146},{-28,-166}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-8,-166},{12,-146}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open0(y=0)
    annotation (Placement(transformation(extent={{-48,-190},{-28,-170}})));
  Modelica.Blocks.Sources.RealExpression P_dump_open1(y=1)
    annotation (Placement(transformation(extent={{-48,-152},{-28,-132}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-1,
    duration=4000,
    offset=0,
    startTime=8000)
    annotation (Placement(transformation(extent={{-94,-216},{-74,-196}})));
  Modelica.Blocks.Math.Product
                           product1
    annotation (Placement(transformation(extent={{68,-178},{88,-158}})));
  replaceable Modelica.Blocks.Sources.RealExpression Steam_Extraction
    annotation (choices(
      choice(redeclare Modelica.Blocks.Sources.Ramp Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Step Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Sine Steam_Extraction),
      choice(redeclare Modelica.Blocks.Sources.Trapezoid Steam_Extraction)), Placement(
        transformation(extent={{-132,-48},{-112,-28}})));
  TRANSFORM.Controls.LimPID LPT1_BV_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-3,
    Ti=300,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-64,-46},{-44,-26}})));
equation

  connect(T_feed_set.y, LPT2_BV_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(actuatorBus.LPT2_BV, LPT2_BV_PID.y) annotation (Line(
      points={{30,-100},{30,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, LPT2_BV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,30},{0,30},{0,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, FeedPump_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(actuatorBus.opening_TCV, P_in_set.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-74},{-74,-74},{-74,10},{-79,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FeedPump_PID.y, add.u1)
    annotation (Line(points={{11,90},{38,90}}, color={0,0,127}));
  connect(add.u2, T_in_set1.y) annotation (Line(points={{38,78},{34,78},{34,74},
          {29,74}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, FeedPump_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,68},{0,68},{0,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
      points={{30,-100},{30,70},{61,70},{61,84}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(hysteresis.y,switch1. u2)
    annotation (Line(points={{-27,-156},{-10,-156}},
                                                  color={255,0,255}));
  connect(sensorBus.Steam_Pressure,hysteresis. u) annotation (Line(
      points={{-30,-100},{-30,-128},{-60,-128},{-60,-156},{-50,-156}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_dump_open0.y,switch1. u3) annotation (Line(points={{-27,-180},{-18,
          -180},{-18,-164},{-10,-164}},
                                      color={0,0,127}));
  connect(switch1.u1,P_dump_open1. y) annotation (Line(points={{-10,-148},{-22,
          -148},{-22,-142},{-27,-142}},
                                    color={0,0,127}));
  connect(ramp.y,product1. u2) annotation (Line(points={{-73,-206},{58,-206},{
          58,-174},{66,-174}}, color={0,0,127}));
  connect(actuatorBus.TBV,product1. y) annotation (Line(
      points={{30,-100},{30,-152},{89,-152},{89,-168}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y,product1. u1) annotation (Line(points={{13,-156},{56,-156},
          {56,-162},{66,-162}}, color={0,0,127}));
  connect(Steam_Extraction.y, LPT1_BV_PID.u_s) annotation (Line(points={{-111,
          -38},{-76,-38},{-76,-36},{-66,-36}}, color={0,0,127}));
  connect(actuatorBus.LPT1_BV, LPT1_BV_PID.y) annotation (Line(
      points={{30,-100},{30,-56},{20,-56},{20,-40},{-38,-40},{-38,-36},{-43,-36}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(sensorBus.Extract_flow, LPT1_BV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-58},{-54,-58},{-54,-48}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>This control system is for a molten salt reactor (MSR) and is specfically used in the NHES.Systems.PrimaryHeatSystem.MSR.Examples.PFL_PCL_BOP_ControlSystemsForAll model.</p>
</html>"));
end CS_L3_MSR;
